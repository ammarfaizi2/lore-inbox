Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVFUGXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVFUGXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVFUGW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:22:57 -0400
Received: from coderock.org ([193.77.147.115]:2457 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261720AbVFTVyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:35 -0400
Message-Id: <20050620215131.856245000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:32 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 02/12] block/xd: replace schedule_timeout() with msleep()/msleep_interruptible()
Content-Disposition: inline; filename=msleep-drivers_block_xd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Any comments would be appreciated. 

Use msleep() or msleep_interruptible() [as appropriate]
instead of schedule_timeout() to gurantee the task delays as
expected. As a result changed the units of the timeout variable from
jiffies to msecs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 xd.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

Index: quilt/drivers/block/xd.c
===================================================================
--- quilt.orig/drivers/block/xd.c
+++ quilt/drivers/block/xd.c
@@ -62,7 +62,7 @@ static int xd[5] = { -1,-1,-1,-1, };
 
 #define XD_DONT_USE_DMA		0  /* Initial value. may be overriden using
 				      "nodma" module option */
-#define XD_INIT_DISK_DELAY	(30*HZ/1000)  /* 30 ms delay during disk initialization */
+#define XD_INIT_DISK_DELAY	(30)  /* 30 ms delay during disk initialization */
 
 /* Above may need to be increased if a problem with the 2nd drive detection
    (ST11M controller) or resetting a controller (WD) appears */
@@ -633,14 +633,12 @@ static u_char __init xd_initdrives (void
 	for (i = 0; i < XD_MAXDRIVES; i++) {
 		xd_build(cmdblk,CMD_TESTREADY,i,0,0,0,0,0);
 		if (!xd_command(cmdblk,PIO_MODE,NULL,NULL,NULL,XD_TIMEOUT*8)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(XD_INIT_DISK_DELAY);
+			msleep_interruptible(XD_INIT_DISK_DELAY);
 
 			init_drive(count);
 			count++;
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(XD_INIT_DISK_DELAY);
+			msleep_interruptible(XD_INIT_DISK_DELAY);
 		}
 	}
 	return (count);
@@ -761,8 +759,7 @@ static void __init xd_wd_init_controller
 
 	outb(0,XD_RESET);		/* reset the controller */
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(XD_INIT_DISK_DELAY);
+	msleep(XD_INIT_DISK_DELAY);
 }
 
 static void __init xd_wd_init_drive (u_char drive)
@@ -936,8 +933,7 @@ If you need non-standard settings use th
 	xd_maxsectors = 0x01;
 	outb(0,XD_RESET);		/* reset the controller */
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(XD_INIT_DISK_DELAY);
+	msleep(XD_INIT_DISK_DELAY);
 }
 
 static void __init xd_xebec_init_drive (u_char drive)

--
