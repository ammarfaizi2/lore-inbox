Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTHJQmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTHJQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:42:24 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:40146 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S270219AbTHJQmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:42:17 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: rzei@mbnet.fi, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] fix problems with pci=noacpi
Date: Sun, 10 Aug 2003 18:42:09 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200308091506.20935.rzei@mbnet.fi> <200308091803.00289.schlicht@uni-mannheim.de> <200308100224.28641.rzei@mbnet.fi>
In-Reply-To: <200308100224.28641.rzei@mbnet.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iXnN/E0o/mJIEAT"
Message-Id: <200308101842.10889.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iXnN/E0o/mJIEAT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 10 August 2003 01:24, Joonas Koivunen wrote:
> On Saturday 09 August 2003 19:02, Thomas Schlichter wrote:
~~ snip ~~
> > If you want to use ACPI while this BIOS bug is not fixed you may use the
> > attached patch and boot with pci=noacpi. Without the patch this doesn't
> > work for me here...
>
> Why isn't this patch in the mainstream kernel? There are many other
> chipset/bios fixes in the kernel.. This would save many
> reboot/recompilings/worries until or if ever epox does something with the
> bios.

Well, I didn't push it to Andrew or Linus yet, because it changes parts of the 
semantics of 'pci=noacpi'. But currently I do think the changed way is more 
correct, so perhaps Andrew may give it a try in the next -mm ??

If so, people who had problems with 'pci=noacpi' and use 'acpi=off' instead 
should give it a try again...

> The patch works nicely. Though I did apply it manually to -test3 :) But it
> works.

I attached the patch again, now it also changes the indentation correctly and 
simplifies the final setting of smp_found_config and the call of 
clustered_apic_check(). It applies to 2.6.0-test3-mm1.

Best regards
   Thomas Schlichter

--Boundary-00=_iXnN/E0o/mJIEAT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_noacpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_noacpi.diff"

--- linux-2.6.0-test3-mm1/arch/i386/kernel/acpi/boot.c.orig	Sun Aug 10 14:16:32 2003
+++ linux-2.6.0-test3-mm1/arch/i386/kernel/acpi/boot.c	Sun Aug 10 17:11:13 2003
@@ -39,6 +39,7 @@
 #define PREFIX			"ACPI: "
 
 extern int acpi_disabled;
+extern int acpi_ioapic_disabled;
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
@@ -386,46 +387,51 @@
 	 * --------
 	 */
 
+	if (!acpi_ioapic_disabled) {
+
+		result = acpi_table_parse_madt(ACPI_MADT_IOAPIC,
+						acpi_parse_ioapic);
+		if (!result) { 
+			printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
+			return -ENODEV;
+		}
+		else if (result < 0) {
+			printk(KERN_ERR PREFIX "Error parsing IOAPIC entry\n");
+			return result;
+		}
-	result = acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic);
-	if (!result) { 
-		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
-		return -ENODEV;
-	}
-	else if (result < 0) {
-		printk(KERN_ERR PREFIX "Error parsing IOAPIC entry\n");
-		return result;
-	}
 
+		/* Build a default routing table for legacy (ISA) interrupts. */
+		mp_config_acpi_legacy_irqs();
-	/* Build a default routing table for legacy (ISA) interrupts. */
-	mp_config_acpi_legacy_irqs();
 
+		result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR,
+						acpi_parse_int_src_ovr);
+		if (result < 0) {
+			printk(KERN_ERR PREFIX
+			"Error parsing interrupt source overrides entry\n");
+			/* TBD: Cleanup to allow fallback to MPS */
+			return result;
+		}
-	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr);
-	if (result < 0) {
-		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
-		/* TBD: Cleanup to allow fallback to MPS */
-		return result;
-	}
 
+		result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC,
+						acpi_parse_nmi_src);
+		if (result < 0) {
+			printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
+			/* TBD: Cleanup to allow fallback to MPS */
+			return result;
+		}
-	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src);
-	if (result < 0) {
-		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
-		/* TBD: Cleanup to allow fallback to MPS */
-		return result;
-	}
 
+		acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
+		acpi_ioapic = 1;
-	acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
-
-	acpi_ioapic = 1;
-
-#endif /*!CONFIG_ACPI_HT_ONLY*/
-#endif /*CONFIG_X86_IO_APIC*/
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
 		clustered_apic_check();
-	}
 #endif
+
+	}
+
+#endif /*!CONFIG_ACPI_HT_ONLY*/
+#endif /*CONFIG_X86_IO_APIC*/
 
 	return 0;
 }
--- linux-2.6.0-test3-mm1/arch/i386/kernel/setup.c.orig	Sun Aug 10 14:17:08 2003
+++ linux-2.6.0-test3-mm1/arch/i386/kernel/setup.c	Sun Aug 10 17:00:04 2003
@@ -69,6 +69,8 @@
 #endif
 EXPORT_SYMBOL(acpi_disabled);
 
+int acpi_ioapic_disabled = 0;
+
 int MCA_bus;
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
@@ -523,6 +525,10 @@
 		/* "acpismp=force" turns on ACPI again */
 		if (c == ' ' && !memcmp(from, "acpismp=force", 13))
 			acpi_disabled = 0;
+
+		/* "pci=noacpi" disables ACPI table parsing for interrupt routing */
+		if (c == ' ' && !memcmp(from, "pci=noacpi", 10))
+			acpi_ioapic_disabled = 1;
 
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.

--Boundary-00=_iXnN/E0o/mJIEAT--
