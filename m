Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUB0TJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUB0TJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:09:17 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:25496 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262920AbUB0TFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:05:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: arjanv@redhat.com
Subject: Re: [PATCH] further __KERNEL_SYSCALLS__ removal
Date: Fri, 27 Feb 2004 19:57:47 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
References: <200402271835.48649.arnd@arndb.de> <1077904855.10066.2.camel@laptop.fenrus.com>
In-Reply-To: <1077904855.10066.2.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402271957.47235.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 19:00, Arjan van de Ven wrote:
> On Fri, 2004-02-27 at 18:35, Arnd Bergmann wrote:
> > ===== drivers/media/dvb/frontends/alps_tdlb7.c 1.8 vs edited =====
> > --- 1.8/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 03:09:55 2004
> > +++ edited/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 23:57:05

>
> this is the wrong way to "fix" this; might as well leave this driver as
> is until it is fixed to use request_firmware()

My idea was to finally eliminate __KERNEL_SYSCALLS__ without breaking
the in-tree drivers, so I changed all I could.
This patch leaves the syscalls in device drivers and fixes all
necessary uses in init/*.c.
Maybe we can find a better solution for calling execve in do_linuxrc(),
run_init_process() and ____call_usermodehelper(). Then a #warning can
be added __KERNEL_SYSCALLS__ is defined.

arch/alpha/kernel/alpha_ksyms.c          |    3 ---
arch/alpha/kernel/smp.c                  |    3 ---
arch/cris/kernel/process.c               |    2 --
arch/parisc/kernel/process.c             |    3 ---
arch/parisc/kernel/smp.c                 |    1 -
arch/ppc/kernel/misc.S                   |   10 ----------
arch/ppc/kernel/ppc_ksyms.c              |    6 ------
arch/ppc/kernel/smp.c                    |    2 --
arch/ppc/platforms/chrp_smp.c            |    2 --
arch/ppc/platforms/pmac_smp.c            |    2 --
arch/ppc64/kernel/misc.S                 |   10 ----------
arch/ppc64/kernel/pmac_smp.c             |    2 --
arch/sparc/kernel/process.c              |    2 --
arch/sparc/kernel/smp.c                  |    3 ---
arch/sparc/kernel/sun4d_smp.c            |    3 ---
arch/sparc/kernel/sun4m_smp.c            |    3 ---
arch/sparc64/kernel/process.c            |    3 ---
arch/sparc64/kernel/smp.c                |    3 ---
arch/x86_64/kernel/process.c             |    2 --
drivers/macintosh/mediabay.c             |    3 ---
drivers/scsi/cpqfcTSinit.c               |    4 ----
drivers/scsi/oktagon_esp.c               |    3 ---
init/do_mounts.c                         |   24 ++++++++++++------------
init/do_mounts.h                         |    1 -
init/do_mounts_devfs.c                   |    8 ++++----
init/do_mounts_initrd.c                  |   29 +++++++++++++++--------------
init/do_mounts_md.c                      |   10 +++++-----
init/do_mounts_rd.c                      |   30 +++++++++++++++---------------
init/initramfs.c                         |    2 --
init/main.c                              |    8 +++---

===== arch/alpha/kernel/alpha_ksyms.c 1.35 vs edited =====
--- 1.35/arch/alpha/kernel/alpha_ksyms.c	Thu Feb 26 02:53:42 2004
+++ edited/arch/alpha/kernel/alpha_ksyms.c	Thu Feb 26 23:57:05 2004
@@ -35,9 +35,6 @@
 #include <asm/cacheflush.h>
 #include <asm/vga.h>
 
-#define __KERNEL_SYSCALLS__
-#include <asm/unistd.h>
-
 extern struct hwrpb_struct *hwrpb;
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
===== arch/alpha/kernel/smp.c 1.39 vs edited =====
--- 1.39/arch/alpha/kernel/smp.c	Wed Oct  8 04:53:37 2003
+++ edited/arch/alpha/kernel/smp.c	Thu Feb 26 23:57:05 2004
@@ -39,9 +39,6 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-#define __KERNEL_SYSCALLS__
-#include <asm/unistd.h>
-
 #include "proto.h"
 #include "irq_impl.h"
 
===== arch/cris/kernel/process.c 1.14 vs edited =====
--- 1.14/arch/cris/kernel/process.c	Wed Oct  8 04:53:37 2003
+++ edited/arch/cris/kernel/process.c	Thu Feb 26 23:57:05 2004
@@ -91,8 +91,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <asm/atomic.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
===== arch/parisc/kernel/process.c 1.14 vs edited =====
--- 1.14/arch/parisc/kernel/process.c	Wed Feb  4 06:41:56 2004
+++ edited/arch/parisc/kernel/process.c	Thu Feb 26 23:57:05 2004
@@ -1,5 +1,3 @@
-/*
- *    PARISC Architecture-dependent parts of process handling
  *    based on the work for i386
  *
  *    Copyright (C) 1999-2003 Matthew Wilcox <willy at parisc-linux.org>
@@ -32,7 +30,6 @@
  *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/elf.h>
===== arch/parisc/kernel/smp.c 1.9 vs edited =====
--- 1.9/arch/parisc/kernel/smp.c	Thu Dec 18 06:48:39 2003
+++ edited/arch/parisc/kernel/smp.c	Thu Feb 26 23:57:05 2004
@@ -16,7 +16,6 @@
 **      the Free Software Foundation; either version 2 of the License, or
 **      (at your option) any later version.
 */
