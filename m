Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVGZNUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGZNUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGZNUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:20:09 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:57815 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261767AbVGZNTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:19:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=U7FhlTskf4XPwoetCbunokO7vL6qTiLtSwj0N0sDDi3X8mvux65NsVRh9jl0iTrdec4YqLRd+BdolMwlGDD8IY+TtTEsWDpiQVTRMsQLpcuuW4pJ58l+Y2GlcDRIxbXub9RR9ZJEdLLS+Eo6UCkZskH7CdYhmUarcQU8WC0cZbY=
Date: Tue, 26 Jul 2005 22:19:28 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6-block:master] block: fix try_module_get race in elevator_find
Message-ID: <20050726131928.GB23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patch removes try_module_get race in elevator_find.
try_module_get should always be called with the spinlock protecting
what the module init/cleanup routines register/unregister to held.  In
the case of elevators, we should be holding elv_list to avoid it going
away between spin_unlock_irq and try_module_get.

 This currently doesn't cause any problem as elevators are never
unloaded, but the fix is simple and it's always nice to be correct.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-07-25 23:16:11.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-07-25 23:20:30.000000000 +0900
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
@@ -554,10 +559,9 @@ void elv_unregister_queue(struct request
 
 int elv_register(struct elevator_type *e)
 {
+	spin_lock_irq(&elv_list_lock);
 	if (elevator_find(e->elevator_name))
 		BUG();
-
-	spin_lock_irq(&elv_list_lock);
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
 
