Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWJHNgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWJHNgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWJHNgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:36:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52919 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751148AbWJHNgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:36:09 -0400
Date: Sun, 8 Oct 2006 14:36:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] alpha pt_regs cleanups: device_interrupt
Message-ID: <20061008133608.GN29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

callers of ->device_interrupt() do set_irq_regs() now; pt_regs argument
removed, remaining uses of regs in instances of ->device_interrupt()
are switched to get_irq_regs() and will be gone in the next patch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/irq_alpha.c     |    5 ++++-
 arch/alpha/kernel/irq_i8259.c     |    4 ++--
 arch/alpha/kernel/irq_impl.h      |    6 +++---
 arch/alpha/kernel/irq_pyxis.c     |    6 +++---
 arch/alpha/kernel/irq_srm.c       |    4 ++--
 arch/alpha/kernel/sys_alcor.c     |    6 +++---
 arch/alpha/kernel/sys_cabriolet.c |   16 ++++++++--------
 arch/alpha/kernel/sys_dp264.c     |   14 +++++++-------
 arch/alpha/kernel/sys_eb64p.c     |    6 +++---
 arch/alpha/kernel/sys_eiger.c     |   16 ++++++++--------
 arch/alpha/kernel/sys_jensen.c    |    6 +++---
 arch/alpha/kernel/sys_marvel.c    |    4 ++--
 arch/alpha/kernel/sys_miata.c     |    4 ++--
 arch/alpha/kernel/sys_mikasa.c    |    6 +++---
 arch/alpha/kernel/sys_noritake.c  |   10 +++++-----
 arch/alpha/kernel/sys_rawhide.c   |    4 ++--
 arch/alpha/kernel/sys_rx164.c     |    6 +++---
 arch/alpha/kernel/sys_sable.c     |    4 ++--
 arch/alpha/kernel/sys_takara.c    |   16 ++++++++--------
 arch/alpha/kernel/sys_titan.c     |   11 +++++++----
 arch/alpha/kernel/sys_wildfire.c  |    4 ++--
 include/asm-alpha/machvec.h       |    2 +-
 22 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/arch/alpha/kernel/irq_alpha.c b/arch/alpha/kernel/irq_alpha.c
index ddf5cf8..d14cc42 100644
--- a/arch/alpha/kernel/irq_alpha.c
+++ b/arch/alpha/kernel/irq_alpha.c
@@ -39,6 +39,7 @@ asmlinkage void 
 do_entInt(unsigned long type, unsigned long vector,
 	  unsigned long la_ptr, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	switch (type) {
 	case 0:
 #ifdef CONFIG_SMP
@@ -72,7 +73,9 @@ #endif
 		alpha_mv.machine_check(vector, la_ptr, regs);
 		return;
 	case 3:
-		alpha_mv.device_interrupt(vector, regs);
+		old_regs = set_irq_regs(regs);
+		alpha_mv.device_interrupt(vector);
+		set_irq_regs(old_regs);
 		return;
 	case 4:
 		perf_irq(la_ptr, regs);
diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index ebbadbc..6c70f8b 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -137,7 +137,7 @@ #endif
 
 #if defined(IACK_SC)
 void
-isa_device_interrupt(unsigned long vector, struct pt_regs *regs)
+isa_device_interrupt(unsigned long vector)
 {
 	/*
 	 * Generate a PCI interrupt acknowledge cycle.  The PIC will
@@ -147,7 +147,7 @@ isa_device_interrupt(unsigned long vecto
 	 */
 	int j = *(vuip) IACK_SC;
 	j &= 0xff;
-	handle_irq(j, regs);
+	handle_irq(j, get_irq_regs());
 }
 #endif
 
diff --git a/arch/alpha/kernel/irq_impl.h b/arch/alpha/kernel/irq_impl.h
index f201d8f..5d84dbd 100644
--- a/arch/alpha/kernel/irq_impl.h
+++ b/arch/alpha/kernel/irq_impl.h
@@ -15,10 +15,10 @@ #include <linux/profile.h>
 
 #define RTC_IRQ    8
 
-extern void isa_device_interrupt(unsigned long, struct pt_regs *);
+extern void isa_device_interrupt(unsigned long);
 extern void isa_no_iack_sc_device_interrupt(unsigned long, struct pt_regs *);
-extern void srm_device_interrupt(unsigned long, struct pt_regs *);
-extern void pyxis_device_interrupt(unsigned long, struct pt_regs *);
+extern void srm_device_interrupt(unsigned long);
+extern void pyxis_device_interrupt(unsigned long);
 
 extern struct irqaction timer_irqaction;
 extern struct irqaction isa_cascade_irqaction;
diff --git a/arch/alpha/kernel/irq_pyxis.c b/arch/alpha/kernel/irq_pyxis.c
index 3b58141..686dc22 100644
--- a/arch/alpha/kernel/irq_pyxis.c
+++ b/arch/alpha/kernel/irq_pyxis.c
@@ -81,7 +81,7 @@ static struct hw_interrupt_type pyxis_ir
 };
 
 void 
-pyxis_device_interrupt(unsigned long vector, struct pt_regs *regs)
+pyxis_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -98,9 +98,9 @@ pyxis_device_interrupt(unsigned long vec
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i == 7)
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		else
-			handle_irq(16+i, regs);
+			handle_irq(16+i, get_irq_regs());
 	}
 }
 
