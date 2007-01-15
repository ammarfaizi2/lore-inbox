Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbXAOHBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAOHBl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAOHBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 02:01:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42912 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074AbXAOHBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 02:01:40 -0500
Date: Mon, 15 Jan 2007 12:31:12 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] i386: modpost apic related warning fixes
Message-ID: <20070115070112.GA18259@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o Modpost generates warnings for i386 if compiled with CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.text:find_unisys_acpi_oem_table from .text between 'acpi_madt_oem_check' (at offset 0xc0101eda) and 'enable_apic_mode'
WARNING: vmlinux - Section mismatch: reference to .init.text:acpi_get_table_header_early from .text between 'acpi_madt_oem_check' (at offset 0xc0101ef0) and 'enable_apic_mode'
WARNING: vmlinux - Section mismatch: reference to .init.text:parse_unisys_oem from .text between 'acpi_madt_oem_check' (at offset 0xc0101f2e) and 'enable_apic_mode'
WARNING: vmlinux - Section mismatch: reference to .init.text:setup_unisys from .text between 'acpi_madt_oem_check' (at offset 0xc0101f37) and 'enable_apic_mode'WARNING: vmlinux - Section mismatch: reference to .init.text:parse_unisys_oem from .text between 'mps_oem_check' (at offset 0xc0101ec7) and 'acpi_madt_oem_check'
WARNING: vmlinux - Section mismatch: reference to .init.text:es7000_sw_apic from .text between 'enable_apic_mode' (at offset 0xc0101f48) and 'check_apicid_present'

o Some functions which are inline (acpi_madt_oem_check) are not inlined by
  compiler as these functions are accessed using function pointer. These
  functions are put in .text section and they in-turn access __init type
  functions hence modpost generates warnings.

o Do not iniline acpi_madt_oem_check, instead make it __init. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/mach-generic/es7000.c             |   41 ++++++++++++++++++++++++++++
 include/asm-i386/mach-es7000/mach_apic.h    |    7 ----
 include/asm-i386/mach-es7000/mach_mpparse.h |   32 ---------------------
 scripts/mod/modpost.c                       |    1 
 4 files changed, 42 insertions(+), 39 deletions(-)

diff -puN include/asm-i386/mach-es7000/mach_mpparse.h~modpost-apic-related-warning-fixes include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.20-rc4-mm1-reloc/include/asm-i386/mach-es7000/mach_mpparse.h~modpost-apic-related-warning-fixes	2007-01-15 11:30:12.000000000 +0530
+++ linux-2.6.20-rc4-mm1-reloc-root/include/asm-i386/mach-es7000/mach_mpparse.h	2007-01-15 11:50:15.000000000 +0530
@@ -18,18 +18,6 @@ extern int parse_unisys_oem (char *oempt
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
 extern void setup_unisys(void);
 
-static inline int mps_oem_check(struct mp_config_table *mpc, char *oem,
-		char *productid)
-{
-	if (mpc->mpc_oemptr) {
-		struct mp_config_oemtable *oem_table = 
-			(struct mp_config_oemtable *)mpc->mpc_oemptr;
-		if (!strncmp(oem, "UNISYS", 6))
-			return parse_unisys_oem((char *)oem_table);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 static inline int es7000_check_dsdt(void)
 {
@@ -40,26 +28,6 @@ static inline int es7000_check_dsdt(void
 		return 1;
 	return 0;
 }
-
-/* Hook from generic ACPI tables.c */
-static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	unsigned long oem_addr; 
-	if (!find_unisys_acpi_oem_table(&oem_addr)) {
-		if (es7000_check_dsdt())
-			return parse_unisys_oem((char *)oem_addr);
-		else {
-			setup_unisys();
-			return 1;
-		}
-	}
-	return 0;
-}
-#else
-static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 0;
-}
 #endif
 
 #endif /* __ASM_MACH_MPPARSE_H */
diff -puN arch/i386/mach-generic/es7000.c~modpost-apic-related-warning-fixes arch/i386/mach-generic/es7000.c
--- linux-2.6.20-rc4-mm1-reloc/arch/i386/mach-generic/es7000.c~modpost-apic-related-warning-fixes	2007-01-15 11:30:12.000000000 +0530
+++ linux-2.6.20-rc4-mm1-reloc-root/arch/i386/mach-generic/es7000.c	2007-01-15 11:56:18.000000000 +0530
@@ -25,4 +25,45 @@ static int probe_es7000(void)
 	return 0;
 }
 
+extern void es7000_sw_apic(void);
+static void __init enable_apic_mode(void)
+{
+	es7000_sw_apic();
+	return;
+}
+
+static __init int mps_oem_check(struct mp_config_table *mpc, char *oem,
+		char *productid)
+{
+	if (mpc->mpc_oemptr) {
+		struct mp_config_oemtable *oem_table =
+			(struct mp_config_oemtable *)mpc->mpc_oemptr;
+		if (!strncmp(oem, "UNISYS", 6))
+			return parse_unisys_oem((char *)oem_table);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+/* Hook from generic ACPI tables.c */
+static int __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	unsigned long oem_addr;
+	if (!find_unisys_acpi_oem_table(&oem_addr)) {
+		if (es7000_check_dsdt())
+			return parse_unisys_oem((char *)oem_addr);
+		else {
+			setup_unisys();
+			return 1;
+		}
+	}
+	return 0;
+}
+#else
+static int __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	return 0;
+}
+#endif
+
 struct genapic apic_es7000 = APIC_INIT("es7000", probe_es7000);
diff -puN include/asm-i386/mach-es7000/mach_apic.h~modpost-apic-related-warning-fixes include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.6.20-rc4-mm1-reloc/include/asm-i386/mach-es7000/mach_apic.h~modpost-apic-related-warning-fixes	2007-01-15 11:54:25.000000000 +0530
+++ linux-2.6.20-rc4-mm1-reloc-root/include/asm-i386/mach-es7000/mach_apic.h	2007-01-15 11:56:27.000000000 +0530
@@ -73,13 +73,6 @@ static inline void init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
-extern void es7000_sw_apic(void);
-static inline void enable_apic_mode(void)
-{
-	es7000_sw_apic();
-	return;
-}
-
 extern int apic_version [MAX_APICS];
 static inline void setup_apic_routing(void)
 {
diff -puN scripts/mod/modpost.c~modpost-apic-related-warning-fixes scripts/mod/modpost.c
--- linux-2.6.20-rc4-mm1-reloc/scripts/mod/modpost.c~modpost-apic-related-warning-fixes	2007-01-15 12:01:49.000000000 +0530
+++ linux-2.6.20-rc4-mm1-reloc-root/scripts/mod/modpost.c	2007-01-15 12:02:16.000000000 +0530
@@ -606,6 +606,7 @@ static int secref_whitelist(const char *
 		"_probe",
 		"_probe_one",
 		"_console",
+		"apic_es7000",
 		NULL
 	};
 
_
