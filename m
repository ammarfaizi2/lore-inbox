Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbUJ1WrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbUJ1WrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUJ1Woq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:44:46 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:20358 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S263032AbUJ1Wnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:43:37 -0400
Message-ID: <41817612.2020104@ribosome.natur.cuni.cz>
Date: Fri, 29 Oct 2004 00:43:30 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041028
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Filesystem performance on 2.4.28-pre3 on hardware RAID5.
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have finished evaluation of my tests of filesystems. For your
interest I put the results at http://www.natur.cuni.cz/~mmokrejs/linux-performance.
I have some questions on the developers:

1.
ext3 has lost nice performance compared to ext2 in terms of "Random create /Delete"
test, whatever it does (see bonnie++ 1.93c docs), also in terms of "Sequential output /Char"
test and in peak perfomance of "Sequential output /Block" test, in perfomance
of "Sequential create /Create" test, "Random seek" perfomance.

2.
"mount -t xfs -o async" unexpectedly kills random seek performance,
but is still a bit better than with "-o sync". ;) Maybe it has to do
with the dramatic jump in CPU consumption of this operation,
as it in both cases it takes about 21-26% instead of usual 3%.
Why? Isn't actually async default mode?

3.
"mke2fs -O dir_index" decreased Sequential output /Block perf
by 25%. It seems the only positive effect of this option
is in Random create /Delete test and "Random seek" test.

4.
At least on this RAID5, "mke2fs -T largefile or -T largefile4"
should be prohibited, as they kill Sequential create /Create perf.

5. Based on you experience, would you prefer better random IO
or sequential IO? The server should house many huge files around 800MB or more,
in general there should be more reads then writes on the partition.
As the RAID5 splits data into blocks on the RAID, sequential reads or writes
anyway get split (cannot if if also randomly sheared over every disk plate). 

Any feedback? Please Cc: me. Thanks.
Martin


For the archive, some minimal results from the test.
There's a lot more, including raw data on that page and even more comments
and some comparisons, briefly (more comments on the web):

----------------------------------------------------
Sequential output /Char
ReiserFS3       255 K/sec
XFS             425 K/sec
ext3            122 K/sec
ext2            540 K/sec (560?)
----------------------------------------------------
Sequential output /Block
ReiserFS3       53400 K/sec
XFS             56500 K/sec
ext3            48000-51500 K/sec
ext2            36000-53000 K/sec
----------------------------------------------------
Sequential create /Create
ReiserFS3       18-23 ms
ReiserFs3       55 us (when "mkreiserfs -t 128 or 256 or 512 or 768" used)
XFS             60-120 ms
ext3            2-3 ms 
ext2            25-30 us (with exception of "mke2fs -T largefile or largefile4")
----------------------------------------------------
Random seeks take very different amount of CPU and have
different amount of seeks per second: 
ReiserFS3       520 seeks/sec and consumes 60% (with 2 weird exceptions below)
ReiserFS3       1290 seeks/sec and consumes 3%
                (mkreiserfs -s 1024 or 2048 or 16384)
                (mkreiserfs -t 768)
XFS             804 seeks/sec and consumes 3%
XFS             540-660 seeks/sec and consumes 21-26%
                (worse values for mount -o sync,
                better values for -o async, but still
                worse than if the switch is omitted).
ext3            770 seeks/sec and consumes 30%
ext2            790-800 seeks/sec and consumes 30%
ext2            815  seeks/sec and consumes 30%
                (mke2fs -O dir_index)
----------------------------------------------------
Random create /Create
ReiserFS3       50-55 us
XFS             3000 us
ext3            1400-7000 us
ext2            24-30 us
----------------------------------------------------
Random create /Read
ReiserFS3       mostly 8-10 us (-o notail doubles the time,
                also by 30% increases Sequential create /Create time
                and by 60% decreases number of Random seeks per sec.
XFS             9-13 or 19 us
ext3            5 us
ext2            10 us
----------------------------------------------------
Random create /Delete:
ReiserFS3       80-90 us
XFS             3000-3500us
ext3            43-66us
ext2            23-38us


How I tested?
I used "bonnie++ -n 1 -s 12G -d /scratch -u apache -q"
on an external RAID5 1TB logical drive. Data should be split
by raid controller into 128 kB chunks. The server has 6 GB RAM,
SMP and HIGHMEM enabled 2.4.28-pre3 kernel, 12 GB swap
on same RAID5 and 1 GB ECC RAM on raid controller. However,
only 500MB are used (it's dual-controller, so every controller
uses just half, the other half is used to mirror the other controller).
