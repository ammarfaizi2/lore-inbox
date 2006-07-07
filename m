Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWGGNYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWGGNYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGGNYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:24:16 -0400
Received: from lucidpixels.com ([66.45.37.187]:11708 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751211AbWGGNYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:24:15 -0400
Date: Fri, 7 Jul 2006 09:24:14 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Mark Lord <liml@rtr.ca>
cc: Sander <sander@humilis.net>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <200607070908.44751.liml@rtr.ca>
Message-ID: <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <20060219171651.GA8986@favonius>
 <Pine.LNX.4.64.0607061906550.5107@p34.internal.lan> <200607070908.44751.liml@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> Look at this:
>>
>>> From smartctl, look at the correspondence:
>> 199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always
>> -       4
>>
>> [4301946.802000] ata4: translated ATA stat/err 0x51/04 to SCSI
>> SK/ASC/ASCQ 0xb/00/00
>> [4301946.802000] ata4: status=0x51 { DriveReady SeekComplete Error }
>> [4301946.802000] ata4: error=0x04 { DriveStatusError }
>> [4302380.482000] ata4: translated ATA stat/err 0x51/04 to SCSI
>> SK/ASC/ASCQ 0xb/00/00
>> [4302380.482000] ata4: status=0x51 { DriveReady SeekComplete Error }
>> [4302380.482000] ata4: error=0x04 { DriveStatusError }
>> [4302493.664000] ata4: no sense translation for status: 0x51
>> [4302493.664000] ata4: translated ATA stat/err 0x51/00 to SCSI
>> SK/ASC/ASCQ 0xb/00/00
>> [4302493.664000] ata4: status=0x51 { DriveReady SeekComplete Error }
>> [4302863.673000] ata4: no sense translation for status: 0x51
>> [4302863.673000] ata4: translated ATA stat/err 0x51/00 to SCSI
>> SK/ASC/ASCQ 0xb/00/00
>> [4302863.673000] ata4: status=0x51 { DriveReady SeekComplete Error }
>>
>> different drive, different cable, same controller, but second port
>>
>> So that Stat/err = UDMA_CRC_Error_Count!
>
> No, I don't think it is -- there's a bit in the drive status
> for indicating CRC errors, and it is not showing up here.
>
> I think it's still just libata sending some command that this
> drive does not implement.  You really need to dump out the failed
> ATA opcode.
>
> I *think* this (uncompiled, untested) patch may do it for you on 2.6.16/17:
>
> --- linux/drivers/scsi/libata-scsi.c.orig	2006-06-19 10:37:03.000000000 -0400
> +++ linux/drivers/scsi/libata-scsi.c	2006-07-07 09:06:57.000000000 -0400
> @@ -542,6 +542,7 @@
> 	struct ata_taskfile *tf = &qc->tf;
> 	unsigned char *sb = cmd->sense_buffer;
> 	unsigned char *desc = sb + 8;
> +	unsigned char ata_op = tf->command;
>
> 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>
> @@ -558,6 +559,7 @@
> 	 * onto sense key, asc & ascq.
> 	 */
> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> +		printk(KERN_WARN "ata_gen_ata_desc_sense: failed ata_op=0x%02x\n", ata_op);
> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
> 				   &sb[1], &sb[2], &sb[3]);
> 		sb[1] &= 0x0f;
>

had to change

KERN_WARN -> KERN_WARNING

then more errors

the patch never worked for me even when I had gotten it to work in
2.6.15.4, it never showed me what I wanted to see

drivers/scsi/libata-scsi.c: In function 'ata_gen_fixed_sense':
drivers/scsi/libata-scsi.c:638: error: 'ata_op' undeclared (first use in
this function)
drivers/scsi/libata-scsi.c:638: error: (Each undeclared identifier is
reported only once
drivers/scsi/libata-scsi.c:638: error: for each function it appears in.)
make[2]: *** [drivers/scsi/libata-scsi.o] Error 1

do you know who wrote the original patch?

