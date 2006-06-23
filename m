Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWFWSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWFWSmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWFWSmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19407 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751924AbWFWSmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:03 -0400
Message-Id: <20060623183916.359410000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:16 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] convert sun3 irq code
Content-Disposition: inline; filename=0026-M68K-convert-sun3-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/sun3/config.c     |    8 --
 arch/m68k/sun3/sun3ints.c   |  208 ++++++-------------------------------------
 arch/m68k/sun3x/config.c    |    7 -
 include/asm-m68k/sun3ints.h |   22 +----
 4 files changed, 32 insertions(+), 213 deletions(-)

34f1711015076d8df22cc1d463ece08c377f0806
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index f1ca0df..553c304 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -36,7 +36,6 @@ extern char _text, _end;
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
 extern unsigned long sun3_gettimeoffset(void);
-extern int show_sun3_interrupts (struct seq_file *, void *);
 extern void sun3_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
 extern void sun3_get_model (char* model);
 extern void idprom_init (void);
@@ -147,13 +146,6 @@ void __init config_sun3(void)
 
         mach_sched_init      =  sun3_sched_init;
         mach_init_IRQ        =  sun3_init_IRQ;
-        mach_default_handler = &sun3_default_handler;
-        mach_request_irq     =  sun3_request_irq;
-        mach_free_irq        =  sun3_free_irq;
-	enable_irq	     =  sun3_enable_irq;
-        disable_irq	     =  sun3_disable_irq;
-	mach_process_int     =  sun3_process_int;
-        mach_get_irq_list    =  show_sun3_interrupts;
         mach_reset           =  sun3_reboot;
 	mach_gettimeoffset   =  sun3_gettimeoffset;
 	mach_get_model	     =  sun3_get_model;
diff --git a/arch/m68k/sun3/sun3ints.c b/arch/m68k/sun3/sun3ints.c
index e62a033..0912435 100644
--- a/arch/m68k/sun3/sun3ints.c
+++ b/arch/m68k/sun3/sun3ints.c
@@ -19,7 +19,6 @@ #include <asm/sun3ints.h>
 #include <linux/seq_file.h>
 
 extern void sun3_leds (unsigned char);
-static irqreturn_t sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp);
 
 void sun3_disable_interrupts(void)
 {
@@ -40,48 +39,30 @@ int led_pattern[8] = {
 
 volatile unsigned char* sun3_intreg;
 
-void sun3_insert_irq(irq_node_t **list, irq_node_t *node)
-{
-}
-
-void sun3_delete_irq(irq_node_t **list, void *dev_id)
-{
-}
-
 void sun3_enable_irq(unsigned int irq)
 {
-	*sun3_intreg |=  (1<<irq);
+	*sun3_intreg |=  (1 << irq);
 }
 
 void sun3_disable_irq(unsigned int irq)
 {
-	*sun3_intreg &= ~(1<<irq);
-}
-
-inline void sun3_do_irq(int irq, struct pt_regs *fp)
-{
-	kstat_cpu(0).irqs[SYS_IRQS + irq]++;
-	*sun3_intreg &= ~(1<<irq);
-	*sun3_intreg |=  (1<<irq);
+	*sun3_intreg &= ~(1 << irq);
 }
 
 static irqreturn_t sun3_int7(int irq, void *dev_id, struct pt_regs *fp)
 {
-	sun3_do_irq(irq,fp);
-	if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 2000))
-		sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%16000)
-			  /2000]);
+	*sun3_intreg |=  (1 << irq);
+	if (!(kstat_cpu(0).irqs[irq] % 2000))
+		sun3_leds(led_pattern[(kstat_cpu(0).irqs[irq] % 16000) / 2000]);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t sun3_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
-        kstat_cpu(0).irqs[SYS_IRQS + irq]++;
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
-        *sun3_intreg &= ~(1<<irq);
-        *sun3_intreg |=  (1<<irq);
+        *sun3_intreg |=  (1 << irq);
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
@@ -89,65 +70,8 @@ #endif
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(fp));
 #endif
