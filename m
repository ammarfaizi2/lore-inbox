Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbRCCBUj>; Fri, 2 Mar 2001 20:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRCCBUa>; Fri, 2 Mar 2001 20:20:30 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:52657 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S130210AbRCCBUU>; Fri, 2 Mar 2001 20:20:20 -0500
Message-Id: <5.0.2.1.2.20010302135432.00af8ae0@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 02 Mar 2001 17:18:12 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Linux 2.4.2-ac5 IDE Software Raid(ata/100) Problem..Kernel
  Oops?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Problem description
2. Machine details
	a) Hardware
	b) Software
3. System log during the incident

1. Problem Description:

I have a software raid 5 with 1 spare. (9 total drives dedicated for raid) 
with a seperate Boot drive for the system.

Before this new problem, I had many problems with DMA timing out, and the 
notorious CRC errors.  None of these problems exist now.  The problem now 
is related to the raid code or something in the kernel.  One of the raid 
drives had problems and died, the spare disk (/dev/hdc) took over without a 
problem.  I went back to the shop and got a brand new disk and replaced the 
old one.  Started up the raid and wanted to make /dev/hdi an active disk 
again and /dev/hdc1 as the spare disk.  This isn't really possible because 
the old-spare drive is now part of the active array.  So my only choice is 
to set the drive as faulty and replace it with /dev/hdi and then re-add it 
and use it as a spare.  The next step was to use the "raidsetfaulty" 
command to mark /dev/hdc as a bad drive and then take it offline with 
"raidhotremove". Then I added /dev/hdi to the raid and it was marked as the 
new spare disk.  This step didnt cause any problems untill sync was 
completed.  After the sync finally completed, this was recorded in the syslog:

Mar  2 13:44:38 bertha kernel: md: md0: sync done.
Mar  2 13:44:38 bertha kernel: RAID5 conf printout:
Mar  2 13:44:38 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 13:44:38 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 13:44:38 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 13:44:38 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 13:44:38 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 13:44:38 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 13:44:38 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 13:44:38 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 13:44:38 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 13:44:38 bertha kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000038
Mar  2 13:44:38 bertha kernel:  printing eip:
Mar  2 13:44:38 bertha kernel: c01ed5ee
Mar  2 13:44:38 bertha kernel: *pde = 00000000
Mar  2 13:44:38 bertha kernel: Oops: 0000
Mar  2 13:44:38 bertha kernel: CPU:    0
Mar  2 13:44:38 bertha kernel: EIP:    0010:[raid5_diskop+910/1520]
Mar  2 13:44:38 bertha kernel: EFLAGS: 00010086
Mar  2 13:44:38 bertha kernel: eax: 00000000   ebx: cdbf04f0   ecx: 
00000000   edx: 00000008
Mar  2 13:44:38 bertha kernel: esi: ce39189c   edi: 00000008   ebp: 
cdbf0448   esp: cfeb3ed4
Mar  2 13:44:38 bertha kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 13:44:38 bertha kernel: Process mdrecoveryd (pid: 7, stackpage=cfeb3000)
Mar  2 13:44:38 bertha kernel: Stack: cde62100 cde62400 cdbf0438 cdbf04e0 
cde62600 cde62300 cde62000 cdbf0400
Mar  2 13:44:38 bertha kernel:        ffffffff 00000002 00000000 00000008 
0000b00f cfeb3f24 0900000a 04797300
Mar  2 13:44:38 bertha kernel:        00000000 cfeb2000 cfec6e78 cfec6e78 
047680e0 0476d9c8 04772964 04777e68
Mar  2 13:44:38 bertha kernel: Call Trace: [md_do_recovery+457/560] 
[md_thread+238/336] [md_thread+0/336] [kernel_thread+43/64]
Mar  2 13:44:38 bertha kernel:
Mar  2 13:44:38 bertha kernel: Code: 8b 41 38 89 46 38 89 51 38 8d 7c 24 2c 
8b 74 24 10 fc b9 20

Now, here's a snapshot from /proc/mdstat after /dev/hdc and /dev/hdi were 
added to the raid and the syn was completed

Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md0 : active raid5 hdc1[9] hdi1[8] hds1[7] hdq1[6] hdo1[5] hdm1[4] hdk1[3] 
hdg1[1] hde1[0]
       525477120 blocks level 5, 4k chunk, algorithm 2 [8/7] [UU_UUUUU]

unused devices: <none>

This says that one device is still faulty and simply will not recognize 
that /dev/hdi is now back online.  The drive has been added to the array, 
is functioning properly, is reported as active by /proc/mdstat (check md0 
3rd line above).  Also note that in the syslog, since the disk has failed, 
the second disk (/dev/hdi) is always reported as
Mar  2 10:48:17 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
which should be (from a previous log):
Jan 29 06:12:11 bertha kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdi1

Any Ideas?


Hardware Details:

Motherboard	: ASUS A7V With the VIA KT133 Chipset
Processor+RAM: AMD Athalon Tbird 1GHz with 512MB RAM
Onboard IDE	: 2 IDE Ports ata/33 (UNUSED)
		: 2 UDMA ATA/100 ports Promise PDC20265)
		hda: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63, UDMA(100)
		hdb: <slave not used>
		hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdd: <slave not used>
PCI CARD 1	: Promise ATA/100 PDC20267
		hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdf: <slave not used>
		hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdh: <slave not used>
PCI CARD 2	: Promise ATA/100 PDC20267
		hdi: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdj: <slave not used>
		hdk: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdl: <slave not used>
PCI CARD 3	: Promise ATA/100 PDC20267
		hdm: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdn: <slave not used>
		hdo: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdp: <slave not used>
PCI CARD 4	: Promise ATA/100 PDC20267
		hdq: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdr: <slave not used>
		hds: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, 
UDMA(100)
		hdt: <slave not used>
PCI CARD 5	: NetGear GA620 Gigabit Ethernet

System Details:
		Using Linux Kernel 2.4.2-ac5
		10 Drives total.
		System Drive:
			/dev/hda is the system drive and is not part of the raid.
		Raid:
			all drives from /dev/hdc to /dev/hds are  part of a raid 5 array (/dev/md0)
			/dev/hdc is the spare drive.

3. System Log: (Condensed version, I tried to not cut anything important, 
just redundant messages)

Mar  2 10:47:30 bertha kernel: md0 stopped.
<md0 started>
Mar  2 10:48:16 bertha kernel: running: 
<hdc1><hds1><hdq1><hdo1><hdm1><hdk1><hdg1><hde1>
Mar  2 10:48:17 bertha kernel: md0: 7 data-disks, max readahead per 
data-disk: 1024k
Mar  2 10:48:17 bertha kernel: raid5: spare disk hdc1
Mar  2 10:48:17 bertha kernel: raid5: md0, not all disks are operational -- 
trying to recover array
Mar  2 10:48:17 bertha kernel: raid5: allocated 8504kB for md0
Mar  2 10:48:17 bertha kernel: raid5: raid level 5 set md0 active with 7 
out of 8 devices, algorithm 2
Mar  2 10:48:17 bertha kernel: RAID5 conf printout:
Mar  2 10:48:17 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 10:48:17 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 10:48:17 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 10:48:17 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 10:48:17 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 10:48:17 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 10:48:17 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 10:48:17 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 10:48:17 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 10:48:17 bertha kernel: md0: resyncing spare disk hdc1 to replace 
failed disk
Mar  2 10:48:17 bertha kernel: md: syncing RAID array md0
Mar  2 10:49:28 bertha kernel: interrupting MD-thread pid 7
Mar  2 10:49:28 bertha kernel: raid5: Disk failure on spare hdc1
Mar  2 10:49:28 bertha kernel: md_do_sync() got signal ... exiting
Mar  2 10:49:28 bertha kernel: RAID5 conf printout:
Mar  2 10:49:28 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 10:49:28 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 10:49:28 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 10:49:28 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 10:49:28 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 10:49:28 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 10:49:28 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 10:49:28 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 10:49:28 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 10:49:28 bertha kernel: md: recovery thread finished ...
Mar  2 10:49:28 bertha kernel: md: recovery thread got woken up ...
Mar  2 10:49:28 bertha kernel: md0: no spare disk to reconstruct array! -- 
continuing in degraded mode
Mar  2 10:49:28 bertha kernel: md: recovery thread finished ...
Mar  2 10:49:41 bertha kernel: trying to hot-add hdi1 to md0 ...
Mar  2 10:49:41 bertha kernel: bind<hdi1,9>
Mar  2 10:49:41 bertha kernel: RAID5 conf printout:
Mar  2 10:49:41 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 10:49:41 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 10:49:41 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 10:49:41 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 10:49:41 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 10:49:41 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 10:49:41 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 10:49:41 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 10:49:41 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 10:49:41 bertha kernel: md: updating md0 RAID superblock on device
Mar  2 10:49:41 bertha kernel: hdi1 [events: 00000052](write) hdi1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: (skipping faulty hdc1 )
Mar  2 10:49:41 bertha kernel: hds1 [events: 00000052](write) hds1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hdq1 [events: 00000052](write) hdq1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hdo1 [events: 00000052](write) hdo1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hdm1 [events: 00000052](write) hdm1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hdk1 [events: 00000052](write) hdk1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hdg1 [events: 00000052](write) hdg1's sb 
offset: 75068160
Mar  2 10:49:41 bertha kernel: hde1 [events: 00000052](write) hde1's sb 
offset: 75068160

