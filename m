Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUG2O0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUG2O0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUG2O0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:26:07 -0400
Received: from styx.suse.cz ([82.119.242.94]:28310 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265027AbUG2OIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:13 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 36/47] allow serio drivers to create children ports
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110196896@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101962419@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.31, 2004-06-29 01:28:21-05:00, dtor_core@ameritech.net
  Input: allow serio drivers to create children ports and register these
         ports for them in serio core to avoid having recursion in connect
         methods.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/mouse/psmouse-base.c |   75 ++++++++----
 drivers/input/mouse/psmouse.h      |   16 --
 drivers/input/mouse/synaptics.c    |   27 +---
 drivers/input/serio/serio.c        |  215 ++++++++++++++++++++++++++++---------
 include/linux/serio.h              |    4 
 5 files changed, 231 insertions(+), 106 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:21 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:21 2004
@@ -652,16 +652,15 @@
 
 static void psmouse_disconnect(struct serio *serio)
 {
-	struct psmouse *psmouse = serio->private;
+	struct psmouse *psmouse, *parent;
 
+	psmouse = serio->private;
 	psmouse->state = PSMOUSE_CMD_MODE;
 
-	if (psmouse->ptport) {
-		if (psmouse->ptport->deactivate)
-			psmouse->ptport->deactivate(psmouse);
-		__serio_unregister_port(psmouse->ptport->serio); /* we have serio_sem */
-		kfree(psmouse->ptport);
-		psmouse->ptport = NULL;
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+		parent = serio->parent->private;
+		if (parent->pt_deactivate)
+			parent->pt_deactivate(parent);
 	}
 
 	if (psmouse->disconnect)
@@ -680,14 +679,17 @@
  */
 static void psmouse_connect(struct serio *serio, struct serio_driver *drv)
 {
-	struct psmouse *psmouse;
+	struct psmouse *psmouse, *parent = NULL;
 
 	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
 	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
 		return;
 
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU)
+		parent = serio->parent->private;
+
 	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
-		return;
+		goto out;
 
 	memset(psmouse, 0, sizeof(struct psmouse));
 
@@ -703,14 +705,14 @@
 	if (serio_open(serio, drv)) {
 		kfree(psmouse);
 		serio->private = NULL;
-		return;
+		goto out;
 	}
 
 	if (psmouse_probe(psmouse) < 0) {
 		serio_close(serio);
 		kfree(psmouse);
 		serio->private = NULL;
-		return;
+		goto out;
 	}
 
 	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
@@ -739,20 +741,36 @@
 
 	psmouse_initialize(psmouse);
 
-	if (psmouse->ptport) {
-		printk(KERN_INFO "serio: %s port at %s\n", psmouse->ptport->serio->name, psmouse->phys);
-		__serio_register_port(psmouse->ptport->serio); /* we have serio_sem */
-		if (psmouse->ptport->activate)
-			psmouse->ptport->activate(psmouse);
-	}
+	if (parent && parent->pt_activate)
+		parent->pt_activate(parent);
 
-	psmouse_activate(psmouse);
+	/*
+	 * OK, the device is ready, we just need to activate it (turn the
+	 * stream mode on). But if mouse has a pass-through port we don't
+	 * want to do it yet to not disturb child detection.
+	 * The child will activate this port when it's ready.
+	 */
+
+	if (serio->child) {
+		/*
+		 * Nothing to be done here, serio core will detect that
+		 * the driver set serio->child and will register it for us.
+		 */
+		printk(KERN_INFO "serio: %s port at %s\n", serio->child->name, psmouse->phys);
+	} else
+		psmouse_activate(psmouse);
+
+out:
+	/* If this is a pass-through port the parent awaits to be activated */
+	if (parent)
+		psmouse_activate(parent);
 }
 
 
 static int psmouse_reconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
