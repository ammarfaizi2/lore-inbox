Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWFWSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWFWSrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWFWSmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21455 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751932AbWFWSmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:08 -0400
Message-Id: <20060623183914.079143000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:10 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] convert amiga irq code
Content-Disposition: inline; filename=0020-M68K-convert-amiga-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/amiga/amiga_ksyms.c |    2 
 arch/m68k/amiga/amiints.c     |  382 ++++-------------------------------------
 arch/m68k/amiga/cia.c         |  155 ++++++++---------
 arch/m68k/amiga/config.c      |   15 --
 include/asm-m68k/amigaints.h  |    8 -
 5 files changed, 117 insertions(+), 445 deletions(-)

9a577b35b8785a9ce7c19782c65f41f064a1dab5
diff --git a/arch/m68k/amiga/amiga_ksyms.c b/arch/m68k/amiga/amiga_ksyms.c
index b7bd84c..8f2e058 100644
--- a/arch/m68k/amiga/amiga_ksyms.c
+++ b/arch/m68k/amiga/amiga_ksyms.c
@@ -23,8 +23,6 @@ EXPORT_SYMBOL(amiga_chip_avail);
 EXPORT_SYMBOL(amiga_chip_size);
 EXPORT_SYMBOL(amiga_audio_period);
 EXPORT_SYMBOL(amiga_audio_min_period);
-EXPORT_SYMBOL(amiga_do_irq);
-EXPORT_SYMBOL(amiga_do_irq_list);
 
 #ifdef CONFIG_AMIGA_PCMCIA
   EXPORT_SYMBOL(pcmcia_reset);
diff --git a/arch/m68k/amiga/amiints.c b/arch/m68k/amiga/amiints.c
index e2d47b7..f9403f4 100644
--- a/arch/m68k/amiga/amiints.c
+++ b/arch/m68k/amiga/amiints.c
@@ -35,62 +35,30 @@
  *           /Jes
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
-#include <linux/seq_file.h>
 
-#include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <asm/amipcmcia.h>
 
