Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbRGTILB>; Fri, 20 Jul 2001 04:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbRGTIKw>; Fri, 20 Jul 2001 04:10:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38671 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266726AbRGTIKn>; Fri, 20 Jul 2001 04:10:43 -0400
Date: Fri, 20 Jul 2001 01:10:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Niels Kristian Bech Jensen <nkbj@image.dk>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.7-pre9.
In-Reply-To: <3B57D541.10312D18@uow.edu.au>
Message-ID: <Pine.LNX.4.31.0107200104290.718-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 20 Jul 2001, Andrew Morton wrote:
>
> I tested various other possible problems, such as making
> /sbin/hotplug an elf executable and it looks OK, apart from
> the /proc problem.

Actually, there's a double stupidity in the dumpable testing: it should
really test that the process has a VM, but it should also make sure to
lock that access properly.

This ends up being even more of an issue for ptrace, I think. Sorry for
the screw-up.  I think the real fix should be something along the lines of
this (actually, we should move the whole ptrace executable test into
ptrace_dumpable: right now x86 is the only one that gets the subtle and
unlikely race with a ptrace and a suid executable right with the memory
access ordering things).

		Linus

----
diff -u --recursive --new-file pre9/linux/arch/alpha/kernel/ptrace.c linux/arch/alpha/kernel/ptrace.c
--- pre9/linux/arch/alpha/kernel/ptrace.c	Fri Jul 20 01:02:50 2001
+++ linux/arch/alpha/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -267,7 +267,7 @@
 		ret = -EPERM;
 		if (child == current)
 			goto out;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->suid) ||
 		     (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/arm/kernel/ptrace.c linux/arch/arm/kernel/ptrace.c
--- pre9/linux/arch/arm/kernel/ptrace.c	Fri Jul 20 01:02:50 2001
+++ linux/arch/arm/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -596,7 +596,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/cris/kernel/ptrace.c linux/arch/cris/kernel/ptrace.c
--- pre9/linux/arch/cris/kernel/ptrace.c	Fri Jul 20 01:02:51 2001
+++ linux/arch/cris/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -117,7 +117,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/i386/kernel/ptrace.c linux/arch/i386/kernel/ptrace.c
--- pre9/linux/arch/i386/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/i386/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -176,7 +176,7 @@
 	 	    (current->gid != child->gid)) && !capable(CAP_SYS_PTRACE))
 			goto out_tsk;
 		rmb();
-		if (!child->mm->dumpable && !capable(CAP_SYS_PTRACE))
+		if (!ptrace_dumpable(child) && !capable(CAP_SYS_PTRACE))
 			goto out_tsk;
 		/* the same process cannot be attached many times */
 		if (child->ptrace & PT_PTRACED)
diff -u --recursive --new-file pre9/linux/arch/ia64/kernel/ptrace.c linux/arch/ia64/kernel/ptrace.c
--- pre9/linux/arch/ia64/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/ia64/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -770,7 +770,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/m68k/kernel/ptrace.c linux/arch/m68k/kernel/ptrace.c
--- pre9/linux/arch/m68k/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/m68k/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -120,7 +120,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/mips/kernel/ptrace.c linux/arch/mips/kernel/ptrace.c
--- pre9/linux/arch/mips/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/mips/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -68,7 +68,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/mips64/kernel/ptrace.c linux/arch/mips64/kernel/ptrace.c
--- pre9/linux/arch/mips64/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/mips64/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -64,7 +64,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
@@ -338,7 +338,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/parisc/kernel/ptrace.c linux/arch/parisc/kernel/ptrace.c
--- pre9/linux/arch/parisc/kernel/ptrace.c	Fri Jul 20 01:02:52 2001
+++ linux/arch/parisc/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -63,7 +63,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/ppc/kernel/ptrace.c linux/arch/ppc/kernel/ptrace.c
--- pre9/linux/arch/ppc/kernel/ptrace.c	Fri Jul 20 01:02:53 2001
+++ linux/arch/ppc/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -120,7 +120,7 @@
 	if (request == PTRACE_ATTACH) {
 		if (child == current)
 			goto out_tsk;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->suid) ||
 		    (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/s390/kernel/ptrace.c linux/arch/s390/kernel/ptrace.c
--- pre9/linux/arch/s390/kernel/ptrace.c	Fri Jul 20 01:02:53 2001
+++ linux/arch/s390/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -235,7 +235,7 @@
 	{
 		if (child == current)
 			goto out;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->suid) ||
 		     (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/s390x/kernel/ptrace.c linux/arch/s390x/kernel/ptrace.c
--- pre9/linux/arch/s390x/kernel/ptrace.c	Fri Jul 20 01:02:53 2001
+++ linux/arch/s390x/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -249,7 +249,7 @@
 	{
 		if (child == current)
 			goto out;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->suid) ||
 		     (current->uid != child->uid) ||
@@ -435,7 +435,7 @@
 	{
 		if (child == current)
 			goto out;
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->suid) ||
 		     (current->uid != child->uid) ||
diff -u --recursive --new-file pre9/linux/arch/sh/kernel/ptrace.c linux/arch/sh/kernel/ptrace.c
--- pre9/linux/arch/sh/kernel/ptrace.c	Fri Jul 20 01:02:53 2001
+++ linux/arch/sh/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -184,7 +184,7 @@
 	 	    (tsk->gid != child->gid)) && !capable(CAP_SYS_PTRACE))
 			goto out_tsk;
 		rmb();
