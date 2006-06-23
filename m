Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWFWSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWFWSmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWFWSmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20431 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751929AbWFWSmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:06 -0400
Message-Id: <20060623183913.765697000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:09 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] convert generic irq code to irq controller
Content-Disposition: inline; filename=0019-M68K-convert-generic-irq-code-to-irq-controller.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic irq code to use irq controller, this gets rid of the
machine specific callbacks and gives better control over irq handling
without duplicating lots of code.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/entry.S      |   11 +-
 arch/m68k/kernel/ints.c       |  240 ++++++++++++++++++++++++++---------------
 arch/m68k/kernel/m68k_ksyms.c |    2 
 arch/m68k/kernel/setup.c      |    3 -
 arch/m68k/kernel/traps.c      |    7 +
 include/asm-m68k/irq.h        |   65 ++++-------
 include/asm-m68k/machdep.h    |    6 -
 include/asm-m68k/traps.h      |    2 
 8 files changed, 188 insertions(+), 148 deletions(-)

58f615bf9135a7bc00999b29deffd0c5f9cc971b
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 1fb88f3..48cccc5 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -48,6 +48,8 @@ #include <asm/asm-offsets.h>
 .globl sys_call_table
 .globl sys_fork, sys_clone, sys_vfork
 .globl ret_from_interrupt, bad_interrupt
+.globl auto_irqhandler_fixup
+.globl user_irqvec_fixup, user_irqhandler_fixup
 
 .text
 ENTRY(buserr)
@@ -212,6 +214,7 @@ #if defined(MACH_Q40_ONLY) && defined(CO
 	jbra	3f
 1:
 #endif
+auto_irqhandler_fixup = . + 2
 	jsr	m68k_handle_int		|  process the IRQ
 3:	addql	#8,%sp			|  pop parameters off stack
 
@@ -234,17 +237,19 @@ ret_from_last_interrupt:
 
 /* Handler for user defined interrupt vectors */
 
