Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267100AbRGJWjJ>; Tue, 10 Jul 2001 18:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbRGJWi7>; Tue, 10 Jul 2001 18:38:59 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:41901 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S267100AbRGJWit>; Tue, 10 Jul 2001 18:38:49 -0400
Date: Tue, 10 Jul 2001 18:38:30 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dead mem pages 
In-Reply-To: <Pine.LNX.4.33.0107100941270.5644-100000@mf1.private>
Message-ID: <Pine.LNX.4.33.0107101321000.25541-100000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hey Wayne,

thx for the long answer.

On Tue, 10 Jul 2001, Wayne Whitney wrote:

> Hi Dirk,
>
> How's things at Renaissance?

good, currently only with one exception ;-)  how is it in Berkeley?

> On Mon, 9 Jul 2001, Dirk Wetter wrote:
>
> > why does the kernel have 2.8GB of cached pages, and our applications
> > have to swap 1.5+1.1GB of pages out?
>
> While I can't answer your question, one thing to know is that "cached"
> does not mean file cache.  In fact, there was a thread on LKML on I think
> exactly this in the last couple of days.  Anyway, I believe "cached" means
> the page cache, which can include lots of things; I gather it's a general
> kernel memory pool, and that everything in the kernel will be moving to
> the page cache.

> Although with 2.8GB of "cached" memory, alot of that must
> be from I/O.

we do some i/o. but still there shouldn't be do a harm to the OS which is
dedicating or more clearly speaking leaking (because we also don't get
it really back) memory for page- or whatever-cache.

> It would be good to know what these 2.8GB of cached pages are.

believe me, i would like to know too where all the $$$ memory
went to. ;-)

> I believe just for filesystem data and metadata.