diff --git a/arch/alpha/kernel/irq_srm.c b/arch/alpha/kernel/irq_srm.c
index 8e4d121..2e9f6d4 100644
--- a/arch/alpha/kernel/irq_srm.c
+++ b/arch/alpha/kernel/irq_srm.c
@@ -72,8 +72,8 @@ init_srm_irqs(long max, unsigned long ig
 }
 
 void 
-srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
index d6926b7..2d412c8 100644
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -100,7 +100,7 @@ static struct hw_interrupt_type alcor_ir
 };
 
 static void
-alcor_device_interrupt(unsigned long vector, struct pt_regs *regs)
+alcor_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -116,9 +116,9 @@ alcor_device_interrupt(unsigned long vec
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i == 31) {
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		} else {
-			handle_irq(16 + i, regs);
+			handle_irq(16 + i, get_irq_regs());
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 25a2150..e75f0ce 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -82,7 +82,7 @@ static struct hw_interrupt_type cabriole
 };
 
 static void 
-cabriolet_device_interrupt(unsigned long v, struct pt_regs *r)
+cabriolet_device_interrupt(unsigned long v)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -98,15 +98,15 @@ cabriolet_device_interrupt(unsigned long
 		i = ffz(~pld);
 		pld &= pld - 1;	/* clear least bit set */
 		if (i == 4) {
-			isa_device_interrupt(v, r);
+			isa_device_interrupt(v);
 		} else {
-			handle_irq(16 + i, r);
+			handle_irq(16 + i, get_irq_regs());
 		}
 	}
 }
 
 static void __init
-common_init_irq(void (*srm_dev_int)(unsigned long v, struct pt_regs *r))
+common_init_irq(void (*srm_dev_int)(unsigned long v))
 {
 	init_i8259a_irqs();
 
@@ -154,18 +154,18 @@ #if defined(CONFIG_ALPHA_GENERIC) || def
    too invasive though.  */
 
 static void
-pc164_srm_device_interrupt(unsigned long v, struct pt_regs *r)
+pc164_srm_device_interrupt(unsigned long v)
 {
 	__min_ipl = getipl();
-	srm_device_interrupt(v, r);
+	srm_device_interrupt(v);
 	__min_ipl = 0;
 }
 
 static void
-pc164_device_interrupt(unsigned long v, struct pt_regs *r)
+pc164_device_interrupt(unsigned long v)
 {
 	__min_ipl = getipl();
-	cabriolet_device_interrupt(v, r);
+	cabriolet_device_interrupt(v);
 	__min_ipl = 0;
 }
 
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index dd6103b..57dce00 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -217,7 +217,7 @@ static struct hw_interrupt_type clipper_
 };
 
 static void
