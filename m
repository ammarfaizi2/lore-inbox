Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUDWCac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUDWCac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 22:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbUDWCab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 22:30:31 -0400
Received: from ns.suse.de ([195.135.220.2]:18085 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264656AbUDWCaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 22:30:06 -0400
Date: Fri, 23 Apr 2004 04:30:01 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: [PATCH] New version of early CPU detect
Message-Id: <20040423043001.4bb05d5f.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We still need some kind of early CPU detection, e.g. for the AMD768 workaround
and for the slab allocator to size its slabs correctly for the cache line.
Also some other code already had private early CPU routines.

This patch takes a new approach compared to the previous patch which caused
Andrew so much grief. It only fills in a few selected fields in boot_cpu_data
(only the data needed to identify the CPU type and the cache alignment).
In particular the feature masks are not filled in, and the other fields
are also not touched to prevent unwanted side effects.

Also convert the ppro workaround to use standard cpu data now. 

Please consider applying to -mm.

I'm not sure if slab still has the necessary support to use the cache line size
early; previously Manfred showed some serious memory saving with this for kernels
that are compiled for a bigger cache line size than the CPU (is often the case on 
distribution kernels). This code could be reenable now with this patch.

-Andi

diff -u linux-2.6.5-i386/arch/i386/kernel/cpu/common.c-o linux-2.6.5-i386/arch/i386/kernel/cpu/common.c
--- linux-2.6.5-i386/arch/i386/kernel/cpu/common.c-o	2004-03-21 21:12:03.000000000 +0100
+++ linux-2.6.5-i386/arch/i386/kernel/cpu/common.c	2004-04-21 17:05:06.000000000 +0200
@@ -137,8 +137,7 @@
 }
 
 
-
-void __init get_cpu_vendor(struct cpuinfo_x86 *c)
+void __init get_cpu_vendor(struct cpuinfo_x86 *c, int early)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -149,7 +148,8 @@
 			    (cpu_devs[i]->c_ident[1] && 
 			     !strcmp(v,cpu_devs[i]->c_ident[1]))) {
 				c->x86_vendor = i;
-				this_cpu = cpu_devs[i];
+				if (!early) 
+					this_cpu = cpu_devs[i];
 				break;
 			}
 		}
@@ -193,6 +193,44 @@
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
 
+/* Do minimum CPU detection early. 
+   Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
+   The others are not touched to avoid unwanted side effects. */
+void __init early_cpu_detect(void) 
+{ 
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (!have_cpuid_p())
+		return;
+
+	/* Get vendor name */
+	cpuid(0x00000000, &c->cpuid_level,
+	      (int *)&c->x86_vendor_id[0],
+	      (int *)&c->x86_vendor_id[8],
+	      (int *)&c->x86_vendor_id[4]);
+	
+	get_cpu_vendor(c, 1);
+
+	c->x86 = 4;
+	c->x86_cache_alignment = 32;
+
+	if (c->cpuid_level >= 0x00000001) {
+		u32 junk, tfms, cap0, misc;
+		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
+		c->x86 = (tfms >> 8) & 15;
+		c->x86_model = (tfms >> 4) & 15;
+		if (c->x86 == 0xf) {
+			c->x86 += (tfms >> 20) & 0xff;
+			c->x86_model += ((tfms >> 16) & 0xF) << 4;
+		} 
+		c->x86_mask = tfms & 15;
+		if (cap0 & (1<<19)) 
+			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
+	}
+
+	early_intel_workaround(c); 
+} 
+
 void __init generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
@@ -205,7 +243,7 @@
 		      (int *)&c->x86_vendor_id[8],
 		      (int *)&c->x86_vendor_id[4]);
 		
-		get_cpu_vendor(c);
+		get_cpu_vendor(c, 0);
 		/* Initialize the standard set of capabilities */
 		/* Note that the vendor-specific code below might override */
 	
@@ -383,7 +421,6 @@
  
 void __init dodgy_tsc(void)
 {
-	get_cpu_vendor(&boot_cpu_data);
 	if (( boot_cpu_data.x86_vendor == X86_VENDOR_CYRIX ) ||
 	    ( boot_cpu_data.x86_vendor == X86_VENDOR_NSC   ))
 		cpu_devs[X86_VENDOR_CYRIX]->c_init(&boot_cpu_data);
@@ -431,9 +468,11 @@
 extern int rise_init_cpu(void);
 extern int nexgen_init_cpu(void);
 extern int umc_init_cpu(void);
+void early_cpu_detect(void);
 
 void __init early_cpu_init(void)
 {
+	early_cpu_detect();
 	intel_cpu_init();
 	cyrix_init_cpu();
 	nsc_init_cpu();
diff -u linux-2.6.5-i386/arch/i386/kernel/cpu/cpu.h-o linux-2.6.5-i386/arch/i386/kernel/cpu/cpu.h
--- linux-2.6.5-i386/arch/i386/kernel/cpu/cpu.h-o	2004-03-21 21:12:03.000000000 +0100
+++ linux-2.6.5-i386/arch/i386/kernel/cpu/cpu.h	2004-04-21 14:53:41.000000000 +0200
@@ -26,3 +26,6 @@
 
 extern void generic_identify(struct cpuinfo_x86 * c);
 extern int have_cpuid_p(void);
+
+extern void early_intel_workaround(struct cpuinfo_x86 *c);
+
diff -u linux-2.6.5-i386/arch/i386/kernel/cpu/intel.c-o linux-2.6.5-i386/arch/i386/kernel/cpu/intel.c
--- linux-2.6.5-i386/arch/i386/kernel/cpu/intel.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-i386/arch/i386/kernel/cpu/intel.c	2004-04-21 17:06:00.000000000 +0200
@@ -28,6 +28,15 @@
 struct movsl_mask movsl_mask;
 #endif
 
+void __init early_intel_workaround(struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return; 
+	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
+	if (c->x86 == 15 && c->x86_cache_alignment == 64) 
+		c->x86_cache_alignment = 128;
+}
+
 /*
  *	Early probe support logic for ppro memory erratum #50
  *
@@ -36,42 +45,14 @@
  
 int __init ppro_with_ram_bug(void)
 {
-	char vendor_id[16];
-	int ident;
-
-	/* Must have CPUID */
-	if(!have_cpuid_p())
-		return 0;
-	if(cpuid_eax(0)<1)
-		return 0;
-	
-	/* Must be Intel */
-	cpuid(0, &ident, 
-		(int *)&vendor_id[0],
-		(int *)&vendor_id[8],
-		(int *)&vendor_id[4]);
-	
-	if(memcmp(vendor_id, "IntelInside", 12))
-		return 0;
-	
-	ident = cpuid_eax(1);
-
-	/* Model 6 */
-
-	if(((ident>>8)&15)!=6)
-		return 0;
-	
-	/* Pentium Pro */
-
-	if(((ident>>4)&15)!=1)
-		return 0;
-	
-	if((ident&15) < 8)
-	{
+	/* Uses data from early_cpu_detect now */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86 == 6 &&
+	    boot_cpu_data.x86_model == 1 && 
+	    boot_cpu_data.x86_mask < 8) { 
 		printk(KERN_INFO "Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
 	}
-	printk(KERN_INFO "Your Pentium Pro seems ok.\n");
 	return 0;
 }
 	
