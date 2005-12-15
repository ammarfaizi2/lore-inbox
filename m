Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVLOOi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVLOOi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLOOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:38:16 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:30618 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750717AbVLOOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:11 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143802.266823000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 04/21] PID Virtualization: return virtual process group ids
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
--

 fs/binfmt_elf.c |    4 ++--
 fs/proc/array.c |    2 +-
 kernel/sys.c    |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_elf.c	2005-11-30 18:08:02.000000000 -0500
+++ linux-2.6.15-rc1/fs/binfmt_elf.c	2005-11-30 18:08:03.000000000 -0500
@@ -1272,7 +1272,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_sighold = p->blocked.sig[0];
 	prstatus->pr_pid = task_vpid(p);
 	prstatus->pr_ppid = task_vppid(p);
-	prstatus->pr_pgrp = process_group(p);
+	prstatus->pr_pgrp = virt_process_group(p);
 	prstatus->pr_sid = p->signal->session;
 	if (thread_group_leader(p)) {
 		/*
@@ -1318,7 +1318,7 @@ static int fill_psinfo(struct elf_prpsin
 
 	psinfo->pr_pid = task_vpid(p);
 	psinfo->pr_ppid = task_vppid(p);
-	psinfo->pr_pgrp = process_group(p);
+	psinfo->pr_pgrp = virt_process_group(p);
 	psinfo->pr_sid = p->signal->session;
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c	2005-11-30 18:08:02.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/array.c	2005-11-30 18:08:03.000000000 -0500
@@ -374,7 +374,7 @@ static int do_task_stat(struct task_stru
 			tty_pgrp = task->signal->tty->pgrp;
 			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
 		}
-		pgid = process_group(task);
+		pgid = virt_process_group(task);
 		sid = task->signal->session;
 		cmin_flt = task->signal->cmin_flt;
 		cmaj_flt = task->signal->cmaj_flt;
Index: linux-2.6.15-rc1/kernel/sys.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sys.c	2005-11-30 18:07:18.000000000 -0500
+++ linux-2.6.15-rc1/kernel/sys.c	2005-11-30 18:08:03.000000000 -0500
@@ -1154,7 +1154,7 @@ out:
 asmlinkage long sys_getpgid(pid_t pid)
 {
 	if (!pid) {
-		return process_group(current);
+		return virt_process_group(current);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1166,7 +1166,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 		if (p) {
 			retval = security_task_getpgid(p);
 			if (!retval)
-				retval = process_group(p);
+				retval = virt_process_group(p);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
@@ -1178,7 +1178,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 asmlinkage long sys_getpgrp(void)
 {
 	/* SMP - assuming writes are word atomic this is fine */
-	return process_group(current);
+	return virt_process_group(current);
 }
 
 #endif
@@ -1224,7 +1224,7 @@ asmlinkage long sys_setsid(void)
 	__set_special_pids(task_pid(current), task_pid(current));
 	current->signal->tty = NULL;
 	current->signal->tty_old_pgrp = 0;
-	err = process_group(current);
+	err = virt_process_group(current);
 out:
 	write_unlock_irq(&tasklist_lock);
 	up(&tty_sem);

--
