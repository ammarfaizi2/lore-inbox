Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJ3B3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 20:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTJ3B3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 20:29:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262063AbTJ3B3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 20:29:35 -0500
Message-ID: <3FA0696D.7030205@pobox.com>
Date: Wed, 29 Oct 2003 20:29:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrik Wallstrom <pawal@blipp.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: SATA and 2.6.0-test9
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org> <20031027181052.GG32168@vic20.blipp.com>
In-Reply-To: <20031027181052.GG32168@vic20.blipp.com>
Content-Type: multipart/mixed;
 boundary="------------010805040206070300030101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010805040206070300030101
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

Duh...  I was missing a piece in libata-core.c, and clobbering some 
information I needed.

Can you try this patch, and let me know if things change?

	Jeff



--------------010805040206070300030101
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.5 vs edited =====
--- 1.5/drivers/scsi/libata-core.c	Wed Oct 22 22:25:32 2003
+++ edited/drivers/scsi/libata-core.c	Wed Oct 29 20:27:27 2003
@@ -1339,9 +1339,13 @@
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

--------------010805040206070300030101--