-        if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 20))
-                sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%160)
-                /20]);
-	return IRQ_HANDLED;
-}
-
-/* handle requested ints, excepting 5 and 7, which always do the same
-   thing */
-irqreturn_t (*sun3_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[0] = sun3_inthandle,
-	[1] = sun3_inthandle,
-	[2] = sun3_inthandle,
-	[3] = sun3_inthandle,
-	[4] = sun3_inthandle,
-	[5] = sun3_int5,
-	[6] = sun3_inthandle,
-	[7] = sun3_int7
-};
-
-static const char *dev_names[SYS_IRQS] = {
-	[5] = "timer",
-	[7] = "int7 handler"
-};
-static void *dev_ids[SYS_IRQS];
-static irqreturn_t (*sun3_inthandler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[5] = sun3_int5,
-	[7] = sun3_int7
-};
-static irqreturn_t (*sun3_vechandler[SUN3_INT_VECS])(int, void *, struct pt_regs *);
-static void *vec_ids[SUN3_INT_VECS];
-static const char *vec_names[SUN3_INT_VECS];
-static int vec_ints[SUN3_INT_VECS];
-
-
-int show_sun3_interrupts(struct seq_file *p, void *v)
-{
-	int i;
-
-	for(i = 0; i < (SUN3_INT_VECS-1); i++) {
-		if(sun3_vechandler[i] != NULL) {
-			seq_printf(p, "vec %3d: %10u %s\n", i+64,
-				   vec_ints[i],
-				   (vec_names[i]) ? vec_names[i] :
-				   "sun3_vechandler");
-		}
-	}
-
-	return 0;
-}
-
-static irqreturn_t sun3_inthandle(int irq, void *dev_id, struct pt_regs *fp)
-{
-	if(sun3_inthandler[irq] == NULL)
-		panic ("bad interrupt %d received (id %p)\n",irq, dev_id);
-
-        kstat_cpu(0).irqs[SYS_IRQS + irq]++;
-        *sun3_intreg &= ~(1<<irq);
-
-	sun3_inthandler[irq](irq, dev_ids[irq], fp);
+        if (!(kstat_cpu(0).irqs[irq] % 20))
+                sun3_leds(led_pattern[(kstat_cpu(0).irqs[irq] % 160) / 20]);
 	return IRQ_HANDLED;
 }
 
@@ -157,109 +81,31 @@ static irqreturn_t sun3_vec255(int irq, 
 	return IRQ_HANDLED;
 }
 
-void sun3_init_IRQ(void)
+static void sun3_inthandle(unsigned int irq, struct pt_regs *fp)
 {
-	int i;
-
-	*sun3_intreg = 1;
-
-	for(i = 0; i < SYS_IRQS; i++)
-	{
-		if(dev_names[i])
-			cpu_request_irq(i, sun3_default_handler[i], 0,
-					dev_names[i], NULL);
-	}
-
-	for(i = 0; i < 192; i++)
-		sun3_vechandler[i] = NULL;
-
-	sun3_vechandler[191] = sun3_vec255;
-}
-
-int sun3_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                      unsigned long flags, const char *devname, void *dev_id)
-{
-
-	if(irq < SYS_IRQS) {
-		if(sun3_inthandler[irq] != NULL) {
-			printk("sun3_request_irq: request for irq %d -- already taken!\n", irq);
-			return 1;
-		}
-
-		sun3_inthandler[irq] = handler;
-		dev_ids[irq] = dev_id;
-		dev_names[irq] = devname;
-
-		/* setting devname would be nice */
-		cpu_request_irq(irq, sun3_default_handler[irq], 0, devname,
-				NULL);
-
-		return 0;
-	} else {
-		if((irq >= 64) && (irq <= 255)) {
-		        int vec;
-
-			vec = irq - 64;
-			if(sun3_vechandler[vec] != NULL) {
-				printk("sun3_request_irq: request for vec %d -- already taken!\n", irq);
-				return 1;
-			}
-
-			sun3_vechandler[vec] = handler;
-			vec_ids[vec] = dev_id;
-			vec_names[vec] = devname;
-			vec_ints[vec] = 0;
-
-			return 0;
-		}
-	}
-
-	printk("sun3_request_irq: invalid irq %d\n", irq);
-	return 1;
+        *sun3_intreg &= ~(1 << irq);
 
+	m68k_handle_int(irq, fp);
 }
 
-void sun3_free_irq(unsigned int irq, void *dev_id)
-{
-
-	if(irq < SYS_IRQS) {
-		if(sun3_inthandler[irq] == NULL)
-			panic("sun3_free_int: attempt to free unused irq %d\n", irq);
-		if(dev_ids[irq] != dev_id)
-			panic("sun3_free_int: incorrect dev_id for irq %d\n", irq);
-
-		sun3_inthandler[irq] = NULL;
-		return;
-	} else if((irq >= 64) && (irq <= 255)) {
-		int vec;
-
-		vec = irq - 64;
-		if(sun3_vechandler[vec] == NULL)
-			panic("sun3_free_int: attempt to free unused vector %d\n", irq);
-		if(vec_ids[irq] != dev_id)
-			panic("sun3_free_int: incorrect dev_id for vec %d\n", irq);
-
-		sun3_vechandler[vec] = NULL;
-		return;
-	} else {
-		panic("sun3_free_irq: invalid irq %d\n", irq);
-	}
-}
+static struct irq_controller sun3_irq_controller = {
+	.name		= "sun3",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.startup	= m68k_irq_startup,
+	.shutdown	= m68k_irq_shutdown,
+	.enable		= sun3_enable_irq,
+	.disable	= sun3_disable_irq,
+};
 