-		if (!child->mm->dumpable && !capable(CAP_SYS_PTRACE))
+		if (!ptrace_dumpable(child) && !capable(CAP_SYS_PTRACE))
 			goto out_tsk;
 		/* the same process cannot be attached many times */
 		if (child->ptrace & PT_PTRACED)
diff -u --recursive --new-file pre9/linux/arch/sparc/kernel/ptrace.c linux/arch/sparc/kernel/ptrace.c
--- pre9/linux/arch/sparc/kernel/ptrace.c	Fri Jul 20 01:02:53 2001
+++ linux/arch/sparc/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -327,7 +327,7 @@
 			pt_error_return(regs, EPERM);
 			goto out_tsk;
 		}
-		if((!child->mm->dumpable ||
+		if((!ptrace_dumpable(child) ||
 		    (current->uid != child->euid) ||
 		    (current->uid != child->uid) ||
 		    (current->uid != child->suid) ||
diff -u --recursive --new-file pre9/linux/arch/sparc64/kernel/ptrace.c linux/arch/sparc64/kernel/ptrace.c
--- pre9/linux/arch/sparc64/kernel/ptrace.c	Fri Jul 20 01:02:54 2001
+++ linux/arch/sparc64/kernel/ptrace.c	Fri Jul 20 01:01:43 2001
@@ -177,7 +177,7 @@
 			pt_error_return(regs, EPERM);
 			goto out_tsk;
 		}
-		if ((!child->mm->dumpable ||
+		if ((!ptrace_dumpable(child) ||
 		     (current->uid != child->euid) ||
 		     (current->uid != child->uid) ||
 		     (current->uid != child->suid) ||
diff -u --recursive --new-file pre9/linux/fs/proc/base.c linux/fs/proc/base.c
--- pre9/linux/fs/proc/base.c	Fri Jul 20 01:03:03 2001
+++ linux/fs/proc/base.c	Fri Jul 20 00:59:38 2001
@@ -670,7 +670,7 @@
 	inode->u.proc_i.task = task;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_PID_INO || task->mm->dumpable) {
+	if (ino == PROC_PID_INO || ptrace_dumpable(task)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
diff -u --recursive --new-file pre9/linux/include/linux/mm.h linux/include/linux/mm.h
--- pre9/linux/include/linux/mm.h	Tue Jul  3 15:42:55 2001
+++ linux/include/linux/mm.h	Fri Jul 20 00:59:22 2001
@@ -442,6 +442,7 @@
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
+extern int ptrace_dumpable(struct task_struct *tsk);

 /*
  * On a two-level page table, this ends up being trivial. Thus the
diff -u --recursive --new-file pre9/linux/kernel/ptrace.c linux/kernel/ptrace.c
--- pre9/linux/kernel/ptrace.c	Mon Mar 19 12:35:08 2001
+++ linux/kernel/ptrace.c	Fri Jul 20 00:58:46 2001
@@ -16,6 +16,19 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>

+int ptrace_dumpable(struct task_struct *task)
+{
+	int dumpable = 0;
+	struct mm_struct *mm;
+
+	task_lock(task);
+	mm = task->mm;
+	if (mm)
+		dumpable = mm->dumpable;
+	task_unlock(task);
+	return dumpable;
+}
+
 /*
  * Access another process' address space, one page at a time.
  */

