Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWGGT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWGGT2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWGGT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:28:06 -0400
Received: from lucidpixels.com ([66.45.37.187]:61921 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932281AbWGGT2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:28:05 -0400
Date: Fri, 7 Jul 2006 15:28:03 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jeff Garzik <jgarzik@pobox.com>
cc: Mark Lord <liml@rtr.ca>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <44AEB3CA.8080606@pobox.com>
Message-ID: <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <200607070908.44751.liml@rtr.ca>
 <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan> <200607070943.17957.liml@rtr.ca>
 <Pine.LNX.4.64.0607071035310.5153@p34.internal.lan>
 <Pine.LNX.4.64.0607071452540.14371@p34.internal.lan> <44AEB3CA.8080606@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Jeff Garzik wrote:

> Justin Piszcz wrote:
>> 
>> 
>> On Fri, 7 Jul 2006, Justin Piszcz wrote:
>> 
>>> 
>>> 
>>> On Fri, 7 Jul 2006, Mark Lord wrote:
>>> 
>>>> Justin Piszcz wrote:
>>>>> 
>>>>> had to change
>>>>> 
>>>>> KERN_WARN -> KERN_WARNING
>>>>> 
>>>>> then more errors
>>>> 
>>>> Eh?  After fixing the KERN_WARN -> KERN_WARNING part,
>>>> the patch compiles / links cleanly here on 2.6.17.
>>>> (fixed copy below).   Still untested, though.
>>>> 
>>>>> do you know who wrote the original patch?
>>>> 
>>>> I did.
>>>> 
>>>> Cheers
>>>> 
>>>> --- linux/drivers/scsi/libata-scsi.c.orig    2006-06-19 
>>>> 10:37:03.000000000 -0400
>>>> +++ linux/drivers/scsi/libata-scsi.c    2006-07-07 09:06:57.000000000 
>>>> -0400
>>>> @@ -542,6 +542,7 @@
>>>>     struct ata_taskfile *tf = &qc->tf;
>>>>     unsigned char *sb = cmd->sense_buffer;
>>>>     unsigned char *desc = sb + 8;
>>>> +    unsigned char ata_op = tf->command;
>>>>
>>>>     memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>>>> 
>>>> @@ -558,6 +559,7 @@
>>>>      * onto sense key, asc & ascq.
>>>>      */
>>>>     if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>>> +        printk(KERN_WARNING "ata_gen_ata_desc_sense: failed 
>>>> ata_op=0x%02x\n", ata_op);
>>>>         ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
>>>>                    &sb[1], &sb[2], &sb[3]);
>>>>         sb[1] &= 0x0f;
>>>> 
>>> 
>>> Mark!! It did it again, here you go:
>>> 
>>> ==> /p34/var/log/messages <==
>>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: status=0x53 { 
>>> DriveReady SeekComplete Index Error }
>>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: error=0x04 { 
>>> DriveStatusError }
>>> ==> /p34/var/log/kern.log <==
>>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: translated ATA stat/err 
>>> 0x53/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: status=0x53 { 
>>> DriveReady SeekComplete Index Error }
>>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: error=0x04 { 
>>> DriveStatusError }
>>> 
>>> Does this help?
>>> 
>>> Can we eliminate the cause of these errors now?
>>> 
>>> 
>> 
>> Jeff or Alan,
>> 
>> Does that ATA translation help in determining what *bad* commands are being 
>> sent to the drive?
>
> No, it needs the patch that Mark has been posting...
>
> 	Jeff
>
>
>

Jeff, the patch is applied and box booted the new kernel and I reproduced 
the error messages, THAT is what is produced with the patch.


Without the patch:

Jun 18 07:09:53 p34 kernel: [4297678.777000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 18 07:09:53 p34 kernel: [4297678.777000] ata3: error=0x04 { 
DriveStatusError }
Jun 18 07:20:08 p34 -- MARK --
Jun 18 07:27:31 p34 kernel: [4298736.905000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 18 07:27:31 p34 kernel: [4298736.905000] ata3: error=0x04 { 
DriveStatusError }

With the patch:

Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: translated ATA stat/err 
0x53/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: status=0x53 { 
DriveReady SeekComplete Index Error }
Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: error=0x04 { 
DriveStatusError }
Jul  7 10:49:29 p34 kernel: [4298273.178000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 10:49:29 p34 kernel: [4298273.178000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 10:49:29 p34 kernel: [4298273.178000] ata4: error=0x04 { 
DriveStatusError }
Jul  7 11:43:02 p34 kernel: [4301488.359000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 11:43:02 p34 kernel: [4301488.359000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 11:43:02 p34 kernel: [4301488.359000] ata4: error=0x04 { 
DriveStatusError }
Jul  7 12:35:27 p34 kernel: [4304634.600000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 12:35:27 p34 kernel: [4304634.600000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 12:35:27 p34 kernel: [4304634.600000] ata4: error=0x04 { 
DriveStatusError }
Jul  7 12:44:14 p34 kernel: [4305162.220000] ata4: no sense translation 
for status: 0x51
Jul  7 12:44:14 p34 kernel: [4305162.220000] ata4: translated ATA stat/err 
0x51/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 12:44:14 p34 kernel: [4305162.220000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 13:03:22 p34 kernel: [4306309.782000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 13:03:22 p34 kernel: [4306309.782000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 13:03:22 p34 kernel: [4306309.782000] ata4: error=0x04 { 
DriveStatusError }
Jul  7 13:05:12 p34 kernel: [4306419.891000] ata4: no sense translation 
for status: 0x51
Jul  7 13:05:12 p34 kernel: [4306419.891000] ata4: translated ATA stat/err 
0x51/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 13:05:12 p34 kernel: [4306419.891000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 13:32:20 p34 kernel: [4308048.717000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  7 13:32:20 p34 kernel: [4308048.717000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  7 13:32:20 p34 kernel: [4308048.717000] ata4: error=0x04 { 
DriveStatusError }

When I had been running it earlier with 2.6.15.x:

Mar  1 13:31:10 p34 kernel: [4295292.736000] +++PATCH: Original kernel 
error:
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: translated op=0x85 ATA 
stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Mar  1 13:31:10 p34 kernel: [4295292.736000] +++PATCH: Mark Lord's 
extended verbosity patch:
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: translated op=0x85 
cmd=0xb0 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: error=0x04 { 
DriveStatusError }
Mar  1 13:31:10 p34 kernel: [4295292.736000] +++PATCH: Original kernel 
error:
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: translated op=0x85 ATA 
stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Mar  1 13:31:10 p34 kernel: [4295292.736000] +++PATCH: Mark Lord's 
extended verbosity patch:
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: translated op=0x85 
cmd=0xb0 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Mar  1 13:31:10 p34 kernel: [4295292.736000] ata3: error=0x04 { 
DriveStatusError }

Perhaps the patch is not printing out the correct error message?

This shows that the source file was patched in libata-scsi.c.

         /*
          * Use ata_to_sense_error() to map status register bits
          * onto sense key, asc & ascq.
          */
         if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
                 printk(KERN_WARNING "ata_gen_ata_desc_sense: failed 
ata_op=0x%02x\n", ata_op);
                 ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
                                    &sb[1], &sb[2], &sb[3]);
                 sb[1] &= 0x0f;
         }


This shows the kernel version.
$ cat /usr/src/linux/.version
4

This shows I am running the patched version.
$ uname -a
Linux p34.internal.lan 2.6.17.3 #4 SMP PREEMPT Fri Jul 7 09:47:53 EDT 2006 
i686 GNU/Linux
$

Maybe something is blocking the opcode output from showing correctly?

Justin.

