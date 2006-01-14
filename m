Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWANWvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWANWvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWANWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:51:23 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:51586 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751336AbWANWvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:51:22 -0500
Date: Sun, 15 Jan 2006 00:51:14 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sh: Consolidate hp620/hp680/hp690 targets into hp6xx.
Message-ID: <20060114225114.GC4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the reasons for keeping these separate before was due to hp690
discontig, and since we have a workaround for that now (abusing some
shadow space so everything is magically contiguous), there's no reason to
keep the targets separate.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/boards/hp6xx/Makefile       |    6 
 arch/sh/boards/hp6xx/hp620/Makefile |    6 
 arch/sh/boards/hp6xx/hp620/mach.c   |   52 --
 arch/sh/boards/hp6xx/hp620/setup.c  |   45 --
 arch/sh/boards/hp6xx/hp680/Makefile |    6 
 arch/sh/boards/hp6xx/hp680/mach.c   |   53 --
 arch/sh/boards/hp6xx/hp680/setup.c  |   41 -
 arch/sh/boards/hp6xx/hp690/Makefile |    6 
 arch/sh/boards/hp6xx/hp690/mach.c   |   48 --
 arch/sh/boards/hp6xx/mach.c         |   46 ++
 arch/sh/boards/hp6xx/setup.c        |   55 ++
 arch/sh/configs/hp680_defconfig     |  626 ------------------------------
 arch/sh/configs/hp6xx_defconfig     |  743 ++++++++++++++++++++++++++++++++++++
 arch/sh/tools/mach-types            |    7 
 drivers/input/touchscreen/Kconfig   |    2 
 15 files changed, 853 insertions(+), 889 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/Makefile sh-2.6.15/arch/sh/boards/hp6xx/Makefile
