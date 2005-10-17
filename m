Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVJQRMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVJQRMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVJQRMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:12:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751053AbVJQRMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:12:49 -0400
Date: Mon, 17 Oct 2005 10:12:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
In-Reply-To: <4353CF7E.1090404@pobox.com>
Message-ID: <Pine.LNX.4.64.0510171008120.3369@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
 <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
 <4353CF7E.1090404@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
> If IDE is compiled in, IDE SATA option is not enabled, and ata_piix or ahci
> are used.

How about this diff instead?

It's really quite clean and understandable, and it makes it very clear 
what's going on from a configuration standpoint, imnsho. And it does the 
right thing when AHCI/PIIX is compiled as a SATA module (well, as right as 
this approach ever can).

Of course, somebody should check that it really is just the AHCI and PIIX 
drivers that want the quirk, but I think the _approach_ is obvious.

		Linus

----
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 11ca443..7bb5725 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1233,7 +1233,7 @@ static void __init quirk_alder_ioapic(st
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
+#ifdef CONFIG_INTEL_SATA_QUIRK
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 20019b8..49ef1c6 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -445,9 +445,14 @@ config SCSI_SATA
 
 	  If unsure, say N.
 
+config INTEL_SATA_QUIRK
+	bool
+	default n
+
 config SCSI_SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on SCSI_SATA && PCI
+	select INTEL_SATA_QUIRK
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -465,6 +470,7 @@ config SCSI_SATA_SVW
 config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
 	depends on SCSI_SATA && PCI
+	select INTEL_SATA_QUIRK
 	help
 	  This option enables support for ICH5 Serial ATA.
 	  If PATA support was enabled previously, this enables
