Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWJKLSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWJKLSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWJKLSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:18:17 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:9102 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751233AbWJKLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:18:16 -0400
Date: Wed, 11 Oct 2006 15:19:43 +0400
Message-Id: <200610111119.k9BBJhls004763@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: OpenVZ Developer List <devel@openvz.org>
Subject: [PATCH] block layer: elv_iosched_show should get elv_list_lock
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Wed, 11 Oct 2006 15:18:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elv_iosched_show function iterates other elv_list,
hence elv_list_lock should be got.

Also the question is: in elv_iosched_show, elv_iosched_store
q->elevator->elevator_type construction is used without locking q->queue_lock.
Is it expected?..

Signed-off-by: Vasily Tarasov <vtaras@openvz.org>

--

--- linux-2.6.18/block/elevator.c.orig	2006-10-11 11:00:34.000000000 +0400
+++ linux-2.6.18/block/elevator.c	2006-10-11 15:08:20.000000000 +0400
@@ -892,7 +892,7 @@ ssize_t elv_iosched_show(request_queue_t
 	struct list_head *entry;
 	int len = 0;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&elv_list_lock);
 	list_for_each(entry, &elv_list) {
 		struct elevator_type *__e;
 
@@ -902,7 +902,7 @@ ssize_t elv_iosched_show(request_queue_t
 		else
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&elv_list_lock);
 
 	len += sprintf(len+name, "\n");
 	return len;
