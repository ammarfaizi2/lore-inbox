Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264945AbVBEG52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264945AbVBEG52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbVBEG51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:57:27 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:404 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263567AbVBEG4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:56:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Date: Sat, 5 Feb 2005 01:56:07 -0500
User-Agent: KMail/1.7.2
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org,
       vojtech@ucw.cz
References: <a71293c20502031443764fb4e5@mail.gmail.com> <d120d500050204061735404d50@mail.gmail.com> <20050204144503.GC1661@ucw.cz>
In-Reply-To: <20050204144503.GC1661@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502050156.09237.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 09:45, Vojtech Pavlik wrote:
> On Fri, Feb 04, 2005 at 09:17:33AM -0500, Dmitry Torokhov wrote:
>  
> > It is still a problem if driver is registered after the port has been
> > detected wich quite often is the case as many people have psmouse as a
> > module.
> > 
> > I wonder if we should make driver registration asynchronous too.
> 
> Probably yes.
> 
> > I
> > don't forsee any issues providing that I bump up module's reference
> > count while driver structure is "in flight", do you?
>  
> No, looks OK to me, too.
> 

Ok, what about the following patch then?

-- 
Dmitry


===================================================================


ChangeSet@1.2005, 2005-02-05 01:48:45-05:00, dtor_core@ameritech.net
  Input: make serio drivers register asynchronously. This should
         speed up boot process as some drivers take a long time
         probing for supported devices.
  
         Also change __inline__ to inline in serio.h
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/serio.c |   65 ++++++++++++++++++++++++--------------------
 include/linux/serio.h       |   25 ++++++++++------
 2 files changed, 51 insertions(+), 39 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2005-02-05 01:53:56 -05:00
