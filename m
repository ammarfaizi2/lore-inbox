Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbUKXHbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUKXHbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbUKXH3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:29:11 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:3942 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262336AbUKXHO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/11] serio bus code cleanup
Date: Wed, 24 Nov 2004 02:09:47 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240208.14115.dtor_core@ameritech.net> <200411240209.02935.dtor_core@ameritech.net>
In-Reply-To: <200411240209.02935.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240209.49593.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1961, 2004-11-24 00:33:25-05:00, dtor_core@ameritech.net
  Input: make serio implementation more in line with standard
         driver model implementations. serio_register_port is
         always asynchronous to allow freely registering child
         ports. When deregistering serio core still takes care
         of destroying children ports first.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/mouse/psmouse-base.c |   11 -
 drivers/input/mouse/synaptics.c    |   10 -
 drivers/input/serio/serio.c        |  350 +++++++++++++++++++------------------
 include/linux/serio.h              |   17 +
 4 files changed, 208 insertions(+), 180 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-11-24 01:51:14 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-11-24 01:51:14 -05:00
@@ -754,6 +754,7 @@
 	memset(psmouse, 0, sizeof(struct psmouse));
 
 	ps2_init(&psmouse->ps2dev, serio);
+	sprintf(psmouse->phys, "%s/input0", serio->phys);
 	init_timer(&psmouse->ping_timer);
 	psmouse->ping_timer.data = (unsigned long)psmouse;
 	psmouse->ping_timer.function = psmouse_ping_device;
@@ -793,8 +794,6 @@
 
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
-	sprintf(psmouse->phys, "%s/input0",
-		serio->phys);
 
 	psmouse->dev.name = psmouse->devname;
 	psmouse->dev.phys = psmouse->phys;
@@ -819,14 +818,6 @@
 	device_create_file(&serio->dev, &psmouse_attr_rate);
 	device_create_file(&serio->dev, &psmouse_attr_resolution);
 	device_create_file(&serio->dev, &psmouse_attr_resetafter);
-
-	if (serio->child) {
-		/*
-		 * Nothing to be done here, serio core will detect that
-		 * the driver set serio->child and will register it for us.
-		 */
-		printk(KERN_INFO "serio: %s port at %s\n", serio->child->name, psmouse->phys);
-	}
 
 	psmouse_activate(psmouse);
 
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-11-24 01:51:14 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-11-24 01:51:14 -05:00
@@ -296,7 +296,8 @@
 
 	psmouse->pt_activate = synaptics_pt_activate;
 
-	psmouse->ps2dev.serio->child = serio;
+	printk(KERN_INFO "serio: %s port at %s\n", serio->name, psmouse->phys);
+	serio_register_port(serio);
 }
 
 /*****************************************************************************
@@ -552,6 +553,7 @@
 {
 	synaptics_reset(psmouse);
 	kfree(psmouse->private);
+	psmouse->private = NULL;
 }
 
 static int synaptics_reconnect(struct psmouse *psmouse)
@@ -640,9 +642,6 @@
 
 	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
 
-	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
-		synaptics_pt_create(psmouse);
-
 	print_ident(priv);
 	set_input_params(&psmouse->dev, priv);
 
@@ -651,6 +650,9 @@
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->pktsize = 6;
+
+	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+		synaptics_pt_create(psmouse);
 
 #if defined(__i386__)
 	/*
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-24 01:51:14 -05:00
+++ b/drivers/input/serio/serio.c	2004-11-24 01:51:14 -05:00
@@ -42,10 +42,9 @@
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(serio_interrupt);
-EXPORT_SYMBOL(serio_register_port);
-EXPORT_SYMBOL(serio_register_port_delayed);
+EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
-EXPORT_SYMBOL(serio_unregister_port_delayed);
+EXPORT_SYMBOL(__serio_unregister_port_delayed);
 EXPORT_SYMBOL(serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
@@ -53,19 +52,20 @@
 EXPORT_SYMBOL(serio_rescan);
 EXPORT_SYMBOL(serio_reconnect);
 
-static DECLARE_MUTEX(serio_sem);	/* protects serio_list and serio_diriver_list */
+/*
+ * serio_sem protects entire serio subsystem and is taken every time
+ * serio port or driver registrered or unregistered.
+ */
+static DECLARE_MUTEX(serio_sem);
+
 static LIST_HEAD(serio_list);
