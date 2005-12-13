Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVLMRXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVLMRXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVLMRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:23:51 -0500
Received: from verein.lst.de ([213.95.11.210]:6354 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750806AbVLMRXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:23:34 -0500
Date: Tue, 13 Dec 2005 18:23:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
Message-ID: <20051213172325.GC16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all these entries in the arch ioctl32.c files are gone [1], we
can build fs/compat_ioctl.c as a normal object and kill tons of cruft.
We need a special do_ioctl32_pointer handler for s390 so the compat_ptr
call is done.  This is not needed but harmless on all other
architectures.  Also remove some superflous includes in
fs/compat_ioctl.c

Tested on ppc64.

[1] parisc still had it's PPP handler left, which is not fully correct
    for ppp and besides that ppp uses the generic SIOCPRIV ioctl so it'd
    kick in for all netdevice users.  We can introduce a proper handler
    in one of the next patch series by adding a compat_ioctl method to
    struct net_device but for now let's just kill it - parisc doesn't
    compile in mainline anyway and I don't want this to block this
    patchset.

Signed-off-by: Christoph Hellwig <hch@lst.de>


Index: linux-2.6.15-rc5/arch/ia64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/ia64/ia32/ia32_ioctl.c	2005-12-12 22:52:55.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,45 +0,0 @@
-/*
- * IA32 Architecture-specific ioctl shim code
- *
- * Copyright (C) 2000 VA Linux Co
- * Copyright (C) 2000 Don Dugger <n0ano@valinux.com>
- * Copyright (C) 2001-2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-
-#include <linux/signal.h>	/* argh, msdos_fs.h isn't self-contained... */
-#include <linux/syscalls.h>
-#include "ia32priv.h"
-  
-#define	INCLUDES
-#include "compat_ioctl.c"
-
-#define IOCTL_NR(a)	((a) & ~(_IOC_SIZEMASK << _IOC_SIZESHIFT))
-
-#define DO_IOCTL(fd, cmd, arg) ({			\
-	int _ret;					\
-	mm_segment_t _old_fs = get_fs();		\
-							\
-	set_fs(KERNEL_DS);				\
-	_ret = sys_ioctl(fd, cmd, (unsigned long)arg);	\
-	set_fs(_old_fs);				\
-	_ret;						\
-})
-
-#define CODE
-#include "compat_ioctl.c"
-
-#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
-#define IOCTL_TABLE_START \
-	struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END \
-	};
-
-IOCTL_TABLE_START
-#define DECLARES
-#include "compat_ioctl.c"
-#include <linux/compat_ioctl.h>
-IOCTL_TABLE_END
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/mips/kernel/ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/mips/kernel/ioctl32.c	2005-12-12 22:52:55.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,50 +0,0 @@
-/*
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 2000 Silicon Graphics, Inc.
- * Written by Ulf Carlsson (ulfc@engr.sgi.com)
- * Copyright (C) 2000, 2004 Ralf Baechle
- * Copyright (C) 2002, 2003  Maciej W. Rozycki
- */
-#define INCLUDES
-#include "compat_ioctl.c"
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/compat.h>
-#include <linux/ioctl32.h>
-#include <linux/syscalls.h>
-
-#ifdef CONFIG_SIBYTE_TBPROF
-#include <asm/sibyte/trace_prof.h>
-#endif
-
-#define A(__x) ((unsigned long)(__x))
-
-long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-
-#define CODE
-#include "compat_ioctl.c"
-
-#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
-#define IOCTL_TABLE_START \
-	struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END \
-	};
-
-IOCTL_TABLE_START
-
-#include <linux/compat_ioctl.h>
-#define DECLARES
-#include "compat_ioctl.c"
-
-/*HANDLE_IOCTL(RTC_IRQP_READ, w_long)
-COMPATIBLE_IOCTL(RTC_IRQP_SET)
-HANDLE_IOCTL(RTC_EPOCH_READ, w_long)
-COMPATIBLE_IOCTL(RTC_EPOCH_SET)
-*/
-
-IOCTL_TABLE_END
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/parisc/kernel/ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/parisc/kernel/ioctl32.c	2005-12-12 22:53:07.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/* $Id: ioctl32.c,v 1.5 2002/10/18 00:21:43 varenet Exp $
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- */
-
-#include <linux/syscalls.h>
-
-#define INCLUDES
-#include "compat_ioctl.c"
-
-#include <asm/perf.h>
-#include <asm/ioctls.h>
-
-#define CODE
-#include "compat_ioctl.c"
-
-#define HANDLE_IOCTL(cmd, handler) { cmd, (ioctl_trans_handler_t)handler, NULL },
-#define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd, sys_ioctl) 
-
-#define IOCTL_TABLE_START  struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END    };
-
-IOCTL_TABLE_START
-#include <linux/compat_ioctl.h>
-
-#define DECLARES
-#include "compat_ioctl.c"
-
-/* And these ioctls need translation */
-HANDLE_IOCTL(SIOCGPPPSTATS, dev_ifsioc)
-HANDLE_IOCTL(SIOCGPPPCSTATS, dev_ifsioc)
-HANDLE_IOCTL(SIOCGPPPVER, dev_ifsioc)
-
-IOCTL_TABLE_END
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/powerpc/kernel/ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/powerpc/kernel/ioctl32.c	2005-12-12 22:52:55.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,45 +0,0 @@
-/*
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Based on sparc64 ioctl32.c by:
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- *
- * ppc64 changes:
- *
- * Copyright (C) 2000  Ken Aaker (kdaaker@rchland.vnet.ibm.com)
- * Copyright (C) 2001  Anton Blanchard (antonb@au.ibm.com)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define INCLUDES
-#include "compat_ioctl.c"
-#include <linux/syscalls.h>
-
-#define CODE
-#include "compat_ioctl.c"
-
-#define HANDLE_IOCTL(cmd,handler) { cmd, (ioctl_trans_handler_t)handler, NULL },
-#define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
-
-#define IOCTL_TABLE_START \
-	struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END \
-	};
-
-IOCTL_TABLE_START
-#include <linux/compat_ioctl.h>
-#define DECLARES
-#include "compat_ioctl.c"
-
-IOCTL_TABLE_END
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/sparc64/kernel/ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/sparc64/kernel/ioctl32.c	2005-12-12 22:52:55.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,39 +0,0 @@
-/* $Id: ioctl32.c,v 1.136 2002/01/14 09:49:52 davem Exp $
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- * Copyright (C) 2003  Pavel Machek (pavel@suse.cz)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- */
-
-#define INCLUDES
-#include "compat_ioctl.c"
-#include <linux/syscalls.h>
-
-#define CODE
-#include "compat_ioctl.c"
-
-#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
-#define IOCTL_TABLE_START \
-	struct ioctl_trans ioctl_start[] = {
-#define IOCTL_TABLE_END \
-	};
-
-IOCTL_TABLE_START
-#include <linux/compat_ioctl.h>
-#define DECLARES
-#include "compat_ioctl.c"
-#if 0
-HANDLE_IOCTL(RTC32_IRQP_READ, do_rtc_ioctl)
-HANDLE_IOCTL(RTC32_IRQP_SET, do_rtc_ioctl)
-HANDLE_IOCTL(RTC32_EPOCH_READ, do_rtc_ioctl)
-HANDLE_IOCTL(RTC32_EPOCH_SET, do_rtc_ioctl)
-#endif
-/* take care of sizeof(sizeof()) breakage */
-IOCTL_TABLE_END
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/ia32/ia32_ioctl.c	2005-12-12 22:53:07.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,32 +0,0 @@
-/* $Id: ia32_ioctl.c,v 1.25 2002/10/11 07:17:06 ak Exp $
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- * Copyright (C) 2001,2002  Andi Kleen, SuSE Labs 
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- */
-
-#define INCLUDES
-#include <linux/syscalls.h>
-#include "compat_ioctl.c"
-#include <asm/ia32.h>
-
-#define CODE
-#include "compat_ioctl.c"
-
-
-#define HANDLE_IOCTL(cmd,handler) { (cmd), (ioctl_trans_handler_t)(handler) }, 
-#define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
-
-struct ioctl_trans ioctl_start[] = { 
-#include <linux/compat_ioctl.h>
-#define DECLARES
-#include "compat_ioctl.c"
-/* take care of sizeof(sizeof()) breakage */
-}; 
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
-
Index: linux-2.6.15-rc5/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/s390/kernel/compat_ioctl.c	2005-12-12 22:53:08.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,47 +0,0 @@
-/*
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- *  S390 version
- *    Copyright (C) 2000-2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Gerhard Tonn (ton@de.ibm.com)
- *               Arnd Bergmann (arndb@de.ibm.com)
- *
- * Original implementation from 32-bit Sparc compat code which is
- * Copyright (C) 2000 Silicon Graphics, Inc.
- * Written by Ulf Carlsson (ulfc@engr.sgi.com) 
- */
-
-#include "compat_linux.h"
-#define INCLUDES
-#define CODE
-#include "../../../fs/compat_ioctl.c"
-#include <asm/dasd.h>
-#include <asm/cmb.h>
-#include <asm/tape390.h>
-#include <asm/ccwdev.h>
-#include "../../../drivers/s390/char/raw3270.h"
-
-static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
-				unsigned long arg, struct file *f)
-{
-	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
-}
-
-static int do_ioctl32_ulong(unsigned int fd, unsigned int cmd,
-				unsigned long arg, struct file *f)
-{
-	return sys_ioctl(fd, cmd, arg);
-}
-
-#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)do_ioctl32_pointer)
-#define ULONG_IOCTL(cmd)		HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)do_ioctl32_ulong)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
-
-struct ioctl_trans ioctl_start[] = {
-/* architecture independent ioctls */
-#include <linux/compat_ioctl.h>
-#define DECLARES
-#include "../../../fs/compat_ioctl.c"
-};
-
-int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/compat_ioctl.h	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/include/linux/compat_ioctl.h	2005-12-12 22:55:04.000000000 +0100
@@ -2,14 +2,6 @@
  * compatible types passed or none at all... Please include
  * only stuff that is compatible on *all architectures*.
  */
