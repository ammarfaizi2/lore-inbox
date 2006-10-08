Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWJHNol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWJHNol (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWJHNol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:44:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60060 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751162AbWJHNok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:44:40 -0400
Date: Sun, 8 Oct 2006 14:44:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] alpha pt_regs cleanups: machine_check()
Message-ID: <20061008134438.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do set_irq_regs() in caller, kill pt_regs argument.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/core_apecs.c    |    5 ++---
 arch/alpha/kernel/core_cia.c      |    5 ++---
 arch/alpha/kernel/core_lca.c      |    6 +++---
 arch/alpha/kernel/core_mcpcia.c   |    5 ++---
 arch/alpha/kernel/core_polaris.c  |    5 ++---
 arch/alpha/kernel/core_t2.c       |    5 ++---
 arch/alpha/kernel/core_tsunami.c  |    5 ++---
 arch/alpha/kernel/core_wildfire.c |    5 ++---
 arch/alpha/kernel/err_ev6.c       |    5 +++--
 arch/alpha/kernel/err_ev7.c       |    2 +-
 arch/alpha/kernel/err_impl.h      |   10 +++++-----
 arch/alpha/kernel/err_marvel.c    |    4 ++--
 arch/alpha/kernel/err_titan.c     |   14 +++++++-------
 arch/alpha/kernel/irq_alpha.c     |   11 ++++++-----
 arch/alpha/kernel/proto.h         |   23 +++++++++++------------
 arch/alpha/kernel/sys_jensen.c    |    2 +-
 arch/alpha/kernel/sys_mikasa.c    |    5 ++---
 arch/alpha/kernel/sys_nautilus.c  |    7 +++----
 arch/alpha/kernel/sys_noritake.c  |    5 ++---
 include/asm-alpha/machvec.h       |    3 +--
 20 files changed, 61 insertions(+), 71 deletions(-)

diff --git a/arch/alpha/kernel/core_apecs.c b/arch/alpha/kernel/core_apecs.c
index a27ba12..ca46b2c 100644
--- a/arch/alpha/kernel/core_apecs.c
+++ b/arch/alpha/kernel/core_apecs.c
@@ -387,8 +387,7 @@ apecs_pci_clr_err(void)
 }
 
 void
-apecs_machine_check(unsigned long vector, unsigned long la_ptr,
-		    struct pt_regs * regs)
+apecs_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	struct el_common *mchk_header;
 	struct el_apecs_procdata *mchk_procdata;
@@ -412,7 +411,7 @@ apecs_machine_check(unsigned long vector
 	wrmces(0x7);		/* reset machine check pending flag */
 	mb();
 
-	process_mcheck_info(vector, la_ptr, regs, "APECS",
+	process_mcheck_info(vector, la_ptr, "APECS",
 			    (mcheck_expected(0)
 			     && (mchk_sysdata->epic_dcsr & 0x0c00UL)));
 }
diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index fd56306..1d6ee6c 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -1192,8 +1192,7 @@ #endif /* CONFIG_VERBOSE_MCHECK */
 }
 
 void
-cia_machine_check(unsigned long vector, unsigned long la_ptr,
-		  struct pt_regs * regs)
+cia_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	int expected;
 
@@ -1208,5 +1207,5 @@ cia_machine_check(unsigned long vector, 
 	expected = mcheck_expected(0);
 	if (!expected && vector == 0x660)
 		expected = cia_decode_mchk(la_ptr);
-	process_mcheck_info(vector, la_ptr, regs, "CIA", expected);
+	process_mcheck_info(vector, la_ptr, "CIA", expected);
 }
diff --git a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
index 6a5a914..4843f6e 100644
--- a/arch/alpha/kernel/core_lca.c
+++ b/arch/alpha/kernel/core_lca.c
@@ -19,6 +19,7 @@ #include <linux/init.h>
 #include <linux/tty.h>
 
 #include <asm/ptrace.h>
+#include <asm/irq_regs.h>
 #include <asm/smp.h>
 
 #include "proto.h"
