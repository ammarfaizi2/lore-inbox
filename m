Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUKRXTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUKRXTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUKRXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:18:42 -0500
Received: from fmr15.intel.com ([192.55.52.69]:54912 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261197AbUKRXQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:16:03 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041115152721.U14339@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-vJZEws5gE3hvB2nKmjk/"
Organization: 
Message-Id: <1100819685.987.120.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Nov 2004 18:14:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vJZEws5gE3hvB2nKmjk/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Chris,

Please apply this debug patch and boot with
apic=debug acpi_dbg_level=1

If the disabled floppy hardware doesn't cause the floppy.c
to hang the system, (or if running Linus' recent floppy.c
update, if the floppy.c doesn't nuke IRQ6) then please
send me the dmesg.

Then try with apic=debug pci=routeirq and capture that dmesg.

If the patch makes no functional difference, then please
add pci=routeirq to the cmdline above and send me that dmesg.

apic=debug
enables print_PIC() so we can see what the BIOS gave us,
and what we do to the PIC.

acpi_dbg_level=1
will prevent ACPI from blindly disabling the
PCI Interrupt Link Devices, which I'm guessing
may be confusing the BIOS on this box.

if you can send me the acpidmp and lspci -vv for
this box, that would help too.

thanks,
-Len


--=-vJZEws5gE3hvB2nKmjk/
Content-Disposition: attachment; filename=debug.patch
Content-Type: text/plain; name=debug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== arch/i386/pci/acpi.c 1.18 vs edited =====
--- 1.18/arch/i386/pci/acpi.c	2004-10-19 00:44:01 -04:00
+++ edited/arch/i386/pci/acpi.c	2004-11-18 17:57:20 -05:00
@@ -56,6 +56,10 @@
 	if (acpi_ioapic)
 		print_IO_APIC();
 #endif
+	{
+		extern void print_PIC(void);
+		print_PIC();
+	}
 
 	return 0;
 }
===== drivers/acpi/pci_link.c 1.34 vs edited =====
--- 1.34/drivers/acpi/pci_link.c	2004-11-02 02:40:09 -05:00
+++ edited/drivers/acpi/pci_link.c	2004-11-18 18:11:15 -05:00
@@ -475,6 +475,9 @@
 	struct acpi_pci_link    *link = NULL;
 	int			i = 0;
 
+extern void print_PIC(void);
+print_PIC();
+
 	ACPI_FUNCTION_TRACE("acpi_irq_penalty_init");
 
 	/*
@@ -685,8 +688,13 @@
 	acpi_link.count++;
 
 end:
+
 	/* disable all links -- to be activated on use */
+if (acpi_dbg_level != 1)
 	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+else
+	printk("NOT disabled\n");
+
 
 	if (result)
 		kfree(link);
@@ -865,6 +873,9 @@
 
 	if (acpi_noirq)
 		return_VALUE(0);
+
+extern void print_PIC(void);
+print_PIC();
 
 	acpi_link.count = 0;
 	INIT_LIST_HEAD(&acpi_link.entries);

--=-vJZEws5gE3hvB2nKmjk/--

