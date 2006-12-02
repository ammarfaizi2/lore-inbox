Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423819AbWLBM4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423819AbWLBM4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423816AbWLBM4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:56:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10889 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423819AbWLBM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:56:10 -0500
Date: Sat, 2 Dec 2006 13:03:17 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ricardo Lugo <ricardolugo@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: hang booting onboard HPT 366 with libata (PATA)
Message-ID: <20061202130317.273abf75@localhost.localdomain>
In-Reply-To: <20061202111928.428e83d2@localhost.localdomain>
References: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com>
	<20061202111928.428e83d2@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 11:19:28 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> > ACPI: PCI Interrup 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
> > ata5: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
> > ata6: PATA max UDMA/66 cmd 0x0 ctl 0x2 bmdma 0xEC08 irq 16
> 
> Ok so the underlying problem seems to be that the second channel of the
> card had no I/O resource assigned to it, presumably because it wasn't in
> use. We check various other "not in use" things but not that one.
> 
> I'll fix that up. I think it just needs another check in libata-sff.

Try the following

--- drivers/ata/libata-sff.c~	2006-12-02 12:39:32.985707472 +0000
+++ drivers/ata/libata-sff.c	2006-12-02 12:39:32.985707472 +0000
@@ -826,6 +826,21 @@
 }
 
 #ifdef CONFIG_PCI
+
+static int ata_resources_present(struct pci_dev *pdev, int port)
+{
+	int i;
+	
+	/* Check the PCI resources for this channel are enabled */
+	port = port * 2;
+	for (i = 0; i < 2; i ++) {
+		if (pci_resource_start(pdev, port + i) == 0 ||
+			pci_resource_len(pdev, port + i) == 0)
+		return 0;
+	}
+	return 1;
+}
+		
 /**
  *	ata_pci_init_native_mode - Initialize native-mode driver
  *	@pdev:  pci device to be initialized
@@ -857,6 +872,13 @@
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
+	
+	/* Discard disabled ports. Some controllers show their
+	   unused channels this way */
+	if (ata_resources_present(pdev, 0) == 0)
+		ports &= ~ATA_PORT_PRIMARY;
+	if (ata_resources_present(pdev, 1) == 0)
+		ports &= ~ATA_PORT_SECONDARY;
 
 	if (ports & ATA_PORT_PRIMARY) {
 		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 0);