@@ -386,8 +387,7 @@ ioc_error(__u32 stat0, __u32 stat1)
 }
 
 void
-lca_machine_check(unsigned long vector, unsigned long la_ptr,
-		  struct pt_regs *regs)
+lca_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	const char * reason;
 	union el_lca el;
@@ -397,7 +397,7 @@ lca_machine_check(unsigned long vector, 
 	wrmces(rdmces());	/* reset machine check pending flag */
 
 	printk(KERN_CRIT "LCA machine check: vector=%#lx pc=%#lx code=%#x\n",
-	       vector, regs->pc, (unsigned int) el.c->code);
+	       vector, get_irq_regs()->pc, (unsigned int) el.c->code);
 
 	/*
 	 * The first quadword after the common header always seems to
diff --git a/arch/alpha/kernel/core_mcpcia.c b/arch/alpha/kernel/core_mcpcia.c
index 28849c8..8d01907 100644
--- a/arch/alpha/kernel/core_mcpcia.c
+++ b/arch/alpha/kernel/core_mcpcia.c
@@ -572,8 +572,7 @@ mcpcia_print_system_area(unsigned long l
 }
 
 void
-mcpcia_machine_check(unsigned long vector, unsigned long la_ptr,
-		     struct pt_regs * regs)
+mcpcia_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	struct el_common *mchk_header;
 	struct el_MCPCIA_uncorrected_frame_mcheck *mchk_logout;
@@ -610,7 +609,7 @@ mcpcia_machine_check(unsigned long vecto
 	wrmces(0x7);
 	mb();
 
-	process_mcheck_info(vector, la_ptr, regs, "MCPCIA", expected != 0);
+	process_mcheck_info(vector, la_ptr, "MCPCIA", expected != 0);
 	if (!expected && vector != 0x620 && vector != 0x630) {
 		mcpcia_print_uncorrectable(mchk_logout);
 		mcpcia_print_system_area(la_ptr);
diff --git a/arch/alpha/kernel/core_polaris.c b/arch/alpha/kernel/core_polaris.c
index 277674a..c5a271d 100644
--- a/arch/alpha/kernel/core_polaris.c
+++ b/arch/alpha/kernel/core_polaris.c
@@ -187,8 +187,7 @@ polaris_pci_clr_err(void)
 }
 
 void
-polaris_machine_check(unsigned long vector, unsigned long la_ptr,
-		      struct pt_regs * regs)
+polaris_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	/* Clear the error before any reporting.  */
 	mb();
@@ -198,6 +197,6 @@ polaris_machine_check(unsigned long vect
 	wrmces(0x7);
 	mb();
 
-	process_mcheck_info(vector, la_ptr, regs, "POLARIS",
+	process_mcheck_info(vector, la_ptr, "POLARIS",
 			    mcheck_expected(0));
 }
diff --git a/arch/alpha/kernel/core_t2.c b/arch/alpha/kernel/core_t2.c
index ecce09e..f5ca525 100644
--- a/arch/alpha/kernel/core_t2.c
+++ b/arch/alpha/kernel/core_t2.c
@@ -551,8 +551,7 @@ t2_clear_errors(int cpu)
  * Hence all the taken/expected/any_expected/last_taken stuff...
  */
 void
-t2_machine_check(unsigned long vector, unsigned long la_ptr,
-		 struct pt_regs * regs)
+t2_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	int cpu = smp_processor_id();
 #ifdef CONFIG_VERBOSE_MCHECK
@@ -618,5 +617,5 @@ #ifdef CONFIG_VERBOSE_MCHECK
 	}
 #endif
 
-	process_mcheck_info(vector, la_ptr, regs, "T2", mcheck_expected(cpu));
+	process_mcheck_info(vector, la_ptr, "T2", mcheck_expected(cpu));
 }
