Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWFWSqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWFWSqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWFWSmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18127 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751920AbWFWSl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:59 -0400
Message-Id: <20060623183914.473905000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:11 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] convert apollo irq code
Content-Disposition: inline; filename=0021-M68K-convert-apollo-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/apollo/config.c   |   24 ++------
 arch/m68k/apollo/dn_ints.c  |  137 +++++++++----------------------------------
 include/asm-m68k/apollohw.h |    4 +
 3 files changed, 37 insertions(+), 128 deletions(-)

5627860f622a2c9a2c6a63c6cc76183c672f0322
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index d401962..99c7097 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -28,11 +28,6 @@ u_long apollo_model;
 
 extern void dn_sched_init(irqreturn_t (*handler)(int,void *,struct pt_regs *));
 extern void dn_init_IRQ(void);
-extern int dn_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
-extern void dn_free_irq(unsigned int irq, void *dev_id);
-extern void dn_enable_irq(unsigned int);
-extern void dn_disable_irq(unsigned int);
-extern int show_dn_interrupts(struct seq_file *, void *);
 extern unsigned long dn_gettimeoffset(void);
 extern int dn_dummy_hwclk(int, struct rtc_time *);
 extern int dn_dummy_set_clock_mmss(unsigned long);
@@ -40,13 +35,11 @@ extern void dn_dummy_reset(void);
 extern void dn_dummy_waitbut(void);
 extern struct fb_info *dn_fb_init(long *);
 extern void dn_dummy_debug_init(void);
-extern void dn_dummy_video_setup(char *,int *);
 extern irqreturn_t dn_process_int(int irq, struct pt_regs *fp);
 #ifdef CONFIG_HEARTBEAT
 static void dn_heartbeat(int on);
 #endif
 static irqreturn_t dn_timer_int(int irq,void *, struct pt_regs *);