-#define __KERNEL_SYSCALLS__
 #undef ENTRY_SYS_CPUS	/* syscall support for iCOD-like functionality */
 
 #include <linux/autoconf.h>
===== arch/ppc/kernel/misc.S 1.52 vs edited =====
--- 1.52/arch/ppc/kernel/misc.S	Fri Feb 13 16:24:55 2004
+++ edited/arch/ppc/kernel/misc.S	Thu Feb 26 23:57:05 2004
@@ -1108,17 +1108,7 @@
 	li	r3,-1; \
 	blr
 
-#define __NR__exit __NR_exit
-
-SYSCALL(setsid)
-SYSCALL(open)
-SYSCALL(read)
-SYSCALL(write)
-SYSCALL(lseek)
-SYSCALL(close)
-SYSCALL(dup)
 SYSCALL(execve)
-SYSCALL(waitpid)
 
 /* Why isn't this a) automatic, b) written in 'C'? */
 	.data
===== arch/ppc/kernel/ppc_ksyms.c 1.52 vs edited =====
--- 1.52/arch/ppc/kernel/ppc_ksyms.c	Thu Feb  5 06:59:19 2004
+++ edited/arch/ppc/kernel/ppc_ksyms.c	Thu Feb 26 23:57:05 2004
@@ -32,8 +32,6 @@
 #include <linux/pmu.h>
 #include <asm/prom.h>
 #include <asm/system.h>
-#define __KERNEL_SYSCALLS__
-#include <asm/unistd.h>
 #include <asm/pci-bridge.h>
 #include <asm/irq.h>
 #include <asm/pmac_feature.h>
@@ -189,10 +187,6 @@
 EXPORT_SYMBOL(flush_dcache_all);
 #endif
 
-EXPORT_SYMBOL(open);
-EXPORT_SYMBOL(read);
-EXPORT_SYMBOL(lseek);
-EXPORT_SYMBOL(close);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);
 
===== arch/ppc/kernel/smp.c 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/smp.c	Thu Feb 26 02:53:43 2004
+++ edited/arch/ppc/kernel/smp.c	Thu Feb 26 23:57:05 2004
@@ -17,8 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
===== arch/ppc/platforms/chrp_smp.c 1.9 vs edited =====
--- 1.9/arch/ppc/platforms/chrp_smp.c	Tue Apr  1 00:29:49 2003
+++ edited/arch/ppc/platforms/chrp_smp.c	Thu Feb 26 23:57:05 2004
@@ -16,8 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 
===== arch/ppc/platforms/pmac_smp.c 1.17 vs edited =====
--- 1.17/arch/ppc/platforms/pmac_smp.c	Thu Feb  5 06:31:23 2004
+++ edited/arch/ppc/platforms/pmac_smp.c	Thu Feb 26 23:57:05 2004
@@ -29,8 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
===== arch/ppc64/kernel/misc.S 1.70 vs edited =====
--- 1.70/arch/ppc64/kernel/misc.S	Thu Feb 26 02:53:43 2004
+++ edited/arch/ppc64/kernel/misc.S	Thu Feb 26 23:57:05 2004
@@ -540,17 +540,7 @@
 	li	r3,-1; \
 	blr
 
