Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVANUZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVANUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVANUV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:21:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53694 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262152AbVANUTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:19:13 -0500
Date: Fri, 14 Jan 2005 20:19:09 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make compat_rt_sigtimedwait conform
Message-ID: <20050114201909.GM30982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compat syscalls need to start compat_sys_ otherwise PA-RISC's compat
syscall wrappers don't work.  Not that the individual involved bothered
to patch PA-RISC ...

Index: linux-2.6/arch/ia64/ia32/ia32_entry.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/ia32/ia32_entry.S,v
retrieving revision 1.16
diff -u -p -r1.16 ia32_entry.S
--- linux-2.6/arch/ia64/ia32/ia32_entry.S	12 Jan 2005 20:15:24 -0000	1.16
+++ linux-2.6/arch/ia64/ia32/ia32_entry.S	14 Jan 2005 19:56:04 -0000
@@ -387,7 +387,7 @@ ia32_syscall_table:
 	data8 sys32_rt_sigaction
 	data8 sys32_rt_sigprocmask /* 175 */
 	data8 sys_rt_sigpending
-	data8 compat_rt_sigtimedwait
+	data8 compat_sys_rt_sigtimedwait
 	data8 sys32_rt_sigqueueinfo
 	data8 sys32_rt_sigsuspend
 	data8 sys32_pread	  /* 180 */
Index: linux-2.6/arch/mips/kernel/scall64-n32.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/kernel/scall64-n32.S,v
retrieving revision 1.7
diff -u -p -r1.7 scall64-n32.S
--- linux-2.6/arch/mips/kernel/scall64-n32.S	12 Jan 2005 20:15:38 -0000	1.7
+++ linux-2.6/arch/mips/kernel/scall64-n32.S	14 Jan 2005 19:56:04 -0000
@@ -243,7 +243,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_capget
 	PTR	sys_capset
 	PTR	sys32_rt_sigpending		/* 6125 */
-	PTR	compat_rt_sigtimedwait
+	PTR	compat_sys_rt_sigtimedwait
 	PTR	sys32_rt_sigqueueinfo
 	PTR	sys32_rt_sigsuspend
 	PTR	sys32_sigaltstack
Index: linux-2.6/arch/mips/kernel/scall64-o32.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/mips/kernel/scall64-o32.S,v
retrieving revision 1.6
diff -u -p -r1.6 scall64-o32.S
--- linux-2.6/arch/mips/kernel/scall64-o32.S	12 Jan 2005 20:15:38 -0000	1.6
+++ linux-2.6/arch/mips/kernel/scall64-o32.S	14 Jan 2005 19:56:04 -0000
@@ -420,7 +420,7 @@ sys_call_table:
 	PTR	sys32_rt_sigaction
 	PTR	sys32_rt_sigprocmask 		/* 4195 */
 	PTR	sys32_rt_sigpending
-	PTR	compat_rt_sigtimedwait
+	PTR	compat_sys_rt_sigtimedwait
 	PTR	sys32_rt_sigqueueinfo
 	PTR	sys32_rt_sigsuspend
 	PTR	sys32_pread			/* 4200 */
Index: linux-2.6/arch/parisc/kernel/syscall_table.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/syscall_table.S,v
retrieving revision 1.12
diff -u -p -r1.12 syscall_table.S
--- linux-2.6/arch/parisc/kernel/syscall_table.S	12 Jan 2005 20:15:40 -0000	1.12
+++ linux-2.6/arch/parisc/kernel/syscall_table.S	14 Jan 2005 19:56:04 -0000
@@ -275,7 +275,7 @@
 	ENTRY_DIFF(rt_sigaction)
 	ENTRY_DIFF(rt_sigprocmask)	/* 175 */
 	ENTRY_DIFF(rt_sigpending)
-	ENTRY_UHOH(rt_sigtimedwait)
+	ENTRY_COMP(rt_sigtimedwait)
 	/* even though the struct siginfo_t is different, it appears like
 	 * all the paths use values which should be same wide and narrow.
 	 * Also the struct is padded to 128 bytes which means we don't have
Index: linux-2.6/arch/ppc64/kernel/misc.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/kernel/misc.S,v
retrieving revision 1.22
diff -u -p -r1.22 misc.S
--- linux-2.6/arch/ppc64/kernel/misc.S	12 Jan 2005 20:15:46 -0000	1.22
+++ linux-2.6/arch/ppc64/kernel/misc.S	14 Jan 2005 19:56:04 -0000
@@ -843,7 +843,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys32_rt_sigaction
 	.llong .sys32_rt_sigprocmask
 	.llong .sys32_rt_sigpending     /* 175 */
-	.llong .compat_rt_sigtimedwait
+	.llong .compat_sys_rt_sigtimedwait
 	.llong .sys32_rt_sigqueueinfo
 	.llong .ppc32_rt_sigsuspend
 	.llong .sys32_pread64
Index: linux-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/kernel/compat_wrapper.S,v
retrieving revision 1.13
diff -u -p -r1.13 compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	12 Jan 2005 20:15:48 -0000	1.13
+++ linux-2.6/arch/s390/kernel/compat_wrapper.S	14 Jan 2005 19:56:05 -0000
@@ -840,13 +840,13 @@ sys32_rt_sigpending_wrapper:
 	llgfr	%r3,%r3			# size_t
 	jg	sys32_rt_sigpending	# branch to system call
 
