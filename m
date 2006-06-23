Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWFWSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWFWSmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWFWSmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:46 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19663 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751925AbWFWSmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:04 -0400
Message-Id: <20060623183912.940014000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:07 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] cleanup amiga irq numbering
Content-Disposition: inline; filename=0017-M68K-cleanup-amiga-irq-numbering.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix amiga irq numbering, so they are after the generic IRQ_AUTO defines
and remove the IRQ_AMIGA_AUTO defines.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/amiga/amiints.c    |   74 +++++++++++++++++-----------------
 arch/m68k/amiga/cia.c        |   11 ++---
 include/asm-m68k/amigaints.h |   92 +++++++++++++++++-------------------------
 3 files changed, 80 insertions(+), 97 deletions(-)

560b34e085caab7e18e396c180d6a13e59b6f472
diff --git a/arch/m68k/amiga/amiints.c b/arch/m68k/amiga/amiints.c
index b0aa61b..d02458e 100644
--- a/arch/m68k/amiga/amiints.c
+++ b/arch/m68k/amiga/amiints.c
@@ -61,25 +61,25 @@ extern int cia_get_irq_list(struct ciaba
 static irq_node_t *ami_irq_list[AMI_STD_IRQS];
 
 static unsigned short amiga_intena_vals[AMI_STD_IRQS] = {
-	[IRQ_AMIGA_VERTB]	= IF_VERTB,
-	[IRQ_AMIGA_COPPER]	= IF_COPER,
-	[IRQ_AMIGA_AUD0]	= IF_AUD0,
-	[IRQ_AMIGA_AUD1]	= IF_AUD1,
-	[IRQ_AMIGA_AUD2]	= IF_AUD2,
-	[IRQ_AMIGA_AUD3]	= IF_AUD3,
-	[IRQ_AMIGA_BLIT]	= IF_BLIT,
-	[IRQ_AMIGA_DSKSYN]	= IF_DSKSYN,
-	[IRQ_AMIGA_DSKBLK]	= IF_DSKBLK,
-	[IRQ_AMIGA_RBF]		= IF_RBF,
-	[IRQ_AMIGA_TBE]		= IF_TBE,
-	[IRQ_AMIGA_SOFT]	= IF_SOFT,
-	[IRQ_AMIGA_PORTS]	= IF_PORTS,
-	[IRQ_AMIGA_EXTER]	= IF_EXTER
+	[IRQ_AMIGA_VERTB-IRQ_USER]	= IF_VERTB,
+	[IRQ_AMIGA_COPPER-IRQ_USER]	= IF_COPER,
+	[IRQ_AMIGA_AUD0-IRQ_USER]	= IF_AUD0,
+	[IRQ_AMIGA_AUD1-IRQ_USER]	= IF_AUD1,
+	[IRQ_AMIGA_AUD2-IRQ_USER]	= IF_AUD2,
+	[IRQ_AMIGA_AUD3-IRQ_USER]	= IF_AUD3,
+	[IRQ_AMIGA_BLIT-IRQ_USER]	= IF_BLIT,
+	[IRQ_AMIGA_DSKSYN-IRQ_USER]	= IF_DSKSYN,
+	[IRQ_AMIGA_DSKBLK-IRQ_USER]	= IF_DSKBLK,
+	[IRQ_AMIGA_RBF-IRQ_USER]	= IF_RBF,
+	[IRQ_AMIGA_TBE-IRQ_USER]	= IF_TBE,
+	[IRQ_AMIGA_SOFT-IRQ_USER]	= IF_SOFT,
+	[IRQ_AMIGA_PORTS-IRQ_USER]	= IF_PORTS,
+	[IRQ_AMIGA_EXTER-IRQ_USER]	= IF_EXTER
 };
 static const unsigned char ami_servers[AMI_STD_IRQS] = {
-	[IRQ_AMIGA_VERTB]	= 1,
-	[IRQ_AMIGA_PORTS]	= 1,
-	[IRQ_AMIGA_EXTER]	= 1
+	[IRQ_AMIGA_VERTB-IRQ_USER]	= 1,
+	[IRQ_AMIGA_PORTS-IRQ_USER]	= 1,
+	[IRQ_AMIGA_EXTER-IRQ_USER]	= 1
 };
 
 static short ami_ablecount[AMI_IRQS];
@@ -210,9 +210,8 @@ int amiga_request_irq(unsigned int irq,
 		return -ENXIO;
 	}
 
-	if (irq >= IRQ_AMIGA_AUTO)
-		return cpu_request_irq(irq - IRQ_AMIGA_AUTO, handler,
-		                       flags, devname, dev_id);
+	if (irq < IRQ_USER)
+		return cpu_request_irq(irq, handler, flags, devname, dev_id);
 
 	if (irq >= IRQ_AMIGA_CIAB)
 		return cia_request_irq(&ciab_base, irq - IRQ_AMIGA_CIAB,
@@ -222,6 +221,7 @@ int amiga_request_irq(unsigned int irq,
 		return cia_request_irq(&ciaa_base, irq - IRQ_AMIGA_CIAA,
 		                       handler, flags, devname, dev_id);
 
+	irq -= IRQ_USER;
 	/*
 	 * IRQ_AMIGA_PORTS & IRQ_AMIGA_EXTER defaults to shared,
 	 * we could add a check here for the SA_SHIRQ flag but all drivers
@@ -257,8 +257,8 @@ void amiga_free_irq(unsigned int irq, vo
 		return;
 	}
 
-	if (irq >= IRQ_AMIGA_AUTO)
-		cpu_free_irq(irq - IRQ_AMIGA_AUTO, dev_id);
+	if (irq < IRQ_USER)
+		cpu_free_irq(irq, dev_id);
 
 	if (irq >= IRQ_AMIGA_CIAB) {
 		cia_free_irq(&ciab_base, irq - IRQ_AMIGA_CIAB, dev_id);
@@ -270,6 +270,7 @@ void amiga_free_irq(unsigned int irq, vo
 		return;
 	}
 
+	irq -= IRQ_USER;
 	if (ami_servers[irq]) {
 		amiga_delete_irq(&ami_irq_list[irq], dev_id);
 		/* if server list empty, disable the interrupt */
@@ -306,9 +307,9 @@ void amiga_enable_irq(unsigned int irq)
 		return;
 
 	/* No action for auto-vector interrupts */
-	if (irq >= IRQ_AMIGA_AUTO){
+	if (irq < IRQ_USER) {
 		printk("%s: Trying to enable auto-vector IRQ %i\n",
-		       __FUNCTION__, irq - IRQ_AMIGA_AUTO);
+		       __FUNCTION__, irq);
 		return;
 	}
 
@@ -327,7 +328,7 @@ void amiga_enable_irq(unsigned int irq)
 	}
 
 	/* enable the interrupt */
-	amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq];
+	amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq-IRQ_USER];
 }
 
 void amiga_disable_irq(unsigned int irq)
