Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWJHNhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJHNhe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWJHNhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:37:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51665 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751151AbWJHNhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:37:33 -0400
Date: Sun, 8 Oct 2006 14:37:32 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] alpha pt_regs cleanups: handle_irq()
Message-ID: <20061008133732.GO29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isa_no_iack_sc_device_interrupt() always gets get_irq_regs()
as argument; kill that argument.
All but two callers of handle_irq() pass get_irq_regs() as
argument; convert the remaining two, kill set_irq_regs() inside
handle_irq().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/irq.c           |    5 +----
 arch/alpha/kernel/irq_alpha.c     |    6 ++++--
 arch/alpha/kernel/irq_i8259.c     |    6 +++---
 arch/alpha/kernel/irq_impl.h      |    4 ++--
 arch/alpha/kernel/irq_pyxis.c     |    2 +-
 arch/alpha/kernel/irq_srm.c       |    2 +-
 arch/alpha/kernel/sys_alcor.c     |    2 +-
 arch/alpha/kernel/sys_cabriolet.c |    2 +-
 arch/alpha/kernel/sys_dp264.c     |    6 +++---
 arch/alpha/kernel/sys_eb64p.c     |    2 +-
 arch/alpha/kernel/sys_eiger.c     |   10 +++++-----
 arch/alpha/kernel/sys_jensen.c    |    2 +-
 arch/alpha/kernel/sys_marvel.c    |    2 +-
 arch/alpha/kernel/sys_miata.c     |    2 +-
 arch/alpha/kernel/sys_mikasa.c    |    2 +-
 arch/alpha/kernel/sys_noritake.c  |    4 ++--
 arch/alpha/kernel/sys_rawhide.c   |    2 +-
 arch/alpha/kernel/sys_rx164.c     |    4 ++--
 arch/alpha/kernel/sys_sable.c     |    2 +-
 arch/alpha/kernel/sys_takara.c    |   10 +++++-----
 arch/alpha/kernel/sys_titan.c     |    2 +-
 arch/alpha/kernel/sys_wildfire.c  |    2 +-
 22 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index dba4e70..facf82a 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -127,9 +127,8 @@ #endif
 #define MAX_ILLEGAL_IRQS 16
 
 void
-handle_irq(int irq, struct pt_regs * regs)
+handle_irq(int irq)
 {	
-	struct pt_regs *old_regs;
 	/* 
 	 * We ack quickly, we don't want the irq controller
 	 * thinking we're snobs just because some other CPU has
@@ -150,7 +149,6 @@ handle_irq(int irq, struct pt_regs * reg
 		return;
 	}
 
-	old_regs = set_irq_regs(regs);
 	irq_enter();
 	/*
 	 * __do_IRQ() must be called with IPL_MAX. Note that we do not
@@ -161,5 +159,4 @@ handle_irq(int irq, struct pt_regs * reg
 	local_irq_disable();
 	__do_IRQ(irq);
 	irq_exit();
-	set_irq_regs(old_regs);
 }
diff --git a/arch/alpha/kernel/irq_alpha.c b/arch/alpha/kernel/irq_alpha.c
index d14cc42..51d66b7 100644
--- a/arch/alpha/kernel/irq_alpha.c
+++ b/arch/alpha/kernel/irq_alpha.c
@@ -52,6 +52,7 @@ #else
 #endif
 		break;
 	case 1:
+		old_regs = set_irq_regs(regs);
 #ifdef CONFIG_SMP
 	  {
 		long cpu;
@@ -62,12 +63,13 @@ #ifdef CONFIG_SMP
 		if (cpu != boot_cpuid) {
 		        kstat_cpu(cpu).irqs[RTC_IRQ]++;
 		} else {
-			handle_irq(RTC_IRQ, regs);
+			handle_irq(RTC_IRQ);
 		}
 	  }
 #else
-		handle_irq(RTC_IRQ, regs);
+		handle_irq(RTC_IRQ);
 #endif
+		set_irq_regs(old_regs);
 		return;
 	case 2:
 		alpha_mv.machine_check(vector, la_ptr, regs);
diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 6c70f8b..9405bee 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,13 +147,13 @@ isa_device_interrupt(unsigned long vecto
 	 */
 	int j = *(vuip) IACK_SC;
 	j &= 0xff;
-	handle_irq(j, get_irq_regs());
+	handle_irq(j);
 }
 #endif
 
 #if defined(CONFIG_ALPHA_GENERIC) || !defined(IACK_SC)
 void
