Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHHWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHHWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHHWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:50 -0400
Received: from coderock.org ([193.77.147.115]:43395 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932301AbVHHWbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:20 -0400
Message-Id: <20050808223034.271841000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:47 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 11/16] block/xd: replace schedule_timeout() with msleep()/msleep_interruptible()
Content-Disposition: inline; filename=msleep-drivers_block_xd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep() or msleep_interruptible() [as appropriate]
instead of schedule_timeout() to gurantee the task delays as
expected. As a result changed the units of the timeout variable from
jiffies to msecs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 xd.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

Index: quilt/drivers/block/xd.c
===================================================================
--- quilt.orig/drivers/block/xd.c
+++ quilt/drivers/block/xd.c
@@ -47,6 +47,7 @@
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -62,7 +63,7 @@ static int xd[5] = { -1,-1,-1,-1, };
 
 #define XD_DONT_USE_DMA		0  /* Initial value. may be overriden using
 				      "nodma" module option */
-#define XD_INIT_DISK_DELAY	(30*HZ/1000)  /* 30 ms delay during disk initialization */
+#define XD_INIT_DISK_DELAY	(30)  /* 30 ms delay during disk initialization */
 
 /* Above may need to be increased if a problem with the 2nd drive detection
    (ST11M controller) or resetting a controller (WD) appears */
@@ -633,14 +634,12 @@ static u_char __init xd_initdrives (void
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
@@ -761,8 +760,7 @@ static void __init xd_wd_init_controller
 
 	outb(0,XD_RESET);		/* reset the controller */
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(XD_INIT_DISK_DELAY);
+	msleep(XD_INIT_DISK_DELAY);
 }
 
 static void __init xd_wd_init_drive (u_char drive)
@@ -936,8 +934,7 @@ If you need non-standard settings use th
 	xd_maxsectors = 0x01;
 	outb(0,XD_RESET);		/* reset the controller */
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(XD_INIT_DISK_DELAY);
+	msleep(XD_INIT_DISK_DELAY);
 }
 
 static void __init xd_xebec_init_drive (u_char drive)

--