-static irqreturn_t (*sched_timer_handler)(int, void *, struct pt_regs *)=NULL;
 static void dn_get_model(char *model);
 static const char *apollo_models[] = {
 	[APOLLO_DN3000-APOLLO_DN3000] = "DN3000 (Otter)",
@@ -164,17 +157,10 @@ void config_apollo(void) {
 
 	mach_sched_init=dn_sched_init; /* */
 	mach_init_IRQ=dn_init_IRQ;
-	mach_default_handler=NULL;
-	mach_request_irq     = dn_request_irq;
-	mach_free_irq        = dn_free_irq;
-	enable_irq      = dn_enable_irq;
-	disable_irq     = dn_disable_irq;
-	mach_get_irq_list    = show_dn_interrupts;
 	mach_gettimeoffset   = dn_gettimeoffset;
 	mach_max_dma_address = 0xffffffff;
 	mach_hwclk           = dn_dummy_hwclk; /* */
 	mach_set_clock_mmss  = dn_dummy_set_clock_mmss; /* */
-	mach_process_int     = dn_process_int;
 	mach_reset	     = dn_dummy_reset;  /* */
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat = dn_heartbeat;
@@ -189,11 +175,13 @@ #endif
 
 }
 
-irqreturn_t dn_timer_int(int irq, void *dev_id, struct pt_regs *fp) {
+irqreturn_t dn_timer_int(int irq, void *dev_id, struct pt_regs *fp)
+{
+	irqreturn_t (*timer_handler)(int, void *, struct pt_regs *) = dev_id;
 
 	volatile unsigned char x;
 
-	sched_timer_handler(irq,dev_id,fp);
+	timer_handler(irq, dev_id, fp);
 
 	x=*(volatile unsigned char *)(timer+3);
 	x=*(volatile unsigned char *)(timer+5);
@@ -217,9 +205,7 @@ #if 0
 	printk("*(0x10803) %02x\n",*(volatile unsigned char *)(timer+0x3));
 #endif
 
-	sched_timer_handler=timer_routine;
-	request_irq(0,dn_timer_int,0,NULL,NULL);
-
+	request_irq(IRQ_APOLLO, dn_timer_int, 0, "time", timer_routine);
 }
 
 unsigned long dn_gettimeoffset(void) {
diff --git a/arch/m68k/apollo/dn_ints.c b/arch/m68k/apollo/dn_ints.c
index a312593..9fe0780 100644
--- a/arch/m68k/apollo/dn_ints.c
+++ b/arch/m68k/apollo/dn_ints.c
@@ -1,125 +1,44 @@
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/kernel_stat.h>
-#include <linux/timer.h>
+#include <linux/interrupt.h>
 
-#include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/page.h>
-#include <asm/machdep.h>
 #include <asm/apollohw.h>
-#include <asm/errno.h>
 
-static irq_handler_t dn_irqs[16];
-
-irqreturn_t dn_process_int(int irq, struct pt_regs *fp)
+void dn_process_int(unsigned int irq, struct pt_regs *fp)
 {
-  irqreturn_t res = IRQ_NONE;
-
-  if(dn_irqs[irq-160].handler) {
-    res = dn_irqs[irq-160].handler(irq,dn_irqs[irq-160].dev_id,fp);
-  } else {
-    printk("spurious irq %d occurred\n",irq);
-  }
-
-  *(volatile unsigned char *)(pica)=0x20;
-  *(volatile unsigned char *)(picb)=0x20;
-
-  return res;
-}
-
-void dn_init_IRQ(void) {
-
-  int i;
-
-  for(i=0;i<16;i++) {
-    dn_irqs[i].handler=NULL;
-    dn_irqs[i].flags=IRQ_FLG_STD;
-    dn_irqs[i].dev_id=NULL;
-    dn_irqs[i].devname=NULL;
-  }
-
-}
-
-int dn_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id) {
-
-  if((irq<0) || (irq>15)) {
-    printk("Trying to request invalid IRQ\n");
-    return -ENXIO;
-  }
-
-  if(!dn_irqs[irq].handler) {
-    dn_irqs[irq].handler=handler;
-    dn_irqs[irq].flags=IRQ_FLG_STD;
-    dn_irqs[irq].dev_id=dev_id;
-    dn_irqs[irq].devname=devname;
-    if(irq<8)
-      *(volatile unsigned char *)(pica+1)&=~(1<<irq);
-    else
-      *(volatile unsigned char *)(picb+1)&=~(1<<(irq-8));
-
-    return 0;
-  }
-  else {
-    printk("Trying to request already assigned irq %d\n",irq);
-    return -ENXIO;
-  }
-
-}
-
-void dn_free_irq(unsigned int irq, void *dev_id) {
-
-  if((irq<0) || (irq>15)) {
-    printk("Trying to free invalid IRQ\n");
-    return ;
-  }
-
-  if(irq<8)
-    *(volatile unsigned char *)(pica+1)|=(1<<irq);
-  else
-    *(volatile unsigned char *)(picb+1)|=(1<<(irq-8));
-
-  dn_irqs[irq].handler=NULL;
-  dn_irqs[irq].flags=IRQ_FLG_STD;
-  dn_irqs[irq].dev_id=NULL;
-  dn_irqs[irq].devname=NULL;
-
-  return ;
-
-}
-
-void dn_enable_irq(unsigned int irq) {
-
-  printk("dn enable irq\n");
-
-}
-
-void dn_disable_irq(unsigned int irq) {
-
-  printk("dn disable irq\n");
+	m68k_handle_int(irq, fp);
 
+	*(volatile unsigned char *)(pica)=0x20;
+	*(volatile unsigned char *)(picb)=0x20;
 }
 
-int show_dn_interrupts(struct seq_file *p, void *v) {
-
-  printk("dn get irq list\n");
-
-  return 0;
-
+int apollo_irq_startup(unsigned int irq)
+{
+	if (irq < 8)
+		*(volatile unsigned char *)(pica+1) &= ~(1 << irq);
+	else
+		*(volatile unsigned char *)(picb+1) &= ~(1 << (irq - 8));
+	return 0;
 }
 
-struct fb_info *dn_dummy_fb_init(long *mem_start) {
-
-  printk("fb init\n");
-
-  return NULL;
-
+void apollo_irq_shutdown(unsigned int irq)
+{
+	if (irq < 8)
+		*(volatile unsigned char *)(pica+1) |= (1 << irq);
+	else
+		*(volatile unsigned char *)(picb+1) |= (1 << (irq - 8));
 }
 
-void dn_dummy_video_setup(char *options,int *ints) {
+static struct irq_controller apollo_irq_controller = {
+	.name           = "apollo",
+	.lock           = SPIN_LOCK_UNLOCKED,
+	.startup        = apollo_irq_startup,
+	.shutdown       = apollo_irq_shutdown,
+};
 
-  printk("no video yet\n");
 
+void dn_init_IRQ(void)
+{
+	m68k_setup_user_interrupt(VEC_USER + 96, 16, dn_process_int);
+	m68k_setup_irq_controller(&apollo_irq_controller, IRQ_APOLLO, 16);
 }
diff --git a/include/asm-m68k/apollohw.h b/include/asm-m68k/apollohw.h
index 4304e1c..a1373b9 100644
--- a/include/asm-m68k/apollohw.h
+++ b/include/asm-m68k/apollohw.h
@@ -3,6 +3,8 @@
 #ifndef _ASMm68k_APOLLOHW_H_
 #define _ASMm68k_APOLLOHW_H_
 
+#include <linux/types.h>
+
 /*
    apollo models
 */
@@ -101,4 +103,6 @@ #define addr_xlat_map ((unsigned short *
 
 #define isaIO2mem(x) (((((x) & 0x3f8)  << 7) | (((x) & 0xfc00) >> 6) | ((x) & 0x7)) + 0x40000 + IO_BASE)
 
+#define IRQ_APOLLO	IRQ_USER
+
 #endif
-- 
1.3.3

--

