Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWAQOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWAQOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAQOux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37857 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750887AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143326.967785000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:15 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 17/34] PID Virtualization return virtual process group ids
Content-Disposition: inline; filename=F4-replace-process-group-access-with-virt-access.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch we now identify where in the kernel code conceptually
a virtual process group needs to be returned to userspace. This is
simply the extension of the previous patch which only dealt with
identify the location of virtual pid/tgid/ppids returns.

As in that patch, these locations are at the kernel/user interfaces. 
and broadly they fall into 3 categories:
(a) syscall return parameter,
(b) syscall return code,
(c) through a datastructure filled in a syscall

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 fs/binfmt_elf.c |    4 ++--
 fs/proc/array.c |    2 +-
 kernel/sys.c    |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.15/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15.orig/fs/binfmt_elf.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/binfmt_elf.c	2006-01-17 08:37:04.000000000 -0500
@@ -1272,7 +1272,7 @@
 	prstatus->pr_sighold = p->blocked.sig[0];
 	prstatus->pr_pid = task_vpid(p);
 	prstatus->pr_ppid = task_vppid(p);
-	prstatus->pr_pgrp = process_group(p);
+	prstatus->pr_pgrp = virt_process_group(p);
 	prstatus->pr_sid = p->signal->session;
 	if (thread_group_leader(p)) {
 		/*
@@ -1318,7 +1318,7 @@
 
 	psinfo->pr_pid = task_vpid(p);
 	psinfo->pr_ppid = task_vppid(p);
-	psinfo->pr_pgrp = process_group(p);
+	psinfo->pr_pgrp = virt_process_group(p);
 	psinfo->pr_sid = p->signal->session;
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
Index: linux-2.6.15/fs/proc/array.c
===================================================================
--- linux-2.6.15.orig/fs/proc/array.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/proc/array.c	2006-01-17 08:37:04.000000000 -0500
@@ -374,7 +374,7 @@
 			tty_pgrp = task->signal->tty->pgrp;
 			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
 		}
-		pgid = process_group(task);
+		pgid = virt_process_group(task);
 		sid = task->signal->session;
 		cmin_flt = task->signal->cmin_flt;
 		cmaj_flt = task->signal->cmaj_flt;
Index: linux-2.6.15/kernel/sys.c
===================================================================
--- linux-2.6.15.orig/kernel/sys.c	2006-01-17 08:36:59.000000000 -0500
+++ linux-2.6.15/kernel/sys.c	2006-01-17 08:37:04.000000000 -0500
@@ -1155,7 +1155,7 @@
 asmlinkage long sys_getpgid(pid_t pid)
 {
 	if (!pid) {
-		return process_group(current);
+		return virt_process_group(current);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1167,7 +1167,7 @@
 		if (p) {
 			retval = security_task_getpgid(p);
 			if (!retval)
-				retval = process_group(p);
+				retval = virt_process_group(p);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
@@ -1179,7 +1179,7 @@
 asmlinkage long sys_getpgrp(void)
 {
 	/* SMP - assuming writes are word atomic this is fine */
-	return process_group(current);
+	return virt_process_group(current);
 }
 
 #endif
@@ -1225,7 +1225,7 @@
 	__set_special_pids(task_pid(current), task_pid(current));
 	current->signal->tty = NULL;
 	current->signal->tty_old_pgrp = 0;
-	err = process_group(current);
+	err = virt_process_group(current);
 out:
 	write_unlock_irq(&tasklist_lock);
 	up(&tty_sem);

--