-#define __NR__exit __NR_exit
-
-SYSCALL(setsid)
-SYSCALL(open)
-SYSCALL(read)
-SYSCALL(write)
-SYSCALL(lseek)
-SYSCALL(close)
-SYSCALL(dup)
 SYSCALL(execve)
-SYSCALL(waitpid)
 
 #ifdef CONFIG_PPC_ISERIES	/* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
===== arch/ppc64/kernel/pmac_smp.c 1.1 vs edited =====
--- 1.1/arch/ppc64/kernel/pmac_smp.c	Thu Feb 12 04:47:59 2004
+++ edited/arch/ppc64/kernel/pmac_smp.c	Thu Feb 26 23:57:05 2004
@@ -29,8 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
===== arch/sparc/kernel/process.c 1.35 vs edited =====
--- 1.35/arch/sparc/kernel/process.c	Thu Feb 26 02:53:43 2004
+++ edited/arch/sparc/kernel/process.c	Thu Feb 26 23:57:05 2004
@@ -9,7 +9,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/errno.h>
@@ -19,7 +18,6 @@
 #include <linux/kallsyms.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
===== arch/sparc/kernel/smp.c 1.12 vs edited =====
--- 1.12/arch/sparc/kernel/smp.c	Thu Feb 26 02:53:43 2004
+++ edited/arch/sparc/kernel/smp.c	Thu Feb 26 23:57:05 2004
@@ -33,9 +33,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #define IRQ_RESCHEDULE		13
 #define IRQ_STOP_CPU		14
 #define IRQ_CROSS_CALL		15
===== arch/sparc/kernel/sun4d_smp.c 1.13 vs edited =====
--- 1.13/arch/sparc/kernel/sun4d_smp.c	Sat Sep 20 09:54:22 2003
+++ edited/arch/sparc/kernel/sun4d_smp.c	Thu Feb 26 23:57:05 2004
@@ -32,9 +32,6 @@
 #include <asm/sbus.h>
 #include <asm/sbi.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #define IRQ_CROSS_CALL		15
 
 extern ctxd_t *srmmu_ctx_table_phys;
===== arch/sparc/kernel/sun4m_smp.c 1.11 vs edited =====
--- 1.11/arch/sparc/kernel/sun4m_smp.c	Tue Apr  1 00:29:49 2003
+++ edited/arch/sparc/kernel/sun4m_smp.c	Thu Feb 26 23:57:05 2004
@@ -27,9 +27,6 @@
 #include <asm/oplib.h>
 #include <asm/hardirq.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #define IRQ_RESCHEDULE		13
 #define IRQ_STOP_CPU		14
 #define IRQ_CROSS_CALL		15
