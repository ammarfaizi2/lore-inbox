Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbQLZAAm>; Mon, 25 Dec 2000 19:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQLZAAW>; Mon, 25 Dec 2000 19:00:22 -0500
Received: from felix.convergence.de ([212.84.236.131]:19726 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S131140AbQLZAAV>;
	Mon, 25 Dec 2000 19:00:21 -0500
Date: Tue, 26 Dec 2000 00:29:44 +0100
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
Message-ID: <20001226002944.A6058@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I bought 4 ATA-100 Maxtor drives and put them on a Promise Ultra100
controller to make a single striping RAID of them to increase
throughput.

I wrote a small test program that simply reads stdin linearly and
displays the throughput.  The block size is 100k.  This is the result:

  # cat /etc/raidtab
  raiddev /dev/md/0
	  raid-level 0
	  nr-raid-disks 4
	  persistent-superblock 1
	  chunk-size 32

	  device /dev/ide/host2/bus0/target0/lun0/part1
	  raid-disk 0
	  device /dev/ide/host2/bus0/target1/lun0/part1
	  raid-disk 2

	  device /dev/ide/host2/bus1/target0/lun0/part1
	  raid-disk 1
	  device /dev/ide/host2/bus1/target1/lun0/part1
	  raid-disk 3

Here are the results of my test program on the disk devices:
  # rb < /dev/ide/host2/bus0/target0/lun0/part1
  27.8 meg/sec
  # rb < /dev/ide/host2/bus0/target0/lun0/part1
  26.8 meg/sec

the other two disks have approximately the same numbers.

Here is the result of my test program on the strip set:
  # rb < /dev/md/0
  30.3 meg/sec
  #

While this is faster than linear mode, I would have expected much better
performance.  These are the boot messages of the Promise adapter:

  PDC20267: IDE controller on PCI bus 00 dev 60
  PDC20267: chipset revision 2
  PDC20267: not 100% native mode: will probe irqs later
  PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
      ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
      ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
  ide2 at 0xdc00-0xdc07,0xe002 on irq 10
  ide3 at 0xe400-0xe407,0xe802 on irq 10
  hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
  hdf: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
  hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
  hdh: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)

I tuned the devices with hdparm -c 1 -a 32 -m 16 -p -u 1, for what it's worth
(did not increase throughput but appeared to lessen the CPU usage).

To verify that this is not an issue of the Promise controller, I started
two instances of my test tool at the same time, one working on hde, the
other on hdg (the two channels).  Both yielded approximately 25 meg/sec,
so it does not appear to be a hardware or driver issue.  Is the RAID
code really this slow?  Any ideas what I can do?

I am using the user space tools from raidtools-19990421-0.90.tar.bz2,
but that should not have any influence, right?

I heard that there is a new, faster RAID code somewhere, but it only
claimed to be faster on RAID level 5, not on striping.

Any tuning advice?

By the way: I noticed another thing: one of the Maxtor hard disks was
broken.  It caused the whole box to freeze solid (no numlock, no console
switches, no sysrq).  That to me severely limits the usefulness of IDE
RAID.  While SCSI problems cause trouble, too, I have never seen one
cause a complete freeze.  How am I supposed to hot-swap the disks?
I am using VESA framebuffer, so maybe there was a panic and it simply
did not appear on my screen (or in the logs).

Hope to hear from you soon (the RAID is needed on Dec 27).
Should I use LVM instead of the MD code?

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
