Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSKUAHW>; Wed, 20 Nov 2002 19:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSKUAHW>; Wed, 20 Nov 2002 19:07:22 -0500
Received: from holomorphy.com ([66.224.33.161]:26348 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264936AbSKUAHT>;
	Wed, 20 Nov 2002 19:07:19 -0500
Date: Wed, 20 Nov 2002 16:08:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021121000811.GQ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC1480.402A0E5B@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> First row: 2.4.30-rc1aa1
> Second row: 2.5.48-mm1+

Given the contents of -aa this is probably not far from its proper
version number, if not being tagged as a 2.5 variant. =)


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> signal_test 30000 122 122000.00 Signal Traps/second
> signal_test 10000 91.7 91700.00 Signal Traps/second
>     Signal delivery is a lot slower in 2.5.  I do not know why,

Similar things have been reported with 2.4.x vs. 2.2.x and IIRC there
was some speculation they were due to low-level arch code interactions.
I think this merits some investigation. I, for one, am a big user of
SIGIO in userspace C programs...


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> exec_test 30000 38.3 191.50 Program Loads/second
> exec_test 10020 37.0259 185.13 Program Loads/second
>     Possibly rmap overhead.
> fork_test 30010 15.3282 1532.82 Task Creations/second
> fork_test 10060 13.5189 1351.89 Task Creations/second
>     Possibly rmap overhead

Both known rmap overheads. This got debated/flamed/beaten to death
earlier in 2.5.x.


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> shell_rtns_1 30000 47.9333 47.93 Shell Scripts/second
> shell_rtns_1 10010 46.7532 46.75 Shell Scripts/second
> shell_rtns_2 30010 47.9174 47.92 Shell Scripts/second
> shell_rtns_2 10010 46.7532 46.75 Shell Scripts/second
> shell_rtns_3 30000 47.8667 47.87 Shell Scripts/second
> shell_rtns_3 10010 46.7532 46.75 Shell Scripts/second
>     rmap?

Yep. Shell stuff forking short-lived things that exec rapid-fire is the
same stuff antonb saw during SDET. (Otherwise it could be something else.)


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> shared_memory 30000 1499.8 149980.00 Shared Memory Operations/second
> shared_memory 10000 1355 135500.00 Shared Memory Operations/second
>     Reason unknown.

This is mmap()/munmap() and open()/close() of an anonymous (i.e. link
count 0) shmfs inode. This needs to be broken down into more specific
sysv shm operations and profiled to get a proper notion of what's wrong.
The codepaths responsible are clear: ipc/shm.c, mm/shmem.c, and mm/mmap.c


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> tcp_test 30000 341.667 30750.00 TCP/IP Messages/second
> tcp_test 10010 296.503 26685.31 TCP/IP Messages/second
> udp_test 30000 635.367 63536.67 UDP/IP DataGrams/second
> udp_test 10000 619.7 61970.00 UDP/IP DataGrams/second
>     networking to localhost is really unrepeatable.  I tend to
>     ignore such results.  Although 2.5 does seem to be consistently
>     slower.

The behavior I observe is a bit different (i.e. totally consistent) but
that's pretty much because I'm bitten incredibly hard by odd performance
scalability issues in networking code (localhost all goes to the same
queue and things spin hard on the lock). On machines small enough not
to really care that there's locking at all I see the variability too.
I'd like to get this variability resolved but it's quite far afield
from anything I actually have expertise in or any sanction to work on.


On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> fifo_test 30000 2008.63 200863.33 FIFO Messages/second
> fifo_test 10000 1970.8 197080.00 FIFO Messages/second
> stream_pipe 30000 1362.77 136276.67 Stream Pipe Messages/second
> stream_pipe 10000 1381.5 138150.00 Stream Pipe Messages/second
> dgram_pipe 30000 1315.1 131510.00 DataGram Pipe Messages/second
> dgram_pipe 10000 1353.1 135310.00 DataGram Pipe Messages/second
> pipe_cpy 30000 2164.77 216476.67 Pipe Messages/second
> pipe_cpy 10000 2291.6 229160.00 Pipe Messages/second
>     The pipe code has had some work.  Although these tests also
>     tend to show very high variation between runs, and between reboots.

The interactions of wake_up_sync() with the rest of the workload would
be nice to resolve (the processes on the pipe end up dominating the
machine), though that's not going to show up in a microbenchmark. Aside
from that I'm satisfied with pipe performance and see highly variable
bandwidth measurements also. I've heard rumors pipe microbenchmark
performance numbers have mostly to do with page color clashes with the
codepaths exercised during the benchmark and the task_structs
describing the processes performing the benchmark, with the natural
link order and code arrangement/size dependencies implied (not to
mention phase of the moon, the weather, and the government).

Would getting an idea of what's statistically significant across runs
for the highly variable benchmarks be useful?


Bill
