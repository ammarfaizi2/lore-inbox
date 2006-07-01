Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWGAO4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWGAO4w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGAO4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:56:52 -0400
Received: from www.osadl.org ([213.239.205.134]:18340 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751367AbWGAO4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:51 -0400
Message-Id: <20060701145223.318475000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 01/44] Consolidate flags for request_irq
Content-Disposition: inline; filename=irqflags-base.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move the interrupt related SA_ flags out of linux/signal.h and rename
them to IRQF_ . This moves the interrupt related flags out of the signal
namespace and allows to remove the architecture dependencies.

SA_INTERRUPT is not needed by userspace and glibc so it can be removed
safely. The existing SA_ constants are kept for easy transition and will
be removed after a 6 month grace period.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 Documentation/feature-removal-schedule.txt |    9 ++++
 include/linux/interrupt.h                  |   47 ++++++++++++++++++++++++
 include/linux/irq.h                        |   55 ++++++++++++++---------------
 include/linux/signal.h                     |   26 -------------
 4 files changed, 83 insertions(+), 54 deletions(-)

Index: linux-2.6.git/include/linux/interrupt.h
===================================================================
--- linux-2.6.git.orig/include/linux/interrupt.h	2006-07-01 16:51:30.000000000 +0200
+++ linux-2.6.git/include/linux/interrupt.h	2006-07-01 16:51:30.000000000 +0200
@@ -14,6 +14,53 @@
 #include <asm/ptrace.h>
 #include <asm/system.h>
 
+/*
+ * These correspond to the IORESOURCE_IRQ_* defines in
+ * linux/ioport.h to select the interrupt line behaviour.  When
+ * requesting an interrupt without specifying a IRQF_TRIGGER, the
+ * setting should be assumed to be "as already configured", which
+ * may be as per machine or firmware initialisation.
+ */
+#define IRQF_TRIGGER_NONE	0x00000000
+#define IRQF_TRIGGER_RISING	0x00000001
+#define IRQF_TRIGGER_FALLING	0x00000002
+#define IRQF_TRIGGER_HIGH	0x00000004
+#define IRQF_TRIGGER_LOW	0x00000008
+#define IRQF_TRIGGER_MASK	(IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW | \
+				 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)
+#define IRQF_TRIGGER_PROBE	0x00000010
+
+/*
+ * These flags used only by the kernel as part of the
+ * irq handling routines.
+ *
+ * IRQF_DISABLED - keep irqs disabled when calling the action handler
+ * IRQF_SAMPLE_RANDOM - irq is used to feed the random generator
+ * IRQF_SHARED - allow sharing the irq among several devices
+ * IRQF_PROBE_SHARED - set by callers when they expect sharing mismatches to occur
+ * IRQF_TIMER - Flag to mark this interrupt as timer interrupt
+ */
+#define IRQF_DISABLED		0x00000020
+#define IRQF_SAMPLE_RANDOM	0x00000040
+#define IRQF_SHARED		0x00000080
+#define IRQF_PROBE_SHARED	0x00000100
+#define IRQF_TIMER		0x00000200
+
+/*
+ * Migration helpers. Scheduled for removal in 1/2007
+ * Do not use for new code !
+ */
+#define SA_INTERRUPT		IRQF_DISABLED
+#define SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
+#define SA_SHIRQ		IRQF_SHARED
+#define SA_PROBEIRQ		IRQF_PROBE_SHARED
+
+#define SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
+#define SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
+#define SA_TRIGGER_FALLING	IRQF_TRIGGER_FALLING
+#define SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
+#define SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
+
 struct irqaction {
 	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
Index: linux-2.6.git/include/linux/signal.h
===================================================================
--- linux-2.6.git.orig/include/linux/signal.h	2006-07-01 16:51:30.000000000 +0200
+++ linux-2.6.git/include/linux/signal.h	2006-07-01 16:51:30.000000000 +0200
@@ -9,32 +9,6 @@
 #include <linux/spinlock.h>
 
 /*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ is for shared interrupt support on PCI and EISA.
- * SA_PROBEIRQ is set by callers when they expect sharing mismatches to occur
- */
-#define SA_SAMPLE_RANDOM	SA_RESTART
-#define SA_SHIRQ		0x04000000
-#define SA_PROBEIRQ		0x08000000
-
-/*
- * As above, these correspond to the IORESOURCE_IRQ_* defines in
- * linux/ioport.h to select the interrupt line behaviour.  When
- * requesting an interrupt without specifying a SA_TRIGGER, the
- * setting should be assumed to be "as already configured", which
- * may be as per machine or firmware initialisation.
- */
-#define SA_TRIGGER_LOW		0x00000008
-#define SA_TRIGGER_HIGH		0x00000004
-#define SA_TRIGGER_FALLING	0x00000002
-#define SA_TRIGGER_RISING	0x00000001
-#define SA_TRIGGER_MASK	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
-				 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)
-
-/*
  * Real Time signals may be queued.
  */
 