-irqreturn_t sun3_process_int(int irq, struct pt_regs *regs)
+void sun3_init_IRQ(void)
 {
+	*sun3_intreg = 1;
 
-	if((irq >= 64) && (irq <= 255)) {
-		int vec;
-
-		vec = irq - 64;
-		if(sun3_vechandler[vec] == NULL)
-			panic ("bad interrupt vector %d received\n",irq);
+	m68k_setup_auto_interrupt(sun3_inthandle);
+	m68k_setup_irq_controller(&sun3_irq_controller, IRQ_AUTO_1, 7);
+	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
 
-		vec_ints[vec]++;
-		return sun3_vechandler[vec](irq, vec_ids[vec], regs);
-	} else {
-		panic("sun3_process_int: unable to handle interrupt vector %d\n",
-		      irq);
-	}
+	request_irq(IRQ_AUTO_5, sun3_int5, 0, "int5", NULL);
+	request_irq(IRQ_AUTO_7, sun3_int7, 0, "int7", NULL);
+	request_irq(IRQ_USER+127, sun3_vec255, 0, "vec255", NULL);
 }
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index 0920f5d..52fb174 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -52,17 +52,10 @@ void __init config_sun3x(void)
 
 	sun3x_prom_init();
 
-	mach_get_irq_list	 = show_sun3_interrupts;
 	mach_max_dma_address = 0xffffffff; /* we can DMA anywhere, whee */
 
-	mach_default_handler = &sun3_default_handler;
 	mach_sched_init      = sun3x_sched_init;
 	mach_init_IRQ        = sun3_init_IRQ;
-	enable_irq           = sun3_enable_irq;
-	disable_irq          = sun3_disable_irq;
-	mach_request_irq     = sun3_request_irq;
-	mach_free_irq        = sun3_free_irq;
-	mach_process_int     = sun3_process_int;
 
 	mach_gettimeoffset   = sun3x_gettimeoffset;
 	mach_reset           = sun3x_reboot;
diff --git a/include/asm-m68k/sun3ints.h b/include/asm-m68k/sun3ints.h
index bd038fc..de91fa0 100644
--- a/include/asm-m68k/sun3ints.h
+++ b/include/asm-m68k/sun3ints.h
@@ -12,37 +12,25 @@ #ifndef SUN3INTS_H
 #define SUN3INTS_H
 
 #include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-#include <linux/seq_file.h>
-#include <asm/segment.h>
 #include <asm/intersil.h>
 #include <asm/oplib.h>
+#include <asm/traps.h>
 
 #define SUN3_INT_VECS 192
 
 void sun3_enable_irq(unsigned int irq);
 void sun3_disable_irq(unsigned int irq);
-int sun3_request_irq(unsigned int irq,
-                     irqreturn_t (*handler)(int, void *, struct pt_regs *),
-                     unsigned long flags, const char *devname, void *dev_id
-		    );
 extern void sun3_init_IRQ (void);
-extern irqreturn_t (*sun3_default_handler[]) (int, void *, struct pt_regs *);
-extern void sun3_free_irq (unsigned int irq, void *dev_id);
 extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
-extern int show_sun3_interrupts(struct seq_file *, void *);
-extern irqreturn_t sun3_process_int(int, struct pt_regs *);
 extern volatile unsigned char* sun3_intreg;
 
 /* master list of VME vectors -- don't fuck with this */
-#define SUN3_VEC_FLOPPY 0x40
-#define SUN3_VEC_VMESCSI0 0x40
-#define SUN3_VEC_VMESCSI1 0x41
-#define SUN3_VEC_CG 0xA8
+#define SUN3_VEC_FLOPPY		(IRQ_USER+0)
+#define SUN3_VEC_VMESCSI0	(IRQ_USER+0)
+#define SUN3_VEC_VMESCSI1	(IRQ_USER+1)
+#define SUN3_VEC_CG		(IRQ_USER+104)
 
 
 #endif /* SUN3INTS_H */
-- 
1.3.3

--