===== arch/sparc64/kernel/process.c 1.48 vs edited =====
--- 1.48/arch/sparc64/kernel/process.c	Wed Oct  8 04:53:41 2003
+++ edited/arch/sparc64/kernel/process.c	Thu Feb 26 23:57:05 2004
@@ -1,4 +1,3 @@
-/*  $Id: process.c,v 1.131 2002/02/09 19:49:30 davem Exp $
  *  arch/sparc64/kernel/process.c
  *
  *  Copyright (C) 1995, 1996 David S. Miller (davem@caip.rutgers.edu)
@@ -10,7 +9,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/errno.h>
@@ -22,7 +20,6 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
===== arch/sparc64/kernel/smp.c 1.66 vs edited =====
--- 1.66/arch/sparc64/kernel/smp.c	Thu Feb 26 03:09:09 2004
+++ edited/arch/sparc64/kernel/smp.c	Thu Feb 26 23:57:05 2004
@@ -36,9 +36,6 @@
 #include <asm/timer.h>
 #include <asm/starfire.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 extern int linux_num_cpus;
 extern void calibrate_delay(void);
 
===== arch/x86_64/kernel/process.c 1.24 vs edited =====
--- 1.24/arch/x86_64/kernel/process.c	Thu Feb 26 02:53:43 2004
+++ edited/arch/x86_64/kernel/process.c	Thu Feb 26 23:57:05 2004
@@ -16,7 +16,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/errno.h>
@@ -25,7 +24,6 @@
 #include <linux/mm.h>
 #include <linux/elfcore.h>
 #include <linux/smp.h>
-#include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/module.h>
===== drivers/macintosh/mediabay.c 1.11 vs edited =====
--- 1.11/drivers/macintosh/mediabay.c	Thu Feb  5 06:56:30 2004
+++ edited/drivers/macintosh/mediabay.c	Thu Feb 26 23:57:05 2004
@@ -10,8 +10,6 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -21,7 +19,6 @@
 #include <linux/timer.h>
 #include <linux/hdreg.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/ide.h>
 #include <asm/prom.h>
===== drivers/scsi/cpqfcTSinit.c 1.43 vs edited =====
--- 1.43/drivers/scsi/cpqfcTSinit.c	Wed Sep 10 01:54:19 2003
+++ edited/drivers/scsi/cpqfcTSinit.c	Thu Feb 26 23:57:05 2004
@@ -46,10 +46,6 @@
 #include <linux/ioport.h>  // request_region() prototype
 #include <linux/completion.h>
 
-#ifdef __alpha__
-#define __KERNEL_SYSCALLS__
-#endif
-#include <asm/unistd.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>   // ioctl related
 #include <asm/irq.h>
===== drivers/scsi/oktagon_esp.c 1.13 vs edited =====
--- 1.13/drivers/scsi/oktagon_esp.c	Thu Feb 26 02:53:45 2004
+++ edited/drivers/scsi/oktagon_esp.c	Thu Feb 26 23:57:05 2004
@@ -12,7 +12,6 @@
 #define USE_BOTTOM_HALF
 #endif
 
-#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -42,8 +41,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #endif
-
-#include <linux/unistd.h>
 
 /* The controller registers can be found in the Z2 config area at these
  * offsets:
===== init/do_mounts.c 1.62 vs edited =====
--- 1.62/init/do_mounts.c	Thu Feb 26 03:08:56 2004
+++ edited/init/do_mounts.c	Thu Feb 26 23:57:05 2004
@@ -66,11 +66,11 @@
 	/* read device number from .../dev */
 
 	sprintf(path, "/sys/block/%s/dev", name);
-	fd = open(path, 0, 0);
+	fd = sys_open(path, 0, 0);
 	if (fd < 0)
 		goto fail;
-	len = read(fd, buf, 32);
-	close(fd);
+	len = sys_read(fd, buf, 32);
+	sys_close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
@@ -96,11 +96,11 @@
 
 	/* otherwise read range from .../range */
 	sprintf(path, "/sys/block/%s/range", name);
-	fd = open(path, 0, 0);
+	fd = sys_open(path, 0, 0);
 	if (fd < 0)
 		goto fail;
