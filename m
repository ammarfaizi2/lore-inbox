Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUHUR0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUHUR0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUHUR0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:26:50 -0400
Received: from [213.188.213.77] ([213.188.213.77]:18356 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S266793AbUHURZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:25:58 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: <linux-kernel@vger.kernel.org>
Subject: Production comparison between 2.4.27 and 2.6.8.1
Date: Sat, 21 Aug 2004 19:25:52 +0200
Message-ID: <004f01c487a3$e8f8e060$0600640a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody.

#***********************************************************

Environment:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 3000+
stepping        : 0
cpu MHz         : 2091.477

#***********************************************************
             total       used       free     shared    buffers
cached
Mem:       1030844     258500     772344          0      36924
167092
-/+ buffers/cache:      54484     976360
Swap:      2056304          0    2056304

#***********************************************************
# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:04.0 Ethernet controller: Marvell Technology Group Ltd. Yukon
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev
02)
0000:03:00.0 VGA compatible controller: nVidia Corporation NV11
[GeForce2 MX/MX 400] (rev b2)

#***********************************************************

Distro is Debian Woody with all necessary packages backported in order
to have 2.6 working.

I used postgres 7.4.3 to make some tests on a server which will go in
producton in a short time.

The test was really simple:

dropdb mydb
createdb mydb
time psql -U blus mydb <schema.sql
time psql -U blus mydb <data.sql

#***********************************************************

I tried both 2.6.8.1 vanilla and 2.4.7 with -lck patches applied and run
the same test changing kernels.

Tests were run:
- on a raid1 partition on 2 serial Ata disks	(ext3) [software raid)
- on a non raid partition on /dev/sda0 (xfs)

(only postgres data has been switched from raid-ext3 to xfs)


My purpose was merely have a difference of time between the 2 kernels in
performing that task.

Case 1a is 2.4.27-lck1 with raid1 ext3
Case 1b is 2.4.27-lck1 without raid on xfs
Case 2a is 2.6.8.1 with raid1 ext3
Case 2b is 2.6.8.1 without raid on xfs
Results were:

A) for creating the schema (which involves creating tables and indexes)
1a:
  real    0m1.312s
  user    0m0.030s
  sys     0m0.008s
1b:
  real    0m0.508s
  user    0m0.024s
  sys     0m0.012s
2a:
  real    0m0.941s
  user    0m0.025s
  sys     0m0.010s
2b:
  real    0m0.560s
  user    0m0.024s
  sys     0m0.005s

B) to import the data (which implies both writing data to disk and
recalculating indexes)
1a:
  real    4m12.757s
  user    0m3.376s
  sys     0m1.700s
1b:
  real    1m0.467s
  user    0m3.290s
  sys     0m1.646s
2a:
  real    2m42.861s
  user    0m3.590s
  sys     0m1.523s
2b:
  real    1m30.746s
  user    0m3.255s
  sys     0m1.501s

#**********************************************
HDPARM shows:
# hdparm -v
hdparm - get/set hard disk parameters - version v5.5

2.4.7:
/dev/sda:
 Timing buffer-cache reads:   2188 MB in  2.00 seconds = 1094.00 MB/sec
 Timing buffered disk reads:  164 MB in  3.02 seconds =  54.34 MB/sec

2.6.8.1:
/dev/sda:
 Timing buffer-cache reads:   2176 MB in  2.00 seconds = 1087.08 MB/sec
 Timing buffered disk reads:  136 MB in  3.04 seconds =  44.77 MB/sec

#**********************************************
It is my first experience with 2.6 branch kernels, because i am trying
to figure out if the tree is performing well to switch everithing in
production, so my ideas may be wrong...

Raid tests may be faked because of the overhead caused by md sync (and
probably raid is better on 2.6). 
However it seems that libsata has better performance on 2.4 (hdparm)
xfs tests shows that 2.4 has better performance if compared to 2.6 and
the difference, in my opinion, is not linked on libsata better
performance.

What is your opinion ?
What can I try to improve performance ?


Regards,

Ing. Massimo Cetra
------------------------------------
Navynet S.r.l
Surfing the network
Via di peretola, 93 - 50145 Firenze 
Tel. 055317634 

