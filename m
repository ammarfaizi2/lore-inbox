Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWFLRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFLRnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWFLRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:43:49 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54513 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1750823AbWFLRnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:43:49 -0400
Date: Mon, 12 Jun 2006 19:43:46 +0200
From: Arne Ahrend <aahrend@web.de>
To: linux-kernel@vger.kernel.org
Subject: PATA: UDMA settings in Alans patch-2.6.17-rc4-ide1.gz better than
 with 2.6.17-rc6-mm2
Message-Id: <20060612194346.d92fbb05.aahrend@web.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current 2.6.17-rc6-mm2 tree sets UDMA speed for my IDE harddisk to 33, whereas Alans patch-2.6.17-rc4-ide1.gz
patch has it at 100. This results in hdparm -T /dev/sda measurements on -mm2 roughly halved from 60+ MB/sec to 30+ MB/sec.

Measurements were in both cases taken on kernels based off 2.6.17-rc6, with Alans -rc4 patch forward-fitted.

The remaining three ATAPI devices get UDMA/33 in both setups.



Alans ide patch for 2.6.17-rc4 conflicts with this post-rc4 change in drivers/scsi/libata-core.c:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bb31a8faa270beafcc51a65880c5564c6b718bd6;hp=387e2b0439026aa738a9edca15a57e5c0bcb4dfc

Following patch can be used in -rc[56] after applying Alans patch in order to apply the failed hunk and also keep the post-rc4 patch from git:

--- linux-2.6.17-rc6-pata-broken/drivers/scsi/libata-core.c	2006-06-12 19:07:42.000000000 +0200
+++ linux-2.6.17-rc6-pata/drivers/scsi/libata-core.c	2006-06-06 20:16:30.000000000 +0200
@@ -3736,14 +3736,14 @@ static void atapi_packet_task(void *_dat
 		 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+ 		ap->ops->data_xfer(ap, qc->dev, qc->cdb, qc->dev->cdb_len, 1);
 		ata_altstatus(ap); /* flush */
 
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+ 		ap->ops->data_xfer(ap, qc->dev, qc->cdb, qc->dev->cdb_len, 1);
 		ata_altstatus(ap); /* flush */
 
 		/* PIO commands are handled by polling */





dmesg section from 2.6.17-rc6 with Alans -rc4 patch fitted:
-----------------------------------------------------------
pata_via 0000:00:0f.1: version 0.1.9
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 1
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:203f
ata3: dev 0 ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata3: dev 1 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata3: dev 1 ATAPI, max UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=69 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
ata3: dev 0 configured for UDMA/100
ata3: dev 1 configured for UDMA/33
scsi2 : pata_via
isa bounce pool size: 16 pages
  Vendor: ATA       Model: SAMSUNG SP1614N   Rev: TM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: X004
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ata4: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 1 cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata4: dev 1 ATAPI, max UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
FIT t.act8b = 2, t.rec8b = 0, t.active = 2, t.recover = 0
ata4: dev 0 configured for UDMA/33
ata4: dev 1 configured for UDMA/33
scsi3 : pata_via
  Vendor: PLEXTOR   Model: CD-R   PX-W4012A  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A103
  Type:   CD-ROM                             ANSI SCSI revision: 05



Cheers,

Arne
