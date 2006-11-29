Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966246AbWK2IKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966246AbWK2IKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966227AbWK2IKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:10:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55210 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966222AbWK2IKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:10:41 -0500
Date: Wed, 29 Nov 2006 09:08:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mm-commits@vger.kernel.org, ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genapic: default to physical mode on hotplug CPU kernels
Message-ID: <20061129080834.GA10199@elte.hu>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu> <20061128111414.A16460@unix-os.sc.intel.com> <20061128202322.GA29334@elte.hu> <20061128143145.B16460@unix-os.sc.intel.com> <20061129071023.GA651@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129071023.GA651@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> hm - indeed. Then we can indeed do the patch below. Nice simplification!

forgot to convert a few more places - full patch below.

	Ingo

----------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] genapic: default to physical mode on hotplug CPU kernels

default to physical mode on hotplug CPU kernels. Furher simplify and
clean up the APIC initialization code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/acpi/boot.c              |    2 +-
 arch/i386/kernel/mpparse.c                |    2 +-
 arch/x86_64/kernel/genapic.c              |   20 +++-----------------
 arch/x86_64/kernel/mpparse.c              |    2 +-
 include/asm-i386/genapic.h                |    4 ++--
 include/asm-i386/mach-bigsmp/mach_apic.h  |    2 +-
 include/asm-i386/mach-default/mach_apic.h |    2 +-
 include/asm-i386/mach-es7000/mach_apic.h  |    2 +-
 include/asm-i386/mach-generic/mach_apic.h |    2 +-
 include/asm-i386/mach-numaq/mach_apic.h   |    2 +-
 include/asm-i386/mach-summit/mach_apic.h  |    2 +-
 include/asm-i386/mach-visws/mach_apic.h   |    2 +-
 include/asm-x86_64/apic.h                 |    2 +-
 13 files changed, 16 insertions(+), 30 deletions(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -921,7 +921,7 @@ static void __init acpi_process_madt(voi
 				acpi_ioapic = 1;
 
 				smp_found_config = 1;
-				clustered_apic_check();
+				setup_apic_routing();
 			}
 		}
 		if (error == -EINVAL) {
Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c
+++ linux/arch/i386/kernel/mpparse.c
@@ -479,7 +479,7 @@ static int __init smp_read_mpc(struct mp
 		}
 		++mpc_record;
 	}