diff --git a/arch/alpha/kernel/core_tsunami.c b/arch/alpha/kernel/core_tsunami.c
index 8aa305b..ce623c6 100644
--- a/arch/alpha/kernel/core_tsunami.c
+++ b/arch/alpha/kernel/core_tsunami.c
@@ -443,8 +443,7 @@ tsunami_pci_clr_err(void)
 }
 
 void
-tsunami_machine_check(unsigned long vector, unsigned long la_ptr,
-		      struct pt_regs * regs)
+tsunami_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	/* Clear error before any reporting.  */
 	mb();
@@ -454,6 +453,6 @@ tsunami_machine_check(unsigned long vect
 	wrmces(0x7);
 	mb();
 
-	process_mcheck_info(vector, la_ptr, regs, "TSUNAMI",
+	process_mcheck_info(vector, la_ptr, "TSUNAMI",
 			    mcheck_expected(smp_processor_id()));
 }
diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index 2b767a1..7e07244 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -322,8 +322,7 @@ wildfire_init_arch(void)
 }
 
 void
-wildfire_machine_check(unsigned long vector, unsigned long la_ptr,
-		       struct pt_regs * regs)
+wildfire_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	mb();
 	mb();  /* magic */
@@ -332,7 +331,7 @@ wildfire_machine_check(unsigned long vec
 	wrmces(0x7);
 	mb();
 
-	process_mcheck_info(vector, la_ptr, regs, "WILDFIRE",
+	process_mcheck_info(vector, la_ptr, "WILDFIRE",
 			    mcheck_expected(smp_processor_id()));
 }
 
diff --git a/arch/alpha/kernel/err_ev6.c b/arch/alpha/kernel/err_ev6.c
index 64f59f2..69b5f4e 100644
--- a/arch/alpha/kernel/err_ev6.c
+++ b/arch/alpha/kernel/err_ev6.c
@@ -11,6 +11,7 @@ #include <linux/pci.h>
 #include <linux/sched.h>
 
 #include <asm/io.h>
+#include <asm/irq_regs.h>
 #include <asm/hwrpb.h>
 #include <asm/smp.h>
 #include <asm/err_common.h>
@@ -229,7 +230,7 @@ ev6_process_logout_frame(struct el_commo
 }
 
 void
-ev6_machine_check(u64 vector, u64 la_ptr, struct pt_regs *regs)
+ev6_machine_check(u64 vector, u64 la_ptr)
 {
 	struct el_common *mchk_header = (struct el_common *)la_ptr;
 
@@ -260,7 +261,7 @@ ev6_machine_check(u64 vector, u64 la_ptr
 		       (unsigned int)vector, (int)smp_processor_id());
 		
 		ev6_process_logout_frame(mchk_header, 1);
-		dik_show_regs(regs, NULL);
+		dik_show_regs(get_irq_regs(), NULL);
 
 		err_print_prefix = saved_err_prefix;
 	}
diff --git a/arch/alpha/kernel/err_ev7.c b/arch/alpha/kernel/err_ev7.c
index fed6b3d..95463ab 100644
--- a/arch/alpha/kernel/err_ev7.c
+++ b/arch/alpha/kernel/err_ev7.c
@@ -118,7 +118,7 @@ ev7_collect_logout_frame_subpackets(stru
 }
 
 void
-ev7_machine_check(u64 vector, u64 la_ptr, struct pt_regs *regs)
+ev7_machine_check(u64 vector, u64 la_ptr)
 {
 	struct el_subpacket *el_ptr = (struct el_subpacket *)la_ptr;
 	char *saved_err_prefix = err_print_prefix;
diff --git a/arch/alpha/kernel/err_impl.h b/arch/alpha/kernel/err_impl.h
index 64e9b73..3c12258 100644
--- a/arch/alpha/kernel/err_impl.h
+++ b/arch/alpha/kernel/err_impl.h
@@ -60,26 +60,26 @@ extern struct ev7_lf_subpackets *
 ev7_collect_logout_frame_subpackets(struct el_subpacket *,
 				    struct ev7_lf_subpackets *);
 extern void ev7_register_error_handlers(void);
-extern void ev7_machine_check(u64, u64, struct pt_regs *);
+extern void ev7_machine_check(u64, u64);
 
 /*
  * err_ev6.c
  */
 extern void ev6_register_error_handlers(void);
 extern int ev6_process_logout_frame(struct el_common *, int);
-extern void ev6_machine_check(u64, u64, struct pt_regs *);
+extern void ev6_machine_check(u64, u64);
 
 /*
  * err_marvel.c
  */
-extern void marvel_machine_check(u64, u64, struct pt_regs *);
+extern void marvel_machine_check(u64, u64);
 extern void marvel_register_error_handlers(void);
 
 /*
  * err_titan.c
  */
 extern int titan_process_logout_frame(struct el_common *, int);
-extern void titan_machine_check(u64, u64, struct pt_regs *);
+extern void titan_machine_check(u64, u64);
 extern void titan_register_error_handlers(void);
 extern int privateer_process_logout_frame(struct el_common *, int);
-extern void privateer_machine_check(u64, u64, struct pt_regs *);
+extern void privateer_machine_check(u64, u64);
diff --git a/arch/alpha/kernel/err_marvel.c b/arch/alpha/kernel/err_marvel.c
index 70b38b1..f2956ac 100644
--- a/arch/alpha/kernel/err_marvel.c
+++ b/arch/alpha/kernel/err_marvel.c
@@ -1042,7 +1042,7 @@ #define EV7__RBOX_INT__IO_ERROR__MASK 0x
 }
 
 void
-marvel_machine_check(u64 vector, u64 la_ptr, struct pt_regs *regs)
+marvel_machine_check(u64 vector, u64 la_ptr)
 {
 	struct el_subpacket *el_ptr = (struct el_subpacket *)la_ptr;
 	int (*process_frame)(struct ev7_lf_subpackets *, int) = NULL;
@@ -1077,7 +1077,7 @@ marvel_machine_check(u64 vector, u64 la_
 
 	default:
 		/* Don't know it - pass it up.  */
-		ev7_machine_check(vector, la_ptr, regs);
+		ev7_machine_check(vector, la_ptr);
 		return;
 	}	
 
diff --git a/arch/alpha/kernel/err_titan.c b/arch/alpha/kernel/err_titan.c
index 7e6720d..2e6e629 100644
--- a/arch/alpha/kernel/err_titan.c
+++ b/arch/alpha/kernel/err_titan.c
@@ -379,7 +379,7 @@ titan_process_logout_frame(struct el_com
 }
 
 void
-titan_machine_check(u64 vector, u64 la_ptr, struct pt_regs *regs)
+titan_machine_check(u64 vector, u64 la_ptr)
 {
 	struct el_common *mchk_header = (struct el_common *)la_ptr;
 	struct el_TITAN_sysdata_mcheck *tmchk =
@@ -408,7 +408,7 @@ #define TITAN_MCHECK_INTERRUPT_MASK	0xF8
 	 * Only handle system errors here 
 	 */
 	if ((vector != SCB_Q_SYSMCHK) && (vector != SCB_Q_SYSERR)) {
-		ev6_machine_check(vector, la_ptr, regs);
+		ev6_machine_check(vector, la_ptr);
 		return;
 	}
 
@@ -442,7 +442,7 @@ #define TITAN_MCHECK_INTERRUPT_MASK	0xF8
 #ifdef CONFIG_VERBOSE_MCHECK
 		titan_process_logout_frame(mchk_header, alpha_verbose_mcheck);
 		if (alpha_verbose_mcheck)
-			dik_show_regs(regs, NULL);
+			dik_show_regs(get_irq_regs(), NULL);
 #endif /* CONFIG_VERBOSE_MCHECK */
 
 		err_print_prefix = saved_err_prefix;
@@ -452,7 +452,7 @@ #endif /* CONFIG_VERBOSE_MCHECK */
 		 * machine checks to interrupts
 		 */
 		irqmask = tmchk->c_dirx & TITAN_MCHECK_INTERRUPT_MASK;
-		titan_dispatch_irqs(irqmask, regs);
+		titan_dispatch_irqs(irqmask, get_irq_regs());
 	}	
 
 
@@ -701,7 +701,7 @@ #define PRIVATEER_MCHK__SYS_ENVIRON		0x2
 }
 
 void
-privateer_machine_check(u64 vector, u64 la_ptr, struct pt_regs *regs)
+privateer_machine_check(u64 vector, u64 la_ptr)
 {
 	struct el_common *mchk_header = (struct el_common *)la_ptr;
 	struct el_TITAN_sysdata_mcheck *tmchk =
@@ -723,7 +723,7 @@ #define PRIVATEER_HOTPLUG_INTERRUPT_MASK
 	 * Only handle system events here.
 	 */
 	if (vector != SCB_Q_SYSEVENT) 
-		return titan_machine_check(vector, la_ptr, regs);
+		return titan_machine_check(vector, la_ptr);
 
 	/*
 	 * Report the event - System Events should be reported even if no
@@ -746,7 +746,7 @@ #define PRIVATEER_HOTPLUG_INTERRUPT_MASK
 	/*
 	 * Dispatch the interrupt(s).
 	 */
-	titan_dispatch_irqs(irqmask, regs);
+	titan_dispatch_irqs(irqmask, get_irq_regs());
 
 	/* 
 	 * Release the logout frame.
diff --git a/arch/alpha/kernel/irq_alpha.c b/arch/alpha/kernel/irq_alpha.c
index 51d66b7..6dd126b 100644
--- a/arch/alpha/kernel/irq_alpha.c
+++ b/arch/alpha/kernel/irq_alpha.c
@@ -72,7 +72,9 @@ #endif
 		set_irq_regs(old_regs);
 		return;
 	case 2:
-		alpha_mv.machine_check(vector, la_ptr, regs);
+		old_regs = set_irq_regs(regs);
+		alpha_mv.machine_check(vector, la_ptr);
+		set_irq_regs(old_regs);
 		return;
 	case 3:
 		old_regs = set_irq_regs(regs);
@@ -125,8 +127,7 @@ #endif
 
 void
 process_mcheck_info(unsigned long vector, unsigned long la_ptr,
-		    struct pt_regs *regs, const char *machine,
-		    int expected)
+		    const char *machine, int expected)
 {
 	struct el_common *mchk_header;
 	const char *reason;
@@ -153,7 +154,7 @@ #endif
 	mchk_header = (struct el_common *)la_ptr;
 
 	printk(KERN_CRIT "%s machine check: vector=0x%lx pc=0x%lx code=0x%x\n",
-	       machine, vector, regs->pc, mchk_header->code);
+	       machine, vector, get_irq_regs()->pc, mchk_header->code);
 
 	switch (mchk_header->code) {
 	/* Machine check reasons.  Defined according to PALcode sources.  */
@@ -194,7 +195,7 @@ #endif
 	printk(KERN_CRIT "machine check type: %s%s\n",
 	       reason, mchk_header->retry ? " (retryable)" : "");
 
-	dik_show_regs(regs, NULL);
+	dik_show_regs(get_irq_regs(), NULL);
 
 #ifdef CONFIG_VERBOSE_MCHECK
 	if (alpha_verbose_mcheck > 1) {
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 408bda2..3fff887 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -20,7 +20,7 @@ struct pci_controller;
 extern struct pci_ops apecs_pci_ops;
 extern void apecs_init_arch(void);
 extern void apecs_pci_clr_err(void);
-extern void apecs_machine_check(u64, u64, struct pt_regs *);
+extern void apecs_machine_check(u64, u64);
 extern void apecs_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_cia.c */
@@ -29,7 +29,7 @@ extern void cia_init_pci(void);
 extern void cia_init_arch(void);
 extern void pyxis_init_arch(void);
 extern void cia_kill_arch(int);
-extern void cia_machine_check(u64, u64, struct pt_regs *);
+extern void cia_machine_check(u64, u64);
 extern void cia_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_irongate.c */
@@ -42,14 +42,14 @@ #define irongate_pci_tbi ((void *)0)
 /* core_lca.c */
 extern struct pci_ops lca_pci_ops;
 extern void lca_init_arch(void);
-extern void lca_machine_check(u64, u64, struct pt_regs *);
+extern void lca_machine_check(u64, u64);
 extern void lca_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_marvel.c */
 extern struct pci_ops marvel_pci_ops;
 extern void marvel_init_arch(void);
 extern void marvel_kill_arch(int);
-extern void marvel_machine_check(u64, u64, struct pt_regs *);
+extern void marvel_machine_check(u64, u64);
 extern void marvel_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 extern int marvel_pa_to_nid(unsigned long);
 extern int marvel_cpuid_to_nid(int);
@@ -64,7 +64,7 @@ void io7_clear_errors(struct io7 *io7);
 extern struct pci_ops mcpcia_pci_ops;
 extern void mcpcia_init_arch(void);
 extern void mcpcia_init_hoses(void);
-extern void mcpcia_machine_check(u64, u64, struct pt_regs *);
+extern void mcpcia_machine_check(u64, u64);
 extern void mcpcia_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_polaris.c */
@@ -72,21 +72,21 @@ extern struct pci_ops polaris_pci_ops;
 extern int polaris_read_config_dword(struct pci_dev *, int, u32 *);
 extern int polaris_write_config_dword(struct pci_dev *, int, u32);
 extern void polaris_init_arch(void);
-extern void polaris_machine_check(u64, u64, struct pt_regs *);
+extern void polaris_machine_check(u64, u64);
 #define polaris_pci_tbi ((void *)0)
 
 /* core_t2.c */
 extern struct pci_ops t2_pci_ops;
 extern void t2_init_arch(void);
 extern void t2_kill_arch(int);
-extern void t2_machine_check(u64, u64, struct pt_regs *);
+extern void t2_machine_check(u64, u64);
 extern void t2_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_titan.c */
 extern struct pci_ops titan_pci_ops;
 extern void titan_init_arch(void);
 extern void titan_kill_arch(int);
-extern void titan_machine_check(u64, u64, struct pt_regs *);
+extern void titan_machine_check(u64, u64);
 extern void titan_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 extern struct _alpha_agp_info *titan_agp_info(void);
 
@@ -94,14 +94,14 @@ extern struct _alpha_agp_info *titan_agp
 extern struct pci_ops tsunami_pci_ops;
 extern void tsunami_init_arch(void);
 extern void tsunami_kill_arch(int);
-extern void tsunami_machine_check(u64, u64, struct pt_regs *);
+extern void tsunami_machine_check(u64, u64);
 extern void tsunami_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 
 /* core_wildfire.c */
 extern struct pci_ops wildfire_pci_ops;
 extern void wildfire_init_arch(void);
 extern void wildfire_kill_arch(int);
-extern void wildfire_machine_check(u64, u64, struct pt_regs *);
+extern void wildfire_machine_check(u64, u64);
 extern void wildfire_pci_tbi(struct pci_controller *, dma_addr_t, dma_addr_t);
 extern int wildfire_pa_to_nid(unsigned long);
 extern int wildfire_cpuid_to_nid(int);
@@ -214,5 +214,4 @@ #define mcheck_extra(cpu)	(*((void)(cpu)
 #endif
 
 extern void process_mcheck_info(unsigned long vector, unsigned long la_ptr,
-				struct pt_regs *regs, const char *machine,
-				int expected);
+				const char *machine, int expected);
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index a7b8902..2c3de97 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -244,7 +244,7 @@ #endif
 }
 
 static void
-jensen_machine_check (u64 vector, u64 la, struct pt_regs *regs)
+jensen_machine_check (u64 vector, u64 la)
 {
 	printk(KERN_CRIT "Machine check\n");
 }
diff --git a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
index ba98048..8d3e942 100644
--- a/arch/alpha/kernel/sys_mikasa.c
+++ b/arch/alpha/kernel/sys_mikasa.c
@@ -182,8 +182,7 @@ mikasa_map_irq(struct pci_dev *dev, u8 s
 
 #if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
 static void
-mikasa_apecs_machine_check(unsigned long vector, unsigned long la_ptr,
-		           struct pt_regs * regs)
+mikasa_apecs_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 #define MCHK_NO_DEVSEL 0x205U
 #define MCHK_NO_TABT 0x204U
@@ -202,7 +201,7 @@ #define MCHK_NO_TABT 0x204U
 	mb();
 
 	code = mchk_header->code;
-	process_mcheck_info(vector, la_ptr, regs, "MIKASA APECS",
+	process_mcheck_info(vector, la_ptr, "MIKASA APECS",
 			    (mcheck_expected(0)
 			     && (code == MCHK_NO_DEVSEL
 			         || code == MCHK_NO_TABT)));
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index c0d696e..93744ba 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -124,8 +124,7 @@ naut_sys_machine_check(unsigned long vec
    in the system.  They are analysed separately but all starts here.  */
 
 void
-nautilus_machine_check(unsigned long vector, unsigned long la_ptr,
-		       struct pt_regs *regs)
+nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	char *mchk_class;
 
@@ -165,7 +164,7 @@ nautilus_machine_check(unsigned long vec
 	else if (vector == SCB_Q_SYSMCHK)
 		mchk_class = "Fatal";
 	else {
-		ev6_machine_check(vector, la_ptr, regs);
+		ev6_machine_check(vector, la_ptr);
 		return;
 	}
 
@@ -173,7 +172,7 @@ nautilus_machine_check(unsigned long vec
 			 "[%s System Machine Check (NMI)]\n",
 	       vector, mchk_class);
 
-	naut_sys_machine_check(vector, la_ptr, regs);
+	naut_sys_machine_check(vector, la_ptr, get_irq_regs());
 
 	/* Tell the PALcode to clear the machine check */
 	draina();
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index 6798362..de6ba34 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -264,8 +264,7 @@ noritake_swizzle(struct pci_dev *dev, u8
 
 #if defined(CONFIG_ALPHA_GENERIC) || !defined(CONFIG_ALPHA_PRIMO)
 static void
-noritake_apecs_machine_check(unsigned long vector, unsigned long la_ptr,
-			     struct pt_regs * regs)
+noritake_apecs_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 #define MCHK_NO_DEVSEL 0x205U
 #define MCHK_NO_TABT 0x204U
@@ -284,7 +283,7 @@ #define MCHK_NO_TABT 0x204U
         mb();
 
         code = mchk_header->code;
-        process_mcheck_info(vector, la_ptr, regs, "NORITAKE APECS",
+        process_mcheck_info(vector, la_ptr, "NORITAKE APECS",
                             (mcheck_expected(0)
                              && (code == MCHK_NO_DEVSEL
                                  || code == MCHK_NO_TABT)));
diff --git a/include/asm-alpha/machvec.h b/include/asm-alpha/machvec.h
index 7ae7442..a86c083 100644
--- a/include/asm-alpha/machvec.h
+++ b/include/asm-alpha/machvec.h
@@ -15,7 +15,6 @@ #ifdef __KERNEL__
 
 struct task_struct;
 struct mm_struct;
-struct pt_regs;
 struct vm_area_struct;
 struct linux_hose_info;
 struct pci_dev;
@@ -80,7 +79,7 @@ struct alpha_machine_vector
 	void (*update_irq_hw)(unsigned long, unsigned long, int);
 	void (*ack_irq)(unsigned long);
 	void (*device_interrupt)(unsigned long vector);
-	void (*machine_check)(u64 vector, u64 la, struct pt_regs *regs);
+	void (*machine_check)(u64 vector, u64 la);
 
 	void (*smp_callin)(void);
 	void (*init_arch)(void);
-- 
1.4.2.GIT