-extern int cia_request_irq(struct ciabase *base,int irq,
-                           irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                           unsigned long flags, const char *devname, void *dev_id);
-extern void cia_free_irq(struct ciabase *base, unsigned int irq, void *dev_id);
-extern void cia_init_IRQ(struct ciabase *base);
-extern int cia_get_irq_list(struct ciabase *base, struct seq_file *p);
-
-/* irq node variables for amiga interrupt sources */
-static irq_node_t *ami_irq_list[AMI_STD_IRQS];
-
-static unsigned short amiga_intena_vals[AMI_STD_IRQS] = {
-	[IRQ_AMIGA_VERTB-IRQ_USER]	= IF_VERTB,
-	[IRQ_AMIGA_COPPER-IRQ_USER]	= IF_COPER,
-	[IRQ_AMIGA_AUD0-IRQ_USER]	= IF_AUD0,
-	[IRQ_AMIGA_AUD1-IRQ_USER]	= IF_AUD1,
-	[IRQ_AMIGA_AUD2-IRQ_USER]	= IF_AUD2,
-	[IRQ_AMIGA_AUD3-IRQ_USER]	= IF_AUD3,
-	[IRQ_AMIGA_BLIT-IRQ_USER]	= IF_BLIT,
-	[IRQ_AMIGA_DSKSYN-IRQ_USER]	= IF_DSKSYN,
-	[IRQ_AMIGA_DSKBLK-IRQ_USER]	= IF_DSKBLK,
-	[IRQ_AMIGA_RBF-IRQ_USER]	= IF_RBF,
-	[IRQ_AMIGA_TBE-IRQ_USER]	= IF_TBE,
-	[IRQ_AMIGA_SOFT-IRQ_USER]	= IF_SOFT,
-	[IRQ_AMIGA_PORTS-IRQ_USER]	= IF_PORTS,
-	[IRQ_AMIGA_EXTER-IRQ_USER]	= IF_EXTER
-};
-static const unsigned char ami_servers[AMI_STD_IRQS] = {
-	[IRQ_AMIGA_VERTB-IRQ_USER]	= 1,
-	[IRQ_AMIGA_PORTS-IRQ_USER]	= 1,
-	[IRQ_AMIGA_EXTER-IRQ_USER]	= 1
+static void amiga_enable_irq(unsigned int irq);
+static void amiga_disable_irq(unsigned int irq);
+static irqreturn_t ami_int1(int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t ami_int3(int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t ami_int4(int irq, void *dev_id, struct pt_regs *fp);
+static irqreturn_t ami_int5(int irq, void *dev_id, struct pt_regs *fp);
+
+static struct irq_controller amiga_irq_controller = {
+	.name		= "amiga",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.enable		= amiga_enable_irq,
+	.disable	= amiga_disable_irq,
 };
 
-static short ami_ablecount[AMI_IRQS];
-
-static irqreturn_t ami_badint(int irq, void *dev_id, struct pt_regs *fp)
-{
-	num_spurious += 1;
-	return IRQ_NONE;
-}
-
 /*
  * void amiga_init_IRQ(void)
  *
@@ -104,23 +72,12 @@ static irqreturn_t ami_badint(int irq, v
 
 void __init amiga_init_IRQ(void)
 {
-	int i;
+	request_irq(IRQ_AUTO_1, ami_int1, 0, "int1", NULL);
+	request_irq(IRQ_AUTO_3, ami_int3, 0, "int3", NULL);
+	request_irq(IRQ_AUTO_4, ami_int4, 0, "int4", NULL);
+	request_irq(IRQ_AUTO_5, ami_int5, 0, "int5", NULL);
 
-	/* initialize handlers */
-	for (i = 0; i < AMI_STD_IRQS; i++) {
-		if (ami_servers[i]) {
-			ami_irq_list[i] = NULL;
-		} else {
-			ami_irq_list[i] = new_irq_node();
-			ami_irq_list[i]->handler = ami_badint;
-			ami_irq_list[i]->flags   = 0;
-			ami_irq_list[i]->dev_id  = NULL;
-			ami_irq_list[i]->devname = NULL;
-			ami_irq_list[i]->next    = NULL;
-		}
-	}
-	for (i = 0; i < AMI_IRQS; i++)
-		ami_ablecount[i] = 0;
+	m68k_setup_irq_controller(&amiga_irq_controller, IRQ_USER, AMI_STD_IRQS);
 
 	/* turn off PCMCIA interrupts */
 	if (AMIGAHW_PRESENT(PCMCIA))
@@ -135,250 +92,21 @@ void __init amiga_init_IRQ(void)
 	cia_init_IRQ(&ciab_base);
 }
 
-static inline int amiga_insert_irq(irq_node_t **list, irq_node_t *node)
-{
-	unsigned long flags;
-	irq_node_t *cur;
-
-	if (!node->dev_id)
-		printk("%s: Warning: dev_id of %s is zero\n",
-		       __FUNCTION__, node->devname);
-
-	local_irq_save(flags);
-
-	cur = *list;
-
-	if (node->flags & SA_INTERRUPT) {
-		if (node->flags & SA_SHIRQ)
-			return -EBUSY;
-		/*
-		 * There should never be more than one
-		 */
-		while (cur && cur->flags & SA_INTERRUPT) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	} else {
-		while (cur) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	}
-
-	node->next = cur;
-	*list = node;
-
-	local_irq_restore(flags);
-	return 0;
-}
-
-static inline void amiga_delete_irq(irq_node_t **list, void *dev_id)
-{
-	unsigned long flags;
-	irq_node_t *node;
-
-	local_irq_save(flags);
-
-	for (node = *list; node; list = &node->next, node = *list) {
-		if (node->dev_id == dev_id) {
-			*list = node->next;
-			/* Mark it as free. */
-			node->handler = NULL;
-			local_irq_restore(flags);
-			return;
-		}
-	}
-	local_irq_restore(flags);
-	printk ("%s: tried to remove invalid irq\n", __FUNCTION__);
-}
-
-/*
- * amiga_request_irq : add an interrupt service routine for a particular
- *                     machine specific interrupt source.
- *                     If the addition was successful, it returns 0.
- */
-
-int amiga_request_irq(unsigned int irq,
-		      irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                      unsigned long flags, const char *devname, void *dev_id)
-{
-	irq_node_t *node;
-	int error = 0;
-
-	if (irq >= AMI_IRQS) {
-		printk ("%s: Unknown IRQ %d from %s\n", __FUNCTION__,
-			irq, devname);
-		return -ENXIO;
-	}
-
-	if (irq < IRQ_USER)
-		return cpu_request_irq(irq, handler, flags, devname, dev_id);
-
-	if (irq >= IRQ_AMIGA_CIAB)
-		return cia_request_irq(&ciab_base, irq - IRQ_AMIGA_CIAB,
-		                       handler, flags, devname, dev_id);
-
-	if (irq >= IRQ_AMIGA_CIAA)
-		return cia_request_irq(&ciaa_base, irq - IRQ_AMIGA_CIAA,
-		                       handler, flags, devname, dev_id);
-
-	irq -= IRQ_USER;
-	/*
-	 * IRQ_AMIGA_PORTS & IRQ_AMIGA_EXTER defaults to shared,
-	 * we could add a check here for the SA_SHIRQ flag but all drivers
-	 * should be aware of sharing anyway.
-	 */
-	if (ami_servers[irq]) {
-		if (!(node = new_irq_node()))
-			return -ENOMEM;
-		node->handler = handler;
-		node->flags   = flags;
-		node->dev_id  = dev_id;
-		node->devname = devname;
-		node->next    = NULL;
-		error = amiga_insert_irq(&ami_irq_list[irq], node);
-	} else {
-		ami_irq_list[irq]->handler = handler;
-		ami_irq_list[irq]->flags   = flags;
-		ami_irq_list[irq]->dev_id  = dev_id;
-		ami_irq_list[irq]->devname = devname;
-	}
-
-	/* enable the interrupt */
-	if (irq < IRQ_AMIGA_PORTS && !ami_ablecount[irq])
-		amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq];
-
-	return error;
-}
-
-void amiga_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq >= AMI_IRQS) {
-		printk ("%s: Unknown IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq < IRQ_USER)
-		cpu_free_irq(irq, dev_id);
-
-	if (irq >= IRQ_AMIGA_CIAB) {
-		cia_free_irq(&ciab_base, irq - IRQ_AMIGA_CIAB, dev_id);
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_CIAA) {
-		cia_free_irq(&ciaa_base, irq - IRQ_AMIGA_CIAA, dev_id);
-		return;
-	}
-
-	irq -= IRQ_USER;
-	if (ami_servers[irq]) {
-		amiga_delete_irq(&ami_irq_list[irq], dev_id);
-		/* if server list empty, disable the interrupt */
-		if (!ami_irq_list[irq] && irq < IRQ_AMIGA_PORTS)
-			amiga_custom.intena = amiga_intena_vals[irq];
-	} else {
-		if (ami_irq_list[irq]->dev_id != dev_id)
-			printk("%s: removing probably wrong IRQ %d from %s\n",
-			       __FUNCTION__, irq, ami_irq_list[irq]->devname);
-		ami_irq_list[irq]->handler = ami_badint;
-		ami_irq_list[irq]->flags   = 0;
-		ami_irq_list[irq]->dev_id  = NULL;
-		ami_irq_list[irq]->devname = NULL;
-		amiga_custom.intena = amiga_intena_vals[irq];
-	}
-}
-
 /*
  * Enable/disable a particular machine specific interrupt source.
  * Note that this may affect other interrupts in case of a shared interrupt.
  * This function should only be called for a _very_ short time to change some
  * internal data, that may not be changed by the interrupt at the same time.
- * ami_(enable|disable)_irq calls may also be nested.
  */
 
-void amiga_enable_irq(unsigned int irq)
-{
-	if (irq >= AMI_IRQS) {
-		printk("%s: Unknown IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (--ami_ablecount[irq])
-		return;
-
-	/* No action for auto-vector interrupts */
-	if (irq < IRQ_USER) {
-		printk("%s: Trying to enable auto-vector IRQ %i\n",
-		       __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_CIAB) {
-		cia_set_irq(&ciab_base, (1 << (irq - IRQ_AMIGA_CIAB)));
-		cia_able_irq(&ciab_base, CIA_ICR_SETCLR |
-		             (1 << (irq - IRQ_AMIGA_CIAB)));
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_CIAA) {
-		cia_set_irq(&ciaa_base, (1 << (irq - IRQ_AMIGA_CIAA)));
-		cia_able_irq(&ciaa_base, CIA_ICR_SETCLR |
-		             (1 << (irq - IRQ_AMIGA_CIAA)));
-		return;
-	}
-
-	/* enable the interrupt */
-	amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq-IRQ_USER];
-}
-
-void amiga_disable_irq(unsigned int irq)
-{
-	if (irq >= AMI_IRQS) {
-		printk("%s: Unknown IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (ami_ablecount[irq]++)
-		return;
-
-	/* No action for auto-vector interrupts */
-	if (irq < IRQ_USER) {
-		printk("%s: Trying to disable auto-vector IRQ %i\n",
-		       __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_CIAB) {
-		cia_able_irq(&ciab_base, 1 << (irq - IRQ_AMIGA_CIAB));
-		return;
-	}
-
-	if (irq >= IRQ_AMIGA_CIAA) {
-		cia_able_irq(&ciaa_base, 1 << (irq - IRQ_AMIGA_CIAA));
-		return;
-	}
-
-	/* disable the interrupt */
-	amiga_custom.intena = amiga_intena_vals[irq-IRQ_USER];
-}
-
-inline void amiga_do_irq(int irq, struct pt_regs *fp)
+static void amiga_enable_irq(unsigned int irq)
 {
-	kstat_cpu(0).irqs[irq]++;
-	ami_irq_list[irq-IRQ_USER]->handler(irq, ami_irq_list[irq-IRQ_USER]->dev_id, fp);
+	amiga_custom.intena = IF_SETCLR | (1 << (irq - IRQ_USER));
 }
 
-void amiga_do_irq_list(int irq, struct pt_regs *fp)
+static void amiga_disable_irq(unsigned int irq)
 {
-	irq_node_t *node;
-
-	kstat_cpu(0).irqs[irq]++;
-
-	amiga_custom.intreq = amiga_intena_vals[irq-IRQ_USER];
-
-	for (node = ami_irq_list[irq-IRQ_USER]; node; node = node->next)
-		node->handler(irq, node->dev_id, fp);
+	amiga_custom.intena = 1 << (irq - IRQ_USER);
 }
 
 /*
@@ -392,19 +120,19 @@ static irqreturn_t ami_int1(int irq, voi
 	/* if serial transmit buffer empty, interrupt */
 	if (ints & IF_TBE) {
 		amiga_custom.intreq = IF_TBE;
-		amiga_do_irq(IRQ_AMIGA_TBE, fp);
+		m68k_handle_int(IRQ_AMIGA_TBE, fp);
 	}
 
 	/* if floppy disk transfer complete, interrupt */
 	if (ints & IF_DSKBLK) {
 		amiga_custom.intreq = IF_DSKBLK;
-		amiga_do_irq(IRQ_AMIGA_DSKBLK, fp);
+		m68k_handle_int(IRQ_AMIGA_DSKBLK, fp);
 	}
 
 	/* if software interrupt set, interrupt */
 	if (ints & IF_SOFT) {
 		amiga_custom.intreq = IF_SOFT;
-		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
+		m68k_handle_int(IRQ_AMIGA_SOFT, fp);
 	}
 	return IRQ_HANDLED;
 }
@@ -416,18 +144,20 @@ static irqreturn_t ami_int3(int irq, voi
 	/* if a blitter interrupt */
 	if (ints & IF_BLIT) {
 		amiga_custom.intreq = IF_BLIT;
-		amiga_do_irq(IRQ_AMIGA_BLIT, fp);
+		m68k_handle_int(IRQ_AMIGA_BLIT, fp);
 	}
 
 	/* if a copper interrupt */
 	if (ints & IF_COPER) {
 		amiga_custom.intreq = IF_COPER;
-		amiga_do_irq(IRQ_AMIGA_COPPER, fp);
+		m68k_handle_int(IRQ_AMIGA_COPPER, fp);
 	}
 
 	/* if a vertical blank interrupt */
-	if (ints & IF_VERTB)
-		amiga_do_irq_list(IRQ_AMIGA_VERTB, fp);
+	if (ints & IF_VERTB) {
+		amiga_custom.intreq = IF_VERTB;
+		m68k_handle_int(IRQ_AMIGA_VERTB, fp);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -438,25 +168,25 @@ static irqreturn_t ami_int4(int irq, voi
 	/* if audio 0 interrupt */
 	if (ints & IF_AUD0) {
 		amiga_custom.intreq = IF_AUD0;
-		amiga_do_irq(IRQ_AMIGA_AUD0, fp);
+		m68k_handle_int(IRQ_AMIGA_AUD0, fp);
 	}
 
 	/* if audio 1 interrupt */
 	if (ints & IF_AUD1) {
 		amiga_custom.intreq = IF_AUD1;
-		amiga_do_irq(IRQ_AMIGA_AUD1, fp);
+		m68k_handle_int(IRQ_AMIGA_AUD1, fp);
 	}
 
 	/* if audio 2 interrupt */
 	if (ints & IF_AUD2) {
 		amiga_custom.intreq = IF_AUD2;
-		amiga_do_irq(IRQ_AMIGA_AUD2, fp);
+		m68k_handle_int(IRQ_AMIGA_AUD2, fp);
 	}
 
 	/* if audio 3 interrupt */
 	if (ints & IF_AUD3) {
 		amiga_custom.intreq = IF_AUD3;
-		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
+		m68k_handle_int(IRQ_AMIGA_AUD3, fp);
 	}
 	return IRQ_HANDLED;
 }
@@ -468,53 +198,13 @@ static irqreturn_t ami_int5(int irq, voi
 	/* if serial receive buffer full interrupt */
 	if (ints & IF_RBF) {
 		/* acknowledge of IF_RBF must be done by the serial interrupt */
-		amiga_do_irq(IRQ_AMIGA_RBF, fp);
+		m68k_handle_int(IRQ_AMIGA_RBF, fp);
 	}
 
 	/* if a disk sync interrupt */
 	if (ints & IF_DSKSYN) {
 		amiga_custom.intreq = IF_DSKSYN;
-		amiga_do_irq(IRQ_AMIGA_DSKSYN, fp);
+		m68k_handle_int(IRQ_AMIGA_DSKSYN, fp);
 	}
 	return IRQ_HANDLED;
 }
-
-static irqreturn_t ami_int7(int irq, void *dev_id, struct pt_regs *fp)
-{
-	panic ("level 7 interrupt received\n");
-}
-
-irqreturn_t (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[1] = ami_int1,
-	[3] = ami_int3,
-	[4] = ami_int4,
-	[5] = ami_int5,
-	[7] = ami_int7
-};
-
-int show_amiga_interrupts(struct seq_file *p, void *v)
-{
-	int i;
-	irq_node_t *node;
-
-	for (i = IRQ_USER; i < IRQ_AMIGA_CIAA; i++) {
-		node = ami_irq_list[i - IRQ_USER];
-		if (!node)
-			continue;
-		seq_printf(p, "ami  %2d: %10u ", i,
-		               kstat_cpu(0).irqs[i]);
-		do {
-			if (node->flags & SA_INTERRUPT)
-				seq_puts(p, "F ");
-			else
-				seq_puts(p, "  ");
-			seq_printf(p, "%s\n", node->devname);
-			if ((node = node->next))
-				seq_puts(p, "                    ");
-		} while (node);
-	}
-
-	cia_get_irq_list(&ciaa_base, p);
-	cia_get_irq_list(&ciab_base, p);
-	return 0;
-}
diff --git a/arch/m68k/amiga/cia.c b/arch/m68k/amiga/cia.c
index 4a003d8..0956e45 100644
--- a/arch/m68k/amiga/cia.c
+++ b/arch/m68k/amiga/cia.c
@@ -29,21 +29,18 @@ struct ciabase {
 	unsigned short int_mask;
 	int handler_irq, cia_irq, server_irq;
 	char *name;
-	irq_handler_t irq_list[CIA_IRQS];
 } ciaa_base = {
 	.cia		= &ciaa,
 	.int_mask	= IF_PORTS,
-	.handler_irq	= IRQ_AUTO_2,
+	.handler_irq	= IRQ_AMIGA_PORTS,
 	.cia_irq	= IRQ_AMIGA_CIAA,
-	.server_irq	= IRQ_AMIGA_PORTS,
-	.name		= "CIAA handler"
+	.name		= "CIAA"
 }, ciab_base = {
 	.cia		= &ciab,
 	.int_mask	= IF_EXTER,
-	.handler_irq	= IRQ_AUTO_6,
+	.handler_irq	= IRQ_AMIGA_EXTER,
 	.cia_irq	= IRQ_AMIGA_CIAB,
-	.server_irq	= IRQ_AMIGA_EXTER,
-	.name		= "CIAB handler"
+	.name		= "CIAB"
 };
 
 /*
@@ -66,13 +63,11 @@ unsigned char cia_set_irq(struct ciabase
 
 /*
  *  Enable or disable CIA interrupts, return old interrupt mask,
- *  interrupts will only be enabled if a handler exists
  */
 
 unsigned char cia_able_irq(struct ciabase *base, unsigned char mask)
 {
-	unsigned char old, tmp;
-	int i;
+	unsigned char old;
 
 	old = base->icr_mask;
 	base->icr_data |= base->cia->icr;
@@ -82,98 +77,104 @@ unsigned char cia_able_irq(struct ciabas
 	else
 		base->icr_mask &= ~mask;
 	base->icr_mask &= CIA_ICR_ALL;
-	for (i = 0, tmp = 1; i < CIA_IRQS; i++, tmp <<= 1) {
-		if ((tmp & base->icr_mask) && !base->irq_list[i].handler) {
-			base->icr_mask &= ~tmp;
-			base->cia->icr = tmp;
-		}
-	}
 	if (base->icr_data & base->icr_mask)
 		amiga_custom.intreq = IF_SETCLR | base->int_mask;
 	return old;
 }
 
-int cia_request_irq(struct ciabase *base, unsigned int irq,
-                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
-{
-	unsigned char mask;
-
-	base->irq_list[irq].handler = handler;
-	base->irq_list[irq].flags   = flags;
-	base->irq_list[irq].dev_id  = dev_id;
-	base->irq_list[irq].devname = devname;
-
-	/* enable the interrupt */
-	mask = 1 << irq;
-	cia_set_irq(base, mask);
-	cia_able_irq(base, CIA_ICR_SETCLR | mask);
-	return 0;
-}
-
-void cia_free_irq(struct ciabase *base, unsigned int irq, void *dev_id)
-{
-	if (base->irq_list[irq].dev_id != dev_id)
-		printk("%s: removing probably wrong IRQ %i from %s\n",
-		       __FUNCTION__, base->cia_irq + irq,
-		       base->irq_list[irq].devname);
-
-	base->irq_list[irq].handler = NULL;
-	base->irq_list[irq].flags   = 0;
-
-	cia_able_irq(base, 1 << irq);
-}
-
 static irqreturn_t cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
-	int mach_irq, i;
+	int mach_irq;
 	unsigned char ints;
 
 	mach_irq = base->cia_irq;
 	ints = cia_set_irq(base, CIA_ICR_ALL);
 	amiga_custom.intreq = base->int_mask;
-	for (i = 0; i < CIA_IRQS; i++, mach_irq++) {
-		if (ints & 1) {
-			kstat_cpu(0).irqs[mach_irq]++;
-			base->irq_list[i].handler(mach_irq, base->irq_list[i].dev_id, fp);
-		}
-		ints >>= 1;
+	for (; ints; mach_irq++, ints >>= 1) {
+		if (ints & 1)
+			m68k_handle_int(mach_irq, fp);
 	}
-	amiga_do_irq_list(base->server_irq, fp);
 	return IRQ_HANDLED;
 }
 
-void __init cia_init_IRQ(struct ciabase *base)
+static void cia_enable_irq(unsigned int irq)
 {
-	int i;
+	unsigned char mask;
 
-	/* init isr handlers */
-	for (i = 0; i < CIA_IRQS; i++) {
-		base->irq_list[i].handler = NULL;
-		base->irq_list[i].flags   = 0;
+	if (irq >= IRQ_AMIGA_CIAB) {
+		mask = 1 << (irq - IRQ_AMIGA_CIAB);
+		cia_set_irq(&ciab_base, mask);
+		cia_able_irq(&ciab_base, CIA_ICR_SETCLR | mask);
+	} else {
+		mask = 1 << (irq - IRQ_AMIGA_CIAA);
+		cia_set_irq(&ciaa_base, mask);
+		cia_able_irq(&ciaa_base, CIA_ICR_SETCLR | mask);
 	}
+}
 
-	/* clear any pending interrupt and turn off all interrupts */
-	cia_set_irq(base, CIA_ICR_ALL);
-	cia_able_irq(base, CIA_ICR_ALL);
+static void cia_disable_irq(unsigned int irq)
+{
+	if (irq >= IRQ_AMIGA_CIAB)
+		cia_able_irq(&ciab_base, 1 << (irq - IRQ_AMIGA_CIAB));
+	else
+		cia_able_irq(&ciaa_base, 1 << (irq - IRQ_AMIGA_CIAA));
+}
 
-	/* install CIA handler */
-	request_irq(base->handler_irq, cia_handler, 0, base->name, base);
+static struct irq_controller cia_irq_controller = {
+	.name		= "cia",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.enable		= cia_enable_irq,
+	.disable	= cia_disable_irq,
+};
+
+/*
+ * Override auto irq 2 & 6 and use them as general chain
+ * for external interrupts, we link the CIA interrupt sources
+ * into this chain.
+ */
 
-	amiga_custom.intena = IF_SETCLR | base->int_mask;
+static void auto_enable_irq(unsigned int irq)
+{
+	switch (irq) {
+	case IRQ_AUTO_2:
+		amiga_custom.intena = IF_SETCLR | IF_PORTS;
+		break;
+	case IRQ_AUTO_6:
+		amiga_custom.intena = IF_SETCLR | IF_EXTER;
+		break;
+	}
 }
 
-int cia_get_irq_list(struct ciabase *base, struct seq_file *p)
+static void auto_disable_irq(unsigned int irq)
 {
-	int i, j;
-
-	j = base->cia_irq;
-	for (i = 0; i < CIA_IRQS; i++) {
-		seq_printf(p, "cia  %2d: %10d ", j + i,
-			       kstat_cpu(0).irqs[j + i]);
-		seq_puts(p, "  ");
-		seq_printf(p, "%s\n", base->irq_list[i].devname);
+	switch (irq) {
+	case IRQ_AUTO_2:
+		amiga_custom.intena = IF_PORTS;
+		break;
+	case IRQ_AUTO_6:
+		amiga_custom.intena = IF_EXTER;
+		break;
 	}
-	return 0;
+}
+
+static struct irq_controller auto_irq_controller = {
+	.name		= "auto",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.enable		= auto_enable_irq,
+	.disable	= auto_disable_irq,
+};
+
+void __init cia_init_IRQ(struct ciabase *base)
+{
+	m68k_setup_irq_controller(&cia_irq_controller, base->cia_irq, CIA_IRQS);
+
+	/* clear any pending interrupt and turn off all interrupts */
+	cia_set_irq(base, CIA_ICR_ALL);
+	cia_able_irq(base, CIA_ICR_ALL);
+
+	/* override auto int and install CIA handler */
+	m68k_setup_irq_controller(&auto_irq_controller, base->handler_irq, 1);
+	m68k_irq_startup(base->handler_irq);
+	request_irq(base->handler_irq, cia_handler, SA_SHIRQ, base->name, base);
 }
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 12e3706..b5b8a41 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -87,17 +87,8 @@ extern char m68k_debug_device[];
 static void amiga_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 /* amiga specific irq functions */
 extern void amiga_init_IRQ (void);
-extern irqreturn_t (*amiga_default_handler[]) (int, void *, struct pt_regs *);
-extern int amiga_request_irq (unsigned int irq,
-			      irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                              unsigned long flags, const char *devname,
-			      void *dev_id);
-extern void amiga_free_irq (unsigned int irq, void *dev_id);
-extern void amiga_enable_irq (unsigned int);
-extern void amiga_disable_irq (unsigned int);
 static void amiga_get_model(char *model);
 static int amiga_get_hardware_list(char *buffer);
-extern int show_amiga_interrupts (struct seq_file *, void *);
 /* amiga specific timer functions */
 static unsigned long amiga_gettimeoffset (void);
 static int a3000_hwclk (int, struct rtc_time *);
@@ -392,14 +383,8 @@ void __init config_amiga(void)
 
   mach_sched_init      = amiga_sched_init;
   mach_init_IRQ        = amiga_init_IRQ;
-  mach_default_handler = &amiga_default_handler;
-  mach_request_irq     = amiga_request_irq;
-  mach_free_irq        = amiga_free_irq;
-  enable_irq           = amiga_enable_irq;
-  disable_irq          = amiga_disable_irq;
   mach_get_model       = amiga_get_model;
   mach_get_hardware_list = amiga_get_hardware_list;
-  mach_get_irq_list    = show_amiga_interrupts;
   mach_gettimeoffset   = amiga_gettimeoffset;
   if (AMIGAHW_PRESENT(A3000_CLK)){
     mach_hwclk         = a3000_hwclk;
diff --git a/include/asm-m68k/amigaints.h b/include/asm-m68k/amigaints.h
index 576f5d1..7c87134 100644
--- a/include/asm-m68k/amigaints.h
+++ b/include/asm-m68k/amigaints.h
@@ -37,8 +37,8 @@ #define IRQ_AMIGA_DSKSYN	(IRQ_USER+12)
 #define IRQ_AMIGA_SOFT		(IRQ_USER+2)
 
 /* interrupts from external hardware */
-#define IRQ_AMIGA_PORTS		(IRQ_USER+3)
-#define IRQ_AMIGA_EXTER		(IRQ_USER+13)
+#define IRQ_AMIGA_PORTS		IRQ_AUTO_2
+#define IRQ_AMIGA_EXTER		IRQ_AUTO_6
 
 /* copper interrupt */
 #define IRQ_AMIGA_COPPER	(IRQ_USER+4)
@@ -88,9 +88,6 @@ #define IF_SOFT     0x0004	/* software i
 #define IF_DSKBLK   0x0002	/* diskblock DMA finished */
 #define IF_TBE	    0x0001	/* serial transmit buffer empty interrupt */
 
-extern void amiga_do_irq(int irq, struct pt_regs *fp);
-extern void amiga_do_irq_list(int irq, struct pt_regs *fp);
-
 /* CIA interrupt control register bits */
 
 #define CIA_ICR_TA	0x01
@@ -107,6 +104,7 @@ #define CIA_ICR_SETCLR	0x80
 
 extern struct ciabase ciaa_base, ciab_base;
 
+extern void cia_init_IRQ(struct ciabase *base);
 extern unsigned char cia_set_irq(struct ciabase *base, unsigned char mask);
 extern unsigned char cia_able_irq(struct ciabase *base, unsigned char mask);
 
-- 
1.3.3

--