-	.globl  compat_rt_sigtimedwait_wrapper
-compat_rt_sigtimedwait_wrapper:
+	.globl  compat_sys_rt_sigtimedwait_wrapper
+compat_sys_rt_sigtimedwait_wrapper:
 	llgtr	%r2,%r2			# const sigset_emu31_t *
 	llgtr	%r3,%r3			# siginfo_emu31_t *
 	llgtr	%r4,%r4			# const struct compat_timespec *
 	llgfr	%r5,%r5			# size_t
-	jg	compat_rt_sigtimedwait	# branch to system call
+	jg	compat_sys_rt_sigtimedwait	# branch to system call
 
 	.globl  sys32_rt_sigqueueinfo_wrapper 
 sys32_rt_sigqueueinfo_wrapper:
Index: linux-2.6/arch/s390/kernel/syscalls.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/kernel/syscalls.S,v
retrieving revision 1.11
diff -u -p -r1.11 syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	12 Jan 2005 20:15:48 -0000	1.11
+++ linux-2.6/arch/s390/kernel/syscalls.S	14 Jan 2005 19:56:05 -0000
@@ -185,7 +185,7 @@ SYSCALL(sys_rt_sigreturn_glue,sys_rt_sig
 SYSCALL(sys_rt_sigaction,sys_rt_sigaction,sys32_rt_sigaction_wrapper)
 SYSCALL(sys_rt_sigprocmask,sys_rt_sigprocmask,sys32_rt_sigprocmask_wrapper)	/* 175 */
 SYSCALL(sys_rt_sigpending,sys_rt_sigpending,sys32_rt_sigpending_wrapper)
-SYSCALL(sys_rt_sigtimedwait,sys_rt_sigtimedwait,compat_rt_sigtimedwait_wrapper)
+SYSCALL(sys_rt_sigtimedwait,sys_rt_sigtimedwait,compat_sys_rt_sigtimedwait_wrapper)
 SYSCALL(sys_rt_sigqueueinfo,sys_rt_sigqueueinfo,sys32_rt_sigqueueinfo_wrapper)
 SYSCALL(sys_rt_sigsuspend_glue,sys_rt_sigsuspend_glue,sys32_rt_sigsuspend_glue)
 SYSCALL(sys_pread64,sys_pread64,sys32_pread64_wrapper)		/* 180 */
Index: linux-2.6/arch/sparc64/kernel/systbls.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/kernel/systbls.S,v
retrieving revision 1.18
diff -u -p -r1.18 systbls.S
--- linux-2.6/arch/sparc64/kernel/systbls.S	12 Jan 2005 20:15:55 -0000	1.18
+++ linux-2.6/arch/sparc64/kernel/systbls.S	14 Jan 2005 19:56:05 -0000
@@ -41,7 +41,7 @@ sys_call_table32:
 /*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys32_setpriority, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*100*/ .word sys32_getpriority, sys32_rt_sigreturn, sys32_rt_sigaction, sys32_rt_sigprocmask, sys32_rt_sigpending
-	.word compat_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
+	.word compat_sys_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
 /*110*/	.word sys_setresgid, sys_getresgid, sys_setregid, sys_nis_syscall, sys_nis_syscall
 	.word sys32_getgroups, sys32_gettimeofday, sys32_getrusage, sys_nis_syscall, sys_getcwd
 /*120*/	.word compat_sys_readv, compat_sys_writev, sys32_settimeofday, sys32_fchown16, sys_fchmod
Index: linux-2.6/arch/x86_64/ia32/ia32entry.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/ia32/ia32entry.S,v
retrieving revision 1.15
diff -u -p -r1.15 ia32entry.S
--- linux-2.6/arch/x86_64/ia32/ia32entry.S	12 Jan 2005 20:16:06 -0000	1.15
+++ linux-2.6/arch/x86_64/ia32/ia32entry.S	14 Jan 2005 19:56:05 -0000
@@ -479,7 +479,7 @@ ia32_sys_call_table:
 	.quad sys32_rt_sigaction
 	.quad sys32_rt_sigprocmask	/* 175 */
 	.quad sys32_rt_sigpending
-	.quad compat_rt_sigtimedwait
+	.quad compat_sys_rt_sigtimedwait
 	.quad sys32_rt_sigqueueinfo
 	.quad stub32_rt_sigsuspend
 	.quad sys32_pread		/* 180 */
Index: linux-2.6/kernel/compat.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/compat.c,v
retrieving revision 1.21
diff -u -p -r1.21 compat.c
--- linux-2.6/kernel/compat.c	12 Jan 2005 21:22:33 -0000	1.21
+++ linux-2.6/kernel/compat.c	14 Jan 2005 19:56:08 -0000
@@ -756,7 +756,7 @@ sigset_from_compat (sigset_t *set, compa
 }
 
 asmlinkage long
-compat_rt_sigtimedwait (compat_sigset_t __user *uthese,
+compat_sys_rt_sigtimedwait (compat_sigset_t __user *uthese,
 		struct compat_siginfo __user *uinfo,
 		struct compat_timespec __user *uts, compat_size_t sigsetsize)
 {

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
