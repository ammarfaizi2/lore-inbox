Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUBPFQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 00:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUBPFQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 00:16:44 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:449 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263637AbUBPFQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 00:16:24 -0500
Date: Sun, 15 Feb 2004 21:13:43 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] syscalls.h #10
Message-Id: <20040215211343.6f8cba53.randy.dunlap@verizon.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [4.5.45.142] at Sun, 15 Feb 2004 23:16:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I'll rediff etc. if this interferes with work on __KERNEL_SYSCALLS__)

applies_to:	linux-263-rc2-mm1
description:	add arch-specific:
		  sys_ioperm, sys_iopl,
		  sys_request_irq, sys_free_irq,
		  sys_pread_wrapper, sys_pwrite_wrapper;
		add generic:
		  sys_statfs family, sys_msync,
		  sys_fadvise family, sys_mlockall/unlockall,
		  sys_madvise, sys_mincore,
		remove the only compat_sys_* from syscalls.h;

diffstat:=
 arch/h8300/kernel/sys_h8300.c     |    2 +-
 arch/ia64/ia32/sys_ia32.c         |    4 ----
 arch/m68k/amiga/amiints.c         |    1 +
 arch/m68k/bvme6000/bvmeints.c     |    1 +
 arch/m68k/hp300/time.c            |    1 +
 arch/m68k/kernel/sys_m68k.c       |    2 +-
 arch/m68k/mac/iop.c               |    1 +
 arch/m68k/mac/macints.c           |    2 +-
 arch/m68k/mac/oss.c               |    1 +
 arch/m68k/mac/psc.c               |    1 +
 arch/m68k/mac/via.c               |    2 +-
 arch/m68k/q40/q40ints.c           |    1 +
 arch/m68k/sun3/sun3ints.c         |    1 +
 arch/m68knommu/kernel/sys_m68k.c  |    2 +-
 arch/parisc/hpux/sys_hpux.c       |    1 -
 arch/parisc/kernel/sys_parisc.c   |    2 +-
 arch/ppc64/kernel/signal32.c      |    1 +
 arch/ppc64/kernel/sys_ppc32.c     |    2 --
 arch/s390/kernel/sys_s390.c       |    2 +-
 arch/sparc64/kernel/setup.c       |    2 +-
 arch/sparc64/kernel/sys_sparc32.c |    4 +---
 arch/x86_64/ia32/sys_ia32.c       |    2 --
 drivers/char/vt_ioctl.c           |    2 +-
 include/asm-h8300/unistd.h        |    1 +
 include/asm-i386/unistd.h         |    1 +
 include/asm-m68k/irq.h            |    5 -----
 include/asm-m68k/unistd.h         |    8 ++++++++
 include/asm-m68knommu/irq.h       |    5 -----
 include/asm-m68knommu/unistd.h    |    8 ++++++++
 include/asm-parisc/unistd.h       |    1 +
 include/asm-ppc64/signal.h        |    9 ---------
 include/asm-s390/unistd.h         |    1 +
 include/asm-sh/unistd.h           |    4 ++++
 include/asm-sparc/unistd.h        |    1 +
 include/asm-sparc64/unistd.h      |    3 ++-
 include/asm-x86_64/unistd.h       |    2 ++
 include/linux/syscalls.h          |   27 ++++++++++++++++++++-------
 37 files changed, 68 insertions(+), 48 deletions(-)


diff -Naurp ./arch/m68knommu/kernel/sys_m68k.c~sysaddrem ./arch/m68knommu/kernel/sys_m68k.c
--- ./arch/m68knommu/kernel/sys_m68k.c~sysaddrem	2004-02-14 19:28:53.000000000 -0800
+++ ./arch/m68knommu/kernel/sys_m68k.c	2004-02-14 19:27:39.000000000 -0800
@@ -193,7 +193,7 @@ asmlinkage int sys_ipc (uint call, int f
 	return -EINVAL;
 }
 
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
 {
   return -ENOSYS;
 }
