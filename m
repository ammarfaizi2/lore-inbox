Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTIYRTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIYRTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:19:53 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:60567 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261304AbTIYRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:16:53 -0400
Date: Thu, 25 Sep 2003 19:16:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/19): 31 bit compat.
Message-ID: <20030925171613.GD2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix emulation of sys_sysinfo and sys_clone.
 - Add code for -ERESTART_RESTARTBLOCK in signal emulation.
 - Fix ptrace peek/poke for 31 bit programs under a 64 bit kernel.
 - Fix typos in cp_stat64.

diffstat:
 arch/s390/kernel/compat_ioctl.c  |    1 +
 arch/s390/kernel/compat_linux.c  |   23 +++++++++++++++--------
 arch/s390/kernel/compat_signal.c |    4 ++++
 arch/s390/kernel/ptrace.c        |   21 +++++++++++++++++++--
 4 files changed, 39 insertions(+), 10 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	Mon Sep  8 21:50:12 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_ioctl.c	Thu Sep 25 18:33:23 2003
@@ -23,6 +23,7 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h>
 #include <linux/dm-ioctl.h>
diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	Thu Sep 25 18:33:02 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_linux.c	Thu Sep 25 18:33:23 2003
@@ -1554,7 +1554,11 @@
         u32 totalswap;
         u32 freeswap;
         unsigned short procs;
-        char _f[22];
+	unsigned short pads;
+	u32 totalhigh;
+	u32 freehigh;
+	unsigned int mem_unit;
+        char _f[8];
 };
 
 extern asmlinkage int sys_sysinfo(struct sysinfo *info);
@@ -1579,6 +1583,9 @@
 	err |= __put_user (s.totalswap, &info->totalswap);
 	err |= __put_user (s.freeswap, &info->freeswap);
 	err |= __put_user (s.procs, &info->procs);
+	err |= __put_user (s.totalhigh, &info->totalhigh);
+	err |= __put_user (s.freehigh, &info->freehigh);
+	err |= __put_user (s.mem_unit, &info->mem_unit);
 	if (err)
 		return -EFAULT;
 	return ret;
@@ -2581,10 +2588,10 @@
 	tmp.__st_ino = (u32)stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = (unsigned int)stat->nlink;
-	tmp.uid = stat->uid;
-	tmp.gid = stat->gid;
+	tmp.st_uid = stat->uid;
+	tmp.st_gid = stat->gid;
 	tmp.st_rdev = huge_encode_dev(stat->rdev);
-	tmp.st_size = stat->st_size;
+	tmp.st_size = stat->size;
 	tmp.st_blksize = (u32)stat->blksize;
 	tmp.st_blocks = (u32)stat->blocks;
 	tmp.st_atime = (u32)stat->atime.tv_sec;
@@ -2773,7 +2780,6 @@
 {
         unsigned long clone_flags;
         unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;
 
         clone_flags = regs.gprs[3] & 0xffffffffUL;
@@ -2782,7 +2788,8 @@
 	child_tidptr = (int *) (regs.gprs[5] & 0x7fffffffUL);
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
-		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+        return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
+		       parent_tidptr, child_tidptr);
 }
+
+
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Mon Sep  8 21:50:28 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Thu Sep 25 18:33:23 2003
@@ -563,6 +563,10 @@
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
 		switch (regs->gprs[2]) {
+			case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fn =
+					do_no_restart_syscall;
+				clear_thread_flag(TIF_RESTART_SVC);
 			case -ERESTARTNOHAND:
 				regs->gprs[2] = -EINTR;
 				break;
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Mon Sep  8 21:50:24 2003
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Thu Sep 25 18:33:23 2003
@@ -321,9 +321,18 @@
 			/* Fake a 31 bit psw address. */
 			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
 				PSW32_ADDR_AMODE31;
-		} else
+		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+			/* gpr 0-15 */
 			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
 					 addr*2 + 4);
+		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
+			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
+			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
+		} else {
+			/* orig gpr 2 */
+			offset = PT_ORIGGPR2 + 4;
+			tmp = *(__u32*)((addr_t) __KSTK_PTREGS(child) + offset);
+		}
 	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
 		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
@@ -387,9 +396,17 @@
 			/* Build a 64 bit psw address from 31 bit address. */
 			__KSTK_PTREGS(child)->psw.addr = 
 				(__u64) tmp & PSW32_ADDR_INSN;
-		} else
+		} else if (addr < (addr_t) &dummy32->regs.acrs[0]) {
+			/* gpr 0-15 */
 			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
 				tmp;
+		} else if (addr < (addr_t) &dummy32->regs.orig_gpr2) {
+			offset = PT_ACR0 + addr - (addr_t) &dummy32->regs.acrs;
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
+		} else {
+			offset = PT_ORIGGPR2 + 4;
+			*(__u32*)((addr_t) __KSTK_PTREGS(child) + offset) = tmp;
+		}
 	} else if (addr >= (addr_t) &dummy32->regs.fp_regs &&
 		   addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
