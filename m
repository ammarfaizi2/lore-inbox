Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJ3Rtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJ3Rtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:49:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23170 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262714AbTJ3Rtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:49:49 -0500
Message-ID: <3FA14F2F.1080700@pobox.com>
Date: Thu, 30 Oct 2003 12:49:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrik Wallstrom <pawal@blipp.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH #2] Re: SATA and 2.6.0-test9
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org> <20031027181052.GG32168@vic20.blipp.com>
In-Reply-To: <20031027181052.GG32168@vic20.blipp.com>
Content-Type: multipart/mixed;
 boundary="------------020501010004010900010807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501010004010900010807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patrik Wallstrom wrote:
> On Mon, 27 Oct 2003, Jeff Garzik wrote:
> 
> 
>>>>Jeff Garzik:
>>>>  o [libata] Merge Serial ATA core, and drivers for
>>>>  o [libata] Integrate Serial ATA driver into kernel tree
>>>
>>>I am happy to see these in the kernel now, but I have yet to get them
>>>working on my KT6 Delta KT600 motherboard with the VT8237 SATA
>>>southbridge controller or even the Promise controller.
>>
>>Does it improve things, if you change ATA_FLAG_SRST to
>>ATA_FLAG_SATA_RESET, in drivers/scsi/sata_via.c ?
> 
> 
> It doesn't hang any more, but the only result is:
> sata_via version 0.11
> ata3: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
> ata4: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
> ata3: thread exiting
> scsi2 : sata_via
> ata4: thread exiting
> scsi3 : sata_via

Actually, attached is a better patch...

--------------020501010004010900010807
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.5 vs edited =====
--- 1.5/drivers/scsi/libata-core.c	Wed Oct 22 22:25:32 2003
+++ edited/drivers/scsi/libata-core.c	Thu Oct 30 11:18:59 2003
@@ -1086,6 +1086,11 @@
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		ata_port_disable(ap);
+		return;
+	}
+
 	ata_bus_reset(ap);
 }
 
@@ -1339,9 +1344,13 @@
 		outb(ap->ctl, ioaddr->ctl_addr);
 
 	/* determine if device 0/1 are present */
-	dev0 = ata_dev_devchk(ap, 0);
-	if (slave_possible)
-		dev1 = ata_dev_devchk(ap, 1);
+	if (ap->flags & ATA_FLAG_SATA_RESET)
+		dev0 = 1;
+	else {
+		dev0 = ata_dev_devchk(ap, 0);
+		if (slave_possible)
+			dev1 = ata_dev_devchk(ap, 1);
+	}
 
 	if (dev0)
 		devmask |= (1 << 0);
===== drivers/scsi/sata_promise.c 1.8 vs edited =====
--- 1.8/drivers/scsi/sata_promise.c	Tue Oct 28 11:04:25 2003
+++ edited/drivers/scsi/sata_promise.c	Thu Oct 30 08:13:44 2003
@@ -176,7 +176,7 @@
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO,
 		.pio_mask	= 0x03, /* pio3-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
@@ -186,7 +186,7 @@
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO,
 		.pio_mask	= 0x03, /* pio3-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
@@ -207,6 +207,8 @@
 
 static struct pci_device_id pdc_sata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
===== drivers/scsi/sata_via.c 1.2 vs edited =====
--- 1.2/drivers/scsi/sata_via.c	Tue Oct 21 23:13:54 2003
+++ edited/drivers/scsi/sata_via.c	Wed Oct 29 20:27:43 2003
@@ -108,7 +108,7 @@
 	{
 		.sht		= &svia_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY
-				  | ATA_FLAG_SRST,
+				  | ATA_FLAG_SATA_RESET,
 		.pio_mask	= 0x03,	/* pio3-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
 		.port_ops	= &svia_sata_ops,

--------------020501010004010900010807--

