Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWEYB2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWEYB2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWEYB1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30350 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964819AbWEYB1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:03 -0400
Message-Id: <20060525003424.301767000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:53 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 11/11] m68k mac VIA2 fixes and cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

Some fixes and cleanups from the linux-mac68k repo. Fix mac_esp by 
clearing the VIA2 SCSI IRQ flag before the SCSI IRQ handler is invoked. 
Also fix a race condition caused by unmasking a nubus slot IRQ then 
setting the relevant nubus_active bit.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/mac/config.c  |   13 -------------
 arch/m68k/mac/macints.c |    1 -
 arch/m68k/mac/via.c     |   17 ++---------------
 3 files changed, 2 insertions(+), 29 deletions(-)

Index: linux-2.6-mm/arch/m68k/mac/config.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/mac/config.c
+++ linux-2.6-mm/arch/m68k/mac/config.c
@@ -89,24 +89,11 @@ extern void mac_debugging_long(int, long
 
 static void mac_get_model(char *str);
 
-void mac_bang(int irq, void *vector, struct pt_regs *p)
-{
-	printk(KERN_INFO "Resetting ...\n");
-	mac_reset();
-}
-
 static void mac_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *))
 {
 	via_init_clock(vector);
 }
 
-#if 0
-void mac_waitbut (void)
-{
-	;
-}
-#endif
-
 extern irqreturn_t mac_default_handler(int, void *, struct pt_regs *);
 
 irqreturn_t (*mac_handlers[8])(int, void *, struct pt_regs *)=
Index: linux-2.6-mm/arch/m68k/mac/macints.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/mac/macints.c
+++ linux-2.6-mm/arch/m68k/mac/macints.c
@@ -216,7 +216,6 @@ static void scc_irq_disable(int);
  * console_loglevel determines NMI handler function
  */
 
-extern irqreturn_t mac_bang(int, void *, struct pt_regs *);
 irqreturn_t mac_nmi_handler(int, void *, struct pt_regs *);
 irqreturn_t mac_debug_handler(int, void *, struct pt_regs *);
 
Index: linux-2.6-mm/arch/m68k/mac/via.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/mac/via.c
+++ linux-2.6-mm/arch/m68k/mac/via.c
@@ -25,7 +25,6 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 
-#include <asm/traps.h>
 #include <asm/bootinfo.h>
 #include <asm/macintosh.h>
 #include <asm/macints.h>
@@ -71,7 +70,6 @@ void via_irq_enable(int irq);
 void via_irq_disable(int irq);
 void via_irq_clear(int irq);
 
-extern irqreturn_t mac_bang(int, void *, struct pt_regs *);
 extern irqreturn_t mac_scc_dispatch(int, void *, struct pt_regs *);
 extern int oss_present;
 
@@ -212,11 +210,6 @@ void __init via_init(void)
 			break;
 	}
 #else
-	/* The alernate IRQ mapping seems to just not work. Anyone with a   */
-	/* supported machine is welcome to take a stab at fixing it. It     */
-	/* _should_ work on the following Quadras: 610,650,700,800,900,950  */
-	/*                                               - 1999-06-12 (jmt) */
-
 	via_alt_mapping = 0;
 #endif
 
@@ -270,12 +263,6 @@ void __init via_register_interrupts(void
 		cpu_request_irq(IRQ_AUTO_1, via1_irq,
 				IRQ_FLG_LOCK|IRQ_FLG_FAST, "via1",
 				(void *) via1);
-#if 0 /* interferes with serial on some machines */
-		if (!psc_present) {
-			cpu_request_irq(IRQ_AUTO_6, mac_bang, IRQ_FLG_LOCK,
-					"Off Switch", mac_bang);
-		}
-#endif
 	}
 	cpu_request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
 			"via2", (void *) via2);
@@ -471,8 +458,8 @@ irqreturn_t via2_irq(int irq, void *dev_
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1)
 		if (events & irq_bit) {
 			via2[gIER] = irq_bit;
-			mac_do_irq_list(VIA2_SOURCE_BASE + i, regs);
 			via2[gIFR] = irq_bit | rbv_clear;
+			mac_do_irq_list(VIA2_SOURCE_BASE + i, regs);
 			via2[gIER] = irq_bit | 0x80;
 		}
 	return IRQ_HANDLED;
@@ -529,6 +516,7 @@ void via_irq_enable(int irq) {
 		}
 		via2[gIER] = irq_bit | 0x80;
 	} else if (irq_src == 7) {
+		nubus_active |= irq_bit;
 		if (rbv_present) {
 			/* enable the slot interrupt. SIER works like IER. */
 			via2[rSIER] = IER_SET_BIT(irq_idx);
@@ -550,7 +538,6 @@ void via_irq_enable(int irq) {
 				}
 			}
 		}
-		nubus_active |= irq_bit;
 	}
 }
 

--

