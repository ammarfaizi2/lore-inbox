Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278052AbRJIXBg>; Tue, 9 Oct 2001 19:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278053AbRJIXB0>; Tue, 9 Oct 2001 19:01:26 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:6162 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S278052AbRJIXBN>;
	Tue, 9 Oct 2001 19:01:13 -0400
Message-ID: <3BC381DE.4090300@thock.com>
Date: Tue, 09 Oct 2001 17:01:50 -0600
From: Dylan Griffiths <dylang+kernel@thock.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010926
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: HPT 370 / RAID 5 possible corruption issue.]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm forwarding this here since Ingo/Andre haven't replied to me in a week. 
  I don't like silent data corruption, so I hope SOMEONE pays attention to 
this.

-------- Original Message --------
Subject: HPT 370 / RAID 5 possible corruption issue.
Date: Tue, 02 Oct 2001 13:44:24 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
To: Andre Hedrick <andre@linux-ide.org>
CC: mingo@redhat.com

	Hi.  I have an HPT 370 in a box here.  It has 2 Quantum drives connectod to
it (one master per channel) that are in a RAID 5 set with two more
Quantums on the VIA onboard IDE controller.  When I run an md5sum of a
group of files vs. the precomputed md5sums, sometimes they don't match in
different spots.

	After googling around the web, I found a similar report with the HPT 366
controller and software RAID:
http://www.linux-consulting.com/Raid/Docs/raid_highload.tst.txt

In there, the fellow found that reading from a drive connected to the HPT
366 controller would have different results depending on load.

The first time I noticed it was on my client box (this is a RAID5 homedir
exported by NFS to the entire LAN).  This sequence shows how I couldn't
verify a download on a TV show I was going to watch:

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r23 : crc does not match
(43BB6DFC!=F53FAF16)
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r36 : crc does not match
(F28A8F31!=E64A1180)
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.rar : crc does not match
(F0A13E95!=5943980D)
41 files, 38 OK, 3 badcrc.  153.198 seconds, 5189.3K/s

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r04 : crc does not match
(C8BDABAB!=BF3DB71A)
41 files, 40 OK, 1 badcrc.  229.229 seconds, 3468.1K/s

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r18 : crc does not match
(74F22550!=CEDD8A8F)
41 files, 40 OK, 1 badcrc.  133.518 seconds, 5954.2K/s

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r22 : crc does not match
(5E5E484E!=CE08A191)
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r25 : crc does not match
(B0006BB7!=38531314)
41 files, 39 OK, 2 badcrc.  132.956 seconds, 5979.4K/s

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  139.748 seconds, 5688.8K/s

dylang@shadowgate:~/movies/TV$ cfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r02 : crc does not match
(484D1D14!=771F6235)
41 files, 40 OK, 1 badcrc.  138.904 seconds, 5723.4K/s

I thought it might've been a network problem, but on the server itself:

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  82.916 seconds, 9588.0K/s

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r26 : crc does not match
(365E02AE!=ED0E2554)                      ** Heavy NFS activity (4 x 100mb
files moved)
41 files, 40 OK, 1 badcrc.  154.080 seconds, 5159.7K/s

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  82.232 seconds, 9667.7K/s

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  81.370 seconds, 9770.2K/s

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  81.954 seconds, 9700.6K/s

dylang@kaneda:~/movies/TV$ ~/cfv Star.Trek.ENT-S1E01-Broken.Bow-Part.2.sfv
Star.Trek.ENT-S1E01-Broken.Bow-Part.2.r*
41 files, 41 OK.  128.051 seconds, 6208.5K/s
      *** lighter NFS activity (1 x 100mb file moved)


	So which is buckling under pressure, the RAID 5 code or the HPT 370 driver 
or card?  The system is an Athlon 550 with 768mb of PC133 RAM running 
2.4.10 and using an EEPro 100 for networking.

root@kaneda:~# cat /proc/interrupts
             CPU0
    0:    5844936          XT-PIC  timer
    1:          2          XT-PIC  keyboard
    2:          0          XT-PIC  cascade
    8:          1          XT-PIC  rtc
    9:    6993615          XT-PIC  eth0
   10:     423816          XT-PIC  ide2, ide3
   14:   17763212          XT-PIC  ide0
   15:    3159230          XT-PIC  ide1


IDE dmesg output:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
      ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 60
PCI: Enabling device 00:0c.0 (0005 -> 0007)
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
      ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:DMA, hdf:pio
      ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:DMA, hdh:pio
hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdb: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdc: FUJITSU MPG3204AT E, ATA DISK drive
hdd: FUJITSU MPG3204AT E, ATA DISK drive
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xdc00-0xdc07,0xd802 on irq 10
ide3 at 0xd400-0xd407,0xd002 on irq 10
hda: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=4866/255/63
hdb: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=4866/255/63
hdc: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63
hdd: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)

RAID info:

root@kaneda:~# cat /proc/mdstat
Personalities : [linear] [raid1] [raid5] [multipath]
read_ahead 1024 sectors
md1 : active linear ide/host0/bus1/target1/lun0/part1[1]
ide/host0/bus1/target0/lun0/part1[0]
        40031488 blocks 32k rounding

md0 : active raid5 ide/host2/bus1/target0/lun0/part6[3]
ide/host2/bus0/target0/lun0/part6[2] ide/host0/bus0/target1/lun0/part6[1]
ide/host0/bus0/target0/lun0/part6[0]
        111266112 blocks level 5, 32k chunk, algorithm 2 [4/4] [UUUU]

unused devices: <none>



-- 
     www.kuro5hin.org -- technology and culture, from the trenches.
                          -=-=-=-=-=-
Those that give up liberty to obtain safety deserve neither.
  -- Benjamin Franklin
   http://www.zdnet.com/zdnn/stories/news/0,4586,2812463,00.html
   http://slashdot.org/article.pl?sid=01/09/16/1647231
                          -=-=-=-=-=-