Index: linux-2.6.git/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.git.orig/Documentation/feature-removal-schedule.txt	2006-07-01 16:51:30.000000000 +0200
+++ linux-2.6.git/Documentation/feature-removal-schedule.txt	2006-07-01 16:51:30.000000000 +0200
@@ -257,3 +257,12 @@ Why:	Code does no longer build since at 
 Who:	Ralf Baechle <ralf@linux-mips.org>
 
 ---------------------------
+
+What:	Interrupt only SA_* flags
+When:	Januar 2007
+Why:	The interrupt related SA_* flags are replaced by IRQF_* to move them
+	out of the signal namespace.
+
+Who:	Thomas Gleixner <tglx@linutronix.de>
+
+---------------------------
Index: linux-2.6.git/include/linux/irq.h
===================================================================
--- linux-2.6.git.orig/include/linux/irq.h	2006-07-01 16:51:30.000000000 +0200
+++ linux-2.6.git/include/linux/irq.h	2006-07-01 16:51:30.000000000 +0200
@@ -24,41 +24,40 @@
 
 /*
  * IRQ line status.
+ *
+ * Bits 0-16 are reserved for the IRQF_* bits in linux/interrupt.h
+ *
+ * IRQ types
  */
-#define IRQ_INPROGRESS	1	/* IRQ handler active - do not enter! */
-#define IRQ_DISABLED	2	/* IRQ disabled - do not enter! */
-#define IRQ_PENDING	4	/* IRQ pending - replay on enable */
-#define IRQ_REPLAY	8	/* IRQ has been replayed but not acked yet */
-#define IRQ_AUTODETECT	16	/* IRQ is being autodetected */
-#define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
-#define IRQ_LEVEL	64	/* IRQ level triggered */
-#define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
+#define IRQ_TYPE_NONE		0x00000000	/* Default, unspecified type */
+#define IRQ_TYPE_EDGE_RISING	0x00000001	/* Edge rising type */
+#define IRQ_TYPE_EDGE_FALLING	0x00000002	/* Edge falling type */
+#define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
+#define IRQ_TYPE_LEVEL_HIGH	0x00000004	/* Level high type */
+#define IRQ_TYPE_LEVEL_LOW	0x00000008	/* Level low type */
+#define IRQ_TYPE_SENSE_MASK	0x0000000f	/* Mask of the above */
+#define IRQ_TYPE_PROBE		0x00000010	/* Probing in progress */
+
+/* Internal flags */
+#define IRQ_INPROGRESS		0x00010000	/* IRQ handler active - do not enter! */
+#define IRQ_DISABLED		0x00020000	/* IRQ disabled - do not enter! */
+#define IRQ_PENDING		0x00040000	/* IRQ pending - replay on enable */
+#define IRQ_REPLAY		0x00080000	/* IRQ has been replayed but not acked yet */
+#define IRQ_AUTODETECT		0x00100000	/* IRQ is being autodetected */
+#define IRQ_WAITING		0x00200000	/* IRQ not yet seen - for autodetection */
+#define IRQ_LEVEL		0x00400000	/* IRQ level triggered */
+#define IRQ_MASKED		0x00800000	/* IRQ masked - shouldn't be seen again */
 #ifdef CONFIG_IRQ_PER_CPU
-# define IRQ_PER_CPU	256	/* IRQ is per CPU */
+# define IRQ_PER_CPU		0x01000000	/* IRQ is per CPU */
 # define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
 #else
 # define CHECK_IRQ_PER_CPU(var) 0
 #endif
 
-#define IRQ_NOPROBE	512	/* IRQ is not valid for probing */
-#define IRQ_NOREQUEST	1024	/* IRQ cannot be requested */
-#define IRQ_NOAUTOEN	2048	/* IRQ will not be enabled on request irq */
-#define IRQ_DELAYED_DISABLE \
-			4096	/* IRQ disable (masking) happens delayed. */
-
-/*
- * IRQ types, see also include/linux/interrupt.h
- */
-#define IRQ_TYPE_NONE		0x0000		/* Default, unspecified type */
-#define IRQ_TYPE_EDGE_RISING	0x0001		/* Edge rising type */
-#define IRQ_TYPE_EDGE_FALLING	0x0002		/* Edge falling type */
-#define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
-#define IRQ_TYPE_LEVEL_HIGH	0x0004		/* Level high type */
-#define IRQ_TYPE_LEVEL_LOW	0x0008		/* Level low type */
-#define IRQ_TYPE_SENSE_MASK	0x000f		/* Mask of the above */
-#define IRQ_TYPE_SIMPLE		0x0010		/* Simple type */
-#define IRQ_TYPE_PERCPU		0x0020		/* Per CPU type */
-#define IRQ_TYPE_PROBE		0x0040		/* Probing in progress */
+#define IRQ_NOPROBE		0x02000000	/* IRQ is not valid for probing */
+#define IRQ_NOREQUEST		0x04000000	/* IRQ cannot be requested */
+#define IRQ_NOAUTOEN		0x08000000	/* IRQ will not be enabled on request irq */
+#define IRQ_DELAYED_DISABLE	0x10000000	/* IRQ disable (masking) happens delayed. */
 
 struct proc_dir_entry;
 

--

