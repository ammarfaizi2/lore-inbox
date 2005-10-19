Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVJSMUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVJSMUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVJSMUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:20:49 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:38764 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750842AbVJSMUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:20:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lV49YFlD+pzp7Wn8sOCt3GTu2qwsDMQ8MO+sbRr/gwSkypKUqXVuPM50De250fh6Y1rwPzsQ/ikQckp4gF5Cfd9y0PS8iTRY+Ufd3FH+hxN5/+LNRyZGGLqOYYMnq07kZ1ZK4hf0qTxLXAP/IdilIEw2pPFj2yN41IfxFvpp7OM=
Date: Wed, 19 Oct 2005 21:20:39 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6-lbock:master] block: fix try_module_get race in elevator_find
Message-ID: <20051019122039.GA27695@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patch removes try_module_get race in elevator_find.
try_module_get should always be called with the spinlock protecting
what the module init/cleanup routines register/unregister to held.  In
the case of elevators, we should be holding elv_list to avoid it going
away between spin_unlock_irq and try_module_get.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-10-16 22:11:57.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-10-16 22:19:49.000000000 +0900
@@ -97,7 +97,6 @@ static struct elevator_type *elevator_fi
 	struct elevator_type *e = NULL;
 	struct list_head *entry;
 
-	spin_lock_irq(&elv_list_lock);
 	list_for_each(entry, &elv_list) {
 		struct elevator_type *__e;
 
@@ -108,7 +107,6 @@ static struct elevator_type *elevator_fi
 			break;
 		}
 	}
-	spin_unlock_irq(&elv_list_lock);
 
 	return e;
 }
@@ -120,12 +118,15 @@ static void elevator_put(struct elevator
 
 static struct elevator_type *elevator_get(const char *name)
 {
-	struct elevator_type *e = elevator_find(name);
+	struct elevator_type *e;
 
-	if (!e)
-		return NULL;
-	if (!try_module_get(e->elevator_owner))
-		return NULL;
+	spin_lock_irq(&elv_list_lock);
+
+	e = elevator_find(name);
+	if (e && !try_module_get(e->elevator_owner))
+		e = NULL;
+
+	spin_unlock_irq(&elv_list_lock);
 
 	return e;
 }
@@ -153,11 +154,15 @@ static char chosen_elevator[16];
 
 static void elevator_setup_default(void)
 {
+	struct elevator_type *e;
+
 	/*
 	 * check if default is set and exists
 	 */
-	if (chosen_elevator[0] && elevator_find(chosen_elevator))
+	if (chosen_elevator[0] && (e = elevator_get(chosen_elevator))) {
+		elevator_put(e);
 		return;
+	}
 
 #if defined(CONFIG_IOSCHED_AS)
 	strcpy(chosen_elevator, "anticipatory");
@@ -555,10 +560,9 @@ void elv_unregister_queue(struct request
 
 int elv_register(struct elevator_type *e)
 {
+	spin_lock_irq(&elv_list_lock);
 	if (elevator_find(e->elevator_name))
 		BUG();
-
-	spin_lock_irq(&elv_list_lock);
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
 