-	len = read(fd, buf, 32);
-	close(fd);
+	len = sys_read(fd, buf, 32);
+	sys_close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
@@ -287,7 +287,7 @@
 				continue;
 		}
 	        /*
-		 * Allow the user to distinguish between failed open
+		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
@@ -326,21 +326,21 @@
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
-	fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
+	fd = sys_open("/dev/root", O_RDWR | O_NDELAY, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, FDEJECT, 0);
-		close(fd);
+		sys_close(fd);
 	}
 	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
-	fd = open("/dev/console", O_RDWR, 0);
+	fd = sys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, TCGETS, (long)&termios);
 		termios.c_lflag &= ~ICANON;
 		sys_ioctl(fd, TCSETSF, (long)&termios);
-		read(fd, &c, 1);
+		sys_read(fd, &c, 1);
 		termios.c_lflag |= ICANON;
 		sys_ioctl(fd, TCSETSF, (long)&termios);
-		close(fd);
+		sys_close(fd);
 	}
 }
 #endif
===== init/do_mounts.h 1.11 vs edited =====
--- 1.11/init/do_mounts.h	Thu Feb 26 02:53:47 2004
+++ edited/init/do_mounts.h	Thu Feb 26 23:57:05 2004
@@ -1,4 +1,3 @@
-#define __KERNEL_SYSCALLS__
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/devfs_fs_kernel.h>
===== init/do_mounts_devfs.c 1.5 vs edited =====
--- 1.5/init/do_mounts_devfs.c	Thu Feb 26 02:53:47 2004
+++ edited/init/do_mounts_devfs.c	Thu Feb 26 23:57:05 2004
@@ -24,7 +24,7 @@
 {
 	long bytes, n;
 	char *p = buf;
-	lseek(fd, 0, 0);
+	sys_lseek(fd, 0, 0);
 
 	for (bytes = 0; bytes < len; bytes += n) {
 		n = sys_getdents64(fd, (struct linux_dirent64 *)(p + bytes),
@@ -45,7 +45,7 @@
 static void * __init read_dir(char *path, int *len)
 {
 	int size;
-	int fd = open(path, 0, 0);
+	int fd = sys_open(path, 0, 0);
 
 	*len = 0;
 	if (fd < 0)
@@ -58,7 +58,7 @@
 			break;
 		n = do_read_dir(fd, p, size);
 		if (n > 0) {
-			close(fd);
+			sys_close(fd);
 			*len = n;
 			return p;
 		}
@@ -68,7 +68,7 @@
 		if (n < 0)
 			break;
 	}
-	close(fd);
+	sys_close(fd);
 	return NULL;
 }
 
===== init/do_mounts_initrd.c 1.6 vs edited =====
--- 1.6/init/do_mounts_initrd.c	Sat Oct 18 17:26:58 2003
+++ edited/init/do_mounts_initrd.c	Thu Feb 26 23:57:05 2004
@@ -1,4 +1,5 @@
-
+#define __KERNEL_SYSCALLS__
+#include <linux/unistd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
@@ -28,12 +29,12 @@
 	static char *argv[] = { "linuxrc", NULL, };
 	extern char * envp_init[];
 
-	close(old_fd);close(root_fd);
-	close(0);close(1);close(2);
-	setsid();
-	(void) open("/dev/console",O_RDWR,0);
-	(void) dup(0);
-	(void) dup(0);
+	sys_close(old_fd);sys_close(root_fd);
+	sys_close(0);sys_close(1);sys_close(2);
+	sys_setsid();
+	(void) sys_open("/dev/console",O_RDWR,0);
+	(void) sys_dup(0);
+	(void) sys_dup(0);
 	return execve(shell, argv, envp_init);
 }
 
@@ -47,8 +48,8 @@
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
-	root_fd = open("/", 0, 0);
-	old_fd = open("/old", 0, 0);
+	root_fd = sys_open("/", 0, 0);
+	old_fd = sys_open("/old", 0, 0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
@@ -57,7 +58,7 @@
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != waitpid(-1, &i, 0))
+		while (pid != sys_wait4(-1, &i, 0, 0))
 			yield();
 	}
 
@@ -67,8 +68,8 @@
 	/* switch root and cwd back to / of rootfs */
 	sys_fchdir(root_fd);
 	sys_chroot(".");
-	close(old_fd);
-	close(root_fd);
+	sys_close(old_fd);
+	sys_close(root_fd);
 	umount_devfs("/old/dev");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
@@ -84,7 +85,7 @@
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = open("/dev/root.old", O_RDWR, 0);
+		int fd = sys_open("/dev/root.old", O_RDWR, 0);
 		printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		sys_umount("/old", MNT_DETACH);
@@ -93,7 +94,7 @@
 			error = fd;
 		} else {
 			error = sys_ioctl(fd, BLKFLSBUF, 0);
-			close(fd);
+			sys_close(fd);
 		}
 		printk(!error ? "okay\n" : "failed\n");
 	}
===== init/do_mounts_md.c 1.4 vs edited =====
--- 1.4/init/do_mounts_md.c	Tue Sep 23 06:16:30 2003
+++ edited/init/do_mounts_md.c	Thu Feb 26 23:57:05 2004
@@ -154,7 +154,7 @@
 
 		printk(KERN_INFO "md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
 
-		fd = open(name, 0, 0);
+		fd = sys_open(name, 0, 0);
 		if (fd < 0) {
 			printk(KERN_ERR "md: open failed - cannot start array %d\n", minor);
 			continue;
@@ -163,7 +163,7 @@
 			printk(KERN_WARNING
 			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
 			       minor);
-			close(fd);
+			sys_close(fd);
 			continue;
 		}
 
@@ -209,7 +209,7 @@
 			err = sys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		close(fd);
+		sys_close(fd);
 	}
 }
 
@@ -243,10 +243,10 @@
 	if (raid_noautodetect)
 		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
 	else {
-		int fd = open("/dev/md0", 0, 0);
+		int fd = sys_open("/dev/md0", 0, 0);
 		if (fd >= 0) {
 			sys_ioctl(fd, RAID_AUTORUN, 0);
-			close(fd);
+			sys_close(fd);
 		}
 	}
 	md_setup_drive();
