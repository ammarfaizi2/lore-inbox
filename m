Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbTCOFU1>; Sat, 15 Mar 2003 00:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbTCOFU1>; Sat, 15 Mar 2003 00:20:27 -0500
Received: from holomorphy.com ([66.224.33.161]:14032 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261391AbTCOFUZ>;
	Sat, 15 Mar 2003 00:20:25 -0500
Date: Fri, 14 Mar 2003 21:30:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315053053.GM20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314205455.49f834c2.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> dbench on 32x/48G NUMA-Q, aic7xxx adapter, pbay disk, 32K PAGE_SIZE
>> (pgcl was used for benchmark feasibility purposes)
>> throughput:
>> ---------- 
>> before:
>> Throughput 61.5376 MB/sec 512 procs
>> dbench 512  637.21s user 15739.41s system 565% cpu 48:16.28 total
>> after:
>> Throughput 104.074 MB/sec 512 procs
>> (GRR, didn't do time, took ca. 30 minutes)

On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> `dbench 512' will presumably do lots of IO and spend significant
> time in I/O wait.  You should see the effects of this change more
> if you use fewer clients (say, 32) so it doesn't hit disk.
> On quad power4, dbench 32:

Hmm. I'm just trying to spawn enough tasks to keep the cpus busy to get
a large enough thread pool to have something to run when someone sleeps.
There's enough idle time now that this sounds like the wrong direction
to move the task count in...


On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> Unpatched:
> 	Throughput 334.372 MB/sec (NB=417.965 MB/sec  3343.72 MBit/sec)
[...]
> patched:
> 	Throughput 335.262 MB/sec (NB=419.078 MB/sec  3352.62 MBit/sec)
[...]
> No difference at all.
> On the quad Xeon (after increasing dirty_ratio and dirty_background_ratio so
> I/O was negligible) I was able to measure a 1.5% improvement.
> I worry about the hardware you're using there.

Why? The adapter is "vaguely modern" (actually acquired as part of a
hunt for an HBA w/a less buggy driver) but the box and disks and so on
are still pretty ancient, so the absolute numbers aren't useful.

To get a real comparison we'd have to compare spindles, HBA's, and
cpus, and attempt to factor them out. The disks are actually only
capable of doing 30MB/s or 40MB/s, the buses can only do 40MB/s, and
the cpus are 700MHz P-III's. Where dbench gets its numbers faster than
wirespeed I have no idea...

This locking issue may just need more cpus to bring out.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> profile:
>> --------
[...]
>> after:
>> vma        samples  %-age       symbol name
>> c0106ff4   52751908 30.8696     default_idle
>> c01dc3b0   28988721 16.9637     __copy_to_user_ll
>> c01dc418    8240854  4.82242    __copy_from_user_ll
>> c011e472    8044716  4.70764    .text.lock.fork
[...]
> Lots of idle time.  Try it with a smaller client count, get the I/O out of
> the picture.

I'll have trouble as there won't be enough tasks to keep the cpus busy.
Why do you think reducing the client count gets io out of the picture?
Why do you think reducing the client count will reduce idle time?


William Lee Irwin III <wli@holomorphy.com> wrote:
>> vmstat (short excerpt, edited for readability):

On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> With what interval?

Sorry, 1s.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> after:
>> procs -----------memory---------- -----io---- --system-- ----cpu----
>>  r  b     free    buff    cache     bi    bo   in    cs   us sy id wa
>> 60 11   38659840 533920  9226720   100  1672  2760  1853   5 66 11 18
>> 31 23   38565472 531264  9320384   240  1020  1195  1679   2 35 37 26
>> 23 23   38384928 521952  9503104   772  3372  5624  5093   2 62  9 27
>> 24 31   37945664 518080  9916448  1536  5808 10449 13484   1 45 13 41
>> 31 86   37755072 516096 10091104  1040  1916  3672  9744   2 51 15 32
>> 24 30   37644352 512864 10192960   900  1612  3184  8414   2 49 12 36
>> There's a lot of odd things going on in both of the vmstat logs.

On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> Where are all those interrupts coming from?

Well, the timer interrupt is a killer. 1KHz*num_cpus_online() blows
goats for sufficiently large num_cpus_online(), but for some reason
things are slower without it. I suspect that scheduling response
time is somehow dependent on it.

I got a hold of an aic7xxx so io throughput is slightly better than my
usual NUMA-Q runs (i.e. oopsen). The disks are still clockwork, though.


-- wli
