Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272439AbTHIQER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272444AbTHIQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:04:16 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:63882 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S272439AbTHIQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:04:11 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: rzei@mbnet.fi
Subject: Re: [BUG?] 2.6.0-test3 USB mouse problems
Date: Sat, 9 Aug 2003 18:02:58 +0200
User-Agent: KMail/1.5.9
References: <200308091506.20935.rzei@mbnet.fi> <200308091808.34884.rzei@mbnet.fi>
In-Reply-To: <200308091808.34884.rzei@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zsRN/3RSTpR4UR7"
Message-Id: <200308091803.00289.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zsRN/3RSTpR4UR7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 09 August 2003 17:08, Joonas Koivunen wrote:
> Seems that all this was caused because of ACPI. With boot-time acpi=off,
> mouse works.

I've got the same mainboard and the same problems...

It's not a problem with ACPI, it's more a problem with the interrupt routing 
based on the ACPI tables. These tables seem to be not correctly implemented 
in the BIOS and, as the german EPOX support admits, are not really tested. To 
change this you may contact the EPOX support and describe your problems, 
too....

If you want to use ACPI while this BIOS bug is not fixed you may use the 
attached patch and boot with pci=noacpi. Without the patch this doesn't work 
for me here...

Best regards
  Thomas Schlichter

--Boundary-00=_zsRN/3RSTpR4UR7
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_noacpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_noacpi.diff"

--- linux-2.6.0-test2-mm4/arch/i386/kernel/acpi/boot.c.orig	Fri Aug  8 16:26:27 2003
+++ linux-2.6.0-test2-mm4/arch/i386/kernel/acpi/boot.c	Fri Aug  8 17:00:07 2003
@@ -39,6 +39,7 @@
 #define PREFIX			"ACPI: "
 
 extern int acpi_disabled;
+extern int acpi_irq_disabled;
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
@@ -381,6 +382,8 @@
 #ifdef CONFIG_X86_IO_APIC
 #ifndef CONFIG_ACPI_HT_ONLY
 
+	if (!acpi_irq_disabled) {
+
 	/* 
 	 * I/O APIC 
 	 * --------
@@ -416,6 +419,8 @@
 	acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
 
 	acpi_ioapic = 1;
+
+	}
 
 #endif /*!CONFIG_ACPI_HT_ONLY*/
 #endif /*CONFIG_X86_IO_APIC*/
--- linux-2.6.0-test2-mm4/arch/i386/kernel/setup.c.orig	Fri Aug  8 16:29:55 2003
+++ linux-2.6.0-test2-mm4/arch/i386/kernel/setup.c	Fri Aug  8 17:00:37 2003
@@ -69,6 +69,8 @@
 #endif
 EXPORT_SYMBOL(acpi_disabled);
 
+int acpi_irq_disabled = 0;
+
 int MCA_bus;
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
@@ -524,6 +526,10 @@
 		if (c == ' ' && !memcmp(from, "acpismp=force", 13))
 			acpi_disabled = 0;
 
+		/* "pci=noacpi" disables ACPI table parsing for interrupt routing */
+		if (c == ' ' && !memcmp(from, "pci=noacpi", 10))
+			acpi_irq_disabled = 1;
+
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.

--Boundary-00=_zsRN/3RSTpR4UR7--