-dp264_device_interrupt(unsigned long vector, struct pt_regs * regs)
+dp264_device_interrupt(unsigned long vector)
 {
 #if 1
 	printk("dp264_device_interrupt: NOT IMPLEMENTED YET!! \n");
@@ -236,9 +236,9 @@ #else
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i == 55)
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		else
-			handle_irq(16 + i, 16 + i, regs);
+			handle_irq(16 + i, get_irq_regs());
 #if 0
 		TSUNAMI_cchip->dir0.csr = 1UL << i; mb();
 		tmp = TSUNAMI_cchip->dir0.csr;
@@ -248,7 +248,7 @@ #endif
 }
 
 static void 
-dp264_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+dp264_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -268,11 +268,11 @@ dp264_srm_device_interrupt(unsigned long
 	if (irq >= 32)
 		irq -= 16;
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void 
-clipper_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+clipper_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -290,7 +290,7 @@ clipper_srm_device_interrupt(unsigned lo
 	 *
 	 * Eg IRQ 24 is DRIR bit 8, etc, etc
 	 */
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
index ed108b6..90d2725 100644
--- a/arch/alpha/kernel/sys_eb64p.c
+++ b/arch/alpha/kernel/sys_eb64p.c
@@ -80,7 +80,7 @@ static struct hw_interrupt_type eb64p_ir
 };
 
 static void 
-eb64p_device_interrupt(unsigned long vector, struct pt_regs *regs)
+eb64p_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -97,9 +97,9 @@ eb64p_device_interrupt(unsigned long vec
 		pld &= pld - 1;	/* clear least bit set */
 
 		if (i == 5) {
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		} else {
-			handle_irq(16 + i, regs);
+			handle_irq(16 + i, get_irq_regs());
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 64a785b..f38cded 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -91,7 +91,7 @@ static struct hw_interrupt_type eiger_ir
 };
 
 static void
-eiger_device_interrupt(unsigned long vector, struct pt_regs * regs)
+eiger_device_interrupt(unsigned long vector)
 {
 	unsigned intstatus;
 
@@ -118,20 +118,20 @@ eiger_device_interrupt(unsigned long vec
 		 * despatch an interrupt if it's set.
 		 */
 
-		if (intstatus & 8) handle_irq(16+3, regs);
-		if (intstatus & 4) handle_irq(16+2, regs);
-		if (intstatus & 2) handle_irq(16+1, regs);
-		if (intstatus & 1) handle_irq(16+0, regs);
+		if (intstatus & 8) handle_irq(16+3, get_irq_regs());
+		if (intstatus & 4) handle_irq(16+2, get_irq_regs());
+		if (intstatus & 2) handle_irq(16+1, get_irq_regs());
+		if (intstatus & 1) handle_irq(16+0, get_irq_regs());
 	} else {
-		isa_device_interrupt(vector, regs);
+		isa_device_interrupt(vector);
 	}
 }
 
 static void
-eiger_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+eiger_srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index 4ac2b32..fc31636 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -129,7 +129,7 @@ static struct hw_interrupt_type jensen_l
 };
 
 static void 
-jensen_device_interrupt(unsigned long vector, struct pt_regs * regs)
+jensen_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -189,7 +189,7 @@ #define JENSEN_CYCLES_PER_SEC	(150000000
           if (cc - last_msg > ((JENSEN_CYCLES_PER_SEC) * 3) ||
 	      irq != last_irq) {
                 printk(KERN_CRIT " irq %d count %d cc %u @ %lx\n",
-                       irq, count, cc-last_cc, regs->pc);
+                       irq, count, cc-last_cc, get_irq_regs()->pc);
                 count = 0;
                 last_msg = cc;
                 last_irq = irq;
@@ -198,7 +198,7 @@ #define JENSEN_CYCLES_PER_SEC	(150000000
         }
 #endif
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 36d2159..4ea5615 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -38,7 +38,7 @@ #endif
  * Interrupt handling.
  */
 static void 
