Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUIJDPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUIJDPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIJDPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:15:48 -0400
Received: from pcp08154275pcs.coatsv01.pa.comcast.net ([69.138.89.207]:41874
	"EHLO iam.rightthere.net") by vger.kernel.org with ESMTP
	id S267591AbUIJDPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:15:41 -0400
Date: Thu, 9 Sep 2004 23:15:26 -0400
From: Jason Davis <jason.davis@unisys.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradeed.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.6.8.1 ES7000 subarch update
Message-ID: <20040910031526.GA17778@righTThere.net>
References: <3010F4D7BBD5F64C9C2D17B9D17BB37705036A42@USTR-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3010F4D7BBD5F64C9C2D17B9D17BB37705036A42@USTR-EXCH4.na.uis.unisys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is an update to the ES7000 subarch patch submitted last week.

Changes that have been made:
1. ES7000 Management Processor driver hooks removed for the time being
2. Fixed misplaced curly brace on an if statement in es7000_gsi_override()

New description:
The patch below implements an algorithm to determine an unique GSI override for mapping GSIs to IO-APIC pins correctly. GSI overrides are required in order for ES7000 machines to function properly since IRQ to pin mappings are NOT all one-to-one. This patch applies only to the Unisys specific ES7000 machines and has been tested thoroughly on several models of the ES7000 line.

Thanks,
Jason

--- linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000.h	2004-08-14 06:54:50.000000000 -0400
+++ linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000.h	2004-09-07 14:49:56.000000000 -0400
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
--- linux-2.6.8.1-inc/arch/i386/mach-es7000/es7000plat.c	2004-08-14 06:56:22.000000000 -0400
+++ linux-2.6.8.1-es7k/arch/i386/mach-es7000/es7000plat.c	2004-09-09 12:22:26.000000000 -0400
@@ -51,27 +51,74 @@
 int 			mip_port;
 unsigned long		mip_addr, host_addr;
 
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
+	else if (cycle_irqs ^ free_irqs) {
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
+	static int initialized = 0;
+	int i;
+
+	/*
+	 * These should NEVER be true at this point but we'd rather be
+	 * safe than sorry.
+	 */
+	if (acpi_disabled || acpi_pci_disabled || acpi_noirq)
+ 		return gsi;
+
 	if (ioapic)
-		return gsi;
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
-		return gsi;
-        }
+ 		return gsi;
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
@@ -193,7 +240,7 @@
 			}
 		}
 	}
-	printk("ES7000: did not find Unisys ACPI OEM table!\n");
+	Dprintk("ES7000: did not find Unisys ACPI OEM table!\n");
 	return -1;
 }


(end-of-patch)

>
>
>-----Original Message-----
>From: Jason Davis [mailto:jason.davis@unisys.com] 
>Sent: Thursday, September 02, 2004 7:52 PM
>To: LKML; Andrew Morton
>Subject: [PATCH] 2.6.8.1 ES7000 subarch update
>
>Howdy -
>
>The patch below adds hooks for the ES7000 Management Processor driver
>and implements an algorithm to determine an available GSI override for
>correctly mapping GSIs to IO-APIC pins. GSI overrides are required for
>the ES7000 platform since IRQ to pin mappings are NOT all one-to-one.
>This patch applies to the Unisys specific ES7000 machines. Extensive
>tests has been done on several models of the ES7000 to verify this
>patch.
>
>Thanks,
>Jason Davis
>
>
> (original patch cut)
