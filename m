Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSKYKit>; Mon, 25 Nov 2002 05:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSKYKit>; Mon, 25 Nov 2002 05:38:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:40102 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262826AbSKYKir>;
	Mon, 25 Nov 2002 05:38:47 -0500
Message-ID: <3DE1FF62.18F7071B@digeo.com>
Date: Mon, 25 Nov 2002 02:45:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Benchmark] AIM results
References: <20021124212337.30844.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2002 10:45:54.0756 (UTC) FILETIME=[D484F840:01C2946F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> Hi all,
> I've ran the AIM benchmark against 2.4.19 and 2.5.49 on my laptop (PIII@800 Reiserfs)

AIM9, I assume.

It's a rather dumb benchmark, but fun.  Lots of really tiny
microbenchmarks, easy to see what's going on.

Some of the codepaths which it touches in 2.5 have had new stuff
added to them - things like the pagecache read and write functions
have additional setup for readv and writev (which got sped up tons,
but is not tested here).  And additional layering for AIO support.

These things hurt when your benchmark is timing how long it takes to
write to a file in 1 kbyte chunks.  This is not really a thing which
we should optimise for.

But still, there's some stuff here which can be fixed; let's go through
it.

> creat-clo 10020 23.7525        23752.50 File Creations and Closes/second
> creat-clo 10030 18.9432        18943.17 File Creations and Closes/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

This loops, creating and deleting a file.   Adding some optimisation
to handle the removal of a zero-length file seems worthwhile.  That
sped it up by 30%-odd.
 
> page_test 10000 152.9       259930.00 System Allocations & Pages/second
> page_test 10010 128.971       219250.75 System Allocations & Pages/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

This found a bug in 2.5.  The deferred-lru-addition queues were preventing
the hot-n-cold page queues from working right.  I fixed that up and it's
almost running at the same speed as 2.4.  But the code paths are longer...

This is an area where smp optimisations cost uniprocessors a little
bit.  We're slightly slower on UP, but when running four instances of
this test on 4-CPU, 2.5 is more than twice the speed of 2.4.

We are still taking a very big hit in vm_enough_memory's call to
get_page_state().  Changing the overcommit mode can further speed
up 2.5, but we need to fix this properly somehow.

> brk_test 10000 63.5      1079500.00 System Memory Allocations/second
> brk_test 10010 53.9461       917082.92 System Memory Allocations/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

Same deal as page_test.
 
> signal_test 10000 204.5       204500.00 Signal Traps/second
> signal_test 10000 146.5       146500.00 Signal Traps/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

Mostly fixed in 2.5.49-mm1
 
> exec_test 10010 16.6833           83.42 Program Loads/second
> exec_test 10030 15.5533           77.77 Program Loads/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

Can't do a lot about that.
 
> fork_test 10000 56.2         5620.00 Task Creations/second
> fork_test 10010 32.967         3296.70 Task Creations/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

Or that.
 
> link_test 10000 224.1        14118.30 Link/Unlink Pairs/second
> link_test 10000 125.7         7919.10 Link/Unlink Pairs/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

I was seeing that difference for a while, then it went away.  I
suspect something is broken in the test.  In particular, it seems
to leave files behind in the test directory, so subsequent runs
have to search past more files.

I sped ext2 up a bit for this, but there's not much difference
from 2.4.
 
> ...
> 
> dir_rtns_1 10000 105.5      1055000.00 Directory Operations/second
> dir_rtns_1 10000 91.1       911000.00 Directory Operations/second
> ^^^^^ Here 2.4.49 is faster then 2.4.19

No, 2.4 was faster than 2.5.  The uninlining of the usercopy
functions costs a bit here.

The code in fs/readdir.c was quite inefficient, and buggy - lots
of unchecked copy_to_users.  I fixed all that up and sped it up
by 50%.

 
> shell_rtns_1 10000 31.3           31.30 Shell Scripts/second
> shell_rtns_1 10010 28.5714           28.57 Shell Scripts/second
> 
> shell_rtns_2 10010 31.3686           31.37 Shell Scripts/second
> shell_rtns_2 10030 28.6142           28.61 Shell Scripts/second
> 
> shell_rtns_3 10010 31.3686           31.37 Shell Scripts/second
> shell_rtns_3 10020 28.6427           28.64 Shell Scripts/second
> 
> series_1 10000 39306.1      3930610.00 Series Evaluations/second
> series_1 10000 38976.2      3897620.00 Series Evaluations/second
> 
> shared_memory 10000 2742.2       274220.00 Shared Memory Operations/second
> shared_memory 10000 2360.6       236060.00 Shared Memory Operations/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

20% of the cost here is just the syscall entry code.  This is
a nanobenchmark.

We added some scalability changes here and yes, uniprocessors
have taken a 5% hit from that.  But running four instances of
this test on 4-way, 2.5 is 250% faster than 2.4.

> tcp_test 10000 805.5        72495.00 TCP/IP Messages/second
> tcp_test 10000 660.7        59463.00 TCP/IP Messages/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)
> 
> udp_test 10000 1448.6       144860.00 UDP/IP DataGrams/second
> udp_test 10000 1115.7       111570.00 UDP/IP DataGrams/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)

Not sure what's going on here, really.  Lots of tiny TCP and UDP
copies to localhost.  The profiles are splattered all over the place.
Networking just generally seems to have increased its cache footprint.

> fifo_test 10000 1568.7       156870.00 FIFO Messages/second
> fifo_test 10000 1041.6       104160.00 FIFO Messages/second
> ^^^^^ Here 2.4.19 is faster then 2.5.49

Not on my machine.  2.5.49-mm1 is 20% faster than 2.4.  This is the
sort of thing which shows much variability.
