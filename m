Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWGGNIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWGGNIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWGGNIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:08:48 -0400
Received: from rtr.ca ([64.26.128.89]:27784 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751019AbWGGNIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:08:47 -0400
From: Mark Lord <liml@rtr.ca>
To: Justin Piszcz <jpiszcz@lucidpixels.com>, Sander <sander@humilis.net>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 7 Jul 2006 09:08:44 -0400
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <20060219171651.GA8986@favonius> <Pine.LNX.4.64.0607061906550.5107@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607061906550.5107@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607070908.44751.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Look at this:
> 
>> From smartctl, look at the correspondence:
> 199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always 
> -       4
> 
> [4301946.802000] ata4: translated ATA stat/err 0x51/04 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
> [4301946.802000] ata4: status=0x51 { DriveReady SeekComplete Error }
> [4301946.802000] ata4: error=0x04 { DriveStatusError }
> [4302380.482000] ata4: translated ATA stat/err 0x51/04 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
> [4302380.482000] ata4: status=0x51 { DriveReady SeekComplete Error }
> [4302380.482000] ata4: error=0x04 { DriveStatusError }
> [4302493.664000] ata4: no sense translation for status: 0x51
> [4302493.664000] ata4: translated ATA stat/err 0x51/00 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
> [4302493.664000] ata4: status=0x51 { DriveReady SeekComplete Error }
> [4302863.673000] ata4: no sense translation for status: 0x51
> [4302863.673000] ata4: translated ATA stat/err 0x51/00 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
> [4302863.673000] ata4: status=0x51 { DriveReady SeekComplete Error }
> 
> different drive, different cable, same controller, but second port
> 
> So that Stat/err = UDMA_CRC_Error_Count!

No, I don't think it is -- there's a bit in the drive status
for indicating CRC errors, and it is not showing up here.

I think it's still just libata sending some command that this
drive does not implement.  You really need to dump out the failed
ATA opcode.

I *think* this (uncompiled, untested) patch may do it for you on 2.6.16/17:

--- linux/drivers/scsi/libata-scsi.c.orig	2006-06-19 10:37:03.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2006-07-07 09:06:57.000000000 -0400
@@ -542,6 +542,7 @@
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
+	unsigned char ata_op = tf->command;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -558,6 +559,7 @@
 	 * onto sense key, asc & ascq.
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		printk(KERN_WARN "ata_gen_ata_desc_sense: failed ata_op=0x%02x\n", ata_op);
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
