Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTEGECl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTEGECl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:02:41 -0400
Received: from [203.145.184.221] ([203.145.184.221]:56333 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262810AbTEGECj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:02:39 -0400
Subject: [PATCH 2.5.69] mod_timer fix for floppy98.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 May 2003 09:50:29 +0530
Message-Id: <1052281229.1189.4.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my previous patch against 2.5.68, missed out killing del_timer.
Thanks to Christian Heller for pointing it out.

vinay

floppy98.c: Trivial {del,add}_timer to mod_timer conversions.

--- linux-2.5.69/drivers/block/floppy98.c	2003-05-05 09:56:04.000000000 +0530
+++ linux-2.5.69-nvk/drivers/block/floppy98.c	2003-05-07 09:43:22.000000000 +0530
@@ -702,15 +702,16 @@
 
 static void reschedule_timeout(int drive, const char *message, int marg)
 {
+	long delay;
+
 	if (drive == current_reqD)
 		drive = current_drive;
-	del_timer(&fd_timeout);
 	if (drive < 0 || drive > N_DRIVE) {
-		fd_timeout.expires = jiffies + 20UL*HZ;
+		delay = jiffies + 20UL*HZ;
 		drive=0;
 	} else
-		fd_timeout.expires = jiffies + UDP->timeout;
-	add_timer(&fd_timeout);
+		delay = jiffies + UDP->timeout;
+	mod_timer(&fd_timeout, delay);
 	if (UDP->flags & FD_DEBUG){
 		DPRINT("reschedule timeout ");
 		printk(message, marg);



