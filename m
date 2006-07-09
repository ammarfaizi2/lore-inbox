Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWGIUQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWGIUQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGIUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:16:21 -0400
Received: from lucidpixels.com ([66.45.37.187]:23510 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1161115AbWGIUQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:16:20 -0400
Date: Sun, 9 Jul 2006 16:16:19 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Mark Lord <liml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <44AEB3CA.8080606@pobox.com>
 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan> <200607091224.31451.liml@rtr.ca>
 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006, Justin Piszcz wrote:

>
>
> On Sun, 9 Jul 2006, Mark Lord wrote:
>
>> Mmm.. there are two main paths into those messages,
>> and my current patch only caught one of them.
>> 
>> Here's a reworked version that catches the ata_op on both paths.
>> Maybe this will dump out the info we need to diagnose Justin's system.
>> 
>> Compiles & links fine on 2.6.17, but not tested.
>> 
>> Cheers
>> 
>> --- linux/drivers/scsi/libata-scsi.c.orig	2006-06-23 13:38:37.000000000 
>> -0400
>> +++ linux/drivers/scsi/libata-scsi.c	2006-07-09 12:19:52.000000000 -0400
>> @@ -542,6 +542,7 @@
>> 	struct ata_taskfile *tf = &qc->tf;
>> 	unsigned char *sb = cmd->sense_buffer;
>> 	unsigned char *desc = sb + 8;
>> +	unsigned char ata_op = tf->command;
>>
>> 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>> 
>> @@ -558,6 +559,7 @@
>> 	 * onto sense key, asc & ascq.
>> 	 */
>> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>> +		printk(KERN_WARNING "ata_gen_ata_desc_sense: failed 
>> ata_op=0x%02x\n", ata_op);
>> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
>> 				   &sb[1], &sb[2], &sb[3]);
>> 		sb[1] &= 0x0f;
>> @@ -617,6 +619,7 @@
>> 	struct scsi_cmnd *cmd = qc->scsicmd;
>> 	struct ata_taskfile *tf = &qc->tf;
>> 	unsigned char *sb = cmd->sense_buffer;
>> +	unsigned char ata_op = tf->command;
>>
>> 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>> 
>> @@ -633,6 +636,7 @@
>> 	 * onto sense key, asc & ascq.
>> 	 */
>> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>> +		printk(KERN_WARNING "ata_gen_fixed_sense: failed 
>> ata_op=0x%02x\n", ata_op);
>> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
>> 				   &sb[2], &sb[12], &sb[13]);
>> 		sb[2] &= 0x0f;
>> 
>
> Thanks Mark!
>
> Applying now.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Mark,

Check line 519, this is where it is printing the error (I believe) and 
the patch does not print the ata_op here.

It is in the ata_to_sense_error() function.

I've already patched, as you can see, recompiled, etc..

# patch -p0 < /tmp/b
patching file linux/drivers/scsi/libata-scsi.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
#

Jul  9 15:22:57 p34 kernel: [4300704.724000] ata3: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  9 15:22:57 p34 kernel: [4300704.724000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jul  9 15:22:57 p34 kernel: [4300704.724000] ata3: error=0x04 { 
DriveStatusError }

This part needs the ata_op:

     519  translate_done:
     520         printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
     521                "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
     522                *sk, *asc, *ascq);


Justin.



