Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUH3FGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUH3FGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 01:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUH3FGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 01:06:03 -0400
Received: from ozlabs.org ([203.10.76.45]:49586 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266820AbUH3FF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 01:05:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.46549.83968.875041@cargo.ozlabs.ibm.com>
Date: Mon, 30 Aug 2004 15:06:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: nathanl@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (2/3) Set platform cpuids later in boot
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the initialization of the per-cpu paca->hw_cpu_id out of the Open
Firmware client boot code and into a common location which is executed
later.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/setup.c~ppc64-later-cpuid-setup arch/ppc64/kernel/setup.c
--- 2.6.9-rc1-bk2/arch/ppc64/kernel/setup.c~ppc64-later-cpuid-setup	2004-08-26 21:56:37.000000000 -0500
+++ 2.6.9-rc1-bk2-nathanl/arch/ppc64/kernel/setup.c	2004-08-26 21:56:37.000000000 -0500
@@ -170,6 +170,8 @@ void __init disable_early_printk(void)
  *
  * This function is valid only for Open Firmware systems.  finish_device_tree
  * must be called before using this.
+ *
+ * While we're here, we may as well set the "physical" cpu ids in the paca.
  */
 static void __init setup_cpu_maps(void)
 {
@@ -182,11 +184,15 @@ static void __init setup_cpu_maps(void)
 
 		intserv = (u32 *)get_property(dn, "ibm,ppc-interrupt-server#s",
 					      &len);
+		if (!intserv)
+			intserv = (u32 *)get_property(dn, "reg", NULL);
+
 		nthreads = len / sizeof(u32);
 
 		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
 			cpu_set(cpu, cpu_possible_map);
 			cpu_set(cpu, cpu_present_map);
+			set_hard_smp_processor_id(cpu, intserv[j]);
 			cpu++;
 		}
 	}
diff -puN arch/ppc64/kernel/prom.c~ppc64-later-cpuid-setup arch/ppc64/kernel/prom.c
--- 2.6.9-rc1-bk2/arch/ppc64/kernel/prom.c~ppc64-later-cpuid-setup	2004-08-26 21:56:37.000000000 -0500
+++ 2.6.9-rc1-bk2-nathanl/arch/ppc64/kernel/prom.c	2004-08-26 21:56:37.000000000 -0500
@@ -919,31 +919,11 @@ static void __init prom_hold_cpus(unsign
 	unsigned long secondary_hold
 		= virt_to_abs(*PTRRELOC((unsigned long *)__secondary_hold));
 	struct systemcfg *_systemcfg = RELOC(systemcfg);
-	struct paca_struct *lpaca = PTRRELOC(&paca[0]);
 	struct prom_t *_prom = PTRRELOC(&prom);
 #ifdef CONFIG_SMP
 	struct naca_struct *_naca = RELOC(naca);
 #endif
 
-	/* On pmac, we just fill out the various global bitmasks and
-	 * arrays indicating our CPUs are here, they are actually started
-	 * later on from pmac_smp
-	 */
-	if (_systemcfg->platform == PLATFORM_POWERMAC) {
-		for (node = 0; prom_next_node(&node); ) {
-			type[0] = 0;
-			prom_getprop(node, "device_type", type, sizeof(type));
-			if (strcmp(type, RELOC("cpu")) != 0)
-				continue;
-			reg = -1;
-			prom_getprop(node, "reg", &reg, sizeof(reg));
-			lpaca[cpuid].hw_cpu_id = reg;
-
-			cpuid++;
-		}
-		return;
-	}
-
 	prom_debug("prom_hold_cpus: start...\n");
 	prom_debug("    1) spinloop       = 0x%x\n", (unsigned long)spinloop);
 	prom_debug("    1) *spinloop      = 0x%x\n", *spinloop);
@@ -987,7 +967,6 @@ static void __init prom_hold_cpus(unsign
 
 		prom_debug("\ncpuid        = 0x%x\n", cpuid);
 		prom_debug("cpu hw idx   = 0x%x\n", reg);
-		lpaca[cpuid].hw_cpu_id = reg;
 
 		/* Init the acknowledge var which will be reset by
 		 * the secondary cpu when it awakens from its OF
@@ -1044,7 +1023,6 @@ next:
 			cpuid++;
 			if (cpuid >= NR_CPUS)
 				continue;
-			lpaca[cpuid].hw_cpu_id = interrupt_server[i];
 			prom_printf("%x : preparing thread ... ",
 				    interrupt_server[i]);
 			if (_naca->smt_state) {
diff -puN include/asm-ppc64/smp.h~ppc64-later-cpuid-setup include/asm-ppc64/smp.h
--- 2.6.9-rc1-bk2/include/asm-ppc64/smp.h~ppc64-later-cpuid-setup	2004-08-26 21:56:37.000000000 -0500
+++ 2.6.9-rc1-bk2-nathanl/include/asm-ppc64/smp.h	2004-08-26 21:56:37.000000000 -0500
@@ -63,7 +63,7 @@ extern int query_cpu_stopped(unsigned in
 
 #define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
 #define set_hard_smp_processor_id(CPU, VAL) \
-	do { (paca[(CPU)].hw_proc_num = (VAL)); } while (0)
+	do { (paca[(CPU)].hw_cpu_id = (VAL)); } while (0)
 
 #endif /* __ASSEMBLY__ */
 

