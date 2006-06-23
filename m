Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWFWSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWFWSmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWFWSmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20175 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751927AbWFWSmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:05 -0400
Message-Id: <20060623183913.384163000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:08 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] introduce irq controller
Content-Disposition: inline; filename=0018-M68K-introduce-irq-controller.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce irq controller and use it to manage auto vector interrupts.
Introduce setup_irq() which can be used for irq setup.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/amiga/amiints.c      |    4 -
 arch/m68k/bvme6000/bvmeints.c  |    1 
 arch/m68k/kernel/ints.c        |  171 +++++++++++++++++++++++++++++-----------
 arch/m68k/mac/config.c         |   15 ----
 arch/m68k/mac/macints.c        |    7 --
 arch/m68k/mvme147/147ints.c    |    1 
 arch/m68k/mvme16x/16xints.c    |    1 
 arch/m68k/q40/config.c         |    2 
 arch/m68k/q40/q40ints.c        |   17 ----
 drivers/block/amiflop.c        |    1 
 include/asm-m68k/atari_stdma.h |    2 
 include/asm-m68k/irq.h         |   25 ++++--
 12 files changed, 148 insertions(+), 99 deletions(-)

565955489c28c96c32f022d473c7c141e1856874
diff --git a/arch/m68k/amiga/amiints.c b/arch/m68k/amiga/amiints.c
index d02458e..e2d47b7 100644
--- a/arch/m68k/amiga/amiints.c
+++ b/arch/m68k/amiga/amiints.c
@@ -40,6 +40,7 @@ #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/seq_file.h>
 
@@ -484,13 +485,10 @@ static irqreturn_t ami_int7(int irq, voi
 }
 
 irqreturn_t (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[0] = ami_badint,
 	[1] = ami_int1,
-	[2] = ami_badint,
 	[3] = ami_int3,
 	[4] = ami_int4,
 	[5] = ami_int5,
-	[6] = ami_badint,
 	[7] = ami_int7
 };
 
diff --git a/arch/m68k/bvme6000/bvmeints.c b/arch/m68k/bvme6000/bvmeints.c
index 298a8df..b015fdc 100644
--- a/arch/m68k/bvme6000/bvmeints.c
+++ b/arch/m68k/bvme6000/bvmeints.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
index 3ce7c61..c7f6ee6 100644
--- a/arch/m68k/kernel/ints.c
+++ b/arch/m68k/kernel/ints.c
@@ -45,7 +45,15 @@ #include <asm/q40ints.h>
 #endif
 
 /* table for system interrupt handlers */
-static irq_handler_t irq_list[SYS_IRQS];
+static struct irq_node *irq_list[SYS_IRQS];
+static struct irq_controller *irq_controller[SYS_IRQS];
+
+static struct irq_controller auto_irq_controller = {
+	.name		= "auto",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.startup	= m68k_irq_startup,
+	.shutdown	= m68k_irq_shutdown,
+};
 
 static const char *default_names[SYS_IRQS] = {
 	[0] = "spurious int",
@@ -101,17 +109,13 @@ void __init init_IRQ(void)
 		hardirq_mask_is_broken();
 	}
 
-	for (i = 0; i < SYS_IRQS; i++) {
-		if (mach_default_handler)
-			irq_list[i].handler = (*mach_default_handler)[i];
-		irq_list[i].flags   = 0;
-		irq_list[i].dev_id  = NULL;
-		irq_list[i].devname = default_names[i];
+	for (i = IRQ_AUTO_1; i <= IRQ_AUTO_7; i++) {
+		irq_controller[i] = &auto_irq_controller;
+		if (mach_default_handler && (*mach_default_handler)[i])
+			cpu_request_irq(i, (*mach_default_handler)[i],
+					0, default_names[i], NULL);
 	}
 
-	for (i = 0; i < NUM_IRQ_NODES; i++)
-		nodes[i].handler = NULL;
-
 	mach_init_IRQ ();
 }
 
@@ -120,9 +124,12 @@ irq_node_t *new_irq_node(void)
 	irq_node_t *node;
 	short i;
 
-	for (node = nodes, i = NUM_IRQ_NODES-1; i >= 0; node++, i--)
-		if (!node->handler)
+	for (node = nodes, i = NUM_IRQ_NODES-1; i >= 0; node++, i--) {
+		if (!node->handler) {
+			memset(node, 0, sizeof(*node));
 			return node;
+		}
+	}
 
 	printk ("new_irq_node: out of nodes\n");
 	return NULL;
