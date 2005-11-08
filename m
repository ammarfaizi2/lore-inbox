Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965325AbVKHAEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325AbVKHAEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbVKHAEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:04:39 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:50705 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965325AbVKHAEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:04:38 -0500
Date: Mon, 7 Nov 2005 16:04:34 -0800
Message-Id: <200511080004.jA804Y0Y020472@zach-dev.vmware.com>
Subject: [PATCH 1/1] Elevator init fixes
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@hotmail.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 00:04:37.0450 (UTC) FILETIME=[01FA42A0:01C5E3F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a panic in the elevator code, backtrace :

Unable to handle kernel NULL pointer dereference at virtual address 00000060
..
EIP is at elevator_put+0x0/0x30 (null elevator_type passed)
..
elevator_init+0x38
blk_init_queu_node+0xc9
floppy_init+0xdb
do_initcalls+0x23
init+0x10a
init+0x0

Clearly if the kmalloc here fails, e->elevator_type is not yet set; this
appears to be the correct fix, but I think I probably hit the second case
due to a race condition.  Someone more familiar with the elevator code
should look at this more closely until I can determine if I can reproduce.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.14-zach-work/drivers/block/elevator.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/block/elevator.c	2005-11-07 09:41:11.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/block/elevator.c	2005-11-07 15:57:10.000000000 -0800
@@ -190,14 +190,14 @@ int elevator_init(request_queue_t *q, ch
 
 	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
 	if (!eq) {
-		elevator_put(e->elevator_type);
+		elevator_put(e);
 		return -ENOMEM;
 	}
 
 	ret = elevator_attach(q, e, eq);
 	if (ret) {
 		kfree(eq);
-		elevator_put(e->elevator_type);
+		elevator_put(e);
 	}
 
 	return ret;