+	struct psmouse *parent = NULL;
 	struct serio_driver *drv = serio->drv;
 
 	if (!drv || !psmouse) {
@@ -779,16 +797,19 @@
 	 */
 	psmouse_initialize(psmouse);
 
-	if (psmouse->ptport) {
-       		if (psmouse_reconnect(psmouse->ptport->serio)) {
-			__serio_unregister_port(psmouse->ptport->serio);
-			__serio_register_port(psmouse->ptport->serio);
-			if (psmouse->ptport->activate)
-				psmouse->ptport->activate(psmouse);
-		}
-	}
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU)
+		parent = serio->parent->private;
+
+	if (parent && parent->pt_activate)
+		parent->pt_activate(parent);
+
+	if (!serio->child)
+		psmouse_activate(psmouse);
+
+	/* If this is a pass-through port the parent waits to be activated */
+	if (parent)
+		psmouse_activate(parent);
 
-	psmouse_activate(psmouse);
 	return 0;
 }
 
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Thu Jul 29 14:39:21 2004
+++ b/drivers/input/mouse/psmouse.h	Thu Jul 29 14:39:21 2004
@@ -34,21 +34,10 @@
 	PSMOUSE_FULL_PACKET
 } psmouse_ret_t;
 
-struct psmouse;
-
-struct psmouse_ptport {
-	struct serio *serio;
-	struct psmouse *parent;
-
-	void (*activate)(struct psmouse *parent);
-	void (*deactivate)(struct psmouse *parent);
-};
-
 struct psmouse {
 	void *private;
 	struct input_dev dev;
 	struct serio *serio;
-	struct psmouse_ptport *ptport;
 	char *vendor;
 	char *name;
 	unsigned char cmdbuf[8];
@@ -66,9 +55,12 @@
 	char phys[32];
 	unsigned long flags;
 
-	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs); 
+	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
+
+	void (*pt_activate)(struct psmouse *psmouse);
+	void (*pt_deactivate)(struct psmouse *psmouse);
 };
 
 #define PSMOUSE_PS2		1
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:21 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:21 2004
@@ -212,14 +212,14 @@
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
-static int synaptics_pt_write(struct serio *port, unsigned char c)
+static int synaptics_pt_write(struct serio *serio, unsigned char c)
 {
-	struct psmouse_ptport *ptport = port->port_data;
+	struct psmouse *parent = serio->parent->private;
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
-	if (psmouse_sliced_command(ptport->parent, c))
+	if (psmouse_sliced_command(parent, c))
 		return -1;
-	if (psmouse_command(ptport->parent, &rate_param, PSMOUSE_CMD_SETRATE))
+	if (psmouse_command(parent, &rate_param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
@@ -248,7 +248,7 @@
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct psmouse *child = psmouse->ptport->serio->private;
+	struct psmouse *child = psmouse->serio->child->private;
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child && child->type >= PSMOUSE_GENPS) {
@@ -259,30 +259,25 @@
 
 static void synaptics_pt_create(struct psmouse *psmouse)
 {
-	struct psmouse_ptport *port;
 	struct serio *serio;
 
-	port = kmalloc(sizeof(struct psmouse_ptport), GFP_KERNEL);
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!port || !serio) {
+	if (!serio) {
 		printk(KERN_ERR "synaptics: not enough memory to allocate pass-through port\n");
 		return;
 	}
 
-	memset(port, 0, sizeof(struct psmouse_ptport));
 	memset(serio, 0, sizeof(struct serio));
 
 	serio->type = SERIO_PS_PSTHRU;
 	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
 	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
 	serio->write = synaptics_pt_write;
-	serio->port_data = port;
+	serio->parent = psmouse->serio;
 
-	port->serio = serio;
-	port->parent = psmouse;
-	port->activate = synaptics_pt_activate;
+	psmouse->pt_activate = synaptics_pt_activate;
 
-	psmouse->ptport = port;
+	psmouse->serio->child = serio;
 }
 
 /*****************************************************************************
@@ -477,8 +472,8 @@
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (psmouse->ptport && psmouse->ptport->serio->drv && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(psmouse->ptport->serio, psmouse->packet);
+		if (psmouse->serio->child && psmouse->serio->child->drv && synaptics_is_pt_packet(psmouse->packet))
+			synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
 
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:21 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:21 2004
@@ -44,10 +44,8 @@
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(serio_register_port);
 EXPORT_SYMBOL(serio_register_port_delayed);
-EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(serio_unregister_port_delayed);
-EXPORT_SYMBOL(__serio_unregister_port);
 EXPORT_SYMBOL(serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
@@ -59,17 +57,28 @@
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_driver_list);
 
-/* serio_find_driver() must be called with serio_sem down.  */
+static void serio_find_driver(struct serio *serio);
+static void serio_create_port(struct serio *serio);
+static void serio_destroy_port(struct serio *serio);
+static void serio_connect_port(struct serio *serio, struct serio_driver *drv);
+static void serio_reconnect_port(struct serio *serio);
+static void serio_disconnect_port(struct serio *serio);
+
+static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
+{
+	drv->connect(serio, drv);
+
+	return serio->drv != NULL;
+}
 
+/* serio_find_driver() must be called with serio_sem down.  */
 static void serio_find_driver(struct serio *serio)
 {
 	struct serio_driver *drv;
 
-	list_for_each_entry(drv, &serio_driver_list, node) {
-		if (serio->drv)
+	list_for_each_entry(drv, &serio_driver_list, node)
+		if (serio_bind_driver(serio, drv))
 			break;
-		drv->connect(serio, drv);
-	}
 }
 
 /*
@@ -145,23 +154,22 @@
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT :
-				__serio_register_port(event->serio);
+				serio_create_port(event->serio);
+				serio_connect_port(event->serio, NULL);
 				break;
 
 			case SERIO_UNREGISTER_PORT :
-				__serio_unregister_port(event->serio);
+				serio_disconnect_port(event->serio);
+				serio_destroy_port(event->serio);
 				break;
 
 			case SERIO_RECONNECT :
-				if (event->serio->drv && event->serio->drv->reconnect)
-					if (event->serio->drv->reconnect(event->serio) == 0)
-						break;
-				/* reconnect failed - fall through to rescan */
+				serio_reconnect_port(event->serio);
+				break;
 
 			case SERIO_RESCAN :
-				if (event->serio->drv)
-					event->serio->drv->disconnect(event->serio);
-				serio_find_driver(event->serio);
+				serio_disconnect_port(event->serio);
+				serio_connect_port(event->serio, NULL);
 				break;
 			default:
 				break;
@@ -216,6 +224,118 @@
  * Serio port operations
  */
 
+static void serio_create_port(struct serio *serio)
+{
+	spin_lock_init(&serio->lock);
+	list_add_tail(&serio->node, &serio_list);
+}
+
+/*
+ * serio_destroy_port() completes deregistration process and removes
+ * port from the system
+ */
+static void serio_destroy_port(struct serio *serio)
+{
+	struct serio_driver *drv = serio->drv;
+	unsigned long flags;
+
+	serio_remove_pending_events(serio);
+	list_del_init(&serio->node);
+
+	if (drv)
+		drv->disconnect(serio);
+
+	if (serio->parent) {
+		spin_lock_irqsave(&serio->parent->lock, flags);
+		serio->parent->child = NULL;
+		spin_unlock_irqrestore(&serio->parent->lock, flags);
+	}
+
+	kfree(serio);
+}
+
+/*
+ * serio_connect_port() tries to bind the port and possible all its
+ * children to appropriate drivers. If driver passed in the function will not
+ * try otehr drivers when binding parent port.
+ */
+static void serio_connect_port(struct serio *serio, struct serio_driver *drv)
+{
+	WARN_ON(serio->drv);
+	WARN_ON(serio->child);
+
+	if (drv)
+		serio_bind_driver(serio, drv);
+	else
+		serio_find_driver(serio);
+
+	/* Ok, now bind children, if any */
+	while (serio->child) {
+		serio = serio->child;
+
+		WARN_ON(serio->drv);
+		WARN_ON(serio->child);
+
+		serio_create_port(serio);
+
+		/*
+		 * With children we just _prefer_ passed in driver,
+		 * but we will try other options in case preferred
+		 * is not the one
+		 */
+		if (!drv || !serio_bind_driver(serio, drv))
+			serio_find_driver(serio);
+	}
+}
+
+/*
+ *
+ */
+static void serio_reconnect_port(struct serio *serio)
+{
+	do {
+		if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
+			serio_disconnect_port(serio);
+			serio_connect_port(serio, NULL);
+			/* Ok, old children are now gone, we are done */
+			break;
+		}
+		serio = serio->child;
+	} while (serio);
+}
+
+/*
+ * serio_disconnect_port() unbinds a port from its driver. As a side effect
+ * all child ports are unbound and destroyed.
+ */
+static void serio_disconnect_port(struct serio *serio)
+{
+	struct serio_driver *drv = serio->drv;
+	struct serio *s;
+
+	if (serio->child) {
+		/*
+		 * Children ports should be disconnected and destroyed
+		 * first, staring with the leaf one, since we don't want
+		 * to do recursion
+		 */
+		do {
+			s = serio->child;
+		} while (s->child);
+
+		while (s != serio) {
+			s = s->parent;
+			serio_destroy_port(s->child);
+		}
+	}
+
+	/*
+	 * Ok, no children left, now disconnect this port
+	 */
+	if (drv)
+		drv->disconnect(serio);
+}
+
 void serio_rescan(struct serio *serio)
 {
 	serio_queue_event(serio, SERIO_RESCAN);
@@ -229,7 +349,8 @@
 void serio_register_port(struct serio *serio)
 {
 	down(&serio_sem);
-	__serio_register_port(serio);
+	serio_create_port(serio);
+	serio_connect_port(serio, NULL);
 	up(&serio_sem);
 }
 
@@ -243,22 +364,11 @@
 	serio_queue_event(serio, SERIO_REGISTER_PORT);
 }
 
-/*
- * Should only be called directly if serio_sem has already been taken,
- * for example when unregistering a serio from other input device's
- * connect() function.
- */
-void __serio_register_port(struct serio *serio)
-{
-	spin_lock_init(&serio->lock);
-	list_add_tail(&serio->node, &serio_list);
-	serio_find_driver(serio);
-}
-
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
-	__serio_unregister_port(serio);
+	serio_disconnect_port(serio);
+	serio_destroy_port(serio);
 	up(&serio_sem);
 }
 
@@ -272,32 +382,33 @@
 	serio_queue_event(serio, SERIO_UNREGISTER_PORT);
 }
 