-isa_no_iack_sc_device_interrupt(unsigned long vector, struct pt_regs *regs)
+isa_no_iack_sc_device_interrupt(unsigned long vector)
 {
 	unsigned long pic;
 
@@ -176,7 +176,7 @@ isa_no_iack_sc_device_interrupt(unsigned
 	while (pic) {
 		int j = ffz(~pic);
 		pic &= pic - 1;
-		handle_irq(j, regs);
+		handle_irq(j);
 	}
 }
 #endif
diff --git a/arch/alpha/kernel/irq_impl.h b/arch/alpha/kernel/irq_impl.h
index 5d84dbd..cc9a8a7 100644
--- a/arch/alpha/kernel/irq_impl.h
+++ b/arch/alpha/kernel/irq_impl.h
@@ -16,7 +16,7 @@ #include <linux/profile.h>
 #define RTC_IRQ    8
 
 extern void isa_device_interrupt(unsigned long);
-extern void isa_no_iack_sc_device_interrupt(unsigned long, struct pt_regs *);
+extern void isa_no_iack_sc_device_interrupt(unsigned long);
 extern void srm_device_interrupt(unsigned long);
 extern void pyxis_device_interrupt(unsigned long);
 
@@ -39,4 +39,4 @@ extern void i8259a_end_irq(unsigned int)
 extern struct hw_interrupt_type i8259a_irq_type;
 extern void init_i8259a_irqs(void);
 
-extern void handle_irq(int irq, struct pt_regs * regs);
+extern void handle_irq(int irq);
diff --git a/arch/alpha/kernel/irq_pyxis.c b/arch/alpha/kernel/irq_pyxis.c
index 686dc22..d53edbc 100644
--- a/arch/alpha/kernel/irq_pyxis.c
+++ b/arch/alpha/kernel/irq_pyxis.c
@@ -100,7 +100,7 @@ pyxis_device_interrupt(unsigned long vec
 		if (i == 7)
 			isa_device_interrupt(vector);
 		else
-			handle_irq(16+i, get_irq_regs());
+			handle_irq(16+i);
 	}
 }
 
diff --git a/arch/alpha/kernel/irq_srm.c b/arch/alpha/kernel/irq_srm.c
index 2e9f6d4..3221201 100644
--- a/arch/alpha/kernel/irq_srm.c
+++ b/arch/alpha/kernel/irq_srm.c
@@ -75,5 +75,5 @@ void 
 srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
