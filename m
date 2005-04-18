Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVDRU4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDRU4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDRU4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:56:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:4034 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261179AbVDRUyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:54:37 -0400
Date: Mon, 18 Apr 2005 22:57:29 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Herbert Xu <herbert@gondor.apana.org.au>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/2] new valid_signal function - convert code that currently
 tests _NSIG directly to use the new function instead
Message-ID: <Pine.LNX.4.62.0504182253320.5362@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below converts most of the current code that uses _NSIG directly 
to instead use the valid_signal() function added by the previous patch.
This avoids gcc -W warnings and off-by-one errors and it's also nice and 
readable, no doubt about what the code tests.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
--- 

 arch/alpha/kernel/ptrace.c         |    5 +++--
 arch/arm/kernel/ptrace.c           |    5 +++--
 arch/arm26/kernel/ptrace.c         |    5 +++--
 arch/cris/arch-v10/kernel/ptrace.c |    5 +++--
 arch/frv/kernel/ptrace.c           |    5 +++--
 arch/h8300/kernel/ptrace.c         |    5 +++--
 arch/i386/kernel/ptrace.c          |    5 +++--
 arch/ia64/kernel/ptrace.c          |    5 +++--
 arch/m32r/kernel/ptrace.c          |    5 +++--
 arch/m68k/kernel/ptrace.c          |    5 +++--
 arch/m68knommu/kernel/ptrace.c     |    5 +++--
 arch/mips/kernel/ptrace.c          |    3 ++-
 arch/mips/kernel/ptrace32.c        |    3 ++-
 arch/parisc/kernel/ptrace.c        |    7 ++++---
 arch/ppc/kernel/ptrace.c           |    5 +++--
 arch/ppc64/kernel/ptrace.c         |    5 +++--
 arch/ppc64/kernel/ptrace32.c       |    5 +++--
 arch/s390/kernel/ptrace.c          |    5 +++--
 arch/sh/kernel/ptrace.c            |    5 +++--
 arch/sh64/kernel/ptrace.c          |    5 +++--
 arch/sparc/kernel/ptrace.c         |    3 ++-
 arch/sparc64/kernel/ptrace.c       |    3 ++-
 arch/um/kernel/ptrace.c            |    4 ++--
 arch/v850/kernel/ptrace.c          |    3 ++-
 arch/x86_64/kernel/ptrace.c        |    5 +++--
 drivers/char/vt_ioctl.c            |    3 ++-
 fs/fcntl.c                         |    3 ++-
 ipc/mqueue.c                       |    4 ++--
 kernel/exit.c                      |    5 +++--
 kernel/futex.c                     |    3 ++-
 kernel/ptrace.c                    |    3 ++-
 kernel/signal.c                    |    9 +++++----
 kernel/sys.c                       |    3 ++-
 33 files changed, 90 insertions(+), 59 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/arch/alpha/kernel/ptrace.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/alpha/kernel/ptrace.c	2005-04-18 22:21:32.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -335,7 +336,7 @@ do_sys_ptrace(long request, long pid, lo
 		/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:    /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -365,7 +366,7 @@ do_sys_ptrace(long request, long pid, lo
 
 	case PTRACE_SINGLESTEP:  /* execute single instruction. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		/* Mark single stepping.  */
 		child->thread_info->bpt_nsaved = -1;
--- linux-2.6.12-rc2-mm3-orig/arch/arm/kernel/ptrace.c	2005-04-05 21:21:05.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/arm/kernel/ptrace.c	2005-04-18 22:21:45.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/init.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -693,7 +694,7 @@ static int do_ptrace(int request, struct
 		case PTRACE_SYSCALL:
 		case PTRACE_CONT:
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			if (request == PTRACE_SYSCALL)
 				set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -728,7 +729,7 @@ static int do_ptrace(int request, struct
 		 */
 		case PTRACE_SINGLESTEP:
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			child->ptrace |= PT_SINGLESTEP;
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/arm26/kernel/ptrace.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/arm26/kernel/ptrace.c	2005-04-18 22:21:58.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -591,7 +592,7 @@ static int do_ptrace(int request, struct
 		case PTRACE_SYSCALL:
 		case PTRACE_CONT:
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			if (request == PTRACE_SYSCALL)
 				set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -626,7 +627,7 @@ static int do_ptrace(int request, struct
 		 */
 		case PTRACE_SINGLESTEP:
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			child->ptrace |= PT_SINGLESTEP;
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/cris/arch-v10/kernel/ptrace.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/cris/arch-v10/kernel/ptrace.c	2005-04-18 22:22:12.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -184,7 +185,7 @@ sys_ptrace(long request, long pid, long 
 		case PTRACE_CONT:
 			ret = -EIO;
 			
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
                         
 			if (request == PTRACE_SYSCALL) {
@@ -219,7 +220,7 @@ sys_ptrace(long request, long pid, long 
 		case PTRACE_SINGLESTEP:
 			ret = -EIO;
 			
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/frv/kernel/ptrace.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/frv/kernel/ptrace.c	2005-04-18 22:22:23.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/user.h>
 #include <linux/config.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -239,7 +240,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -267,7 +268,7 @@ asmlinkage int sys_ptrace(long request, 
 
 	case PTRACE_SINGLESTEP:  /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		ptrace_enable(child);
--- linux-2.6.12-rc2-mm3-orig/arch/h8300/kernel/ptrace.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/h8300/kernel/ptrace.c	2005-04-18 22:22:42.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/config.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -171,7 +172,7 @@ asmlinkage int sys_ptrace(long request, 
 		case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 		case PTRACE_CONT: { /* restart after signal. */
 			ret = -EIO;
-			if ((unsigned long) data >= _NSIG)
+			if (!valid_signal(data))
 				break ;
 			if (request == PTRACE_SYSCALL)
 				set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -202,7 +203,7 @@ asmlinkage int sys_ptrace(long request, 
 
 		case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			child->exit_code = data;
--- linux-2.6.12-rc2-mm3-orig/arch/i386/kernel/ptrace.c	2005-04-05 21:21:07.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/i386/kernel/ptrace.c	2005-04-18 22:23:00.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -511,7 +512,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:	/* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -543,7 +544,7 @@ asmlinkage int sys_ptrace(long request, 
 
 	case PTRACE_SINGLESTEP:	/* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
--- linux-2.6.12-rc2-mm3-orig/arch/ia64/kernel/ptrace.c	2005-04-05 21:21:07.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ia64/kernel/ptrace.c	2005-04-18 22:23:09.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/signal.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -1481,7 +1482,7 @@ sys_ptrace (long request, pid_t pid, uns
 	      case PTRACE_CONT:
 		/* restart after signal. */
 		ret = -EIO;
-		if (data > _NSIG)
+		if (!valid_signal(data))
 			goto out_tsk;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -1520,7 +1521,7 @@ sys_ptrace (long request, pid_t pid, uns
 		/* let child execute for one instruction */
 	      case PTRACE_SINGLEBLOCK:
 		ret = -EIO;
-		if (data > _NSIG)
+		if (!valid_signal(data))
 			goto out_tsk;
 
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/m32r/kernel/ptrace.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/m32r/kernel/ptrace.c	2005-04-18 22:23:19.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/string.h>
+#include <linux/signal.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -665,7 +666,7 @@ do_ptrace(long request, struct task_stru
 	case PTRACE_SYSCALL:
 	case PTRACE_CONT:
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -700,7 +701,7 @@ do_ptrace(long request, struct task_stru
 		unsigned long pc, insn;
 
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
--- linux-2.6.12-rc2-mm3-orig/arch/m68k/kernel/ptrace.c	2005-03-02 08:37:52.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/m68k/kernel/ptrace.c	2005-04-18 22:23:30.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/config.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -251,7 +252,7 @@ asmlinkage int sys_ptrace(long request, 
 			long tmp;
 
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			if (request == PTRACE_SYSCALL) {
 					child->thread.work.syscall_trace = ~0;
@@ -292,7 +293,7 @@ asmlinkage int sys_ptrace(long request, 
 			long tmp;
 
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			child->thread.work.syscall_trace = 0;
 			tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
--- linux-2.6.12-rc2-mm3-orig/arch/m68knommu/kernel/ptrace.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/m68knommu/kernel/ptrace.c	2005-04-18 22:23:43.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/config.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -240,7 +241,7 @@ asmlinkage int sys_ptrace(long request, 
 			long tmp;
 
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			if (request == PTRACE_SYSCALL)
 				set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -278,7 +279,7 @@ asmlinkage int sys_ptrace(long request, 
 			long tmp;
 
 			ret = -EIO;
-			if ((unsigned long) data > _NSIG)
+			if (!valid_signal(data))
 				break;
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
--- linux-2.6.12-rc2-mm3-orig/arch/mips/kernel/ptrace.c	2005-04-11 21:20:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/mips/kernel/ptrace.c	2005-04-18 22:24:15.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/cpu.h>
 #include <asm/fpu.h>
@@ -257,7 +258,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/mips/kernel/ptrace32.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/mips/kernel/ptrace32.c	2005-04-18 22:24:24.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/cpu.h>
 #include <asm/fpu.h>
@@ -241,7 +242,7 @@ asmlinkage int sys32_ptrace(int request,
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned int) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/parisc/kernel/ptrace.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/parisc/kernel/ptrace.c	2005-04-18 22:24:46.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/compat.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -285,7 +286,7 @@ long sys_ptrace(long request, pid_t pid,
 		ret = -EIO;
 		DBG("sys_ptrace(%s)\n",
 			request == PTRACE_SYSCALL ? "SYSCALL" : "CONT");
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			goto out_tsk;
 		child->ptrace &= ~(PT_SINGLESTEP|PT_BLOCKSTEP);
 		if (request == PTRACE_SYSCALL) {
@@ -311,7 +312,7 @@ long sys_ptrace(long request, pid_t pid,
 	case PTRACE_SINGLEBLOCK:
 		DBG("sys_ptrace(SINGLEBLOCK)\n");
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			goto out_tsk;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->ptrace &= ~PT_SINGLESTEP;
@@ -328,7 +329,7 @@ long sys_ptrace(long request, pid_t pid,
 	case PTRACE_SINGLESTEP:
 		DBG("sys_ptrace(SINGLESTEP)\n");
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			goto out_tsk;
 
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--- linux-2.6.12-rc2-mm3-orig/arch/ppc/kernel/ptrace.c	2005-03-02 08:37:51.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/ppc/kernel/ptrace.c	2005-04-18 22:24:55.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -356,7 +357,7 @@ int sys_ptrace(long request, long pid, l
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -389,7 +390,7 @@ int sys_ptrace(long request, long pid, l
 
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_single_step(child);
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/ptrace.c	2005-04-05 21:21:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/ptrace.c	2005-04-18 22:25:13.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -162,7 +163,7 @@ int sys_ptrace(long request, long pid, l
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -194,7 +195,7 @@ int sys_ptrace(long request, long pid, l
 
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_single_step(child);
--- linux-2.6.12-rc2-mm3-orig/arch/ppc64/kernel/ptrace32.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/ppc64/kernel/ptrace32.c	2005-04-18 22:25:22.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -293,7 +294,7 @@ int sys32_ptrace(long request, long pid,
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -325,7 +326,7 @@ int sys32_ptrace(long request, long pid,
 
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_single_step(child);
--- linux-2.6.12-rc2-mm3-orig/arch/s390/kernel/ptrace.c	2005-04-05 21:21:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/s390/kernel/ptrace.c	2005-04-18 22:25:35.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/signal.h>
 
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -609,7 +610,7 @@ do_ptrace(struct task_struct *child, lon
 		/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:
 		/* restart after signal. */
-		if ((unsigned long) data >= _NSIG)
+		if (!valid_signal(data))
 			return -EIO;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -637,7 +638,7 @@ do_ptrace(struct task_struct *child, lon
 
 	case PTRACE_SINGLESTEP:
 		/* set the trap flag. */
-		if ((unsigned long) data >= _NSIG)
+		if (!valid_signal(data))
 			return -EIO;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
--- linux-2.6.12-rc2-mm3-orig/arch/sh/kernel/ptrace.c	2005-04-05 21:21:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/sh/kernel/ptrace.c	2005-04-18 22:25:46.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/user.h>
 #include <linux/slab.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -197,7 +198,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -228,7 +229,7 @@ asmlinkage int sys_ptrace(long request, 
 		struct pt_regs *dummy = NULL;
 
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
--- linux-2.6.12-rc2-mm3-orig/arch/sh64/kernel/ptrace.c	2005-04-05 21:21:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/sh64/kernel/ptrace.c	2005-04-18 22:25:55.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -255,7 +256,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
@@ -285,7 +286,7 @@ asmlinkage int sys_ptrace(long request, 
 		struct pt_regs *regs;
 
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
--- linux-2.6.12-rc2-mm3-orig/arch/sparc/kernel/ptrace.c	2005-04-05 21:21:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/sparc/kernel/ptrace.c	2005-04-18 22:26:05.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -526,7 +527,7 @@ asmlinkage void do_ptrace(struct pt_regs
 		addr = 1;
 
 	case PTRACE_CONT: { /* restart after signal. */
-		if (data > _NSIG) {
+		if (!valid_signal(data)) {
 			pt_error_return(regs, EIO);
 			goto out_tsk;
 		}
--- linux-2.6.12-rc2-mm3-orig/arch/sparc64/kernel/ptrace.c	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/sparc64/kernel/ptrace.c	2005-04-18 22:26:15.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/asi.h>
 #include <asm/pgtable.h>
@@ -510,7 +511,7 @@ asmlinkage void do_ptrace(struct pt_regs
 		addr = 1;
 
 	case PTRACE_CONT: { /* restart after signal. */
-		if (data > _NSIG) {
+		if (!valid_signal(data)) {
 			pt_error_return(regs, EIO);
 			goto out_tsk;
 		}
--- linux-2.6.12-rc2-mm3-orig/arch/um/kernel/ptrace.c	2005-04-05 21:21:16.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/um/kernel/ptrace.c	2005-04-18 22:27:30.000000000 +0200
@@ -143,7 +143,7 @@ long sys_ptrace(long request, long pid, 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 
 		child->ptrace &= ~PT_DTRACE;
@@ -179,7 +179,7 @@ long sys_ptrace(long request, long pid, 
 
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->ptrace |= PT_DTRACE;
--- linux-2.6.12-rc2-mm3-orig/arch/v850/kernel/ptrace.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/v850/kernel/ptrace.c	2005-04-18 22:27:44.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
+#include <linux/signal.h>
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
@@ -208,7 +209,7 @@ int sys_ptrace(long request, long pid, l
 	/* Execute a single instruction. */
 	case PTRACE_SINGLESTEP:
 		rval = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 
 		/* Turn CHILD's single-step flag on or off.  */
--- linux-2.6.12-rc2-mm3-orig/arch/x86_64/kernel/ptrace.c	2005-04-11 21:20:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3/arch/x86_64/kernel/ptrace.c	2005-04-18 22:27:52.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -467,7 +468,7 @@ asmlinkage long sys_ptrace(long request,
 	case PTRACE_CONT:    /* restart after signal. */
 
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
@@ -529,7 +530,7 @@ asmlinkage long sys_ptrace(long request,
 
 	case PTRACE_SINGLESTEP:    /* set the trap flag. */
 		ret = -EIO;
-		if ((unsigned long) data > _NSIG)
+		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
 		set_singlestep(child);
--- linux-2.6.12-rc2-mm3-orig/drivers/char/vt_ioctl.c	2005-04-05 21:21:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/char/vt_ioctl.c	2005-04-18 22:28:15.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -641,7 +642,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		extern int spawnpid, spawnsig;
 		if (!perm || !capable(CAP_KILL))
 		  return -EPERM;
-		if (arg < 1 || arg > _NSIG || arg == SIGKILL)
+		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
 		  return -EINVAL;
 		spawnpid = current->pid;
 		spawnsig = arg;
--- linux-2.6.12-rc2-mm3-orig/fs/fcntl.c	2005-04-11 21:20:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/fcntl.c	2005-04-18 19:23:00.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/signal.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -308,7 +309,7 @@ static long do_fcntl(int fd, unsigned in
 		break;
 	case F_SETSIG:
 		/* arg == 0 restores default behaviour. */
-		if (arg < 0 || arg > _NSIG) {
+		if (!valid_signal(arg)) {
 			break;
 		}
 		err = 0;
--- linux-2.6.12-rc2-mm3-orig/ipc/mqueue.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc2-mm3/ipc/mqueue.c	2005-04-18 22:29:07.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 #include <net/sock.h>
 #include "util.h"
 
@@ -976,8 +977,7 @@ asmlinkage long sys_mq_notify(mqd_t mqde
 			     notification.sigev_notify != SIGEV_THREAD))
 			return -EINVAL;
 		if (notification.sigev_notify == SIGEV_SIGNAL &&
-			(notification.sigev_signo < 0 ||
-			 notification.sigev_signo > _NSIG)) {
+			!valid_signal(notification.sigev_signo)) {
 			return -EINVAL;
 		}
 		if (notification.sigev_notify == SIGEV_THREAD) {
--- linux-2.6.12-rc2-mm3-orig/kernel/exit.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/exit.c	2005-04-18 22:29:29.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/cpuset.h>
 #include <linux/perfctr.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -281,7 +282,7 @@ void set_special_pids(pid_t session, pid
  */
 int allow_signal(int sig)
 {
-	if (sig < 1 || sig > _NSIG)
+	if (!valid_signal(sig) || sig < 1)
 		return -EINVAL;
 
 	spin_lock_irq(&current->sighand->siglock);
@@ -302,7 +303,7 @@ EXPORT_SYMBOL(allow_signal);
 
 int disallow_signal(int sig)
 {
-	if (sig < 1 || sig > _NSIG)
+	if (!valid_signal(sig) || sig < 1)
 		return -EINVAL;
 
 	spin_lock_irq(&current->sighand->siglock);
--- linux-2.6.12-rc2-mm3-orig/kernel/futex.c	2005-04-05 21:21:55.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/futex.c	2005-04-18 22:29:41.000000000 +0200
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
@@ -654,7 +655,7 @@ static int futex_fd(unsigned long uaddr,
 	int ret, err;
 
 	ret = -EINVAL;
-	if (signal < 0 || signal > _NSIG)
+	if (!valid_signal(signal))
 		goto out;
 
 	ret = get_unused_fd();
--- linux-2.6.12-rc2-mm3-orig/kernel/ptrace.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/kernel/ptrace.c	2005-04-18 22:30:00.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
+#include <linux/signal.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -166,7 +167,7 @@ bad:
 
 int ptrace_detach(struct task_struct *child, unsigned int data)
 {
-	if ((unsigned long) data > _NSIG)
+	if (!valid_signal(data))
 		return	-EIO;
 
 	/* Architecture-specific hardware disable .. */
--- linux-2.6.12-rc2-mm3-orig/kernel/signal.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/signal.c	2005-04-18 22:30:33.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/syscalls.h>
 #include <linux/ptrace.h>
 #include <linux/posix-timers.h>
+#include <linux/signal.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -638,7 +639,7 @@ static int check_kill_permission(int sig
 				 struct task_struct *t)
 {
 	int error = -EINVAL;
-	if (sig < 0 || sig > _NSIG)
+	if (!valid_signal(sig))
 		return error;
 	error = -EPERM;
 	if ((!info || ((unsigned long)info != 1 &&
@@ -1237,7 +1238,7 @@ send_sig_info(int sig, struct siginfo *i
 	 * Make sure legacy kernel users don't send in bad values
 	 * (normal paths check this in check_kill_permission).
 	 */
-	if (sig < 0 || sig > _NSIG)
+	if (!valid_signal(sig))
 		return -EINVAL;
 
 	/*
@@ -1512,7 +1513,7 @@ void do_notify_parent(struct task_struct
 		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
 			sig = 0;
 	}
-	if (sig > 0 && sig <= _NSIG)
+	if (valid_signal(sig) && sig > 0)
 		__group_send_sig_info(sig, &info, tsk->parent);
 	__wake_up_parent(tsk, tsk->parent);
 	spin_unlock_irqrestore(&psig->siglock, flags);
@@ -2356,7 +2357,7 @@ do_sigaction(int sig, const struct k_sig
 {
 	struct k_sigaction *k;
 
-	if (sig < 1 || sig > _NSIG || (act && sig_kernel_only(sig)))
+	if (!valid_signal(sig) || sig < 1 || (act && sig_kernel_only(sig)))
 		return -EINVAL;
 
 	k = &current->sighand->action[sig-1];
--- linux-2.6.12-rc2-mm3-orig/kernel/sys.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/sys.c	2005-04-18 22:30:52.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
+#include <linux/signal.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -1657,7 +1658,7 @@ asmlinkage long sys_prctl(int option, un
 	switch (option) {
 		case PR_SET_PDEATHSIG:
 			sig = arg2;
-			if (sig < 0 || sig > _NSIG) {
+			if (!valid_signal(sig)) {
 				error = -EINVAL;
 				break;
 			}