Mar  2 10:49:41 bertha kernel: md0: resyncing spare disk hdi1 to replace 
failed disk
Mar  2 10:49:41 bertha kernel: RAID5 conf printout:
Mar  2 10:49:41 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 10:49:41 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 10:49:41 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 10:49:41 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 10:49:41 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 10:49:41 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 10:49:41 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 10:49:41 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 10:49:41 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1

Mar  2 10:49:41 bertha kernel: md: syncing RAID array md0
Mar  2 10:49:41 bertha kernel: md: minimum _guaranteed_ reconstruction 
speed: 100 KB/sec/disc.

Mar  2 10:50:09 bertha kernel: trying to remove hdc1 from md0 ...

Mar  2 10:50:09 bertha kernel: unbind<hdc1,8>
Mar  2 10:50:09 bertha kernel: export_rdev(hdc1)
Mar  2 10:50:09 bertha kernel: md: updating md0 RAID superblock on device
Mar  2 10:50:09 bertha kernel: hds1 [events: 00000054](write) hds1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdi1 [events: 00000055](write) hdi1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdq1 [events: 00000055](write) hdq1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdo1 [events: 00000055](write) hdo1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdm1 [events: 00000055](write) hdm1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdk1 [events: 00000055](write) hdk1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hdg1 [events: 00000055](write) hdg1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: hde1 [events: 00000055](write) hde1's sb 
offset: 75068160
Mar  2 10:50:09 bertha kernel: .
Mar  2 10:50:09 bertha kernel: .
Mar  2 10:50:23 bertha kernel: trying to hot-add hdc1 to md0 ...
Mar  2 10:50:23 bertha kernel: bind<hdc1,9>
Mar  2 10:50:23 bertha kernel: RAID5 conf printout:
Mar  2 10:50:23 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 10:50:23 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 10:50:23 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 10:50:23 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 10:50:23 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 10:50:23 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 10:50:23 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 10:50:23 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 10:50:23 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 10:50:23 bertha kernel: md: updating md0 RAID superblock on device
Mar  2 10:50:23 bertha kernel: hdc1 [events: 00000057](write) hdc1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hds1 [events: 00000057](write) hds1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdi1 [events: 00000057](write) hdi1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdq1 [events: 00000057](write) hdq1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdo1 [events: 00000057](write) hdo1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdm1 [events: 00000057](write) hdm1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdk1 [events: 00000057](write) hdk1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hdg1 [events: 00000057](write) hdg1's sb 
offset: 75068160
Mar  2 10:50:23 bertha kernel: hde1 [events: 00000057](write) hde1's sb 
offset: 75068160
Mar  2 13:44:38 bertha kernel: md: md0: sync done.
Mar  2 13:44:38 bertha kernel: RAID5 conf printout:
Mar  2 13:44:38 bertha kernel:  --- rd:8 wd:7 fd:1
Mar  2 13:44:38 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Mar  2 13:44:38 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Mar  2 13:44:38 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
Mar  2 13:44:38 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Mar  2 13:44:38 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Mar  2 13:44:38 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Mar  2 13:44:38 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Mar  2 13:44:38 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Mar  2 13:44:38 bertha kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000038
Mar  2 13:44:38 bertha kernel:  printing eip:
Mar  2 13:44:38 bertha kernel: c01ed5ee
Mar  2 13:44:38 bertha kernel: *pde = 00000000
Mar  2 13:44:38 bertha kernel: Oops: 0000
Mar  2 13:44:38 bertha kernel: CPU:    0
Mar  2 13:44:38 bertha kernel: EIP:    0010:[raid5_diskop+910/1520]
Mar  2 13:44:38 bertha kernel: EFLAGS: 00010086
Mar  2 13:44:38 bertha kernel: eax: 00000000   ebx: cdbf04f0   ecx: 
00000000   edx: 00000008
Mar  2 13:44:38 bertha kernel: esi: ce39189c   edi: 00000008   ebp: 
cdbf0448   esp: cfeb3ed4
Mar  2 13:44:38 bertha kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 13:44:38 bertha kernel: Process mdrecoveryd (pid: 7, stackpage=cfeb3000)
Mar  2 13:44:38 bertha kernel: Stack: cde62100 cde62400 cdbf0438 cdbf04e0 
cde62600 cde62300 cde62000 cdbf0400
Mar  2 13:44:38 bertha kernel:        ffffffff 00000002 00000000 00000008 
0000b00f cfeb3f24 0900000a 04797300
Mar  2 13:44:38 bertha kernel:        00000000 cfeb2000 cfec6e78 cfec6e78 
047680e0 0476d9c8 04772964 04777e68
Mar  2 13:44:38 bertha kernel: Call Trace: [md_do_recovery+457/560] 
[md_thread+238/336] [md_thread+0/336] [kernel_thread+43/64]
Mar  2 13:44:38 bertha kernel:
Mar  2 13:44:38 bertha kernel: Code: 8b 41 38 89 46 38 89 51 38 8d 7c 24 2c 
8b 74 24 10 fc b9 20

<the system appears to be operating as normal..>