(/proc/slabinfo doesn't reveal anything weird in our cases)

> I think
> that ext2, for example, has moved from using buffers for both data and
> metadata to using the pagecache for metadata.  Assuming you are using
> ext2, it would be interesting to see what the numbers look like with an
> older kernel that still uses buffers for ext2 metadata (something like
> kernel 2.4.2, I think, it will say in the ChangeLog)--it's vaguely
> possible that a leak was introduced in moving the ext2 metadata into the
> pagecache.  Or perhaps the VM balancing on cached filesystem metadata was
> broken when moving ext2 to the pagecache.

the data where the "real" file i/o is coming from are reiserfs partitions
with the exception of one machine (xfs), which is behaving in the same
manner. also, lvm is running under those fs.

> > i don't know how to collect more information, please let me know what
> > i can do in order send more info (.config is CONFIG_HIGHMEM4G=y).
>
> One thing you can do is capture the output of "vmstat 1" from a fresh
> reboot through the machines becoming unusable.  Depending on how long it
> takes to fail, you might want to increase the period from 1 second.

kind of that i did. i saw a lot a lot of "so" activity, *if* there was
an output and the machines weren't too busy with swapping.

sar -B on the file from yesterday tells me:

12:00:00     pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg  inatarpg
[...]
14:00:02         0.00      1.02     24003    180843         0         2
14:20:02         0.00      1.03     24003    180846         0         0
14:40:02         0.00      1.07     24003    180848         0         0
15:00:02         0.50      1.31     25132    180885         0        55
15:20:52       317.22   1534.27    466283     29531    287829      6639
15:40:52       213.80      1.97    513702    171317      2360       292
16:02:41         1.54      0.75    590263     32258     88140       323
16:22:41        33.68      1.62    537667     83592     93147        72
16:42:41         5.79      1.55    541736     97796     73838         9
17:00:00         4.92      1.68    523394    166445     21797        44
Average:        46.43    144.11    225926    136494     37807       538

sar -r:

12:00:00    kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached kbswpfree kbswpused  %swpused
[..]
14:00:02      3157092    901036     22.20         0     62400    756984  14337736         0      0.00
14:20:02      3157464    900664     22.19         0     62400    756996  14337736         0      0.00
14:40:02      3157452    900676     22.19         0     62400    757004  14337736         0      0.00
15:00:02      3141724    916404     22.58         0     62400    761668  14337736         0      0.00
15:20:52         4704   4053424     99.88         0      2848   3131724  10966232   3371504     23.51
15:40:52        18580   4039548     99.54         0      3236   2746280  10959228   3378508     23.56
16:02:41        43060   4015068     98.94         0      3240   2839404  10825980   3511756     24.49
16:22:41        44640   4013488     98.90         0      3240   2854384  10810852   3526884     24.60
16:42:41        40352   4017776     99.01         0      3248   2850232  10810852   3526884     24.60
17:00:00        45088   4013040     98.89         0      3260   2843284  10811436   3526300     24.59
Average:      1950288   2107840     51.94         0     38673   1562233  12948280   1389456      9.69

so the machine was basically memorywise ok, upto the point when the
jobs were submitted (15:20), which used up all the userspace memory
(kbmemused=4GB), but simultaneously the kernel claimed more pages for
it's cache (kbcached=3.13GB), so the machine had to start swapping
heavily (kbswpused=3.3GB).  and there is exactly my point: why didn't
my app get the memory, but the kernel?

> On a general note, you can try the -ac series of kernels, but I don't
> believe that they have any significant VM changes.

ac is up to -ac2 for 2.4.6. i don't see either that my points are
addressed there.

> Again on a general note, the 2.4 kernel's VM is new and hence not fully
> mature.  So the short and unhelpful answer to your query is probably that
> the current VM system is not well tuned for your workload (4.3GB of memory
> hungry simulations on a 4GB machine).

concerning the maturity that's also the answer i got from the kernel
guru's at last USENIX in boston. but ihmo it *should* become soon
better for the future if Linux intends to become bigger in the server
business. (my $0.02)

> Will the simulations still run if you ulimit them to 1.75GB?  If so, it
> would be interesting to know, for another data point, how things behave
> with 2 1.75GB processes.

with one process i get:

  1:49pm  up 20:16,  2 users,  load average: 1.13, 1.02, 0.97
55 processes: 52 sleeping, 2 running, 1 zombie, 0 stopped
CPU0 states: 99.0% user,  0.1% system, 99.0% nice,  0.0% idle
CPU1 states:  0.1% user,  4.0% system,  0.0% nice, 94.0% idle
Mem:  4058128K av, 4012536K used,   45592K free,       0K shrd,    3644K buff
Swap: 14337736K av, 1870764K used, 12466972K free                 3510436K cached

  PID USER     PRI  NI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMAND
 5747 uid1      18   4 2290M 1.4G 864M  414M  0M R N  99.9 21.8 709:42 ceqsim
13297 uid2      14   0  1048    0 1048   820  56 R     5.6  0.0   0:00 top
    1 root       8   0    76   12   64    64   4 S     0.0  0.0   0:01 init
    2 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:09 kswapd
    4 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:00 kreclaimd
    5 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:00 bdflush
    6 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:01 kupdated
    7 root       9   0     0    0    0     0   0 SW    0.0  0.0   0:00 scsi_eh_0

the of total of VSZ + RSS (in ps alx:)  2520012 899304

cat /proc/meminfo

MemTotal:      4058128 kB
MemFree:         45628 kB
MemShared:           0 kB
Buffers:          3644 kB
Cached:        3510712 kB
Active:        1824092 kB
Inact_dirty:   1523012 kB
Inact_clean:    167252 kB
Inact_target:     1076 kB
HighTotal:     3211200 kB
HighFree:        13532 kB
LowTotal:       846928 kB
LowFree:         32096 kB
SwapTotal:    14337736 kB
SwapFree:     12466972 kB

so again, top shows me that 1.4GB are swapped out, so does /proc/swaps:

Filename                        Type            Size    Used    Priority
/dev/sda5                       partition       2048248 1870764 -1
/dev/sdb1                       partition       2048248 0       -2
[..]

and this looks also like the same bug to me.

> Well, hope this helps.

a little bit, yes. thanks!


any official word from a guru?


	~dirkw




