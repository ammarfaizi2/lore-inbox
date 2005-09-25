Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVIYVHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVIYVHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVIYVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:07:04 -0400
Received: from pop.gmx.de ([213.165.64.20]:9913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932296AbVIYVHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:07:01 -0400
X-Authenticated: #20450766
Date: Sun, 25 Sep 2005 23:06:56 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3slvtzf72.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0509252026290.3089@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Peter Osterlund wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> > Just tried pktcdvd on 2.6.13.1. The setup went fine:
> > 
> > 20:33:13: pktcdvd: writer pktcdvd0 mapped to hdc
> > 20:33:21: pktcdvd: inserted media is CD-RW
> > 20:33:21: pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
> > 20:33:21: pktcdvd: Max. media speed: 10
> > 20:33:21: pktcdvd: write speed 10x
> > 20:33:21: pktcdvd: 590528kB available on disc
> > 20:33:23: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2005/09/24 20:18 (1078)
> > 
> > But, as I tried to copy some files to the CD-RW, it first went ok, but 
> > then produced the following:
> > 
> > 20:41:01: ide-cd: cmd 0x2a timed out
> > 		      ^^^^	---------> write10
> > 20:41:01: hdc: DMA timeout retry
> > 20:41:01: hdc: timeout waiting for DMA
> > 20:41:01: hdc: status timeout: status=0xd0 { Busy }
> > 20:41:01: ide: failed opcode was: unknown
> > 20:41:01: hdc: drive not ready for command
> > 20:41:31: hdc: ATAPI reset timed-out, status=0x80
> > 20:42:06: ide1: reset timed-out, status=0x80
> > 20:42:06: hdc: status timeout: status=0x80 { Busy }
> > 20:42:06: ide: failed opcode was: unknown
> > 20:42:06: hdc: drive not ready for command
> > 20:42:36: hdc: ATAPI reset timed-out, status=0x80
> > 20:43:07: : I/O error, dev hdc, sector 136672
> > 20:43:07: end_request: I/O error, dev hdc, sector 136680
> > 20:43:07: end_request: I/O error, dev hdc, sector 136688
> > 20:43:07: end_request: I/O error, dev hdc, sector 136696
> > 20:43:07: end_request: I/O error, dev hdc, sector 137216
> > 20:43:07: end_request: I/O error, dev hdc, sector 137224
> > 20:43:07: end_request: I/O error, dev hdc, sector 137232
> > 20:43:07: end_request: I/O error, dev hdc, sector 137240
> > ... <thousands of the above>
> > 20:43:11: end_request: I/O error, dev hdc, sector 344440
> > 20:43:11: end_request: I/O error, dev hdc, sector 344444
> > 20:43:11: pktcdvd: bb 00 06 ea 06 ea 00 00 00 00 00 00 - sense 00.e0.0e (No sense)
> > 20:43:11: end_request: I/O error, dev hdc, sector 363008
> > 20:43:11: end_request: I/O error, dev hdc, sector 363016
> > ... <more of them>
> > 20:43:11: printk: 79693 messages suppressed.
> > 20:43:11: Buffer I/O error on device pktcdvd0, logical block 90752
> > 20:43:11: lost page write due to I/O error on pktcdvd0
> > 20:43:11: end_request: I/O error, dev hdc, sector 362880
> > 20:43:11: end_request: I/O error, dev hdc, sector 362884
> > ...
> > 
> > the "cp" finished earlier, I did a sync, and it also finished. The good 
> > parts - no Oops, no process stuck in "D", tha bad parts - it didn't 
> > work:-), the IDE LED stays on and I cannot eject the CD. The CD-R is a 
> > BenQ 52x32x52 Seamless Link alone on ide1, the disk does indeed say 
> > 4x-10x. The cd-writer works mostly... if I am gentle to it - I usually 
> > burn at 32x even if the media says 52x... Is it just a hw-failure or a 
> > driver bug?
> 
> Did it ever work with this hardware, for example using 2.6.12?

It was the first time I ever tried it. Now as you asked I also tried 
2.6.12-rc5. Surprise, surprise - it worked... But very strange. First, I 
did

# time cp -a source /cdrom/ ; time sync

It took a few minutes to copy 190MB, but it finished successfully. Now to 
the strange things: even after it finished the LED on the writer continued 
flashing red... Only after I performed a read access to /cdrom/ it 
stopped. Actually, just wrote a small file to it, did a sync, sync 
returned, LED is flashing red. Now I cannot stop it by reading. Only 
unmounting it helped.

> Does the drive have the latest firmware? If not, a firmware upgrade 
> might help.

Yeah, seems to be. But, likely, unusable for me - I don't have Windows at 
home. Don't know how relevant that BIOS upgrade would be. Here's comment 
from the BenQ site:

<quote>

Firmware Update

Changes:

1. Fix misjudgement for 8cm CD-R disc.
2. Solution for CD Extra reading issue.
3. Enable quality test function on CD-DVD Speed v3.x.

YQS.zip  	 143 KB  	Version: Y.QS 	 01-10-2004 	

Changes:

Added solution for disc auto-play function in Windows XP SP2.

YRS.zip  	 143 KB  	Version: Y.RS 	 11-11-2004

</quote>

Besides, it works under 2.6.12-rc5...

> Does it work if you use ide-scsi instead of ide-cd?

No. I get

# mount ./pktcdvd0 /cdrom -t udf -o rw,noatime
pktcdvd: inserted media is CD-RW
pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
pktcdvd: Max. media speed: 10
pktcdvd: write speed 10x
pktcdvd: 590528kB available on disc
UDF-fs: No partition found (1)
mount: wrong fs type, bad option, bad superblock on ./pktcdvd0,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

> What errors do you get if you try to burn at 52x without using the
> packet writing driver?

Well, to compare packet / "normal" I just tried the same CD-RW with 
cdrecord as /dev/hdc at the same speed 10 (max for this CD) - it worked.

Thanks
Guennadi
---
Guennadi Liakhovetski