-static LIST_HEAD(serio_driver_list);
-static unsigned int serio_no;
 
 struct bus_type serio_bus = {
 	.name =	"serio",
 };
 
-static void serio_find_driver(struct serio *serio);
-static void serio_create_port(struct serio *serio);
+static void serio_add_port(struct serio *serio);
 static void serio_destroy_port(struct serio *serio);
-static void serio_connect_port(struct serio *serio, struct serio_driver *drv);
 static void serio_reconnect_port(struct serio *serio);
 static void serio_disconnect_port(struct serio *serio);
 
@@ -82,37 +82,37 @@
 	return 0;
 }
 
-static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
-{
-	get_driver(&drv->driver);
+/*
+ * Basic serio -> driver core mappings
+ */
 
+static void serio_bind_driver(struct serio *serio, struct serio_driver *drv)
+{
+	down_write(&serio_bus.subsys.rwsem);
 	if (serio_match_port(drv->ids, serio)) {
+		serio->dev.driver = &drv->driver;
 		drv->connect(serio, drv);
-
-		if (serio->drv) {
-			down_write(&serio_bus.subsys.rwsem);
-			serio->dev.driver = &drv->driver;
-			device_bind_driver(&serio->dev);
-			up_write(&serio_bus.subsys.rwsem);
-			return 1;
-		}
+		if (!serio->drv)
+			serio->dev.driver = NULL;
 	}
+	up_write(&serio_bus.subsys.rwsem);
+}
 
-	put_driver(&drv->driver);
-	return 0;
+static void serio_release_driver(struct serio *serio)
+{
+	down_write(&serio_bus.subsys.rwsem);
+	device_release_driver(&serio->dev);
+	up_write(&serio_bus.subsys.rwsem);
 }
 
-/* serio_find_driver() must be called with serio_sem down.  */
 static void serio_find_driver(struct serio *serio)
 {
-	struct serio_driver *drv;
-
-	list_for_each_entry(drv, &serio_driver_list, node)
-		if (!drv->manual_bind)
-			if (serio_bind_driver(serio, drv))
-				break;
+	down_write(&serio_bus.subsys.rwsem);
+	device_attach(&serio->dev);
+	up_write(&serio_bus.subsys.rwsem);
 }
 
+
 /*
  * Serio event processing.
  */
@@ -120,6 +120,7 @@
 struct serio_event {
 	int type;
 	struct serio *serio;
+	struct module *owner;
 	struct list_head node;
 };
 
@@ -136,7 +137,8 @@
 static DECLARE_COMPLETION(serio_exited);
 static int serio_pid;
 
-static void serio_queue_event(struct serio *serio, enum serio_event_type event_type)
+static void serio_queue_event(struct serio *serio, struct module *owner,
+			      enum serio_event_type event_type)
 {
 	unsigned long flags;
 	struct serio_event *event;
@@ -159,17 +161,27 @@
 	}
 
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		__module_get(owner);
+
 		event->type = event_type;
 		event->serio = serio;
+		event->owner = owner;
 
 		list_add_tail(&event->node, &serio_event_list);
 		wake_up(&serio_wait);
+	} else {
+		printk(KERN_ERR "serio: Not enough memory to queue event %d\n", event_type);
 	}
