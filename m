Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVCFX3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVCFX3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVCFWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:37:17 -0500
Received: from coderock.org ([193.77.147.115]:49839 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261554AbVCFWga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:30 -0500
Subject: [patch 03/14] char/sx: replace schedule_timeout() with msleep_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:22 +0100
Message-Id: <20050306223623.286AD1ED3D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please consider applying. 

Use msleep_interruptible() instead of schedule_timeout() to
guarantee consistent timing regardless of HZ value. schedule_timeout(1) will
vary between 10 and 1 milliseconds, depending on the value of HZ (100 or 1000
respectively). For consistent behavior, msleep_interruptible() should be used.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/sx.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN drivers/char/sx.c~msleep_interruptible-drivers_char_sx drivers/char/sx.c
--- kj/drivers/char/sx.c~msleep_interruptible-drivers_char_sx	2005-03-05 16:11:01.000000000 +0100
+++ kj-domen/drivers/char/sx.c	2005-03-05 16:11:01.000000000 +0100
@@ -1515,13 +1515,9 @@ static void sx_close (void *ptr)
 	sx_reconfigure_port(port);	
 	sx_send_command (port, HS_CLOSE, 0, 0);
 
-	while (to-- && (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout (1);
-		if (signal_pending (current))
+	while (to-- && (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED))
+		if (msleep_interruptible(10))
 				break;
-	}
-	current->state = TASK_RUNNING;
 	if (sx_read_channel_byte (port, hi_hstat) != HS_IDLE_CLOSED) {
 		if (sx_send_command (port, HS_FORCE_CLOSED, -1, HS_IDLE_CLOSED) != 1) {
 			printk (KERN_ERR 
_
