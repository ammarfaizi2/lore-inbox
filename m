Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWHJTld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWHJTld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWHJTiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26348 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932696AbWHJThp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:45 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [138/145] i386: remove redundant generic_identify() calls when identifying cpus
Message-Id: <20060810193738.7455013C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:38 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

cpu_dev->c_identify is only called from arch/i386/common.c:identify_cpu(), and
this after generic_identify() already has been called. There is no need to call
this function twice and hook it in c_identify - but I may be wrong, please
double check before applying.

This patch also removes generic_identify() from cpu.h to avoid unnecessary
future nesting.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/cpu/amd.c       |    1 -
 arch/i386/kernel/cpu/common.c    |    2 +-
 arch/i386/kernel/cpu/cpu.h       |    2 --
 arch/i386/kernel/cpu/cyrix.c     |    2 --
 arch/i386/kernel/cpu/intel.c     |    1 -
 arch/i386/kernel/cpu/nexgen.c    |    1 -
 arch/i386/kernel/cpu/transmeta.c |    1 -
 7 files changed, 1 insertion(+), 9 deletions(-)

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -275,7 +275,6 @@ static struct cpu_dev amd_cpu_dev __init
 		},
 	},
 	.c_init		= init_amd,
-	.c_identify	= generic_identify,
 	.c_size_cache	= amd_size_cache,
 };
 
Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -265,7 +265,7 @@ static void __init early_cpu_detect(void
 	}
 }
 
-void __cpuinit generic_identify(struct cpuinfo_x86 * c)
+static void __cpuinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
 	int ebx;
Index: linux/arch/i386/kernel/cpu/cpu.h
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cpu.h
+++ linux/arch/i386/kernel/cpu/cpu.h
@@ -24,7 +24,5 @@ extern struct cpu_dev * cpu_devs [X86_VE
 extern int get_model_name(struct cpuinfo_x86 *c);
 extern void display_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void generic_identify(struct cpuinfo_x86 * c);
-
 extern void early_intel_workaround(struct cpuinfo_x86 *c);
 
Index: linux/arch/i386/kernel/cpu/cyrix.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cyrix.c
+++ linux/arch/i386/kernel/cpu/cyrix.c
@@ -427,7 +427,6 @@ static void __init cyrix_identify(struct
 			local_irq_restore(flags);
 		}
 	}
-	generic_identify(c);
 }
 
 static struct cpu_dev cyrix_cpu_dev __initdata = {
@@ -457,7 +456,6 @@ static struct cpu_dev nsc_cpu_dev __init
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
 	.c_init		= init_nsc,
-	.c_identify	= generic_identify,
 };
 
 int __init nsc_init_cpu(void)
Index: linux/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/intel.c
+++ linux/arch/i386/kernel/cpu/intel.c
@@ -263,7 +263,6 @@ static struct cpu_dev intel_cpu_dev __cp
 		},
 	},
 	.c_init		= init_intel,
-	.c_identify	= generic_identify,
 	.c_size_cache	= intel_size_cache,
 };
 
Index: linux/arch/i386/kernel/cpu/nexgen.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/nexgen.c
+++ linux/arch/i386/kernel/cpu/nexgen.c
@@ -38,7 +38,6 @@ static void __init nexgen_identify(struc
 	if ( deep_magic_nexgen_probe() ) {
 		strcpy(c->x86_vendor_id, "NexGenDriven");
 	}
-	generic_identify(c);
 }
 
 static struct cpu_dev nexgen_cpu_dev __initdata = {
Index: linux/arch/i386/kernel/cpu/transmeta.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/transmeta.c
+++ linux/arch/i386/kernel/cpu/transmeta.c
@@ -88,7 +88,6 @@ static void __init init_transmeta(struct
 static void __init transmeta_identify(struct cpuinfo_x86 * c)
 {
 	u32 xlvl;
-	generic_identify(c);
 
 	/* Transmeta-defined flags: level 0x80860001 */
 	xlvl = cpuid_eax(0x80860000);