diff -Naurp ./arch/sparc64/kernel/sys_sparc32.c~sysaddrem ./arch/sparc64/kernel/sys_sparc32.c
--- ./arch/sparc64/kernel/sys_sparc32.c~sysaddrem	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/sparc64/kernel/sys_sparc32.c	2004-02-14 20:05:35.000000000 -0800
@@ -282,9 +282,7 @@ static inline long put_tv32(struct compa
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-extern asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
-
-asmlinkage int sys32_ioperm(u32 from, u32 num, int on)
+asmlinkage long sys32_ioperm(u32 from, u32 num, int on)
 {
 	return sys_ioperm((unsigned long)from, (unsigned long)num, on);
 }
diff -Naurp ./arch/sparc64/kernel/setup.c~sysaddrem ./arch/sparc64/kernel/setup.c
--- ./arch/sparc64/kernel/setup.c~sysaddrem	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/sparc64/kernel/setup.c	2004-02-14 20:05:10.000000000 -0800
@@ -603,7 +603,7 @@ static int __init set_preferred_console(
 }
 console_initcall(set_preferred_console);
 
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
 {
 	return -EIO;
 }
diff -Naurp ./arch/m68k/kernel/sys_m68k.c~sysaddrem ./arch/m68k/kernel/sys_m68k.c
--- ./arch/m68k/kernel/sys_m68k.c~sysaddrem	2004-02-12 09:30:03.000000000 -0800
+++ ./arch/m68k/kernel/sys_m68k.c	2004-02-14 19:31:51.000000000 -0800
@@ -261,7 +261,7 @@ asmlinkage int sys_ipc (uint call, int f
 	return -EINVAL;
 }
 
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
 {
   return -ENOSYS;
 }
diff -Naurp ./arch/m68k/hp300/time.c~sysaddrem ./arch/m68k/hp300/time.c
--- ./arch/m68k/hp300/time.c~sysaddrem	2004-02-03 19:44:15.000000000 -0800
+++ ./arch/m68k/hp300/time.c	2004-02-14 22:01:18.000000000 -0800
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/traps.h>
+#include <asm/unistd.h>
 #include "ints.h"
 
 /* Clock hardware definitions */
diff -Naurp ./arch/m68k/q40/q40ints.c~sysaddrem ./arch/m68k/q40/q40ints.c
--- ./arch/m68k/q40/q40ints.c~sysaddrem	2004-02-03 19:44:30.000000000 -0800
+++ ./arch/m68k/q40/q40ints.c	2004-02-14 22:01:00.000000000 -0800
@@ -26,6 +26,7 @@
 #include <asm/irq.h>
 #include <asm/hardirq.h>
 #include <asm/traps.h>
+#include <asm/unistd.h>
 
 #include <asm/q40_master.h>
 #include <asm/q40ints.h>
diff -Naurp ./arch/m68k/sun3/sun3ints.c~sysaddrem ./arch/m68k/sun3/sun3ints.c
--- ./arch/m68k/sun3/sun3ints.c~sysaddrem	2004-02-03 19:45:07.000000000 -0800
+++ ./arch/m68k/sun3/sun3ints.c	2004-02-14 22:00:38.000000000 -0800
@@ -15,6 +15,7 @@
 #include <asm/intersil.h>
 #include <asm/oplib.h>
 #include <asm/sun3ints.h>
+#include <asm/unistd.h>
 #include <linux/seq_file.h>
 
 extern void sun3_leds (unsigned char);
diff -Naurp ./arch/m68k/amiga/amiints.c~sysaddrem ./arch/m68k/amiga/amiints.c
--- ./arch/m68k/amiga/amiints.c~sysaddrem	2004-02-03 19:45:08.000000000 -0800
+++ ./arch/m68k/amiga/amiints.c	2004-02-14 22:00:09.000000000 -0800
@@ -49,6 +49,7 @@
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <asm/amipcmcia.h>
+#include <asm/unistd.h>
 
 extern int cia_request_irq(struct ciabase *base,int irq,
                            irqreturn_t (*handler)(int, void *, struct pt_regs *),
diff -Naurp ./arch/m68k/bvme6000/bvmeints.c~sysaddrem ./arch/m68k/bvme6000/bvmeints.c
--- ./arch/m68k/bvme6000/bvmeints.c~sysaddrem	2004-02-03 19:43:12.000000000 -0800
+++ ./arch/m68k/bvme6000/bvmeints.c	2004-02-14 21:59:49.000000000 -0800
@@ -20,6 +20,7 @@
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
+#include <asm/unistd.h>
 
 static irqreturn_t bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp);
 
diff -Naurp ./arch/m68k/mac/via.c~sysaddrem ./arch/m68k/mac/via.c
--- ./arch/m68k/mac/via.c~sysaddrem	2004-02-03 19:43:43.000000000 -0800
+++ ./arch/m68k/mac/via.c	2004-02-14 21:59:20.000000000 -0800
@@ -23,7 +23,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-
 #include <linux/ide.h>
 
 #include <asm/traps.h>
@@ -33,6 +32,7 @@
 #include <asm/machw.h> 
 #include <asm/mac_via.h>
 #include <asm/mac_psc.h>
+#include <asm/unistd.h>
 
 volatile __u8 *via1, *via2;
 #if 0
diff -Naurp ./arch/m68k/mac/oss.c~sysaddrem ./arch/m68k/mac/oss.c
--- ./arch/m68k/mac/oss.c~sysaddrem	2004-02-03 19:43:46.000000000 -0800
+++ ./arch/m68k/mac/oss.c	2004-02-14 21:59:02.000000000 -0800
@@ -26,6 +26,7 @@
 #include <asm/macints.h>
 #include <asm/mac_via.h>
 #include <asm/mac_oss.h>
+#include <asm/unistd.h>
 
 int oss_present;
 volatile struct mac_oss *oss;
diff -Naurp ./arch/m68k/mac/psc.c~sysaddrem ./arch/m68k/mac/psc.c
--- ./arch/m68k/mac/psc.c~sysaddrem	2004-02-03 19:43:56.000000000 -0800
+++ ./arch/m68k/mac/psc.c	2004-02-14 21:58:50.000000000 -0800
@@ -24,6 +24,7 @@
 #include <asm/macintosh.h> 
 #include <asm/macints.h> 
 #include <asm/mac_psc.h>
+#include <asm/unistd.h>
 
 #define DEBUG_PSC
 
diff -Naurp ./arch/m68k/mac/macints.c~sysaddrem ./arch/m68k/mac/macints.c
--- ./arch/m68k/mac/macints.c~sysaddrem	2004-02-03 19:44:27.000000000 -0800
+++ ./arch/m68k/mac/macints.c	2004-02-14 21:58:33.000000000 -0800
@@ -132,8 +132,8 @@
 #include <asm/mac_psc.h>
 #include <asm/hwtest.h>
 #include <asm/errno.h>
-
 #include <asm/macints.h>
+#include <asm/unistd.h>
 
 #define DEBUG_SPURIOUS
 #define SHUTUP_SONIC
diff -Naurp ./arch/m68k/mac/iop.c~sysaddrem ./arch/m68k/mac/iop.c
--- ./arch/m68k/mac/iop.c~sysaddrem	2004-02-03 19:44:43.000000000 -0800
+++ ./arch/m68k/mac/iop.c	2004-02-14 21:58:00.000000000 -0800
@@ -118,6 +118,7 @@
 #include <asm/macints.h> 
 #include <asm/mac_iop.h>
 #include <asm/mac_oss.h>
+#include <asm/unistd.h>
 
 /*#define DEBUG_IOP*/
 
diff -Naurp ./arch/ia64/ia32/sys_ia32.c~sysaddrem ./arch/ia64/ia32/sys_ia32.c
--- ./arch/ia64/ia32/sys_ia32.c~sysaddrem	2004-02-12 09:30:03.000000000 -0800
+++ ./arch/ia64/ia32/sys_ia32.c	2004-02-14 19:09:53.000000000 -0800
@@ -2273,8 +2273,6 @@ sys32_pause (void)
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage long sys_msync (unsigned long start, size_t len, int flags);
-
 asmlinkage int
 sys32_msync (unsigned int start, unsigned int len, int flags)
 {
@@ -2960,8 +2958,6 @@ sys32_timer_create(u32 clock, struct sig
 	return err;
 }
 
-extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
-
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
 { 
diff -Naurp ./arch/ppc64/kernel/sys_ppc32.c~sysaddrem ./arch/ppc64/kernel/sys_ppc32.c
--- ./arch/ppc64/kernel/sys_ppc32.c~sysaddrem	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/ppc64/kernel/sys_ppc32.c	2004-02-14 19:07:52.000000000 -0800
@@ -2768,8 +2768,6 @@ long ppc32_lookup_dcookie(u32 cookie_hig
 				  buf, len);
 }
 
-extern int sys_fadvise64(int fd, loff_t offset, size_t len, int advice);
-
 long ppc32_fadvise64(int fd, u32 unused, u32 offset_high, u32 offset_low,
 		     size_t len, int advice)
 {
diff -Naurp ./arch/ppc64/kernel/signal32.c~sysaddrem ./arch/ppc64/kernel/signal32.c
--- ./arch/ppc64/kernel/signal32.c~sysaddrem	2004-02-03 19:44:38.000000000 -0800
+++ ./arch/ppc64/kernel/signal32.c	2004-02-14 21:24:32.000000000 -0800
@@ -21,6 +21,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
+#include <linux/syscalls.h>
 #include <linux/errno.h>
 #include <linux/elf.h>
 #include <linux/compat.h>
diff -Naurp ./arch/parisc/kernel/sys_parisc.c~sysaddrem ./arch/parisc/kernel/sys_parisc.c
--- ./arch/parisc/kernel/sys_parisc.c~sysaddrem	2004-02-14 19:32:23.000000000 -0800
+++ ./arch/parisc/kernel/sys_parisc.c	2004-02-14 19:32:42.000000000 -0800
@@ -245,7 +245,7 @@ asmlinkage ssize_t parisc_readahead(int 
 /*
  * This changes the io permissions bitmap in the current task.
  */
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	return -ENOSYS;
 }
diff -Naurp ./arch/parisc/hpux/sys_hpux.c~sysaddrem ./arch/parisc/hpux/sys_hpux.c
--- ./arch/parisc/hpux/sys_hpux.c~sysaddrem	2004-02-12 09:30:03.000000000 -0800
+++ ./arch/parisc/hpux/sys_hpux.c	2004-02-14 18:55:55.000000000 -0800
@@ -211,7 +211,6 @@ int hpux_statfs(const char *path, struct
 	kfree(kpath);
 
 	/* just fake it, beginning of structures match */
-	extern int sys_statfs(const char *, struct statfs *);
 	error = sys_statfs(path, (struct statfs *) buf);
 
 	/* ignoring rest of statfs struct, but it should be zeros. Need to do 
diff -Naurp ./arch/h8300/kernel/sys_h8300.c~sysaddrem ./arch/h8300/kernel/sys_h8300.c
--- ./arch/h8300/kernel/sys_h8300.c~sysaddrem	2004-02-12 09:30:03.000000000 -0800
+++ ./arch/h8300/kernel/sys_h8300.c	2004-02-14 19:33:50.000000000 -0800
@@ -260,7 +260,7 @@ asmlinkage int sys_ipc (uint call, int f
 	return -EINVAL;
 }
 
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
 {
   return -ENOSYS;
 }
diff -Naurp ./arch/x86_64/ia32/sys_ia32.c~sysaddrem ./arch/x86_64/ia32/sys_ia32.c
--- ./arch/x86_64/ia32/sys_ia32.c~sysaddrem	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/x86_64/ia32/sys_ia32.c	2004-02-14 19:05:42.000000000 -0800
@@ -1841,8 +1841,6 @@ sys32_timer_create(u32 clock, struct sig
 	return err; 
 } 
 
-extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
-
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
 { 
diff -Naurp ./arch/s390/kernel/sys_s390.c~sysaddrem ./arch/s390/kernel/sys_s390.c
--- ./arch/s390/kernel/sys_s390.c~sysaddrem	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/s390/kernel/sys_s390.c	2004-02-14 19:35:00.000000000 -0800
@@ -289,7 +289,7 @@ asmlinkage int sys_olduname(struct oldol
 	return error;
 }
 
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
 {
 	return -ENOSYS;
 }
diff -Naurp ./drivers/char/vt_ioctl.c~sysaddrem ./drivers/char/vt_ioctl.c
--- ./drivers/char/vt_ioctl.c~sysaddrem	2004-02-12 09:28:43.000000000 -0800
+++ ./drivers/char/vt_ioctl.c	2004-02-14 19:38:22.000000000 -0800
@@ -60,7 +60,7 @@ struct vt_struct *vt_cons[MAX_NR_CONSOLE
 unsigned char keyboard_type = KB_101;
 
 #ifdef CONFIG_X86
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
+#include <linux/syscalls.h>
 #endif
 
 /*
diff -Naurp ./include/asm-ppc64/signal.h~sysaddrem ./include/asm-ppc64/signal.h
--- ./include/asm-ppc64/signal.h~sysaddrem	2004-02-03 19:43:43.000000000 -0800
+++ ./include/asm-ppc64/signal.h	2004-02-14 22:12:41.000000000 -0800
@@ -148,15 +148,6 @@ struct pt_regs;
 struct timespec;
 extern int do_signal(sigset_t *oldset, struct pt_regs *regs);
 extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
-extern long sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset,
-			       size_t sigsetsize);
-extern long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
-extern long sys_rt_sigtimedwait(const sigset_t *uthese, siginfo_t *uinfo,
-				const struct timespec *uts, size_t sigsetsize);
-extern long sys_rt_sigqueueinfo(int pid, int sig, siginfo_t *uinfo);
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 
-struct pt_regs;
-int do_signal32(sigset_t *oldset, struct pt_regs *regs);
-
 #endif /* _ASMPPC64_SIGNAL_H */
diff -Naurp ./include/asm-x86_64/unistd.h~sysaddrem ./include/asm-x86_64/unistd.h
--- ./include/asm-x86_64/unistd.h~sysaddrem	2004-02-12 16:50:58.000000000 -0800
+++ ./include/asm-x86_64/unistd.h	2004-02-14 21:09:09.000000000 -0800
@@ -719,6 +719,8 @@ asmlinkage long sys_pipe(int *fildes);
 
 asmlinkage long sys_ptrace(long request, long pid,
 				unsigned long addr, long data);
+asmlinkage long sys_iopl(unsigned int level, struct pt_regs regs);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 
 #endif	/* __ASSEMBLY__ */
 
diff -Naurp ./include/asm-parisc/unistd.h~sysaddrem ./include/asm-parisc/unistd.h
--- ./include/asm-parisc/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-parisc/unistd.h	2004-02-14 20:07:57.000000000 -0800
@@ -907,6 +907,7 @@ int sys_clone(unsigned long clone_flags,
 int sys_vfork(struct pt_regs *regs);
 int sys_pipe(int *fildes);
 long sys_ptrace(long request, pid_t pid, long addr, long data);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 
 #endif	/* __KERNEL_SYSCALLS__ */
 
diff -Naurp ./include/linux/syscalls.h~sysaddrem ./include/linux/syscalls.h
--- ./include/linux/syscalls.h~sysaddrem	2004-02-13 15:12:57.000000000 -0800
+++ ./include/linux/syscalls.h	2004-02-14 22:31:16.000000000 -0800
@@ -11,7 +11,6 @@
 #ifndef _LINUX_SYSCALLS_H
 #define _LINUX_SYSCALLS_H
 
-struct compat_timespec;
 struct epoll_event;
 struct iattr;
 struct inode;
@@ -39,6 +38,8 @@ struct shmid_ds;
 struct sockaddr;
 struct stat;
 struct stat64;
+struct statfs;
+struct statfs64;
 struct __sysctl_args;
 struct sysinfo;
 struct timespec;
@@ -161,10 +162,6 @@ asmlinkage long sys_waitpid(pid_t pid, u
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
 			struct timespec __user *utime, u32 __user *uaddr2);
-#ifdef CONFIG_FUTEX
-asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
-			struct compat_timespec *utime, u32 *uaddr2);
-#endif
 
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
@@ -205,6 +202,13 @@ asmlinkage long sys_truncate(const char 
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 asmlinkage long sys_stat(char __user *filename,
 			struct __old_kernel_stat __user *statbuf);
+asmlinkage long sys_statfs(const char __user * path,
+				struct statfs __user *buf);
+asmlinkage long sys_statfs64(const char __user *path, size_t sz,
+				struct statfs64 __user *buf);
+asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
+asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
+				struct statfs64 __user *buf);
 asmlinkage long sys_lstat(char __user *filename,
 			struct __old_kernel_stat __user *statbuf);
 asmlinkage long sys_fstat(unsigned int fd,
@@ -255,10 +259,17 @@ asmlinkage unsigned long sys_mremap(unsi
 long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
-long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
+asmlinkage long sys_msync(unsigned long start, size_t len, int flags);
+asmlinkage long sys_fadvise64(int fd, loff_t offset, size_t len, int advice);
+asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 asmlinkage long sys_munmap(unsigned long addr, size_t len);
 asmlinkage long sys_mlock(unsigned long start, size_t len);
 asmlinkage long sys_munlock(unsigned long start, size_t len);
+asmlinkage long sys_mlockall(int flags);
+asmlinkage long sys_munlockall(void);
+asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
+asmlinkage long sys_mincore(unsigned long start, size_t len,
+				unsigned char __user * vec);
 
 asmlinkage long sys_pivot_root(const char __user *new_root,
 				const char __user *put_old);
@@ -281,6 +292,7 @@ asmlinkage long sys_fcntl64(unsigned int
 #endif
 asmlinkage long sys_dup(unsigned int fildes);
 asmlinkage long sys_dup2(unsigned int oldfd, unsigned int newfd);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
 asmlinkage long sys_flock(unsigned int fd, unsigned int cmd);
@@ -436,7 +448,8 @@ asmlinkage long sys_semctl(int semid, in
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
 				const struct timespec __user *timeout);
-long sys_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr,
+				int shmflg, unsigned long *addr);
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt(char __user *shmaddr);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
diff -Naurp ./include/asm-m68k/unistd.h~sysaddrem ./include/asm-m68k/unistd.h
--- ./include/asm-m68k/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-m68k/unistd.h	2004-02-14 21:47:56.000000000 -0800
@@ -339,6 +339,8 @@ __syscall_return(type,__res); \
 
 #ifdef __KERNEL_SYSCALLS__
 
+#include <linux/interrupt.h>
+
 /*
  * we need this inline - forking from kernel space will result
  * in NO COPY ON WRITE (!!!), until an execve is executed. This
@@ -370,6 +372,12 @@ asmlinkage long sys_mmap2(
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
+struct pt_regs;
+int sys_request_irq(unsigned int, 
+			irqreturn_t (*)(int, void *, struct pt_regs *), 
+			unsigned long, const char *, void *);
+void sys_free_irq(unsigned int, void *);
 
 #endif
 
diff -Naurp ./include/asm-m68k/irq.h~sysaddrem ./include/asm-m68k/irq.h
--- ./include/asm-m68k/irq.h~sysaddrem	2004-02-03 19:44:04.000000000 -0800
+++ ./include/asm-m68k/irq.h	2004-02-14 21:43:10.000000000 -0800
@@ -76,11 +76,6 @@ extern void (*disable_irq)(unsigned int)
 
 struct pt_regs;
 
-extern int sys_request_irq(unsigned int, 
-	irqreturn_t (*)(int, void *, struct pt_regs *), 
-	unsigned long, const char *, void *);
-extern void sys_free_irq(unsigned int, void *);
-
 /*
  * various flags for request_irq() - the Amiga now uses the standard
  * mechanism like all other architectures - SA_INTERRUPT and SA_SHIRQ
diff -Naurp ./include/asm-m68knommu/unistd.h~sysaddrem ./include/asm-m68knommu/unistd.h
--- ./include/asm-m68knommu/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-m68knommu/unistd.h	2004-02-14 21:48:09.000000000 -0800
@@ -375,6 +375,8 @@ type name(atype a, btype b, ctype c, dty
 
 #ifdef __KERNEL_SYSCALLS__
 
+#include <linux/interrupt.h>
+
 /*
  * we need this inline - forking from kernel space will result
  * in NO COPY ON WRITE (!!!), until an execve is executed. This
@@ -412,6 +414,12 @@ asmlinkage long sys_mmap2(unsigned long 
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
+struct pt_regs;
+int sys_request_irq(unsigned int, 
+			irqreturn_t (*)(int, void *, struct pt_regs *), 
+			unsigned long, const char *, void *);
+void sys_free_irq(unsigned int, void *);
 
 #endif
 
diff -Naurp ./include/asm-m68knommu/irq.h~sysaddrem ./include/asm-m68knommu/irq.h
--- ./include/asm-m68knommu/irq.h~sysaddrem	2004-02-03 19:43:49.000000000 -0800
+++ ./include/asm-m68knommu/irq.h	2004-02-14 21:46:37.000000000 -0800
@@ -62,11 +62,6 @@
 extern void (*mach_enable_irq)(unsigned int);
 extern void (*mach_disable_irq)(unsigned int);
 
-extern int sys_request_irq(unsigned int, 
-	irqreturn_t (*)(int, void *, struct pt_regs *), 
-	unsigned long, const char *, void *);
-extern void sys_free_irq(unsigned int, void *);
-
 /*
  * various flags for request_irq() - the Amiga now uses the standard
  * mechanism like all other architectures - SA_INTERRUPT and SA_SHIRQ
diff -Naurp ./include/asm-sparc/unistd.h~sysaddrem ./include/asm-sparc/unistd.h
--- ./include/asm-sparc/unistd.h~sysaddrem	2004-02-14 20:00:02.000000000 -0800
+++ ./include/asm-sparc/unistd.h	2004-02-14 19:59:11.000000000 -0800
@@ -458,6 +458,7 @@ asmlinkage unsigned long sys_mmap2(
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long pgoff);
+asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
 
 #endif /* __KERNEL_SYSCALLS__ */
 
diff -Naurp ./include/asm-i386/unistd.h~sysaddrem ./include/asm-i386/unistd.h
--- ./include/asm-i386/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-i386/unistd.h	2004-02-14 19:45:09.000000000 -0800
@@ -410,6 +410,7 @@ asmlinkage int sys_fork(struct pt_regs r
 asmlinkage int sys_vfork(struct pt_regs regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_iopl(unsigned long unused);
 
 #endif
 
diff -Naurp ./include/asm-s390/unistd.h~sysaddrem ./include/asm-s390/unistd.h
--- ./include/asm-s390/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-s390/unistd.h	2004-02-14 21:06:02.000000000 -0800
@@ -552,6 +552,7 @@ asmlinkage int sys_vfork(struct pt_regs 
 #endif /* CONFIG_ARCH_S390X */
 asmlinkage __SYS_RETTYPE sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 #endif
 
diff -Naurp ./include/asm-h8300/unistd.h~sysaddrem ./include/asm-h8300/unistd.h
--- ./include/asm-h8300/unistd.h~sysaddrem	2004-02-14 21:05:01.000000000 -0800
+++ ./include/asm-h8300/unistd.h	2004-02-14 21:04:30.000000000 -0800
@@ -486,6 +486,7 @@ asmlinkage int sys_execve(char *name, ch
 			int dummy, ...);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 #endif
 
diff -Naurp ./include/asm-sparc64/unistd.h~sysaddrem ./include/asm-sparc64/unistd.h
--- ./include/asm-sparc64/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-sparc64/unistd.h	2004-02-14 20:03:40.000000000 -0800
@@ -440,10 +440,11 @@ static __inline__ _syscall1(int,close,in
 static __inline__ _syscall1(int,_exit,int,exitcode)
 static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
-extern asmlinkage unsigned long sys_mmap(
+asmlinkage unsigned long sys_mmap(
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long off);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 #endif /* __KERNEL_SYSCALLS__ */
 
diff -Naurp ./include/asm-sh/unistd.h~sysaddrem ./include/asm-sh/unistd.h
--- ./include/asm-sh/unistd.h~sysaddrem	2004-02-12 09:30:09.000000000 -0800
+++ ./include/asm-sh/unistd.h	2004-02-14 22:06:44.000000000 -0800
@@ -457,6 +457,10 @@ asmlinkage int sys_pipe(unsigned long r4
 			unsigned long r6, unsigned long r7,
 			struct pt_regs regs);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char *buf,
+				size_t count, long dummy, loff_t pos);
+asmlinkage ssize_t sys_pwrite_wrapper(unsigned int fd, const char *buf,
+				size_t count, long dummy, loff_t pos);
 
 #endif
 


--
~Randy
