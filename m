Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWFWSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWFWSmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWFWSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19919 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751926AbWFWSmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:04 -0400
Message-Id: <20060623183914.898486000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:12 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] convert atari irq code
Content-Disposition: inline; filename=0022-M68K-convert-atari-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/atari/ataints.c |  278 +++++++--------------------------------------
 arch/m68k/atari/config.c  |   11 --
 2 files changed, 42 insertions(+), 247 deletions(-)

db0859143263b908e466609fc42856e5f522cae9
diff --git a/arch/m68k/atari/ataints.c b/arch/m68k/atari/ataints.c
index bb54741..ece13cb 100644
--- a/arch/m68k/atari/ataints.c
+++ b/arch/m68k/atari/ataints.c
@@ -104,6 +104,7 @@ #include <asm/entry.h>
  * the sr copy in the frame.
  */
 
+#if 0
 
 #define	NUM_INT_SOURCES	(8 + NUM_ATARI_SOURCES)
 
@@ -133,13 +134,6 @@ static struct irqhandler irq_handler[NUM
  */
 static struct irqparam irq_param[NUM_INT_SOURCES];
 
-/*
- * Bitmap for free interrupt vector numbers
- * (new vectors starting from 0x70 can be allocated by
- * atari_register_vme_int())
- */
-static int free_vme_vec_bitmap;
-
 /* check for valid int number (complex, sigh...) */
 #define	IS_VALID_INTNO(n)											\
 	((n) > 0 &&														\
@@ -301,6 +295,14 @@ __asm__ (__ALIGN_STR "\n"
 );
 	for (;;);
 }
+#endif
+
+/*
+ * Bitmap for free interrupt vector numbers
+ * (new vectors starting from 0x70 can be allocated by
+ * atari_register_vme_int())
+ */
+static int free_vme_vec_bitmap;
 
 /* GK:
  * HBL IRQ handler for Falcon. Nobody needs it :-)
@@ -313,13 +315,34 @@ __ALIGN_STR "\n\t"
 	"orw	#0x200,%sp@\n\t"	/* set saved ipl to 2 */
 	"rte");
 
-/* Defined in entry.S; only increments 'num_spurious' */
-asmlinkage void bad_inthandler(void);
-
-extern void atari_microwire_cmd( int cmd );
+extern void atari_microwire_cmd(int cmd);
 
 extern int atari_SCC_reset_done;
 
+static int atari_startup_irq(unsigned int irq)
+{
+	m68k_irq_startup(irq);
+	atari_turnon_irq(irq);
+	atari_enable_irq(irq);
+	return 0;
+}
+
+static void atari_shutdown_irq(unsigned int irq)
+{
+	atari_disable_irq(irq);
+	atari_turnoff_irq(irq);
+	m68k_irq_shutdown(irq);
+}
+
+static struct irq_controller atari_irq_controller = {
+	.name		= "atari",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.startup	= atari_startup_irq,
+	.shutdown	= atari_shutdown_irq,
+	.enable		= atari_enable_irq,
+	.disable	= atari_disable_irq,
+};
+
 /*
  * void atari_init_IRQ (void)
  *
@@ -333,12 +356,8 @@ extern int atari_SCC_reset_done;
 
 void __init atari_init_IRQ(void)
 {
-	int i;
-
-	/* initialize the vector table */
-	for (i = 0; i < NUM_INT_SOURCES; ++i) {
-		vectors[IRQ_SOURCE_TO_VECTOR(i)] = bad_inthandler;
-	}
+	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
+	m68k_setup_irq_controller(&atari_irq_controller, 1, NUM_ATARI_SOURCES - 1);
 
 	/* Initialize the MFP(s) */
 
@@ -378,8 +397,7 @@ #endif
 									 * enabled in VME mask
 									 */
 		tt_scu.vme_mask = 0x60;		/* enable MFP and SCC ints */