-#ifndef COMPATIBLE_IOCTL /* pointer to compatible structure or no argument */
-#define COMPATIBLE_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
-#endif
-
-#ifndef ULONG_IOCTL /* argument is an unsigned long integer, not a pointer */
-#define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
-#endif
-
 
 COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
Index: linux-2.6.15-rc5/fs/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/fs/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/fs/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -14,7 +14,7 @@
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
-obj-$(CONFIG_COMPAT)		+= compat.o
+obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
 
 nfsd-$(CONFIG_NFSD)		:= nfsctl.o
 obj-y				+= $(nfsd-y) $(nfsd-m)
Index: linux-2.6.15-rc5/fs/compat_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/compat_ioctl.c	2005-12-12 22:53:07.000000000 +0100
+++ linux-2.6.15-rc5/fs/compat_ioctl.c	2005-12-12 22:59:42.000000000 +0100
@@ -10,7 +10,6 @@
  * ioctls.
  */
 
-#ifdef INCLUDES
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>
@@ -82,13 +81,9 @@
 #include <linux/capi.h>
 
 #include <scsi/scsi.h>
-/* Ugly hack. */
-#undef __KERNEL__
 #include <scsi/scsi_ioctl.h>
-#define __KERNEL__
 #include <scsi/sg.h>
 
