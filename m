Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWIHPdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWIHPdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWIHPdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:33:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750833AbWIHPdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:33:12 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] FRV: Improve FRV's use of generic IRQ handling
Date: Fri, 08 Sep 2006 16:32:36 +0100
To: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Improve FRV's use of generic IRQ handling:

 (*) Use generic_handle_irq() rather than __do_IRQ() as the latter is obsolete.

 (*) Don't implement enable() and disable() ops as these will fall back to
     using unmask() and mask().

 (*) Provide mask_ack() functions to avoid a call each to mask() and ack().

 (*) Make the cascade handlers always return IRQ_HANDLED.

 (*) Implement the mask() and unmask() functions in the same order as they're
     listed in the ops table.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/irq-mb93091.c |   36 +++++++++++++++++++-----------------
 arch/frv/kernel/irq-mb93093.c |   36 +++++++++++++++++++-----------------
 arch/frv/kernel/irq-mb93493.c |   35 ++++++++++++++---------------------
 arch/frv/kernel/irq.c         |   15 +--------------
 4 files changed, 53 insertions(+), 69 deletions(-)

diff --git a/arch/frv/kernel/irq-mb93091.c b/arch/frv/kernel/irq-mb93091.c
index 635d234..369bc0a 100644
--- a/arch/frv/kernel/irq-mb93091.c
+++ b/arch/frv/kernel/irq-mb93091.c
@@ -36,41 +36,45 @@ #define __clr_IFR(M)	do { __reg16(0xffc0
 /*
  * on-motherboard FPGA PIC operations
  */
-static void frv_fpga_enable(unsigned int irq)
+static void frv_fpga_mask(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
-	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
+	imr |= 1 << (irq - IRQ_BASE_FPGA);
 
 	__set_IMR(imr);
 }
 
-static void frv_fpga_disable(unsigned int irq)
+static void frv_fpga_ack(unsigned int irq)
+{
+	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
+}
+
+static void frv_fpga_mask_ack(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
 	imr |= 1 << (irq - IRQ_BASE_FPGA);
-
 	__set_IMR(imr);
-}
 
-static void frv_fpga_ack(unsigned int irq)
-{
 	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
 }
 
-static void frv_fpga_end(unsigned int irq)
+static void frv_fpga_unmask(unsigned int irq)
 {
+	uint16_t imr = __get_IMR();
+
+	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
+
+	__set_IMR(imr);
 }
 
 static struct irq_chip frv_fpga_pic = {
 	.name		= "mb93091",
-	.enable		= frv_fpga_enable,
-	.disable	= frv_fpga_disable,
 	.ack		= frv_fpga_ack,
-	.mask		= frv_fpga_disable,
-	.unmask		= frv_fpga_enable,
-	.end		= frv_fpga_end,
+	.mask		= frv_fpga_mask,
+	.mask_ack	= frv_fpga_mask_ack,
+	.unmask		= frv_fpga_unmask,
 };
 
 /*
@@ -79,7 +83,6 @@ static struct irq_chip frv_fpga_pic = {
 static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
 {
 	uint16_t imr, mask = (unsigned long) _mask;
-	irqreturn_t iret = 0;
 
 	imr = __get_IMR();
 	mask = mask & ~imr & __get_IFR();
@@ -92,11 +95,10 @@ static irqreturn_t fpga_interrupt(int ir
 		irq = 31 - irq;
 		mask &= ~(1 << irq);
 
-		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
-			iret |= IRQ_HANDLED;
+		generic_handle_irq(IRQ_BASE_FPGA + irq, regs);
 	}
 
-	return iret;
+	return IRQ_HANDLED;
 }
 
 /*
diff --git a/arch/frv/kernel/irq-mb93093.c b/arch/frv/kernel/irq-mb93093.c
index f60db79..a43a221 100644
--- a/arch/frv/kernel/irq-mb93093.c
+++ b/arch/frv/kernel/irq-mb93093.c
@@ -35,40 +35,44 @@ #define __clr_IFR(M)	do { __reg16(0x02) 
 /*
  * off-CPU FPGA PIC operations
  */
-static void frv_fpga_enable(unsigned int irq)
+static void frv_fpga_mask(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
-	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
-
+	imr |= 1 << (irq - IRQ_BASE_FPGA);
 	__set_IMR(imr);
 }
 
-static void frv_fpga_disable(unsigned int irq)
+static void frv_fpga_ack(unsigned int irq)
+{
+	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
+}
+
+static void frv_fpga_mask_ack(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
 	imr |= 1 << (irq - IRQ_BASE_FPGA);
-
 	__set_IMR(imr);
-}
 
-static void frv_fpga_ack(unsigned int irq)
-{
 	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
 }
 
-static void frv_fpga_end(unsigned int irq)
+static void frv_fpga_unmask(unsigned int irq)
 {
+	uint16_t imr = __get_IMR();
+
+	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
+
+	__set_IMR(imr);
 }
 
 static struct irq_chip frv_fpga_pic = {
 	.name		= "mb93093",
-	.enable		= frv_fpga_enable,
-	.disable	= frv_fpga_disable,
 	.ack		= frv_fpga_ack,
-	.mask		= frv_fpga_disable,
-	.unmask		= frv_fpga_enable,
+	.mask		= frv_fpga_mask,
+	.mask_ack	= frv_fpga_mask_ack,
+	.unmask		= frv_fpga_unmask,
 	.end		= frv_fpga_end,
 };
 
@@ -78,7 +82,6 @@ static struct irq_chip frv_fpga_pic = {
 static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
 {
 	uint16_t imr, mask = (unsigned long) _mask;
-	irqreturn_t iret = 0;
 
 	imr = __get_IMR();
 	mask = mask & ~imr & __get_IFR();
@@ -91,11 +94,10 @@ static irqreturn_t fpga_interrupt(int ir
 		irq = 31 - irq;
 		mask &= ~(1 << irq);
 
-		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
-			iret |= IRQ_HANDLED;
+		generic_irq_handle(IRQ_BASE_FPGA + irq, regs);
 	}
 
-	return iret;
+	return IRQ_HANDLED;
 }
 
 /*
diff --git a/arch/frv/kernel/irq-mb93493.c b/arch/frv/kernel/irq-mb93493.c
index 8ad9abf..39c0188 100644
--- a/arch/frv/kernel/irq-mb93493.c
+++ b/arch/frv/kernel/irq-mb93493.c
@@ -43,8 +43,9 @@ #define IRQ_ROUTING					\
 
 /*
  * daughter board PIC operations
+ * - there is no way to ACK interrupts in the MB93493 chip
  */
-static void frv_mb93493_enable(unsigned int irq)
+static void frv_mb93493_mask(unsigned int irq)
 {
 	uint32_t iqsr;
 	volatile void *piqsr;
@@ -55,11 +56,15 @@ static void frv_mb93493_enable(unsigned 
 		piqsr = __addr_MB93493_IQSR(0);
 
 	iqsr = readl(piqsr);
-	iqsr |= 1 << (irq - IRQ_BASE_MB93493 + 16);
+	iqsr &= ~(1 << (irq - IRQ_BASE_MB93493 + 16));
 	writel(iqsr, piqsr);
 }
 
-static void frv_mb93493_disable(unsigned int irq)
+static void frv_mb93493_ack(unsigned int irq)
+{
+}
+
+static void frv_mb93493_unmask(unsigned int irq)
 {
 	uint32_t iqsr;
 	volatile void *piqsr;
@@ -70,26 +75,16 @@ static void frv_mb93493_disable(unsigned
 		piqsr = __addr_MB93493_IQSR(0);
 
 	iqsr = readl(piqsr);
-	iqsr &= ~(1 << (irq - IRQ_BASE_MB93493 + 16));
+	iqsr |= 1 << (irq - IRQ_BASE_MB93493 + 16);
 	writel(iqsr, piqsr);
 }
 
-static void frv_mb93493_ack(unsigned int irq)
-{
-}
-
-static void frv_mb93493_end(unsigned int irq)
-{
-}
-
 static struct irq_chip frv_mb93493_pic = {
 	.name		= "mb93093",
-	.enable		= frv_mb93493_enable,
-	.disable	= frv_mb93493_disable,
 	.ack		= frv_mb93493_ack,
-	.mask		= frv_mb93493_disable,
-	.unmask		= frv_mb93493_enable,
-	.end		= frv_mb93493_end,
+	.mask		= frv_mb93493_mask,
+	.mask_ack	= frv_mb93493_mask,
+	.unmask		= frv_mb93493_unmask,
 };
 
 /*
@@ -98,7 +93,6 @@ static struct irq_chip frv_mb93493_pic =
 static irqreturn_t mb93493_interrupt(int irq, void *_piqsr, struct pt_regs *regs)
 {
 	volatile void *piqsr = _piqsr;
-	irqreturn_t iret = 0;
 	uint32_t iqsr;
 
 	iqsr = readl(piqsr);
@@ -112,11 +106,10 @@ static irqreturn_t mb93493_interrupt(int
 		irq = 31 - irq;
 		iqsr &= ~(1 << irq);
 
-		if (__do_IRQ(IRQ_BASE_MB93493 + irq, regs))
-			iret |= IRQ_HANDLED;
+		generic_handle_irq(IRQ_BASE_MB93493 + irq, regs);
 	}
 
-	return iret;
+	return IRQ_HANDLED;
 }
 
 /*
diff --git a/arch/frv/kernel/irq.c b/arch/frv/kernel/irq.c
index e1ab9f2..5ac041c 100644
--- a/arch/frv/kernel/irq.c
+++ b/arch/frv/kernel/irq.c
@@ -97,19 +97,8 @@ int show_interrupts(struct seq_file *p, 
 /*
  * on-CPU PIC operations
  */
-static void frv_cpupic_enable(unsigned int irqlevel)
-{
-	__clr_MASK(irqlevel);
-}
-
-static void frv_cpupic_disable(unsigned int irqlevel)
-{
-	__set_MASK(irqlevel);
-}
-
 static void frv_cpupic_ack(unsigned int irqlevel)
 {
-	__set_MASK(irqlevel);
 	__clr_RC(irqlevel);
 	__clr_IRL();
 }
@@ -138,8 +127,6 @@ static void frv_cpupic_end(unsigned int 
 
 static struct irq_chip frv_cpu_pic = {
 	.name		= "cpu",
-	.enable		= frv_cpupic_enable,
-	.disable	= frv_cpupic_disable,
 	.ack		= frv_cpupic_ack,
 	.mask		= frv_cpupic_mask,
 	.mask_ack	= frv_cpupic_mask_ack,
@@ -156,7 +143,7 @@ static struct irq_chip frv_cpu_pic = {
 asmlinkage void do_IRQ(void)
 {
 	irq_enter();
-	__do_IRQ(__get_IRL(), __frame);
+	generic_handle_irq(__get_IRL(), __frame);
 	irq_exit();
 }
 