===== init/do_mounts_rd.c 1.9 vs edited =====
--- 1.9/init/do_mounts_rd.c	Mon Nov  3 16:09:51 2003
+++ edited/init/do_mounts_rd.c	Thu Feb 26 23:57:05 2004
@@ -69,8 +69,8 @@
 	/*
 	 * Read block 0 to test for gzipped kernel
 	 */
-	lseek(fd, start_block * BLOCK_SIZE, 0);
-	read(fd, buf, size);
+	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
+	sys_read(fd, buf, size);
 
 	/*
 	 * If it matches the gzip magic numbers, return -1
@@ -104,8 +104,8 @@
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
-	lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
-	read(fd, buf, size);
+	sys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
+	sys_read(fd, buf, size);
 
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
@@ -131,7 +131,7 @@
 	       start_block);
 	
 done:
-	lseek(fd, start_block * BLOCK_SIZE, 0);
+	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
 	kfree(buf);
 	return nblocks;
 }
@@ -148,11 +148,11 @@
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
-	out_fd = open("/dev/ram", O_RDWR, 0);
+	out_fd = sys_open("/dev/ram", O_RDWR, 0);
 	if (out_fd < 0)
 		goto out;
 
-	in_fd = open(from, O_RDONLY, 0);
+	in_fd = sys_open(from, O_RDONLY, 0);
 	if (in_fd < 0)
 		goto noclose_input;
 
@@ -217,20 +217,20 @@
 		if (i && (i % devblocks == 0)) {
 			printk("done disk #%d.\n", disk++);
 			rotate = 0;
-			if (close(in_fd)) {
+			if (sys_close(in_fd)) {
 				printk("Error closing the disk.\n");
 				goto noclose_input;
 			}
 			change_floppy("disk #%d", disk);
-			in_fd = open(from, O_RDONLY, 0);
+			in_fd = sys_open(from, O_RDONLY, 0);
 			if (in_fd < 0)  {
 				printk("Error opening disk.\n");
 				goto noclose_input;
 			}
 			printk("Loading disk #%d... ", disk);
 		}
-		read(in_fd, buf, BLOCK_SIZE);
-		write(out_fd, buf, BLOCK_SIZE);
+		sys_read(in_fd, buf, BLOCK_SIZE);
+		sys_write(out_fd, buf, BLOCK_SIZE);
 #if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
 		if (!(i % 16)) {
 			printk("%c\b", rotator[rotate & 0x3]);
@@ -243,9 +243,9 @@
 successful_load:
 	res = 1;
 done:
-	close(in_fd);
+	sys_close(in_fd);
 noclose_input:
-	close(out_fd);
+	sys_close(out_fd);
 out:
 	kfree(buf);
 	sys_unlink("/dev/ram");
@@ -342,7 +342,7 @@
 {
 	if (exit_code) return -1;
 	
-	insize = read(crd_infd, inbuf, INBUFSIZ);
+	insize = sys_read(crd_infd, inbuf, INBUFSIZ);
 	if (insize == 0) {
 		error("RAMDISK: ran out of compressed data");
 		return -1;
@@ -363,7 +363,7 @@
     unsigned n, written;
     uch *in, ch;
     
-    written = write(crd_outfd, window, outcnt);
+    written = sys_write(crd_outfd, window, outcnt);
     if (written != outcnt && unzip_error == 0) {
 	printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %ld\n",
 	       written, outcnt, bytes_out);
===== init/initramfs.c 1.13 vs edited =====
--- 1.13/init/initramfs.c	Thu Feb 26 02:53:47 2004
+++ edited/init/initramfs.c	Thu Feb 26 23:57:05 2004
@@ -1,10 +1,8 @@
-#define __KERNEL_SYSCALLS__
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
-#include <linux/unistd.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/syscalls.h>
===== init/main.c 1.120 vs edited =====
--- 1.120/init/main.c	Thu Feb 26 03:09:17 2004
+++ edited/init/main.c	Thu Feb 26 23:57:05 2004
@@ -624,11 +624,11 @@
 	unlock_kernel();
 	system_running = 1;
 
-	if (open("/dev/console", O_RDWR, 0) < 0)
+	if (sys_open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
 
-	(void) dup(0);
-	(void) dup(0);
+	(void) sys_dup(0);
+	(void) sys_dup(0);
 	
 	/*
 	 * We try each of these until one succeeds.

