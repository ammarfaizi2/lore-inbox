Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVBKHf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVBKHf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVBKHf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:35:59 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:58206 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262213AbVBKHFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 9/10] Gameport: complete sysfs integration
Date: Fri, 11 Feb 2005 02:04:39 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110203.15425.dtor_core@ameritech.net> <200502110204.00573.dtor_core@ameritech.net>
In-Reply-To: <200502110204.00573.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110204.40128.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2157, 2005-02-11 01:21:32-05:00, dtor_core@ameritech.net
  Input: complete gameport sysfs integration, ports are now
         devices in driver model. Implemented similarly to serio.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/gameport.c |  586 ++++++++++++++++++++++++++++++++++----
 include/linux/gameport.h          |   64 ++--
 2 files changed, 579 insertions(+), 71 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-02-11 01:40:19 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-02-11 01:40:19 -05:00
@@ -2,6 +2,7 @@
  * Generic gameport layer
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Copyright (c) 2005 Dmitry Torokhov
  */
 
 /*
@@ -10,22 +11,27 @@
  * the Free Software Foundation.
  */
 
-#include <asm/io.h>
+#include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/gameport.h>
+#include <linux/wait.h>
+#include <linux/completion.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
 #include <linux/slab.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 
+/*#include <asm/io.h>*/
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Generic gameport layer");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(gameport_register_port);
+EXPORT_SYMBOL(__gameport_register_port);
 EXPORT_SYMBOL(gameport_unregister_port);
-EXPORT_SYMBOL(gameport_register_driver);
+EXPORT_SYMBOL(__gameport_register_driver);
 EXPORT_SYMBOL(gameport_unregister_driver);
 EXPORT_SYMBOL(gameport_open);
 EXPORT_SYMBOL(gameport_close);
@@ -34,13 +40,23 @@
 EXPORT_SYMBOL(gameport_set_name);
 EXPORT_SYMBOL(gameport_set_phys);
 
+/*
+ * gameport_sem protects entire gameport subsystem and is taken
+ * every time gameport port or driver registrered or unregistered.
+ */
+static DECLARE_MUTEX(gameport_sem);
+
 static LIST_HEAD(gameport_list);
-static LIST_HEAD(gameport_driver_list);
 
 static struct bus_type gameport_bus = {
 	.name =	"gameport",
 };
 
+static void gameport_add_port(struct gameport *gameport);
+static void gameport_destroy_port(struct gameport *gameport);
+static void gameport_reconnect_port(struct gameport *gameport);
+static void gameport_disconnect_port(struct gameport *gameport);
+
 #ifdef __i386__
 
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
@@ -106,21 +122,325 @@
 #endif
 }
 
+
+/*
+ * Basic gameport -> driver core mappings
+ */
+
+static void gameport_bind_driver(struct gameport *gameport, struct gameport_driver *drv)
+{
+	down_write(&gameport_bus.subsys.rwsem);
+
+	gameport->dev.driver = &drv->driver;
+	if (drv->connect(gameport, drv)) {
+		gameport->dev.driver = NULL;
+		goto out;
+	}
+	device_bind_driver(&gameport->dev);
+out:
+	up_write(&gameport_bus.subsys.rwsem);
+}
+
+static void gameport_release_driver(struct gameport *gameport)
+{
+	down_write(&gameport_bus.subsys.rwsem);
+	device_release_driver(&gameport->dev);
+	up_write(&gameport_bus.subsys.rwsem);
+}
+
 static void gameport_find_driver(struct gameport *gameport)
 {
-        struct gameport_driver *drv;
+	down_write(&gameport_bus.subsys.rwsem);
+	device_attach(&gameport->dev);
+	up_write(&gameport_bus.subsys.rwsem);
+}
+
+
+/*
+ * Gameport event processing.
+ */
+
+enum gameport_event_type {
+	GAMEPORT_RESCAN,
+	GAMEPORT_RECONNECT,
+	GAMEPORT_REGISTER_PORT,
+	GAMEPORT_REGISTER_DRIVER,
+};
+
+struct gameport_event {
+	enum gameport_event_type type;
+	void *object;
+	struct module *owner;
+	struct list_head node;
+};
+
+static DEFINE_SPINLOCK(gameport_event_lock);	/* protects gameport_event_list */
+static LIST_HEAD(gameport_event_list);
+static DECLARE_WAIT_QUEUE_HEAD(gameport_wait);
+static DECLARE_COMPLETION(gameport_exited);
+static int gameport_pid;
+
+static void gameport_queue_event(void *object, struct module *owner,
+			      enum gameport_event_type event_type)
+{
+	unsigned long flags;
+	struct gameport_event *event;
+
+	spin_lock_irqsave(&gameport_event_lock, flags);
 
-        list_for_each_entry(drv, &gameport_driver_list, node) {
-		if (gameport->drv)
+	/*
+ 	 * Scan event list for the other events for the same gameport port,
+	 * starting with the most recent one. If event is the same we
+	 * do not need add new one. If event is of different type we
+	 * need to add this event and should not look further because
+	 * we need to preseve sequence of distinct events.
+ 	 */
+	list_for_each_entry_reverse(event, &gameport_event_list, node) {
+		if (event->object == object) {
+			if (event->type == event_type)
+				goto out;
 			break;
-               	drv->connect(gameport, drv);
-        }
+		}
+	}
+
+	if ((event = kmalloc(sizeof(struct gameport_event), GFP_ATOMIC))) {
+		if (!try_module_get(owner)) {
+			printk(KERN_WARNING "gameport: Can't get module reference, dropping event %d\n", event_type);
+			goto out;
+		}
+
+		event->type = event_type;
+		event->object = object;
+		event->owner = owner;
+
+		list_add_tail(&event->node, &gameport_event_list);
+		wake_up(&gameport_wait);
+	} else {
+		printk(KERN_ERR "gameport: Not enough memory to queue event %d\n", event_type);
+	}
+out:
+	spin_unlock_irqrestore(&gameport_event_lock, flags);
 }
 
