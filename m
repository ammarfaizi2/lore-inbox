Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTECXbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTECXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:31:48 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:58635 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263467AbTECXbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:44 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054461823@movementarian.org>
Subject: [PATCH 3/8] OProfile update
In-Reply-To: <1052005446607@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:06 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.3 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fm-000JiC-VV*1IhsQELY7cw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clear up the code around  start_sem so it's more obvious, and remove a pointless
down/up pair on buffer_sem (shutdown is already synchronised in sync_stop()).

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.c linux-me/drivers/oprofile/oprof.c
--- linux/drivers/oprofile/oprof.c	2003-04-30 19:58:07.000000000 +0100
+++ linux-me/drivers/oprofile/oprof.c	2003-04-29 01:16:00.000000000 +0100
@@ -28,6 +28,8 @@
 {
 	int err;
  
+	down(&start_sem);
+
 	if ((err = alloc_cpu_buffers()))
 		goto out;
 
@@ -45,7 +47,6 @@
 	if ((err = sync_start()))
 		goto out3;
 
-	down(&start_sem);
 	is_setup = 1;
 	up(&start_sem);
 	return 0;
@@ -58,6 +59,7 @@
 out1:
 	free_cpu_buffers();
 out:
+	up(&start_sem);
 	return err;
 }
 
@@ -106,22 +108,20 @@
 
 void oprofile_shutdown(void)
 {
+	down(&start_sem);
 	sync_stop();
 	if (oprofile_ops->shutdown)
 		oprofile_ops->shutdown(); 
-	/* down() is also necessary to synchronise all pending events
-	 * before freeing */
-	down(&buffer_sem);
 	is_setup = 0;
-	up(&buffer_sem);
 	free_event_buffer();
 	free_cpu_buffers();
+	up(&start_sem);
 }
 
- 
+
 extern void timer_init(struct oprofile_operations ** ops);
 
- 
+
 static int __init oprofile_init(void)
 {
 	int err;