-#include <asm/types.h>
 #include <asm/uaccess.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
@@ -96,7 +91,6 @@
 #include <linux/watchdog.h>
 #include <linux/dm-ioctl.h>
 
-#include <asm/module.h>
 #include <linux/soundcard.h>
 #include <linux/lp.h>
 #include <linux/ppdev.h>
@@ -129,11 +123,6 @@
 #include <linux/dvb/frontend.h>
 #include <linux/dvb/video.h>
 
-#undef INCLUDES
-#endif
-
-#ifdef CODE
-
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
 #define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
@@ -149,6 +138,12 @@
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
 #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
 
+static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
+			      unsigned long arg, struct file *f)
+{
+	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
+}
+
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -2706,10 +2701,20 @@
 }
 #endif
 
-#undef CODE
-#endif
+#define HANDLE_IOCTL(cmd,handler) \
+	{ (cmd), (ioctl_trans_handler_t)(handler) },
+
+/* pointer to compatible structure or no argument */
+#define COMPATIBLE_IOCTL(cmd) \
+	{ (cmd), do_ioctl32_pointer },
+
+/* argument is an unsigned long integer, not a pointer */
+#define ULONG_IOCTL(cmd) \
+	{ (cmd), (ioctl_trans_handler_t)sys_ioctl },
 
-#ifdef DECLARES
+
+struct ioctl_trans ioctl_start[] = {
+#include <linux/compat_ioctl.h>
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
 #ifdef CONFIG_NET
@@ -2922,6 +2927,6 @@
 HANDLE_IOCTL(VIDEO_GET_EVENT, do_video_get_event)
 HANDLE_IOCTL(VIDEO_STILLPICTURE, do_video_stillpicture)
 HANDLE_IOCTL(VIDEO_SET_SPU_PALETTE, do_video_set_spu_palette)
+};
 
-#undef DECLARES
-#endif
+int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/ia64/ia32/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/ia64/ia32/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/ia64/ia32/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -2,11 +2,9 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-y := ia32_entry.o sys_ia32.o ia32_ioctl.o ia32_signal.o \
+obj-y := ia32_entry.o sys_ia32.o ia32_signal.o \
 	 ia32_support.o ia32_traps.o binfmt_elf32.o ia32_ldt.o
 
-CFLAGS_ia32_ioctl.o += -Ifs/
-
 # Don't let GCC uses f16-f31 so that save_ia32_fpstate_live() and
 # restore_ia32_fpstate_live() can be sure the live register contain user-level state.
 CFLAGS_ia32_signal.o += -mfixed-range=f16-f31