-void gameport_rescan(struct gameport *gameport)
+static void gameport_free_event(struct gameport_event *event)
 {
-	gameport_close(gameport);
-	gameport_find_driver(gameport);
+	module_put(event->owner);
+	kfree(event);
+}
+
+static void gameport_remove_duplicate_events(struct gameport_event *event)
+{
+	struct list_head *node, *next;
+	struct gameport_event *e;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gameport_event_lock, flags);
+
+	list_for_each_safe(node, next, &gameport_event_list) {
+		e = list_entry(node, struct gameport_event, node);
+		if (event->object == e->object) {
+			/*
+			 * If this event is of different type we should not
+			 * look further - we only suppress duplicate events
+			 * that were sent back-to-back.
+			 */
+			if (event->type != e->type)
+				break;
+
+			list_del_init(node);
+			gameport_free_event(e);
+		}
+	}
+
+	spin_unlock_irqrestore(&gameport_event_lock, flags);
+}
+
+
+static struct gameport_event *gameport_get_event(void)
+{
+	struct gameport_event *event;
+	struct list_head *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gameport_event_lock, flags);
+
+	if (list_empty(&gameport_event_list)) {
+		spin_unlock_irqrestore(&gameport_event_lock, flags);
+		return NULL;
+	}
+
+	node = gameport_event_list.next;
+	event = list_entry(node, struct gameport_event, node);
+	list_del_init(node);
+
+	spin_unlock_irqrestore(&gameport_event_lock, flags);
+
+	return event;
+}
+
+static void gameport_handle_events(void)
+{
+	struct gameport_event *event;
+	struct gameport_driver *gameport_drv;
+
+	down(&gameport_sem);
+
+	while ((event = gameport_get_event())) {
+
+		switch (event->type) {
+			case GAMEPORT_REGISTER_PORT:
+				gameport_add_port(event->object);
+				break;
+
+			case GAMEPORT_RECONNECT:
+				gameport_reconnect_port(event->object);
+				break;
+
+			case GAMEPORT_RESCAN:
+				gameport_disconnect_port(event->object);
+				gameport_find_driver(event->object);
+				break;
+
+			case GAMEPORT_REGISTER_DRIVER:
+				gameport_drv = event->object;
+				driver_register(&gameport_drv->driver);
+				break;
+
+			default:
+				break;
+		}
+
+		gameport_remove_duplicate_events(event);
+		gameport_free_event(event);
+	}
+
+	up(&gameport_sem);
+}
+
+/*
+ * Remove all events that have been submitted for a given gameport port.
+ */
+static void gameport_remove_pending_events(struct gameport *gameport)
+{
+	struct list_head *node, *next;
+	struct gameport_event *event;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gameport_event_lock, flags);
+
+	list_for_each_safe(node, next, &gameport_event_list) {
+		event = list_entry(node, struct gameport_event, node);
+		if (event->object == gameport) {
+			list_del_init(node);
+			gameport_free_event(event);
+		}
+	}
+
+	spin_unlock_irqrestore(&gameport_event_lock, flags);
+}
+
+/*
+ * Destroy child gameport port (if any) that has not been fully registered yet.
+ *
+ * Note that we rely on the fact that port can have only one child and therefore
+ * only one child registration request can be pending. Additionally, children
+ * are registered by driver's connect() handler so there can't be a grandchild
+ * pending registration together with a child.
+ */
+static struct gameport *gameport_get_pending_child(struct gameport *parent)
+{
+	struct gameport_event *event;
+	struct gameport *gameport, *child = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gameport_event_lock, flags);
+
+	list_for_each_entry(event, &gameport_event_list, node) {
+		if (event->type == GAMEPORT_REGISTER_PORT) {
+			gameport = event->object;
+			if (gameport->parent == parent) {
+				child = gameport;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&gameport_event_lock, flags);
+	return child;
+}
+
+static int gameport_thread(void *nothing)
+{
+	lock_kernel();
+	daemonize("kgameportd");
+	allow_signal(SIGTERM);
+
+	do {
+		gameport_handle_events();
+		wait_event_interruptible(gameport_wait, !list_empty(&gameport_event_list));
+		try_to_freeze(PF_FREEZE);
+	} while (!signal_pending(current));
+
+	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
+
+	unlock_kernel();
+	complete_and_exit(&gameport_exited, 0);
+}
+
+
+/*
+ * Gameport port operations
+ */
+
+static ssize_t gameport_show_description(struct device *dev, char *buf)
+{
+	struct gameport *gameport = to_gameport_port(dev);
+	return sprintf(buf, "%s\n", gameport->name);
+}
+
+static ssize_t gameport_rebind_driver(struct device *dev, const char *buf, size_t count)
+{
+	struct gameport *gameport = to_gameport_port(dev);
+	struct device_driver *drv;
+	int retval;
+
+	retval = down_interruptible(&gameport_sem);
+	if (retval)
+		return retval;
+
+	retval = count;
+	if (!strncmp(buf, "none", count)) {
+		gameport_disconnect_port(gameport);
+	} else if (!strncmp(buf, "reconnect", count)) {
+		gameport_reconnect_port(gameport);
+	} else if (!strncmp(buf, "rescan", count)) {
+		gameport_disconnect_port(gameport);
+		gameport_find_driver(gameport);
+	} else if ((drv = driver_find(buf, &gameport_bus)) != NULL) {
+		gameport_disconnect_port(gameport);
+		gameport_bind_driver(gameport, to_gameport_driver(drv));
+		put_driver(drv);
+	} else {
+		retval = -EINVAL;
+	}
+
+	up(&gameport_sem);
+
+	return retval;
+}
+
+static struct device_attribute gameport_device_attrs[] = {
+	__ATTR(description, S_IRUGO, gameport_show_description, NULL),
+	__ATTR(drvctl, S_IWUSR, NULL, gameport_rebind_driver),
+	__ATTR_NULL
+};
+
+static void gameport_release_port(struct device *dev)
+{
+	struct gameport *gameport = to_gameport_port(dev);
+
+	kfree(gameport);
+	module_put(THIS_MODULE);
 }
 
 void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
@@ -128,29 +448,162 @@
 	va_list args;
 
 	va_start(args, fmt);
-	gameport->phys = gameport->phys_buf;
-	vsnprintf(gameport->phys_buf, sizeof(gameport->phys_buf), fmt, args);
+	vsnprintf(gameport->phys, sizeof(gameport->phys), fmt, args);
 	va_end(args);
 }
 