-/*
- * Should only be called directly if serio_sem has already been taken,
- * for example when unregistering a serio from other input device's
- * disconnect() function.
- */
-void __serio_unregister_port(struct serio *serio)
-{
-	serio_remove_pending_events(serio);
-	list_del_init(&serio->node);
-	if (serio->drv)
-		serio->drv->disconnect(serio);
-	kfree(serio);
-}
 
 /*
  * Serio driver operations
  */
 
+
 void serio_register_driver(struct serio_driver *drv)
 {
 	struct serio *serio;
+
 	down(&serio_sem);
+
 	list_add_tail(&drv->node, &serio_driver_list);
-	list_for_each_entry(serio, &serio_list, node)
-		if (!serio->drv)
-			drv->connect(serio, drv);
+
+start_over:
+	list_for_each_entry(serio, &serio_list, node) {
+		if (!serio->drv) {
+			serio_connect_port(serio, drv);
+			/*
+			 * if new child appeared then the list is changed,
+			 * we need to start over
+			 */
+			if (serio->child)
+				goto start_over;
+		}
+	}
+
 	up(&serio_sem);
 }
 
@@ -306,13 +417,19 @@
 	struct serio *serio;
 
 	down(&serio_sem);
+
 	list_del_init(&drv->node);
 
+start_over:
 	list_for_each_entry(serio, &serio_list, node) {
-		if (serio->drv == drv)
-			drv->disconnect(serio);
-		serio_find_driver(serio);
+		if (serio->drv == drv) {
+			serio_disconnect_port(serio);
+			serio_connect_port(serio, NULL);
+			/* we could've deleted some ports, restart */
+			goto start_over;
+		}
 	}
+
 	up(&serio_sem);
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:39:21 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:39:21 2004
@@ -40,6 +40,8 @@
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 
+	struct serio *parent, *child;
+
 	struct serio_driver *drv; /* Accessed from interrupt, writes must be protected by serio_lock */
 
 	struct list_head node;
@@ -68,10 +70,8 @@
 
 void serio_register_port(struct serio *serio);
 void serio_register_port_delayed(struct serio *serio);
-void __serio_register_port(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
 void serio_unregister_port_delayed(struct serio *serio);
-void __serio_unregister_port(struct serio *serio);
 void serio_register_driver(struct serio_driver *drv);
 void serio_unregister_driver(struct serio_driver *drv);
 

