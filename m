Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTFQOlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFQOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:40:27 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:36613 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264761AbTFQOkB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:40:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10558616352073@movementarian.org>
Subject: [PATCH 3/3] OProfile: thread switching performance fix
In-Reply-To: <10558616341836@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 17 Jun 2003 15:53:55 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SHqO-000GjU-G7*2l04U1PCUuo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid the linear list walk of get_exec_dcookie() when we've switched to a task
using the same mm.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-fixes/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-fixes/drivers/oprofile/buffer_sync.c	2003-06-15 15:34:47.000000000 +0100
@@ -425,7 +425,7 @@
 {
 	struct mm_struct * mm = 0;
 	struct task_struct * new;
-	unsigned long cookie;
+	unsigned long cookie = 0;
 	int in_kernel = 1;
 	unsigned int i;
  
@@ -442,13 +442,15 @@
 				in_kernel = s->event;
 				add_kernel_ctx_switch(s->event);
 			} else {
+				struct mm_struct * oldmm = mm;
+
 				/* userspace context switch */
 				new = (struct task_struct *)s->event;
 
-				release_mm(mm);
+				release_mm(oldmm);
 				mm = take_tasks_mm(new);
-
-				cookie = get_exec_dcookie(mm);
+				if (mm != oldmm)
+					cookie = get_exec_dcookie(mm);
 				add_user_ctx_switch(new, cookie);
 			}
 		} else {

