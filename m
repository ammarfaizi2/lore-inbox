Return-Path: <linux-kernel-owner+w=401wt.eu-S932448AbXAPINn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXAPINn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAPINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:13:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:43624 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbXAPINn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:13:43 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OaS2B5jlpG5/+I57kbRFbRnrjduVYnr+pLfTffK7KslTuCTfNAZom/z1A6SIYYO2zXMKOfXjYCntQI+Q4szjrMoaSwFoIeCHWldjPFNYwtbqv2Cihqk27+cvOwMI4Rk2k1rNs5mYZ/Y+YrOFNONpsWrATAXeCrmKufVIIauEjVk=
Message-ID: <d00698fb0701160013w53d13a4eo6e22ff658fb460bb@mail.gmail.com>
Date: Tue, 16 Jan 2007 09:13:40 +0100
From: noah <noah123@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in drivers/md/md.c ?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm getting "md: bug in file drivers/md/md.c, line 1652" (see below) after
writing data to a md-device using dd.
Is it really a bug or am I just using mdadm in the wrong way? I'm unsure
about the --assume-clean flag when creating the raid5 volume.

My kernel is 2.6.18.

Below are some printouts including instructions on howto reproduce the
problem (at least on my system).
I should mention I've played around with striping the disks/partitions
involved aswell.

I've tried to use --zero-superblock on the devices before creating the array
but it didn't make the problems go away.


# fdisk -l /dev/hda; fdisk -l /dev/hdc; fdisk -l /dev/hdh

Disk /dev/hda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1       10943    87899616   da  Non-FS data
/dev/hda2           10944       30401   156296385   da  Non-FS data

Disk /dev/hdc: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdc1               1       10943    87899616   da  Non-FS data
/dev/hdc2           10944       30401   156296385   da  Non-FS data

Disk /dev/hdh: 200.0 GB, 200049647616 bytes
255 heads, 63 sectors/track, 24321 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdh1               1       19459   156304386   da  Non-FS data
/dev/hdh2           19460       24321    39054015   da  Non-FS data



# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid6] [raid5] [raid4]
md1 : active raid5 hdh1[2] hdc2[1] hda2[0]
      312592512 blocks super 1.0 level 5, 64k chunk, algorithm 2 [3/3] [UUU]

md0 : active raid1 hda1[0] hdc1[1]
      87899544 blocks super 1.0 [2/2] [UU]

unused devices: <none>



How to reproduce:
-----------------

# mdadm --create --assume-clean /dev/md1 -n 3 -l raid5 -e 1.0 /dev/hda2
/dev/hdc2 /dev/hdh1
mdadm: /dev/hda2 appears to be part of a raid array:
    level=raid5 devices=3 ctime=Tue Jan 16 08:13:32 2007
mdadm: /dev/hdc2 appears to be part of a raid array:
    level=raid5 devices=3 ctime=Tue Jan 16 08:13:32 2007
mdadm: /dev/hdh1 appears to be part of a raid array:
    level=raid5 devices=3 ctime=Tue Jan 16 08:13:32 2007
Continue creating array? y
mdadm: array /dev/md1 started.

# tail -f /var/log/everything& dd if=/dev/zero of=/dev/md1 bs=1024k
count=2000
[1] 11612
Jan 16 08:17:33 planet kernel: raid5: device hdh1 operational as raid disk 2
Jan 16 08:17:33 planet kernel: raid5: device hdc2 operational as raid disk 1
Jan 16 08:17:33 planet kernel: raid5: device hda2 operational as raid disk 0
Jan 16 08:17:33 planet kernel: raid5: allocated 3162kB for md1
Jan 16 08:17:33 planet kernel: raid5: raid level 5 set md1 active with 3 out
of 3 devices, algorithm 2
Jan 16 08:17:33 planet kernel: RAID5 conf printout:
Jan 16 08:17:33 planet kernel:  --- rd:3 wd:3 fd:0
Jan 16 08:17:33 planet kernel:  disk 0, o:1, dev:hda2
Jan 16 08:17:33 planet kernel:  disk 1, o:1, dev:hdc2
Jan 16 08:17:33 planet kernel:  disk 2, o:1, dev:hdh1