-void gameport_register_port(struct gameport *gameport)
+/*
+ * Prepare gameport port for registration.
+ */
+static void gameport_init_port(struct gameport *gameport)
 {
-	list_add_tail(&gameport->node, &gameport_list);
+	static atomic_t gameport_no = ATOMIC_INIT(0);
+
+	__module_get(THIS_MODULE);
+
+	init_MUTEX(&gameport->drv_sem);
+	device_initialize(&gameport->dev);
+	snprintf(gameport->dev.bus_id, sizeof(gameport->dev.bus_id),
+		 "gameport%lu", (unsigned long)atomic_inc_return(&gameport_no) - 1);
+	gameport->dev.bus = &gameport_bus;
+	gameport->dev.release = gameport_release_port;
+	if (gameport->parent)
+		gameport->dev.parent = &gameport->parent->dev;
+}
+
+/*
+ * Complete gameport port registration.
+ * Driver core will attempt to find appropriate driver for the port.
+ */
+static void gameport_add_port(struct gameport *gameport)
+{
+	if (gameport->parent)
+		gameport->parent->child = gameport;
+
 	gameport->speed = gameport_measure_speed(gameport);
 
-	if (gameport->dyn_alloc) {
-		if (gameport->io)
-			printk(KERN_INFO "gameport: %s is %s, io %#x, speed %d kHz\n",
-				gameport->name, gameport->phys, gameport->io, gameport->speed);
-		else
-			printk(KERN_INFO "gameport: %s is %s, speed %d kHz\n",
-				gameport->name, gameport->phys, gameport->speed);
+	list_add_tail(&gameport->node, &gameport_list);
+
+	if (gameport->io)
+		printk(KERN_INFO "gameport: %s is %s, io %#x, speed %dkHz\n",
+			gameport->name, gameport->phys, gameport->io, gameport->speed);
+	else
+		printk(KERN_INFO "gameport: %s is %s, speed %dkHz\n",
+			gameport->name, gameport->phys, gameport->speed);
+
+	device_add(&gameport->dev);
+	gameport->registered = 1;
+}
+
+/*
+ * gameport_destroy_port() completes deregistration process and removes
+ * port from the system
+ */
+static void gameport_destroy_port(struct gameport *gameport)
+{
+	struct gameport *child;
+
+	child = gameport_get_pending_child(gameport);
+	if (child) {
+		gameport_remove_pending_events(child);
+		put_device(&child->dev);
 	}
 
-	gameport_find_driver(gameport);
+	if (gameport->parent) {
+		gameport->parent->child = NULL;
+		gameport->parent = NULL;
+	}
+
+	if (gameport->registered) {
+		device_del(&gameport->dev);
+		list_del_init(&gameport->node);
+		gameport->registered = 0;
+	}
+
+	gameport_remove_pending_events(gameport);
+	put_device(&gameport->dev);
 }
 
 /*
+ * Reconnect gameport port and all its children (re-initialize attached devices)
+ */
+static void gameport_reconnect_port(struct gameport *gameport)
+{
+	do {
+		if (!gameport->drv || !gameport->drv->reconnect || gameport->drv->reconnect(gameport)) {
+			gameport_disconnect_port(gameport);
+			gameport_find_driver(gameport);
+			/* Ok, old children are now gone, we are done */
+			break;
+		}
+		gameport = gameport->child;
+	} while (gameport);
+}
+
+/*
+ * gameport_disconnect_port() unbinds a port from its driver. As a side effect
+ * all child ports are unbound and destroyed.
+ */
+static void gameport_disconnect_port(struct gameport *gameport)
+{
+	struct gameport *s, *parent;
+
+	if (gameport->child) {
+		/*
+		 * Children ports should be disconnected and destroyed
+		 * first, staring with the leaf one, since we don't want
+		 * to do recursion
+		 */
+		for (s = gameport; s->child; s = s->child)
+			/* empty */;
+
+		do {
+			parent = s->parent;
+
+			gameport_release_driver(s);
+			gameport_destroy_port(s);
+		} while ((s = parent) != gameport);
+	}
+
+	/*
+	 * Ok, no children left, now disconnect this port
+	 */
+	gameport_release_driver(gameport);
+}
+
+void gameport_rescan(struct gameport *gameport)
+{
+	gameport_queue_event(gameport, NULL, GAMEPORT_RESCAN);
+}
+
+void gameport_reconnect(struct gameport *gameport)
+{
+	gameport_queue_event(gameport, NULL, GAMEPORT_RECONNECT);
+}
+
+/*
+ * Submits register request to kgameportd for subsequent execution.
+ * Note that port registration is always asynchronous.
+ */
+void __gameport_register_port(struct gameport *gameport, struct module *owner)
+{
+	gameport_init_port(gameport);
+	gameport_queue_event(gameport, owner, GAMEPORT_REGISTER_PORT);
+}
+
+/*
+ * Synchronously unregisters gameport port.
+ */
+void gameport_unregister_port(struct gameport *gameport)
+{
+	down(&gameport_sem);
+	gameport_disconnect_port(gameport);
+	gameport_destroy_port(gameport);
+	up(&gameport_sem);
+}
+
+
+/*
  * Gameport driver operations
  */
 
@@ -165,69 +618,100 @@
 	__ATTR_NULL
 };
 
