Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWFWSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWFWSmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWFWSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20943 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751930AbWFWSmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:08 -0400
Message-Id: <20060623183916.726374000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:17 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 21/21] convert VME irq code
Content-Disposition: inline; filename=0027-M68K-convert-VME-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/bvme6000/Makefile   |    2 -
 arch/m68k/bvme6000/bvmeints.c |  161 -----------------------------------------
 arch/m68k/bvme6000/config.c   |   21 ++---
 arch/m68k/mvme147/147ints.c   |  146 -------------------------------------
 arch/m68k/mvme147/Makefile    |    2 -
 arch/m68k/mvme147/config.c    |   22 ++----
 arch/m68k/mvme16x/16xints.c   |  150 --------------------------------------
 arch/m68k/mvme16x/Makefile    |    2 -
 arch/m68k/mvme16x/config.c    |   23 +++---
 include/asm-m68k/bvme6000hw.h |   30 ++++----
 include/asm-m68k/mvme147hw.h  |   44 ++++++-----
 include/asm-m68k/mvme16xhw.h  |   40 +++++-----
 12 files changed, 88 insertions(+), 555 deletions(-)
 delete mode 100644 arch/m68k/bvme6000/bvmeints.c
 delete mode 100644 arch/m68k/mvme147/147ints.c
 delete mode 100644 arch/m68k/mvme16x/16xints.c

4be81c0899302a775885858280aa764829944393
diff --git a/arch/m68k/bvme6000/Makefile b/arch/m68k/bvme6000/Makefile
index 2348e6c..d817400 100644
--- a/arch/m68k/bvme6000/Makefile
+++ b/arch/m68k/bvme6000/Makefile
@@ -2,4 +2,4 @@ #
 # Makefile for Linux arch/m68k/bvme6000 source directory
 #
 
-obj-y		:= config.o bvmeints.o rtc.o
+obj-y		:= config.o rtc.o
diff --git a/arch/m68k/bvme6000/bvmeints.c b/arch/m68k/bvme6000/bvmeints.c
deleted file mode 100644
index b015fdc..0000000
--- a/arch/m68k/bvme6000/bvmeints.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * arch/m68k/bvme6000/bvmeints.c
- *
- * Copyright (C) 1997 Richard Hirst [richard@sleepie.demon.co.uk]
- *
- * based on amiints.c -- Amiga Linux interrupt handling code
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file README.legal in the main directory of this archive
- * for more details.
- *
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/seq_file.h>
-
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/traps.h>
-
-static irqreturn_t bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp);
-
-/*
- * This should ideally be 4 elements only, for speed.
- */
-
-static struct {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-	const char	*devname;
-	unsigned	count;
-} irq_tab[256];
-
-/*
- * void bvme6000_init_IRQ (void)
- *
- * Parameters:	None
- *
- * Returns:	Nothing
- *
- * This function is called during kernel startup to initialize
- * the bvme6000 IRQ handling routines.
- */
-
-void bvme6000_init_IRQ (void)
-{
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		irq_tab[i].handler = bvme6000_defhand;
-		irq_tab[i].flags = IRQ_FLG_STD;
-		irq_tab[i].dev_id = NULL;
-		irq_tab[i].devname = NULL;
-		irq_tab[i].count = 0;
-	}
-}
-
-int bvme6000_request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                unsigned long flags, const char *devname, void *dev_id)
-{
-	if (irq > 255) {
-		printk("%s: Incorrect IRQ %d from %s\n", __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-#if 0
-	/* Nothing special about auto-vectored devices for the BVME6000,
-	 * but treat it specially to avoid changes elsewhere.
-	 */
-
-	if (irq >= VEC_INT1 && irq <= VEC_INT7)
-		return cpu_request_irq(irq - VEC_SPUR, handler, flags,
-						devname, dev_id);
-#endif
-	if (!(irq_tab[irq].flags & IRQ_FLG_STD)) {
-		if (irq_tab[irq].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_tab[irq].devname);
-			return -EBUSY;
-		}
-		if (flags & IRQ_FLG_REPLACE) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_tab[irq].devname);
-			return -EBUSY;
-		}
-	}
-	irq_tab[irq].handler = handler;
-	irq_tab[irq].flags   = flags;
-	irq_tab[irq].dev_id  = dev_id;
-	irq_tab[irq].devname = devname;
-	return 0;
-}
-
-void bvme6000_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq > 255) {
-		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-#if 0
-	if (irq >= VEC_INT1 && irq <= VEC_INT7) {
-		cpu_free_irq(irq - VEC_SPUR, dev_id);
-		return;
-	}
-#endif
-	if (irq_tab[irq].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_tab[irq].devname);
-
-	irq_tab[irq].handler = bvme6000_defhand;
-	irq_tab[irq].flags   = IRQ_FLG_STD;
-	irq_tab[irq].dev_id  = NULL;
-	irq_tab[irq].devname = NULL;
-}
-
-irqreturn_t bvme6000_process_int (unsigned long vec, struct pt_regs *fp)
-{
-	if (vec > 255) {
-		printk ("bvme6000_process_int: Illegal vector %ld", vec);
-		return IRQ_NONE;
-	} else {
-		irq_tab[vec].count++;
-		irq_tab[vec].handler(vec, irq_tab[vec].dev_id, fp);
-		return IRQ_HANDLED;
-	}
-}
-
-int show_bvme6000_interrupts(struct seq_file *p, void *v)
-{
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		if (irq_tab[i].count)
-			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
-			    i, irq_tab[i].count,
-			    irq_tab[i].devname ? irq_tab[i].devname : "free");
-	}
-	return 0;
-}
-
-
-static irqreturn_t bvme6000_defhand (int irq, void *dev_id, struct pt_regs *fp)
-{
-	printk ("Unknown interrupt 0x%02x\n", irq);
-	return IRQ_NONE;
-}
-
-void bvme6000_enable_irq (unsigned int irq)
-{
-}
-
-
-void bvme6000_disable_irq (unsigned int irq)
-{
-}
-
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index c90cb5f..d1e916a 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -36,15 +36,8 @@ #include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/bvme6000hw.h>
 
