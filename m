Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTGGVm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbTGGVm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:42:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21395 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264611AbTGGVmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:42:54 -0400
Subject: [PATCH] linux-2.4.22-pre3_x440-acpi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Andrew Grover <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057614929.27377.88.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jul 2003 14:55:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Andrew, all,

	This patch insures that when booting with the new ACPI code that we
enable the clustered_apic bits for the x440. Without this patch, x440s
will not boot in full ACPI mode. 

Thanks to James Cleverdon for the original version of this patch.

Please apply,

thanks
-john


diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	Mon Jul  7 13:59:57 2003
+++ b/arch/i386/kernel/acpi.c	Mon Jul  7 13:59:57 2003
@@ -129,6 +129,8 @@
 	printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 		madt->lapic_address);
 
+	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+
 	return 0;
 }
 
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Jul  7 13:59:57 2003
+++ b/arch/i386/kernel/io_apic.c	Mon Jul  7 13:59:57 2003
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
--- a/arch/i386/kernel/mpparse.c	Mon Jul  7 13:59:57 2003
+++ b/arch/i386/kernel/mpparse.c	Mon Jul  7 13:59:57 2003
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
--- a/include/asm-i386/acpi.h	Mon Jul  7 13:59:57 2003
+++ b/include/asm-i386/acpi.h	Mon Jul  7 13:59:57 2003
@@ -165,6 +165,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
+/* Check for special HW using OEM name lists */
+extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
+
 #endif /*CONFIG_ACPI_SLEEP*/
 
 



