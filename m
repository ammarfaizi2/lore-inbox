Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVA0Gyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVA0Gyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVA0Gyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:54:31 -0500
Received: from embeddededge.com ([209.113.146.155]:63498 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S262479AbVA0GyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:54:15 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-4--347377266
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] add AMD Geode processor support
From: Dan Malek <dan@embeddedalley.com>
Date: Wed, 26 Jan 2005 22:54:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4--347377266
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Hi Marcelo!

Here is a patch for 2.4 that adds the basic AMD Geode GX2/GX3
and GX1/SC1200 support.  This patch updates configuration
scripts, defconfig, and setup files.

Signed-off-by: Dan Malek <dan@embeddedalley.com>


--Apple-Mail-4--347377266
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="geode_x86.patch"
Content-Disposition: attachment;
	filename=geode_x86.patch

diff -Naru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	2004-11-17 03:54:21.000000000 -0800
+++ b/arch/i386/config.in	2005-01-26 17:03:43.000000000 -0800
@@ -42,6 +42,8 @@
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
 	 Winchip-2				CONFIG_MWINCHIP2 \
 	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
+	 Geode-GX1/SC1200			CONFIG_GEODE_SC1200 \
+	 Geode-GX2/GX3				CONFIG_GEODE_GX2 \
 	 CyrixIII/VIA-C3			CONFIG_MCYRIXIII \
 	 VIA-C3-2				CONFIG_MVIAC3_2" Pentium-Pro
 #
