Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSFEQCm>; Wed, 5 Jun 2002 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSFEQCl>; Wed, 5 Jun 2002 12:02:41 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:36108 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315487AbSFEQCj>; Wed, 5 Jun 2002 12:02:39 -0400
Date: Wed, 5 Jun 2002 17:02:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONFIG_GENERIC_ISA_DMA
Message-ID: <20020605170234.D10293@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, lkml,

The following patch adds support for CONFIG_GENERIC_ISA_DMA, which went
into the 2.4-ac kernel series prior to 2.5 happening.

The following patch allows architectures to decide whether they want
the generic ISA DMA functionality provided by kernel/dma.c and other
supporting files.

--- orig/fs/proc/proc_misc.c	Wed May 29 23:57:09 2002
+++ linux/fs/proc/proc_misc.c	Wed May 29 21:55:53 2002
@@ -394,12 +394,14 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#ifdef CONFIG_GENERIC_ISA_DMA
 static int dma_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
 	int len = get_dma_list(page);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
+#endif
 
 static int ioports_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -553,7 +555,9 @@
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
+#ifdef CONFIG_GENERIC_ISA_DMA
 		{"dma",		dma_read_proc},
+#endif		
 		{"ioports",	ioports_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286
--- orig/kernel/Makefile	Wed Jun  5 10:08:25 2002
+++ linux/kernel/Makefile	Sat May 25 10:31:47 2002
@@ -12,11 +12,12 @@
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
		printk.o platform.o suspend.o
 
-obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
+obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
--- orig/kernel/ksyms.c	Wed Jun  5 10:08:25 2002
+++ linux/kernel/ksyms.c	Mon Jun  3 10:14:30 2002
@@ -436,9 +436,11 @@
 EXPORT_SYMBOL(kiobuf_wait_for_io);
 
 /* dma handling */
+#ifdef CONFIG_GENERIC_ISA_DMA
 EXPORT_SYMBOL(request_dma);
 EXPORT_SYMBOL(free_dma);
 EXPORT_SYMBOL(dma_spin_lock);
+#endif
 #ifdef HAVE_DISABLE_HLT
 EXPORT_SYMBOL(disable_hlt);
 EXPORT_SYMBOL(enable_hlt);
--- orig/arch/alpha/config.in	Wed May 29 23:56:58 2002
+++ linux/arch/alpha/config.in	Wed May 29 21:55:08 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/i386/config.in	Wed Jun  5 10:08:22 2002
+++ linux/arch/i386/config.in	Sat May 25 10:25:43 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/ia64/config.in	Wed May 29 23:56:59 2002
+++ linux/arch/ia64/config.in	Wed May 29 21:55:09 2002
@@ -13,6 +13,7 @@
 define_bool CONFIG_SBUS n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 choice 'IA-64 processor type' \
 	"Itanium			CONFIG_ITANIUM \
--- orig/arch/m68k/config.in	Sat May 25 11:09:21 2002
+++ linux/arch/m68k/config.in	Mon May 13 10:16:01 2002
@@ -6,6 +6,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
--- orig/arch/mips/config.in	Sat May 25 11:09:28 2002
+++ linux/arch/mips/config.in	Wed Apr 24 19:32:40 2002
@@ -4,6 +4,7 @@
 #
 define_bool CONFIG_MIPS y
 define_bool CONFIG_SMP n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux Kernel Configuration"
 
--- orig/arch/mips64/config.in	Sat May 25 11:09:34 2002
+++ linux/arch/mips64/config.in	Wed Apr 24 19:32:40 2002
@@ -26,6 +26,7 @@
 
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 #
 # Select some configuration options automatically based on user selections
--- orig/arch/parisc/config.in	Sat May 25 11:09:39 2002
+++ linux/arch/parisc/config.in	Sun Feb 24 16:46:01 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/ppc/config.in	Wed May 29 23:57:00 2002
+++ linux/arch/ppc/config.in	Wed May 29 21:55:14 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
--- orig/arch/sh/config.in	Sat May 25 11:09:56 2002
+++ linux/arch/sh/config.in	Sat Mar 23 23:09:17 2002
@@ -9,6 +9,7 @@
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/sparc/config.in	Sat May 25 11:09:59 2002
+++ linux/arch/sparc/config.in	Fri May  3 10:39:16 2002
@@ -6,6 +6,7 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_HIGHMEM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 source init/Config.in
 
--- orig/arch/sparc64/config.in	Sat May 25 11:10:04 2002
+++ linux/arch/sparc64/config.in	Mon May  6 16:42:10 2002
@@ -26,6 +26,7 @@
 define_bool CONFIG_HAVE_DEC_LOCK y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