index 2d412c8..49bedfb 100644
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -118,7 +118,7 @@ alcor_device_interrupt(unsigned long vec
 		if (i == 31) {
 			isa_device_interrupt(vector);
 		} else {
-			handle_irq(16 + i, get_irq_regs());
+			handle_irq(16 + i);
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index e75f0ce..ace475c 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -100,7 +100,7 @@ cabriolet_device_interrupt(unsigned long
 		if (i == 4) {
 			isa_device_interrupt(v);
 		} else {
-			handle_irq(16 + i, get_irq_regs());
+			handle_irq(16 + i);
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index 57dce00..85d2f93 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -238,7 +238,7 @@ #else
 		if (i == 55)
 			isa_device_interrupt(vector);
 		else
-			handle_irq(16 + i, get_irq_regs());
+			handle_irq(16 + i);
 #if 0
 		TSUNAMI_cchip->dir0.csr = 1UL << i; mb();
 		tmp = TSUNAMI_cchip->dir0.csr;
@@ -268,7 +268,7 @@ dp264_srm_device_interrupt(unsigned long
 	if (irq >= 32)
 		irq -= 16;
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void 
@@ -290,7 +290,7 @@ clipper_srm_device_interrupt(unsigned lo
 	 *
 	 * Eg IRQ 24 is DRIR bit 8, etc, etc
 	 */
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
index 90d2725..9c5a306 100644
--- a/arch/alpha/kernel/sys_eb64p.c
+++ b/arch/alpha/kernel/sys_eb64p.c
@@ -99,7 +99,7 @@ eb64p_device_interrupt(unsigned long vec
 		if (i == 5) {
 			isa_device_interrupt(vector);
 		} else {
-			handle_irq(16 + i, get_irq_regs());
+			handle_irq(16 + i);
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index f38cded..7ef3b6f 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -118,10 +118,10 @@ eiger_device_interrupt(unsigned long vec
 		 * despatch an interrupt if it's set.
 		 */
 
-		if (intstatus & 8) handle_irq(16+3, get_irq_regs());
-		if (intstatus & 4) handle_irq(16+2, get_irq_regs());
-		if (intstatus & 2) handle_irq(16+1, get_irq_regs());
-		if (intstatus & 1) handle_irq(16+0, get_irq_regs());
+		if (intstatus & 8) handle_irq(16+3);
+		if (intstatus & 4) handle_irq(16+2);
+		if (intstatus & 2) handle_irq(16+1);
+		if (intstatus & 1) handle_irq(16+0);
 	} else {
 		isa_device_interrupt(vector);
 	}
@@ -131,7 +131,7 @@ static void
 eiger_srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index fc31636..a7b8902 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -198,7 +198,7 @@ #define JENSEN_CYCLES_PER_SEC	(150000000
         }
 #endif
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 4ea5615..e349f03 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -64,7 +64,7 @@ io7_device_interrupt(unsigned long vecto
 	irq &= MARVEL_IRQ_VEC_IRQ_MASK;		/* not too many bits */
 	irq |= pid << MARVEL_IRQ_VEC_PE_SHIFT;	/* merge the pid     */
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static volatile unsigned long *
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index fbbd952..b8b817f 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -56,7 +56,7 @@ miata_srm_device_interrupt(unsigned long
 	if (irq >= 16)
 		irq = irq + 8;
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
index 5429ba0..ba98048 100644
--- a/arch/alpha/kernel/sys_mikasa.c
+++ b/arch/alpha/kernel/sys_mikasa.c
@@ -99,7 +99,7 @@ mikasa_device_interrupt(unsigned long ve
 		if (i < 16) {
 			isa_device_interrupt(vector);
 		} else {
-			handle_irq(i, get_irq_regs());
+			handle_irq(i);
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index b9a8434..6798362 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -98,7 +98,7 @@ noritake_device_interrupt(unsigned long 
 		if (i < 16) {
 			isa_device_interrupt(vector);
 		} else {
-			handle_irq(i, get_irq_regs());
+			handle_irq(i);
 		}
 	}
 }
@@ -122,7 +122,7 @@ noritake_srm_device_interrupt(unsigned l
 	if (irq >= 16)
 		irq = irq + 1;
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_rawhide.c b/arch/alpha/kernel/sys_rawhide.c
index bef6516..581d08c 100644
--- a/arch/alpha/kernel/sys_rawhide.c
+++ b/arch/alpha/kernel/sys_rawhide.c
@@ -158,7 +158,7 @@ rawhide_srm_device_interrupt(unsigned lo
 	/* Adjust by which hose it is from.  */
 	irq -= ((irq + 16) >> 2) & 0x38;
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index fa8eef8..ce1faa6 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -102,9 +102,9 @@ rx164_device_interrupt(unsigned long vec
 		i = ffz(~pld);
 		pld &= pld - 1; /* clear least bit set */
 		if (i == 20) {
-			isa_no_iack_sc_device_interrupt(vector, get_irq_regs());
+			isa_no_iack_sc_device_interrupt(vector);
 		} else {
-			handle_irq(16+i, get_irq_regs());
+			handle_irq(16+i);
 		}
 	}
 }
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index 7913791..906019c 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -526,7 +526,7 @@ #if 0
 	printk("%s: vector 0x%lx bit 0x%x irq 0x%x\n",
 	       __FUNCTION__, vector, bit, irq);
 #endif
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
index ce2d3b0..9bd9a31 100644
--- a/arch/alpha/kernel/sys_takara.c
+++ b/arch/alpha/kernel/sys_takara.c
@@ -112,10 +112,10 @@ takara_device_interrupt(unsigned long ve
 		 * despatch an interrupt if it's set.
 		 */
 
-		if (intstatus & 8) handle_irq(16+3, get_irq_regs());
-		if (intstatus & 4) handle_irq(16+2, get_irq_regs());
-		if (intstatus & 2) handle_irq(16+1, get_irq_regs());
-		if (intstatus & 1) handle_irq(16+0, get_irq_regs());
+		if (intstatus & 8) handle_irq(16+3);
+		if (intstatus & 4) handle_irq(16+2);
+		if (intstatus & 2) handle_irq(16+1);
+		if (intstatus & 1) handle_irq(16+0);
 	} else {
 		isa_device_interrupt (vector);
 	}
@@ -125,7 +125,7 @@ static void 
 takara_srm_device_interrupt(unsigned long vector)
 {
 	int irq = (vector - 0x800) >> 4;
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 static void __init
diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
index 1473aa0..e8e8ec9 100644
--- a/arch/alpha/kernel/sys_titan.c
+++ b/arch/alpha/kernel/sys_titan.c
@@ -178,7 +178,7 @@ titan_srm_device_interrupt(unsigned long
 	int irq;
 
 	irq = (vector - 0x800) >> 4;
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 }
 
 
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index ddf5edd..42c3eed 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -246,7 +246,7 @@ wildfire_device_interrupt(unsigned long 
 	 * bits 5-0:	irq in PCA
 	 */
 
-	handle_irq(irq, get_irq_regs());
+	handle_irq(irq);
 	return;
 }
 
-- 
1.4.2.GIT

