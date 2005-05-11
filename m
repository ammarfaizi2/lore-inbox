Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVELIDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVELIDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVELIDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:03:52 -0400
Received: from [24.10.253.213] ([24.10.253.213]:25728 "EHLO linux.site")
	by vger.kernel.org with ESMTP id S261300AbVELICf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:02:35 -0400
Subject: [patch 1/1] Do not enforce unique IO_APIC_ID check for xAPIC systems (i386)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       linux-kernel@vger.kernel.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Wed, 11 May 2005 05:57:54 -0700
Message-Id: <20050511125755.5ADA442AE9@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is per Andi's request to remove NO_IOAPIC_CHECK from genapic and use heuristics to prevent unique I/O APIC ID check for systems that don't need it.
The patch disables unique I/O APIC ID check for Xeon-based and other platforms that don't use serial APIC bus for interrupt delivery. Andi stated that AMD systems don't need unique IO_APIC_IDs either.

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/i386/kernel/mpparse.c~no-ioapic-check-i386 arch/i386/kernel/mpparse.c
--- linux-2.6.13-rc3-mm3/arch/i386/kernel/mpparse.c~no-ioapic-check-i386	2005-05-11 02:01:51.642551064 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/i386/kernel/mpparse.c	2005-05-11 02:05:07.334801320 -0700
@@ -912,7 +912,10 @@ void __init mp_register_ioapic (
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 < 15))
+		mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	else
+		mp_ioapics[idx].mpc_apicid = id;
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
diff -puN arch/i386/kernel/io_apic.c~no-ioapic-check-i386 arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc3-mm3/arch/i386/kernel/io_apic.c~no-ioapic-check-i386	2005-05-11 02:01:51.693543312 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/i386/kernel/io_apic.c	2005-05-11 04:51:38.005988440 -0700
@@ -1680,6 +1680,12 @@ static void __init setup_ioapic_ids_from
 	unsigned char old_id;
 	unsigned long flags;
 
+	/* 
+	 * Don't check I/O APIC IDs for xAPIC systems.  They have
+	 * no meaning without the serial APIC bus.
+	 */
+	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86 < 15))
+		return;
 	/*
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
@@ -1706,10 +1712,6 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
 		}
 
-		/* Don't check I/O APIC IDs for some xAPIC systems.  They have
-		 * no meaning without the serial APIC bus. */
-		if (NO_IOAPIC_CHECK)
-			continue;
 		/*
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
diff -puN include/asm-i386/genapic.h~no-ioapic-check-i386 include/asm-i386/genapic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/genapic.h~no-ioapic-check-i386	2005-05-11 02:01:51.729537840 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/genapic.h	2005-05-11 02:12:08.537768736 -0700
@@ -78,7 +78,6 @@ struct genapic { 
 	.int_delivery_mode = INT_DELIVERY_MODE, \
 	.int_dest_mode = INT_DEST_MODE, \
 	.no_balance_irq = NO_BALANCE_IRQ, \
-	.no_ioapic_check = NO_IOAPIC_CHECK, \
 	.ESR_DISABLE = esr_disable, \
 	.apic_destination_logical = APIC_DEST_LOGICAL, \
 	APICFUNC(apic_id_registered), \
diff -puN include/asm-i386/mach-bigsmp/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-bigsmp/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.764532520 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-bigsmp/mach_apic.h	2005-05-11 02:12:15.404724800 -0700
@@ -14,8 +14,6 @@
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
-#define NO_IOAPIC_CHECK (0)
-
 static inline int apic_id_registered(void)
 {
 	return (1);
diff -puN include/asm-i386/mach-default/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-default/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-default/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.809525680 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-default/mach_apic.h	2005-05-11 02:12:26.216081224 -0700
@@ -19,8 +19,6 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
 
-#define NO_IOAPIC_CHECK (0)
-
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
diff -puN include/asm-i386/mach-es7000/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-es7000/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.860517928 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-es7000/mach_apic.h	2005-05-11 02:12:30.793385368 -0700
@@ -38,8 +38,6 @@ static inline cpumask_t target_cpus(void
 #define WAKE_SECONDARY_VIA_INIT
 #endif
 
-#define NO_IOAPIC_CHECK (1)
-
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 { 
 	return 0;
diff -puN include/asm-i386/mach-generic/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-generic/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-generic/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.895512608 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-generic/mach_apic.h	2005-05-11 02:12:40.895849560 -0700
@@ -5,7 +5,6 @@
 
 #define esr_disable (genapic->ESR_DISABLE)
 #define NO_BALANCE_IRQ (genapic->no_balance_irq)
-#define NO_IOAPIC_CHECK	(genapic->no_ioapic_check)
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
 #undef APIC_DEST_LOGICAL
diff -puN include/asm-i386/mach-numaq/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-numaq/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.931507136 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-numaq/mach_apic.h	2005-05-11 02:12:48.456700136 -0700
@@ -17,8 +17,6 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
-#define NO_IOAPIC_CHECK (0)
-
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
diff -puN include/asm-i386/mach-summit/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-summit/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:51.969501360 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-summit/mach_apic.h	2005-05-11 02:13:44.542173848 -0700
@@ -7,8 +7,6 @@
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
 
-#define NO_IOAPIC_CHECK (1)	/* Don't check I/O APIC ID for xAPIC */
-
 /* In clustered mode, the high nibble of APIC ID is a cluster number.
  * The low nibble is a 4-bit bitmap. */
 #define XAPIC_DEST_CPUS_SHIFT	4
diff -puN include/asm-i386/mach-visws/mach_apic.h~no-ioapic-check-i386 include/asm-i386/mach-visws/mach_apic.h
--- linux-2.6.13-rc3-mm3/include/asm-i386/mach-visws/mach_apic.h~no-ioapic-check-i386	2005-05-11 02:01:52.004496040 -0700
+++ linux-2.6.13-rc3-mm3-root/include/asm-i386/mach-visws/mach_apic.h	2005-05-11 02:13:50.727233576 -0700
@@ -9,8 +9,6 @@
 #define no_balance_irq (0)
 #define esr_disable (0)
 
-#define NO_IOAPIC_CHECK (0)
-
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
_
