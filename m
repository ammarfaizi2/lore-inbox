Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVANVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVANVuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVANVtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:49:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:32711 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262171AbVANVji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:39:38 -0500
Date: Fri, 14 Jan 2005 13:39:13 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: ak@suse.de
Subject: [Patch] x86_64: use cpumask_t instead of unsigned long
Message-ID: <20050114133912.B13523@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another cpumask_t related fix. Please apply.

thanks,
suresh
--

Use cpumask_t instead of unsigned long.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.10/arch/x86_64/kernel/mce.c linux-cpumask/arch/x86_64/kernel/mce.c
--- linux-2.6.10/arch/x86_64/kernel/mce.c	2004-12-24 13:34:30.000000000 -0800
+++ linux-cpumask/arch/x86_64/kernel/mce.c	2005-01-14 13:21:37.536627920 -0800
@@ -311,12 +311,12 @@
  */
 void __init mcheck_init(struct cpuinfo_x86 *c)
 {
-	static unsigned long mce_cpus __initdata = 0;
+	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
 
 	mce_cpu_quirks(c); 
 
 	if (mce_dont_init ||
-	    test_and_set_bit(smp_processor_id(), &mce_cpus) ||
+	    cpu_test_and_set(smp_processor_id(), mce_cpus) ||
 	    !mce_available(c))
 		return;
 
diff -Nru linux-2.6.10/arch/x86_64/kernel/setup64.c linux-cpumask/arch/x86_64/kernel/setup64.c
--- linux-2.6.10/arch/x86_64/kernel/setup64.c	2004-12-24 13:34:29.000000000 -0800
+++ linux-cpumask/arch/x86_64/kernel/setup64.c	2005-01-14 13:21:29.657825680 -0800
@@ -28,7 +28,7 @@
 
 char x86_boot_params[2048] __initdata = {0,};
 
-unsigned long cpu_initialized __initdata = 0;
+cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
 
 struct x8664_pda cpu_pda[NR_CPUS] __cacheline_aligned; 
 
@@ -199,7 +199,7 @@
 
 	me = current;
 
-	if (test_and_set_bit(cpu, &cpu_initialized))
+	if (cpu_test_and_set(cpu, cpu_initialized))
 		panic("CPU#%d already initialized!\n", cpu);
 
 	printk("Initializing CPU#%d\n", cpu);
diff -Nru linux-2.6.10/include/asm-x86_64/proto.h linux-cpumask/include/asm-x86_64/proto.h
--- linux-2.6.10/include/asm-x86_64/proto.h	2004-12-24 13:35:27.000000000 -0800
+++ linux-cpumask/include/asm-x86_64/proto.h	2005-01-14 13:21:32.499393696 -0800
@@ -54,7 +54,7 @@
 
 extern unsigned long end_pfn_map; 
 
-extern unsigned long cpu_initialized;
+extern cpumask_t cpu_initialized;
 
 extern void show_trace(unsigned long * rsp);
 extern void show_registers(struct pt_regs *regs);
