Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWJFVQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWJFVQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWJFVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:16:13 -0400
Received: from natblert.rzone.de ([81.169.145.181]:56469 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S932422AbWJFVQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:16:12 -0400
Date: Fri, 6 Oct 2006 23:06:48 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] ppc: PReP fixup after irq changes
Message-ID: <20061006210648.GA8428@aepfle.de>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org> <20061006203434.GA7932@aepfle.de> <20061006205216.GA8272@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061006205216.GA8272@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compile fixes for PReP

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---

xmon still needs some attention

 arch/ppc/syslib/open_pic.c |   14 +++++++-------
 include/asm-ppc/open_pic.h |    6 +++---
 include/asm-ppc/smp.h      |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6/include/asm-ppc/open_pic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/open_pic.h
+++ linux-2.6/include/asm-ppc/open_pic.h
@@ -48,12 +48,12 @@ extern void openpic_init(int linux_irq_o
 extern void openpic_init_nmi_irq(u_int irq);
 extern void openpic_set_irq_priority(u_int irq, u_int pri);
 extern void openpic_hookup_cascade(u_int irq, char *name,
-				   int (*cascade_fn)(struct pt_regs *));
+				   int (*cascade_fn)(void));
 extern u_int openpic_irq(void);
 extern void openpic_eoi(void);
 extern void openpic_request_IPIs(void);
 extern void do_openpic_setup_cpu(void);
-extern int openpic_get_irq(struct pt_regs *regs);
+extern int openpic_get_irq(void);
 extern void openpic_reset_processor_phys(u_int cpumask);
 extern void openpic_setup_ISU(int isu_num, unsigned long addr);
 extern void openpic_cause_IPI(u_int ipi, cpumask_t cpumask);
@@ -93,6 +93,6 @@ extern void openpic2_init(int linux_irq_
 extern void openpic2_init_nmi_irq(u_int irq);
 extern u_int openpic2_irq(void);
 extern void openpic2_eoi(void);
-extern int openpic2_get_irq(struct pt_regs *regs);
+extern int openpic2_get_irq(void);
 extern void openpic2_setup_ISU(int isu_num, unsigned long addr);
 #endif /* _PPC_KERNEL_OPEN_PIC_H */
Index: linux-2.6/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-2.6.orig/arch/ppc/syslib/open_pic.c
+++ linux-2.6/arch/ppc/syslib/open_pic.c
@@ -45,7 +45,7 @@ static u_int NumSources;
 static int open_pic_irq_offset;
 static volatile OpenPIC_Source __iomem *ISR[NR_IRQS];
 static int openpic_cascade_irq = -1;
-static int (*openpic_cascade_fn)(struct pt_regs *);
+static int (*openpic_cascade_fn)(void);
 
 /* Global Operations */
 static void openpic_disable_8259_pass_through(void);
@@ -54,7 +54,7 @@ static void openpic_set_spurious(u_int v
 #ifdef CONFIG_SMP
 /* Interprocessor Interrupts */
 static void openpic_initipi(u_int ipi, u_int pri, u_int vector);
-static irqreturn_t openpic_ipi_action(int cpl, void *dev_id, struct pt_regs *);
+static irqreturn_t openpic_ipi_action(int cpl, void *dev_id);
 #endif
 
 /* Timer Interrupts */
@@ -700,7 +700,7 @@ static struct irqaction openpic_cascade_
 
 void __init
 openpic_hookup_cascade(u_int irq, char *name,
-	int (*cascade_fn)(struct pt_regs *))
+	int (*cascade_fn)(void))
 {
 	openpic_cascade_irq = irq;
 	openpic_cascade_fn = cascade_fn;
@@ -857,16 +857,16 @@ static void openpic_end_ipi(unsigned int
 {
 }
 
-static irqreturn_t openpic_ipi_action(int cpl, void *dev_id, struct pt_regs *regs)
+static irqreturn_t openpic_ipi_action(int cpl, void *dev_id)
 {
-	smp_message_recv(cpl-OPENPIC_VEC_IPI-open_pic_irq_offset, regs);
+	smp_message_recv(cpl-OPENPIC_VEC_IPI-open_pic_irq_offset);
 	return IRQ_HANDLED;
 }
 
 #endif /* CONFIG_SMP */
 
 int
-openpic_get_irq(struct pt_regs *regs)
+openpic_get_irq(void)
 {
 	int irq = openpic_irq();
 
@@ -876,7 +876,7 @@ openpic_get_irq(struct pt_regs *regs)
 	 * This should move to irq.c eventually.  -- paulus
 	 */
 	if (irq == openpic_cascade_irq && openpic_cascade_fn != NULL) {
-		int cirq = openpic_cascade_fn(regs);
+		int cirq = openpic_cascade_fn();
 
 		/* Allow for the cascade being shared with other devices */
 		if (cirq != -1) {
Index: linux-2.6/include/asm-ppc/smp.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/smp.h
+++ linux-2.6/include/asm-ppc/smp.h
@@ -39,7 +39,7 @@ extern struct smp_ops_t *smp_ops;
 extern void smp_send_tlb_invalidate(int);
 extern void smp_send_xmon_break(int cpu);
 struct pt_regs;
-extern void smp_message_recv(int, struct pt_regs *);
+extern void smp_message_recv(int);
 
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