-	}
-	else {
+	} else {
 		/* If no SCU and no Hades, the HSYNC interrupt needs to be
 		 * disabled this way. (Else _inthandler in kernel/sys_call.S
 		 * gets overruns)
@@ -404,184 +422,6 @@ #endif
 }
 
 
-static irqreturn_t atari_call_irq_list( int irq, void *dev_id, struct pt_regs *fp )
-{
-	irq_node_t *node;
-
-	for (node = (irq_node_t *)dev_id; node; node = node->next)
-		node->handler(irq, node->dev_id, fp);
-	return IRQ_HANDLED;
-}
-
-
-/*
- * atari_request_irq : add an interrupt service routine for a particular
- *                     machine specific interrupt source.
- *                     If the addition was successful, it returns 0.
- */
-
-int atari_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                      unsigned long flags, const char *devname, void *dev_id)
-{
-	int vector;
-	unsigned long oflags = flags;
-
-	/*
-	 * The following is a hack to make some PCI card drivers work,
-	 * which set the SA_SHIRQ flag.
-	 */
-
-	flags &= ~SA_SHIRQ;
-
-	if (flags == SA_INTERRUPT) {
-		printk ("%s: SA_INTERRUPT changed to IRQ_TYPE_SLOW for %s\n",
-			__FUNCTION__, devname);
-		flags = IRQ_TYPE_SLOW;
-	}
-	if (flags < IRQ_TYPE_SLOW || flags > IRQ_TYPE_PRIO) {
-		printk ("%s: Bad irq type 0x%lx <0x%lx> requested from %s\n",
-		        __FUNCTION__, flags, oflags, devname);
-		return -EINVAL;
-	}
-	if (!IS_VALID_INTNO(irq)) {
-		printk ("%s: Unknown irq %d requested from %s\n",
-		        __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-	vector = IRQ_SOURCE_TO_VECTOR(irq);
-
-	/*
-	 * Check type/source combination: slow ints are (currently)
-	 * only possible for MFP-interrupts.
-	 */
-	if (flags == IRQ_TYPE_SLOW &&
-		(irq < STMFP_SOURCE_BASE || irq >= SCC_SOURCE_BASE)) {
-		printk ("%s: Slow irq requested for non-MFP source %d from %s\n",
-		        __FUNCTION__, irq, devname);
-		return -EINVAL;
-	}
-
-	if (vectors[vector] == bad_inthandler) {
-		/* int has no handler yet */
-		irq_handler[irq].handler = handler;
-		irq_handler[irq].dev_id  = dev_id;
-		irq_param[irq].flags   = flags;
-		irq_param[irq].devname = devname;
-		vectors[vector] =
-			(flags == IRQ_TYPE_SLOW) ? slow_handlers[irq-STMFP_SOURCE_BASE] :
-			(flags == IRQ_TYPE_FAST) ? atari_fast_irq_handler :
-			                          atari_prio_irq_handler;
-		/* If MFP int, also enable and umask it */
-		atari_turnon_irq(irq);
-		atari_enable_irq(irq);
-
-		return 0;
-	}
-	else if (irq_param[irq].flags == flags) {
-		/* old handler is of same type -> handlers can be chained */
-		irq_node_t *node;
-		unsigned long flags;
-
-		local_irq_save(flags);
-
-		if (irq_handler[irq].handler != atari_call_irq_list) {
-			/* Only one handler yet, make a node for this first one */
-			if (!(node = new_irq_node()))
-				return -ENOMEM;
-			node->handler = irq_handler[irq].handler;
-			node->dev_id  = irq_handler[irq].dev_id;
-			node->devname = irq_param[irq].devname;
-			node->next = NULL;
-
-			irq_handler[irq].handler = atari_call_irq_list;
-			irq_handler[irq].dev_id  = node;
-			irq_param[irq].devname   = "chained";
-		}
-
-		if (!(node = new_irq_node()))
-			return -ENOMEM;
-		node->handler = handler;
-		node->dev_id  = dev_id;
-		node->devname = devname;
-		/* new handlers are put in front of the queue */
-		node->next = irq_handler[irq].dev_id;
-		irq_handler[irq].dev_id = node;
-
-		local_irq_restore(flags);
-		return 0;
-	} else {
-		printk ("%s: Irq %d allocated by other type int (call from %s)\n",
-		        __FUNCTION__, irq, devname);
-		return -EBUSY;
-	}
-}
-
-void atari_free_irq(unsigned int irq, void *dev_id)
-{
-	unsigned long flags;
-	int vector;
-	irq_node_t **list, *node;
-
-	if (!IS_VALID_INTNO(irq)) {
-		printk("%s: Unknown irq %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	vector = IRQ_SOURCE_TO_VECTOR(irq);
-	if (vectors[vector] == bad_inthandler)
-		goto not_found;
-
-	local_irq_save(flags);
-
-	if (irq_handler[irq].handler != atari_call_irq_list) {
-		/* It's the only handler for the interrupt */
-		if (irq_handler[irq].dev_id != dev_id) {
-			local_irq_restore(flags);
-			goto not_found;
-		}
-		irq_handler[irq].handler = NULL;
-		irq_handler[irq].dev_id  = NULL;
-		irq_param[irq].devname   = NULL;
-		vectors[vector] = bad_inthandler;
-		/* If MFP int, also disable it */
-		atari_disable_irq(irq);
-		atari_turnoff_irq(irq);
-
-		local_irq_restore(flags);
-		return;
-	}
-
-	/* The interrupt is chained, find the irq on the list */
-	for(list = (irq_node_t **)&irq_handler[irq].dev_id; *list; list = &(*list)->next) {
-		if ((*list)->dev_id == dev_id) break;
-	}
-	if (!*list) {
-		local_irq_restore(flags);
-		goto not_found;
-	}
-
-	(*list)->handler = NULL; /* Mark it as free for reallocation */
-	*list = (*list)->next;
-
-	/* If there's now only one handler, unchain the interrupt, i.e. plug in
-	 * the handler directly again and omit atari_call_irq_list */
-	node = (irq_node_t *)irq_handler[irq].dev_id;
-	if (node && !node->next) {
-		irq_handler[irq].handler = node->handler;
-		irq_handler[irq].dev_id  = node->dev_id;
-		irq_param[irq].devname   = node->devname;
-		node->handler = NULL; /* Mark it as free for reallocation */
-	}
-
-	local_irq_restore(flags);
-	return;
-
-not_found:
-	printk("%s: tried to remove invalid irq\n", __FUNCTION__);
-	return;
-}
-
-
 /*
  * atari_register_vme_int() returns the number of a free interrupt vector for
  * hardware with a programmable int vector (probably a VME board).
@@ -591,58 +431,24 @@ unsigned long atari_register_vme_int(voi
 {
 	int i;
 
-	for(i = 0; i < 32; i++)
-		if((free_vme_vec_bitmap & (1 << i)) == 0)
+	for (i = 0; i < 32; i++)
+		if ((free_vme_vec_bitmap & (1 << i)) == 0)
 			break;
 
-	if(i == 16)
+	if (i == 16)
 		return 0;
 
 	free_vme_vec_bitmap |= 1 << i;
-	return (VME_SOURCE_BASE + i);
+	return VME_SOURCE_BASE + i;
 }
 
 
 void atari_unregister_vme_int(unsigned long irq)
 {
-	if(irq >= VME_SOURCE_BASE && irq < VME_SOURCE_BASE + VME_MAX_SOURCES) {
+	if (irq >= VME_SOURCE_BASE && irq < VME_SOURCE_BASE + VME_MAX_SOURCES) {
 		irq -= VME_SOURCE_BASE;
 		free_vme_vec_bitmap &= ~(1 << irq);
 	}
 }
 
 
-int show_atari_interrupts(struct seq_file *p, void *v)
-{
-	int i;
-
-	for (i = 0; i < NUM_INT_SOURCES; ++i) {
-		if (vectors[IRQ_SOURCE_TO_VECTOR(i)] == bad_inthandler)
-			continue;
-		if (i < STMFP_SOURCE_BASE)
-			seq_printf(p, "auto %2d: %10u ",
-				       i, kstat_cpu(0).irqs[i]);
-		else
-			seq_printf(p, "vec $%02x: %10u ",
-				       IRQ_SOURCE_TO_VECTOR(i),
-				       kstat_cpu(0).irqs[i]);
-
-		if (irq_handler[i].handler != atari_call_irq_list) {
-			seq_printf(p, "%s\n", irq_param[i].devname);
-		}
-		else {
-			irq_node_t *n;
-			for( n = (irq_node_t *)irq_handler[i].dev_id; n; n = n->next ) {
-				seq_printf(p, "%s\n", n->devname);
-				if (n->next)
-					seq_puts(p, "                    " );
-			}
-		}
-	}
-	if (num_spurious)
-		seq_printf(p, "spurio.: %10u\n", num_spurious);
-
-	return 0;
-}
-
-
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 1012b08..727289a 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -57,12 +57,6 @@ static int atari_get_hardware_list(char 
 
 /* atari specific irq functions */
 extern void atari_init_IRQ (void);
-extern int atari_request_irq (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                              unsigned long flags, const char *devname, void *dev_id);
-extern void atari_free_irq (unsigned int irq, void *dev_id);
-extern void atari_enable_irq (unsigned int);
-extern void atari_disable_irq (unsigned int);
-extern int show_atari_interrupts (struct seq_file *, void *);
 extern void atari_mksound( unsigned int count, unsigned int ticks );
 #ifdef CONFIG_HEARTBEAT
 static void atari_heartbeat( int on );
@@ -232,13 +226,8 @@ void __init config_atari(void)
 
     mach_sched_init      = atari_sched_init;
     mach_init_IRQ        = atari_init_IRQ;
-    mach_request_irq     = atari_request_irq;
-    mach_free_irq        = atari_free_irq;
-    enable_irq           = atari_enable_irq;
-    disable_irq          = atari_disable_irq;
     mach_get_model	 = atari_get_model;
     mach_get_hardware_list = atari_get_hardware_list;
-    mach_get_irq_list	 = show_atari_interrupts;
     mach_gettimeoffset   = atari_gettimeoffset;
     mach_reset           = atari_reset;
     mach_max_dma_address = 0xffffff;
-- 
1.3.3

--

