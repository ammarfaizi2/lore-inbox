Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAXUhO>; Wed, 24 Jan 2001 15:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAXUhE>; Wed, 24 Jan 2001 15:37:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48280 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129718AbRAXUgu>;
	Wed, 24 Jan 2001 15:36:50 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14959.15438.827521.926281@pizda.ninka.net>
Date: Wed, 24 Jan 2001 12:34:22 -0800 (PST)
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling for sparc64
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31503515856@berkeley.gci.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31503515856@berkeley.gci.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrong, your one-line fix may make it build correctly but it
will not produce working quota 32-bit syscall code there.

Someone needs to fixup the conversion code, I don't have time to track
the AC series (it actually duplicates a lot of networking stuff I just
pushed to Linus and ended up in 2.4.1-pre10) which means it likely
won't be fixed until Linus takes those quota code changes.

Please stick to 2.4.1-preX on sparc64, and if using 2.4.1-pre10 please
apply this patch to get a clean build :-)

Later,
David S. Miller
davem@redhat.com

--- ./arch/sparc/kernel/signal.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./arch/sparc/kernel/signal.c	Wed Jan 24 10:06:14 2001
@@ -28,9 +28,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int sys_wait4(pid_t pid, unsigned long *stat_addr,
-			 int options, unsigned long *ru);
-
 extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
 		   void *fpqueue, unsigned long *fpqdepth);
 extern void fpload(unsigned long *fpregs, unsigned long *fsr);
--- ./arch/sparc/kernel/sys_sunos.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./arch/sparc/kernel/sys_sunos.c	Wed Jan 24 10:06:21 2001
@@ -834,7 +834,6 @@
 }
 
 /* So stupid... */
-extern asmlinkage int sys_wait4(pid_t, unsigned int *, int, struct rusage *);
 asmlinkage int sunos_wait4(pid_t pid, unsigned int *stat_addr, int options, struct rusage *ru)
 {
 	int ret;
--- ./arch/sparc64/kernel/signal.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./arch/sparc64/kernel/signal.c	Wed Jan 24 10:05:52 2001
@@ -31,9 +31,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int sys_wait4(pid_t pid, unsigned long *stat_addr,
-			 int options, unsigned long *ru);
-
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs * regs,
 			 unsigned long orig_o0, int ret_from_syscall);
 
--- ./arch/sparc64/kernel/signal32.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./arch/sparc64/kernel/signal32.c	Wed Jan 24 10:05:57 2001
@@ -29,9 +29,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int sys_wait4(pid_t pid, unsigned long *stat_addr,
-			 int options, unsigned long *ru);
-
 asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs,
 			 unsigned long orig_o0, int ret_from_syscall);
 
--- ./arch/sparc64/kernel/sys_sparc32.c.~1~	Wed Dec 13 08:34:55 2000
+++ ./arch/sparc64/kernel/sys_sparc32.c	Wed Jan 24 10:06:06 2001
@@ -1794,9 +1794,6 @@
 	return err;
 }
 
-extern asmlinkage int sys_wait4(pid_t pid,unsigned int * stat_addr,
-				int options, struct rusage * ru);
-
 asmlinkage int sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
 {
 	if (!ru)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