Index: linux-2.6.15-rc5/arch/mips/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/mips/kernel/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/mips/kernel/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -50,7 +50,7 @@
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
 obj-$(CONFIG_BINFMT_IRIX)	+= binfmt_irix.o
-obj-$(CONFIG_MIPS32_COMPAT)	+= ioctl32.o linux32.o signal32.o
+obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o ptrace32.o
 
@@ -60,6 +60,5 @@
 obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
 
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
-CFLAGS_ioctl32.o	+= -Ifs/
 
 EXTRA_AFLAGS := $(CFLAGS)
Index: linux-2.6.15-rc5/arch/parisc/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/parisc/kernel/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/parisc/kernel/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -6,7 +6,6 @@
 
 AFLAGS_entry.o	:= -traditional
 AFLAGS_pacache.o := -traditional
-CFLAGS_ioctl32.o := -Ifs/
 
 obj-y	     	:= cache.o pacache.o setup.o traps.o time.o irq.o \
 		   pa7300lc.o syscall.o entry.o sys_parisc.o firmware.o \
@@ -19,6 +18,6 @@
 obj-$(CONFIG_PA11)	+= pci-dma.o
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_MODULES)	+= module.o
-obj-$(CONFIG_64BIT)	+= binfmt_elf32.o sys_parisc32.o ioctl32.o signal32.o
+obj-$(CONFIG_64BIT)	+= binfmt_elf32.o sys_parisc32.o signal32.o
 # only supported for PCX-W/U in 64-bit mode at the moment
 obj-$(CONFIG_64BIT)	+= perf.o perf_asm.o
Index: linux-2.6.15-rc5/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/powerpc/kernel/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/powerpc/kernel/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -4,7 +4,6 @@
 
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
-CFLAGS_ioctl32.o += -Ifs/
 endif
 ifeq ($(CONFIG_PPC32),y)
 CFLAGS_prom_init.o      += -fPIC
@@ -17,7 +16,7 @@
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o systbl.o \
-				   paca.o ioctl32.o cpu_setup_power4.o \
+				   paca.o cpu_setup_power4.o \
 				   firmware.o sysfs.o idle_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
Index: linux-2.6.15-rc5/arch/s390/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/s390/kernel/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/s390/kernel/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -15,8 +15,7 @@
 obj-$(CONFIG_SMP)		+= smp.o
 
 obj-$(CONFIG_S390_SUPPORT)	+= compat_linux.o compat_signal.o \
-					compat_ioctl.o compat_wrapper.o \
-					compat_exec_domain.o
+					compat_wrapper.o compat_exec_domain.o
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
 obj-$(CONFIG_ARCH_S390_31)	+= entry.o reipl.o
Index: linux-2.6.15-rc5/arch/sparc64/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/sparc64/kernel/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/sparc64/kernel/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -16,7 +16,7 @@
 obj-$(CONFIG_PCI)	 += ebus.o isa.o pci_common.o pci_iommu.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o
 obj-$(CONFIG_SMP)	 += smp.o trampoline.o
-obj-$(CONFIG_SPARC32_COMPAT) += sys32.o sys_sparc32.o signal32.o ioctl32.o
+obj-$(CONFIG_SPARC32_COMPAT) += sys32.o sys_sparc32.o signal32.o
 obj-$(CONFIG_BINFMT_ELF32) += binfmt_elf32.o
 obj-$(CONFIG_BINFMT_AOUT32) += binfmt_aout32.o
 obj-$(CONFIG_MODULES) += module.o
@@ -40,5 +40,3 @@
 
 head.o: head.S ttable.S itlb_base.S dtlb_base.S dtlb_backend.S dtlb_prot.S \
 	etrap.S rtrap.S winfixup.S entry.S
-
-CFLAGS_ioctl32.o += -Ifs/
Index: linux-2.6.15-rc5/arch/x86_64/ia32/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/ia32/Makefile	2005-12-12 22:52:55.000000000 +0100
+++ linux-2.6.15-rc5/arch/x86_64/ia32/Makefile	2005-12-12 22:53:09.000000000 +0100
@@ -2,8 +2,7 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-$(CONFIG_IA32_EMULATION) := ia32entry.o sys_ia32.o ia32_ioctl.o \
-	ia32_signal.o tls32.o \
+obj-$(CONFIG_IA32_EMULATION) := ia32entry.o sys_ia32.o ia32_signal.o tls32.o \
 	ia32_binfmt.o fpu32.o ptrace32.o syscall32.o syscall32_syscall.o
 
 sysv-$(CONFIG_SYSVIPC) := ipc32.o
@@ -29,4 +28,3 @@
 
 AFLAGS_vsyscall-sysenter.o = -m32
 AFLAGS_vsyscall-syscall.o = -m32
-CFLAGS_ia32_ioctl.o += -Ifs/
