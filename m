Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUBMJO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266852AbUBMJO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:14:29 -0500
Received: from batzmaru.gol.ad.jp ([203.216.0.80]:21178 "EHLO
	batzmaru.gol.ad.jp") by vger.kernel.org with ESMTP id S266851AbUBMJOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:14:02 -0500
X-Mailer: exmh version 2.5 07/13/2001 (debian 2.5-1) with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org
Subject: 2.6.x stability and oddity tale (Promise ATA/SATA, reiserfs/ext3, spontaneous reboots)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Feb 2004 18:13:59 +0900
From: Christian Balzer <chibi@gol.com>
Message-Id: <E1ArZOZ-0000O6-00@batzmaru.gol.ad.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

this will be long, but also hopefully provide a number of interesting
pointers and a heads up for the kernel crowd. 

It all starts with this report: 
http://bugzilla.kernel.org/show_bug.cgi?id=1933

Take a peek, at the very least for the HW/OS description.
Since no solution for the above problem was forthcoming I decided
to swap in 2 SATA drives instead of the Promise card connected ATA
ones, using the so far unused onboard Promise SATA controller. 
While performance (one guesses due to the added SCSI and libata layers)
of that RAID0 was not as high as with the ATA setup (same drives, just 
different interface) it turned out to be adequate. Things were working
beautifully for 15 days, longer than ever with the original config.

Yesterday, during the last stages of the ever i/o intense expire run
the machine spontaneously rebooted. Sorry, no traces of anything in the
logs and the machine is in a remote location, no staring at consoles either. 
 
Incidently a nearly identical machine (same OS/kernel, 4 GB memory, 4 drives, 
2 off the onboard Promise SATA) also decided to reboot itself during a busy 
time on the RAID1 formed by the 2 SATA drivers, after performing the same 
feats for 2 weeks w/o problems. While the machine was rebuilding the (MD)
RAID1, copying around several 2GB files on said RAID was enough to make
it crash and reboot again, both with 2.6.1 and 2.6.2. Again, no logs
or other hints at this point, but if push comes to shove at least I know
how to reproduce this one it seems.

Another similarity between these two cases is that the affected file system
is a reiserfs volume.

I decided to see if I could recreate these crashes with slightly different
hardware, namely IBM e325 dual opteron servers. Same 240 CPUs, same 2GB
of memory, same OS and kernel (2.6.1). But for disk io I used these:
---
02:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
03:03.0 Fibre Channel: QLogic Corp. QLA2300 64-bit FC-AL Adapter (rev 01)
---
2 36GB SCSI drives forming a MD RAID1 locally and a SAN on the FC-AL card.

Neither local nor SAN stress tests did result in crashes, so my main
suspect for the above troubles is somewhere in the IDE/SATA/DMA complex.
I had run postmark (single instance though) for some days on that SAN
2 weeks ago already.

However when doing those tests I came across a very odd difference
in behavior between ext3 and reiserfs. The tests below were done on
the SAN, 2 bonnie++ started (2nd 10 seconds after the first). On reiser
there was a pretty linear degradation but with ext3 something got very,
very starved, during those periods I/O to the SAN was down to 1.5MB/s 
and both CPUs at "100% wa" (top and vmstat confirmed).

Results (both of them for each run):
--- reiserfs

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mb02             4G 15293  74 22200  12  5624   2  4793  22 38244   9 100.6   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 22330 100 +++++ +++ 17886 100 20147  93 +++++ +++ 15523  92

[2nd one finished about 10 seconds after the 1st one, as expected]

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mb02             4G 14217  70 17651   9  4506   2  6142  28 39263   9 429.8   3
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 22863 100 +++++ +++ 16649  95 22453 100 +++++ +++ 16728  99

---

--- ext3

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mb02             4G 10228  54  4699   2  1251   0  2841  13 31697   6 189.0   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  1389  99 +++++ +++ +++++ +++  1449  99 +++++ +++  6306  99

[2nd one finished a lot later than the first one, thus the vastly higher
 read speeds.]

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mb02             4G  4045  21  2237   1  1525   0  5664  26 49946  12 414.9   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  1571  99 +++++ +++ +++++ +++  1613  99 +++++ +++  6330  99
---

Sample vmstat during the "ext3 starvation" period:
---
#vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0 11      0   7088  36748 1955788    0    0    10    21   14    10  0  0 99  0
 0 11      0   7072  36756 1955712    0    0     0  1564 1387   190  0  3  0 98
 0 11      0   7072  36756 1955712    0    0     0  1556 1361   152  0  1  0 99
 0 11      0   7072  36756 1955780    0    0     8  1568 1376   240  0  0  0 100
 0 11      0   7072  36756 1955780    0    0     0  1552 1358   158  0  1  0 99
 0 11      0   7072  36764 1955772    0    0     0  1700 1358   169  0  0  0 100
 0 11      0   7072  36772 1955764    0    0     0  1788 1419   559  0  0  0 100
 0 11      0   7200  36796 1955604    0    0     4  1936 1338   206  0  3  0 97
 0 11      0   7136  36812 1955588    0    0     0  1564 1271   331  0  1  0 99
 0 11      0   7136  36816 1955652    0    0     0  1572 1392   257 10  2  0 88
 0 11      0   7136  36816 1955652    0    0     0  1808 1355   154  0  0  0 100
 0 11      0   7136  36816 1955652    0    0     0  1436 1363   154  0  1  0 100
 0 11      0   7136  36816 1955652    0    0     0  1552 1346   154  0  0  0 100
 0 11      0   7072  36820 1955716    0    0     0  5604 1332   184  0  2  0 98
 0 11      0   7072  36820 1955716    0    0     0   132 1040   138  0  0  0 100
 0 11      0   7072  36820 1955716    0    0     0  1284 1317   150  0  1  0 99
 0 11      0   7072  36824 1955712    0    0     0  1576 1366   176  0  1  0 99
 0 11      0   7072  36824 1955712    0    0     0  1680 1356   158  0  1  0 100
---

Any non-obvious suggestions and feedback are welcome, please Cc:, though I
also monitor this list. The IBM machines and SAN are not production yet,
so I can break/reconfigure things. The real problem childs up there are
unfortunately production machines, thus rebooting or deliberately crashing
them is not very desirable. ;)

Regards,

Christian Balzer
-- 
Christian Balzer        Network/Systems Engineer                NOC
chibi@gol.com   	Global OnLine Japan/Fusion Network Services
http://www.gol.com/

