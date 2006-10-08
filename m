Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWJHNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWJHNtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWJHNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:49:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31140 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751157AbWJHNtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:49:52 -0400
Date: Sun, 8 Oct 2006 14:49:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 pt_regs fixes
Message-ID: <20061008134948.GR29920@ftp.linux.org.uk>
References: <20061008133129.GK29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008133129.GK29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grr...   Forgotten git-add ;-/  Fixed variant follows:

>From 0bff922ae22bed819077793c4084faf219de89aa Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 8 Oct 2006 08:23:28 -0400
Subject: [PATCH] sparc64 pt_regs fixes

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc64/kernel/ebus.c       |    2 +-
 arch/sparc64/kernel/irq.c        |    5 ++++-
 arch/sparc64/kernel/pci_psycho.c |    6 +++---
 arch/sparc64/kernel/pci_sabre.c  |    6 +++---
 arch/sparc64/kernel/pci_schizo.c |    8 ++++----
 arch/sparc64/kernel/power.c      |    2 +-
 arch/sparc64/kernel/sbus.c       |    6 +++---
 arch/sparc64/kernel/smp.c        |    6 +++++-
 include/asm-sparc64/floppy.h     |    8 ++++----
 include/asm-sparc64/irq_regs.h   |    1 +
 10 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
index 8a9b470..2df25c2 100644
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -79,7 +79,7 @@ static void __ebus_dma_reset(struct ebus
 	}
 }
 
-static irqreturn_t ebus_dma_irq(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t ebus_dma_irq(int irq, void *dev_id)
 {
 	struct ebus_dma_info *p = dev_id;
 	unsigned long flags;
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 4e64724..ce05deb 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -547,9 +547,11 @@ #endif
 void handler_irq(int irq, struct pt_regs *regs)
 {
 	struct ino_bucket *bucket;
+	struct pt_regs *old_regs;
 
 	clear_softint(1 << irq);
 
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 
 	/* Sliiiick... */
@@ -558,12 +560,13 @@ void handler_irq(int irq, struct pt_regs
 		struct ino_bucket *next = __bucket(bucket->irq_chain);
 
 		bucket->irq_chain = 0;
-		__do_IRQ(bucket->virt_irq, regs);
+		__do_IRQ(bucket->virt_irq);
 
 		bucket = next;
 	}
 
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 struct sun5_timer {
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 1ec0aab..fda5db2 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -533,7 +533,7 @@ #define  PSYCHO_UEAFSR_BLK	0x00000000008
 #define  PSYCHO_UEAFSR_RESV2	0x00000000007fffffUL /* Reserved                     */
 #define PSYCHO_UE_AFAR	0x0038UL
 
-static irqreturn_t psycho_ue_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t psycho_ue_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_A.controller_regs + PSYCHO_UE_AFSR;
@@ -610,7 +610,7 @@ #define  PSYCHO_CEAFSR_BLK	0x00000000008
 #define  PSYCHO_CEAFSR_RESV2	0x00000000007fffffUL /* Reserved                     */
 #define PSYCHO_CE_AFAR	0x0040UL
 
-static irqreturn_t psycho_ce_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t psycho_ce_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_A.controller_regs + PSYCHO_CE_AFSR;
@@ -735,7 +735,7 @@ static irqreturn_t psycho_pcierr_intr_ot
 	return ret;
 }
 
-static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
 	struct pci_controller_info *p = pbm->parent;
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 4589185..6ec5698 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -574,7 +574,7 @@ static void sabre_check_iommu_error(stru
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static irqreturn_t sabre_ue_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sabre_ue_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_A.controller_regs + SABRE_UE_AFSR;
@@ -634,7 +634,7 @@ static irqreturn_t sabre_ue_intr(int irq
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t sabre_ce_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sabre_ce_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_A.controller_regs + SABRE_CE_AFSR;
@@ -726,7 +726,7 @@ static irqreturn_t sabre_pcierr_intr_oth
 	return ret;
 }
 
-static irqreturn_t sabre_pcierr_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sabre_pcierr_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg, afar_reg;
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 75ade83..66911b1 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -515,7 +515,7 @@ #define SCHIZO_UEAFSR_MTAGSYND	0x0000000
 #define SCHIZO_UEAFSR_MTAG	0x000000000000e000UL /* Safari */
 #define SCHIZO_UEAFSR_ECCSYND	0x00000000000001ffUL /* Safari */
 
-static irqreturn_t schizo_ue_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_B.controller_regs + SCHIZO_UE_AFSR;
@@ -603,7 +603,7 @@ #define SCHIZO_CEAFSR_MTAGSYND	0x0000000
 #define SCHIZO_CEAFSR_MTAG	0x000000000000e000UL
 #define SCHIZO_CEAFSR_ECCSYND	0x00000000000001ffUL
 
-static irqreturn_t schizo_ce_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t schizo_ce_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	unsigned long afsr_reg = p->pbm_B.controller_regs + SCHIZO_CE_AFSR;
@@ -778,7 +778,7 @@ static irqreturn_t schizo_pcierr_intr_ot
 	return ret;
 }
 
-static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
 	struct pci_controller_info *p = pbm->parent;
@@ -933,7 +933,7 @@ #define BUS_ERROR_ILL		0x000000000000000
 /* We only expect UNMAP errors here.  The rest of the Safari errors
  * are marked fatal and thus cause a system reset.
  */
-static irqreturn_t schizo_safarierr_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t schizo_safarierr_intr(int irq, void *dev_id)
 {
 	struct pci_controller_info *p = dev_id;
 	u64 errlog;
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 0b9c706..699b24b 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -35,7 +35,7 @@ static void __iomem *power_reg;
 static DECLARE_WAIT_QUEUE_HEAD(powerd_wait);
 static int button_pressed;
 
-static irqreturn_t power_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t power_handler(int irq, void *dev_id)
 {
 	if (button_pressed == 0) {
 		button_pressed = 1;
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index c49a577..01d6d86 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -839,7 +839,7 @@ #define  SYSIO_UEAFSR_DOFF  0x0000e00000
 #define  SYSIO_UEAFSR_SIZE  0x00001c0000000000UL /* Bad transfer size 2^SIZE  */
 #define  SYSIO_UEAFSR_MID   0x000003e000000000UL /* UPA MID causing the fault */
 #define  SYSIO_UEAFSR_RESV2 0x0000001fffffffffUL /* Reserved                  */
-static irqreturn_t sysio_ue_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
 	struct sbus_iommu *iommu = sbus->iommu;
@@ -911,7 +911,7 @@ #define  SYSIO_CEAFSR_DOFF  0x0000e00000
 #define  SYSIO_CEAFSR_SIZE  0x00001c0000000000UL /* Bad transfer size 2^SIZE  */
 #define  SYSIO_CEAFSR_MID   0x000003e000000000UL /* UPA MID causing the fault */
 #define  SYSIO_CEAFSR_RESV2 0x0000001fffffffffUL /* Reserved                  */
-static irqreturn_t sysio_ce_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
 	struct sbus_iommu *iommu = sbus->iommu;
@@ -988,7 +988,7 @@ #define  SYSIO_SBAFSR_RESV2 0x0000600000
 #define  SYSIO_SBAFSR_SIZE  0x00001c0000000000UL /* Size of transfer          */
 #define  SYSIO_SBAFSR_MID   0x000003e000000000UL /* MID causing the error     */
 #define  SYSIO_SBAFSR_RESV3 0x0000001fffffffffUL /* Reserved                  */
-static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
 	struct sbus_iommu *iommu = sbus->iommu;
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index f62bf3a..cc09d82 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -31,6 +31,7 @@ #include <asm/mmu_context.h>
 #include <asm/cpudata.h>
 
 #include <asm/irq.h>
+#include <asm/irq_regs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
@@ -1187,6 +1188,7 @@ void smp_percpu_timer_interrupt(struct p
 	unsigned long compare, tick, pstate;
 	int cpu = smp_processor_id();
 	int user = user_mode(regs);
+	struct pt_regs *old_regs;
 
 	/*
 	 * Check for level 14 softint.
@@ -1203,8 +1205,9 @@ void smp_percpu_timer_interrupt(struct p
 		clear_softint(tick_mask);
 	}
 
+	old_regs = set_irq_regs(regs);
 	do {
-		profile_tick(CPU_PROFILING, regs);
+		profile_tick(CPU_PROFILING);
 		if (!--prof_counter(cpu)) {
 			irq_enter();
 
@@ -1236,6 +1239,7 @@ void smp_percpu_timer_interrupt(struct p
 				     : /* no outputs */
 				     : "r" (pstate));
 	} while (time_after_eq(tick, compare));
+	set_irq_regs(old_regs);
 }
 
 static void __init smp_setup_percpu_timer(void)
diff --git a/include/asm-sparc64/floppy.h b/include/asm-sparc64/floppy.h
index abf1500..dbe033e 100644
--- a/include/asm-sparc64/floppy.h
+++ b/include/asm-sparc64/floppy.h
@@ -208,7 +208,7 @@ static void sun_fd_enable_dma(void)
 	pdma_areasize = pdma_size;
 }
 
-irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie, struct pt_regs *regs)
+irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
 {
 	if (likely(doing_pdma)) {
 		void __iomem *stat = (void __iomem *) fdc_status;
@@ -255,7 +255,7 @@ irqreturn_t sparc_floppy_irq(int irq, vo
 	}
 
 main_interrupt:
-	return floppy_interrupt(irq, dev_cookie, regs);
+	return floppy_interrupt(irq, dev_cookie);
 }
 
 static int sun_fd_request_irq(void)
@@ -311,7 +311,7 @@ struct sun_pci_dma_op {
 static struct sun_pci_dma_op sun_pci_dma_current = { -1U, 0, 0, NULL};
 static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
 
-extern irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern irqreturn_t floppy_interrupt(int irq, void *dev_id);
 
 static unsigned char sun_pci_fd_inb(unsigned long port)
 {
@@ -446,7 +446,7 @@ static int sun_pci_fd_eject(int drive)
 
 void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
 {
-	floppy_interrupt(0, NULL, NULL);
+	floppy_interrupt(0, NULL);
 }
 
 /*
diff --git a/include/asm-sparc64/irq_regs.h b/include/asm-sparc64/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-sparc64/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
-- 
1.4.2.GIT

