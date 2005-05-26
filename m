Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVEZPcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVEZPcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVEZPcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:32:07 -0400
Received: from math.ut.ee ([193.40.36.2]:1740 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261558AbVEZPcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:32:00 -0400
Date: Thu, 26 May 2005 18:31:39 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>
Subject: ide-cd problem in 2.6.12-rc5 + todays snapshot
Message-ID: <Pine.SOC.4.61.0505261816190.28439@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background: I have a Sony CDU5211 CD drive with Intel D815EEA2 mainboard 
(ICH2 IDE in 815 chipset). Since 2.4.21 timeframe IDE DMA for this CD 
drive is broken (see my post 
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/0480.html). This 
happens on at least 2 identical machines. This is the first problem 
(that I have learned to live with).

Now, since ide-cd dma is broken, the first access to cd always gets DMA 
timeout and turns off DMA, then it works. I have hddtemp installed and 
it probes for drives on boot. In 2.6.12 (and I think I tested pristine 
2.6.12-rc5 too) the cd works as before - dma timeout+disable on first 
access (by hddtemp).

Now, in 2.6.12-rc5 + todays git snapshot, it does not work any more. I 
suspect the DMA alignment change.

In 2.6.12-rc2 the dmesg from hddtemp was

hdc: DMA disabled
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xb0

In todays snapshot, the dmesg is

hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)

and so on ad infimum.

The messages are very similar to my earlier reported problems that were 
fixed:
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/1003.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/0459.html


-- 
Meelis Roos (mroos@linux.ee)
