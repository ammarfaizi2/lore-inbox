Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTBETgn>; Wed, 5 Feb 2003 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBETgn>; Wed, 5 Feb 2003 14:36:43 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:65176 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S264729AbTBETgj>; Wed, 5 Feb 2003 14:36:39 -0500
Message-ID: <3E4169E3.4050003@bogonomicon.net>
Date: Wed, 05 Feb 2003 13:45:39 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
CC: "'Stephan von Krawczynski'" <skraw@ithnet.com>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <009f01c2cd35$d9015860$020da8c0@nitemare>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks similar to what I complained about in "PDC292XX DMA
loss in 2.4.21-pre3-ac4".  I can reproduce my problem but it only 
happens randomly under heavy load.  I have to load down accesses
to both disks (each on their own channel as master) on the
controller.  The same task running on only one of the disks sees
no problems.

    http://www.ussg.iu.edu/hypermail/linux/kernel/0301.3/0239.html

The only differnce now is I have seen it on both disks on the
PDC29269.  I have one disk on each channel.  I've ruled out problems 
with the hardware.  I'm now using different cables and a differnt 
PDC29269 controller.

This is from earlier today.

Feb  5 10:57:11 blip kernel: hdg: dma_intr: status=0xd0 { Busy }
Feb  5 10:57:11 blip kernel:
Feb  5 10:57:11 blip kernel: hdg: DMA disabled
Feb  5 10:57:11 blip kernel: PDC202XX: Secondary channel reset.
Feb  5 10:57:11 blip kernel: ide3: reset: success

This one is recent after the reboot after the one above.

Feb  5 13:22:42 blip kernel: hde: dma_intr: status=0xd0 { Busy }
Feb  5 13:22:42 blip kernel:
Feb  5 13:22:42 blip kernel: hde: DMA disabled
Feb  5 13:22:42 blip kernel: PDC202XX: Primary channel reset.
Feb  5 13:22:43 blip kernel: ide2: reset: success

It happened after about 12 minutes run time on the script below.

#!/bin/bash
mount1=/data5 # {mount point of disk one}
mount2=/data6 # {mount point of disk two}
mount3=/usr   # Further load to use up DMA channel time

(while(true)
do
    find /$mount1 -type f -print | xargs wc
done > /dev/null) &
(while(true)
do
    find /$mount2 -type f -print | xargs wc
done > /dev/null) &
(while(true)
do
    find /$mount3 -type f -print | xargs wc
done > /dev/null) &
wait

exit 0


I haven't looked at the code yet, but it comes to mind what
happens when one has run out of DMA channels or interrupts
to service requests?  My system has both the PDC29269 channels
on a shared interrupt with the a couple of other devices.  My
motherboard is a ASUS A7N8X with the nForce2 chipset.

- Bryan