-	clustered_apic_check();
+	setup_apic_routing();
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
Index: linux/arch/x86_64/kernel/genapic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic.c
+++ linux/arch/x86_64/kernel/genapic.c
@@ -33,25 +33,11 @@ u8 x86_cpu_to_log_apicid[NR_CPUS]	= { [0
 struct genapic __read_mostly *genapic = &apic_flat;
 
 /*
- * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
+ * Choose the APIC routing mode:
  */
-void __init clustered_apic_check(void)
+void __init setup_apic_routing(void)
 {
-	unsigned int i, max_apic = 0;
-	u8 id;
-
-	/*
-	 * Determine the maximum APIC ID in use:
-	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		id = bios_cpu_apicid[i];
-		if (id == BAD_APICID)
-			continue;
-		if (id > max_apic)
-			max_apic = id;
-	}
-
-	if (max_apic < 8)
+	if (cpus_weight(cpu_possible_map) <= 8)
 		genapic = &apic_flat;
 	else
 		genapic = &apic_physflat;
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -302,7 +302,7 @@ static int __init smp_read_mpc(struct mp
 			}
 		}
 	}
-	clustered_apic_check();
+	setup_apic_routing();
 	if (!num_processors)
 		printk(KERN_ERR "MPTABLE: no processors registered!\n");
 	return num_processors;
Index: linux/include/asm-i386/genapic.h
===================================================================
--- linux.orig/include/asm-i386/genapic.h
+++ linux/include/asm-i386/genapic.h
@@ -36,7 +36,7 @@ struct genapic { 
 	void (*init_apic_ldr)(void);
 	physid_mask_t (*ioapic_phys_id_map)(physid_mask_t map);
 
-	void (*clustered_apic_check)(void);
+	void (*setup_apic_routing)(void);
 	int (*multi_timer_check)(int apic, int irq);
 	int (*apicid_to_node)(int logical_apicid); 
 	int (*cpu_to_logical_apicid)(int cpu);
@@ -99,7 +99,7 @@ struct genapic { 
 	APICFUNC(check_apicid_present) \
 	APICFUNC(init_apic_ldr) \
 	APICFUNC(ioapic_phys_id_map) \
-	APICFUNC(clustered_apic_check) \
+	APICFUNC(setup_apic_routing) \
 	APICFUNC(multi_timer_check) \
 	APICFUNC(apicid_to_node) \
 	APICFUNC(cpu_to_logical_apicid) \
Index: linux/include/asm-i386/mach-bigsmp/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-bigsmp/mach_apic.h
+++ linux/include/asm-i386/mach-bigsmp/mach_apic.h
@@ -71,7 +71,7 @@ static inline void init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 		"Physflat", nr_ioapics);
Index: linux/include/asm-i386/mach-default/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-default/mach_apic.h
+++ linux/include/asm-i386/mach-default/mach_apic.h
@@ -54,7 +54,7 @@ static inline physid_mask_t ioapic_phys_
 	return phys_map;
 }
 
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 					"Flat", nr_ioapics);
Index: linux/include/asm-i386/mach-es7000/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-es7000/mach_apic.h
+++ linux/include/asm-i386/mach-es7000/mach_apic.h
@@ -81,7 +81,7 @@ static inline void enable_apic_mode(void
 }
 
 extern int apic_version [MAX_APICS];
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 	int apic = bios_cpu_apicid[smp_processor_id()];
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus %lx\n",
Index: linux/include/asm-i386/mach-generic/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-generic/mach_apic.h
+++ linux/include/asm-i386/mach-generic/mach_apic.h
@@ -13,7 +13,7 @@
 #define apic_id_registered (genapic->apic_id_registered)
 #define init_apic_ldr (genapic->init_apic_ldr)
 #define ioapic_phys_id_map (genapic->ioapic_phys_id_map)
-#define clustered_apic_check (genapic->clustered_apic_check) 
+#define setup_apic_routing (genapic->setup_apic_routing)
 #define multi_timer_check (genapic->multi_timer_check)
 #define apicid_to_node (genapic->apicid_to_node)
 #define cpu_to_logical_apicid (genapic->cpu_to_logical_apicid) 
Index: linux/include/asm-i386/mach-numaq/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-numaq/mach_apic.h
+++ linux/include/asm-i386/mach-numaq/mach_apic.h
@@ -34,7 +34,7 @@ static inline void init_apic_ldr(void)
 	/* Already done in NUMA-Q firmware */
 }
 
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 		"NUMA-Q", nr_ioapics);
Index: linux/include/asm-i386/mach-summit/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-summit/mach_apic.h
+++ linux/include/asm-i386/mach-summit/mach_apic.h
@@ -80,7 +80,7 @@ static inline int apic_id_registered(voi
 	return 1;
 }
 
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 	printk("Enabling APIC mode:  Summit.  Using %d I/O APICs\n",
 						nr_ioapics);
Index: linux/include/asm-i386/mach-visws/mach_apic.h
===================================================================
--- linux.orig/include/asm-i386/mach-visws/mach_apic.h
+++ linux/include/asm-i386/mach-visws/mach_apic.h
@@ -47,7 +47,7 @@ static inline void summit_check(char *oe
 {
 }
 
-static inline void clustered_apic_check(void)
+static inline void setup_apic_routing(void)
 {
 }
 
Index: linux/include/asm-x86_64/apic.h
===================================================================
--- linux.orig/include/asm-x86_64/apic.h
+++ linux/include/asm-x86_64/apic.h
@@ -82,7 +82,7 @@ extern void setup_secondary_APIC_clock (
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
-extern void clustered_apic_check(void);
+extern void setup_apic_routing(void);
 static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void setup_APIC_extened_lvt(unsigned char lvt_off, unsigned char vector,