-extern irqreturn_t bvme6000_process_int (int level, struct pt_regs *regs);
-extern void bvme6000_init_IRQ (void);
-extern void bvme6000_free_irq (unsigned int, void *);
-extern int  show_bvme6000_interrupts(struct seq_file *, void *);
-extern void bvme6000_enable_irq (unsigned int);
-extern void bvme6000_disable_irq (unsigned int);
 static void bvme6000_get_model(char *model);
 static int  bvme6000_get_hardware_list(char *buffer);
-extern int  bvme6000_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void bvme6000_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long bvme6000_gettimeoffset (void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
@@ -100,6 +93,14 @@ static int bvme6000_get_hardware_list(ch
     return 0;
 }
 
+/*
+ * This function is called during kernel startup to initialize
+ * the bvme6000 IRQ handling routines.
+ */
+static void bvme6000_init_IRQ(void)
+{
+	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
+}
 
 void __init config_bvme6000(void)
 {
@@ -127,12 +128,6 @@ #endif
     mach_hwclk           = bvme6000_hwclk;
     mach_set_clock_mmss	 = bvme6000_set_clock_mmss;
     mach_reset		 = bvme6000_reset;
-    mach_free_irq	 = bvme6000_free_irq;
-    mach_process_int	 = bvme6000_process_int;
-    mach_get_irq_list	 = show_bvme6000_interrupts;
-    mach_request_irq	 = bvme6000_request_irq;
-    enable_irq		 = bvme6000_enable_irq;
-    disable_irq          = bvme6000_disable_irq;
     mach_get_model       = bvme6000_get_model;
     mach_get_hardware_list = bvme6000_get_hardware_list;
 
diff --git a/arch/m68k/mvme147/147ints.c b/arch/m68k/mvme147/147ints.c
deleted file mode 100644
index b4aa5e8..0000000
--- a/arch/m68k/mvme147/147ints.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- * arch/m68k/mvme147/147ints.c
- *
- * Copyright (C) 1997 Richard Hirst [richard@sleepie.demon.co.uk]
- *
- * based on amiints.c -- Amiga Linux interrupt handling code
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file README.legal in the main directory of this archive
- * for more details.
- *
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/seq_file.h>
-
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/traps.h>
-
-static irqreturn_t mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp);
-
-/*
- * This should ideally be 4 elements only, for speed.
- */
-
-static struct {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-	const char	*devname;
-	unsigned	count;
-} irq_tab[256];
-
-/*
- * void mvme147_init_IRQ (void)
- *
- * Parameters:	None
- *
- * Returns:	Nothing
- *
- * This function is called during kernel startup to initialize
- * the mvme147 IRQ handling routines.
- */
-
-void mvme147_init_IRQ (void)
-{
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		irq_tab[i].handler = mvme147_defhand;
-		irq_tab[i].flags = IRQ_FLG_STD;
-		irq_tab[i].dev_id = NULL;
-		irq_tab[i].devname = NULL;
-		irq_tab[i].count = 0;
-	}
-}
-
-int mvme147_request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                unsigned long flags, const char *devname, void *dev_id)
-{
-	if (irq > 255) {
-		printk("%s: Incorrect IRQ %d from %s\n", __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-	if (!(irq_tab[irq].flags & IRQ_FLG_STD)) {
-		if (irq_tab[irq].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_tab[irq].devname);
-			return -EBUSY;
-		}
-		if (flags & IRQ_FLG_REPLACE) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_tab[irq].devname);
-			return -EBUSY;
-		}
-	}
-	irq_tab[irq].handler = handler;
-	irq_tab[irq].flags   = flags;
-	irq_tab[irq].dev_id  = dev_id;
-	irq_tab[irq].devname = devname;
-	return 0;
-}
-
-void mvme147_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq > 255) {
-		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-	if (irq_tab[irq].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_tab[irq].devname);
-
-	irq_tab[irq].handler = mvme147_defhand;
-	irq_tab[irq].flags   = IRQ_FLG_STD;
-	irq_tab[irq].dev_id  = NULL;
-	irq_tab[irq].devname = NULL;
-}
-
-irqreturn_t mvme147_process_int (unsigned long vec, struct pt_regs *fp)
-{
-	if (vec > 255) {
-		printk ("mvme147_process_int: Illegal vector %ld\n", vec);
-		return IRQ_NONE;
-	} else {
-		irq_tab[vec].count++;
-		irq_tab[vec].handler(vec, irq_tab[vec].dev_id, fp);
-		return IRQ_HANDLED;
-	}
-}
-
-int show_mvme147_interrupts (struct seq_file *p, void *v)
-{
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		if (irq_tab[i].count)
-			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
-			    i, irq_tab[i].count,
-			    irq_tab[i].devname ? irq_tab[i].devname : "free");
-	}
-	return 0;
-}
-
-
-static irqreturn_t mvme147_defhand (int irq, void *dev_id, struct pt_regs *fp)
-{
-	printk ("Unknown interrupt 0x%02x\n", irq);
-	return IRQ_NONE;
-}
-
-void mvme147_enable_irq (unsigned int irq)
-{
-}
-
-
-void mvme147_disable_irq (unsigned int irq)
-{
-}
-
diff --git a/arch/m68k/mvme147/Makefile b/arch/m68k/mvme147/Makefile
index f0153ed..a36d38d 100644
--- a/arch/m68k/mvme147/Makefile
+++ b/arch/m68k/mvme147/Makefile
@@ -2,4 +2,4 @@ #
 # Makefile for Linux arch/m68k/mvme147 source directory
 #
 
