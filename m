Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUEKReZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUEKReZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbUEKReZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:34:25 -0400
Received: from chaos.ao.net ([208.5.40.6]:22242 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id S264897AbUEKRdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:33:38 -0400
Date: Tue, 11 May 2004 13:33:34 -0400
From: Dan Merillat <dmerillat@sequiam.com>
To: linux-kernel@vger.kernel.org
Subject: VM issues in 2.6.6
Message-ID: <20040511173333.GS5945@chaos.ao.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing performance testing on a new dual-opteron box (Running a 64 bit
kernel) and found something that's very strange to me: mounting a filesystem
synchronously moves the data to the disk 33% faster then mounting it async.  

I tested using both reiser and ext2, with the same results, so it looks
like a vm/pagecache issue rather then a filesystem issue.

I create a 1gig file with dd on a filesystem mounted synchronously, and I 
achieve 45megabytes/second

harik@hailstorm:/test2$ dd if=/dev/zero of=testfile bs=1024k count=1024
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 23.857952 seconds (45005616 bytes/sec)

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0    324 1205740 355272 314252    0    0     0 49152 2029 19238  0 15 47 39
 0  1    324 1161836 355316 356368    0    0     0 43008 1874  1610  0 10 50 40
 0  1    324 1120436 355352 396316    0    0     0 39916 1946  1796  0 10 50 41
 1  0    324 1083060 355660 434224    0    0     0 37688 1798  4242  0 12 46 42
 0  1    324 1033140 355708 482388    0    0     0 48952 1995  1895  0 13 50 37
 0  1    324 985396 355752 528448    0    0     0 46080 2022  4547  0 12 49 38
 1  0    324 934388 355800 577632    0    0     0 48520 1990 16480  0 16 46 39
 0  1    324 887476 355844 622672    0    0     0 45688 1953  1793  0 11 50 40
 0  1    324 849076 356152 661532    0    0     0 39516 1827  3877  0 12 47 42
 1  1    324 798132 356200 710716    0    0     0 49152 2003 19758  0 16 46 38
 1  0    324 747124 356248 759900    0    0     0 48448 2011 22061  0 16 46 39
 1  0    324 700212 356300 804932    0    0     0 44736 1932  3833  0 12 49 40

If I do the same on the filesystem mounted async:

harik@hailstorm:/test2$ dd if=/dev/zero of=testfile bs=1024k count=1024 ; time sync
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 24.524777 seconds (43781920 bytes/sec)

real    0m14.635s
user    0m0.000s
sys     0m0.276s

for a total time of 39 seconds, at 27megabytes/second.

Sample vmstat:
 1  4    312 351052 356444 1151804    0    0     0 23636 1506   106  0  4 48 48
 0  4    312 350860 356444 1151804    0    0     0 26492 1571   110  0  4 49 47
 1  3    312 350732 356444 1151804    0    0     0 31288 1663   168  0  5 35 60
 0  4    312 350604 356444 1151804    0    0     0 28448 1629   168  0  5  0 95
 0  4    312 350476 356444 1151804    0    0     0 32824 1706   158  0  4  0 95
 0  4    312 347140 356444 1151804    0    0     0 29132 1605   246  0 15  0 85
 0  4    312 347012 356444 1151804    0    0     0 24996 1523   113  0  4  0 95
 0  4    312 346756 356444 1151804    0    0     0 31296 1666    97  0  5  0 96
 0  4    312 346692 356444 1151804    0    0     0 33104 1690    94  0  5  0 95
 0  4    312 346500 356444 1151804    0    0     0 28360 1569    91  0  4  0 96
 0  4    312 346436 356444 1151804    0    0     0 26528 1572    88  0  4  0 97
 0  1    312 344708 356444 1151804    0    0     0 24684 1477   309  0 10 32 57
 0  1    312 344580 356444 1151804    0    0     0 23040 1385   339  0  3 49 49
 0  1    312 344388 356444 1151804    0    0     0 20352 1337   286  0  3 49 48
 0  1    312 344388 356444 1151804    0    0     0 21120 1355   307  0  2 49 49
 0  1    312 344580 356444 1151804    0    0     0 21696 1358   306  0  3 49 48
 0  1    312 344588 356444 1151804    0    0     0 22592 1378   327  0  3 48 49



Could it be that we're seeking like mad in test #2 as 3 PDflushes and
the dd all try to write out different parts of the file?  If so,  a
possible fix would be to track pathological writers like this and force
them to clean their own dirty pages (pdflush then ignores their pages)
leaving only one writer on the file, which should stream much nicer to
the disk.  

The nasty side-effect of what I'm seeing is that the entire system
grinds to a halt waiting on disk, as every program run bumps the atime,
dirtying the page, which has to be flushed synchronously before it can
continue.  

Or I could be completely wrong.  I just know how ungodly slow my system
gets when running that test async.

--Dan
