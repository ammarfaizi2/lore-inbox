Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289750AbSBJU5W>; Sun, 10 Feb 2002 15:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSBJU5D>; Sun, 10 Feb 2002 15:57:03 -0500
Received: from mallaury.noc.nerim.net ([62.4.17.82]:20746 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S289750AbSBJU46>; Sun, 10 Feb 2002 15:56:58 -0500
Date: Sun, 10 Feb 2002 21:56:53 +0100
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, neilb@cse.unsw.edu.au, andre@linux-ide.org,
        jmontpezat@nerim.net
Subject: [RAID-soft,ATA,WD] problems with a RAID5 disc not detected 
Message-ID: <20020210205653.GA20212@calixo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

  I've got a strange problem with a machine, a K6-3 on an ASUS P5A-B
motherboard (ALi chipset). There were three discs, all of different brands
but all roughly of 6 Gb (for slighly differing manufacturers' value of
"gigabyte"), with some partitions mounted in RAID5 (recently upgraded to "new-style"
raidtools).

After two years, the WD disc failed. No big deal, M. Spare Parts happily
sold a new one.
Nowadays, it's very difficult to find 6 Gb discs, so the smallest and
cheapest available turned out to be a 40 Gb model. Again, no big deal
thought I, the motherboard supports ATA/33, so I expected things to still 
run normally. 

Blam! the BIOS refuses to detect the WD disc, unless it's the only disc on
its ribbon cable (even with a 80-wire cable). Fortunately, Linux doesn't
really care, and it was possible to make use of this bad boy.  

*However*, every time I boot, even though the disc is properly detected and
its partition table read, the new WD (40 Gb) discs's partitions are ignored
by the RAID5 autodetector. When the machine hits runlevel 2, it is possible
to manually raidhotadd back the partitions, and after the reconstruction is
complete, things seem to work normally, but there is obviously something
wrong.

I've tried 2.4.18-pre9 and 2.4.18-pre7-ac3 this morning (-ac3 to check
whether Andre's new IDE stuff helps -- identical results). Here's the
salient bits of dmesg (2.4.18-pre9 -- there is a small NULL dereference in
-ac3, which I'll gladly ksymoops if that matters, but I don't think it does
for this particular problem); I've added at the bottom of this message an
URL to the raw data (and more):

ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
pci=biosirq.

--> OK, some complaints, but they're not related to RAID5, are they ?

ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST36422A, ATA DISK drive
hdb: WDC WD400BB-32CCB0, ATA DISK drive
hdc: QUANTUM FIREBALL EX6.4A, ATA DISK drive
hdd: IDE-CD R/RW 16x10A, ATAPI CD/DVD-ROM drive

----> all four discs are here, fine. The BIOS doesn't detect hdb.

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12500460 sectors (6400 MB) w/256KiB Cache, CHS=778/255/63, UDMA(33)
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, (U)DMA
hdc: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=13328/15/63, UDMA(33)
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
 /dev/ide/host0/bus0/target1/lun0: [PTBL] [4865/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 >
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >

---> OK, [PTBL] but the kernel did detect the disc and found its correct geometry, didn't it ?

md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   644.400 MB/sec
   32regs    :   459.600 MB/sec
   pII_mmx   :   940.400 MB/sec
   p5_mmx    :   931.600 MB/sec
raid5: using function: pII_mmx (940.400 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000000e]
 [events: 0000000e]
 [events: 0000000e]
 [events: 0000000e]
md: autorun ...
md: considering ide/host0/bus1/target0/lun0/part6 ...
md:  adding ide/host0/bus1/target0/lun0/part6 ...
md:  adding ide/host0/bus0/target0/lun0/part6 ...
md: created md0
md: bind<ide/host0/bus0/target0/lun0/part6,1>
md: bind<ide/host0/bus1/target0/lun0/part6,2>
md: running: <ide/host0/bus1/target0/lun0/part6><ide/host0/bus0/target0/lun0/part6>
md: ide/host0/bus1/target0/lun0/part6's event counter: 0000000e
md: ide/host0/bus0/target0/lun0/part6's event counter: 0000000e
md0: former device ide/host0/bus0/target1/lun0/part6 is unavailable, removing from array!
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k

----> what the hell is going on ? ide/host0/bus0/target1/lun0/part6 has been
detected, even if through fallback (the BIOS didn't help, but which BIOS is
actually helpful/useful ?). Yet, the md layer didn't consider that partition
for inclusion.

raid5: device ide/host0/bus1/target0/lun0/part6 operational as raid disk 2
raid5: device ide/host0/bus0/target0/lun0/part6 operational as raid disk 0
raid5: md0, not all disks are operational -- trying to recover array
raid5: allocated 3291kB for md0
raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host0/bus0/target0/lun0/part6
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host0/bus1/target0/lun0/part6
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host0/bus0/target0/lun0/part6
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host0/bus1/target0/lun0/part6
md: updating md0 RAID superblock on device
md: ide/host0/bus1/target0/lun0/part6 [events: 0000000f]<6>(write) ide/host0/bus1/target0/lun0/part6's sb offset: 1052608
md: recovery thread got woken up ...
md0: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: ide/host0/bus0/target0/lun0/part6 [events: 0000000f]<6>(write) ide/host0/bus0/target0/lun0/part6's sb offset: 1052160
md: considering ide/host0/bus1/target0/lun0/part5 ...
md:  adding ide/host0/bus1/target0/lun0/part5 ...
md:  adding ide/host0/bus0/target0/lun0/part5 ...
md: created md1
md: bind<ide/host0/bus0/target0/lun0/part5,1>
md: bind<ide/host0/bus1/target0/lun0/part5,2>
md: running: <ide/host0/bus1/target0/lun0/part5><ide/host0/bus0/target0/lun0/part5>
md: ide/host0/bus1/target0/lun0/part5's event counter: 0000000e
md: ide/host0/bus0/target0/lun0/part5's event counter: 0000000e
md1: former device ide/host0/bus0/target1/lun0/part5 is unavailable, removing from array!
md1: max total readahead window set to 496k
md1: 2 data-disks, max readahead per data-disk: 248k
raid5: device ide/host0/bus1/target0/lun0/part5 operational as raid disk 2
raid5: device ide/host0/bus0/target0/lun0/part5 operational as raid disk 0
raid5: md1, not all disks are operational -- trying to recover array
raid5: allocated 3291kB for md1
raid5: raid level 5 set md1 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host0/bus0/target0/lun0/part5
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host0/bus1/target0/lun0/part5
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host0/bus0/target0/lun0/part5
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host0/bus1/target0/lun0/part5
md: updating md1 RAID superblock on device
md: ide/host0/bus1/target0/lun0/part5 [events: 0000000f]<6>(write) ide/host0/bus1/target0/lun0/part5's sb offset: 1052608
md: recovery thread got woken up ...
md1: no spare disk to reconstruct array! -- continuing in degraded mode
md0: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: ide/host0/bus0/target0/lun0/part5 [events: 0000000f]<6>(write) ide/host0/bus0/target0/lun0/part5's sb offset: 1052160
md: ... autorun DONE.

etc.

The boot proceeds, the system is brought up, even in degraded mode. When I
can log into the machine, I can raidhotadd back the missing partitions, and
after a couple minutes, everything's back. So, it's not like the partitions
on the WD disc are unusable by the MD layer, it's just that it somehow
refuses to consider them at boot time. Why ?

I've posted more detailed data at http://www.chepelov.org/cyrille/lktoro, in
case these are needed:

muscat% ls
config-2.4.18-pre7-ac3    dmesg-2.4.18-pre7-ac3                   hdparm md1.conf
config-2.4.18-pre9        dmesg-2.4.18-pre7-ac3-after-raidhotadd  lspci
dev-mdstat--normal_state  dmesg-2.4.18-pre9                       md0.conf

Thank you very much in advance for any help !

Bottom line: after the "Caviar discs have so much pride they accept being
slaves only of fellow Caviar discs" stupidity of the early '90s, the "WD
can't bother to make their discs compatible with three year old machines
while still advertising this feature" new stupidity won Western Digital a place of
choice on my hardware blacklist (not that I'm really a market maker,
unfortunately ;-) )

	-- Cyrille


-- 
Grumpf.