-io7_device_interrupt(unsigned long vector, struct pt_regs * regs)
+io7_device_interrupt(unsigned long vector)
 {
 	unsigned int pid;
 	unsigned int irq;
@@ -64,7 +64,7 @@ io7_device_interrupt(unsigned long vecto
 	irq &= MARVEL_IRQ_VEC_IRQ_MASK;		/* not too many bits */
 	irq |= pid << MARVEL_IRQ_VEC_PE_SHIFT;	/* merge the pid     */
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static volatile unsigned long *
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 61ac56f..fbbd952 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -33,7 +33,7 @@ #include "machvec_impl.h"
 
 
 static void 
-miata_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+miata_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -56,7 +56,7 @@ miata_srm_device_interrupt(unsigned long
 	if (irq >= 16)
 		irq = irq + 8;
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
index cc4c581..5429ba0 100644
--- a/arch/alpha/kernel/sys_mikasa.c
+++ b/arch/alpha/kernel/sys_mikasa.c
@@ -79,7 +79,7 @@ static struct hw_interrupt_type mikasa_i
 };
 
 static void 
-mikasa_device_interrupt(unsigned long vector, struct pt_regs *regs)
+mikasa_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -97,9 +97,9 @@ mikasa_device_interrupt(unsigned long ve
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i < 16) {
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		} else {
-			handle_irq(i, regs);
+			handle_irq(i, get_irq_regs());
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index 2d3cff7..b9a8434 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -77,7 +77,7 @@ static struct hw_interrupt_type noritake
 };
 
 static void 
-noritake_device_interrupt(unsigned long vector, struct pt_regs *regs)
+noritake_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	unsigned int i;
@@ -96,15 +96,15 @@ noritake_device_interrupt(unsigned long 
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i < 16) {
-			isa_device_interrupt(vector, regs);
+			isa_device_interrupt(vector);
 		} else {
-			handle_irq(i, regs);
+			handle_irq(i, get_irq_regs());
 		}
 	}
 }
 
 static void 
-noritake_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+noritake_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -122,7 +122,7 @@ noritake_srm_device_interrupt(unsigned l
 	if (irq >= 16)
 		irq = irq + 1;
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_rawhide.c b/arch/alpha/kernel/sys_rawhide.c
index 949607e..bef6516 100644
--- a/arch/alpha/kernel/sys_rawhide.c
+++ b/arch/alpha/kernel/sys_rawhide.c
@@ -134,7 +134,7 @@ static struct hw_interrupt_type rawhide_
 };
 
 static void 
-rawhide_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+rawhide_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -158,7 +158,7 @@ rawhide_srm_device_interrupt(unsigned lo
 	/* Adjust by which hose it is from.  */
 	irq -= ((irq + 16) >> 2) & 0x38;
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index 6ae5060..fa8eef8 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -83,7 +83,7 @@ static struct hw_interrupt_type rx164_ir
 };
 
 static void 
-rx164_device_interrupt(unsigned long vector, struct pt_regs *regs)
+rx164_device_interrupt(unsigned long vector)
 {
 	unsigned long pld;
 	volatile unsigned int *dirr;
@@ -102,9 +102,9 @@ rx164_device_interrupt(unsigned long vec
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i == 20) {
-			isa_no_iack_sc_device_interrupt(vector, regs);
+			isa_no_iack_sc_device_interrupt(vector, get_irq_regs());
 		} else {
-			handle_irq(16+i, regs);
+			handle_irq(16+i, get_irq_regs());
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index a7a1464..7913791 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -512,7 +512,7 @@ static struct hw_interrupt_type sable_ly
 };
 
 static void 
-sable_lynx_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+sable_lynx_srm_device_interrupt(unsigned long vector)
 {
 	/* Note that the vector reported by the SRM PALcode corresponds
 	   to the interrupt mask bits, but we have to manage via the
@@ -526,7 +526,7 @@ #if 0
 	printk("%s: vector 0x%lx bit 0x%x irq 0x%x\n",
 	       __FUNCTION__, vector, bit, irq);
 #endif
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
index 2c75cd1..ce2d3b0 100644
--- a/arch/alpha/kernel/sys_takara.c
+++ b/arch/alpha/kernel/sys_takara.c
@@ -85,7 +85,7 @@ static struct hw_interrupt_type takara_i
 };
 
 static void
-takara_device_interrupt(unsigned long vector, struct pt_regs *regs)
+takara_device_interrupt(unsigned long vector)
 {
 	unsigned intstatus;
 
@@ -112,20 +112,20 @@ takara_device_interrupt(unsigned long ve
 		 * despatch an interrupt if it's set.
 		 */
 
-		if (intstatus & 8) handle_irq(16+3, regs);
-		if (intstatus & 4) handle_irq(16+2, regs);
-		if (intstatus & 2) handle_irq(16+1, regs);
-		if (intstatus & 1) handle_irq(16+0, regs);
+		if (intstatus & 8) handle_irq(16+3, get_irq_regs());
+		if (intstatus & 4) handle_irq(16+2, get_irq_regs());
+		if (intstatus & 2) handle_irq(16+1, get_irq_regs());
+		if (intstatus & 1) handle_irq(16+0, get_irq_regs());
 	} else {
-		isa_device_interrupt (vector, regs);
+		isa_device_interrupt (vector);
 	}
 }
 
 static void 
