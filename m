Return-Path: <linux-kernel-owner+w=401wt.eu-S932821AbXAKXiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXAKXiU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbXAKXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:38:20 -0500
Received: from lucidpixels.com ([66.45.37.187]:49590 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822AbXAKXiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:38:19 -0500
Date: Thu, 11 Jan 2007 18:38:17 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Linux Software RAID 5 Performance Optimizations: 2.6.19.1: (211MB/s
 read & 195MB/s write)
Message-ID: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 4 raptor 150s:

Without the tweaks, I get 111MB/s write and 87MB/s read.
With the tweaks, 195MB/s write and 211MB/s read.

Using kernel 2.6.19.1.

Without the tweaks and with the tweaks:

# Stripe tests:
echo 8192 > /sys/block/md3/md/stripe_cache_size

# DD TESTS [WRITE]

DEFAULT: (512K)
$ dd if=/dev/zero of=10gb.no.optimizations.out bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 96.6988 seconds, 111 MB/s

8192 STRIPE CACHE
$ dd if=/dev/zero of=10gb.8192k.stripe.out bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 55.0628 seconds, 195 MB/s
(and again...)
10737418240 bytes (11 GB) copied, 61.9902 seconds, 173 MB/s
(and again...)
10737418240 bytes (11 GB) copied, 61.3053 seconds, 175 MB/s
** maybe 16384 is better, need to do more testing.

16384 STRIPE CACHE
$ dd if=/dev/zero of=10gb.16384k.stripe.out bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 56.2793 seconds, 191 MB/s

32768 STRIPE CACHE
$ dd if=/dev/zero of=10gb.32768.stripe.out bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 55.8382 seconds, 192 MB/s

# Set readahead.
blockdev --setra 16384 /dev/md3

# DD TESTS [READ]

DEFAULT: (1536K READ AHEAD)
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
298+0 records in
297+0 records out
311427072 bytes (311 MB) copied, 3.5453 seconds, 87.8 MB/s

2048K READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 85.4632 seconds, 126 MB/s

8192K READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 64.9454 seconds, 165 MB/s

16384K READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 59.3119 seconds, 181 MB/s

32768 READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 56.6329 seconds, 190 MB/s

65536 READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 54.9768 seconds, 195 MB/s

131072 READ AHEAD
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 52.0896 seconds, 206 MB/s

262144 READ AHEAD**
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 50.8496 seconds, 211 MB/s
(and again..)
10737418240 bytes (11 GB) copied, 51.2064 seconds, 210 MB/s***

524288 READ AHEAD
$ dd if=10gb.16384k.stripe.out of=/dev/null bs=1M
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 59.6508 seconds, 180 MB/s

Output (vmstat) during a write test:
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 2  1    172 730536     12 952740    0    0     0 357720 1836 107450  0 80  6 15
 1  1    172 485016     12 1194448    0    0     0 171760 1604 42853  0 38 16 46
 1  0    172 243960     12 1432140    0    0     0 223088 1598 63118  0 44 25 31
 0  0    172  77428     12 1596240    0    0     0 199736 1559 56939  0 36 28 36
 2  0    172  50328     12 1622796    0    0    16 87496 1726 31251  0 27 73  0
 2  1    172  50600     12 1622052    0    0     0 313432 1739 88026  0 53 16 32
 1  1    172  51012     12 1621216    0    0     0 200656 1586 56349  0 38  9 53
 0  3    172  50084     12 1622408    0    0     0 204320 1588 67085  0 40 24 36
 1  1    172  51716     12 1620760    0    0     0 245672 1608 81564  0 61 13 26
 0  2    172  51168     12 1621432    0    0     0 212740 1622 67203  0 44 22 34
 0  2    172  51940     12 1620516    0    0     0 203704 1614 59396  0 42 24 35
 0  0    172  51188     12 1621348    0    0     0 171744 1582 56664  0 38 28 34
 1  0    172  52264     12 1620812    0    0     0 143792 1724 43543  0 39 59  2
 0  1    172  48292     12 1623984    0    0    16 248784 1610 73980  0 40 19 41
 0  2    172  51868     12 1620596    0    0     0 209184 1571 60611  0 40 20 40
 1  1    172  51168     12 1621340    0    0     0 205020 1620 70048  0 38 27 34
 2  0    172  51076     12 1621508    0    0     0 236400 1658 81582  0 59 13 29
 0  0    172  51284     12 1621064    0    0     0 138739 1611 40220  0 30 34 36
 1  0    172  52020     12 1620376    0    0     4 170200 1752 52315  0 38 58  5

Output (vmstat) during a read test:
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 1  0    172  53484     12 1769396    0    0     0     0 1005   54  0  0 100  0
 0  0    172  53148     12 1740380    0    0 221752     0 1562 11779  0 22 70  9
 0  0    172  53868     12 1709048    0    0 231764    16 1708 14658  0 37 54  9
 2  0    172  53384     12 1768236    0    0 189604     8 1646 8507  0 28 59 13
 2  0    172  53920     12 1758856    0    0 253708     0 1716 17665  0 37 63  0
 0  0    172  50704     12 1739872    0    0 239700     0 1654 10949  0 41 54  5
 1  0    172  50796     12 1684120    0    0 206236     0 1722 16610  0 43 57  0
 2  0    172  53012     12 1768192    0    0 217876    12 1709 17022  0 34 66  0
 0  0    172  50676     12 1761664    0    0 252840     8 1711 15985  0 38 62  0
 0  0    172  53676     12 1736192    0    0 240072     0 1686 7530  0 42 54  4
 0  0    172  52892     12 1686740    0    0 211924     0 1707 16284  0 38 62  0
 2  0    172  53536     12 1767580    0    0 212668     0 1680 18409  0 34 62  5
 0  0    172  50488     12 1760780    0    0 251972     9 1719 15818  0 41 59  0
 0  0    172  53912     12 1736916    0    0 241932     8 1645 12602  0 37 54  9
 1  0    172  53296     12 1656072    0    0 180800     0 1723 15826  0 41 59  0
 1  1    172  51208     12 1770156    0    0 242800     0 1738 11146  1 30 64  6
 2  0    172  53604     12 1756452    0    0 251104     0 1652 10315  0 39 59  2
 0  0    172  53268     12 1739120    0    0 244536     0 1679 18972  0 44 56  0
 1  0    172  53256     12 1664920    0    0 187620     0 1668 19003  0 39 53  8
 1  0    172  53716     12 1767424    0    0 234244     0 1711 17040  0 32 64  5
 2  0    172  53680     12 1760680    0    0 255196     0 1695 9895  0 38 61  1