-
 out:
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
+static void serio_free_event(struct serio_event *event)
+{
+	module_put(event->owner);
+	kfree(event);
+}
+
 static void serio_remove_duplicate_events(struct serio_event *event)
 {
 	struct list_head *node, *next;
@@ -179,7 +191,7 @@
 	spin_lock_irqsave(&serio_event_lock, flags);
 
 	list_for_each_safe(node, next, &serio_event_list) {
-		e = container_of(node, struct serio_event, node);
+		e = list_entry(node, struct serio_event, node);
 		if (event->serio == e->serio) {
 			/*
 			 * If this event is of different type we should not
@@ -187,9 +199,10 @@
 			 * that were sent back-to-back.
 			 */
 			if (event->type != e->type)
-				break;	/* Stop, when need to preserve event flow */
+				break;
+
 			list_del_init(node);
-			kfree(e);
+			serio_free_event(e);
 		}
 	}
 
@@ -211,7 +224,7 @@
 	}
 
 	node = serio_event_list.next;
-	event = container_of(node, struct serio_event, node);
+	event = list_entry(node, struct serio_event, node);
 	list_del_init(node);
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
@@ -223,14 +236,14 @@
 {
 	struct serio_event *event;
 
-	while ((event = serio_get_event())) {
+	down(&serio_sem);
 
-		down(&serio_sem);
+	while ((event = serio_get_event())) {
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT :
-				serio_create_port(event->serio);
-				serio_connect_port(event->serio, NULL);
+				serio_add_port(event->serio);
+				serio_find_driver(event->serio);
 				break;
 
 			case SERIO_UNREGISTER_PORT :
@@ -244,18 +257,22 @@
 
 			case SERIO_RESCAN :
 				serio_disconnect_port(event->serio);
-				serio_connect_port(event->serio, NULL);
+				serio_find_driver(event->serio);
 				break;
 			default:
 				break;
 		}
 
-		up(&serio_sem);
 		serio_remove_duplicate_events(event);
-		kfree(event);
+		serio_free_event(event);
 	}
+
+	up(&serio_sem);
 }
 
+/*
+ * Remove all events that have been submitted for a given serio port.
+ */
 static void serio_remove_pending_events(struct serio *serio)
 {
 	struct list_head *node, *next;
@@ -265,16 +282,42 @@
 	spin_lock_irqsave(&serio_event_lock, flags);
 
 	list_for_each_safe(node, next, &serio_event_list) {
-		event = container_of(node, struct serio_event, node);
+		event = list_entry(node, struct serio_event, node);
 		if (event->serio == serio) {
 			list_del_init(node);
-			kfree(event);
+			serio_free_event(event);
 		}
 	}
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
+/*
+ * Destroy child serio port (if any) that has not been fully registered yet.
+ *
+ * Note that we rely on the fact that port can have only one child and therefore
+ * only one child registration request can be pending. Additionally, children
+ * are registered by driver's connect() handler so there can't be a grandchild
+ * pending registration together with a child.
+ */
+static struct serio *serio_get_pending_child(struct serio *parent)
+{
+	struct serio_event *event;
+	struct serio *serio = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_event_lock, flags);
+
+	list_for_each_entry(event, &serio_event_list, node) {
+		if (event->type == SERIO_REGISTER_PORT && event->serio->parent == parent) {
+			serio = event->serio;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&serio_event_lock, flags);
+	return serio;
+}
 
 static int serio_thread(void *nothing)
 {
@@ -323,10 +366,10 @@
 		serio_reconnect_port(serio);
 	} else if (!strncmp(buf, "rescan", count)) {
 		serio_disconnect_port(serio);
-		serio_connect_port(serio, NULL);
+		serio_find_driver(serio);
 	} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
 		serio_disconnect_port(serio);
-		serio_connect_port(serio, to_serio_driver(drv));
+		serio_bind_driver(serio, to_serio_driver(drv));
 		put_driver(drv);
 	} else {
 		retval = -EINVAL;
@@ -376,22 +419,43 @@
 	module_put(THIS_MODULE);
 }
 