-takara_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+takara_srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
index 302aab3..1473aa0 100644
--- a/arch/alpha/kernel/sys_titan.c
+++ b/arch/alpha/kernel/sys_titan.c
@@ -167,18 +167,18 @@ titan_set_irq_affinity(unsigned int irq,
 }
 
 static void
-titan_device_interrupt(unsigned long vector, struct pt_regs * regs)
+titan_device_interrupt(unsigned long vector)
 {
 	printk("titan_device_interrupt: NOT IMPLEMENTED YET!! \n");
 }
 
 static void 
-titan_srm_device_interrupt(unsigned long vector, struct pt_regs * regs)
+titan_srm_device_interrupt(unsigned long vector)
 {
 	int irq;
 
 	irq = (vector - 0x800) >> 4;
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 }
 
 
@@ -245,6 +245,7 @@ titan_legacy_init_irq(void)
 void
 titan_dispatch_irqs(u64 mask, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	unsigned long vector;
 
 	/*
@@ -252,6 +253,7 @@ titan_dispatch_irqs(u64 mask, struct pt_
 	 */
 	mask &= titan_cpu_irq_affinity[smp_processor_id()];
 
+	old_regs = set_irq_regs(regs);
 	/*
 	 * Dispatch all requested interrupts 
 	 */
@@ -263,8 +265,9 @@ titan_dispatch_irqs(u64 mask, struct pt_
 		vector = 0x900 + (vector << 4);	/* convert to SRM vector */
 		
 		/* dispatch it */
-		alpha_mv.device_interrupt(vector, regs);
+		alpha_mv.device_interrupt(vector);
 	}
+	set_irq_regs(old_regs);
 }
   
 
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index 22c5798..ddf5edd 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -234,7 +234,7 @@ #endif
 }
 
 static void 
-wildfire_device_interrupt(unsigned long vector, struct pt_regs * regs)
+wildfire_device_interrupt(unsigned long vector)
 {
 	int irq;
 
@@ -246,7 +246,7 @@ wildfire_device_interrupt(unsigned long 
 	 * bits 5-0:	irq in PCA
 	 */
 
-	handle_irq(irq, regs);
+	handle_irq(irq, get_irq_regs());
 	return;
 }
 
diff --git a/include/asm-alpha/machvec.h b/include/asm-alpha/machvec.h
index aced22f..7ae7442 100644
--- a/include/asm-alpha/machvec.h
+++ b/include/asm-alpha/machvec.h
@@ -79,7 +79,7 @@ struct alpha_machine_vector
 
 	void (*update_irq_hw)(unsigned long, unsigned long, int);
 	void (*ack_irq)(unsigned long);
-	void (*device_interrupt)(unsigned long vector, struct pt_regs *regs);
+	void (*device_interrupt)(unsigned long vector);
 	void (*machine_check)(u64 vector, u64 la, struct pt_regs *regs);
 
 	void (*smp_callin)(void);
-- 
1.4.2.GIT