-ENTRY(mach_inthandler)
+ENTRY(user_inthandler)
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 					|  put exception # in d0
 	bfextu	%sp@(PT_VECTOR){#4,#10},%d0
+user_irqvec_fixup = . + 2
+	subw	#VEC_USER,%d0
 
 	movel	%sp,%sp@-
 	movel	%d0,%sp@-		|  put vector # on stack
-	movel	mach_process_int,%a0
-	jsr	%a0@			|  process the IRQ
+user_irqhandler_fixup = . + 2
+	jsr	m68k_handle_int		|  process the IRQ
 	addql	#8,%sp			|  pop parameters off stack
 
 	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
diff --git a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
index c7f6ee6..5a8344b 100644
--- a/arch/m68k/kernel/ints.c
+++ b/arch/m68k/kernel/ints.c
@@ -39,14 +39,22 @@ #include <asm/irq.h>
 #include <asm/traps.h>
 #include <asm/page.h>
 #include <asm/machdep.h>
+#include <asm/cacheflush.h>
 
 #ifdef CONFIG_Q40
 #include <asm/q40ints.h>
 #endif
 
+extern u32 auto_irqhandler_fixup[];
+extern u32 user_irqhandler_fixup[];
+extern u16 user_irqvec_fixup[];
+
 /* table for system interrupt handlers */
-static struct irq_node *irq_list[SYS_IRQS];
-static struct irq_controller *irq_controller[SYS_IRQS];
+static struct irq_node *irq_list[NR_IRQS];
+static struct irq_controller *irq_controller[NR_IRQS];
+static int irq_depth[NR_IRQS];
+
+static int m68k_first_user_vec;
 
 static struct irq_controller auto_irq_controller = {
 	.name		= "auto",
@@ -55,39 +63,16 @@ static struct irq_controller auto_irq_co
 	.shutdown	= m68k_irq_shutdown,
 };
 
-static const char *default_names[SYS_IRQS] = {
-	[0] = "spurious int",
-	[1] = "int1 handler",
-	[2] = "int2 handler",
-	[3] = "int3 handler",
-	[4] = "int4 handler",
-	[5] = "int5 handler",
-	[6] = "int6 handler",
-	[7] = "int7 handler"
+static struct irq_controller user_irq_controller = {
+	.name		= "user",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.startup	= m68k_irq_startup,
+	.shutdown	= m68k_irq_shutdown,
 };
 
-/* The number of spurious interrupts */
-volatile unsigned int num_spurious;
-
 #define NUM_IRQ_NODES 100
 static irq_node_t nodes[NUM_IRQ_NODES];
 
-static void dummy_enable_irq(unsigned int irq);
-static void dummy_disable_irq(unsigned int irq);
-static int dummy_request_irq(unsigned int irq,
-		irqreturn_t (*handler) (int, void *, struct pt_regs *),
-		unsigned long flags, const char *devname, void *dev_id);
-static void dummy_free_irq(unsigned int irq, void *dev_id);
-
-void (*enable_irq) (unsigned int) = dummy_enable_irq;
-void (*disable_irq) (unsigned int) = dummy_disable_irq;
-
-int (*mach_request_irq) (unsigned int, irqreturn_t (*)(int, void *, struct pt_regs *),
-                      unsigned long, const char *, void *) = dummy_request_irq;
-void (*mach_free_irq) (unsigned int, void *) = dummy_free_irq;
-
-void init_irq_proc(void);
-
 /*
  * void init_IRQ(void)
  *
@@ -109,14 +94,70 @@ void __init init_IRQ(void)
 		hardirq_mask_is_broken();
 	}
 
-	for (i = IRQ_AUTO_1; i <= IRQ_AUTO_7; i++) {
+	for (i = IRQ_AUTO_1; i <= IRQ_AUTO_7; i++)
 		irq_controller[i] = &auto_irq_controller;
-		if (mach_default_handler && (*mach_default_handler)[i])
-			cpu_request_irq(i, (*mach_default_handler)[i],
-					0, default_names[i], NULL);
-	}
 
-	mach_init_IRQ ();
+	mach_init_IRQ();
+}
+
+/**
+ * m68k_setup_auto_interrupt
+ * @handler: called from auto vector interrupts
+ *
+ * setup the handler to be called from auto vector interrupts instead of the
+ * standard m68k_handle_int(), it will be called with irq numbers in the range
+ * from IRQ_AUTO_1 - IRQ_AUTO_7.
+ */
+void __init m68k_setup_auto_interrupt(void (*handler)(unsigned int, struct pt_regs *))
+{
+	if (handler)
+		*auto_irqhandler_fixup = (u32)handler;
+	flush_icache();
+}
+
+/**
+ * m68k_setup_user_interrupt
+ * @vec: first user vector interrupt to handle
+ * @cnt: number of active user vector interrupts
+ * @handler: called from user vector interrupts
+ *
+ * setup user vector interrupts, this includes activating the specified range
+ * of interrupts, only then these interrupts can be requested (note: this is
+ * different from auto vector interrupts). An optional handler can be installed
+ * to be called instead of the default m68k_handle_int(), it will be called
+ * with irq numbers starting from IRQ_USER.
+ */
+void __init m68k_setup_user_interrupt(unsigned int vec, unsigned int cnt,
+				      void (*handler)(unsigned int, struct pt_regs *))
+{
+	int i;
+
+	m68k_first_user_vec = vec;
+	for (i = 0; i < cnt; i++)
+		irq_controller[IRQ_USER + i] = &user_irq_controller;
+	*user_irqvec_fixup = vec - IRQ_USER;
+	if (handler)
+		*user_irqhandler_fixup = (u32)handler;
+	flush_icache();
+}
+
+/**
+ * m68k_setup_irq_controller
+ * @contr: irq controller which controls specified irq
+ * @irq: first irq to be managed by the controller
+ *
+ * Change the controller for the specified range of irq, which will be used to
+ * manage these irq. auto/user irq already have a default controller, which can
+ * be changed as well, but the controller probably should use m68k_irq_startup/
+ * m68k_irq_shutdown.
+ */
+void m68k_setup_irq_controller(struct irq_controller *contr, unsigned int irq,
+			       unsigned int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++)
+		irq_controller[irq + i] = contr;
 }
 
 irq_node_t *new_irq_node(void)
@@ -135,34 +176,13 @@ irq_node_t *new_irq_node(void)
 	return NULL;
 }
 
