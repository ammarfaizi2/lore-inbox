Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBJKiU>; Mon, 10 Feb 2003 05:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTBJKiU>; Mon, 10 Feb 2003 05:38:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:33500 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264919AbTBJKiS>;
	Mon, 10 Feb 2003 05:38:18 -0500
Date: Mon, 10 Feb 2003 02:48:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hans Reiser <reiser@namesys.com>
Cc: andrea@suse.de, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210024810.43a57910.akpm@digeo.com>
In-Reply-To: <3E4779DD.7080402@namesys.com>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
	<20030209203343.06608eb3.akpm@digeo.com>
	<20030210045107.GD1109@unthought.net>
	<3E473172.3060407@cyberone.com.au>
	<20030210073614.GJ31401@dualathlon.random>
	<3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
	<20030210001921.3a0a5247.akpm@digeo.com>
	<20030210085649.GO31401@dualathlon.random>
	<20030210010937.57607249.akpm@digeo.com>
	<3E4779DD.7080402@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 10:47:56.0783 (UTC) FILETIME=[DF0F8FF0:01C2D0F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> readahead seems to be less effective for non-sequential objects.  Or at 
> least, you don't get the order of magnitude benefit from doing only one 
> seek, you only get the better elevator scheduling from having more 
> things in the elevator, which isn't such a big gain.
> 
> For the spectators of the thread, one of the things most of us learn 
> from experience about readahead is that there has to be something else 
> trying to interject seeks into your workload for readahead to make a big 
> difference, otherwise a modern disk drive (meaning, not 30 or so years 
> old) is going to optimize it for you anyway using its track cache.
> 

The biggest place where readahead helps is when there are several files being
read at the same time.  Without readahead the disk will seek from one file
to the next after having performed a 4k I/O.  With readahead, after performing
a (say) 128k I/O.  It really can make a 32x difference.

Readahead is brute force.  The anticipatory scheduler solves this in a
smarter way.

Yes, device readahead helps.  But I believe the caches are only 4-way
segmented or thereabouts, so it is easy to thrash them.  Let's test:

vmm:/mnt/hda6> dd if=/dev/zero of=file1 bs=1M count=100
100+0 records in
100+0 records out
vmm:/mnt/hda6> dd if=/dev/zero of=file2 bs=1M count=100
100+0 records in
100+0 records out
vmm:/mnt/hda6> fadvise file1 0 9999999999 dontneed
vmm:/mnt/hda6> fadvise file2 0 9999999999 dontneed
vmm:/mnt/hda6> time cat file1 > /dev/null & time cat file2 > /dev/null
cat 2 > /dev/null  0.00s user 0.11s system 0% cpu 21.011 total
cat 1 > /dev/null  0.00s user 0.14s system 0% cpu 23.011 total
vmm:/mnt/hda6> 0 blockdev --setra 4 /dev/hda
vmm:/mnt/hda6> fadvise file1 0 9999999999 dontneed
vmm:/mnt/hda6> fadvise file2 0 9999999999 dontneed
vmm:/mnt/hda6> time cat file1 > /dev/null & time cat file2 > /dev/null
cat 2 > /dev/null  0.07s user 0.43s system 1% cpu 31.431 total
cat 1 > /dev/null  0.01s user 0.27s system 0% cpu 31.430 total

OK, so there's a 50% slowdown on a modern IDE disk from not using readahead.

vmm:/mnt/hda6> for i in $(seq 1 8)
for> do
for> dd if=/dev/zero of=file$i bs=1M count=10 
for> sync
for> fadvise file$i 0 999999999 dontneed
for> done

vmm:/home/akpm> 0 blockdev --setra 240 /dev/hda1
for i in $(seq 1 8)
do
time cat file$i >/dev/null&          
done
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 4.422 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 5.801 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.012 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.261 total
cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 6.401 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.494 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.754 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 6.757 total

vmm:/mnt/hda6> for i in $(seq 1 8)
do
fadvise file$i 0 999999999 dontneed
done
vmm:/home/akpm> 0 blockdev --setra 4 /dev/hda1
vmm:/mnt/hda6> for i in $(seq 1 8)
do
time cat file$i >/dev/null&          
done
cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 13.373 total
cat file$i > /dev/null  0.00s user 0.04s system 0% cpu 14.849 total
cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 15.816 total
cat file$i > /dev/null  0.00s user 0.04s system 0% cpu 16.808 total
cat file$i > /dev/null  0.00s user 0.05s system 0% cpu 17.824 total
cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.004 total
cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.274 total
cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 19.301 total

So with eight files, it's a 300% drop from not using readahead.


With 16 files, readahead enabled:
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 9.887 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 10.925 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 11.033 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 11.146 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 11.381 total
cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 11.640 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 11.907 total
cat file$i > /dev/null  0.00s user 0.01s system 0% cpu 12.262 total
....

Readahead disabled:

cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 39.307 total
cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 39.378 total
cat file$i > /dev/null  0.00s user 0.04s system 0% cpu 39.679 total
cat file$i > /dev/null  0.00s user 0.03s system 0% cpu 39.888 total
cat file$i > /dev/null  0.00s user 0.02s system 0% cpu 40.261 total


Still only 300%.  I'd expect to see much larger differences on some older
SCSI disks I have here.