2000+0 records in
2000+0 records out
2097152000 bytes (2.1 GB) copied, 20.1704 s, 97.6 MB/s
# Jan 16 08:18:25 planet kernel: md: bug in file drivers/md/md.c, line 1652
Jan 16 08:18:25 planet kernel:
Jan 16 08:18:25 planet kernel: md:^I**********************************
Jan 16 08:18:25 planet kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Jan 16 08:18:25 planet kernel: md:^I**********************************
Jan 16 08:18:25 planet kernel: md3:
Jan 16 08:18:25 planet kernel: md2:
Jan 16 08:18:25 planet kernel: md1: <hdh1><hdc2><hda2>
Jan 16 08:18:25 planet kernel: md: rdev hdh1, SZ:156304256 F:0 S:1 DN:2
Jan 16 08:18:25 planet kernel: md: rdev superblock:
Jan 16 08:18:25 planet kernel: md:  SB: (V:1.0.0) ID:<
dfe2a519.00000000.00000000.00000000> CT:4810920a
Jan 16 08:18:25 planet kernel: md:     L370828101 S00000049 ND:0 RD:0 md0
LO:65536 CS:-65534
Jan 16 08:18:25 planet kernel: md:     UT:00000000 ST:0 AD:312608624 WD:0
FD:312608752 SD:0 CSUM:00000000 E:00000000
Jan 16 08:18:25 planet kernel:      D  0:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:25 planet kernel:      D  1:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:25 planet kernel:      D  2:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:25 planet kernel:      D  3:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:25 planet kernel:      D  4:
DISK<N:1523622768,(2102314299,1854133953),R:-156999677,S:1106077391>
Jan 16 08:18:25 planet kernel:      D  5:
DISK<N:210652739,(-1798385262,-1893740592),R:-255389722,S:-686276843>
Jan 16 08:18:26 planet kernel:      D  6:
DISK<N:-2086715584,(-802597153,16977798),R:-124438632,S:2143986971>
Jan 16 08:18:26 planet kernel:      D  7:
DISK<N:367272331,(1828035126,-1723094824),R:1398921667,S:1323308299>
Jan 16 08:18:26 planet kernel:      D  8:
DISK<N:1380081680,(-2083157242,551551245),R:-2139027649,S:855329668>
Jan 16 08:18:26 planet kernel:      D  9:
DISK<N:1735239043,(-1541046209,-529921362),R:-1222307600,S:887119196>
Jan 16 08:18:26 planet kernel:      D 10:
DISK<N:1333588127,(-2104901122,558281879),R:-7033862,S:1671770600>
Jan 16 08:18:26 planet kernel:      D 11:
DISK<N:85030519,(-1114494749,-107508385),R:547372471,S:-495231153>
Jan 16 08:18:26 planet kernel:      D 12:
DISK<N:330896420,(1888697057,-505735736),R:409071801,S:-393483751>
Jan 16 08:18:26 planet kernel:      D 13:
DISK<N:-1540222231,(-671372187,979834932),R:-2028885087,S:-111956365>
Jan 16 08:18:26 planet kernel:      D 14:
DISK<N:-2003446222,(1181201804,483028273),R:-1155078818,S:1107831040>
Jan 16 08:18:26 planet kernel:      D 15:
DISK<N:-557073400,(2067195822,791861148),R:-1157357381,S:602122844>
Jan 16 08:18:26 planet kernel:      D 16:
DISK<N:-225482010,(-1725978464,-1520084405),R:1675525676,S:1556295757>
Jan 16 08:18:26 planet kernel:      D 17:
DISK<N:-908183734,(-1157632239,-1137972139),R:-1055596967,S:1269304326>
Jan 16 08:18:26 planet kernel:      D 18:
DISK<N:-603893280,(-569888368,1032504318),R:798618610,S:985240996>
Jan 16 08:18:26 planet kernel:      D 19:
DISK<N:490487460,(-206474683,1127296990),R:1084373025,S:-913096247>
Jan 16 08:18:26 planet kernel:      D 20:
DISK<N:-1542344191,(-155193184,-1948794740),R:2027961155,S:-750517592>
Jan 16 08:18:26 planet kernel:      D 21:
DISK<N:-309206828,(-1881161743,1426287870),R:-545517820,S:2035651849>
Jan 16 08:18:26 planet kernel:      D 22:
DISK<N:2114464545,(-1845664683,-1156768433),R:-1426597581,S:-311243219>
Jan 16 08:18:26 planet kernel:      D 23:
DISK<N:1199065145,(-514385948,1992573921),R:-560681972,S:-202215636>
Jan 16 08:18:26 planet kernel:      D 24:
DISK<N:35534958,(1096830985,-2141974010),R:1023385212,S:-2094570834>
Jan 16 08:18:26 planet kernel:      D 25:
DISK<N:1310971224,(1717308177,861401725),R:153135315,S:153387104>
Jan 16 08:18:26 planet kernel:      D 26:
DISK<N:-529200607,(-635468306,503453457),R:150656399,S:1633879690>
Jan 16 08:18:26 planet kernel: md:     THIS:
DISK<N:17697816,(478179968,1223536760),R:777010250,S:-1636575368>
Jan 16 08:18:26 planet kernel: md: rdev hdc2, SZ:156296256 F:0 S:1 DN:1
Jan 16 08:18:26 planet kernel: md: rdev superblock:
Jan 16 08:18:26 planet kernel: md:  SB: (V:1.0.0) ID:<
dfe2a519.00000000.00000000.00000000> CT:4810920a
Jan 16 08:18:26 planet kernel: md:     L370828101 S00000049 ND:0 RD:0 md0
LO:65536 CS:-65534
Jan 16 08:18:26 planet kernel: md:     UT:00000000 ST:0 AD:312592624 WD:0
FD:312592752 SD:0 CSUM:00000000 E:00000000
Jan 16 08:18:26 planet kernel:      D  0:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  1:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  2:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  3:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel: md:     THIS:  DISK<N:0,(0,0),R:0,S:0>
Jan 16 08:18:26 planet kernel: md: rdev hda2, SZ:156296256 F:0 S:1 DN:0
Jan 16 08:18:26 planet kernel: md: rdev superblock:
Jan 16 08:18:26 planet kernel: md:  SB: (V:1.0.0) ID:<
dfe2a519.00000000.00000000.00000000> CT:4810920a
Jan 16 08:18:26 planet kernel: md:     L370828101 S00000049 ND:0 RD:0 md0
LO:65536 CS:-65534
Jan 16 08:18:26 planet kernel: md:     UT:00000000 ST:0 AD:312592624 WD:0
FD:312592752 SD:0 CSUM:00000000 E:00000000
Jan 16 08:18:26 planet kernel:      D  0:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  1:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  2:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  3:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel: md:     THIS:  DISK<N:0,(0,0),R:0,S:0>
Jan 16 08:18:26 planet kernel: md0: <hda1><hdc1>
Jan 16 08:18:26 planet kernel: md: rdev hda1, SZ:87899544 F:0 S:1 DN:0
Jan 16 08:18:26 planet kernel: md: rdev superblock:
Jan 16 08:18:26 planet kernel: md:  SB: (V:1.0.0) ID:<
b3e50782.79735b20.00005d73.00000000> CT:84bcf12d
Jan 16 08:18:26 planet kernel: md:     L413983828 S1986622032 ND:544826209
RD:1847620457 md1629516911 LO:65536 CS:-1
Jan 16 08:18:26 planet kernel: md:     UT:00000000 ST:0 AD:175799088 WD:0
FD:175799216 SD:0 CSUM:00000000 E:00000000
Jan 16 08:18:26 planet kernel:      D  0:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  1:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  2:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  3:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel: md:     THIS:  DISK<N:0,(0,0),R:0,S:0>
Jan 16 08:18:26 planet kernel: md: rdev hdc1, SZ:87899544 F:0 S:1 DN:1
Jan 16 08:18:26 planet kernel: md: rdev superblock:
Jan 16 08:18:26 planet kernel: md:  SB: (V:1.0.0) ID:<
b3e50782.79735b20.00005d73.00000000> CT:84bcf12d
Jan 16 08:18:26 planet kernel: md:     L413983828 S1986622032 ND:544826209
RD:1847620457 md1629516911 LO:65536 CS:-1
Jan 16 08:18:26 planet kernel: md:     UT:00000000 ST:0 AD:175799088 WD:0
FD:175799216 SD:0 CSUM:00000000 E:00000000
Jan 16 08:18:26 planet kernel:      D  0:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  1:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  2:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel:      D  3:  DISK<N:-1,(-1,-1),R:-1,S:-1>
Jan 16 08:18:26 planet kernel: md:     THIS:  DISK<N:0,(0,0),R:0,S:0>
Jan 16 08:18:27 planet kernel: md:^I**********************************
Jan 16 08:18:27 planet kernel:
