Return-Path: <linux-kernel-owner+w=401wt.eu-S1030286AbXALUQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbXALUQv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbXALUQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:16:51 -0500
Received: from lucidpixels.com ([66.45.37.187]:33468 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030243AbXALUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:16:49 -0500
Date: Fri, 12 Jan 2007 15:15:09 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1:
 (211MB/s read & 195MB/s write)
In-Reply-To: <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan>
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
 <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan>
 <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan> <200701122235.30288.a1426z@gawab.com>
 <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, max sectors did improve my performance a little bit but 
stripe_cache+read_ahead were the main optimizations that made everything 
go faster by about ~1.5x.   I have individual bonnie++ benchmarks of 
[only] the max_sector_kb tests as well, it improved the times from 8min/bonnie 
run -> 7min 11 seconds or so, see below and then after that is what you 
requested.

# Options used:
# blockdev --setra 1536 /dev/md3 (back to default)
# cat /sys/block/sd{e,g,i,k}/queue/max_sectors_kb
# value: 512
# value: 512
# value: 512
# value: 512
# Test with, chunksize of raid array (128)
# echo 128 > /sys/block/sde/queue/max_sectors_kb
# echo 128 > /sys/block/sdg/queue/max_sectors_kb
# echo 128 > /sys/block/sdi/queue/max_sectors_kb
# echo 128 > /sys/block/sdk/queue/max_sectors_kb

max_sectors_kb128_run1:max_sectors_kb128_run1,4000M,46522,98,109829,19,42776,12,46527,97,86206,14,647.7,1,16:100000:16/64,874,9,29123,97,2778,16,852,9,25399,86,1396,10
max_sectors_kb128_run2:max_sectors_kb128_run2,4000M,44037,99,107971,19,42420,12,46385,97,85773,14,628.8,1,16:100000:16/64,981,10,23006,77,3185,19,848,9,27891,94,1737,13
max_sectors_kb128_run3:max_sectors_kb128_run3,4000M,46501,98,108313,19,42558,12,46314,97,87697,15,617.0,1,16:100000:16/64,864,9,29795,99,2744,16,897,9,29021,98,1439,10
max_sectors_kb128_run4:max_sectors_kb128_run4,4000M,40750,98,108959,19,42519,12,45027,97,86484,14,637.0,1,16:100000:16/64,929,10,29641,98,2476,14,883,9,29529,99,1867,13
max_sectors_kb128_run5:max_sectors_kb128_run5,4000M,46664,98,108387,19,42801,12,46423,97,87379,14,642.5,0,16:100000:16/64,925,10,29756,99,2759,16,915,10,28694,97,1215,8

162.54user 43.96system 7:12.02elapsed 47%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (5major+1104minor)pagefaults 0swaps
168.75user 43.51system 7:14.49elapsed 48%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (13major+1092minor)pagefaults 0swaps
162.76user 44.18system 7:12.26elapsed 47%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (13major+1096minor)pagefaults 0swaps
178.91user 43.39system 7:24.39elapsed 50%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (13major+1094minor)pagefaults 0swaps
162.45user 43.86system 7:11.26elapsed 47%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (13major+1092minor)pagefaults 0swaps

---------------

# cat /sys/block/sd[abcdefghijk]/queue/*
cat: /sys/block/sda/queue/iosched: Is a directory
32767
512
128
128
noop [anticipatory] 
cat: /sys/block/sdb/queue/iosched: Is a directory
32767
512
128
128
noop [anticipatory] 
cat: /sys/block/sdc/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdd/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sde/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdf/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdg/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdh/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdi/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdj/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
cat: /sys/block/sdk/queue/iosched: Is a directory
32767
128
128
128
noop [anticipatory] 
# 

(note I am only using four of these (which are raptors, in raid5 for md3))

# cat /proc/meminfo
MemTotal:      2048904 kB
MemFree:       1299980 kB
Buffers:          1408 kB
Cached:          58032 kB
SwapCached:          0 kB
Active:          65012 kB
Inactive:        33796 kB
HighTotal:     1153312 kB
HighFree:      1061792 kB
LowTotal:       895592 kB
LowFree:        238188 kB
SwapTotal:     2200760 kB
SwapFree:      2200760 kB
Dirty:               8 kB
Writeback:           0 kB
AnonPages:       39332 kB
Mapped:          20248 kB
Slab:            37116 kB
SReclaimable:    10580 kB
SUnreclaim:      26536 kB
PageTables:       1284 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3225212 kB
Committed_AS:   111056 kB
VmallocTotal:   114680 kB
VmallocUsed:      3828 kB
VmallocChunk:   110644 kB
# 

# echo 3 > /proc/sys/vm/drop_caches
# dd if=/dev/md3 of=/dev/null bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 399.352 seconds, 26.9 MB/s
# for i in sde sdg sdi sdk; do   echo 192 > 
/sys/block/"$i"/queue/max_sectors_kb;   echo "Set 
/sys/block/"$i"/queue/max_sectors_kb to 192kb"; done
Set /sys/block/sde/queue/max_sectors_kb to 192kb
Set /sys/block/sdg/queue/max_sectors_kb to 192kb
Set /sys/block/sdi/queue/max_sectors_kb to 192kb
Set /sys/block/sdk/queue/max_sectors_kb to 192kb
# echo 3 > /proc/sys/vm/drop_caches
# dd if=/dev/md3 of=/dev/null bs=1M count=10240 
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 398.069 seconds, 27.0 MB/s

Awful performance with your numbers/drop_caches settings.. !

What were your tests designed to show?


Justin.

On Fri, 12 Jan 2007, Justin Piszcz wrote:

> 
> 
> On Fri, 12 Jan 2007, Al Boldi wrote:
> 
> > Justin Piszcz wrote:
> > > RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU
> > >
> > > This should be 1:14 not 1:06(was with a similarly sized file but not the
> > > same) the 1:14 is the same file as used with the other benchmarks.  and to
> > > get that I used 256mb read-ahead and 16384 stripe size ++ 128
> > > max_sectors_kb (same size as my sw raid5 chunk size)
> > 
> > max_sectors_kb is probably your key. On my system I get twice the read 
> > performance by just reducing max_sectors_kb from default 512 to 192.
> > 
> > Can you do a fresh reboot to shell and then:
> > $ cat /sys/block/hda/queue/*
> > $ cat /proc/meminfo
> > $ echo 3 > /proc/sys/vm/drop_caches
> > $ dd if=/dev/hda of=/dev/null bs=1M count=10240
> > $ echo 192 > /sys/block/hda/queue/max_sectors_kb
> > $ echo 3 > /proc/sys/vm/drop_caches
> > $ dd if=/dev/hda of=/dev/null bs=1M count=10240
> > 
> > 
> > Thanks!
> > 
> > --
> > Al
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Ok. sec
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
