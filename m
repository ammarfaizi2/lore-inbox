Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275044AbRIYQBw>; Tue, 25 Sep 2001 12:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRIYQBn>; Tue, 25 Sep 2001 12:01:43 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:30885 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S275044AbRIYQBa>;
	Tue, 25 Sep 2001 12:01:30 -0400
Date: Tue, 25 Sep 2001 18:01:09 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: VM-improvment with 2.4.9-ac14 + 2.4.9-ac14-aging
Message-ID: <Pine.LNX.4.21.0109251732570.876-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

I have a success-story which I told Rik on irc and he asked me to mail it
to you.

I have a fileserver with 280GB diskspace and 256MB ram, it's a celeron
366. It has two software raid0 arrays. The whole machine runs reiserfs.
(before the hardwareupgrade a little while ago it ran LVM which didn't
work fine when I tried 2.4.9-ac9 so I went back to the old kernel,
2.4.4-ac10)

2.4.4-ac10 worked but it really liked to swap in and out all the time when
the ftp-server was active (people where downloading at 3-10MB/s) and this
made the machine _very_ sluggish. For example it swapped out about
everything that wasn't used in the last 2-5 seconds so interactive work on
the machine (ssh) was awful. And if several downloads where taking place
at the same time it really started swapping out and then in. and then the
server became almost unusable to anything else, and the I/O-speeds really
went down because of the swapping. It was swapping both in and out during
the ftp-downloads thus killing all performance of the machine.

Now I've upgraded to 2.4.9-ac14 + 2.4.9-ac14-aging from Rik. (I patched it
woth the reiserfs-speedup too but this shouldn't affect the swapping I
think). The machine became a completely new machine, now I don't notice
that someone's downloading files at >9MB/s from it. The interactive usage
is much better. I tried leaving an ssh session idle on the server over
night and it was still responsive when I woke up, with 2.4.4-ac10 it would
have taken 1-2 seconds for it to come alive again.

The machine has swapped out things like unused pages of the httpd's and
mysqld's and stuff so it has 40-50MB swap used according to top and
friends. If I run vmstat during downloads I don't see this constant swap
out/swap in behaviour anymore and the machine is much more responsive.

I do however see that it allocates new swap sometimes but not swapping
anything out. and I do see that it swaps stuff in from time to time, I
guess this ends up in the SwapCache and is later beeing discarded and then
sometime later swapped in again and the procedure repeats.

This newly allocated swapspace that's never used seems to decrease slowly
over time. The fact that it's allocating new swapspace doesn't really
bother me but I don't like the reason why it does it. The pages the
ftpserver uses for the I/O are only used once and then discarded. I don't
think we should allocate new swapspace for this kind of sequential I/O.