-static void serio_create_port(struct serio *serio)
+/*
+ * Prepare serio port for registration.
+ */
+static void serio_init_port(struct serio *serio)
 {
-	try_module_get(THIS_MODULE);
+	static atomic_t serio_no = ATOMIC_INIT(0);
+
+	__module_get(THIS_MODULE);
 
 	spin_lock_init(&serio->lock);
 	init_MUTEX(&serio->drv_sem);
-	list_add_tail(&serio->node, &serio_list);
-	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id), "serio%d", serio_no++);
+	device_initialize(&serio->dev);
+	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id),
+		 "serio%d", atomic_inc_return(&serio_no) - 1);
 	serio->dev.bus = &serio_bus;
 	serio->dev.release = serio_release_port;
 	if (serio->parent)
 		serio->dev.parent = &serio->parent->dev;
-	device_initialize(&serio->dev);
+}
+
+/*
+ * Complete serio port registration.
+ * Driver core will attempt to find appropriate driver for the port.
+ */
+static void serio_add_port(struct serio *serio)
+{
+	if (serio->parent) {
+		serio_pause_rx(serio->parent);
+		serio->parent->child = serio;
+		serio_continue_rx(serio->parent);
+	}
+
+	list_add_tail(&serio->node, &serio_list);
 	if (serio->start)
 		serio->start(serio);
 	device_add(&serio->dev);
+	serio->registered = 1;
 }
 
 /*
@@ -400,77 +464,43 @@
  */
 static void serio_destroy_port(struct serio *serio)
 {
-	struct serio_driver *drv = serio->drv;
-	unsigned long flags;
-
-	serio_remove_pending_events(serio);
-	list_del_init(&serio->node);
+	struct serio *child;
 
-	if (drv) {
-		drv->disconnect(serio);
-		down_write(&serio_bus.subsys.rwsem);
-		device_release_driver(&serio->dev);
-		up_write(&serio_bus.subsys.rwsem);
-		put_driver(&drv->driver);
+	child = serio_get_pending_child(serio);
+	if (child) {
+		serio_remove_pending_events(child);
+		put_device(&child->dev);
 	}
 
 	if (serio->stop)
 		serio->stop(serio);
 
 	if (serio->parent) {
-		spin_lock_irqsave(&serio->parent->lock, flags);
+		serio_pause_rx(serio->parent);
 		serio->parent->child = NULL;
-		spin_unlock_irqrestore(&serio->parent->lock, flags);
+		serio->parent = NULL;
+		serio_continue_rx(serio->parent);
 	}
 
-	device_unregister(&serio->dev);
-}
-
-/*
- * serio_connect_port() tries to bind the port and possible all its
- * children to appropriate drivers. If driver passed in the function will not
- * try otehr drivers when binding parent port.
- */
-static void serio_connect_port(struct serio *serio, struct serio_driver *drv)
-{
-	WARN_ON(serio->drv);
-	WARN_ON(serio->child);
-
-	if (drv)
-		serio_bind_driver(serio, drv);
-	else if (!serio->manual_bind)
-		serio_find_driver(serio);
-
-	/* Ok, now bind children, if any */
-	while (serio->child) {
-		serio = serio->child;
-
-		WARN_ON(serio->drv);
-		WARN_ON(serio->child);
-
-		serio_create_port(serio);
-
-		if (!serio->manual_bind) {
-			/*
-			 * With children we just _prefer_ passed in driver,
-			 * but we will try other options in case preferred
-			 * is not the one
-			 */
-			if (!drv || !serio_bind_driver(serio, drv))
-				serio_find_driver(serio);
-		}
+	if (serio->registered) {
+		device_del(&serio->dev);
+		list_del_init(&serio->node);
+		serio->registered = 0;
 	}
+
+	serio_remove_pending_events(serio);
+	put_device(&serio->dev);
 }
 
 /*
- *
+ * Reconnect serio port and all its children (re-initialize attached devices)
  */
 static void serio_reconnect_port(struct serio *serio)
 {
 	do {
 		if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
 			serio_disconnect_port(serio);
-			serio_connect_port(serio, NULL);
+			serio_find_driver(serio);
 			/* Ok, old children are now gone, we are done */
 			break;
 		}
@@ -484,8 +514,7 @@
  */
 static void serio_disconnect_port(struct serio *serio)
 {
-	struct serio_driver *drv = serio->drv;
-	struct serio *s;
+	struct serio *s, *parent;
 
 	if (serio->child) {
 		/*
@@ -493,56 +522,46 @@
 		 * first, staring with the leaf one, since we don't want
 		 * to do recursion
 		 */
+		for (s = serio; s->child; s = s->child)
+			/* empty */;
+
 		do {
-			s = serio->child;
-		} while (s->child);
+			parent = s->parent;
 
-		while (s != serio) {
-			s = s->parent;
-			serio_destroy_port(s->child);
-		}
+			serio_release_driver(s);
+			serio_destroy_port(s);
+		} while ((s = parent) != serio);
 	}
 
 	/*
 	 * Ok, no children left, now disconnect this port
 	 */
-	if (drv) {
-		drv->disconnect(serio);
-		down_write(&serio_bus.subsys.rwsem);
-		device_release_driver(&serio->dev);
-		up_write(&serio_bus.subsys.rwsem);
-		put_driver(&drv->driver);
-	}
+	serio_release_driver(serio);
 }
 
 void serio_rescan(struct serio *serio)
 {
-	serio_queue_event(serio, SERIO_RESCAN);
+	serio_queue_event(serio, NULL, SERIO_RESCAN);
 }
 
 void serio_reconnect(struct serio *serio)
 {
-	serio_queue_event(serio, SERIO_RECONNECT);
-}
-
-void serio_register_port(struct serio *serio)
-{
-	down(&serio_sem);
-	serio_create_port(serio);
-	serio_connect_port(serio, NULL);
-	up(&serio_sem);
+	serio_queue_event(serio, NULL, SERIO_RECONNECT);
 }
 
 /*
  * Submits register request to kseriod for subsequent execution.
- * Can be used when it is not obvious whether the serio_sem is
- * taken or not and when delayed execution is feasible.
+ * Note that port registration is always asynchronous.
  */
-void serio_register_port_delayed(struct serio *serio)
+void __serio_register_port(struct serio *serio, struct module *owner)
 {
-	serio_queue_event(serio, SERIO_REGISTER_PORT);
+	serio_init_port(serio);
+	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
 }
 
+/*
+ * Synchronously unregisters serio port.
+ */
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
@@ -552,13 +571,13 @@
 }
 
 /*
- * Submits unregister request to kseriod for subsequent execution.
+ * Submits register request to kseriod for subsequent execution.
  * Can be used when it is not obvious whether the serio_sem is
  * taken or not and when delayed execution is feasible.
  */
-void serio_unregister_port_delayed(struct serio *serio)
+void __serio_unregister_port_delayed(struct serio *serio, struct module *owner)
 {
-	serio_queue_event(serio, SERIO_UNREGISTER_PORT);
+	serio_queue_event(serio, owner, SERIO_UNREGISTER_PORT);
 }
 
 
@@ -603,34 +622,33 @@
 	__ATTR_NULL
 };
 
