Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSLOKGn>; Sun, 15 Dec 2002 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266319AbSLOKGn>; Sun, 15 Dec 2002 05:06:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36828 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266316AbSLOKGm>;
	Sun, 15 Dec 2002 05:06:42 -0500
Date: Sun, 15 Dec 2002 11:19:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] threaded coredumps, tcore-fixes-2.5.51-A0
Message-ID: <Pine.LNX.4.44.0212151112001.4707-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes one more threaded-coredumps
detail reported by the glibc people: all threads taken down by the
coredump code should report the proper exit code. We can do this rather
easily via the group_exit mechanism. 'Other' threads used to report
SIGKILL, which was highly confusing as the shell often displayed the
'Killed' message instead of a 'Segmentation fault' message. Another
missing bit was the 0x80 bit set in the exit status for all threads, if
the coredump was successful. (it's safe to set this bit in
->sig->group_exit_code in an unlocked way because all threads are
artificially descheduled by the coredump code.)

i tested the patch on x86, it works as expected:

  $ ulimit -c 0
  $ ./p3-coredump
  Segmentation fault

  $ ulimit -c 10000000
  $ ./p3-coredump
  Segmentation fault (core dumped)

	Ingo

--- linux/fs/exec.c.orig	2002-12-15 12:06:38.000000000 +0100
+++ linux/fs/exec.c	2002-12-15 12:07:04.000000000 +0100
@@ -1268,7 +1268,7 @@
 	BUG_ON(mm->core_waiters);
 }
 
-int do_coredump(long signr, struct pt_regs * regs)
+int do_coredump(long signr, int exit_code, struct pt_regs * regs)
 {
 	char corename[CORENAME_MAX_SIZE + 1];
 	struct mm_struct *mm = current->mm;
@@ -1288,6 +1288,8 @@
 	}
 	mm->dumpable = 0;
 	init_completion(&mm->core_done);
+	current->sig->group_exit = 1;
+	current->sig->group_exit_code = exit_code;
 	coredump_wait(mm);
 
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
@@ -1314,6 +1316,7 @@
 
 	retval = binfmt->core_dump(signr, regs, file);
 
+	current->sig->group_exit_code |= 0x80;
 close_fail:
 	filp_close(file, NULL);
 fail_unlock:
--- linux/include/linux/binfmts.h.orig	2002-09-20 17:20:29.000000000 +0200
+++ linux/include/linux/binfmts.h	2002-12-15 12:07:04.000000000 +0100
@@ -57,7 +57,7 @@
 extern int copy_strings(int argc,char ** argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
-extern int do_coredump(long signr, struct pt_regs * regs);
+extern int do_coredump(long signr, int exit_code, struct pt_regs * regs);
 extern void set_binfmt(struct linux_binfmt *new);
 
 
--- linux/kernel/signal.c.orig	2002-12-15 12:06:38.000000000 +0100
+++ linux/kernel/signal.c	2002-12-15 12:07:04.000000000 +0100
@@ -1313,7 +1313,7 @@
 			case SIGQUIT: case SIGILL: case SIGTRAP:
 			case SIGABRT: case SIGFPE: case SIGSEGV:
 			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
+				if (do_coredump(signr, exit_code, regs))
 					exit_code |= 0x80;
 				/* FALLTHRU */
 

