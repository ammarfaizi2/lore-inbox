Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWBAEyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWBAEyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWBAEyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:54:24 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:58825 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030294AbWBAEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:54:24 -0500
Date: Tue, 31 Jan 2006 23:49:43 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4] i386: __init should be __cpuinit
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601312352_MC3-1-B748-FCE9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HOTPLUG_CPU on i386 there are places where __init[data] is
referenced from normal code.

On startup:
        arch/i386/kernel/cpu/amd.c::amd_init_cpu():
                cpu_devs[X86_VENDOR_AMD] = &amd_cpu_dev;        
        amd_cpu_dev is declared __initdata and is freed

On CPU hotplug:
        arch/i386/kernel/cpu/common.c::get_cpu_vendor():
               for (i = 0; i < X86_VENDOR_NUM; i++) {
                        if (cpu_devs[i]) {
                                if (!strcmp(v,cpu_devs[i]->c_ident[0]) ||

To fix this, change every instance of __init that seems suspicious
into __cpuinit.  When !CONFIG_HOTPLUG_CPU there is no change in .text
or .data size.  When enabled, .text += 3248 bytes; .data += 2148 bytes.

This should be safe in every case; the only drawback is the extra code and
data when CPU hotplug is enabled.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/cpu/amd.c             |    4 +--
 arch/i386/kernel/cpu/centaur.c         |   22 +++++++++----------
 arch/i386/kernel/cpu/cyrix.c           |   37 ++++++++++++++++-----------------
 arch/i386/kernel/cpu/intel_cacheinfo.c |    1 
 arch/i386/kernel/cpu/nexgen.c          |    8 +++----
 arch/i386/kernel/cpu/rise.c            |    4 +--
 6 files changed, 39 insertions(+), 37 deletions(-)

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/amd.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/amd.c
@@ -22,7 +22,7 @@
 extern void vide(void);
 __asm__(".align 4\nvide: ret");
 
-static void __init init_amd(struct cpuinfo_x86 *c)
+static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int mbytes = num_physpages >> (20-PAGE_SHIFT);
@@ -255,7 +255,7 @@ static unsigned int amd_size_cache(struc
 	return size;
 }
 
-static struct cpu_dev amd_cpu_dev __initdata = {
+static struct cpu_dev amd_cpu_dev __cpuinitdata = {
 	.c_vendor	= "AMD",
 	.c_ident 	= { "AuthenticAMD" },
 	.c_models = {
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/centaur.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/centaur.c
@@ -8,7 +8,7 @@
 
 #ifdef CONFIG_X86_OOSTORE
 
-static u32 __init power2(u32 x)
+static u32 __cpuinit power2(u32 x)
 {
 	u32 s=1;
 	while(s<=x)
@@ -21,7 +21,7 @@ static u32 __init power2(u32 x)
  *	Set up an actual MCR
  */
  
-static void __init centaur_mcr_insert(int reg, u32 base, u32 size, int key)
+static void __cpuinit centaur_mcr_insert(int reg, u32 base, u32 size, int key)
 {
 	u32 lo, hi;
 	
@@ -39,7 +39,7 @@ static void __init centaur_mcr_insert(in
  *	Shortcut: We know you can't put 4Gig of RAM on a winchip
  */
 
-static u32 __init ramtop(void)		/* 16388 */
+static u32 __cpuinit ramtop(void)		/* 16388 */
 {
 	int i;
 	u32 top = 0;
@@ -90,7 +90,7 @@ static u32 __init ramtop(void)		/* 16388
  *	Compute a set of MCR's to give maximum coverage
  */
 
-static int __init centaur_mcr_compute(int nr, int key)
+static int __cpuinit centaur_mcr_compute(int nr, int key)
 {
 	u32 mem = ramtop();
 	u32 root = power2(mem);
@@ -165,7 +165,7 @@ static int __init centaur_mcr_compute(in
 	return ct;
 }
 
-static void __init centaur_create_optimal_mcr(void)
+static void __cpuinit centaur_create_optimal_mcr(void)
 {
 	int i;
 	/*
@@ -188,7 +188,7 @@ static void __init centaur_create_optima
 		wrmsr(MSR_IDT_MCR0+i, 0, 0);
 }
 
-static void __init winchip2_create_optimal_mcr(void)
+static void __cpuinit winchip2_create_optimal_mcr(void)
 {
 	u32 lo, hi;
 	int i;
@@ -226,7 +226,7 @@ static void __init winchip2_create_optim
  *	Handle the MCR key on the Winchip 2.
  */
 
-static void __init winchip2_unprotect_mcr(void)
+static void __cpuinit winchip2_unprotect_mcr(void)
 {
 	u32 lo, hi;
 	u32 key;
@@ -238,7 +238,7 @@ static void __init winchip2_unprotect_mc
 	wrmsr(MSR_IDT_MCR_CTRL, lo, hi);
 }
 
-static void __init winchip2_protect_mcr(void)
+static void __cpuinit winchip2_protect_mcr(void)
 {
 	u32 lo, hi;
 	
@@ -256,7 +256,7 @@ static void __init winchip2_protect_mcr(
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
-static void __init init_c3(struct cpuinfo_x86 *c)
+static void __cpuinit init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
 
@@ -302,7 +302,7 @@ static void __init init_c3(struct cpuinf
 	display_cacheinfo(c);
 }
 
-static void __init init_centaur(struct cpuinfo_x86 *c)
+static void __cpuinit init_centaur(struct cpuinfo_x86 *c)
 {
 	enum {
 		ECX8=1<<1,
@@ -456,7 +456,7 @@ static unsigned int centaur_size_cache(s
 	return size;
 }
 
-static struct cpu_dev centaur_cpu_dev __initdata = {
+static struct cpu_dev centaur_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Centaur",
 	.c_ident	= { "CentaurHauls" },
 	.c_init		= init_centaur,
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/cyrix.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/cyrix.c
@@ -12,7 +12,7 @@
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-static void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void __cpuinit do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
 	unsigned long flags;
@@ -52,25 +52,25 @@ static void __init do_cyrix_devid(unsign
  * Actually since bugs.h doesn't even reference this perhaps someone should
  * fix the documentation ???
  */
-static unsigned char Cx86_dir0_msb __initdata = 0;
+static unsigned char Cx86_dir0_msb __cpuinitdata = 0;
 
-static char Cx86_model[][9] __initdata = {
+static char Cx86_model[][9] __cpuinitdata = {
 	"Cx486", "Cx486", "5x86 ", "6x86", "MediaGX ", "6x86MX ",
 	"M II ", "Unknown"
 };
-static char Cx486_name[][5] __initdata = {
+static char Cx486_name[][5] __cpuinitdata = {
 	"SLC", "DLC", "SLC2", "DLC2", "SRx", "DRx",
 	"SRx2", "DRx2"
 };
-static char Cx486S_name[][4] __initdata = {
+static char Cx486S_name[][4] __cpuinitdata = {
 	"S", "S2", "Se", "S2e"
 };
-static char Cx486D_name[][4] __initdata = {
+static char Cx486D_name[][4] __cpuinitdata = {
 	"DX", "DX2", "?", "?", "?", "DX4"
 };
-static char Cx86_cb[] __initdata = "?.5x Core/Bus Clock";
-static char cyrix_model_mult1[] __initdata = "12??43";
-static char cyrix_model_mult2[] __initdata = "12233445";
+static char Cx86_cb[] __cpuinitdata = "?.5x Core/Bus Clock";
+static char cyrix_model_mult1[] __cpuinitdata = "12??43";
+static char cyrix_model_mult2[] __cpuinitdata = "12233445";
 
 /*
  * Reset the slow-loop (SLOP) bit on the 686(L) which is set by some old
@@ -80,9 +80,10 @@ static char cyrix_model_mult2[] __initda
  * FIXME: our newer udelay uses the tsc. We don't need to frob with SLOP
  */
 
-extern void calibrate_delay(void) __init;
+/* is __devinit, should be __cpuinit in init/calibrate.c ??? */
+extern void calibrate_delay(void) __devinit;
 
-static void __init check_cx686_slop(struct cpuinfo_x86 *c)
+static void __cpuinit check_cx686_slop(struct cpuinfo_x86 *c)
 {
 	unsigned long flags;
 	
@@ -107,7 +108,7 @@ static void __init check_cx686_slop(stru
 }
 
 
-static void __init set_cx86_reorder(void)
+static void __cpuinit set_cx86_reorder(void)
 {
 	u8 ccr3;
 
@@ -122,7 +123,7 @@ static void __init set_cx86_reorder(void
 	setCx86(CX86_CCR3, ccr3);
 }
 
-static void __init set_cx86_memwb(void)
+static void __cpuinit set_cx86_memwb(void)
 {
 	u32 cr0;
 
@@ -137,7 +138,7 @@ static void __init set_cx86_memwb(void)
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x14 );
 }
 
-static void __init set_cx86_inc(void)
+static void __cpuinit set_cx86_inc(void)
 {
 	unsigned char ccr3;
 
@@ -158,7 +159,7 @@ static void __init set_cx86_inc(void)
  *	Configure later MediaGX and/or Geode processor.
  */
 
-static void __init geode_configure(void)
+static void __cpuinit geode_configure(void)
 {
 	unsigned long flags;
 	u8 ccr3, ccr4;
@@ -191,7 +192,7 @@ static struct pci_device_id cyrix_55x0[]
 };
 #endif
 
-static void __init init_cyrix(struct cpuinfo_x86 *c)
+static void __cpuinit init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
@@ -429,7 +430,7 @@ static void cyrix_identify(struct cpuinf
 	generic_identify(c);
 }
 
-static struct cpu_dev cyrix_cpu_dev __initdata = {
+static struct cpu_dev cyrix_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Cyrix",
 	.c_ident 	= { "CyrixInstead" },
 	.c_init		= init_cyrix,
@@ -444,7 +445,7 @@ int __init cyrix_init_cpu(void)
 
 //early_arch_initcall(cyrix_init_cpu);
 
-static struct cpu_dev nsc_cpu_dev __initdata = {
+static struct cpu_dev nsc_cpu_dev __cpuinitdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
 	.c_init		= init_nsc,
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/nexgen.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/nexgen.c
@@ -10,7 +10,7 @@
  *	to have CPUID. (Thanks to Herbert Oppmann)
  */
  
-static int __init deep_magic_nexgen_probe(void)
+static int __cpuinit deep_magic_nexgen_probe(void)
 {
 	int ret;
 	
@@ -27,12 +27,12 @@ static int __init deep_magic_nexgen_prob
 	return  ret;
 }
 
-static void __init init_nexgen(struct cpuinfo_x86 * c)
+static void __cpuinit init_nexgen(struct cpuinfo_x86 * c)
 {
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
 
-static void __init nexgen_identify(struct cpuinfo_x86 * c)
+static void __cpuinit nexgen_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect NexGen with old hypercode */
 	if ( deep_magic_nexgen_probe() ) {
@@ -41,7 +41,7 @@ static void __init nexgen_identify(struc
 	generic_identify(c);
 }
 
-static struct cpu_dev nexgen_cpu_dev __initdata = {
+static struct cpu_dev nexgen_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Nexgen",
 	.c_ident	= { "NexGenDriven" },
 	.c_models = {
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/rise.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/rise.c
@@ -5,7 +5,7 @@
 
 #include "cpu.h"
 
-static void __init init_rise(struct cpuinfo_x86 *c)
+static void __cpuinit init_rise(struct cpuinfo_x86 *c)
 {
 	printk("CPU: Rise iDragon");
 	if (c->x86_model > 2)
@@ -28,7 +28,7 @@ static void __init init_rise(struct cpui
 	set_bit(X86_FEATURE_CX8, c->x86_capability);
 }
 
-static struct cpu_dev rise_cpu_dev __initdata = {
+static struct cpu_dev rise_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Rise",
 	.c_ident	= { "RiseRiseRise" },
 	.c_models = {
--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -152,6 +152,7 @@ static int __cpuinit cpuid4_cache_lookup
 	return 0;
 }
 
+/* __init is safe here */
 static int __init find_num_cache_leaves(void)
 {
 	unsigned int		eax, ebx, ecx, edx;
-- 
Chuck
