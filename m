Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVAKKN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVAKKN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVAKKN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:13:59 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:48575 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262675AbVAKKN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:13:56 -0500
From: pmeda@akamai.com
Date: Tue, 11 Jan 2005 02:17:05 -0800
Message-Id: <200501111017.CAA00344@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [patch] easily tweakable comm length
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change still keeps the comm length at 16, but allows easier patching for
local modifications, and also introduces a macro to use instead of magic 16,
where sizeof(comm) is not preferable to use.
Not able to use killall, pidof etc. effectively, when long process names are
used for scripts. Just changing the command length from 16 to 32 breaks a.out
coredump logic. Deamonise and get_task_comm helped in other places in 2.6.10.

Signed-off-by: Prasanna Meda <pmeda@akamai.com>

--- a/arch/sparc64/kernel/binfmt_aout32.c	Tue Jan 11 09:04:24 2005
+++ b/arch/sparc64/kernel/binfmt_aout32.c	Tue Jan 11 09:04:59 2005
@@ -95,7 +95,7 @@
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
-       	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
+       	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));
 	dump.signal = signr;
 	dump_thread(regs, &dump);
 
--- a/fs/binfmt_aout.c	Tue Jan 11 09:11:56 2005
+++ b/fs/binfmt_aout.c	Tue Jan 11 09:14:32 2005
@@ -112,7 +112,7 @@
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
-       	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
+       	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));
 #ifndef __sparc__
 	dump.u_ar0 = (void *)(((unsigned long)(&dump.regs)) - ((unsigned long)(&dump)));
 #endif
--- a/include/linux/sched.h	Tue Jan 11 09:23:56 2005
+++ b/include/linux/sched.h	Tue Jan 11 09:27:05 2005
@@ -121,6 +121,9 @@
 #define set_current_state(state_value)		\
 	set_mb(current->state, (state_value))
 
+/* Task command name length */
+#define TASK_COMM_LEN 16
+
 /*
  * Scheduling policies
  */
@@ -601,7 +604,7 @@
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
 	unsigned short used_math;
-	char comm[16];
+	char comm[TASK_COMM_LEN];
 /* file system info */
 	int link_count, total_link_count;
 /* ipc stuff */
