Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946128AbWBDANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946128AbWBDANB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946127AbWBDANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:13:01 -0500
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:54148 "EHLO
	xena.localdomain") by vger.kernel.org with ESMTP id S1946124AbWBDANA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:13:00 -0500
Subject: [patch 1/1] Compilation fix for ES7000 when no ACPI is specified in config (i386)
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, snakebyte@gmx.de, hager@cs.umu.se,
       natalie.protasevich@unisys.com, Natalie.Protasevich@unisys.com
From: natalie.protasevich@unisys.com
Date: Fri, 03 Feb 2006 17:20:00 -0700
Message-Id: <20060204002001.0CBA08A7F2@xena.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ES7000 platfrom code clean up for compilation errors and a warning.
Ifdef'd the ACPI related parts in the ES7000 platform code. They were causing compile errors in certain configuration (without ACPI defined).
I think this approach would be best (as opposed to Kconfig changes) since it only touches the subarch...

Signed-off-by: <Natalie.Protasevich@unisys.com>
---


diff -puN include/asm-i386/mach-es7000/mach_mpparse.h~es7000-compile-fix include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.16-rc1-mm4/include/asm-i386/mach-es7000/mach_mpparse.h~es7000-compile-fix	2006-02-02 02:56:05.000000000 -0700
+++ linux-2.6.16-rc1-mm4-root/include/asm-i386/mach-es7000/mach_mpparse.h	2006-02-02 03:35:19.000000000 -0700
@@ -30,7 +30,8 @@ static inline int mps_oem_check(struct m
 	return 0;
 }
 
-static inline int es7000_check_dsdt()
+#ifdef CONFIG_ACPI
+static inline int es7000_check_dsdt(void)
 {
 	struct acpi_table_header *header = NULL;
 	if(!acpi_get_table_header_early(ACPI_DSDT, &header))
@@ -54,6 +55,11 @@ static inline int acpi_madt_oem_check(ch
 	}
 	return 0;
 }
-
+#else
+static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return 0;
+}
+#endif
 
 #endif /* __ASM_MACH_MPPARSE_H */
diff -puN arch/i386/kernel/mpparse.c~es7000-compile-fix arch/i386/kernel/mpparse.c
--- linux-2.6.16-rc1-mm4/arch/i386/kernel/mpparse.c~es7000-compile-fix	2006-02-02 02:56:05.000000000 -0700
+++ linux-2.6.16-rc1-mm4-root/arch/i386/kernel/mpparse.c	2006-02-02 02:59:07.000000000 -0700
@@ -828,6 +828,8 @@ void __init find_smp_config (void)
 		smp_scan_config(address, 0x400);
 }
 
+int es7000_plat;
+
 /* --------------------------------------------------------------------------
                             ACPI-based MP Configuration
    -------------------------------------------------------------------------- */
@@ -1005,8 +1007,6 @@ void __init mp_override_legacy_irq (
 	return;
 }
 
-int es7000_plat;
-
 void __init mp_config_acpi_legacy_irqs (void)
 {
 	struct mpc_config_intsrc intsrc;
diff -puN arch/i386/mach-es7000/es7000plat.c~es7000-compile-fix arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.16-rc1-mm4/arch/i386/mach-es7000/es7000plat.c~es7000-compile-fix	2006-02-02 02:56:05.000000000 -0700
+++ linux-2.6.16-rc1-mm4-root/arch/i386/mach-es7000/es7000plat.c	2006-02-02 02:59:54.000000000 -0700
@@ -51,8 +51,6 @@ struct mip_reg		*host_reg;
 int 			mip_port;
 unsigned long		mip_addr, host_addr;
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
-
 /*
  * GSI override for ES7000 platforms.
  */
@@ -76,8 +74,6 @@ es7000_rename_gsi(int ioapic, int gsi)
 	return gsi;
 }
 
-#endif	/* (CONFIG_X86_IO_APIC) && (CONFIG_ACPI) */
-
 void __init
 setup_unisys(void)
 {
@@ -160,6 +156,7 @@ parse_unisys_oem (char *oemptr)
 	return es7000_plat;
 }
 
+#ifdef CONFIG_ACPI
 int __init
 find_unisys_acpi_oem_table(unsigned long *oem_addr)
 {
@@ -212,6 +209,7 @@ find_unisys_acpi_oem_table(unsigned long
 	}
 	return -1;
 }
+#endif
 
 static void
 es7000_spin(int n)
diff -puN arch/i386/mach-es7000/es7000.h~es7000-compile-fix arch/i386/mach-es7000/es7000.h
--- linux-2.6.16-rc1-mm4/arch/i386/mach-es7000/es7000.h~es7000-compile-fix	2006-02-02 02:56:05.000000000 -0700
+++ linux-2.6.16-rc1-mm4-root/arch/i386/mach-es7000/es7000.h	2006-02-02 03:04:51.000000000 -0700
@@ -83,6 +83,7 @@ struct es7000_oem_table {
 	struct psai psai;
 };
 
+#ifdef CONFIG_ACPI
 struct acpi_table_sdt {
 	unsigned long pa;
 	unsigned long count;
@@ -99,6 +100,9 @@ struct oem_table {
 	u32 OEMTableSize;
 };
 
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
+#endif
+
 struct mip_reg {
 	unsigned long long off_0;
 	unsigned long long off_8;
@@ -114,7 +118,6 @@ struct mip_reg {
 #define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
 
 extern int parse_unisys_oem (char *oemptr);
-extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
 extern void setup_unisys(void);
 extern int es7000_start_cpu(int cpu, unsigned long eip);
 extern void es7000_sw_apic(void);
_