Robbert Kouprie wrote:
 > Benjamin Herrenschmidt wrote:
 >
 >
 >>>Feb 4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
 >>>Feb 4 01:02:22 admin kernel:
 >>>Feb 4 01:02:22 admin kernel: PDC202XX: Primary channel reset.
 >>>Feb 4 01:02:22 admin kernel: ide2: reset: success
 >>>Feb 4 01:02:23 admin kernel: hde: status error: status=0x58 { DriveReady
 >>
 > SeekComplete DataRequest }
 >
 >>>Feb 4 01:02:23 admin kernel:
 >>>Feb 4 01:02:23 admin kernel: hde: drive not ready for command
 >>>Feb 4 01:02:23 admin kernel: hde: status error: status=0x50 { DriveReady
 >>
 > SeekComplete }
 >
 >>>Feb 4 01:02:23 admin kernel:
 >>>Feb 4 01:02:23 admin kernel: hde: no DRQ after issuing WRITE
 >>>Feb 4 01:02:23 admin kernel: hde: status timeout: status=0xd0 { Busy }
 >>>Feb 4 01:02:23 admin kernel:
 >>
 >>Hi Alan !
 >>
 >>I'm trying to get some sense out of the above report as it seem to match
 >>a problem a user reported me as well. It's interesting because it's
 >>apparently running UP, so it's not the SMP race found by Ross. It's
 >>definitely a problem with shared interrupt though.
 >
 >
 > Hi all,
 >
 > I experience a similar problem too on UP (and UP kernel, no preempt, no
 > taskfile, no acpi). Having replaced almost all hardware involved, I'm 99%
 > sure it isn't a hardware problem. I reported to Alan & Andre privately at
 > the time, but unfortunately there was no way to reproduce it, so nothing
 > came out of it. Also there have been a few threads where it looks like
 > people report the same problem.
 >
 > Like:
 > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0210.3/0416.html (2nd
 > paragraph)
 > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.1/0547.html
 > (replacing the cable actually _didn't_ fix it in the end)
 >
 > System is a PIII-866 on an Asus board, WD1800JB 180Gb on pri master
 > (UDMA100), WD1200BB 120Gb sec master (UDMA100) on an Promise PDC20269 PCI
 > card, kernel 2.4.20-rc1-ac4 (yes it's an older one, but testing is 
hard, as
 > it sometimes takes a month for the problem to show up again).
 >
 > In a shared interrupt setup (i.e. 2 disks on each channel of the 
PDC), the
 > machine will just crash in unpredictable ways, without leaving 
traces. With
 > only the 180Gb drive on the PDC, there's no interrupt sharing, and the
 > system is able to stay alive when the error happens, it's just the 
disk that
 > drops dead in that case. Box has to be powered off (resetting doesn't 
help)
 > for the drive to get alive again. The logs say:
 >
 > Nov  1 08:24:14 Bambi kernel: hde: dma_timer_expiry: dma status == 0x21
 > Nov  1 08:24:24 Bambi kernel: PDC202XX: Primary channel reset.
 > Nov  1 08:24:24 Bambi kernel: hde: timeout waiting for DMA
 > Nov  1 08:24:24 Bambi kernel: hde: (__ide_dma_test_irq) called while not
 > waiting
 > Nov  1 08:24:24 Bambi kernel: blk: queue c02d5e58, I/O limit 4095Mb (mask
 > 0xffffffff)
 > Nov  1 08:24:34 Bambi kernel: hde: irq timeout: status=0xd0 { Busy }
 > Nov  1 08:24:34 Bambi kernel:
 > Nov  1 08:24:34 Bambi kernel: hde: DMA disabled
 > Nov  1 08:24:34 Bambi kernel: PDC202XX: Primary channel reset.
 > Nov  1 08:25:04 Bambi kernel: ide2: reset timed-out, status=0xd0
 > Nov  1 08:25:04 Bambi kernel: hde: status timeout: status=0xd0 { Busy }
 > Nov  1 08:25:04 Bambi kernel:
 > Nov  1 08:25:04 Bambi kernel: PDC202XX: Primary channel reset.
 > Nov  1 08:25:34 Bambi kernel: ide2: reset timed-out, status=0xd0
 >
 > A few times I tried to reset the drive with hdparm using "hdparm -w
 > /dev/hde". This didn't have success and produced the following log 
messages:
 >
 > Nov  1 12:02:57 Bambi kernel: hde: DMA disabled
 > Nov  1 12:02:57 Bambi kernel: PDC202XX: Primary channel reset.
 > Nov  1 12:02:57 Bambi kernel: hde: ide_timer_expiry: hwgroup->busy 
was 0 ??
 > Nov  1 12:03:27 Bambi kernel: ide2: reset timed-out, status=0xd0
 >
 > Does anyone have any theory of how to reproduce this (maybe with the new
 > theory of Benjamin)? I would be glad to test new kernels, but some 
testcase
 > is required to be able to supply more results (within a reasonable 
amount of
 > time that is ;)).
 >
 > Below all specs in the shared irq setup, 2 drives on the 20269, one 
on each
 > channel. (In the non-shared setup, I moved the WD 120Gb to an extra
 > PDC20262, no interrupts were shared.)
 >
 > Regards,
 > - Robbert Kouprie
 >