-obj-y		:= config.o 147ints.o
+obj-y		:= config.o
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 0fcf972..0cd0e5b 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -36,15 +36,8 @@ #include <asm/machdep.h>
 #include <asm/mvme147hw.h>
 
 
-extern irqreturn_t mvme147_process_int (int level, struct pt_regs *regs);
-extern void mvme147_init_IRQ (void);
-extern void mvme147_free_irq (unsigned int, void *);
-extern int  show_mvme147_interrupts (struct seq_file *, void *);
-extern void mvme147_enable_irq (unsigned int);
-extern void mvme147_disable_irq (unsigned int);
 static void mvme147_get_model(char *model);
 static int  mvme147_get_hardware_list(char *buffer);
-extern int mvme147_request_irq (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void mvme147_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long mvme147_gettimeoffset (void);
 extern int mvme147_hwclk (int, struct rtc_time *);
@@ -91,6 +84,15 @@ static int mvme147_get_hardware_list(cha
 	return 0;
 }
 
+/*
+ * This function is called during kernel startup to initialize
+ * the mvme147 IRQ handling routines.
+ */
+
+void mvme147_init_IRQ(void)
+{
+	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
+}
 
 void __init config_mvme147(void)
 {
@@ -101,12 +103,6 @@ void __init config_mvme147(void)
 	mach_hwclk		= mvme147_hwclk;
 	mach_set_clock_mmss	= mvme147_set_clock_mmss;
 	mach_reset		= mvme147_reset;
-	mach_free_irq		= mvme147_free_irq;
-	mach_process_int	= mvme147_process_int;
-	mach_get_irq_list	= show_mvme147_interrupts;
-	mach_request_irq	= mvme147_request_irq;
-	enable_irq		= mvme147_enable_irq;
-	disable_irq		= mvme147_disable_irq;
 	mach_get_model		= mvme147_get_model;
 	mach_get_hardware_list	= mvme147_get_hardware_list;
 
diff --git a/arch/m68k/mvme16x/16xints.c b/arch/m68k/mvme16x/16xints.c
deleted file mode 100644
index 81afada..0000000
--- a/arch/m68k/mvme16x/16xints.c
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * arch/m68k/mvme16x/16xints.c
- *
- * Copyright (C) 1995 Richard Hirst [richard@sleepie.demon.co.uk]
- *
- * based on amiints.c -- Amiga Linux interrupt handling code
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file README.legal in the main directory of this archive
- * for more details.
- *
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/seq_file.h>
-
-#include <asm/system.h>
-#include <asm/ptrace.h>
-#include <asm/irq.h>
-
-static irqreturn_t mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp);
-
-/*
- * This should ideally be 4 elements only, for speed.
- */
-
-static struct {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
-	void		*dev_id;
-	const char	*devname;
-	unsigned	count;
-} irq_tab[192];
-
-/*
- * void mvme16x_init_IRQ (void)
- *
- * Parameters:	None
- *
- * Returns:	Nothing
- *
- * This function is called during kernel startup to initialize
- * the mvme16x IRQ handling routines.  Should probably ensure
- * that the base vectors for the VMEChip2 and PCCChip2 are valid.
- */
-
-void mvme16x_init_IRQ (void)
-{
-	int i;
-
-	for (i = 0; i < 192; i++) {
-		irq_tab[i].handler = mvme16x_defhand;
-		irq_tab[i].flags = IRQ_FLG_STD;
-		irq_tab[i].dev_id = NULL;
-		irq_tab[i].devname = NULL;
-		irq_tab[i].count = 0;
-	}
-}
-
-int mvme16x_request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                unsigned long flags, const char *devname, void *dev_id)
-{
-	if (irq < 64 || irq > 255) {
-		printk("%s: Incorrect IRQ %d from %s\n", __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-
-	if (!(irq_tab[irq-64].flags & IRQ_FLG_STD)) {
-		if (irq_tab[irq-64].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_tab[irq-64].devname);
-			return -EBUSY;
-		}
-		if (flags & IRQ_FLG_REPLACE) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_tab[irq-64].devname);
-			return -EBUSY;
-		}
-	}
-	irq_tab[irq-64].handler = handler;
-	irq_tab[irq-64].flags   = flags;
-	irq_tab[irq-64].dev_id  = dev_id;
-	irq_tab[irq-64].devname = devname;
-	return 0;
-}
-
-void mvme16x_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq < 64 || irq > 255) {
-		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq_tab[irq-64].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_tab[irq-64].devname);
-
-	irq_tab[irq-64].handler = mvme16x_defhand;
-	irq_tab[irq-64].flags   = IRQ_FLG_STD;
-	irq_tab[irq-64].dev_id  = NULL;
-	irq_tab[irq-64].devname = NULL;
-}
-
-irqreturn_t mvme16x_process_int (unsigned long vec, struct pt_regs *fp)
-{
-	if (vec < 64 || vec > 255) {
-		printk ("mvme16x_process_int: Illegal vector %ld", vec);
-		return IRQ_NONE;
-	} else {
-		irq_tab[vec-64].count++;
-		irq_tab[vec-64].handler(vec, irq_tab[vec-64].dev_id, fp);
-		return IRQ_HANDLED;
-	}
-}
-
-int show_mvme16x_interrupts (struct seq_file *p, void *v)
-{
-	int i;
-
-	for (i = 0; i < 192; i++) {
-		if (irq_tab[i].count)
-			seq_printf(p, "Vec 0x%02x: %8d  %s\n",
-			    i+64, irq_tab[i].count,
-			    irq_tab[i].devname ? irq_tab[i].devname : "free");
-	}
-	return 0;
-}
-
-
-static irqreturn_t mvme16x_defhand (int irq, void *dev_id, struct pt_regs *fp)
-{
-	printk ("Unknown interrupt 0x%02x\n", irq);
-	return IRQ_NONE;
-}
-
-
-void mvme16x_enable_irq (unsigned int irq)
-{
-}
-
-
-void mvme16x_disable_irq (unsigned int irq)
-{
-}
-
-
diff --git a/arch/m68k/mvme16x/Makefile b/arch/m68k/mvme16x/Makefile
index 5129f56..950e82f 100644
--- a/arch/m68k/mvme16x/Makefile
+++ b/arch/m68k/mvme16x/Makefile
@@ -2,4 +2,4 @@ #
 # Makefile for Linux arch/m68k/mvme16x source directory
 #
 