-void gameport_unregister_port(struct gameport *gameport)
+static int gameport_driver_probe(struct device *dev)
 {
-	list_del_init(&gameport->node);
-	if (gameport->drv)
-		gameport->drv->disconnect(gameport);
-	if (gameport->dyn_alloc)
-		kfree(gameport);
+	struct gameport *gameport = to_gameport_port(dev);
+	struct gameport_driver *drv = to_gameport_driver(dev->driver);
+
+	drv->connect(gameport, drv);
+	return gameport->drv ? 0 : -ENODEV;
 }
 
-void gameport_register_driver(struct gameport_driver *drv)
+static int gameport_driver_remove(struct device *dev)
 {
-	struct gameport *gameport;
+	struct gameport *gameport = to_gameport_port(dev);
+	struct gameport_driver *drv = to_gameport_driver(dev->driver);
 
-	drv->driver.bus = &gameport_bus;
-	driver_register(&drv->driver);
+	drv->disconnect(gameport);
+	return 0;
+}
 
-	list_add_tail(&drv->node, &gameport_driver_list);
-	list_for_each_entry(gameport, &gameport_list, node)
-		if (!gameport->drv)
-			drv->connect(gameport, drv);
+void __gameport_register_driver(struct gameport_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &gameport_bus;
+	drv->driver.probe = gameport_driver_probe;
+	drv->driver.remove = gameport_driver_remove;
+	gameport_queue_event(drv, owner, GAMEPORT_REGISTER_DRIVER);
 }
 
 void gameport_unregister_driver(struct gameport_driver *drv)
 {
 	struct gameport *gameport;
 
-	list_del_init(&drv->node);
+	down(&gameport_sem);
+	drv->ignore = 1;	/* so gameport_find_driver ignores it */
+
+start_over:
 	list_for_each_entry(gameport, &gameport_list, node) {
-		if (gameport->drv == drv)
-			drv->disconnect(gameport);
-		gameport_find_driver(gameport);
+		if (gameport->drv == drv) {
+			gameport_disconnect_port(gameport);
+			gameport_find_driver(gameport);
+			/* we could've deleted some ports, restart */
+			goto start_over;
+		}
 	}
+
 	driver_unregister(&drv->driver);
+	up(&gameport_sem);
+}
+
+static int gameport_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct gameport_driver *gameport_drv = to_gameport_driver(drv);
+
+	return !gameport_drv->ignore;
+}
+
+static void gameport_set_drv(struct gameport *gameport, struct gameport_driver *drv)
+{
+	down(&gameport->drv_sem);
+	gameport->drv = drv;
+	up(&gameport->drv_sem);
 }
 
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode)
 {
+
 	if (gameport->open) {
-		if (gameport->open(gameport, mode))
+		if (gameport->open(gameport, mode)) {
 			return -1;
+		}
 	} else {
 		if (mode != GAMEPORT_MODE_RAW)
 			return -1;
 	}
 
-	if (gameport->drv)
-		return -1;
-
-	gameport->drv = drv;
-
+	gameport_set_drv(gameport, drv);
 	return 0;
 }
 
 void gameport_close(struct gameport *gameport)
 {
-	gameport->drv = NULL;
+	gameport_set_drv(gameport, NULL);
 	if (gameport->close)
 		gameport->close(gameport);
 }
 
 static int __init gameport_init(void)
 {
+	if (!(gameport_pid = kernel_thread(gameport_thread, NULL, CLONE_KERNEL))) {
+		printk(KERN_ERR "gameport: Failed to start kgameportd\n");
+		return -1;
+	}
+
+	gameport_bus.dev_attrs = gameport_device_attrs;
 	gameport_bus.drv_attrs = gameport_driver_attrs;
+	gameport_bus.match = gameport_bus_match;
 	bus_register(&gameport_bus);
 
 	return 0;
@@ -236,6 +720,8 @@
 static void __exit gameport_exit(void)
 {
 	bus_unregister(&gameport_bus);
+	kill_proc(gameport_pid, SIGTERM, 1);
+	wait_for_completion(&gameport_exited);
 }
 
 module_init(gameport_init);
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2005-02-11 01:40:19 -05:00
+++ b/include/linux/gameport.h	2005-02-11 01:40:19 -05:00
@@ -17,10 +17,8 @@
 
 	void *private;		/* Private pointer for joystick drivers */
 	void *port_data;	/* Private pointer for gameport drivers */
-	char *name;
-	char name_buf[32];
-	char *phys;
-	char phys_buf[32];
+	char name[32];
+	char phys[32];
 
 	int io;
 	int speed;
@@ -33,14 +31,17 @@
 	int (*open)(struct gameport *, int);
 	void (*close)(struct gameport *);
 
+	struct gameport *parent, *child;
+
 	struct gameport_driver *drv;
+	struct semaphore drv_sem;	/* protects serio->drv so attributes can pin driver */
+
 	struct device dev;
+	unsigned int registered;	/* port has been fully registered with driver core */
 
 	struct list_head node;
-
-	/* temporary, till sysfs transition is complete */
-	int dyn_alloc;
 };
