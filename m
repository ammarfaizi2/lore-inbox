Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbTFLBtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbTFLBtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:49:05 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:28423 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264676AbTFLBst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:48:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553833504038@movementarian.org>
Subject: [PATCH 1/4] OProfile: Export task->tgid in the buffer
In-Reply-To: 
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 12 Jun 2003 03:02:30 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QHQ8-000228-6l*HGi3F0fBjTo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Export the task->tgid to userspace as well. This is needed
for forthcoming thread profiling stuff and should have been
done in the original patch ... oh well.

This requires an upgrade to oprofile 0.5.3. You can get it from
the website, or, for the impatient, here :

http://movementarian.org/oprofile-0.5.3.tar.gz

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-fixes/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-05-26 05:42:35.000000000 +0100
+++ linux-fixes/drivers/oprofile/buffer_sync.c	2003-06-12 02:05:19.000000000 +0100
@@ -274,12 +272,17 @@
 		add_event_entry(KERNEL_EXIT_SWITCH_CODE); 
 }
  
-static void add_user_ctx_switch(pid_t pid, unsigned long cookie)
+static void
+add_user_ctx_switch(struct task_struct const * task, unsigned long cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_SWITCH_CODE); 
-	add_event_entry(pid);
+	add_event_entry(task->pid);
 	add_event_entry(cookie);
+	/* Another code for daemon back-compat */
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(CTX_TGID_CODE);
+	add_event_entry(task->tgid);
 }
 
  
@@ -446,7 +449,7 @@
 				mm = take_tasks_mm(new);
 
 				cookie = get_exec_dcookie(mm);
-				add_user_ctx_switch(new->pid, cookie);
+				add_user_ctx_switch(new, cookie);
 			}
 		} else {
 			add_sample(mm, s, in_kernel);
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/event_buffer.h linux-fixes/drivers/oprofile/event_buffer.h
--- linux-cvs/drivers/oprofile/event_buffer.h	2003-04-02 06:06:51.000000000 +0100
+++ linux-fixes/drivers/oprofile/event_buffer.h	2003-06-12 02:04:05.000000000 +0100
@@ -31,6 +31,7 @@
 #define KERNEL_ENTER_SWITCH_CODE	4
 #define KERNEL_EXIT_SWITCH_CODE		5
 #define MODULE_LOADED_CODE		6
+#define CTX_TGID_CODE			7
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);

