Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313452AbSDQKOF>; Wed, 17 Apr 2002 06:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDQKOE>; Wed, 17 Apr 2002 06:14:04 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:28048 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313452AbSDQKOD>; Wed, 17 Apr 2002 06:14:03 -0400
Date: Wed, 17 Apr 2002 11:57:40 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@suse.de>
Subject: [PATCH][2.5-dj] P4 thermal LVT (damage control)
Message-ID: <Pine.LNX.4.44.0204171029540.30470-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids frobbing the LVT if we haven't touched it. In 
particular, the case where its handled by SMM. And changes one #ifdef 
(Dave does that look ok?)

Against 2.5.8-dj1

<insert "please apply" chanting and bone throwing here>

--- linux-2.5-dj/arch/i386/kernel/apic.c.orig	Wed Apr 17 09:52:58 2002
+++ linux-2.5-dj/arch/i386/kernel/apic.c	Wed Apr 17 10:25:33 2002
@@ -78,6 +78,13 @@
 		apic_write_around(APIC_LVTPC, v | APIC_LVT_MASKED);
 	}
 
+/* lets not touch this if we didn't frob it */
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5) {
+		v = apic_read(APIC_LVTTHMR);
+		apic_write_around(APIC_LVTTHMR, v | APIC_LVT_MASKED);
+	}
+#endif
 	/*
 	 * Clean APIC state for other OSs:
 	 */
@@ -88,6 +95,11 @@
 		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
 	if (maxlvt >= 4)
 		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_write_around(APIC_LVTTHRM, APIC_LVT_MASKED);
+#endif
 	v = GET_APIC_VERSION(apic_read(APIC_LVR));
 	if (APIC_INTEGRATED(v)) {	/* !82489DX */
 		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
@@ -472,6 +484,7 @@
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
+	
 	__save_flags(flags);
 	__cli();
 	disable_local_APIC();
--- linux-2.5-dj/include/asm/hw_irq.h.orig	Wed Apr 17 10:48:28 2002
+++ linux-2.5-dj/include/asm/hw_irq.h	Wed Apr 17 11:13:53 2002
@@ -38,6 +38,7 @@
 extern asmlinkage void apic_timer_interrupt(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
+extern asmlinkage void smp_thermal_interrupt(struct pt_regs);
 #endif
 
 extern void mask_irq(unsigned int irq);
--- linux-2.5-dj/arch/i386/kernel/i8259.c.orig	Wed Apr 17 10:37:55 2002
+++ linux-2.5-dj/arch/i386/kernel/i8259.c	Wed Apr 17 11:33:38 2002
@@ -393,7 +393,7 @@
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 
 	/* thermal monitor LVT interrupt */
-#ifdef CONFIG_MPENTIUM4
+#ifdef CONFIG_X86_MCE_P4THERMAL
 	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 #endif

-- 
http://function.linuxpower.ca