@@ -139,9 +141,31 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y 	
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
+
+if [ "$CONFIG_GEODE_SC1200" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_USE_STRING_486 y
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
+
+if [ "$CONFIG_GEODE_GX2" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_MTRR n
+   define_bool CONFIG_X86_LOCAL_APIC n
+   define_bool CONFIG_X86_GOOD_APIC n
+   define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_MCE n
 fi
+
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y
@@ -192,7 +216,9 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 
+if [ "$CONFIG_GEODE_GX2" != "y" ]; then
 bool 'Machine Check Exception' CONFIG_X86_MCE
+fi
 
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
 tristate 'Dell laptop support' CONFIG_I8K
@@ -205,10 +231,19 @@
    tristate 'BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)' CONFIG_EDD
 fi
 
-choice 'High Memory Support' \
+# GX2/3 does not have PAE support, so don't give em the option of 64G support
+
+if [ "$CONFIG_GEODE_GX2" != "y" ]; then
+	choice 'High Memory Support' \
 	"off    CONFIG_NOHIGHMEM \
 	 4GB    CONFIG_HIGHMEM4G \
 	 64GB   CONFIG_HIGHMEM64G" off
+else
+	choice 'High Memory Support' \
+	"off	CONFIG_NOHIGHMEM \
+	 4GB	CONFIG_HIGHMEM4G" off
+fi
+
 if [ "$CONFIG_HIGHMEM4G" = "y" -o "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
 else
@@ -223,16 +258,22 @@
 fi
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
+
+if [ "$CONFIG_GEODE_GX2" != "y" ]; then
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
+fi
+
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
-   bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
-   dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
-   if [ "$CONFIG_X86_UP_APIC" = "y" ]; then
-      define_bool CONFIG_X86_LOCAL_APIC y
-   fi
-   if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
-      define_bool CONFIG_X86_IO_APIC y
+   if [ "$CONFIG_GEODE_GX2" != "y" ]; then
+   	bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
+   	dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
+   	if [ "$CONFIG_X86_UP_APIC" = "y" ]; then
+      	define_bool CONFIG_X86_LOCAL_APIC y
+   	fi
+   	if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
+      	define_bool CONFIG_X86_IO_APIC y
+   	fi 
    fi
 else
    int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
diff -Naru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2004-08-07 16:26:04.000000000 -0700
+++ b/arch/i386/kernel/setup.c	2005-01-26 17:03:43.000000000 -0800
@@ -74,6 +74,9 @@
  *  Provisions for empty E820 memory regions (reported by certain BIOSes).
  *  Alex Achenbach <xela@slit.de>, December 2002.
  *
+ *  AMD Geode support by Lycoris Solutions Team and NSC Longmont.
+ *  solutions@lycoris.com, john.zulauf@amd.com.  December 2003.
+ *
  */
 
 /*
@@ -1544,6 +1547,52 @@
 	return r;
 }
 
+static int __init init_amd_geode(struct cpuinfo_x86 *c)
+{
+
+	int r;
+
+	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
+	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
+	clear_bit(0*32+31, &c->x86_capability);
+	
+	r = get_model_name(c);
+
+	switch(c->x86_model)
+	{
+	        case 4: /* GX1/SCxx00 */
+
+			/* GX1 uses bits 16 and 24 differently - 
+			   you could probably just do 
+
+			   clear_bit(0*32+16, &c->x86_capability);
+			   clear_bit(0*32+24, &c->x86_capability);
+
+			   since I don't think the kernel supports
+			   FPU-CMOV or Cyrix MMX.  Unsure tho.
+
+			   Also checking GX1 cache here needs to be done -
+			   display_cacheinfo() won't work according to
+			   AMD specs.
+			*/
+
+			break;
+
+		case 5: /* GX2 */
+			display_cacheinfo(c);
+			break;
+			
+	        case 10: /* GX3 */
+			/* What else needs to happen here? */
+			display_cacheinfo(c);
+			break;
+			
+
+	}
+
+	return r;
+}
+
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
@@ -2904,11 +2953,24 @@
 		break;
 
 	case X86_VENDOR_NSC:
-	        init_cyrix(c);
+             /* NSC chips with TFMS of 0x54n or 0x55n are Geode 
+		- do a special init */
+		if ( (c->x86 == 5) &&
+		     (c->x86_model >= 4 && c->x86_model <= 5))
+			init_amd_geode(c);
+		else
+		        init_cyrix(c);
 		break;
 
 	case X86_VENDOR_AMD:
-		init_amd(c);
+		/* Unlike its predecessors, the GX3 flavor of the 
+		   Geode family declares itself as an AuthenticAMD,
+		   so check for that here */
+		
+		if (c->x86 == 5 && c->x86_model == 10)
+			init_amd_geode(c);
+		else
+			init_amd(c);
 		break;
 
 	case X86_VENDOR_CENTAUR:
diff -Naru a/include/asm-i386/msr.h b/include/asm-i386/msr.h
--- a/include/asm-i386/msr.h	2003-11-28 10:26:21.000000000 -0800
+++ b/include/asm-i386/msr.h	2005-01-26 17:03:43.000000000 -0800
@@ -1,6 +1,8 @@
 #ifndef __ASM_MSR_H
 #define __ASM_MSR_H
 
+#include <linux/config.h>
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -17,8 +19,14 @@
 			  : /* no outputs */ \
 			  : "c" (msr), "a" (val1), "d" (val2))
 
+#ifdef CONFIG_GEODE_SC1200
+#define rdtsc(low,high) \
+     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high)); \
+    if ((unsigned long) low > 0xFFFFFFFC) high--
+#else
 #define rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
+#endif
 
 #define rdtscl(low) \
      __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
diff -Naru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	2005-01-19 06:09:25.000000000 -0800
+++ b/arch/i386/defconfig	2005-01-26 17:59:24.000000000 -0800
@@ -36,6 +36,8 @@
 # CONFIG_MWINCHIPC6 is not set
 # CONFIG_MWINCHIP2 is not set
 # CONFIG_MWINCHIP3D is not set
+# CONFIG_GEODE_SC1200 is not set
+# CONFIG_GEODE_GX2 is not set
 # CONFIG_MCYRIXIII is not set
 # CONFIG_MVIAC3_2 is not set
 CONFIG_X86_WP_WORKS_OK=y
@@ -274,6 +276,7 @@
 # CONFIG_BLK_DEV_TRIFLEX is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_CS5535 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set

--Apple-Mail-4--347377266--