--- linux-2.6.15/arch/sh/boards/hp6xx/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/boards/hp6xx/Makefile	2006-01-04 00:15:26.000000000 +0200
@@ -0,0 +1,6 @@
+#
+# Makefile for the HP6xx specific parts of the kernel
+#
+
+obj-y	 := mach.o setup.o
+
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp620/Makefile sh-2.6.15/arch/sh/boards/hp6xx/hp620/Makefile
--- linux-2.6.15/arch/sh/boards/hp6xx/hp620/Makefile	2005-06-20 22:45:19.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp620/Makefile	1970-01-01 02:00:00.000000000 +0200
@@ -1,6 +0,0 @@
-#
-# Makefile for the HP620 specific parts of the kernel
-#
-
-obj-y	 := mach.o setup.o
-
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp620/mach.c sh-2.6.15/arch/sh/boards/hp6xx/hp620/mach.c
--- linux-2.6.15/arch/sh/boards/hp6xx/hp620/mach.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp620/mach.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,52 +0,0 @@
-/*
- * linux/arch/sh/boards/hp6xx/hp620/mach.c
- * 
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- * 
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Machine vector for the HP620
- */
-
-#include <linux/init.h>
-
-#include <asm/machvec.h>
-#include <asm/rtc.h>
-#include <asm/machvec_init.h>
-
-#include <asm/io.h>
-#include <asm/hd64461/hd64461.h>
-#include <asm/irq.h>
-
-/*
- * The Machine Vector
- */
-
-struct sh_machine_vector mv_hp620 __initmv = {
-        .mv_nr_irqs             = HD64461_IRQBASE+HD64461_IRQ_NUM,
-
-        .mv_inb                 = hd64461_inb,
-        .mv_inw                 = hd64461_inw,
-        .mv_inl                 = hd64461_inl,
-        .mv_outb                = hd64461_outb,
-        .mv_outw                = hd64461_outw,
-        .mv_outl                = hd64461_outl,
-
-        .mv_inb_p               = hd64461_inb_p,
-        .mv_inw_p               = hd64461_inw,
-        .mv_inl_p               = hd64461_inl,
-        .mv_outb_p              = hd64461_outb_p,
-        .mv_outw_p              = hd64461_outw,
-        .mv_outl_p              = hd64461_outl,
-
-        .mv_insb                = hd64461_insb,
-        .mv_insw                = hd64461_insw,
-        .mv_insl                = hd64461_insl,
-        .mv_outsb               = hd64461_outsb,
-        .mv_outsw               = hd64461_outsw,
-        .mv_outsl               = hd64461_outsl,
-
-        .mv_irq_demux           = hd64461_irq_demux,
-};
-ALIAS_MV(hp620)
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp620/setup.c sh-2.6.15/arch/sh/boards/hp6xx/hp620/setup.c
--- linux-2.6.15/arch/sh/boards/hp6xx/hp620/setup.c	2005-06-20 22:45:19.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp620/setup.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,45 +0,0 @@
-/*
- * linux/arch/sh/boards/hp6xx/hp620/setup.c
- *
- * Copyright (C) 2002 Andriy Skulysh, 2005 Kristoffer Ericson
- *
- * May be copied or modified under the terms of the GNU General Public
- * License. See Linux/COPYING for more information.
- *
- * Setup code for an HP620.
- * Due to similiarity with hp680/hp690 same inits are done (for now)
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <asm/hd64461/hd64461.h>
-#include <asm/io.h>
-#include <asm/hp6xx/hp6xx.h>
-#include <asm/cpu/dac.h>
-
-const char *get_system_type(void)
-{
-	return "HP620";
-}
-
-int __init platform_setup(void)
-{
-	u16 v;
-
-	v  = inw(HD64461_STBCR);
-	v |= HD64461_STBCR_SURTST | HD64461_STBCR_SIRST  |
-	     HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST |
-	     HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST |
-	     HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST |
-	     HD64461_STBCR_SAFECKE_IST;
-	outw(v, HD64461_STBCR);
-
-	v  = inw(HD64461_GPADR);
-	v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
-	outw(v, HD64461_GPADR);
-
-	sh_dac_disable(DAC_SPEAKER_VOLUME);
-
-	return 0;
-}
-
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp680/Makefile sh-2.6.15/arch/sh/boards/hp6xx/hp680/Makefile
--- linux-2.6.15/arch/sh/boards/hp6xx/hp680/Makefile	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp680/Makefile	1970-01-01 02:00:00.000000000 +0200
@@ -1,6 +0,0 @@
-#
-# Makefile for the HP680 specific parts of the kernel
-#
-
-obj-y	 := mach.o setup.o
-
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp680/mach.c sh-2.6.15/arch/sh/boards/hp6xx/hp680/mach.c
--- linux-2.6.15/arch/sh/boards/hp6xx/hp680/mach.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp680/mach.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,53 +0,0 @@
-/*
- * linux/arch/sh/boards/hp6xx/hp680/mach.c
- *
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Machine vector for the HP680
- */
-
-#include <linux/init.h>
-
-#include <asm/machvec.h>
-#include <asm/rtc.h>
-#include <asm/machvec_init.h>
-
-#include <asm/io.h>
-#include <asm/hd64461/hd64461.h>
-#include <asm/hp6xx/io.h>
-#include <asm/irq.h>
-
-struct sh_machine_vector mv_hp680 __initmv = {
-	.mv_nr_irqs = HD64461_IRQBASE + HD64461_IRQ_NUM,
-
-	.mv_inb = hd64461_inb,
-	.mv_inw = hd64461_inw,
-	.mv_inl = hd64461_inl,
-	.mv_outb = hd64461_outb,
-	.mv_outw = hd64461_outw,
-	.mv_outl = hd64461_outl,
-
-	.mv_inb_p = hd64461_inb_p,
-	.mv_inw_p = hd64461_inw,
-	.mv_inl_p = hd64461_inl,
-	.mv_outb_p = hd64461_outb_p,
-	.mv_outw_p = hd64461_outw,
-	.mv_outl_p = hd64461_outl,
-
-	.mv_insb = hd64461_insb,
-	.mv_insw = hd64461_insw,
-	.mv_insl = hd64461_insl,
-	.mv_outsb = hd64461_outsb,
-	.mv_outsw = hd64461_outsw,
-	.mv_outsl = hd64461_outsl,
-
-	.mv_readw = hd64461_readw,
-	.mv_writew = hd64461_writew,
-
-	.mv_irq_demux = hd64461_irq_demux,
-};
-
-ALIAS_MV(hp680)
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp680/setup.c sh-2.6.15/arch/sh/boards/hp6xx/hp680/setup.c
--- linux-2.6.15/arch/sh/boards/hp6xx/hp680/setup.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp680/setup.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,41 +0,0 @@
-/*
- * linux/arch/sh/boards/hp6xx/hp680/setup.c
- *
- * Copyright (C) 2002 Andriy Skulysh
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Setup code for an HP680  (internal peripherials only)
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <asm/hd64461/hd64461.h>
-#include <asm/io.h>
-#include <asm/hp6xx/hp6xx.h>
-#include <asm/cpu/dac.h>
-
-const char *get_system_type(void)
-{
-	return "HP680";
-}
-
-int __init platform_setup(void)
-{
-	u16 v;
-	v = inw(HD64461_STBCR);
-	v |= HD64461_STBCR_SURTST | HD64461_STBCR_SIRST |
-	    HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST |
-	    HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST |
-	    HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST |
-	    HD64461_STBCR_SAFECKE_IST;
-	outw(v, HD64461_STBCR);
-	v = inw(HD64461_GPADR);
-	v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
-	outw(v, HD64461_GPADR);
-
-	sh_dac_disable(DAC_SPEAKER_VOLUME);
-
-	return 0;
-}
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp690/Makefile sh-2.6.15/arch/sh/boards/hp6xx/hp690/Makefile
--- linux-2.6.15/arch/sh/boards/hp6xx/hp690/Makefile	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp690/Makefile	1970-01-01 02:00:00.000000000 +0200
@@ -1,6 +0,0 @@
-#
-# Makefile for the HP690 specific parts of the kernel
-#
-
-obj-y	 := mach.o
-
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/hp690/mach.c sh-2.6.15/arch/sh/boards/hp6xx/hp690/mach.c
--- linux-2.6.15/arch/sh/boards/hp6xx/hp690/mach.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/hp6xx/hp690/mach.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,48 +0,0 @@
-/*
- * linux/arch/sh/boards/hp6xx/hp690/mach.c
- *
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * Machine vector for the HP690
- */
-
-#include <linux/init.h>
-
-#include <asm/machvec.h>
-#include <asm/rtc.h>
-#include <asm/machvec_init.h>
-
-#include <asm/io.h>
-#include <asm/hd64461/hd64461.h>
-#include <asm/irq.h>
-
-struct sh_machine_vector mv_hp690 __initmv = {
-        .mv_nr_irqs             = HD64461_IRQBASE+HD64461_IRQ_NUM,
-
-        .mv_inb                 = hd64461_inb,
-        .mv_inw                 = hd64461_inw,
-        .mv_inl                 = hd64461_inl,
-        .mv_outb                = hd64461_outb,
-        .mv_outw                = hd64461_outw,
-        .mv_outl                = hd64461_outl,
-
-        .mv_inb_p               = hd64461_inb_p,
-        .mv_inw_p               = hd64461_inw,
-        .mv_inl_p               = hd64461_inl,
-        .mv_outb_p              = hd64461_outb_p,
-        .mv_outw_p              = hd64461_outw,
-        .mv_outl_p              = hd64461_outl,
-
-        .mv_insb                = hd64461_insb,
-        .mv_insw                = hd64461_insw,
-        .mv_insl                = hd64461_insl,
-        .mv_outsb               = hd64461_outsb,
-        .mv_outsw               = hd64461_outsw,
-        .mv_outsl               = hd64461_outsl,
-
-        .mv_irq_demux           = hd64461_irq_demux,
-};
-ALIAS_MV(hp690)
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/mach.c sh-2.6.15/arch/sh/boards/hp6xx/mach.c
--- linux-2.6.15/arch/sh/boards/hp6xx/mach.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/boards/hp6xx/mach.c	2006-01-04 15:36:51.000000000 +0200
@@ -0,0 +1,46 @@
+/*
+ * linux/arch/sh/boards/hp6xx/mach.c
+ *
+ * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * Machine vector for the HP680
+ */
+#include <asm/machvec.h>
+#include <asm/hd64461.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+struct sh_machine_vector mv_hp6xx __initmv = {
+	.mv_nr_irqs = HD64461_IRQBASE + HD64461_IRQ_NUM,
+
+	.mv_inb = hd64461_inb,
+	.mv_inw = hd64461_inw,
+	.mv_inl = hd64461_inl,
+	.mv_outb = hd64461_outb,
+	.mv_outw = hd64461_outw,
+	.mv_outl = hd64461_outl,
+
+	.mv_inb_p = hd64461_inb_p,
+	.mv_inw_p = hd64461_inw,
+	.mv_inl_p = hd64461_inl,
+	.mv_outb_p = hd64461_outb_p,
+	.mv_outw_p = hd64461_outw,
+	.mv_outl_p = hd64461_outl,
+
+	.mv_insb = hd64461_insb,
+	.mv_insw = hd64461_insw,
+	.mv_insl = hd64461_insl,
+	.mv_outsb = hd64461_outsb,
+	.mv_outsw = hd64461_outsw,
+	.mv_outsl = hd64461_outsl,
+
+	.mv_readw = hd64461_readw,
+	.mv_writew = hd64461_writew,
+
+	.mv_irq_demux = hd64461_irq_demux,
+};
+
+ALIAS_MV(hp6xx)
diff -urN -X exclude linux-2.6.15/arch/sh/boards/hp6xx/setup.c sh-2.6.15/arch/sh/boards/hp6xx/setup.c
--- linux-2.6.15/arch/sh/boards/hp6xx/setup.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/boards/hp6xx/setup.c	2006-01-04 15:38:50.000000000 +0200
@@ -0,0 +1,55 @@
+/*
+ * linux/arch/sh/boards/hp6xx/hp680/setup.c
+ *
+ * Copyright (C) 2002 Andriy Skulysh
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * Setup code for an HP680  (internal peripherials only)
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/hd64461.h>
+#include <asm/hp6xx/hp6xx.h>
+#include <asm/cpu/dac.h>
+
+const char *get_system_type(void)
+{
+	return "HP6xx";
+}
+
+int __init platform_setup(void)
+{
+	u8 v8;
+	u16 v;
+	v = inw(HD64461_STBCR);
+	v |= HD64461_STBCR_SURTST | HD64461_STBCR_SIRST |
+	    HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST |
+	    HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST |
+	    HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST |
+	    HD64461_STBCR_SAFECKE_IST;
+#ifndef CONFIG_HD64461_ENABLER
+	v |= HD64461_STBCR_SPC1ST;
+#endif
+	outw(v, HD64461_STBCR);
+	v = inw(HD64461_GPADR);
+	v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
+	outw(v, HD64461_GPADR);
+
+	outw(HD64461_PCCGCR_VCC0 | HD64461_PCCSCR_VCC1, HD64461_PCC0GCR);
+
+#ifndef CONFIG_HD64461_ENABLER
+	outw(HD64461_PCCGCR_VCC0 | HD64461_PCCSCR_VCC1, HD64461_PCC1GCR);
+#endif
+
+	sh_dac_output(0, DAC_SPEAKER_VOLUME);
+	sh_dac_disable(DAC_SPEAKER_VOLUME);
+	v8 = ctrl_inb(DACR);
+	v8 &= ~DACR_DAE;
+	ctrl_outb(v8,DACR);
+
+	return 0;
+}
diff -urN -X exclude linux-2.6.15/arch/sh/configs/hp680_defconfig sh-2.6.15/arch/sh/configs/hp680_defconfig
--- linux-2.6.15/arch/sh/configs/hp680_defconfig	2005-10-06 00:20:18.000000000 +0300
+++ sh-2.6.15/arch/sh/configs/hp680_defconfig	1970-01-01 02:00:00.000000000 +0200
@@ -1,626 +0,0 @@
-#
-# Automatically generated make config: don't edit
-# Linux kernel version: 2.6.13-sh
-# Thu Oct  6 00:20:18 2005
-#
-CONFIG_SUPERH=y
-CONFIG_UID16=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-CONFIG_GENERIC_HARDIRQS=y
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
-CONFIG_BROKEN_ON_SMP=y
-CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
-CONFIG_LOCALVERSION=""
-CONFIG_SWAP=y
-# CONFIG_SYSVIPC is not set
-# CONFIG_BSD_PROCESS_ACCT is not set
-# CONFIG_SYSCTL is not set
-# CONFIG_HOTPLUG is not set
-# CONFIG_IKCONFIG is not set
-# CONFIG_EMBEDDED is not set
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
-CONFIG_PRINTK=y
-CONFIG_BUG=y
-CONFIG_BASE_FULL=y
-CONFIG_FUTEX=y
-CONFIG_EPOLL=y
-CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
-# CONFIG_MODULES is not set
-
-#
-# System type
-#
-# CONFIG_SH_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SOLUTION_ENGINE is not set
-# CONFIG_SH_7300_SOLUTION_ENGINE is not set
-# CONFIG_SH_73180_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SYSTEMH is not set
-# CONFIG_SH_STB1_HARP is not set
-# CONFIG_SH_STB1_OVERDRIVE is not set
-# CONFIG_SH_HP6XX is not set
-# CONFIG_SH_CQREEK is not set
-# CONFIG_SH_DMIDA is not set
-# CONFIG_SH_EC3104 is not set
-# CONFIG_SH_SATURN is not set
-# CONFIG_SH_DREAMCAST is not set
-# CONFIG_SH_CAT68701 is not set
-# CONFIG_SH_BIGSUR is not set
-# CONFIG_SH_SH2000 is not set
-# CONFIG_SH_ADX is not set
-# CONFIG_SH_MPC1211 is not set
-# CONFIG_SH_SH03 is not set
-# CONFIG_SH_SECUREEDGE5410 is not set
-# CONFIG_SH_HS7751RVOIP is not set
-# CONFIG_SH_RTS7751R2D is not set
-# CONFIG_SH_EDOSK7705 is not set
-# CONFIG_SH_SH4202_MICRODEV is not set
-# CONFIG_SH_LANDISK is not set
-CONFIG_SH_UNKNOWN=y
-
-#
-# Processor selection
-#
-CONFIG_CPU_SH3=y
-
-#
-# SH-2 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7604 is not set
-
-#
-# SH-3 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7300 is not set
-# CONFIG_CPU_SUBTYPE_SH7705 is not set
-# CONFIG_CPU_SUBTYPE_SH7707 is not set
-# CONFIG_CPU_SUBTYPE_SH7708 is not set
-CONFIG_CPU_SUBTYPE_SH7709=y
-
-#
-# SH-4 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7750 is not set
-# CONFIG_CPU_SUBTYPE_SH7091 is not set
-# CONFIG_CPU_SUBTYPE_SH7750R is not set
-# CONFIG_CPU_SUBTYPE_SH7750S is not set
-# CONFIG_CPU_SUBTYPE_SH7751 is not set
-# CONFIG_CPU_SUBTYPE_SH7751R is not set
-# CONFIG_CPU_SUBTYPE_SH7760 is not set
-# CONFIG_CPU_SUBTYPE_SH4_202 is not set
-
-#
-# ST40 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
-# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
-
-#
-# SH-4A Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH73180 is not set
-# CONFIG_CPU_SUBTYPE_SH7770 is not set
-# CONFIG_CPU_SUBTYPE_SH7780 is not set
-
-#
-# Memory management options
-#
-CONFIG_MMU=y
-CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
-# CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-
-#
-# Cache configuration
-#
-# CONFIG_SH_DIRECT_MAPPED is not set
-# CONFIG_SH_WRITETHROUGH is not set
-# CONFIG_SH_OCRAM is not set
-CONFIG_MEMORY_START=0x0c000000
-CONFIG_MEMORY_SIZE=0x00400000
-# CONFIG_CF_ENABLER is not set
-
-#
-# Processor features
-#
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_SH_RTC=y
-# CONFIG_SH_DSP is not set
-CONFIG_SH_ADC=y
-
-#
-# Timer support
-#
-CONFIG_SH_TMU=y
-# CONFIG_SH_PCLK_FREQ_BOOL is not set
-
-#
-# CPU Frequency scaling
-#
-# CONFIG_CPU_FREQ is not set
-
-#
-# DMA support
-#
-# CONFIG_SH_DMA is not set
-
-#
-# Companion Chips
-#
-CONFIG_HD6446X_SERIES=y
-CONFIG_HD64461=y
-# CONFIG_HD64465 is not set
-CONFIG_HD64461_IRQ=36
-# CONFIG_HD64461_ENABLER is not set
-
-#
-# Kernel features
-#
-# CONFIG_KEXEC is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_SMP is not set
-
-#
-# Boot options
-#
-CONFIG_ZERO_PAGE_OFFSET=0x00001000
-CONFIG_BOOT_LINK_OFFSET=0x00800000
-# CONFIG_UBC_WAKEUP is not set
-# CONFIG_CMDLINE_BOOL is not set
-
-#
-# Bus options
-#
-# CONFIG_PCI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-# CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
-
-#
-# Executable file formats
-#
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_FLAT is not set
-# CONFIG_BINFMT_MISC is not set
-
-#
-# Networking
-#
-# CONFIG_NET is not set
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-# CONFIG_STANDALONE is not set
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
-
-#
-# Memory Technology Devices (MTD)
-#
-# CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_COW_COMMON is not set
-# CONFIG_BLK_DEV_LOOP is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_LBD is not set
-# CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
-CONFIG_BLK_DEV_IDE=y
-
-#
-# Please see Documentation/ide.txt for help/info on IDE drives
-#
-# CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
-
-#
-# IDE chipset support/bugfixes
-#
-CONFIG_IDE_GENERIC=y
-CONFIG_IDE_SH=y
-# CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
-
-#
-# SCSI device support
-#
-# CONFIG_SCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-# CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
-
-#
-# Telephony Support
-#
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-CONFIG_INPUT=y
-
-#
-# Userland interfaces
-#
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
-
-#
-# Hardware I/O ports
-#
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_SERIO_RAW is not set
-# CONFIG_GAMEPORT is not set
-
-#
-# Character devices
-#
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_HW_CONSOLE=y
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-# CONFIG_SERIAL_8250 is not set
-
-#
-# Non-8250 serial port support
-#
-# CONFIG_SERIAL_SH_SCI is not set
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
-# CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-# CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
-# CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-# CONFIG_I2C_SENSOR is not set
-
-#
-# Dallas's 1-wire bus
-#
-# CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
-CONFIG_HWMON=y
-# CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Misc devices
-#
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-
-#
-# Graphics support
-#
-CONFIG_FB=y
-CONFIG_FB_CFB_FILLRECT=y
-CONFIG_FB_CFB_COPYAREA=y
-CONFIG_FB_CFB_IMAGEBLIT=y
-CONFIG_FB_SOFT_CURSOR=y
-# CONFIG_FB_MACMODES is not set
-# CONFIG_FB_MODE_HELPERS is not set
-# CONFIG_FB_TILEBLITTING is not set
-# CONFIG_FB_EPSON1355 is not set
-CONFIG_FB_HIT=y
-# CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
-
-#
-# Console display driver support
-#
-CONFIG_DUMMY_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-# CONFIG_FONT_8x8 is not set
-# CONFIG_FONT_8x16 is not set
-# CONFIG_FONT_6x11 is not set
-# CONFIG_FONT_7x14 is not set
-CONFIG_FONT_PEARL_8x8=y
-# CONFIG_FONT_ACORN_8x8 is not set
-# CONFIG_FONT_MINI_4x6 is not set
-# CONFIG_FONT_SUN8x16 is not set
-# CONFIG_FONT_SUN12x22 is not set
-# CONFIG_FONT_10x18 is not set
-
-#
-# Logo configuration
-#
-# CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
-# CONFIG_MMC is not set
-
-#
-# InfiniBand support
-#
-# CONFIG_INFINIBAND is not set
-
-#
-# SN Devices
-#
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
-
-#
-# XFS support
-#
-# CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-CONFIG_INOTIFY=y
-# CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_SYSFS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
-# CONFIG_TMPFS is not set
-# CONFIG_HUGETLBFS is not set
-# CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
-# CONFIG_NLS is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
-# Kernel hacking
-#
-# CONFIG_PRINTK_TIME is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_FRAME_POINTER is not set
-# CONFIG_SH_STANDARD_BIOS is not set
-# CONFIG_KGDB is not set
-
-#
-# Security options
-#
-# CONFIG_KEYS is not set
-# CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
-
-#
-# Library routines
-#
-# CONFIG_CRC_CCITT is not set
-CONFIG_CRC32=y
-# CONFIG_LIBCRC32C is not set
diff -urN -X exclude linux-2.6.15/arch/sh/configs/hp6xx_defconfig sh-2.6.15/arch/sh/configs/hp6xx_defconfig
--- linux-2.6.15/arch/sh/configs/hp6xx_defconfig	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/configs/hp6xx_defconfig	2006-01-04 21:02:29.000000000 +0200
@@ -0,0 +1,743 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.15-sh
+# Wed Jan  4 15:32:56 2006
+#
+CONFIG_SUPERH=y
+CONFIG_UID16=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+# CONFIG_CLEAN_COMPILE is not set
+CONFIG_BROKEN=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+# CONFIG_SYSVIPC is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_SYSCTL is not set
+CONFIG_HOTPLUG=y
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# System type
+#
+# CONFIG_SH_SOLUTION_ENGINE is not set
+# CONFIG_SH_7751_SOLUTION_ENGINE is not set
+# CONFIG_SH_7300_SOLUTION_ENGINE is not set
+# CONFIG_SH_73180_SOLUTION_ENGINE is not set
+# CONFIG_SH_7751_SYSTEMH is not set
+# CONFIG_SH_STB1_HARP is not set
+# CONFIG_SH_STB1_OVERDRIVE is not set
+CONFIG_SH_HP6XX=y
+# CONFIG_SH_CQREEK is not set
+# CONFIG_SH_DMIDA is not set
+# CONFIG_SH_EC3104 is not set
+# CONFIG_SH_SATURN is not set
+# CONFIG_SH_DREAMCAST is not set
+# CONFIG_SH_CAT68701 is not set
+# CONFIG_SH_BIGSUR is not set
+# CONFIG_SH_SH2000 is not set
+# CONFIG_SH_ADX is not set
+# CONFIG_SH_MPC1211 is not set
+# CONFIG_SH_SH03 is not set
+# CONFIG_SH_SECUREEDGE5410 is not set
+# CONFIG_SH_HS7751RVOIP is not set
+# CONFIG_SH_RTS7751R2D is not set
+# CONFIG_SH_EDOSK7705 is not set
+# CONFIG_SH_SH4202_MICRODEV is not set
+# CONFIG_SH_LANDISK is not set
+# CONFIG_SH_TITAN is not set
+# CONFIG_SH_UNKNOWN is not set
+
+#
+# Processor selection
+#
+CONFIG_CPU_SH3=y
+
+#
+# SH-2 Processor Support
+#
+# CONFIG_CPU_SUBTYPE_SH7604 is not set
+
+#
+# SH-3 Processor Support
+#
+# CONFIG_CPU_SUBTYPE_SH7300 is not set
+# CONFIG_CPU_SUBTYPE_SH7705 is not set
+# CONFIG_CPU_SUBTYPE_SH7707 is not set
+# CONFIG_CPU_SUBTYPE_SH7708 is not set
+CONFIG_CPU_SUBTYPE_SH7709=y
+
+#
+# SH-4 Processor Support
+#
+# CONFIG_CPU_SUBTYPE_SH7750 is not set
+# CONFIG_CPU_SUBTYPE_SH7091 is not set
+# CONFIG_CPU_SUBTYPE_SH7750R is not set
+# CONFIG_CPU_SUBTYPE_SH7750S is not set
+# CONFIG_CPU_SUBTYPE_SH7751 is not set
+# CONFIG_CPU_SUBTYPE_SH7751R is not set
+# CONFIG_CPU_SUBTYPE_SH7760 is not set
+# CONFIG_CPU_SUBTYPE_SH4_202 is not set
+
+#
+# ST40 Processor Support
+#
+# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
+# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
+
+#
+# SH-4A Processor Support
+#
+# CONFIG_CPU_SUBTYPE_SH73180 is not set
+# CONFIG_CPU_SUBTYPE_SH7770 is not set
+# CONFIG_CPU_SUBTYPE_SH7780 is not set
+
+#
+# Memory management options
+#
+CONFIG_MMU=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+
+#
+# Cache configuration
+#
+# CONFIG_SH_DIRECT_MAPPED is not set
+# CONFIG_SH_WRITETHROUGH is not set
+# CONFIG_SH_OCRAM is not set
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_MEMORY_SIZE=0x00400000
+
+#
+# Processor features
+#
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SH_RTC=y
+# CONFIG_SH_DSP is not set
+CONFIG_SH_ADC=y
+
+#
+# Timer support
+#
+CONFIG_SH_TMU=y
+CONFIG_SH_PCLK_FREQ_BOOL=y
+CONFIG_SH_PCLK_FREQ=22110000
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# DMA support
+#
+CONFIG_SH_DMA=y
+CONFIG_NR_ONCHIP_DMA_CHANNELS=4
+# CONFIG_NR_DMA_CHANNELS_BOOL is not set
+# CONFIG_DMA_PAGE_OPS is not set
+
+#
+# Companion Chips
+#
+CONFIG_HD6446X_SERIES=y
+CONFIG_HD64461=y
+# CONFIG_HD64465 is not set
+CONFIG_HD64461_IRQ=36
+CONFIG_HD64461_IOBASE=0xb0000000
+CONFIG_HD64461_ENABLER=y
+
+#
+# Kernel features
+#
+# CONFIG_KEXEC is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_SMP is not set
+
+#
+# Boot options
+#
+CONFIG_ZERO_PAGE_OFFSET=0x00001000
+CONFIG_BOOT_LINK_OFFSET=0x00800000
+# CONFIG_UBC_WAKEUP is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_ISA=y
+# CONFIG_PCI is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+
+#
+# PC-card bridges
+#
+# CONFIG_I82365 is not set
+# CONFIG_TCIC is not set
+CONFIG_HD64461_PCMCIA=y
+CONFIG_HD64461_PCMCIA_SOCKETS=1
+CONFIG_PCMCIA_PROBE=y
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Networking
+#
+# CONFIG_NET is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+# CONFIG_PNP is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECS is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_IDE_SH=y
+# CONFIG_IDE_ARM is not set
+# CONFIG_IDE_CHIPSETS is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Old CD-ROM drivers (not SCSI, not IDE)
+#
+# CONFIG_CD_NO_IDESCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+
+#
+# Network device support
+#
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_SH_SCI is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+
+#
+# Graphics support
+#
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_EPSON1355 is not set
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_HIT=y
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+# CONFIG_FONT_8x16 is not set
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+CONFIG_FONT_PEARL_8x8=y
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=y
+
+#
+# Advanced Linux Sound Architecture
+#
+# CONFIG_SND is not set
+
+#
+# Open Sound System
+#
+CONFIG_SOUND_PRIME=y
+# CONFIG_OBSOLETE_OSS_DRIVER is not set
+# CONFIG_SOUND_MSNDCLAS is not set
+# CONFIG_SOUND_MSNDPIN is not set
+CONFIG_SOUND_SH_DAC_AUDIO=y
+CONFIG_SOUND_SH_DAC_AUDIO_CHANNEL=1
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_SH_STANDARD_BIOS is not set
+# CONFIG_KGDB is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
diff -urN -X exclude linux-2.6.15/arch/sh/tools/mach-types sh-2.6.15/arch/sh/tools/mach-types
--- linux-2.6.15/arch/sh/tools/mach-types	2004-12-26 05:37:11.000000000 +0200
+++ sh-2.6.15/arch/sh/tools/mach-types	2006-01-07 22:11:41.257993544 +0200
@@ -7,13 +7,10 @@
 #
 SE			SH_SOLUTION_ENGINE
 7751SE			SH_7751_SOLUTION_ENGINE		
-7300SE			SH_7300_SOLUTION_ENGINE
+7300SE			SH_7300_SOLUTION_ENGINE
 73180SE			SH_73180_SOLUTION_ENGINE
 7751SYSTEMH		SH_7751_SYSTEMH
-HP600			SH_HP600
-HP620			SH_HP620
-HP680			SH_HP680
-HP690			SH_HP690
+HP6XX			SH_HP6XX
 HD64461			HD64461
 HD64465			HD64465
 SH2000			SH_SH2000

diff -urN -X exclude linux-2.6.15/drivers/input/touchscreen/Kconfig sh-2.6.15/drivers/input/touchscreen/Kconfig
--- linux-2.6.15/drivers/input/touchscreen/Kconfig	2005-11-12 20:17:37.000000000 +0200
+++ sh-2.6.15/drivers/input/touchscreen/Kconfig	2006-01-04 00:15:28.000000000 +0200
@@ -85,7 +85,7 @@
 
 config TOUCHSCREEN_HP600
 	tristate "HP Jornada 680/690 touchscreen"
-	depends on SH_HP600 && SH_ADC
+	depends on SH_HP6XX && SH_ADC
 	help
 	  Say Y here if you have a HP Jornada 680 or 690 and want to
           support the built-in touchscreen.