+#define to_gameport_port(d)	container_of(d, struct gameport, dev)
 
 struct gameport_driver {
 
@@ -48,10 +49,12 @@
 	char *description;
 
 	int (*connect)(struct gameport *, struct gameport_driver *drv);
+	int (*reconnect)(struct gameport *);
 	void (*disconnect)(struct gameport *);
 
 	struct device_driver driver;
-	struct list_head node;
+
+	unsigned int ignore;
 };
 #define to_gameport_driver(d)	container_of(d, struct gameport_driver, driver)
 
@@ -59,13 +62,18 @@
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
+void __gameport_register_port(struct gameport *gameport, struct module *owner);
+static inline void gameport_register_port(struct gameport *gameport)
+{
+	__gameport_register_port(gameport, THIS_MODULE);
+}
+
+void gameport_unregister_port(struct gameport *gameport);
+
 static inline struct gameport *gameport_allocate_port(void)
 {
 	struct gameport *gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL);
 
-	if (gameport)
-		gameport->dyn_alloc = 1;
-
 	return gameport;
 }
 
@@ -76,17 +84,31 @@
 
 static inline void gameport_set_name(struct gameport *gameport, const char *name)
 {
-	gameport->name = gameport->name_buf;
-	strlcpy(gameport->name, name, sizeof(gameport->name_buf));
+	strlcpy(gameport->name, name, sizeof(gameport->name));
 }
 
 void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
 