+++ b/drivers/input/serio/serio.c	2005-02-05 01:53:56 -05:00
@@ -44,7 +44,7 @@
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(__serio_unregister_port_delayed);
-EXPORT_SYMBOL(serio_register_driver);
+EXPORT_SYMBOL(__serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
@@ -120,18 +120,19 @@
  * Serio event processing.
  */
 
-struct serio_event {
-	int type;
-	struct serio *serio;
-	struct module *owner;
-	struct list_head node;
-};
-
 enum serio_event_type {
 	SERIO_RESCAN,
 	SERIO_RECONNECT,
 	SERIO_REGISTER_PORT,
 	SERIO_UNREGISTER_PORT,
+	SERIO_REGISTER_DRIVER,
+};
+
+struct serio_event {
+	enum serio_event_type type;
+	void *object;
+	struct module *owner;
+	struct list_head node;
 };
 
 static DEFINE_SPINLOCK(serio_event_lock);	/* protects serio_event_list */
@@ -140,7 +141,7 @@
 static DECLARE_COMPLETION(serio_exited);
 static int serio_pid;
 
-static void serio_queue_event(struct serio *serio, struct module *owner,
+static void serio_queue_event(void *object, struct module *owner,
 			      enum serio_event_type event_type)
 {
 	unsigned long flags;
@@ -156,7 +157,7 @@
 	 * we need to preseve sequence of distinct events.
  	 */
 	list_for_each_entry_reverse(event, &serio_event_list, node) {
-		if (event->serio == serio) {
+		if (event->object == object) {
 			if (event->type == event_type)
 				goto out;
 			break;
@@ -170,7 +171,7 @@
 		}
 
 		event->type = event_type;
-		event->serio = serio;
+		event->object = object;
 		event->owner = owner;
 
 		list_add_tail(&event->node, &serio_event_list);
@@ -198,7 +199,7 @@
 
 	list_for_each_safe(node, next, &serio_event_list) {
 		e = list_entry(node, struct serio_event, node);
-		if (event->serio == e->serio) {
+		if (event->object == e->object) {
 			/*
 			 * If this event is of different type we should not
 			 * look further - we only suppress duplicate events
@@ -241,6 +242,7 @@
 static void serio_handle_events(void)
 {
 	struct serio_event *event;
+	struct serio_driver *serio_drv;
 
 	down(&serio_sem);
 
@@ -248,21 +250,26 @@
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT:
-				serio_add_port(event->serio);
+				serio_add_port(event->object);
 				break;
 
 			case SERIO_UNREGISTER_PORT:
-				serio_disconnect_port(event->serio);
-				serio_destroy_port(event->serio);
+				serio_disconnect_port(event->object);
+				serio_destroy_port(event->object);
 				break;
 
 			case SERIO_RECONNECT:
-				serio_reconnect_port(event->serio);
+				serio_reconnect_port(event->object);
 				break;
 
 			case SERIO_RESCAN:
-				serio_disconnect_port(event->serio);
-				serio_find_driver(event->serio);
+				serio_disconnect_port(event->object);
+				serio_find_driver(event->object);
+				break;
+
+			case SERIO_REGISTER_DRIVER:
+				serio_drv = event->object;
+				driver_register(&serio_drv->driver);
 				break;
 
 			default:
@@ -289,7 +296,7 @@
 
 	list_for_each_safe(node, next, &serio_event_list) {
 		event = list_entry(node, struct serio_event, node);
-		if (event->serio == serio) {
+		if (event->object == serio) {
 			list_del_init(node);
 			serio_free_event(event);
 		}
@@ -309,20 +316,23 @@
 static struct serio *serio_get_pending_child(struct serio *parent)
 {
 	struct serio_event *event;
-	struct serio *serio = NULL;
+	struct serio *serio, *child = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
 	list_for_each_entry(event, &serio_event_list, node) {
-		if (event->type == SERIO_REGISTER_PORT && event->serio->parent == parent) {
-			serio = event->serio;
-			break;
+		if (event->type == SERIO_REGISTER_PORT) {
+			serio = event->object;
+			if (serio->parent == parent) {
+				child = serio;
+				break;
+			}
 		}
 	}
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
-	return serio;
+	return child;
 }
 
 static int serio_thread(void *nothing)
@@ -672,16 +682,13 @@
 	return 0;
 }
 
-void serio_register_driver(struct serio_driver *drv)
+void __serio_register_driver(struct serio_driver *drv, struct module *owner)
 {
-	down(&serio_sem);
-
 	drv->driver.bus = &serio_bus;
 	drv->driver.probe = serio_driver_probe;
 	drv->driver.remove = serio_driver_remove;
-	driver_register(&drv->driver);
 
-	up(&serio_sem);
+	serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
 }
 
 void serio_unregister_driver(struct serio_driver *drv)
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2005-02-05 01:53:56 -05:00
+++ b/include/linux/serio.h	2005-02-05 01:53:56 -05:00
@@ -95,10 +95,15 @@
 	__serio_unregister_port_delayed(serio, THIS_MODULE);
 }
 
-void serio_register_driver(struct serio_driver *drv);
+void __serio_register_driver(struct serio_driver *drv, struct module *owner);
+static inline void serio_register_driver(struct serio_driver *drv)
+{
+	__serio_register_driver(drv, THIS_MODULE);
+}
+
 void serio_unregister_driver(struct serio_driver *drv);
 
-static __inline__ int serio_write(struct serio *serio, unsigned char data)
+static inline int serio_write(struct serio *serio, unsigned char data)
 {
 	if (serio->write)
 		return serio->write(serio, data);
@@ -106,13 +111,13 @@
 		return -1;
 }
 
-static __inline__ void serio_drv_write_wakeup(struct serio *serio)
+static inline void serio_drv_write_wakeup(struct serio *serio)
 {
 	if (serio->drv && serio->drv->write_wakeup)
 		serio->drv->write_wakeup(serio);
 }
 
-static __inline__ void serio_cleanup(struct serio *serio)
+static inline void serio_cleanup(struct serio *serio)
 {
 	if (serio->drv && serio->drv->cleanup)
 		serio->drv->cleanup(serio);
@@ -122,12 +127,12 @@
  * Use the following fucntions to manipulate serio's per-port
  * driver-specific data.
  */
-static __inline__ void *serio_get_drvdata(struct serio *serio)
+static inline void *serio_get_drvdata(struct serio *serio)
 {
 	return dev_get_drvdata(&serio->dev);
 }
 
-static __inline__ void serio_set_drvdata(struct serio *serio, void *data)
+static inline void serio_set_drvdata(struct serio *serio, void *data)
 {
 	dev_set_drvdata(&serio->dev, data);
 }
@@ -136,12 +141,12 @@
  * Use the following fucntions to protect critical sections in
  * driver code from port's interrupt handler
  */
-static __inline__ void serio_pause_rx(struct serio *serio)
+static inline void serio_pause_rx(struct serio *serio)
 {
 	spin_lock_irq(&serio->lock);
 }
 
-static __inline__ void serio_continue_rx(struct serio *serio)
+static inline void serio_continue_rx(struct serio *serio)
 {
 	spin_unlock_irq(&serio->lock);
 }
@@ -149,12 +154,12 @@
 /*
  * Use the following fucntions to pin serio's driver in process context
  */
-static __inline__ int serio_pin_driver(struct serio *serio)
+static inline int serio_pin_driver(struct serio *serio)
 {
 	return down_interruptible(&serio->drv_sem);
 }
 
-static __inline__ void serio_unpin_driver(struct serio *serio)
+static inline void serio_unpin_driver(struct serio *serio)
 {
 	up(&serio->drv_sem);
 }