@@ -341,9 +342,9 @@ void amiga_disable_irq(unsigned int irq)
 		return;
 
 	/* No action for auto-vector interrupts */
-	if (irq >= IRQ_AMIGA_AUTO) {
+	if (irq < IRQ_USER) {
 		printk("%s: Trying to disable auto-vector IRQ %i\n",
-		       __FUNCTION__, irq - IRQ_AMIGA_AUTO);
+		       __FUNCTION__, irq);
 		return;
 	}
 
@@ -358,24 +359,24 @@ void amiga_disable_irq(unsigned int irq)
 	}
 
 	/* disable the interrupt */
-	amiga_custom.intena = amiga_intena_vals[irq];
+	amiga_custom.intena = amiga_intena_vals[irq-IRQ_USER];
 }
 
 inline void amiga_do_irq(int irq, struct pt_regs *fp)
 {
-	kstat_cpu(0).irqs[SYS_IRQS + irq]++;
-	ami_irq_list[irq]->handler(irq, ami_irq_list[irq]->dev_id, fp);
+	kstat_cpu(0).irqs[irq]++;
+	ami_irq_list[irq-IRQ_USER]->handler(irq, ami_irq_list[irq-IRQ_USER]->dev_id, fp);
 }
 
 void amiga_do_irq_list(int irq, struct pt_regs *fp)
 {
 	irq_node_t *node;
 
-	kstat_cpu(0).irqs[SYS_IRQS + irq]++;
+	kstat_cpu(0).irqs[irq]++;
 
-	amiga_custom.intreq = amiga_intena_vals[irq];
+	amiga_custom.intreq = amiga_intena_vals[irq-IRQ_USER];
 
-	for (node = ami_irq_list[irq]; node; node = node->next)
+	for (node = ami_irq_list[irq-IRQ_USER]; node; node = node->next)
 		node->handler(irq, node->dev_id, fp);
 }
 