-void gameport_register_port(struct gameport *gameport);
-void gameport_unregister_port(struct gameport *gameport);
+/*
+ * Use the following fucntions to pin gameport's driver in process context
+ */
+static inline int gameport_pin_driver(struct gameport *gameport)
+{
+	return down_interruptible(&gameport->drv_sem);
+}
+
+static inline void gameport_unpin_driver(struct gameport *gameport)
+{
+	up(&gameport->drv_sem);
+}
+
+void __gameport_register_driver(struct gameport_driver *drv, struct module *owner);
+static inline void gameport_register_driver(struct gameport_driver *drv)
+{
+	__gameport_register_driver(drv, THIS_MODULE);
+}
 
-void gameport_register_driver(struct gameport_driver *drv);
 void gameport_unregister_driver(struct gameport_driver *drv);
 
 #define GAMEPORT_MODE_DISABLED		0
@@ -104,7 +126,7 @@
 #define GAMEPORT_ID_VENDOR_GRAVIS	0x0009
 #define GAMEPORT_ID_VENDOR_GUILLEMOT	0x000a
 
-static __inline__ void gameport_trigger(struct gameport *gameport)
+static inline void gameport_trigger(struct gameport *gameport)
 {
 	if (gameport->trigger)
 		gameport->trigger(gameport);
@@ -112,7 +134,7 @@
 		outb(0xff, gameport->io);
 }
 
-static __inline__ unsigned char gameport_read(struct gameport *gameport)
+static inline unsigned char gameport_read(struct gameport *gameport)
 {
 	if (gameport->read)
 		return gameport->read(gameport);
@@ -120,7 +142,7 @@
 		return inb(gameport->io);
 }
 
-static __inline__ int gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
+static inline int gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
 	if (gameport->cooked_read)
 		return gameport->cooked_read(gameport, axes, buttons);
@@ -128,7 +150,7 @@
 		return -1;
 }
 
-static __inline__ int gameport_calibrate(struct gameport *gameport, int *axes, int *max)
+static inline int gameport_calibrate(struct gameport *gameport, int *axes, int *max)
 {
 	if (gameport->calibrate)
 		return gameport->calibrate(gameport, axes, max);
@@ -136,7 +158,7 @@
 		return -1;
 }
 
-static __inline__ int gameport_time(struct gameport *gameport, int time)
+static inline int gameport_time(struct gameport *gameport, int time)
 {
 	return (time * gameport->speed) / 1000;
 }
