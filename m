Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273288AbTHFCax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273273AbTHFCax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:30:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42203 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S273356AbTHFCat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:30:49 -0400
Message-ID: <3F306858.1040202@mrs.umn.edu>
Date: Tue, 05 Aug 2003 21:30:48 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: reiserfs-list@namesys.com
Subject: Filesystem Tests
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested the performace of various filesystems with a mozilla build tree 
of 295MB, with primarily writing and copying operations.  The test 
system is Linux 2.6.0-test2, 512MB memory, 11531.85MB partition for 
tests.  Sync is run a few times throughout the test (for full script see 
bottom of this email).  I ran mkfs on the partition before every test. 
Running the tests again tends to produces similar times, about +/- 3 
seconds.

The first item number is time, in seconds, to complete the test (lower 
is better).  The second number is CPU use percentage (lower is better).

reiser4 171.28s, 30%CPU (1.0000x time; 1.0x CPU)
reiserfs 302.53s, 16%CPU (1.7663x time; 0.53x CPU)
ext3 319.71s, 11%CPU	(1.8666x time; 0.36x CPU)
xfs 429.79s, 13%CPU (2.5093x time; 0.43x CPU)
jfs 470.88s, 6%CPU (2.7492x time 0.02x CPU)

What's interesting:
* ext3's syncs tended to take the longest 10 seconds, except
* JFS took a whopping 38.18s on its final sync
* xfs used more CPU than ext3 but was slower than ext3
* reiser4 had highest throughput and most CPU usage
* jfs had lowest throughput and least CPU usage
* total performance of course depends on how IO or CPU bound your task is

Individual test times (first number again is time in seconds, second is 
CPU usage, last is total again)
reiser4
Copying Tree
33.39,34%
Sync
1.54,0%
recopying tree to mozilla-2
31.09,34%
recopying mozilla-2 to mozilla-3
33.15,33%
sync
2.89,3%
du
2.05,42%
rm -rf mozilla
7.41,52%
tar c mozilla-2
52.25,25%
final sync
6.77,2%
171.28,30%

reiserfs
Copying Tree
39.55,32%
Sync
3.15,1%
recopying tree to mozilla-2
75.15,13%
recopying mozilla-2 to mozilla-3
77.62,13%
sync
3.84,1%
du
2.46,21%
rm -rf mozilla
5.22,58%
tar c mozilla-2
90.83,12%
final sync
4.19,3%
302.53,16%

extended 3
Copying Tree
39.42,25%
Sync
9.05,0%
recopying tree to mozilla-2
79.96,9%
recopying mozilla-2 to mozilla-3
98.84,7%
sync
8.15,0%
du
3.31,11%
rm -rf mozilla
3.71,39%
tar c mozilla-2
74.93,13%
final sync
1.67,1%
319.71,11%

xfs
Copying Tree
43.50,32%
Sync
2.08,1%
recopying tree to mozilla-2
102.37,12%
recopying mozilla-2 to mozilla-3
108.00,12%
sync
2.40,2%
du
3.73,32%
rm -rf mozilla
8.75,56%
tar c mozilla-2
157.61,7%
final sync
0.95,1%
429.79,13%

jfs
Copying Tree
48.15,20%
Sync
3.05,1%
recopying tree to mozilla-2
108.39,5%
recopying mozilla-2 to mozilla-3
114.96,5%
sync
3.86,0%
du
2.42,17%
rm -rf mozilla
15.33,7%
tar c mozilla-2
135.86,6%
final sync
38.18,0%
470.88,6%

Here is the benchmark script:
#!/bin/sh
time='time -f%e,%P '
echo "Copying Tree"
$time cp -a /home/test/mozilla /mnt/test
echo "Sync"
$time sync
cd /mnt/test &&
echo "recopying tree to mozilla-2"
$time cp -a mozilla mozilla-2 &&
echo "recopying mozilla-2 to mozilla-3"
$time cp -a mozilla mozilla-2 &&
echo "sync"
$time sync &&
echo "du"
$time du mozilla > /dev/null &&
echo "rm -rf mozilla"
$time rm -rf mozilla
echo "tar c mozilla-2"
$time tar c mozilla-2 > mozilla.tar
echo "final sync"
$time sync