Here's the output of 'vmstat 5' during a download from the ftpserver:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  49400   4584  15024 181276   0   0     0     0  128    74   0   0 100
 0  0  0  49400   4584  15024 181276   0   0     0     0  123    74   0   0 100
 0  0  0  49400   4584  15024 181276   0   0     0     0  121    74   0   0 100
 0  0  1  49400   4584  15024 181276   0   0     0     2  171    73   0   0 100
 0  0  0  49400   3056  15268 182608   0   0  1956    38 1088   367   1   8  91
 1  0  1  49400   3056  13964 185372   0   0  7096    30 3616   894   3  30  67
 2  0  1  50204   3056  13952 185512   0   0  7198    30 3675   889   4  32  64
 1  0  0  50668   3056  13696 185736  11   0  6271    32 3205   797   3  29  67
 2  0  1  50968   3056  13520 183756 126   0  7814   101 3826   971  13  31  57
 1  0  1  51340   3056  13548 184572   3   0  7274    61 3690   912   8  32  59
 1  0  0  51340   3056  13600 184556   0   0  6391    35 3298   852   4  27  69
 1  0  1  51624   3056  13580 184592   0   0  8005    34 4102  1048   4  38  58
 1  0  0  51668   3056  13500 184732   0   0  6607    33 3361   847   3  29  68
 1  0  0  51716   3056  13460 185352   0   0  7903    37 3997   988   3  35  62
 1  0  1  51716   3056  13492 185340   0   0  6890    38 3504   898   3  30  66
 1  0  0  51716   3056  13172 185684   0   0  7787    34 3962  1021   2  32  65
 2  0  1  51724   3056  13096 185692   0   0  6764    30 3454   969   2  28  70
 2  0  1  51724   3056  13088 185696   0   0  6669    34 3316   540  70  30   0
 1  0  0  51724   3056  13120 185776   0  27  7224    61 3689   904   6  32  62
 1  0  0  51724   3056  13168 185868   0   0  6917    34 3521   898   2  30  68
 3  0  0  51724   3060  13064 184884   0   0  7917    37 3948   935   7  36  58
 0  0  0  51724   3124  13016 185436 101   0  6600    56 3276   861   7  28  66
 1  0  0  51724   3056  13044 185472   0   0  6571    33 3354   880   2  30  68
 1  0  0  51744   3056  12908 185616   0   0  7876    32 3992  1025   2  34  63
 1  0  0  51744   3056  12944 185580   0   0  6902    30 3514   887   1  29  70
 0  0  0  51744   3056  12916 185628   0   0  3610    38 1908   558   2  17  81
 0  0  0  51744   3848  12956 184792   0   0   140     5  217   190   3   4  94
 0  0  0  51744   4176  13020 184820   0   0     1    26  141    89   1   0  99
 0  0  0  51744   4176  13020 184820   0   0     0     0  119    69   0   0 100
 1  0  0  51744   4096  13020 184824   0   0     1     0  128    80   0   0 100
 0  0  0  51744   4152  13020 184844   0   0     3     7  134    90   1   0  99
 0  0  0  51744   4156  13020 184844   0   0     0     6  122    76   0   0 100
 0  0  0  51744   4644  13020 184352   0   0    14    21  129    85   7   1  92
 0  0  0  51744   4648  13020 184352   0   0     0    14  128    78   0   0 100
 0  0  0  51744   4644  13020 184352   0   0     0     0  124    76   1   0  99
 0  0  0  51744   4648  13020 184352   0   0     0     0  130    72   0   0 100
 0  0  0  51744   4644  13020 184352   0   0     0     0  128    78   1   0  99
 0  0  0  51744   4648  13020 184352   0   0     0     0  126    77   0   0  99
 0  0  0  51744   4644  13020 184352   0   0     0     0  126    79   0   0 100
 0  0  0  51744   4588  13020 184356  10   0    15    11  138    88   0   1  99
 0  0  0  51736   3616  13040 185064  40   0   191     6  152    96   0   1  99
 0  0  0  51736   3596  13060 185064   0   0     0     7  130    76   0   0 100
 0  0  0  51736   3596  13060 185064   0   0     0     0  128    78   0   1  99

here you can see the increase in the swapspaceallocation. It rarely swaps
anything out, it just allocates new swapspace. these statistics where
taken about 30 minutes ago, I just checked the amount of swap
used/allocated now (30 min later) and it's 52036 now.
I can't see any new processes started so I assume it's preallocated
swapspace.

I didn't look in /proc/meminfo when I ran that vmstat but here it is 30
minutes later:

        total:    used:    free:  shared: buffers:  cached:
Mem:  261926912 258797568  3129344    32768 14131200 218222592
Swap: 127987712 53284864 74702848
MemTotal:       255788 kB
MemFree:          3056 kB
MemShared:          32 kB
Buffers:         13800 kB
Cached:         185172 kB
SwapCached:      27936 kB
Active:         142740 kB
Inact_dirty:     53728 kB
Inact_clean:     30472 kB
Inact_target:    65520 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255788 kB
LowFree:          3056 kB
SwapTotal:      124988 kB
SwapFree:        72952 kB


/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

