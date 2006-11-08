Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754577AbWKHMlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbWKHMlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbWKHMlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:41:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:54081 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754577AbWKHMla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:41:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CB2uI5KdZvNvkYGo0/1vNbC3qsn/Xhq0dSNsD8IAUNm4/23cIIYAA1LuWrfvs0c0ypgiNI/413I9Zk+4+3yFiYnZWUMCCuE4/TyKQheDxFVNB5vEaxhkjonc7mziB5owqqWmCv8sMc0l5jyNMH824A4wIs9D/ULP/46On3VzLTM=
Date: Wed, 8 Nov 2006 21:41:21 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] input: change to GFP_KERNEL for SERIO_REGISTER_DRIVER event allocation
Message-ID: <20061108124121.GE14871@localhost>
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

This patch changes allocation from GFP_ATOMIC to GFP_KERNEL for
SERIO_REGISTER_DRIVER events to make it more robust.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/serio/serio.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

Index: work-fault-inject/drivers/input/serio/serio.c
===================================================================
--- work-fault-inject.orig/drivers/input/serio/serio.c
+++ work-fault-inject/drivers/input/serio/serio.c
@@ -191,12 +191,15 @@ static DECLARE_WAIT_QUEUE_HEAD(serio_wai
 static struct task_struct *serio_task;
 
 static int serio_queue_event(void *object, struct module *owner,
-			     enum serio_event_type event_type)
+			     enum serio_event_type event_type, gfp_t gfp_flags)
 {
 	unsigned long flags;
 	struct serio_event *event;
+	struct serio_event *new_event;
 	int err = 0;
 
+	new_event = kmalloc(sizeof(struct serio_event), gfp_flags);
+
 	spin_lock_irqsave(&serio_event_lock, flags);
 
 	/*
@@ -208,25 +211,27 @@ static int serio_queue_event(void *objec
 	 */
 	list_for_each_entry_reverse(event, &serio_event_list, node) {
 		if (event->object == object) {
-			if (event->type == event_type)
+			if (event->type == event_type) {
+				kfree(new_event);
 				goto out;
+			}
 			break;
 		}
 	}
 
-	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+	if (new_event) {
 		if (!try_module_get(owner)) {
 			err = -EINVAL;
 			printk(KERN_WARNING "serio: Can't get module reference, dropping event %d\n", event_type);
-			kfree(event);
+			kfree(new_event);
 			goto out;
 		}
 
-		event->type = event_type;
-		event->object = object;
-		event->owner = owner;
+		new_event->type = event_type;
+		new_event->object = object;
+		new_event->owner = owner;
 
-		list_add_tail(&event->node, &serio_event_list);
+		list_add_tail(&new_event->node, &serio_event_list);
 		wake_up(&serio_wait);
 	} else {
 		err = -ENOMEM;
@@ -679,12 +684,12 @@ static void serio_disconnect_port(struct
 
 void serio_rescan(struct serio *serio)
 {
-	serio_queue_event(serio, NULL, SERIO_RESCAN);
+	serio_queue_event(serio, NULL, SERIO_RESCAN, GFP_ATOMIC);
 }
 
 void serio_reconnect(struct serio *serio)
 {
-	serio_queue_event(serio, NULL, SERIO_RECONNECT);
+	serio_queue_event(serio, NULL, SERIO_RECONNECT, GFP_ATOMIC);
 }
 
 /*
@@ -694,7 +699,7 @@ void serio_reconnect(struct serio *serio
 void __serio_register_port(struct serio *serio, struct module *owner)
 {
 	serio_init_port(serio);
-	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
+	serio_queue_event(serio, owner, SERIO_REGISTER_PORT, GFP_ATOMIC);
 }
 
 /*
@@ -728,7 +733,7 @@ void serio_unregister_child_port(struct 
  */
 void __serio_unregister_port_delayed(struct serio *serio, struct module *owner)
 {
-	serio_queue_event(serio, owner, SERIO_UNREGISTER_PORT);
+	serio_queue_event(serio, owner, SERIO_UNREGISTER_PORT, GFP_ATOMIC);
 }
 
 
@@ -812,7 +817,7 @@ int __serio_register_driver(struct serio
 {
 	drv->driver.bus = &serio_bus;
 
-	return serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
+	return serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER, GFP_KERNEL);
 }
 
 void serio_unregister_driver(struct serio_driver *drv)
