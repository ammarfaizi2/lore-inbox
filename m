Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWCaFpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWCaFpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWCaFpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:45:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:30158 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750893AbWCaFpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:45:02 -0500
Date: Thu, 30 Mar 2006 23:43:50 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: Please pull from 'for_paulus' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603302342470.15997-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/kernel/setup_32.c            |    6 ----
 arch/powerpc/kernel/traps.c               |    9 ++----
 arch/powerpc/platforms/83xx/mpc834x_sys.c |   40 +++++++++++++++---------------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   40 +++++++++++++++---------------
 4 files changed, 43 insertions(+), 52 deletions(-)

Kumar Gala:
      powerpc: merge machine_check_exception between ppc32 & ppc64
      powerpc: converted embedded platforms to use new define_machine support

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a72bf5d..69ac257 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -50,7 +50,6 @@
 #include <asm/kgdb.h>
 #endif
 
-extern void platform_init(void);
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
 boot_infos_t *boot_infos;
@@ -138,12 +137,7 @@ void __init machine_init(unsigned long d
 		strlcpy(cmd_line, CONFIG_CMDLINE, sizeof(cmd_line));
 #endif /* CONFIG_CMDLINE */
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
 	probe_machine();
-#else
-	/* Base init based on machine type. Obsoloete, please kill ! */
-	platform_init();
-#endif
 
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4cbde21..064a525 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -228,7 +228,7 @@ void system_reset_exception(struct pt_re
  */
 static inline int check_io_access(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC_PMAC
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
 	unsigned long msr = regs->msr;
 	const struct exception_table_entry *entry;
 	unsigned int *nip = (unsigned int *)regs->nip;
@@ -261,7 +261,7 @@ static inline int check_io_access(struct
 			return 1;
 		}
 	}
-#endif /* CONFIG_PPC_PMAC */
+#endif /* CONFIG_PPC_PMAC && CONFIG_PPC32 */
 	return 0;
 }
 
@@ -308,8 +308,8 @@ platform_machine_check(struct pt_regs *r
 
 void machine_check_exception(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC64
 	int recover = 0;
+	unsigned long reason = get_mc_reason(regs);
 
 	/* See if any machine dependent calls */
 	if (ppc_md.machine_check_exception)
@@ -317,8 +317,6 @@ void machine_check_exception(struct pt_r
 
 	if (recover)
 		return;
-#else
-	unsigned long reason = get_mc_reason(regs);
 
 	if (user_mode(regs)) {
 		regs->msr |= MSR_RI;
@@ -462,7 +460,6 @@ void machine_check_exception(struct pt_r
 	 * additional info, e.g. bus error registers.
 	 */
 	platform_machine_check(regs);
-#endif /* CONFIG_PPC64 */
 
 	if (debugger_fault_handler(regs))
 		return;
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 7c18b4c..7e789d2 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -158,25 +158,25 @@ static int __init mpc834x_rtc_hookup(voi
 late_initcall(mpc834x_rtc_hookup);
 #endif
 
-void __init platform_init(void)
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc834x_sys_probe(void)
 {
-	/* setup the PowerPC module struct */
-	ppc_md.setup_arch = mpc834x_sys_setup_arch;
-
-	ppc_md.init_IRQ = mpc834x_sys_init_IRQ;
-	ppc_md.get_irq = ipic_get_irq;
-
-	ppc_md.restart = mpc83xx_restart;
-
-	ppc_md.time_init = mpc83xx_time_init;
-	ppc_md.set_rtc_time = NULL;
-	ppc_md.get_rtc_time = NULL;
-	ppc_md.calibrate_decr = generic_calibrate_decr;
-
-	ppc_md.progress = udbg_progress;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc834x_sys_init(): exit", 0);
-
-	return;
+	/* We always match for now, eventually we should look at the flat
+	   dev tree to ensure this is the board we are suppose to run on
+	*/
+	return 1;
 }
+
+define_machine(mpc834x_sys) {
+	.name			= "MPC834x SYS",
+	.probe			= mpc834x_sys_probe,
+	.setup_arch		= mpc834x_sys_setup_arch,
+	.init_IRQ		= mpc834x_sys_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.restart		= mpc83xx_restart,
+	.time_init		= mpc83xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index b7821db..5eeff37 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -220,25 +220,25 @@ void mpc85xx_ads_show_cpuinfo(struct seq
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
-void __init platform_init(void)
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc85xx_ads_probe(void)
 {
-	ppc_md.setup_arch = mpc85xx_ads_setup_arch;
-	ppc_md.show_cpuinfo = mpc85xx_ads_show_cpuinfo;
-
-	ppc_md.init_IRQ = mpc85xx_ads_pic_init;
-	ppc_md.get_irq = mpic_get_irq;
-
-	ppc_md.restart = mpc85xx_restart;
-	ppc_md.power_off = NULL;
-	ppc_md.halt = NULL;
-
-	ppc_md.time_init = NULL;
-	ppc_md.set_rtc_time = NULL;
-	ppc_md.get_rtc_time = NULL;
-	ppc_md.calibrate_decr = generic_calibrate_decr;
-
-	ppc_md.progress = udbg_progress;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc85xx_ads platform_init(): exit", 0);
+	/* We always match for now, eventually we should look at the flat
+	   dev tree to ensure this is the board we are suppose to run on
+	*/
+	return 1;
 }
+
+define_machine(mpc85xx_ads) {
+	.name			= "MPC85xx ADS",
+	.probe			= mpc85xx_ads_probe,
+	.setup_arch		= mpc85xx_ads_setup_arch,
+	.init_IRQ		= mpc85xx_ads_pic_init,
+	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= mpc85xx_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};


