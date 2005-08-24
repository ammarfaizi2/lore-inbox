Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVHYGGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVHYGGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVHYGGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:06:25 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:10880 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S964852AbVHYGGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:06:24 -0400
Subject: [patch 1/1] ES7000 platform update (i386) 
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Wed, 24 Aug 2005 04:00:06 -0700
Message-Id: <20050824110007.08C805BCDC@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is subarch update for ES7000. I've modified platform check code and
removed unnecessary OEM table parsing for newer systems that don't use 
OEM information during boot. Parsing the table in fact is causing problems, 
and the platform doesn't get recognized.
The patch only affects the ES7000 subach.

Signed-off-by: <Natalie.Protasevich@unisys.com>
---

 arch/i386/mach-es7000/es7000.h              |    5 +--
 arch/i386/mach-es7000/es7000plat.c          |   45 +++++++++++++---------------
 include/asm-i386/mach-es7000/mach_mpparse.h |   30 ++++++++++++++----
 3 files changed, 49 insertions(+), 31 deletions(-)

diff -puN arch/i386/mach-es7000/es7000.h~es7000_plat_update arch/i386/mach-es7000/es7000.h
--- linux-2.6.13-rc6/arch/i386/mach-es7000/es7000.h~es7000_plat_update	2005-08-23 21:01:22.621684672 -0700
+++ linux-2.6.13-rc6-root/arch/i386/mach-es7000/es7000.h	2005-08-23 23:49:47.225551392 -0700
@@ -104,7 +104,8 @@ struct mip_reg {
 #define	MIP_SW_APIC		0x1020b
 #define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
 
-extern int parse_unisys_oem (char *oemptr, int oem_entries);
-extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length);
+extern int parse_unisys_oem (char *oemptr);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
+extern void setup_unisys ();
 extern int es7000_start_cpu(int cpu, unsigned long eip);
 extern void es7000_sw_apic(void);
diff -puN arch/i386/mach-es7000/es7000plat.c~es7000_plat_update arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.13-rc6/arch/i386/mach-es7000/es7000plat.c~es7000_plat_update	2005-08-23 21:01:22.656679352 -0700
+++ linux-2.6.13-rc6-root/arch/i386/mach-es7000/es7000plat.c	2005-08-23 21:04:15.662378488 -0700
@@ -75,12 +75,29 @@ es7000_rename_gsi(int ioapic, int gsi)
 
 #endif // (CONFIG_X86_IO_APIC) && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)
 
+void __init
+setup_unisys ()
+{
+	/*
+	 * Determine the generation of the ES7000 currently running.
+	 *
+	 * es7000_plat = 1 if the machine is a 5xx ES7000 box
+	 * es7000_plat = 2 if the machine is a x86_64 ES7000 box
+	 *
+	 */
+	if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
+		es7000_plat = 2;
+	else
+		es7000_plat = 1;
+	ioapic_renumber_irq = es7000_rename_gsi;
+}
+
 /*
  * Parse the OEM Table
  */
 
 int __init
-parse_unisys_oem (char *oemptr, int oem_entries)
+parse_unisys_oem (char *oemptr)
 {
 	int                     i;
 	int 			success = 0;
@@ -95,7 +112,7 @@ parse_unisys_oem (char *oemptr, int oem_
 
 	tp += 8;
 
-	for (i=0; i <= oem_entries; i++) {
+	for (i=0; i <= 6; i++) {
 		type = *tp++;
 		size = *tp++;
 		tp -= 2;
@@ -130,34 +147,18 @@ parse_unisys_oem (char *oemptr, int oem_
 		default:
 			break;
 		}
-		if (i == 6) break;
 		tp += size;
 	}
 
 	if (success < 2) {
 		es7000_plat = 0;
-	} else {
-		printk("\nEnabling ES7000 specific features...\n");
-		/*
-		 * Determine the generation of the ES7000 currently running.
-		 *
-		 * es7000_plat = 0 if the machine is NOT a Unisys ES7000 box
-		 * es7000_plat = 1 if the machine is a 5xx ES7000 box
-		 * es7000_plat = 2 if the machine is a x86_64 ES7000 box
-		 *
-		 */
-		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
-			es7000_plat = 2;
-		else
-			es7000_plat = 1;
-
-		ioapic_renumber_irq = es7000_rename_gsi;
-	}
+	} else
+		setup_unisys();
 	return es7000_plat;
 }
 
 int __init
-find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length)
+find_unisys_acpi_oem_table(unsigned long *oem_addr)
 {
 	struct acpi_table_rsdp		*rsdp = NULL;
 	unsigned long			rsdp_phys = 0;
@@ -201,13 +202,11 @@ find_unisys_acpi_oem_table(unsigned long
 				acpi_table_print(header, sdt.entry[i].pa);
 				t = (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, header->length);
 				addr = (void *) __acpi_map_table(t->OEMTableAddr, t->OEMTableSize);
-				*length = header->length;
 				*oem_addr = (unsigned long) addr;
 				return 0;
 			}
 		}
 	}
-	Dprintk("ES7000: did not find Unisys ACPI OEM table!\n");
 	return -1;
 }
 
diff -puN include/asm-i386/mach-es7000/mach_mpparse.h~es7000_plat_update include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.13-rc6/include/asm-i386/mach-es7000/mach_mpparse.h~es7000_plat_update	2005-08-23 21:01:22.692673880 -0700
+++ linux-2.6.13-rc6-root/include/asm-i386/mach-es7000/mach_mpparse.h	2005-08-23 23:50:06.168671600 -0700
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
+#include <linux/acpi.h>
+
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
 {
@@ -12,8 +14,9 @@ static inline void mpc_oem_pci_bus(struc
 {
 }
 
-extern int parse_unisys_oem (char *oemptr, int oem_entries);
-extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length);
+extern int parse_unisys_oem (char *oemptr);
+extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
+extern void setup_unisys();
 
 static inline int mps_oem_check(struct mp_config_table *mpc, char *oem,
 		char *productid)
@@ -22,18 +25,33 @@ static inline int mps_oem_check(struct m
 		struct mp_config_oemtable *oem_table = 
 			(struct mp_config_oemtable *)mpc->mpc_oemptr;
 		if (!strncmp(oem, "UNISYS", 6))
-			return parse_unisys_oem((char *)oem_table, oem_table->oem_length);
+			return parse_unisys_oem((char *)oem_table);
 	}
 	return 0;
 }
 
+static inline int es7000_check_dsdt()
+{
+	struct acpi_table_header *header = NULL;
+	if(!acpi_get_table_header_early(ACPI_DSDT, &header))
+		acpi_table_print(header, 0);
+	if (!strncmp(header->oem_id, "UNISYS", 6))
+		return 1;
+	return 0;
+}
+
 /* Hook from generic ACPI tables.c */
 static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	unsigned long oem_addr; 
-	int oem_entries;
-	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))
-		return parse_unisys_oem((char *)oem_addr, oem_entries);
+	if (!find_unisys_acpi_oem_table(&oem_addr)) {
+		if (es7000_check_dsdt())
+			return parse_unisys_oem((char *)oem_addr);
+		else {
+			setup_unisys();
+			return 1;
+		}
+	}
 	return 0;
 }
 
_
