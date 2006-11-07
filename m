Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWKGMGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWKGMGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbWKGMGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:06:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:53357 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754221AbWKGMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:06:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=sFUm/nGmAgeuRvazyeu1xPA3i4oXK+SbhGcx9gOyHI1ihFREfSYCkDHQzePt2YbT+4W/bZg5X+HjFSZMdFUNjsgjUJIldjNsNJd+hhjBf27FYj7Om2W3q6JPRBMjdtFy5BLFxySSU9YkkTcGkCXTa620rlImfJG1fUeaftJbRuo=
Date: Tue, 7 Nov 2006 21:06:05 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] input: make serio_register_driver() return error code
Message-ID: <20061107120605.GA13896@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serio_register_driver() may fail under memory shortage.

When serio_register_driver() called, it queues SERIO_REGISTER_DRIVER
event into global serio_event_list, and then kseriod kernel thread
handles that event and do driver_register().

But event allocation by serio_register_driver() may fail.
Because it is GFP_ATOMIC allocation. It will cause the problem
by serio_unregister_driver() with not being registered driver
at module_exit() time 

This patch makes serio_register_driver() call driver_register()
directly instead of kseriod so that it can check whether
driver_register() is succeeded or not.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/serio/serio.c |   18 ++++--------------
 include/linux/serio.h       |    7 +------
 2 files changed, 5 insertions(+), 20 deletions(-)

Index: work-fault-inject/drivers/input/serio/serio.c
===================================================================
--- work-fault-inject.orig/drivers/input/serio/serio.c
+++ work-fault-inject/drivers/input/serio/serio.c
@@ -46,7 +46,7 @@ EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(serio_unregister_child_port);
 EXPORT_SYMBOL(__serio_unregister_port_delayed);
-EXPORT_SYMBOL(__serio_register_driver);
+EXPORT_SYMBOL(serio_register_driver);
 EXPORT_SYMBOL(serio_unregister_driver);
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
@@ -175,7 +175,6 @@ enum serio_event_type {
 	SERIO_RECONNECT,
 	SERIO_REGISTER_PORT,
 	SERIO_UNREGISTER_PORT,
-	SERIO_REGISTER_DRIVER,
 };
 
 struct serio_event {
@@ -322,10 +321,6 @@ static void serio_handle_event(void)
 				serio_find_driver(event->object);
 				break;
 
-			case SERIO_REGISTER_DRIVER:
-				serio_add_driver(event->object);
-				break;
-
 			default:
 				break;
 		}
@@ -791,22 +786,17 @@ static struct bus_type serio_bus = {
 	.remove = serio_driver_remove,
 };
 
-static void serio_add_driver(struct serio_driver *drv)
+int serio_register_driver(struct serio_driver *drv)
 {
 	int error;
 
+	drv->driver.bus = &serio_bus;
 	error = driver_register(&drv->driver);
 	if (error)
 		printk(KERN_ERR
 			"serio: driver_register() failed for %s, error: %d\n",
 			drv->driver.name, error);
-}
-
-void __serio_register_driver(struct serio_driver *drv, struct module *owner)
-{
-	drv->driver.bus = &serio_bus;
-
-	serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
+	return error;
 }
 
 void serio_unregister_driver(struct serio_driver *drv)
Index: work-fault-inject/include/linux/serio.h
===================================================================
--- work-fault-inject.orig/include/linux/serio.h
+++ work-fault-inject/include/linux/serio.h
@@ -91,12 +91,7 @@ static inline void serio_unregister_port
 	__serio_unregister_port_delayed(serio, THIS_MODULE);
 }
 
-void __serio_register_driver(struct serio_driver *drv, struct module *owner);
-static inline void serio_register_driver(struct serio_driver *drv)
-{
-	__serio_register_driver(drv, THIS_MODULE);
-}
-
+int serio_register_driver(struct serio_driver *drv);
 void serio_unregister_driver(struct serio_driver *drv);
 
 static inline int serio_write(struct serio *serio, unsigned char data)
