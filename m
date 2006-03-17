Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCQMcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCQMcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCQMcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:32:12 -0500
Received: from village.ehouse.ru ([193.111.92.18]:12039 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S932148AbWCQMcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:32:11 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: xfs cluster rewrites is broken?
Date: Fri, 17 Mar 2006 15:32:03 +0300
User-Agent: KMail/1.9.1
Cc: admin@list.net.ru
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171532.04385.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Two days ago i've try 2.6.16-rc5 on 2-way dual-core Opteron server
and faced with a strange system behaviour. 
Bulky database updates (host is intended to be a database mysql server),
at some point of time leads to the state when system begins continuously 
write to disk with a speed about of 100-250 Mb/s, really, near to limit 
of raid controller [lsi320-2x]).
On particular drive only innodb logfiles ( rollback segmets )
have some relationship to mysql. It seems strange because write speed
to innodb datafile itself within limits of 20 Mb/s )
( both on the xfs partitions in this case ). 

vmstat 1 shows something like this:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 2746688   4232 465784    0    0   132 156046 2853   762 12  4 73 
11
 1  0      0 2777440   4232 465784    0    0     0 242742 4050   432  6  4 74 
17
 1  1      0 2746696   4232 465784    0    0     0 134551 2201   556 13  5 74  
8
 1  1      0 2760712   4232 465920    0    0   128 296360 4892  1083  5  5 70 
19
 0  1      0 2746596   4232 465920    0    0     0 209254 3560  9072 10  5 70 
15
 0  1      0 2745736   4232 466192    0    0   256 142445 2477   721 12  4 75  
9
 1  0      0 2757396   4232 466328    0    0   128 190102 3375   829  8  4 74 
14
 0  1      0 2746360   4232 466328    0    0     0 192885 3122   256  9  4 75

and iostat:

nuclear ~ # iostat 1
Linux 2.6.16-rc6-g232a347a (nuclear.srv.ehouse.ru) 	03/17/06
[skip]
Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
sda            1196.76       222.90    152462.91     194620  133118417
sdb              42.69        11.82      5024.36      10322    4386869

avg-cpu:  %user   %nice    %sys %iowait   %idle
          12.72    0.00    3.99    8.73   74.56

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
sda            2079.00         0.00    265946.00          0     265946
sdb               0.00         0.00         0.00 

( it is sda contains ib_logfile[0-3], sdb -- ib_data itself )

while normaly it looks like:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 1772460  98660 1242776    0    0     0  2045  329   697 24  2 74  
0
 1  0      0 1801452  98660 1242776    0    0     0 20022  671  1164 23  2 74  
1
 2  0      0 1782372  98660 1242776    0    0   880  3845  383  1070 20  2 74  
4
 1  0      0 1771876  98660 1242776    0    0     0  7897  428   718 24  2 74  
0
 1  0      0 1781572  98660 1242776    0    0     0  8200  446  1314 24  2 74  
0
 1  0      0 1770020  98660 1242776    0    0     0 11402  478   742 23  2 74  
0

I don't seen smothing similar with previous 2.6.15. so assume this 
is a kernel issue.
clone of last git tree seems affected too, so i've try to 'bisect' a little.
One day crowling with git bisect reveal commit related to this.

$git bisect bad
6c4fe19f66a839bce68fcb7b99cdcb0f31c7a59e is first bad commit
diff-tree 6c4fe19f66a839bce68fcb7b99cdcb0f31c7a59e (from 
7336cea8c2737bbaf0296d67782f760828301d56)
Author: Christoph Hellwig <hch@sgi.com>
Date:   Wed Jan 11 20:49:28 2006 +1100

    [XFS] cluster rewrites      We can cluster mapped pages aswell, this 
improves
    performances on rewrites since we can reduce the number of allocator
    calls.

    SGI-PV: 947118
    SGI-Modid: xfs-linux-melb:xfs-kern:203829a

    Signed-off-by: Christoph Hellwig <hch@sgi.com>
    Signed-off-by: Nathan Scott <nathans@sgi.com>

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6c4fe19f66a839bce68fcb7b99cdcb0f31c7a59e;hp=7336cea8c2737bbaf0296d67782f760828301d56

Reverting of this on 2.6.16-rc5 eliminate symptoms completely.

half-intuitive:

diff -urN a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
--- a/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 13:13:53.000000000 +0300
+++ b/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 15:12:12.000000000 +0300
@@ -616,8 +616,6 @@
 				acceptable = (type == IOMAP_UNWRITTEN);
 			else if (buffer_delay(bh))
 				acceptable = (type == IOMAP_DELAY);
-			else if (buffer_mapped(bh))
-				acceptable = (type == 0);
 			else
 				break;
 		} while ((bh = bh->b_this_page) != head);

works too, as i can see, but this is just illustration.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
