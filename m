Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTH2OzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTH2Oxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:53:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261273AbTH2Ovr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:51:47 -0400
Message-ID: <3F4F6863.4080400@pobox.com>
Date: Fri, 29 Aug 2003 10:51:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Daniela Engert <dani@ngrt.de>, Misha Nasledov <misha@nasledov.com>
Subject: libata update posted (was Re: VIA Serial ATA chipset)
References: <20030813074535.C3AB427AC8@mail.medav.de>
In-Reply-To: <20030813074535.C3AB427AC8@mail.medav.de>
Content-Type: multipart/mixed;
 boundary="------------050905060104010308070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905060104010308070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Daniela Engert wrote:
> On Tue, 12 Aug 2003 23:49:23 -0700, Misha Nasledov wrote:
> 
> 
>>Thanks a lot, this patch works for me. I have the following in my dmesg:
>>
>>VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
>>PCI: Found IRQ 3 for device 0000:00:0f.0
>>IRQ routing conflict for 0000:00:0f.0, have irq 11, want irq 3
>>PCI: Sharing IRQ 3 with 0000:00:0f.1
>>IRQ routing conflict for 0000:00:10.0, have irq 11, want irq 3
>>IRQ routing conflict for 0000:00:10.1, have irq 11, want irq 3
>>VIA8237SATA: chipset revision 128
>>VIA8237SATA: 100% native mode on irq 11
>>   ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:pio, hdj:pio
>>   ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
>>
>>The IRQ routing conflict lines have always existed, and there are more
>>similar lines in other parts of the dmesg. I'm not sure if they are
>>pertinent at all. Unfortunately, the drive does not seem to perform as
>>well as a SATA drive should; my UDMA/133 drive currently outperforms
>>this. However, it seems to significantly faster than the UDMA/66 drive
>>I run Linux on, so I am glad that it works as fast it does because now
>>I can perhaps use this as my new system drive.
> 
> 
> Well, the patch was meant to be a quick shot from the hips only, just
> to get your system going and to check if my assumptions about the
> structure of the VIA SATA host controller implementation wer correct.
> It looks like they are, this controller seems to follow the T13 ATA
> host controller model.

Correct.


>>Are there any plans on the horizon for a more complete driver for this
>>chipset?
> 
> 
> Jeff Garzik is working on a SATA driver. My conclusions from the
> results of the feasability test above are that adding the VIA SATA
> controller to the already existing libata source should boil down to
> pretty simple programming excercise.

It was.  The sata_via.c driver is absolutely generic except for its PCI 
ID.  I only chose to create a separate driver because I now have docs 
(thanks, VIA), so I can begin programming the SATA-specific registers.

So, here are the 2.4 and 2.6 versions of the VIA SATA support for 
libata, contained in the latest libata update.

2.4 BK: bk://kernel.bkbits.net/jgarzik/atascsi-2.4
2.4 Patch: 
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.23-pre1-libata3.patch.bz2

2.6 BK: bk://kernel.bkbits.net/jgarzik/atascsi-2.6
2.6 Patch: 
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test4-bk2-libata3.patch.bz2


Changes:
* add VIA SATA driver
* fixes to software reset.
* other fixes
* split scsi-related code into separate file, libata-scsi.c.
* continue work on phy layer
* continue work towards fully async taskfile API:  you call submit_tf(), 
and later on, your callback is called when the taskfile completes or 
times out.   async taskfile API is required for ATAPI and supporting 
more advanced host controllers like Promise or AHCI (SATA2).
* some cleanups


--------------050905060104010308070500
Content-Type: text/plain;
 name="patch.srst"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.srst"

===== drivers/scsi/ata_piix.c 1.22 vs edited =====
--- 1.22/drivers/scsi/ata_piix.c	Thu Aug 28 22:07:27 2003
+++ edited/drivers/scsi/ata_piix.c	Fri Aug 29 00:51:44 2003
@@ -137,7 +137,7 @@
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x03,	/* pio3-4 */
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.host_info	= &piix_pata_ops,
@@ -146,7 +146,8 @@
 	/* ich5_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED,
+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED
+				  | ATA_FLAG_SRST,
 		.pio_mask	= 0x03,	/* pio3-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
 		.host_info	= &piix_sata_ops,
@@ -155,7 +156,7 @@
 	/* piix4_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 		.pio_mask	= 0x03, /* pio3-4 */
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.host_info	= &piix_pata_ops,

--------------050905060104010308070500--