@@ -149,55 +156,115 @@ void free_irq(unsigned int irq, void *de
 
 EXPORT_SYMBOL(free_irq);
 
-int cpu_request_irq(unsigned int irq,
-                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
+int setup_irq(unsigned int irq, struct irq_node *node)
 {
-	if (irq < IRQ_AUTO_1 || irq > IRQ_AUTO_7) {
+	struct irq_controller *contr;
+	struct irq_node **prev;
+	unsigned long flags;
+
+	if (irq >= SYS_IRQS || !(contr = irq_controller[irq])) {
 		printk("%s: Incorrect IRQ %d from %s\n",
-		       __FUNCTION__, irq, devname);
+		       __FUNCTION__, irq, node->devname);
 		return -ENXIO;
 	}
 
-#if 0
-	if (!(irq_list[irq].flags & IRQ_FLG_STD)) {
-		if (irq_list[irq].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_list[irq].devname);
-			return -EBUSY;
-		}
-		if (!(flags & IRQ_FLG_REPLACE)) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_list[irq].devname);
+	spin_lock_irqsave(&contr->lock, flags);
+
+	prev = irq_list + irq;
+	if (*prev) {
+		/* Can't share interrupts unless both agree to */
+		if (!((*prev)->flags & node->flags & SA_SHIRQ)) {
+			spin_unlock_irqrestore(&contr->lock, flags);
 			return -EBUSY;
 		}
+		while (*prev)
+			prev = &(*prev)->next;
 	}
-#endif
 
-	irq_list[irq].handler = handler;
-	irq_list[irq].flags   = flags;
-	irq_list[irq].dev_id  = dev_id;
-	irq_list[irq].devname = devname;
+	if (!irq_list[irq]) {
+		if (contr->startup)
+			contr->startup(irq);
+		else
+			contr->enable(irq);
+	}
+	node->next = NULL;
+	*prev = node;
+
+	spin_unlock_irqrestore(&contr->lock, flags);
+
 	return 0;
 }
 
+int cpu_request_irq(unsigned int irq,
+                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
+                    unsigned long flags, const char *devname, void *dev_id)
+{
+	struct irq_node *node;
+	int res;
+
+	node = new_irq_node();
+	if (!node)
+		return -ENOMEM;
+
+	node->handler = handler;
+	node->flags   = flags;
+	node->dev_id  = dev_id;
+	node->devname = devname;
+
+	res = setup_irq(irq, node);
+	if (res)
+		node->handler = NULL;
+
+	return res;
+}
+
 void cpu_free_irq(unsigned int irq, void *dev_id)
 {
-	if (irq < IRQ_AUTO_1 || irq > IRQ_AUTO_7) {
+	struct irq_controller *contr;
+	struct irq_node **p, *node;
+	unsigned long flags;
+
+	if (irq >= SYS_IRQS || !(contr = irq_controller[irq])) {
 		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
 		return;
 	}
 
-	if (irq_list[irq].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_list[irq].devname);
+	spin_lock_irqsave(&contr->lock, flags);
+
+	p = irq_list + irq;
+	while ((node = *p)) {
+		if (node->dev_id == dev_id)
+			break;
+		p = &node->next;
+	}
+
+	if (node) {
+		*p = node->next;
+		node->handler = NULL;
+	} else
+		printk("%s: Removing probably wrong IRQ %d\n",
+		       __FUNCTION__, irq);
+
+	if (!irq_list[irq])
+		contr->shutdown(irq);
 
-	irq_list[irq].handler = (*mach_default_handler)[irq];
-	irq_list[irq].flags   = 0;
-	irq_list[irq].dev_id  = NULL;
-	irq_list[irq].devname = default_names[irq];
+	spin_unlock_irqrestore(&contr->lock, flags);
 }
 
+int m68k_irq_startup(unsigned int irq)
+{
+	if (irq <= IRQ_AUTO_7)
+		vectors[VEC_SPUR + irq] = auto_inthandler;
+	return 0;
+}
+
+void m68k_irq_shutdown(unsigned int irq)
+{
+	if (irq <= IRQ_AUTO_7)
+		vectors[VEC_SPUR + irq] = bad_inthandler;
+}
+
+
 /*
  * Do we need these probe functions on the m68k?
  *
@@ -250,8 +317,14 @@ static void dummy_free_irq(unsigned int 
 
 asmlinkage void m68k_handle_int(unsigned int irq, struct pt_regs *regs)
 {
+	struct irq_node *node;
+
 	kstat_cpu(0).irqs[irq]++;
-	irq_list[irq].handler(irq, irq_list[irq].dev_id, regs);
+	node = irq_list[irq];
+	do {
+		node->handler(irq, node->dev_id, regs);
+		node = node->next;
+	} while (node);
 }
 
 asmlinkage void handle_badint(struct pt_regs *regs)
@@ -262,16 +335,18 @@ asmlinkage void handle_badint(struct pt_
 
 int show_interrupts(struct seq_file *p, void *v)
 {
+	struct irq_controller *contr;
+	struct irq_node *node;
 	int i = *(loff_t *) v;
 
 	/* autovector interrupts */
-	if (i < SYS_IRQS) {
-		if (mach_default_handler) {
-			seq_printf(p, "auto %2d: %10u ", i,
-			               i ? kstat_cpu(0).irqs[i] : num_spurious);
-			seq_puts(p, "  ");
-			seq_printf(p, "%s\n", irq_list[i].devname);
-		}
+	if (i < SYS_IRQS && irq_list[i]) {
+		contr = irq_controller[i];
+		node = irq_list[i];
+		seq_printf(p, "%s %u: %10u %s", contr->name, i, kstat_cpu(0).irqs[i], node->devname);
+		while ((node = node->next))
+			seq_printf(p, ", %s", node->devname);
+		seq_puts(p, "\n");
 	} else if (i == SYS_IRQS)
 		mach_get_irq_list(p, v);
 	return 0;
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 19dce75..7e04f2a 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -94,20 +94,6 @@ static void mac_sched_init(irqreturn_t (
 	via_init_clock(vector);
 }
 
-extern irqreturn_t mac_default_handler(int, void *, struct pt_regs *);
-
-irqreturn_t (*mac_handlers[8])(int, void *, struct pt_regs *)=
-{
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler,
-	mac_default_handler
-};
-
 /*
  * Parse a Macintosh-specific record in the bootinfo
  */
@@ -188,7 +174,6 @@ void __init config_mac(void)
 	enable_irq           = mac_enable_irq;
 	disable_irq          = mac_disable_irq;
 	mach_get_model	 = mac_get_model;
-	mach_default_handler = &mac_handlers;
 	mach_get_irq_list    = show_mac_interrupts;
 	mach_gettimeoffset   = mac_gettimeoffset;
 #warning move to adb/via init
diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
index 7a1600b..73b39cd 100644
--- a/arch/m68k/mac/macints.c
+++ b/arch/m68k/mac/macints.c
@@ -637,13 +637,6 @@ int show_mac_interrupts(struct seq_file 
 	return 0;
 }
 
-void mac_default_handler(int irq, void *dev_id, struct pt_regs *regs)
-{
-#ifdef DEBUG_SPURIOUS
-	printk("Unexpected IRQ %d on device %p\n", irq, dev_id);
-#endif
-}
-
 static int num_debug[8];
 
 irqreturn_t mac_debug_handler(int irq, void *dev_id, struct pt_regs *regs)
diff --git a/arch/m68k/mvme147/147ints.c b/arch/m68k/mvme147/147ints.c
index 69a744e..b4aa5e8 100644
--- a/arch/m68k/mvme147/147ints.c
+++ b/arch/m68k/mvme147/147ints.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/m68k/mvme16x/16xints.c b/arch/m68k/mvme16x/16xints.c
index 793ef73..81afada 100644
--- a/arch/m68k/mvme16x/16xints.c
+++ b/arch/m68k/mvme16x/16xints.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/seq_file.h>
 
 #include <asm/system.h>
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 5e0f9b0..01fd662 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -37,7 +37,6 @@ #include <asm/machdep.h>
 #include <asm/q40_master.h>
 
 extern irqreturn_t q40_process_int (int level, struct pt_regs *regs);
-extern irqreturn_t (*q40_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
 extern void q40_free_irq (unsigned int, void *);
 extern int  show_q40_interrupts (struct seq_file *, void *);
@@ -181,7 +180,6 @@ void __init config_q40(void)
     mach_request_irq	 = q40_request_irq;
     enable_irq		 = q40_enable_irq;
     disable_irq          = q40_disable_irq;
-    mach_default_handler = &q40_default_handler;
     mach_get_model       = q40_get_model;
     mach_get_hardware_list = q40_get_hardware_list;
 
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index b106839..ff80cba 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -46,7 +46,6 @@ irqreturn_t q40_irq2_handler (int, void 
 
 
 static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp);
-static irqreturn_t default_handler(int lev, void *dev_id, struct pt_regs *regs);
 
 
 #define DEVNAME_SIZE 24
@@ -415,22 +414,6 @@ static irqreturn_t q40_defhand (int irq,
 	else master_outb(-1,KEYBOARD_UNLOCK_REG);
 	return IRQ_NONE;
 }
-static irqreturn_t default_handler(int lev, void *dev_id, struct pt_regs *regs)
-{
-	printk ("Uninitialised interrupt level %d\n", lev);
-	return IRQ_NONE;
-}
-
-irqreturn_t (*q40_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	 [0] = default_handler,
-	 [1] = default_handler,
-	 [2] = default_handler,
-	 [3] = default_handler,
-	 [4] = default_handler,
-	 [5] = default_handler,
-	 [6] = default_handler,
-	 [7] = default_handler
-};
 
 
 void q40_enable_irq (unsigned int irq)
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 2a8af68..2641597 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -64,6 +64,7 @@ #include <linux/amifd.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
+#include <linux/interrupt.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
diff --git a/include/asm-m68k/atari_stdma.h b/include/asm-m68k/atari_stdma.h
index 64f9288..b4eadf8 100644
--- a/include/asm-m68k/atari_stdma.h
+++ b/include/asm-m68k/atari_stdma.h
@@ -3,7 +3,7 @@ #ifndef _atari_stdma_h
 #define _atari_stdma_h
 
 
-#include <asm/irq.h>
+#include <linux/interrupt.h>
 
 
 /***************************** Prototypes *****************************/
diff --git a/include/asm-m68k/irq.h b/include/asm-m68k/irq.h
index 320a084..7fa8733 100644
--- a/include/asm-m68k/irq.h
+++ b/include/asm-m68k/irq.h
@@ -1,7 +1,8 @@
 #ifndef _M68K_IRQ_H_
 #define _M68K_IRQ_H_
 
-#include <linux/interrupt.h>
+#include <linux/hardirq.h>
+#include <linux/spinlock_types.h>
 
 /*
  * # of m68k auto vector interrupts
@@ -81,7 +82,7 @@ #define disable_irq_nosync	disable_irq
 struct pt_regs;
 
 extern int cpu_request_irq(unsigned int,
-			   irqreturn_t (*)(int, void *, struct pt_regs *),
+			   int (*)(int, void *, struct pt_regs *),
 			   unsigned long, const char *, void *);
 extern void cpu_free_irq(unsigned int, void *);
 
@@ -103,23 +104,35 @@ #endif
  * interrupt source (if it supports chaining).
  */
 typedef struct irq_node {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
-	unsigned long	flags;
+	int		(*handler)(int, void *, struct pt_regs *);
 	void		*dev_id;
-	const char	*devname;
 	struct irq_node *next;
+	unsigned long	flags;
+	const char	*devname;
 } irq_node_t;
 
 /*
  * This structure has only 4 elements for speed reasons
  */
 typedef struct irq_handler {
-	irqreturn_t	(*handler)(int, void *, struct pt_regs *);
+	int		(*handler)(int, void *, struct pt_regs *);
 	unsigned long	flags;
 	void		*dev_id;
 	const char	*devname;
 } irq_handler_t;
 
+struct irq_controller {
+	const char *name;
+	spinlock_t lock;
+	int (*startup)(unsigned int irq);
+	void (*shutdown)(unsigned int irq);
+	void (*enable)(unsigned int irq);
+	void (*disable)(unsigned int irq);
+};
+
+extern int m68k_irq_startup(unsigned int);
+extern void m68k_irq_shutdown(unsigned int);
+
 /* count of spurious interrupts */
 extern volatile unsigned int num_spurious;
 
-- 
1.3.3

--

