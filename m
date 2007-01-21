Return-Path: <linux-kernel-owner+w=401wt.eu-S1751209AbXAURgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXAURgz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAURgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:36:55 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:52296 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXAURgy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:36:54 -0500
From: Chr <chunkeey@web.de>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sun, 21 Jan 2007 18:34:40 +0100
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com, chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet>
In-Reply-To: <20070121083618.GA2434@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701211834.41306.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 21. January 2007 09:36, Björn Steinbrink wrote:
> On 2007.01.21 00:39:20 -0600, Robert Hancock wrote:
>
> Ah, right... sata_nv.c of course interacts with the outside world, d'oh!
>
> Up to now, I only got bad kernels, latest tested being:
> 94fcda1f8ab5e0cacc381c5ca1cc9aa6ad523576
>
> Which, unless I missed a commit in the diff, only USB changes,
> continuing anyway.
>
> Just to make sure, here's my little helper for this bisect run, I hope
> it does what you expected:
>
> #!/bin/bash
> cp ../sata_nv.c.orig drivers/ata/sata_nv.c
> git bisect good
> cp drivers/ata/sata_nv.c ../sata_nv.c.orig
> cp ../sata_nv.c drivers/ata/
> make oldconfig
> make -j4
>
> Where "../sata_nv.c" is the version from 2.6.20-rc5. The copying is done
> to avoid conflicts and keep git happy. Of course there's also a version
> for bad kernels ;) No idea, why I didn't make that an argument to the
> script...
>
> Thanks,
> Björn

Argggg, 2.6.19 (with 2.6.20-rc5 adma stuff) is affected too (BTW, what do you 
do to trigger the exceptions? Because, it takes hours to "reproduces" this
silly *************).

But, this time it looks slightly different:
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xec Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
!!!
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x1)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
!!!
ata3: hard resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back


Oh, and I got this nice SMART Error: 

ID# ATTRIBUTE_NAME		FLAG		RAW VALUE
199 UDMA_CRC_Error_Count    0x003e   ...      -       12

SMART Error Log Version: 1
ATA Error Count: 1
        CR = Command Register [HEX]
        FR = Features Register [HEX]
        SC = Sector Count Register [HEX]
        SN = Sector Number Register [HEX]
        CL = Cylinder Low Register [HEX]
        CH = Cylinder High Register [HEX]
        DH = Device/Head Register [HEX]
        DC = Device Command Register [HEX]
        ER = Error register [HEX]
        ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 1 occurred at disk power-on lifetime: 5603 hours (233 days + 11 hours)
  When the command that caused the error occurred, the device was in an 
unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  04 51 3f 00 00 00 af

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  91 00 3f 00 00 00 0f 00      05:30:59.655  INITIALIZE DEVICE PARAMETERS 
[OBS-6]
  ec 00 01 01 00 00 00 00      05:30:59.654  IDENTIFY DEVICE
  ec 00 00 00 00 00 00 00      05:30:56.191  IDENTIFY DEVICE
  ca 00 28 02 ee 9a 0c 00      05:30:56.190  WRITE DMA
  ca 00 10 e8 4c 10 0a 00      05:30:56.190  WRITE DMA


Maybe, it's really the HDD!

OT: "http://www.nvidia.com/object/680i_hotfix.html"  


Chr.
