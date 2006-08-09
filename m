Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWHIBCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWHIBCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWHIBCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:16 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:53166 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030383AbWHIBCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:16 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010350.25458.46602.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 02/06] i386: remove redundant generic_identify() calls when identifying cpus
Date: Wed,  9 Aug 2006 10:03:02 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: remove redundant generic_identify() calls when identifying cpus

cpu_dev->c_identify is only called from arch/i386/common.c:identify_cpu(), and
this after generic_identify() already has been called. There is no need to call
this function twice and hook it in c_identify - but I may be wrong, please
double check before applying.

This patch also removes generic_identify() from cpu.h to avoid unnecessary
future nesting.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 amd.c       |    1 -
 common.c    |    2 +-
 cpu.h       |    2 --
 cyrix.c     |    2 --
 intel.c     |    1 -
 nexgen.c    |    1 -
 transmeta.c |    1 -
 7 files changed, 1 insertion(+), 9 deletions(-)

--- 0001/arch/i386/kernel/cpu/amd.c
+++ work/arch/i386/kernel/cpu/amd.c	2006-08-09 07:51:46.000000000 +0900
@@ -275,7 +275,6 @@ static struct cpu_dev amd_cpu_dev __init
 		},
 	},
 	.c_init		= init_amd,
-	.c_identify	= generic_identify,
 	.c_size_cache	= amd_size_cache,
 };
 
--- 0001/arch/i386/kernel/cpu/common.c
+++ work/arch/i386/kernel/cpu/common.c	2006-08-09 08:06:33.000000000 +0900
@@ -265,7 +265,7 @@ static void __init early_cpu_detect(void
 	}
 }
 
-void __cpuinit generic_identify(struct cpuinfo_x86 * c)
+static void __cpuinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
 	int ebx;
--- 0001/arch/i386/kernel/cpu/cpu.h
+++ work/arch/i386/kernel/cpu/cpu.h	2006-08-09 07:52:07.000000000 +0900
@@ -24,7 +24,5 @@ extern struct cpu_dev * cpu_devs [X86_VE
 extern int get_model_name(struct cpuinfo_x86 *c);
 extern void display_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void generic_identify(struct cpuinfo_x86 * c);
-
 extern void early_intel_workaround(struct cpuinfo_x86 *c);
 
--- 0004/arch/i386/kernel/cpu/cyrix.c
+++ work/arch/i386/kernel/cpu/cyrix.c	2006-08-09 08:04:46.000000000 +0900
@@ -427,7 +427,6 @@ static void __cpuinit cyrix_identify(str
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
--- 0001/arch/i386/kernel/cpu/intel.c
+++ work/arch/i386/kernel/cpu/intel.c	2006-08-09 07:51:40.000000000 +0900
@@ -263,7 +263,6 @@ static struct cpu_dev intel_cpu_dev __cp
 		},
 	},
 	.c_init		= init_intel,
-	.c_identify	= generic_identify,
 	.c_size_cache	= intel_size_cache,
 };
 
--- 0004/arch/i386/kernel/cpu/nexgen.c
+++ work/arch/i386/kernel/cpu/nexgen.c	2006-08-09 07:52:47.000000000 +0900
@@ -38,7 +38,6 @@ static void __cpuinit nexgen_identify(st
 	if ( deep_magic_nexgen_probe() ) {
 		strcpy(c->x86_vendor_id, "NexGenDriven");
 	}
-	generic_identify(c);
 }
 
 static struct cpu_dev nexgen_cpu_dev __initdata = {
--- 0004/arch/i386/kernel/cpu/transmeta.c
+++ work/arch/i386/kernel/cpu/transmeta.c	2006-08-09 07:53:37.000000000 +0900
@@ -88,7 +88,6 @@ static void __init init_transmeta(struct
 static void __cpuinit transmeta_identify(struct cpuinfo_x86 * c)
 {
 	u32 xlvl;
-	generic_identify(c);
 
 	/* Transmeta-defined flags: level 0x80860001 */
 	xlvl = cpuid_eax(0x80860000);
