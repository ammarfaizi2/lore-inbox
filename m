Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTIUAE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 20:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbTIUAE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 20:04:29 -0400
Received: from elk.zenon.net ([213.189.198.216]:9435 "EHLO frontend3.aha.ru")
	by vger.kernel.org with ESMTP id S261546AbTIUAEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 20:04:25 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: bug() in software raid in 2.4.22
Date: Sun, 21 Sep 2003 01:15:14 +0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309210115.14432@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

[I'm not sure that it is a bug, and anyway the problem is solved already. 
But maybe someone in linux-kernel mailing list will be interested]

On my server, I am running software raid1 for several months.
It was created from two 80 Gb Segate hard drives, each with a single 
partition, /dev/hdf1 and /dev/hdg1. Disks were connected to onboard 
Promise RAID controller, that was used just as two more IDE interfaces.
It worked, no problems, no errors.

After a major hardware upgrade, first disk was moved from /dev/hdf (slave 
on third IDE interface) to /dev/hde (master on third IDE interface).

I fixed /etc/raiddtab:

raiddev                 /dev/md0
raid-level              1
nr-raid-disks           2
nr-spare-disks          0
chunk-size              4

device                  /dev/hde1
raid-disk               0

device                  /dev/hdg1
raid-disk               1

(before it contained /dev/hdf1 instead of /dev/hde1).

And attempted to start raid (/etc/init.d/raid2 start - it is a Debian Sid 
system).

It was not started. And in system logs, I got the following:

Sep 13 16:42:39 zigzag kernel:  [events: 00000022]
Sep 13 16:42:39 zigzag kernel: md: could not lock hdf1, zero-size? Marking 
faulty.
Sep 13 16:42:39 zigzag kernel: md: could not import hdf1, trying to run 
array nevertheless.
Sep 13 16:42:39 zigzag kernel:  [events: 00000023]
Sep 13 16:42:39 zigzag kernel: md: autorun ...
Sep 13 16:42:39 zigzag kernel: md: considering hdg1 ...
Sep 13 16:42:39 zigzag kernel: md:  adding hdg1 ...
Sep 13 16:42:39 zigzag kernel: md:  adding hde1 ...
Sep 13 16:42:39 zigzag kernel: md: created md0
Sep 13 16:42:39 zigzag kernel: md: bind<hde1,1>
Sep 13 16:42:39 zigzag kernel: md: bind<hdg1,2>
Sep 13 16:42:39 zigzag kernel: md: running: <hdg1><hde1>
Sep 13 16:42:39 zigzag kernel: md: hdg1's event counter: 00000023
Sep 13 16:42:39 zigzag kernel: md: hde1's event counter: 00000022
Sep 13 16:42:39 zigzag kernel: md: superblock update time inconsistency -- 
using the most recent one
Sep 13 16:42:39 zigzag kernel: md: freshest: hdg1
Sep 13 16:42:39 zigzag kernel: md: device name has changed from hdf1 to 
hde1 since last import!
Sep 13 16:42:39 zigzag kernel: md: bug in file md.c, line 1322
Sep 13 16:42:39 zigzag kernel:
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel: md0: <hdg1><hde1> array superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:1 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f6347ef ST:0 AD:1 WD:1 FD:0 
SD:0 CSUM:6d6ef950 E:00000023
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,[dev 
00:00](0,0),R:0,S:9>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md: rdev hdg1: O:hdg1, SZ:00000000 F:0 DN:1 
<6>md: rdev superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:1 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f6347ef ST:0 AD:1 WD:1 FD:0 
SD:0 CSUM:6d6ef950 E:00000023
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,[dev 
00:00](0,0),R:0,S:9>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md: rdev hde1: O:hdf1, SZ:00000000 F:0 DN:0 
<6>md: rdev superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:2 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f62c8d7 ST:1 AD:2 WD:2 FD:0 
SD:0 CSUM:6d6e7b3b E:00000022
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,hdf1(33,65),R:0,S:6>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  
DISK<N:0,hdf1(33,65),R:0,S:6>
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel:
Sep 13 16:42:39 zigzag kernel: md: bug in file md.c, line 1650
Sep 13 16:42:39 zigzag kernel:
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel: md0: <hdg1><hde1> array superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:1 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f6347ef ST:0 AD:1 WD:1 FD:0 
SD:0 CSUM:6d6ef950 E:00000023
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,[dev 
00:00](0,0),R:0,S:9>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md: rdev hdg1: O:hdg1, SZ:00000000 F:0 DN:1 
<6>md: rdev superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:1 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f6347ef ST:0 AD:1 WD:1 FD:0 
SD:0 CSUM:6d6ef950 E:00000023
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,[dev 
00:00](0,0),R:0,S:9>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md: rdev hde1: O:hdf1, SZ:00000000 F:0 DN:0 
<6>md: rdev superblock:
Sep 13 16:42:39 zigzag kernel: md:  SB: (V:0.90.0) 
ID:<839a3cb0.8fd990bd.368c136f.fdcad272> CT:386d2272
Sep 13 16:42:39 zigzag kernel: md:     L1 S78150592 ND:2 RD:2 md0 LO:0 
CS:4096
Sep 13 16:42:39 zigzag kernel: md:     UT:3f62c8d7 ST:1 AD:2 WD:2 FD:0 
SD:0 CSUM:6d6e7b3b E:00000022
Sep 13 16:42:39 zigzag kernel:      D  0:  DISK<N:0,hdf1(33,65),R:0,S:6>
Sep 13 16:42:39 zigzag kernel:      D  1:  DISK<N:1,hdg1(34,1),R:1,S:6>
Sep 13 16:42:39 zigzag kernel: md:     THIS:  
DISK<N:0,hdf1(33,65),R:0,S:6>
Sep 13 16:42:39 zigzag kernel: md:^I**********************************
Sep 13 16:42:39 zigzag kernel:
Sep 13 16:42:39 zigzag kernel: md :do_md_run() returned -22
Sep 13 16:42:39 zigzag kernel: md: md0 stopped.
Sep 13 16:42:39 zigzag kernel: md: unbind<hdg1,1>
Sep 13 16:42:39 zigzag kernel: md: export_rdev(hdg1)
Sep 13 16:42:39 zigzag kernel: md: unbind<hde1,0>
Sep 13 16:42:39 zigzag kernel: md: export_rdev(hde1)
Sep 13 16:42:39 zigzag kernel: md: ... autorun DONE.

I was able to get my raid back (without any data loss) by re-running 
mkraid, and since then it works for a week without problems.
But since the log contains lines "bug in md.c", I decided to post this 
message to linux-kernel.

That happened with Linux 2.4.22 SMP on dual-athlon server. I will provide 
more system information if it is needed.

