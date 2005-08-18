Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVHRRwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVHRRwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVHRRwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:52:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8603 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932353AbVHRRwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:52:07 -0400
Message-Id: <200508181752.j7IHq2Qt001692@d03av02.boulder.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 1/4] ppc64: fix IPI on bpa_iic
Date: Thu, 18 Aug 2005 19:35:21 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200508181931.43481.arnd@arndb.de>
In-Reply-To: <200508181931.43481.arnd@arndb.de>
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a severe bug in the bpa_iic driver that caused
all sorts of problems.

We had been using incorrect priority values for inter processor
interrupts, which resulted in always doing CALL_FUNCTION
instead of RESCHEDULE or DEBUGGER_BREAK.

The symptoms cured by this patch include bad performance on
SMP systems spurious kernel panics in the IPI code.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6.13-rc6.orig/arch/ppc64/kernel/bpa_iic.c
+++ linux-2.6.13-rc6/arch/ppc64/kernel/bpa_iic.c
@@ -205,6 +205,18 @@ static struct iic_regs __iomem *find_iic
 }
 
 #ifdef CONFIG_SMP
+
+/* Use the highest interrupt priorities for IPI */
+static inline int iic_ipi_to_irq(int ipi)
+{
+	return IIC_IPI_OFFSET + IIC_NUM_IPIS - 1 - ipi;
+}
+
+static inline int iic_irq_to_ipi(int irq)
+{
+	return IIC_NUM_IPIS - 1 - (irq - IIC_IPI_OFFSET);
+}
+
 void iic_setup_cpu(void)
 {
 	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
@@ -212,18 +224,20 @@ void iic_setup_cpu(void)
 
 void iic_cause_IPI(int cpu, int mesg)
 {
-	out_be64(&per_cpu(iic, cpu).regs->generate, mesg);
+	out_be64(&per_cpu(iic, cpu).regs->generate, (IIC_NUM_IPIS - 1 - mesg) << 4);
 }
 
 static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
 {
-
-	smp_message_recv(irq - IIC_IPI_OFFSET, regs);
+	smp_message_recv(iic_irq_to_ipi(irq), regs);
 	return IRQ_HANDLED;
 }
 
-static void iic_request_ipi(int irq, const char *name)
+static void iic_request_ipi(int ipi, const char *name)
 {
+	int irq;
+
+	irq = iic_ipi_to_irq(ipi);
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs
 	 * disabled */
 	get_irq_desc(irq)->handler = &iic_pic;
@@ -233,10 +247,10 @@ static void iic_request_ipi(int irq, con
 
 void iic_request_IPIs(void)
 {
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_CALL_FUNCTION, "IPI-call");
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_RESCHEDULE, "IPI-resched");
+	iic_request_ipi(PPC_MSG_CALL_FUNCTION, "IPI-call");
+	iic_request_ipi(PPC_MSG_RESCHEDULE, "IPI-resched");
 #ifdef CONFIG_DEBUGGER
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
+	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
 #endif /* CONFIG_DEBUGGER */
 }
 #endif /* CONFIG_SMP */

