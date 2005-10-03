Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVJCTIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVJCTIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVJCTIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:08:23 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:13696 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S932622AbVJCTIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:08:23 -0400
Subject: [patch 1/1] ES7000 platform update (i386)
To: akpm@osdl.org
Cc: zwane@arm.linux.org.uk, ak@suse.de, linux-kernel@vger.kernel.org,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Sun, 02 Oct 2005 17:01:29 -0700
Message-Id: <20051003000130.601D243F57@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is platform code update for ES7000: 
disables IRQ overrides for the recent ES7000 (Rascal/Zorro),
cleans up the compile warning.
The patch only affects the ES7000 subarch.

Signed-off-by: <Natalie.Protasevich@unisys.com>
---

 arch/i386/mach-es7000/es7000.h              |   11 ++++++++++-
 arch/i386/mach-es7000/es7000plat.c          |   11 +++++++----
 include/asm-i386/mach-es7000/mach_mpparse.h |    2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff -puN arch/i386/mach-es7000/es7000.h~es7000_plat_update arch/i386/mach-es7000/es7000.h
--- linux-2.6.14-rc2-mm2/arch/i386/mach-es7000/es7000.h~es7000_plat_update	2005-10-02 15:06:09.523620888 -0700
+++ linux-2.6.14-rc2-mm2-root/arch/i386/mach-es7000/es7000.h	2005-10-02 16:43:47.857018840 -0700
@@ -24,6 +24,15 @@
  * http://www.unisys.com
  */
 
+/*
+ * ES7000 chipsets
+ */	
+
+#define NON_UNISYS		0
+#define ES7000_CLASSIC		1
+#define ES7000_ZORRO		2
+
+
 #define	MIP_REG			1
 #define	MIP_PSAI_REG		4
 
@@ -106,6 +115,6 @@ struct mip_reg {
 
 extern int parse_unisys_oem (char *oemptr);
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
-extern void setup_unisys ();
+extern void setup_unisys(void);
 extern int es7000_start_cpu(int cpu, unsigned long eip);
 extern void es7000_sw_apic(void);
diff -puN arch/i386/mach-es7000/es7000plat.c~es7000_plat_update arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.14-rc2-mm2/arch/i386/mach-es7000/es7000plat.c~es7000_plat_update	2005-10-02 15:06:09.558615568 -0700
+++ linux-2.6.14-rc2-mm2-root/arch/i386/mach-es7000/es7000plat.c	2005-10-02 16:45:32.410124352 -0700
@@ -62,6 +62,9 @@ static unsigned int base;
 static int
 es7000_rename_gsi(int ioapic, int gsi)
 {
+	if (es7000_plat == ES7000_ZORRO)
+		return gsi;
+
 	if (!base) {
 		int i;
 		for (i = 0; i < nr_ioapics; i++)
@@ -76,7 +79,7 @@ es7000_rename_gsi(int ioapic, int gsi)
 #endif	/* (CONFIG_X86_IO_APIC) && (CONFIG_ACPI) */
 
 void __init
-setup_unisys ()
+setup_unisys(void)
 {
 	/*
 	 * Determine the generation of the ES7000 currently running.
@@ -86,9 +89,9 @@ setup_unisys ()
 	 *
 	 */
 	if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
-		es7000_plat = 2;
+		es7000_plat = ES7000_ZORRO;
 	else
-		es7000_plat = 1;
+		es7000_plat = ES7000_CLASSIC;
 	ioapic_renumber_irq = es7000_rename_gsi;
 }
 
@@ -151,7 +154,7 @@ parse_unisys_oem (char *oemptr)
 	}
 
 	if (success < 2) {
-		es7000_plat = 0;
+		es7000_plat = NON_UNISYS;
 	} else
 		setup_unisys();
 	return es7000_plat;
diff -puN include/asm-i386/mach-es7000/mach_mpparse.h~es7000_plat_update include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.14-rc2-mm2/include/asm-i386/mach-es7000/mach_mpparse.h~es7000_plat_update	2005-10-02 15:06:09.594610096 -0700
+++ linux-2.6.14-rc2-mm2-root/include/asm-i386/mach-es7000/mach_mpparse.h	2005-10-02 15:11:41.029224376 -0700
@@ -16,7 +16,7 @@ static inline void mpc_oem_pci_bus(struc
 
 extern int parse_unisys_oem (char *oemptr);
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr);
-extern void setup_unisys();
+extern void setup_unisys(void);
 
 static inline int mps_oem_check(struct mp_config_table *mpc, char *oem,
 		char *productid)
_