-void serio_register_driver(struct serio_driver *drv)
+static int serio_driver_probe(struct device *dev)
 {
-	struct serio *serio;
+	struct serio *serio = to_serio_port(dev);
+	struct serio_driver *drv = to_serio_driver(dev->driver);
 
-	down(&serio_sem);
+	drv->connect(serio, drv);
+	return serio->drv ? 0 : -ENODEV;
+}
 
-	list_add_tail(&drv->node, &serio_driver_list);
+static int serio_driver_remove(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct serio_driver *drv = to_serio_driver(dev->driver);
 
-	drv->driver.bus = &serio_bus;
-	driver_register(&drv->driver);
+	drv->disconnect(serio);
+	return 0;
+}
 
-	if (drv->manual_bind)
-		goto out;
+void serio_register_driver(struct serio_driver *drv)
+{
+	down(&serio_sem);
 
-start_over:
-	list_for_each_entry(serio, &serio_list, node) {
-		if (!serio->drv) {
-			serio_connect_port(serio, drv);
-			/*
-			 * if new child appeared then the list is changed,
-			 * we need to start over
-			 */
-			if (serio->child)
-				goto start_over;
-		}
-	}
+	drv->driver.bus = &serio_bus;
+	drv->driver.probe = serio_driver_probe;
+	drv->driver.remove = serio_driver_remove;
+	driver_register(&drv->driver);
 
-out:
 	up(&serio_sem);
 }
 
