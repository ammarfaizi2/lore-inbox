Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268743AbTGJA5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbTGJA5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:57:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38582 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268743AbTGJA5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:57:51 -0400
Subject: [PATCH] linux-2.4.22-pre4_x440-acpi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Andrew Grover <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057799280.27380.248.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jul 2003 18:08:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Andrew, All,

	Due to the new ACPI code, when booting in full ACPI mode, we do not go
through the mps tables, thus we do not execute the summit detection code
required for booting an x440. 

This patch insures that when booting in full ACPI mode we check to see
if we're running on a summit based system and enable clustered apic
mode. Without this patch the x440s hang while booting in full ACPI mode.

Thanks to James Cleverdon for the original version of this patch.

Please apply,

thanks
-john


diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	Wed Jul  9 16:39:20 2003
+++ b/arch/i386/kernel/acpi.c	Wed Jul  9 16:39:20 2003
@@ -129,6 +129,8 @@
 	printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 		madt->lapic_address);
 
+	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+
 	return 0;
 }
 
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Wed Jul  9 16:39:20 2003
+++ b/arch/i386/kernel/io_apic.c	Wed Jul  9 16:39:20 2003
@@ -1732,6 +1732,13 @@
 		apic_id = reg_00.ID;
 	}
 
+	/* XAPICs do not need unique IDs */
+	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC){
+		printk(KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", 
+			ioapic, apic_id);
+		return apic_id;
+	}
+
 	/*
 	 * Every APIC in a system must have a unique ID or we get lots of nice 
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Jul  9 16:39:20 2003
+++ b/arch/i386/kernel/mpparse.c	Wed Jul  9 16:39:20 2003
@@ -1252,6 +1252,23 @@
 	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
 }
 
+/* Hook from generic ACPI tables.c */
+void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	if (!strncmp(oem_id, "IBM", 3) &&
+	    (!strncmp(oem_table_id, "SERVIGIL", 8) ||
+	     !strncmp(oem_table_id, "EXA", 3) ||
+	     !strncmp(oem_table_id, "RUTHLESS", 8))){
+		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode = APIC_DEST_PHYSICAL;
+		int_delivery_mode = dest_Fixed;
+		esr_disable = 1;
+		/*Start cyclone clock*/
+		cyclone_setup(0);
+	}
+}
+
 #ifdef CONFIG_ACPI_PCI
 
 void __init mp_parse_prt (void)
diff -Nru a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h	Wed Jul  9 16:39:20 2003
+++ b/include/asm-i386/acpi.h	Wed Jul  9 16:39:20 2003
@@ -165,6 +165,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
+/* Check for special HW using OEM name lists */
+extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
+
 #endif /*CONFIG_ACPI_SLEEP*/
 
 



