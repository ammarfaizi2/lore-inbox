Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTGJV7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGJV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:59:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23940 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269631AbTGJV4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:56:36 -0400
Subject: [PATCH] linux-2.4.22-pre4_x440-acpi-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Grover <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307100019460.6316@freak.distro.conectiva>
References: <1057799280.27380.248.camel@w-jstultz2.beaverton.ibm.com>
	 <Pine.LNX.4.55L.0307100019460.6316@freak.distro.conectiva>
Content-Type: text/plain
Organization: 
Message-Id: <1057874924.22130.182.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jul 2003 15:08:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 20:22, Marcelo Tosatti wrote:
> I just applied it John, it will be in bk soon.
> 
> But cant that be done in a cleaner way?

Think I've sorted a slightly cleaner way, and bonus points for making it
compile with CONFIG_ACPI & !CONFIG_X86_CLUSTERED_APIC (gah! sorry about
that).

This patch moves the summit detection being done in
acpi_madt_oem_check() to detect_clustered_apic(). Also fixes the compile
failure when compiling with CONFIG_ACPI and without
CONFIG_X86_CLUSTERED_APIC. 


Applies on top of 2.4.22-bkcurrent.

Thanks
-john


diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	Thu Jul 10 14:44:25 2003
+++ b/arch/i386/kernel/acpi.c	Thu Jul 10 14:44:25 2003
@@ -44,6 +44,7 @@
 #include <asm/io_apic.h>
 #include <asm/acpi.h>
 #include <asm/save_state.h>
+#include <asm/smpboot.h>
 
 
 #define PREFIX			"ACPI: "
@@ -129,7 +130,7 @@
 	printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 		madt->lapic_address);
 
-	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+	detect_clustered_apic(madt->header.oem_id, madt->header.oem_table_id);
 
 	return 0;
 }
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Thu Jul 10 14:44:25 2003
+++ b/arch/i386/kernel/mpparse.c	Thu Jul 10 14:44:25 2003
@@ -1252,22 +1252,6 @@
 	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
 }
 
-/* Hook from generic ACPI tables.c */
-void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	if (!strncmp(oem_id, "IBM", 3) &&
-	    (!strncmp(oem_table_id, "SERVIGIL", 8) ||
-	     !strncmp(oem_table_id, "EXA", 3) ||
-	     !strncmp(oem_table_id, "RUTHLESS", 8))){
-		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
-		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
-		int_dest_addr_mode = APIC_DEST_PHYSICAL;
-		int_delivery_mode = dest_Fixed;
-		esr_disable = 1;
-		/*Start cyclone clock*/
-		cyclone_setup(0);
-	}
-}
 
 #ifdef CONFIG_ACPI_PCI
 
diff -Nru a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h	Thu Jul 10 14:44:25 2003
+++ b/include/asm-i386/acpi.h	Thu Jul 10 14:44:25 2003
@@ -165,9 +165,6 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
-/* Check for special HW using OEM name lists */
-extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
-
 #endif /*CONFIG_ACPI_SLEEP*/
 
 
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Thu Jul 10 14:44:25 2003
+++ b/include/asm-i386/smpboot.h	Thu Jul 10 14:44:25 2003
@@ -29,8 +29,19 @@
 		esr_disable = 1;
 		/*Start cyclone clock*/
 		cyclone_setup(0);
-	}
-	else if (!strncmp(oem, "IBM NUMA", 8)){
+	/* check for ACPI tables */
+	} else if (!strncmp(oem, "IBM", 3) &&
+	    (!strncmp(prod, "SERVIGIL", 8) ||
+	     !strncmp(prod, "EXA", 3) ||
+	     !strncmp(prod, "RUTHLESS", 8))){
+		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode = APIC_DEST_PHYSICAL;
+		int_delivery_mode = dest_Fixed;
+		esr_disable = 1;
+		/*Start cyclone clock*/
+		cyclone_setup(0);
+	} else if (!strncmp(oem, "IBM NUMA", 8)){
 		clustered_apic_mode = CLUSTERED_APIC_NUMAQ;
 		apic_broadcast_id = APIC_BROADCAST_ID_APIC;
 		int_dest_addr_mode = APIC_DEST_LOGICAL;





