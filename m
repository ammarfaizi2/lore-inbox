Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754037AbWKQGhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbWKQGhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbWKQGhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:37:38 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:48445 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1754037AbWKQGhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:37:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnoUALrmXEVKhRUUVWdsb2JhbACBSYRAhjcBKw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] input: make serio_register_driver() return error code
Date: Fri, 17 Nov 2006 01:37:34 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com> <20061108123636.GA14871@localhost>
In-Reply-To: <20061108123636.GA14871@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170137.35955.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 07:36, Akinobu Mita wrote:
> 
> 2) driver_register() failure by kseriod.
> 
>    This failure cannot be checked by serio_register_driver().
>    But it is necessary to prevent serio_unregister_driver() from
>    trying to call driver_unregister() with not registered driver
>    by adding flag to serio driver indicating whether registration is
>    complete.
> 

Hi Akinobu,

I think I found a way to handle all errors when registering serio driver.
What do you think about the patch below?

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/serio.c |  109 ++++++++++++++++++++++++++++++--------------
 include/linux/serio.h       |    7 --
 2 files changed, 76 insertions(+), 40 deletions(-)

Index: work/drivers/input/serio/serio.c
===================================================================
--- work.orig/drivers/input/serio/serio.c
+++ work/drivers/input/serio/serio.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(serio_unregister_child_port);
-EXPORT_SYMBOL(__serio_register_driver);
+EXPORT_SYMBOL(serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
@@ -61,10 +61,10 @@ static LIST_HEAD(serio_list);
 
 static struct bus_type serio_bus;
 
-static void serio_add_driver(struct serio_driver *drv);
 static void serio_add_port(struct serio *serio);
 static void serio_reconnect_port(struct serio *serio);
 static void serio_disconnect_port(struct serio *serio);
+static void serio_attach_driver(struct serio_driver *drv);
 
 static int serio_connect_driver(struct serio *serio, struct serio_driver *drv)
 {
@@ -168,10 +168,10 @@ static void serio_find_driver(struct ser
  */
 
 enum serio_event_type {
-	SERIO_RESCAN,
-	SERIO_RECONNECT,
+	SERIO_RESCAN_PORT,
+	SERIO_RECONNECT_PORT,
 	SERIO_REGISTER_PORT,
-	SERIO_REGISTER_DRIVER,
+	SERIO_ATTACH_DRIVER,
 };
 
 struct serio_event {
@@ -186,11 +186,12 @@ static LIST_HEAD(serio_event_list);
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static struct task_struct *serio_task;
 
-static void serio_queue_event(void *object, struct module *owner,
-			      enum serio_event_type event_type)
+static int serio_queue_event(void *object, struct module *owner,
+			     enum serio_event_type event_type)
 {
 	unsigned long flags;
 	struct serio_event *event;
+	int retval = 0;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
@@ -209,24 +210,34 @@ static void serio_queue_event(void *obje
 		}
 	}
 
-	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
-		if (!try_module_get(owner)) {
-			printk(KERN_WARNING "serio: Can't get module reference, dropping event %d\n", event_type);
-			kfree(event);
-			goto out;
-		}
-
-		event->type = event_type;
-		event->object = object;
-		event->owner = owner;
+	event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC);
+	if (!event) {
+		printk(KERN_ERR
+			"serio: Not enough memory to queue event %d\n",
+			event_type);
+		retval = -ENOMEM;
+		goto out;
+	}
 
-		list_add_tail(&event->node, &serio_event_list);
-		wake_up(&serio_wait);
-	} else {
-		printk(KERN_ERR "serio: Not enough memory to queue event %d\n", event_type);
+	if (!try_module_get(owner)) {
+		printk(KERN_WARNING
+			"serio: Can't get module reference, dropping event %d\n",
+			event_type);
+		kfree(event);
+		retval = -EINVAL;
+		goto out;
 	}
+
+	event->type = event_type;
+	event->object = object;
+	event->owner = owner;
+
+	list_add_tail(&event->node, &serio_event_list);
+	wake_up(&serio_wait);
+
 out:
 	spin_unlock_irqrestore(&serio_event_lock, flags);
+	return retval;
 }
 
 static void serio_free_event(struct serio_event *event)
@@ -304,17 +315,17 @@ static void serio_handle_event(void)
 				serio_add_port(event->object);
 				break;
 
-			case SERIO_RECONNECT:
+			case SERIO_RECONNECT_PORT:
 				serio_reconnect_port(event->object);
 				break;
 
-			case SERIO_RESCAN:
+			case SERIO_RESCAN_PORT:
 				serio_disconnect_port(event->object);
 				serio_find_driver(event->object);
 				break;
 
-			case SERIO_REGISTER_DRIVER:
-				serio_add_driver(event->object);
+			case SERIO_ATTACH_DRIVER:
+				serio_attach_driver(event->object);
 				break;
 
 			default:
@@ -666,12 +677,12 @@ static void serio_disconnect_port(struct
 
 void serio_rescan(struct serio *serio)
 {
-	serio_queue_event(serio, NULL, SERIO_RESCAN);
+	serio_queue_event(serio, NULL, SERIO_RESCAN_PORT);
 }
 
 void serio_reconnect(struct serio *serio)
 {
-	serio_queue_event(serio, NULL, SERIO_RECONNECT);
+	serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
 }
 
 /*
@@ -766,22 +777,52 @@ static int serio_driver_remove(struct de
 	return 0;
 }
 
-static void serio_add_driver(struct serio_driver *drv)
+static void serio_attach_driver(struct serio_driver *drv)
 {
 	int error;
 
-	error = driver_register(&drv->driver);
+	error = driver_attach(&drv->driver);
 	if (error)
-		printk(KERN_ERR
-			"serio: driver_register() failed for %s, error: %d\n",
-			drv->driver.name, error);
+		printk(KERN_WARNING
+			"serio: driver_attach() failed with error %d\n",
+			error);
 }
 
-void __serio_register_driver(struct serio_driver *drv, struct module *owner)
+int serio_register_driver(struct serio_driver *drv)
 {
+	int manual_bind = drv->manual_bind;
+	int error;
+
 	drv->driver.bus = &serio_bus;
 
-	serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
+	/*
+	 * Temporarily disable automatic binding because probing
+	 * takes long time and we are better off doing it in kseriod
+	 */
+	drv->manual_bind = 1;
+
+	error = driver_register(&drv->driver);
+	if (error) {
+		printk(KERN_ERR
+			"serio: driver_register() failed for %s, error: %d\n",
+			drv->driver.name, error);
+		return error;
+	}
+
+	/*
+	 * Restore original bind mode and let kseriod bind the
+	 * driver to free ports
+	 */
+	if (!manual_bind) {
+		drv->manual_bind = 0;
+		error = serio_queue_event(drv, NULL, SERIO_ATTACH_DRIVER);
+		if (error) {
+			driver_unregister(&drv->driver);
+			return error;
+		}
+	}
+
+	return 0;
 }
 
 void serio_unregister_driver(struct serio_driver *drv)
Index: work/include/linux/serio.h
===================================================================
--- work.orig/include/linux/serio.h
+++ work/include/linux/serio.h
@@ -86,12 +86,7 @@ static inline void serio_register_port(s
 void serio_unregister_port(struct serio *serio);
 void serio_unregister_child_port(struct serio *serio);
 
-void __serio_register_driver(struct serio_driver *drv, struct module *owner);
-static inline void serio_register_driver(struct serio_driver *drv)
-{
-	__serio_register_driver(drv, THIS_MODULE);
-}
-
+int serio_register_driver(struct serio_driver *drv);
 void serio_unregister_driver(struct serio_driver *drv);
 
 static inline int serio_write(struct serio *serio, unsigned char data)
