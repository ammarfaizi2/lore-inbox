Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUIBX5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUIBX5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbUIBXzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:55:32 -0400
Received: from pcp08154275pcs.coatsv01.pa.comcast.net ([69.138.89.207]:48016
	"EHLO iam.rightthere.net") by vger.kernel.org with ESMTP
	id S269377AbUIBXwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:52:18 -0400
Date: Thu, 2 Sep 2004 19:52:14 -0400
From: Jason Davis <jason.davis@unisys.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.8.1 ES7000 subarch update
Message-ID: <20040902235214.GA21954@righTThere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy -

The patch below adds hooks for the ES7000 Management Processor driver and implements an algorithm to determine an available GSI override for correctly mapping GSIs to IO-APIC pins. GSI overrides are required for the ES7000 platform since IRQ to pin mappings are NOT all one-to-one. This patch applies to the Unisys specific ES7000 machines. Extensive tests has been done on several models of the ES7000 to verify this patch.

Thanks,
Jason Davis


diff -Naur linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000.h linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000.h
--- linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000.h	2004-08-14 06:54:50.000000000 -0400
+++ linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000.h	2004-09-01 23:25:34.863415632 -0400
@@ -104,6 +104,13 @@
 #define	MIP_SW_APIC		0x1020b
 #define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
 
+#if defined(CONFIG_X86_IO_APIC) && (defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_ACPI_BOOT))
+#define IOAPIC_GSI_BOUND(ioapic) ((ioapic+1) * (nr_ioapic_registers[ioapic]-1))
+#define MAX_GSI_MAPSIZE 32
+#endif
+
+extern unsigned long io_apic_irqs;
+
 extern int parse_unisys_oem (char *oemptr, int oem_entries);
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length);
 extern int es7000_start_cpu(int cpu, unsigned long eip);
diff -Naur linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000plat.c linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000plat.c	2004-08-14 06:56:22.000000000 -0400
+++ linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000plat.c	2004-09-01 23:43:36.287014256 -0400
@@ -51,27 +51,81 @@
 int 			mip_port;
 unsigned long		mip_addr, host_addr;
 
+EXPORT_SYMBOL(mip_reg);
+EXPORT_SYMBOL(host_reg);
+EXPORT_SYMBOL(mip_port);
+EXPORT_SYMBOL(mip_addr);
+EXPORT_SYMBOL(host_addr);
+
+#if defined(CONFIG_X86_IO_APIC) && (defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_ACPI_BOOT))
+static unsigned long cycle_irqs = 0;
+static unsigned long free_irqs = 0;
+static int gsi_map[MAX_GSI_MAPSIZE] = { [0 ... MAX_GSI_MAPSIZE-1] = -1 };
+
+/*
+ * GSI override for ES7000 platforms.
+ */
+
+static int __init
+es7000_gsi_override(int ioapic, int gsi)
+{
+	static int newgsi = 0;
+
+	if (gsi_map[gsi] != -1)
+		gsi = gsi_map[gsi];
+	else if (cycle_irqs ^ free_irqs)
+	{
+		newgsi = find_next_bit(&cycle_irqs, IOAPIC_GSI_BOUND(0), newgsi);
+		__set_bit(newgsi, &free_irqs);
+		gsi_map[gsi] = newgsi;
+		gsi = newgsi;
+		newgsi++;
+		Dprintk("es7000_gsi_override: free_irqs = 0x%lx\n", free_irqs);
+	}
+
+	return gsi;
+}
+
 static int __init
 es7000_rename_gsi(int ioapic, int gsi)
 {
-	if (ioapic)
+	static int initialized = 0;
+	int i;
+
+	/*
+	 * These should NEVER be true at this point but we'd rather be
+	 * safe than sorry.
+	 */
+	if (acpi_disabled || acpi_pci_disabled || acpi_noirq)
 		return gsi;
-	else {
-		if (gsi == 0)
-			return 13;
-		if (gsi == 1)
-			return 16;
-		if (gsi == 4)
-			return 17;
-		if (gsi == 6)
-			return 18;
-		if (gsi == 7)
-			return 19;
-		if (gsi == 8)
-			return 20;
+
+	if (ioapic)
 		return gsi;
-        }
+
+	if (!initialized) {
+		unsigned long tmp_irqs = 0;
+
+		for (i = 0; i < nr_ioapic_registers[0]; i++)
+			__set_bit(mp_irqs[i].mpc_srcbusirq, &tmp_irqs);
+
+		cycle_irqs = (~tmp_irqs & io_apic_irqs & ((1 << IOAPIC_GSI_BOUND(0)) - 1));
+
+		initialized = 1;
+		Dprintk("es7000_rename_gsi: cycle_irqs = 0x%lx\n", cycle_irqs);
+	}
+
+	for (i = 0; i < nr_ioapic_registers[0]; i++) {
+		if (mp_irqs[i].mpc_srcbusirq == gsi) {
+			if (mp_irqs[i].mpc_dstirq == gsi)
+				return gsi;
+			else
+				return es7000_gsi_override(0, gsi);
+		}
+	}
+
+	return gsi;
 }
+#endif // (CONFIG_X86_IO_APIC) && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)
 
 /*
  * Parse the OEM Table