@@ -639,21 +657,19 @@
 	struct serio *serio;
 
 	down(&serio_sem);
-
-	list_del_init(&drv->node);
+	drv->manual_bind = 1;	/* so serio_find_driver ignores it */
 
 start_over:
 	list_for_each_entry(serio, &serio_list, node) {
 		if (serio->drv == drv) {
 			serio_disconnect_port(serio);
-			serio_connect_port(serio, NULL);
+			serio_find_driver(serio);
 			/* we could've deleted some ports, restart */
 			goto start_over;
 		}
 	}
 
 	driver_unregister(&drv->driver);
-
 	up(&serio_sem);
 }
 
@@ -666,6 +682,17 @@
 	up(&serio->drv_sem);
 }
 
+static int serio_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct serio_driver *serio_drv = to_serio_driver(drv);
+
+	if (serio->manual_bind || serio_drv->manual_bind)
+		return 0;
+
+	return serio_match_port(serio_drv->ids, serio);
+}
+
 /* called from serio_driver->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_driver *drv)
 {
@@ -697,7 +724,7 @@
 
         if (likely(serio->drv)) {
                 ret = serio->drv->interrupt(serio, data, dfl, regs);
-	} else if (!dfl) {
+	} else if (!dfl && serio->registered) {
 		serio_rescan(serio);
 		ret = IRQ_HANDLED;
 	}
@@ -710,12 +737,13 @@
 static int __init serio_init(void)
 {
 	if (!(serio_pid = kernel_thread(serio_thread, NULL, CLONE_KERNEL))) {
-		printk(KERN_WARNING "serio: Failed to start kseriod\n");
+		printk(KERN_ERR "serio: Failed to start kseriod\n");
 		return -1;
 	}
 
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
+	serio_bus.match = serio_bus_match;
 	bus_register(&serio_bus);
 
 	return 0;
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-11-24 01:51:14 -05:00
+++ b/include/linux/serio.h	2004-11-24 01:51:14 -05:00
@@ -51,6 +51,7 @@
 	struct semaphore drv_sem;	/* protects serio->drv so attributes can pin driver */
 
 	struct device dev;
+	unsigned int registered;	/* port has been fully registered with driver core */
 
 	struct list_head node;
 };
@@ -72,8 +73,6 @@
 	void (*cleanup)(struct serio *);
 
 	struct device_driver driver;
-
-	struct list_head node;
 };
 #define to_serio_driver(d)	container_of(d, struct serio_driver, driver)
 
@@ -83,10 +82,18 @@
 void serio_reconnect(struct serio *serio);
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
-void serio_register_port(struct serio *serio);
-void serio_register_port_delayed(struct serio *serio);
+void __serio_register_port(struct serio *serio, struct module *owner);
+static inline void serio_register_port(struct serio *serio)
+{
+	__serio_register_port(serio, THIS_MODULE);
+}
+
 void serio_unregister_port(struct serio *serio);
-void serio_unregister_port_delayed(struct serio *serio);
+void __serio_unregister_port_delayed(struct serio *serio, struct module *owner);
+static inline void serio_unregister_port_delayed(struct serio *serio)
+{
+	__serio_unregister_port_delayed(serio, THIS_MODULE);
+}
 
 void serio_register_driver(struct serio_driver *drv);
 void serio_unregister_driver(struct serio_driver *drv);