-obj-y		:= config.o 16xints.o rtc.o mvme16x_ksyms.o
+obj-y		:= config.o rtc.o mvme16x_ksyms.o
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 26ce81c..ce2727e 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -40,15 +40,8 @@ extern t_bdid mvme_bdid;
 
 static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
 
-extern irqreturn_t mvme16x_process_int (int level, struct pt_regs *regs);
-extern void mvme16x_init_IRQ (void);
-extern void mvme16x_free_irq (unsigned int, void *);
-extern int show_mvme16x_interrupts (struct seq_file *, void *);
-extern void mvme16x_enable_irq (unsigned int);
-extern void mvme16x_disable_irq (unsigned int);
 static void mvme16x_get_model(char *model);
 static int  mvme16x_get_hardware_list(char *buffer);
-extern int  mvme16x_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void mvme16x_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern unsigned long mvme16x_gettimeoffset (void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
@@ -120,6 +113,16 @@ static int mvme16x_get_hardware_list(cha
     return (len);
 }
 
+/*
+ * This function is called during kernel startup to initialize
+ * the mvme16x IRQ handling routines.  Should probably ensure
+ * that the base vectors for the VMEChip2 and PCCChip2 are valid.
+ */
+
+static void mvme16x_init_IRQ (void)
+{
+	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
+}
 
 #define pcc2chip	((volatile u_char *)0xfff42000)
 #define PccSCCMICR	0x1d
@@ -138,12 +141,6 @@ void __init config_mvme16x(void)
     mach_hwclk           = mvme16x_hwclk;
     mach_set_clock_mmss	 = mvme16x_set_clock_mmss;
     mach_reset		 = mvme16x_reset;
-    mach_free_irq	 = mvme16x_free_irq;
-    mach_process_int	 = mvme16x_process_int;
-    mach_get_irq_list	 = show_mvme16x_interrupts;
-    mach_request_irq	 = mvme16x_request_irq;
-    enable_irq           = mvme16x_enable_irq;
-    disable_irq          = mvme16x_disable_irq;
     mach_get_model       = mvme16x_get_model;
     mach_get_hardware_list = mvme16x_get_hardware_list;
 
diff --git a/include/asm-m68k/bvme6000hw.h b/include/asm-m68k/bvme6000hw.h
index 28a859b..f40d2f8 100644
--- a/include/asm-m68k/bvme6000hw.h
+++ b/include/asm-m68k/bvme6000hw.h
@@ -109,23 +109,23 @@ #define BVME_CONFIG_SW4	0x01
 
 #define BVME_IRQ_TYPE_PRIO	0
 
-#define BVME_IRQ_PRN		0x54
-#define BVME_IRQ_I596		0x1a
-#define BVME_IRQ_SCSI		0x1b
-#define BVME_IRQ_TIMER		0x59
-#define BVME_IRQ_RTC		0x1e
-#define BVME_IRQ_ABORT		0x1f
+#define BVME_IRQ_PRN		(IRQ_USER+20)
+#define BVME_IRQ_TIMER		(IRQ_USER+25)
+#define BVME_IRQ_I596		IRQ_AUTO_2
+#define BVME_IRQ_SCSI		IRQ_AUTO_3
+#define BVME_IRQ_RTC		IRQ_AUTO_6
+#define BVME_IRQ_ABORT		IRQ_AUTO_7
 
 /* SCC interrupts */
-#define BVME_IRQ_SCC_BASE		0x40
-#define BVME_IRQ_SCCB_TX		0x40
-#define BVME_IRQ_SCCB_STAT		0x42
-#define BVME_IRQ_SCCB_RX		0x44
-#define BVME_IRQ_SCCB_SPCOND		0x46
-#define BVME_IRQ_SCCA_TX		0x48
-#define BVME_IRQ_SCCA_STAT		0x4a
-#define BVME_IRQ_SCCA_RX		0x4c
-#define BVME_IRQ_SCCA_SPCOND		0x4e
+#define BVME_IRQ_SCC_BASE		IRQ_USER
+#define BVME_IRQ_SCCB_TX		IRQ_USER
+#define BVME_IRQ_SCCB_STAT		(IRQ_USER+2)
+#define BVME_IRQ_SCCB_RX		(IRQ_USER+4)
+#define BVME_IRQ_SCCB_SPCOND		(IRQ_USER+6)
+#define BVME_IRQ_SCCA_TX		(IRQ_USER+8)
+#define BVME_IRQ_SCCA_STAT		(IRQ_USER+10)
+#define BVME_IRQ_SCCA_RX		(IRQ_USER+12)
+#define BVME_IRQ_SCCA_SPCOND		(IRQ_USER+14)
 
 /* Address control registers */
 
diff --git a/include/asm-m68k/mvme147hw.h b/include/asm-m68k/mvme147hw.h
index f245139..b810431 100644
--- a/include/asm-m68k/mvme147hw.h
+++ b/include/asm-m68k/mvme147hw.h
@@ -1,6 +1,8 @@
 #ifndef _MVME147HW_H_
 #define _MVME147HW_H_
 
+#include <asm/irq.h>
+
 typedef struct {
 	unsigned char
 		ctrl,
@@ -72,39 +74,39 @@ #define PCC_LEVEL_TIMER1	0x04
 #define PCC_LEVEL_SCSI_PORT	0x04
 #define PCC_LEVEL_SCSI_DMA	0x04
 
-#define PCC_IRQ_AC_FAIL		0x40
-#define PCC_IRQ_BERR		0x41
-#define PCC_IRQ_ABORT		0x42
-/* #define PCC_IRQ_SERIAL	0x43 */
-#define PCC_IRQ_PRINTER		0x47
-#define PCC_IRQ_TIMER1		0x48
-#define PCC_IRQ_TIMER2		0x49
-#define PCC_IRQ_SOFTWARE1	0x4a
-#define PCC_IRQ_SOFTWARE2	0x4b
+#define PCC_IRQ_AC_FAIL		(IRQ_USER+0)
+#define PCC_IRQ_BERR		(IRQ_USER+1)
+#define PCC_IRQ_ABORT		(IRQ_USER+2)
+/* #define PCC_IRQ_SERIAL	(IRQ_USER+3) */
+#define PCC_IRQ_PRINTER		(IRQ_USER+7)
+#define PCC_IRQ_TIMER1		(IRQ_USER+8)
+#define PCC_IRQ_TIMER2		(IRQ_USER+9)
+#define PCC_IRQ_SOFTWARE1	(IRQ_USER+10)
+#define PCC_IRQ_SOFTWARE2	(IRQ_USER+11)
 
 
 #define M147_SCC_A_ADDR		0xfffe3002
 #define M147_SCC_B_ADDR		0xfffe3000
 #define M147_SCC_PCLK		5000000
 
-#define MVME147_IRQ_SCSI_PORT	0x45
-#define MVME147_IRQ_SCSI_DMA	0x46
+#define MVME147_IRQ_SCSI_PORT	(IRQ_USER+0x45)
+#define MVME147_IRQ_SCSI_DMA	(IRQ_USER+0x46)
 
 /* SCC interrupts, for MVME147 */
 
 #define MVME147_IRQ_TYPE_PRIO	0
-#define MVME147_IRQ_SCC_BASE		0x60
-#define MVME147_IRQ_SCCB_TX		0x60
-#define MVME147_IRQ_SCCB_STAT		0x62
-#define MVME147_IRQ_SCCB_RX		0x64
-#define MVME147_IRQ_SCCB_SPCOND		0x66
-#define MVME147_IRQ_SCCA_TX		0x68
-#define MVME147_IRQ_SCCA_STAT		0x6a
-#define MVME147_IRQ_SCCA_RX		0x6c
-#define MVME147_IRQ_SCCA_SPCOND		0x6e
+#define MVME147_IRQ_SCC_BASE		(IRQ_USER+32)
+#define MVME147_IRQ_SCCB_TX		(IRQ_USER+32)
+#define MVME147_IRQ_SCCB_STAT		(IRQ_USER+34)
+#define MVME147_IRQ_SCCB_RX		(IRQ_USER+36)
+#define MVME147_IRQ_SCCB_SPCOND		(IRQ_USER+38)
+#define MVME147_IRQ_SCCA_TX		(IRQ_USER+40)
+#define MVME147_IRQ_SCCA_STAT		(IRQ_USER+42)
+#define MVME147_IRQ_SCCA_RX		(IRQ_USER+44)
+#define MVME147_IRQ_SCCA_SPCOND		(IRQ_USER+46)
 
 #define MVME147_LANCE_BASE	0xfffe1800
-#define MVME147_LANCE_IRQ	0x44
+#define MVME147_LANCE_IRQ	(IRQ_USER+4)
 
 #define ETHERNET_ADDRESS 0xfffe0778
 
diff --git a/include/asm-m68k/mvme16xhw.h b/include/asm-m68k/mvme16xhw.h
index 5d07231..6117f56 100644
--- a/include/asm-m68k/mvme16xhw.h
+++ b/include/asm-m68k/mvme16xhw.h
@@ -66,28 +66,28 @@ #define MVME_SCC_PCLK	10000000
 
 #define MVME162_IRQ_TYPE_PRIO	0
 
-#define MVME167_IRQ_PRN		0x54
-#define MVME16x_IRQ_I596	0x57
-#define MVME16x_IRQ_SCSI	0x55
-#define MVME16x_IRQ_FLY		0x7f
-#define MVME167_IRQ_SER_ERR	0x5c
-#define MVME167_IRQ_SER_MODEM	0x5d
-#define MVME167_IRQ_SER_TX	0x5e
-#define MVME167_IRQ_SER_RX	0x5f
-#define MVME16x_IRQ_TIMER	0x59
-#define MVME167_IRQ_ABORT	0x6e
-#define MVME162_IRQ_ABORT	0x5e
+#define MVME167_IRQ_PRN		(IRQ_USER+20)
+#define MVME16x_IRQ_I596	(IRQ_USER+23)
+#define MVME16x_IRQ_SCSI	(IRQ_USER+21)
+#define MVME16x_IRQ_FLY		(IRQ_USER+63)
+#define MVME167_IRQ_SER_ERR	(IRQ_USER+28)
+#define MVME167_IRQ_SER_MODEM	(IRQ_USER+29)
+#define MVME167_IRQ_SER_TX	(IRQ_USER+30)
+#define MVME167_IRQ_SER_RX	(IRQ_USER+31)
+#define MVME16x_IRQ_TIMER	(IRQ_USER+25)
+#define MVME167_IRQ_ABORT	(IRQ_USER+46)
+#define MVME162_IRQ_ABORT	(IRQ_USER+30)
 
 /* SCC interrupts, for MVME162 */
-#define MVME162_IRQ_SCC_BASE		0x40
-#define MVME162_IRQ_SCCB_TX		0x40
-#define MVME162_IRQ_SCCB_STAT		0x42
-#define MVME162_IRQ_SCCB_RX		0x44
-#define MVME162_IRQ_SCCB_SPCOND		0x46
-#define MVME162_IRQ_SCCA_TX		0x48
-#define MVME162_IRQ_SCCA_STAT		0x4a
-#define MVME162_IRQ_SCCA_RX		0x4c
-#define MVME162_IRQ_SCCA_SPCOND		0x4e
+#define MVME162_IRQ_SCC_BASE		(IRQ_USER+0)
+#define MVME162_IRQ_SCCB_TX		(IRQ_USER+0)
+#define MVME162_IRQ_SCCB_STAT		(IRQ_USER+2)
+#define MVME162_IRQ_SCCB_RX		(IRQ_USER+4)
+#define MVME162_IRQ_SCCB_SPCOND		(IRQ_USER+6)
+#define MVME162_IRQ_SCCA_TX		(IRQ_USER+8)
+#define MVME162_IRQ_SCCA_STAT		(IRQ_USER+10)
+#define MVME162_IRQ_SCCA_RX		(IRQ_USER+12)
+#define MVME162_IRQ_SCCA_SPCOND		(IRQ_USER+14)
 
 /* MVME162 version register */
 
-- 
1.3.3

--