-/*
- * We will keep these functions until I have convinced Linus to move
- * the declaration of them from include/linux/sched.h to
- * include/asm/irq.h.
- */
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler) (int, void *, struct pt_regs *),
-		unsigned long flags, const char *devname, void *dev_id)
-{
-	return mach_request_irq(irq, handler, flags, devname, dev_id);
-}
-
-EXPORT_SYMBOL(request_irq);
-
-void free_irq(unsigned int irq, void *dev_id)
-{
-	mach_free_irq(irq, dev_id);
-}
-
-EXPORT_SYMBOL(free_irq);
-
 int setup_irq(unsigned int irq, struct irq_node *node)
 {
 	struct irq_controller *contr;
 	struct irq_node **prev;
 	unsigned long flags;
 
-	if (irq >= SYS_IRQS || !(contr = irq_controller[irq])) {
+	if (irq >= NR_IRQS || !(contr = irq_controller[irq])) {
 		printk("%s: Incorrect IRQ %d from %s\n",
 		       __FUNCTION__, irq, node->devname);
 		return -ENXIO;
@@ -195,9 +215,9 @@ int setup_irq(unsigned int irq, struct i
 	return 0;
 }
 
-int cpu_request_irq(unsigned int irq,
-                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
+int request_irq(unsigned int irq,
+		irqreturn_t (*handler) (int, void *, struct pt_regs *),
+		unsigned long flags, const char *devname, void *dev_id)
 {
 	struct irq_node *node;
 	int res;
@@ -218,13 +238,15 @@ int cpu_request_irq(unsigned int irq,
 	return res;
 }
 
-void cpu_free_irq(unsigned int irq, void *dev_id)
+EXPORT_SYMBOL(request_irq);
+
+void free_irq(unsigned int irq, void *dev_id)
 {
 	struct irq_controller *contr;
 	struct irq_node **p, *node;
 	unsigned long flags;
 
-	if (irq >= SYS_IRQS || !(contr = irq_controller[irq])) {
+	if (irq >= NR_IRQS || !(contr = irq_controller[irq])) {
 		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
 		return;
 	}
@@ -245,16 +267,69 @@ void cpu_free_irq(unsigned int irq, void
 		printk("%s: Removing probably wrong IRQ %d\n",
 		       __FUNCTION__, irq);
 
-	if (!irq_list[irq])
-		contr->shutdown(irq);
+	if (!irq_list[irq]) {
+		if (contr->shutdown)
+			contr->shutdown(irq);
+		else
+			contr->disable(irq);
+	}
+
+	spin_unlock_irqrestore(&contr->lock, flags);
+}
+
+EXPORT_SYMBOL(free_irq);
+
+void enable_irq(unsigned int irq)
+{
+	struct irq_controller *contr;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS || !(contr = irq_controller[irq])) {
+		printk("%s: Incorrect IRQ %d\n",
+		       __FUNCTION__, irq);
+		return;
+	}
+
+	spin_lock_irqsave(&contr->lock, flags);
+	if (irq_depth[irq]) {
+		if (!--irq_depth[irq]) {
+			if (contr->enable)
+				contr->enable(irq);
+		}
+	} else
+		WARN_ON(1);
+	spin_unlock_irqrestore(&contr->lock, flags);
+}
+
+EXPORT_SYMBOL(enable_irq);
 
+void disable_irq(unsigned int irq)
+{
+	struct irq_controller *contr;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS || !(contr = irq_controller[irq])) {
+		printk("%s: Incorrect IRQ %d\n",
+		       __FUNCTION__, irq);
+		return;
+	}
+
+	spin_lock_irqsave(&contr->lock, flags);
+	if (!irq_depth[irq]++) {
+		if (contr->disable)
+			contr->disable(irq);
+	}
 	spin_unlock_irqrestore(&contr->lock, flags);
 }
 
+EXPORT_SYMBOL(disable_irq);
+
 int m68k_irq_startup(unsigned int irq)
 {
 	if (irq <= IRQ_AUTO_7)
 		vectors[VEC_SPUR + irq] = auto_inthandler;
+	else
+		vectors[m68k_first_user_vec + irq - IRQ_USER] = user_inthandler;
 	return 0;
 }
 
@@ -262,6 +337,8 @@ void m68k_irq_shutdown(unsigned int irq)
 {
 	if (irq <= IRQ_AUTO_7)
 		vectors[VEC_SPUR + irq] = bad_inthandler;
+	else
+		vectors[m68k_first_user_vec + irq - IRQ_USER] = bad_inthandler;
 }
 
 
@@ -292,28 +369,16 @@ #endif
 
 EXPORT_SYMBOL(probe_irq_off);
 
-static void dummy_enable_irq(unsigned int irq)
+unsigned int irq_canonicalize(unsigned int irq)
 {
-	printk("calling uninitialized enable_irq()\n");
-}
-
-static void dummy_disable_irq(unsigned int irq)
-{
-	printk("calling uninitialized disable_irq()\n");
-}
-
-static int dummy_request_irq(unsigned int irq,
-		irqreturn_t (*handler) (int, void *, struct pt_regs *),
-		unsigned long flags, const char *devname, void *dev_id)
-{
-	printk("calling uninitialized request_irq()\n");
-	return 0;
+#ifdef CONFIG_Q40
+	if (MACH_IS_Q40 && irq == 11)
+		irq = 10;
+#endif
+	return irq;
 }
 
-static void dummy_free_irq(unsigned int irq, void *dev_id)
-{
-	printk("calling uninitialized disable_irq()\n");
-}
+EXPORT_SYMBOL(irq_canonicalize);
 
 asmlinkage void m68k_handle_int(unsigned int irq, struct pt_regs *regs)
 {
@@ -340,15 +405,14 @@ int show_interrupts(struct seq_file *p, 
 	int i = *(loff_t *) v;
 
 	/* autovector interrupts */
-	if (i < SYS_IRQS && irq_list[i]) {
+	if (irq_list[i]) {
 		contr = irq_controller[i];
 		node = irq_list[i];
-		seq_printf(p, "%s %u: %10u %s", contr->name, i, kstat_cpu(0).irqs[i], node->devname);
+		seq_printf(p, "%-8s %3u: %10u %s", contr->name, i, kstat_cpu(0).irqs[i], node->devname);
 		while ((node = node->next))
 			seq_printf(p, ", %s", node->devname);
 		seq_puts(p, "\n");
-	} else if (i == SYS_IRQS)
-		mach_get_irq_list(p, v);
+	}
 	return 0;
 }
 
diff --git a/arch/m68k/kernel/m68k_ksyms.c b/arch/m68k/kernel/m68k_ksyms.c
index 5b7952e..1f5e1b5 100644
--- a/arch/m68k/kernel/m68k_ksyms.c
+++ b/arch/m68k/kernel/m68k_ksyms.c
@@ -57,8 +57,6 @@ EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(kernel_thread);
 #ifdef CONFIG_VME
 EXPORT_SYMBOL(vme_brdtype);
diff --git a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
index 750d5b3..214a95f 100644
--- a/arch/m68k/kernel/setup.c
+++ b/arch/m68k/kernel/setup.c
@@ -68,11 +68,8 @@ char m68k_debug_device[6] = "";
 void (*mach_sched_init) (irqreturn_t (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void) __initdata = NULL;
-irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
 void (*mach_get_model) (char *model);
 int (*mach_get_hardware_list) (char *buffer);
-int (*mach_get_irq_list) (struct seq_file *, void *);
-irqreturn_t (*mach_process_int) (int, struct pt_regs *);
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
 int (*mach_hwclk) (int, struct rtc_time*);
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index b19b951..e86de7b 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -87,16 +87,15 @@ void __init trap_init (void)
 {
 	int i;
 
-	vectors[VEC_SPUR] = bad_inthandler;
-	for (i = VEC_INT1; i <= VEC_INT7; i++)
-		vectors[i] = auto_inthandler;
+	for (i = VEC_SPUR; i <= VEC_INT7; i++)
+		vectors[i] = bad_inthandler;
 
 	for (i = 0; i < VEC_USER; i++)
 		if (!vectors[i])
 			vectors[i] = trap;
 
 	for (i = VEC_USER; i < 256; i++)
-		vectors[i] = mach_inthandler;
+		vectors[i] = bad_inthandler;
 
 #ifdef CONFIG_M68KFPU_EMU
 	if (FPU_IS_EMU)
diff --git a/include/asm-m68k/irq.h b/include/asm-m68k/irq.h
index 7fa8733..f4ae7d8 100644
--- a/include/asm-m68k/irq.h
+++ b/include/asm-m68k/irq.h
@@ -1,25 +1,30 @@
 #ifndef _M68K_IRQ_H_
 #define _M68K_IRQ_H_
 
+#include <linux/linkage.h>
 #include <linux/hardirq.h>
 #include <linux/spinlock_types.h>
 
 /*
- * # of m68k auto vector interrupts
- */
-
-#define SYS_IRQS 8
-
-/*
  * This should be the same as the max(NUM_X_SOURCES) for all the
  * different m68k hosts compiled into the kernel.
  * Currently the Atari has 72 and the Amiga 24, but if both are
  * supported in the kernel it is better to make room for 72.
  */
-#if defined(CONFIG_ATARI) || defined(CONFIG_MAC)
-#define NR_IRQS (72+SYS_IRQS)
+#if defined(CONFIG_VME) || defined(CONFIG_SUN3) || defined(CONFIG_SUN3X)
+#define NR_IRQS 200
+#elif defined(CONFIG_ATARI) || defined(CONFIG_MAC)
+#define NR_IRQS 72
+#elif defined(CONFIG_Q40)
+#define NR_IRQS	43
+#elif defined(CONFIG_AMIGA)
+#define NR_IRQS	32
+#elif defined(CONFIG_APOLLO)
+#define NR_IRQS	24
+#elif defined(CONFIG_HP300)
+#define NR_IRQS	8
 #else
-#define NR_IRQS (24+SYS_IRQS)
+#error unknown nr of irqs
 #endif
 
 /*
@@ -53,39 +58,13 @@ #define IRQ_AUTO_7	7	/* level 7 interrup
 
 #define IRQ_USER	8
 
-static __inline__ int irq_canonicalize(int irq)
-{
-	return irq;
-}
-
-/*
- * Machine specific interrupt sources.
- *
- * Adding an interrupt service routine for a source with this bit
- * set indicates a special machine specific interrupt source.
- * The machine specific files define these sources.
- *
- * The IRQ_MACHSPEC bit is now gone - the only thing it did was to
- * introduce unnecessary overhead.
- *
- * All interrupt handling is actually machine specific so it is better
- * to use function pointers, as used by the Sparc port, and select the
- * interrupt handling functions when initializing the kernel. This way
- * we save some unnecessary overhead at run-time.
- *                                                      01/11/97 - Jes
- */
-
-extern void (*enable_irq)(unsigned int);
-extern void (*disable_irq)(unsigned int);
+extern unsigned int irq_canonicalize(unsigned int irq);
+extern void enable_irq(unsigned int);
+extern void disable_irq(unsigned int);
 #define disable_irq_nosync	disable_irq
 
 struct pt_regs;
 
-extern int cpu_request_irq(unsigned int,
-			   int (*)(int, void *, struct pt_regs *),
-			   unsigned long, const char *, void *);
-extern void cpu_free_irq(unsigned int, void *);
-
 /*
  * various flags for request_irq() - the Amiga now uses the standard
  * mechanism like all other architectures - SA_INTERRUPT and SA_SHIRQ
@@ -133,12 +112,16 @@ struct irq_controller {
 extern int m68k_irq_startup(unsigned int);
 extern void m68k_irq_shutdown(unsigned int);
 
-/* count of spurious interrupts */
-extern volatile unsigned int num_spurious;
-
 /*
  * This function returns a new irq_node_t
  */
 extern irq_node_t *new_irq_node(void);
 
+extern void m68k_setup_auto_interrupt(void (*handler)(unsigned int, struct pt_regs *));
+extern void m68k_setup_user_interrupt(unsigned int vec, unsigned int cnt,
+				      void (*handler)(unsigned int, struct pt_regs *));
+extern void m68k_setup_irq_controller(struct irq_controller *, unsigned int, unsigned int);
+
+asmlinkage void m68k_handle_int(unsigned int, struct pt_regs *);
+
 #endif /* _M68K_IRQ_H_ */
diff --git a/include/asm-m68k/machdep.h b/include/asm-m68k/machdep.h
index 7d3fee3..df898f2 100644
--- a/include/asm-m68k/machdep.h
+++ b/include/asm-m68k/machdep.h
@@ -13,14 +13,8 @@ struct buffer_head;
 extern void (*mach_sched_init) (irqreturn_t (*handler)(int, void *, struct pt_regs *));
 /* machine dependent irq functions */
 extern void (*mach_init_IRQ) (void);
-extern irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
-extern int (*mach_request_irq) (unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                                unsigned long flags, const char *devname, void *dev_id);
-extern void (*mach_free_irq) (unsigned int irq, void *dev_id);
 extern void (*mach_get_model) (char *model);
 extern int (*mach_get_hardware_list) (char *buffer);
-extern int (*mach_get_irq_list) (struct seq_file *p, void *v);
-extern irqreturn_t (*mach_process_int) (int irq, struct pt_regs *fp);
 /* machine dependent timer functions */
 extern unsigned long (*mach_gettimeoffset)(void);
 extern int (*mach_hwclk)(int, struct rtc_time*);
diff --git a/include/asm-m68k/traps.h b/include/asm-m68k/traps.h
index 7715194..8caef25 100644
--- a/include/asm-m68k/traps.h
+++ b/include/asm-m68k/traps.h
@@ -19,7 +19,7 @@ #include <asm/ptrace.h>
 typedef void (*e_vector)(void);
 
 asmlinkage void auto_inthandler(void);
-asmlinkage void mach_inthandler(void);
+asmlinkage void user_inthandler(void);
 asmlinkage void bad_inthandler(void);
 
 extern e_vector vectors[];
-- 
1.3.3

--

