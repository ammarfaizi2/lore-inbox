Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVCEWsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVCEWsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCEWsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:01 -0500
Received: from coderock.org ([193.77.147.115]:43429 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261307AbVCEWm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:42:57 -0500
Subject: [patch 02/15] block/xd: replace schedule_timeout() with msleep()/msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:45 +0100
Message-Id: <20050305224245.B52AD1F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Use msleep() or msleep_interruptible() [as appropriate]
instead of schedule_timeout() to gurantee the task delays as
expected. As a result changed the units of the timeout variable from
jiffies to msecs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/xd.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -puN drivers/block/xd.c~msleep-drivers_block_xd drivers/block/xd.c
--- kj/drivers/block/xd.c~msleep-drivers_block_xd	2005-03-05 16:09:12.000000000 +0100
+++ kj-domen/drivers/block/xd.c	2005-03-05 16:09:12.000000000 +0100
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
_
