Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUCKU1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUCKUZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:25:39 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:44897 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261693AbUCKUVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:21:49 -0500
Date: Thu, 11 Mar 2004 21:21:41 +0100
Message-Id: <200403112021.i2BKLf0Z000850@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 422] m68k interrupt management
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k interrupt management: rename routines to not confuse them with syscalls
(as requested by Andrew Morton):
  - sys_{request,free}_irq() -> cpu_{request,free}_irq()
  - q40_sys_default_handler[] -> q40_default_handler
  - sys_default_handler() -> default_handler()

--- linux-2.6.4/arch/m68k/amiga/amiints.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/amiga/amiints.c	2004-03-01 10:43:50.000000000 +0100
@@ -197,7 +197,7 @@
 	}
 
 	if (irq >= IRQ_AMIGA_AUTO)
-		return sys_request_irq(irq - IRQ_AMIGA_AUTO, handler,
+		return cpu_request_irq(irq - IRQ_AMIGA_AUTO, handler,
 		                       flags, devname, dev_id);
 
 	if (irq >= IRQ_AMIGA_CIAB)
@@ -244,7 +244,7 @@
 	}
 
 	if (irq >= IRQ_AMIGA_AUTO)
-		sys_free_irq(irq - IRQ_AMIGA_AUTO, dev_id);
+		cpu_free_irq(irq - IRQ_AMIGA_AUTO, dev_id);
 
 	if (irq >= IRQ_AMIGA_CIAB) {
 		cia_free_irq(&ciab_base, irq - IRQ_AMIGA_CIAB, dev_id);
--- linux-2.6.4/arch/m68k/bvme6000/bvmeints.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/bvme6000/bvmeints.c	2004-03-01 10:43:53.000000000 +0100
@@ -73,7 +73,7 @@
 	 */
 
 	if (irq >= VEC_INT1 && irq <= VEC_INT7)
-		return sys_request_irq(irq - VEC_SPUR, handler, flags,
+		return cpu_request_irq(irq - VEC_SPUR, handler, flags,
 						devname, dev_id);
 #endif
 	if (!(irq_tab[irq].flags & IRQ_FLG_STD)) {
@@ -103,7 +103,7 @@
 	}
 #if 0
 	if (irq >= VEC_INT1 && irq <= VEC_INT7) {
-		sys_free_irq(irq - VEC_SPUR, dev_id);
+		cpu_free_irq(irq - VEC_SPUR, dev_id);
 		return;
 	}
 #endif
--- linux-2.6.4/arch/m68k/hp300/time.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/hp300/time.c	2004-03-01 10:40:42.000000000 +0100
@@ -68,7 +68,7 @@
 
   asm volatile(" movpw %0,%1@(5)" : : "d" (INTVAL), "a" (CLOCKBASE));
 
-  sys_request_irq(6, hp300_tick, IRQ_FLG_STD, "timer tick", vector);
+  cpu_request_irq(6, hp300_tick, IRQ_FLG_STD, "timer tick", vector);
 
   out_8(CLOCKBASE + CLKCR2, 0x1);		/* select CR1 */
   out_8(CLOCKBASE + CLKCR1, 0x40);		/* enable irq */
--- linux-2.6.4/arch/m68k/kernel/ints.c	2004-01-01 20:23:30.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/kernel/ints.c	2004-03-01 10:43:58.000000000 +0100
@@ -137,8 +137,8 @@
 
 EXPORT_SYMBOL(free_irq);
 
-int sys_request_irq(unsigned int irq, 
-                    irqreturn_t (*handler)(int, void *, struct pt_regs *), 
+int cpu_request_irq(unsigned int irq,
+                    irqreturn_t (*handler)(int, void *, struct pt_regs *),
                     unsigned long flags, const char *devname, void *dev_id)
 {
 	if (irq < IRQ1 || irq > IRQ7) {
@@ -169,7 +169,7 @@
 	return 0;
 }
 
-void sys_free_irq(unsigned int irq, void *dev_id)
+void cpu_free_irq(unsigned int irq, void *dev_id)
 {
 	if (irq < IRQ1 || irq > IRQ7) {
 		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
--- linux-2.6.4/arch/m68k/mac/iop.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/mac/iop.c	2004-03-01 10:41:00.000000000 +0100
@@ -317,7 +317,7 @@
 {
 	if (iop_ism_present) {
 		if (oss_present) {
-			sys_request_irq(OSS_IRQLEV_IOPISM, iop_ism_irq,
+			cpu_request_irq(OSS_IRQLEV_IOPISM, iop_ism_irq,
 					IRQ_FLG_LOCK, "ISM IOP",
 					(void *) IOP_NUM_ISM);
 			oss_irq_enable(IRQ_MAC_ADB);
--- linux-2.6.4/arch/m68k/mac/macints.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/mac/macints.c	2004-03-01 10:44:03.000000000 +0100
@@ -261,7 +261,8 @@
 	if (psc_present) psc_register_interrupts();
 	if (baboon_present) baboon_register_interrupts();
 	iop_register_interrupts();
-	sys_request_irq(7, mac_nmi_handler, IRQ_FLG_LOCK, "NMI", mac_nmi_handler);
+	cpu_request_irq(7, mac_nmi_handler, IRQ_FLG_LOCK, "NMI",
+			mac_nmi_handler);
 #ifdef DEBUG_MACINTS
 	printk("mac_init_IRQ(): Done!\n");
 #endif
@@ -507,7 +508,7 @@
 #endif
 
 	if (irq < VIA1_SOURCE_BASE) {
-		return sys_request_irq(irq, handler, flags, devname, dev_id);
+		return cpu_request_irq(irq, handler, flags, devname, dev_id);
 	}
 
 	if (irq >= NUM_MAC_SOURCES) {
@@ -544,7 +545,7 @@
 #endif
 
 	if (irq < VIA1_SOURCE_BASE) {
-		return sys_free_irq(irq, dev_id);
+		return cpu_free_irq(irq, dev_id);
 	}
 
 	if (irq >= NUM_MAC_SOURCES) {
--- linux-2.6.4/arch/m68k/mac/oss.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/mac/oss.c	2004-03-01 10:41:22.000000000 +0100
@@ -67,15 +67,15 @@
 
 void __init oss_register_interrupts(void)
 {
-	sys_request_irq(OSS_IRQLEV_SCSI, oss_irq, IRQ_FLG_LOCK,
+	cpu_request_irq(OSS_IRQLEV_SCSI, oss_irq, IRQ_FLG_LOCK,
 			"scsi", (void *) oss);
-	sys_request_irq(OSS_IRQLEV_IOPSCC, mac_scc_dispatch, IRQ_FLG_LOCK,
+	cpu_request_irq(OSS_IRQLEV_IOPSCC, mac_scc_dispatch, IRQ_FLG_LOCK,
 			"scc", mac_scc_dispatch);
-	sys_request_irq(OSS_IRQLEV_NUBUS, oss_nubus_irq, IRQ_FLG_LOCK,
+	cpu_request_irq(OSS_IRQLEV_NUBUS, oss_nubus_irq, IRQ_FLG_LOCK,
 			"nubus", (void *) oss);
-	sys_request_irq(OSS_IRQLEV_SOUND, oss_irq, IRQ_FLG_LOCK,
+	cpu_request_irq(OSS_IRQLEV_SOUND, oss_irq, IRQ_FLG_LOCK,
 			"sound", (void *) oss);
-	sys_request_irq(OSS_IRQLEV_VIA1, via1_irq, IRQ_FLG_LOCK,
+	cpu_request_irq(OSS_IRQLEV_VIA1, via1_irq, IRQ_FLG_LOCK,
 			"via1", (void *) via1);
 }
 
--- linux-2.6.4/arch/m68k/mac/psc.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/mac/psc.c	2004-03-01 10:41:31.000000000 +0100
@@ -117,14 +117,10 @@
 
 void __init psc_register_interrupts(void)
 {
-	sys_request_irq(3, psc_irq, IRQ_FLG_LOCK, "psc3",
-			(void *) 0x30);
-	sys_request_irq(4, psc_irq, IRQ_FLG_LOCK, "psc4",
-			(void *) 0x40);
-	sys_request_irq(5, psc_irq, IRQ_FLG_LOCK, "psc5",
-			(void *) 0x50);
-	sys_request_irq(6, psc_irq, IRQ_FLG_LOCK, "psc6",
-			(void *) 0x60);
+	cpu_request_irq(3, psc_irq, IRQ_FLG_LOCK, "psc3", (void *) 0x30);
+	cpu_request_irq(4, psc_irq, IRQ_FLG_LOCK, "psc4", (void *) 0x40);
+	cpu_request_irq(5, psc_irq, IRQ_FLG_LOCK, "psc5", (void *) 0x50);
+	cpu_request_irq(6, psc_irq, IRQ_FLG_LOCK, "psc6", (void *) 0x60);
 }
 
 /*
--- linux-2.6.4/arch/m68k/mac/via.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/mac/via.c	2004-03-01 10:43:38.000000000 +0100
@@ -260,24 +260,27 @@
 void __init via_register_interrupts(void)
 {
 	if (via_alt_mapping) {
-		sys_request_irq(IRQ_AUTO_1, via1_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
-				"software", (void *) via1);
-		sys_request_irq(IRQ_AUTO_6, via1_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
-				"via1", (void *) via1);
+		cpu_request_irq(IRQ_AUTO_1, via1_irq,
+				IRQ_FLG_LOCK|IRQ_FLG_FAST, "software",
+				(void *) via1);
+		cpu_request_irq(IRQ_AUTO_6, via1_irq,
+				IRQ_FLG_LOCK|IRQ_FLG_FAST, "via1",
+				(void *) via1);
 	} else {
-		sys_request_irq(IRQ_AUTO_1, via1_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
-				"via1", (void *) via1);
+		cpu_request_irq(IRQ_AUTO_1, via1_irq,
+				IRQ_FLG_LOCK|IRQ_FLG_FAST, "via1",
+				(void *) via1);
 #if 0 /* interferes with serial on some machines */
 		if (!psc_present) {
-			sys_request_irq(IRQ_AUTO_6, mac_bang, IRQ_FLG_LOCK,
+			cpu_request_irq(IRQ_AUTO_6, mac_bang, IRQ_FLG_LOCK,
 					"Off Switch", mac_bang);
 		}
 #endif
 	}
-	sys_request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
+	cpu_request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
 			"via2", (void *) via2);
 	if (!psc_present) {
-		sys_request_irq(IRQ_AUTO_4, mac_scc_dispatch, IRQ_FLG_LOCK,
+		cpu_request_irq(IRQ_AUTO_4, mac_scc_dispatch, IRQ_FLG_LOCK,
 				"scc", mac_scc_dispatch);
 	}
 	request_irq(IRQ_MAC_NUBUS, via_nubus_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
--- linux-2.6.4/arch/m68k/q40/config.c	2003-05-27 19:02:33.000000000 +0200
+++ linux-m68k-2.6.4/arch/m68k/q40/config.c	2004-03-01 12:02:44.000000000 +0100
@@ -40,7 +40,7 @@
 extern void floppy_setup(char *str, int *ints);
 
 extern irqreturn_t q40_process_int (int level, struct pt_regs *regs);
-extern irqreturn_t (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
+extern irqreturn_t (*q40_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
 extern void q40_free_irq (unsigned int, void *);
 extern int  show_q40_interrupts (struct seq_file *, void *);
@@ -185,7 +185,7 @@
     mach_request_irq	 = q40_request_irq;
     enable_irq		 = q40_enable_irq;
     disable_irq          = q40_disable_irq;
-    mach_default_handler = &q40_sys_default_handler;
+    mach_default_handler = &q40_default_handler;
     mach_get_model       = q40_get_model;
     mach_get_hardware_list = q40_get_hardware_list;
 
--- linux-2.6.4/arch/m68k/q40/q40ints.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/q40/q40ints.c	2004-03-01 13:27:22.000000000 +0100
@@ -46,10 +46,8 @@
 irqreturn_t q40_irq2_handler (int, void *, struct pt_regs *fp);
 
 
-extern irqreturn_t (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);
-
 static irqreturn_t q40_defhand (int irq, void *dev_id, struct pt_regs *fp);
-static irqreturn_t sys_default_handler(int lev, void *dev_id, struct pt_regs *regs);
+static irqreturn_t default_handler(int lev, void *dev_id, struct pt_regs *regs);
 
 
 #define DEVNAME_SIZE 24
@@ -96,7 +94,8 @@
 	}
 
 	/* setup handler for ISA ints */
-	sys_request_irq(IRQ2,q40_irq2_handler, 0, "q40 ISA and master chip", NULL);
+	cpu_request_irq(IRQ2, q40_irq2_handler, 0, "q40 ISA and master chip",
+			NULL);
 
 	/* now enable some ints.. */
 	master_outb(1,EXT_ENABLE_REG);  /* ISA IRQ 5-15 */
@@ -153,8 +152,8 @@
 	  }
 	else {
 	  /* Q40_IRQ_SAMPLE :somewhat special actions required here ..*/
-	  sys_request_irq(4,handler,flags,devname,dev_id);
-	  sys_request_irq(6,handler,flags,devname,dev_id);
+	  cpu_request_irq(4, handler, flags, devname, dev_id);
+	  cpu_request_irq(6, handler, flags, devname, dev_id);
 	  return 0;
 	}
 }
@@ -192,8 +191,8 @@
 	  }
 	else
 	  { /* == Q40_IRQ_SAMPLE */
-	    sys_free_irq(4,dev_id);
-	    sys_free_irq(6,dev_id);
+	    cpu_free_irq(4, dev_id);
+	    cpu_free_irq(6, dev_id);
 	  }
 }
 
@@ -417,16 +416,16 @@
 	else master_outb(-1,KEYBOARD_UNLOCK_REG);
 	return IRQ_NONE;
 }
-static irqreturn_t sys_default_handler(int lev, void *dev_id, struct pt_regs *regs)
+static irqreturn_t default_handler(int lev, void *dev_id, struct pt_regs *regs)
 {
 	printk ("Uninitialised interrupt level %d\n", lev);
 	return IRQ_NONE;
 }
 
- irqreturn_t (*q40_sys_default_handler[SYS_IRQS]) (int, void *, struct pt_regs *) = {
-	 sys_default_handler,sys_default_handler,sys_default_handler,sys_default_handler,
-	 sys_default_handler,sys_default_handler,sys_default_handler,sys_default_handler
- };
+irqreturn_t (*q40_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
+	 default_handler, default_handler, default_handler, default_handler,
+	 default_handler, default_handler, default_handler, default_handler
+};
 
 
 void q40_enable_irq (unsigned int irq)
--- linux-2.6.4/arch/m68k/sun3/sun3ints.c	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/arch/m68k/sun3/sun3ints.c	2004-03-01 10:42:17.000000000 +0100
@@ -153,8 +153,8 @@
 	for(i = 0; i < SYS_IRQS; i++)
 	{
 		if(dev_names[i])
-			sys_request_irq(i, sun3_default_handler[i],
-					0, dev_names[i], NULL);
+			cpu_request_irq(i, sun3_default_handler[i], 0,
+					dev_names[i], NULL);
 	}
 
 	for(i = 0; i < 192; i++) 
@@ -178,7 +178,8 @@
 		dev_names[irq] = devname;
 		
 		/* setting devname would be nice */
-		sys_request_irq(irq, sun3_default_handler[irq], 0, devname, NULL);
+		cpu_request_irq(irq, sun3_default_handler[irq], 0, devname,
+				NULL);
 
 		return 0;
 	} else {
--- linux-2.6.4/include/asm-m68k/irq.h	2004-02-29 17:00:18.000000000 +0100
+++ linux-m68k-2.6.4/include/asm-m68k/irq.h	2004-03-01 10:44:51.000000000 +0100
@@ -76,10 +76,10 @@
 
 struct pt_regs;
 
-extern int sys_request_irq(unsigned int,
-	irqreturn_t (*)(int, void *, struct pt_regs *),
-	unsigned long, const char *, void *);
-extern void sys_free_irq(unsigned int, void *);
+extern int cpu_request_irq(unsigned int,
+			   irqreturn_t (*)(int, void *, struct pt_regs *),
+			   unsigned long, const char *, void *);
+extern void cpu_free_irq(unsigned int, void *);
 
 /*
  * various flags for request_irq() - the Amiga now uses the standard

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