@@ -498,11 +499,12 @@ int show_amiga_interrupts(struct seq_fil
 	int i;
 	irq_node_t *node;
 
-	for (i = 0; i < AMI_STD_IRQS; i++) {
-		if (!(node = ami_irq_list[i]))
+	for (i = IRQ_USER; i < IRQ_AMIGA_CIAA; i++) {
+		node = ami_irq_list[i - IRQ_USER];
+		if (!node)
 			continue;
 		seq_printf(p, "ami  %2d: %10u ", i,
-		               kstat_cpu(0).irqs[SYS_IRQS + i]);
+		               kstat_cpu(0).irqs[i]);
 		do {
 			if (node->flags & SA_INTERRUPT)
 				seq_puts(p, "F ");
diff --git a/arch/m68k/amiga/cia.c b/arch/m68k/amiga/cia.c
index 9476eb9..4a003d8 100644
--- a/arch/m68k/amiga/cia.c
+++ b/arch/m68k/amiga/cia.c
@@ -33,14 +33,14 @@ struct ciabase {
 } ciaa_base = {
 	.cia		= &ciaa,
 	.int_mask	= IF_PORTS,
-	.handler_irq	= IRQ_AMIGA_AUTO_2,
+	.handler_irq	= IRQ_AUTO_2,
 	.cia_irq	= IRQ_AMIGA_CIAA,
 	.server_irq	= IRQ_AMIGA_PORTS,
 	.name		= "CIAA handler"
 }, ciab_base = {
 	.cia		= &ciab,
 	.int_mask	= IF_EXTER,
-	.handler_irq	= IRQ_AMIGA_AUTO_6,
+	.handler_irq	= IRQ_AUTO_6,
 	.cia_irq	= IRQ_AMIGA_CIAB,
 	.server_irq	= IRQ_AMIGA_EXTER,
 	.name		= "CIAB handler"
@@ -131,12 +131,11 @@ static irqreturn_t cia_handler(int irq, 
 	unsigned char ints;
 
 	mach_irq = base->cia_irq;
-	irq = SYS_IRQS + mach_irq;
 	ints = cia_set_irq(base, CIA_ICR_ALL);
 	amiga_custom.intreq = base->int_mask;
-	for (i = 0; i < CIA_IRQS; i++, irq++, mach_irq++) {
+	for (i = 0; i < CIA_IRQS; i++, mach_irq++) {
 		if (ints & 1) {
-			kstat_cpu(0).irqs[irq]++;
+			kstat_cpu(0).irqs[mach_irq]++;
 			base->irq_list[i].handler(mach_irq, base->irq_list[i].dev_id, fp);
 		}
 		ints >>= 1;
@@ -172,7 +171,7 @@ int cia_get_irq_list(struct ciabase *bas
 	j = base->cia_irq;
 	for (i = 0; i < CIA_IRQS; i++) {
 		seq_printf(p, "cia  %2d: %10d ", j + i,
-			       kstat_cpu(0).irqs[SYS_IRQS + j + i]);
+			       kstat_cpu(0).irqs[j + i]);
 		seq_puts(p, "  ");
 		seq_printf(p, "%s\n", base->irq_list[i].devname);
 	}
diff --git a/include/asm-m68k/amigaints.h b/include/asm-m68k/amigaints.h
index aa968d0..576f5d1 100644
--- a/include/asm-m68k/amigaints.h
+++ b/include/asm-m68k/amigaints.h
@@ -13,6 +13,8 @@
 #ifndef _ASMm68k_AMIGAINTS_H_
 #define _ASMm68k_AMIGAINTS_H_
 
+#include <asm/irq.h>
+
 /*
 ** Amiga Interrupt sources.
 **
@@ -23,72 +25,52 @@ #define AMI_STD_IRQS        (14)
 #define CIA_IRQS            (5)
 #define AMI_IRQS            (32) /* AUTO_IRQS+AMI_STD_IRQS+2*CIA_IRQS */
 
-/* vertical blanking interrupt */
-#define IRQ_AMIGA_VERTB     0
+/* builtin serial port interrupts */
+#define IRQ_AMIGA_TBE		(IRQ_USER+0)
+#define IRQ_AMIGA_RBF		(IRQ_USER+11)
 
-/* copper interrupt */
-#define IRQ_AMIGA_COPPER    1
+/* floppy disk interrupts */
+#define IRQ_AMIGA_DSKBLK	(IRQ_USER+1)
+#define IRQ_AMIGA_DSKSYN	(IRQ_USER+12)
 
-/* Audio interrupts */
-#define IRQ_AMIGA_AUD0	    2
-#define IRQ_AMIGA_AUD1	    3
-#define IRQ_AMIGA_AUD2	    4
-#define IRQ_AMIGA_AUD3	    5
+/* software interrupts */
+#define IRQ_AMIGA_SOFT		(IRQ_USER+2)
 
-/* Blitter done interrupt */
-#define IRQ_AMIGA_BLIT	    6
+/* interrupts from external hardware */
+#define IRQ_AMIGA_PORTS		(IRQ_USER+3)
+#define IRQ_AMIGA_EXTER		(IRQ_USER+13)
 
-/* floppy disk interrupts */
-#define IRQ_AMIGA_DSKSYN    7
-#define IRQ_AMIGA_DSKBLK    8
+/* copper interrupt */
+#define IRQ_AMIGA_COPPER	(IRQ_USER+4)
 
-/* builtin serial port interrupts */
-#define IRQ_AMIGA_RBF	    9
-#define IRQ_AMIGA_TBE	    10
+/* vertical blanking interrupt */
+#define IRQ_AMIGA_VERTB		(IRQ_USER+5)
 
-/* software interrupts */
-#define IRQ_AMIGA_SOFT      11
+/* Blitter done interrupt */
+#define IRQ_AMIGA_BLIT		(IRQ_USER+6)
 
-/* interrupts from external hardware */
-#define IRQ_AMIGA_PORTS	    12
-#define IRQ_AMIGA_EXTER	    13
+/* Audio interrupts */
+#define IRQ_AMIGA_AUD0		(IRQ_USER+7)
+#define IRQ_AMIGA_AUD1		(IRQ_USER+8)
+#define IRQ_AMIGA_AUD2		(IRQ_USER+9)
+#define IRQ_AMIGA_AUD3		(IRQ_USER+10)
 
 /* CIA interrupt sources */
-#define IRQ_AMIGA_CIAA      14
-#define IRQ_AMIGA_CIAA_TA   14
-#define IRQ_AMIGA_CIAA_TB   15
-#define IRQ_AMIGA_CIAA_ALRM 16
-#define IRQ_AMIGA_CIAA_SP   17
-#define IRQ_AMIGA_CIAA_FLG  18
-#define IRQ_AMIGA_CIAB      19
-#define IRQ_AMIGA_CIAB_TA   19
-#define IRQ_AMIGA_CIAB_TB   20
-#define IRQ_AMIGA_CIAB_ALRM 21
-#define IRQ_AMIGA_CIAB_SP   22
-#define IRQ_AMIGA_CIAB_FLG  23
-
-/* auto-vector interrupts */
-#define IRQ_AMIGA_AUTO      24
-#define IRQ_AMIGA_AUTO_0    24 /* This is just a dummy */
-#define IRQ_AMIGA_AUTO_1    25
-#define IRQ_AMIGA_AUTO_2    26
-#define IRQ_AMIGA_AUTO_3    27
-#define IRQ_AMIGA_AUTO_4    28
-#define IRQ_AMIGA_AUTO_5    29
-#define IRQ_AMIGA_AUTO_6    30
-#define IRQ_AMIGA_AUTO_7    31
-
-#define IRQ_FLOPPY	    IRQ_AMIGA_DSKBLK
+#define IRQ_AMIGA_CIAA		(IRQ_USER+14)
+#define IRQ_AMIGA_CIAA_TA	(IRQ_USER+14)
+#define IRQ_AMIGA_CIAA_TB	(IRQ_USER+15)
+#define IRQ_AMIGA_CIAA_ALRM	(IRQ_USER+16)
+#define IRQ_AMIGA_CIAA_SP	(IRQ_USER+17)
+#define IRQ_AMIGA_CIAA_FLG	(IRQ_USER+18)
+#define IRQ_AMIGA_CIAB		(IRQ_USER+19)
+#define IRQ_AMIGA_CIAB_TA	(IRQ_USER+19)
+#define IRQ_AMIGA_CIAB_TB	(IRQ_USER+20)
+#define IRQ_AMIGA_CIAB_ALRM	(IRQ_USER+21)
+#define IRQ_AMIGA_CIAB_SP	(IRQ_USER+22)
+#define IRQ_AMIGA_CIAB_FLG	(IRQ_USER+23)
 
-/* INTREQR masks */
-#define IRQ1_MASK   0x0007	/* INTREQR mask for IRQ 1 */
-#define IRQ2_MASK   0x0008	/* INTREQR mask for IRQ 2 */
-#define IRQ3_MASK   0x0070	/* INTREQR mask for IRQ 3 */
-#define IRQ4_MASK   0x0780	/* INTREQR mask for IRQ 4 */
-#define IRQ5_MASK   0x1800	/* INTREQR mask for IRQ 5 */
-#define IRQ6_MASK   0x2000	/* INTREQR mask for IRQ 6 */
-#define IRQ7_MASK   0x4000	/* INTREQR mask for IRQ 7 */
 
+/* INTREQR masks */
 #define IF_SETCLR   0x8000      /* set/clr bit */
 #define IF_INTEN    0x4000	/* master interrupt bit in INT* registers */
 #define IF_EXTER    0x2000	/* external level 6 and CIA B interrupt */
-- 
1.3.3

--

