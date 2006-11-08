Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754572AbWKHMif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbWKHMif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbWKHMie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:38:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:31280 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754572AbWKHMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:38:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aOTpVBRwt2muymBVkBPWOXSJwdYiec8+2tu5doJtCJx1dmzZOnDE6c6VOAEJ7KoQJq22Fv+MLEX/ZfTt21JIupNoBdWbtbpciGI18Q8jz4lGVDQgU+JxQXjhc6t8CeOrV8SXY9MhVVSHVqTCI5JfDLn5d9VmKu0CW6oVZQ9F9eI=
Date: Wed, 8 Nov 2006 21:38:22 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] input: make serio_register_driver() return error
Message-ID: <20061108123822.GB14871@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com> <20061108123636.GA14871@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108123636.GA14871@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes serio_register_driver() return error
when serio_event allocation is failed or unable to get module reference.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/serio/serio.c |   12 ++++++++----
 include/linux/serio.h       |    6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

Index: work-fault-inject/drivers/input/serio/serio.c
===================================================================
--- work-fault-inject.orig/drivers/input/serio/serio.c
+++ work-fault-inject/drivers/input/serio/serio.c
@@ -190,11 +190,12 @@ static LIST_HEAD(serio_event_list);
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static struct task_struct *serio_task;
 
-static void serio_queue_event(void *object, struct module *owner,
-			      enum serio_event_type event_type)
+static int serio_queue_event(void *object, struct module *owner,
+			     enum serio_event_type event_type)
 {
 	unsigned long flags;
 	struct serio_event *event;
+	int err = 0;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
@@ -215,6 +216,7 @@ static void serio_queue_event(void *obje
 
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
 		if (!try_module_get(owner)) {
+			err = -EINVAL;
 			printk(KERN_WARNING "serio: Can't get module reference, dropping event %d\n", event_type);
 			kfree(event);
 			goto out;
@@ -227,10 +229,12 @@ static void serio_queue_event(void *obje
 		list_add_tail(&event->node, &serio_event_list);
 		wake_up(&serio_wait);
 	} else {
+		err = -ENOMEM;
 		printk(KERN_ERR "serio: Not enough memory to queue event %d\n", event_type);
 	}
 out:
 	spin_unlock_irqrestore(&serio_event_lock, flags);
+	return err;
 }
 
 static void serio_free_event(struct serio_event *event)
@@ -802,11 +806,11 @@ static void serio_add_driver(struct seri
 			drv->driver.name, error);
 }
 
-void __serio_register_driver(struct serio_driver *drv, struct module *owner)
+int __serio_register_driver(struct serio_driver *drv, struct module *owner)
 {
 	drv->driver.bus = &serio_bus;
 
-	serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
+	return serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
 }
 
 void serio_unregister_driver(struct serio_driver *drv)
Index: work-fault-inject/include/linux/serio.h
===================================================================
--- work-fault-inject.orig/include/linux/serio.h
+++ work-fault-inject/include/linux/serio.h
@@ -91,10 +91,10 @@ static inline void serio_unregister_port
 	__serio_unregister_port_delayed(serio, THIS_MODULE);
 }
 
-void __serio_register_driver(struct serio_driver *drv, struct module *owner);
-static inline void serio_register_driver(struct serio_driver *drv)
+int __serio_register_driver(struct serio_driver *drv, struct module *owner);
+static inline int serio_register_driver(struct serio_driver *drv)
 {
-	__serio_register_driver(drv, THIS_MODULE);
+	return __serio_register_driver(drv, THIS_MODULE);
 }
 
 void serio_unregister_driver(struct serio_driver *drv);
