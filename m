Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUJCX2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUJCX2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268238AbUJCX2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:28:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:16798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268237AbUJCX2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:28:11 -0400
Date: Sun, 3 Oct 2004 16:24:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <safemode@comcast.net>
Cc: preining@logic.at, adrian.bunk@stusta.de, edt@aei.ca, jeremy@goop.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-Id: <20041003162456.4729ab1a.akpm@osdl.org>
In-Reply-To: <416084A5.4080200@comcast.net>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at>
	<20041002022921.0e1aceb3.akpm@osdl.org>
	<200410021440.45194.edt@aei.ca>
	<1096787657.9182.6.camel@localhost>
	<20041002091644.GA8431@gamma.logic.tuwien.ac.at>
	<20041002022921.0e1aceb3.akpm@osdl.org>
	<200410021440.45194.edt@aei.ca>
	<20041002091644.GA8431@gamma.logic.tuwien.ac.at>
	<20041002022921.0e1aceb3.akpm@osdl.org>
	<20041002105038.GB2470@stusta.mhn.de>
	<20041003083014.GB12458@gamma.logic.tuwien.ac.at>
	<416084A5.4080200@comcast.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <safemode@comcast.net> wrote:
>
> None of the mails reporting that inserting a header in any file has 
>  produced a build here that actually gets rid of the build error.  I have 
>  the same errors about implicit declarations of ack_APIC_irq that i had 
>  before i added asm/io_apic.h to irq.c in arch/i386/kernel and before i 
>  added it to include/asm/hardirq.h.   I've attached my .config to see if 
>  anyone realizes what i'm doing wrong or what's not being defined 
>  correctly.

yeah, it's all screwed up.  I fixed it up with the below two patches.



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/apic.c    |   18 ++++++++++++++++++
 25-akpm/arch/i386/kernel/irq.c     |   11 +++++++++++
 25-akpm/include/asm-i386/hardirq.h |   22 +---------------------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff -puN include/asm-i386/hardirq.h~uninline-ack_bad_irq include/asm-i386/hardirq.h
--- 25/include/asm-i386/hardirq.h~uninline-ack_bad_irq	2004-10-02 14:27:51.603791632 -0700
+++ 25-akpm/include/asm-i386/hardirq.h	2004-10-02 14:27:51.610790568 -0700
@@ -14,26 +14,6 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves.
- */
-static inline void ack_bad_irq(unsigned int irq)
-{
-#ifdef CONFIG_X86
-	printk("unexpected IRQ trap at vector %02x\n", irq);
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Currently unexpected vectors happen only on SMP and APIC.
-	 * We _must_ ack these because every local APIC has only N
-	 * irq slots per priority level, and a 'hanging, unacked' IRQ
-	 * holds up an irq slot - in excessive cases (when multiple
-	 * unexpected vectors occur) that might lock up the APIC
-	 * completely.
-	 */
-	ack_APIC_irq();
-#endif
-#endif
-}
+void ack_bad_irq(unsigned int irq);
 
 #endif /* __ASM_HARDIRQ_H */
diff -puN arch/i386/kernel/irq.c~uninline-ack_bad_irq arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~uninline-ack_bad_irq	2004-10-02 14:27:51.605791328 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2004-10-02 14:27:51.610790568 -0700
@@ -16,6 +16,17 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
+#ifndef CONFIG_X86_LOCAL_APIC
+/*
+ * 'what should we do if we get a hw irq event on an illegal vector'.
+ * each architecture has to answer this themselves.
+ */
+void ack_bad_irq(unsigned int irq)
+{
+	printk("unexpected IRQ trap at vector %02x\n", irq);
+}
+#endif
+
 #ifdef CONFIG_4KSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
diff -puN arch/i386/kernel/apic.c~uninline-ack_bad_irq arch/i386/kernel/apic.c
--- 25/arch/i386/kernel/apic.c~uninline-ack_bad_irq	2004-10-02 14:27:51.606791176 -0700
+++ 25-akpm/arch/i386/kernel/apic.c	2004-10-02 14:27:51.611790416 -0700
@@ -47,6 +47,24 @@ int apic_verbosity;
 
 static void apic_pm_activate(void);
 
+/*
+ * 'what should we do if we get a hw irq event on an illegal vector'.
+ * each architecture has to answer this themselves.
+ */
+void ack_bad_irq(unsigned int irq)
+{
+	printk("unexpected IRQ trap at vector %02x\n", irq);
+	/*
+	 * Currently unexpected vectors happen only on SMP and APIC.
+	 * We _must_ ack these because every local APIC has only N
+	 * irq slots per priority level, and a 'hanging, unacked' IRQ
+	 * holds up an irq slot - in excessive cases (when multiple
+	 * unexpected vectors occur) that might lock up the APIC
+	 * completely.
+	 */
+	ack_APIC_irq();
+}
+
 void __init apic_intr_init(void)
 {
 #ifdef CONFIG_SMP
_






- remove APIC_MISMATCH_DEBUG altogether.  Just make it synonymous with
  CONFIG_X86_IO_APIC

- Move the definition of irq_mis_count over to io_apic.c

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/io_apic.c |    4 ++--
 25-akpm/arch/i386/kernel/irq.c     |    5 +----
 25-akpm/include/asm-i386/io_apic.h |    2 --
 3 files changed, 3 insertions(+), 8 deletions(-)

diff -puN include/asm-i386/io_apic.h~irq_mis_count-build-fix include/asm-i386/io_apic.h
--- 25/include/asm-i386/io_apic.h~irq_mis_count-build-fix	2004-10-02 14:36:52.055630464 -0700
+++ 25-akpm/include/asm-i386/io_apic.h	2004-10-02 14:37:03.188937944 -0700
@@ -53,8 +53,6 @@ static inline void end_edge_ioapic_irq (
 #define end_edge_ioapic 	end_edge_ioapic_irq
 #endif
 
-#define APIC_MISMATCH_DEBUG
-
 #define IO_APIC_BASE(idx) \
 		((volatile int *)(__fix_to_virt(FIX_IO_APIC_BASE_0 + idx) \
 		+ (mp_ioapics[idx].mpc_apicaddr & ~PAGE_MASK)))
diff -puN arch/i386/kernel/irq.c~irq_mis_count-build-fix arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~irq_mis_count-build-fix	2004-10-02 14:36:52.072627880 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2004-10-02 14:37:26.449401816 -0700
@@ -194,9 +194,6 @@ EXPORT_SYMBOL(do_softirq);
  */
 
 atomic_t irq_err_count;
-#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
-atomic_t irq_mis_count;
-#endif
 
 /*
  * /proc/interrupts printing:
@@ -253,7 +250,7 @@ skip:
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
+#if defined(CONFIG_X86_IO_APIC)
 		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 	}
diff -puN arch/i386/kernel/io_apic.c~irq_mis_count-build-fix arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~irq_mis_count-build-fix	2004-10-02 14:36:52.091624992 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2004-10-02 14:37:56.827783600 -0700
@@ -42,6 +42,8 @@
 
 #include "io_ports.h"
 
+atomic_t irq_mis_count;
+
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -1877,9 +1879,7 @@ static void end_level_ioapic_irq (unsign
 	ack_APIC_irq();
 
 	if (!(v & (1 << (i & 0x1f)))) {
-#ifdef APIC_MISMATCH_DEBUG
 		atomic_inc(&irq_mis_count);
-#endif
 		spin_lock(&ioapic_lock);
 		__mask_and_edge_IO_APIC_irq(irq);
 		__unmask_and_level_IO_APIC_irq(irq);
_

