Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTAEJKX>; Sun, 5 Jan 2003 04:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbTAEJKX>; Sun, 5 Jan 2003 04:10:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:28648 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264610AbTAEJKV>;
	Sun, 5 Jan 2003 04:10:21 -0500
Message-ID: <3E17F878.21A363BF@digeo.com>
Date: Sun, 05 Jan 2003 01:18:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <3E1783D0.5A47A299@digeo.com> <Pine.LNX.4.44.0301041930300.1388-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 09:18:49.0402 (UTC) FILETIME=[74E6F9A0:01C2B49B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> It doesn't show up on lmbench (insufficient precision), but your AIM9
> numbers are quite interesting. Are they stable?

OK, a closer look.  This is on a dual 1.7G P4, with HT disabled (involuntarily,
grr.)   Looks like an 8-10% hit on context-switch intensive stuff.


2.5.54+BK
=========

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
i686-linu  Linux 2.5.54    3      4     11     6     48      12      53

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn

tbench 32:			(85k switches/sec)

Throughput 114.633 MB/sec (NB=143.291 MB/sec  1146.33 MBit/sec)
Throughput 114.157 MB/sec (NB=142.696 MB/sec  1141.57 MBit/sec)
Throughput 115.095 MB/sec (NB=143.869 MB/sec  1150.95 MBit/sec)

pollbench 1 100 5000		(118k switches/sec)
  result with handles 1 processes 100 loops 5000:time  8.371942 sec.
  result with handles 1 processes 100 loops 5000:time  8.381814 sec.
  result with handles 1 processes 100 loops 5000:time  8.367576 sec.
pollbench 2 100 2000		(105k switches/sec)
  result with handles 2 processes 100 loops 2000:time  3.694412 sec.
  result with handles 2 processes 100 loops 2000:time  3.672226 sec.
  result with handles 2 processes 100 loops 2000:time  3.657455 sec.
pollbench 5 100 2000		(79k switches/sec)
  result with handles 5 processes 100 loops 2000:time  4.564727 sec.
  result with handles 5 processes 100 loops 2000:time  4.783192 sec.
  result with handles 5 processes 100 loops 2000:time  4.561067 sec.

2.5.54+BK+broken-wrmsr-backout-patch:
=====================================


Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
i686-linu  Linux 2.5.54    3      4     11     6     48      12      53
i686-linu  Linux 2.5.54    1      3      8     4     40      10      51

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
i686-linu  Linux 2.5.54     3    14   22    26          30         57
i686-linu  Linux 2.5.54     1    12   28    22          32         58


tbench 32:

Throughput 121.701 MB/sec (NB=152.126 MB/sec  1217.01 MBit/sec)
Throughput 124.958 MB/sec (NB=156.197 MB/sec  1249.58 MBit/sec)
Throughput 124.086 MB/sec (NB=155.107 MB/sec  1240.86 MBit/sec)

pollbench 1 100 5000
  result with handles 1 processes 100 loops 5000:time  7.306432 sec.
  result with handles 1 processes 100 loops 5000:time  7.352913 sec.
  result with handles 1 processes 100 loops 5000:time  7.337019 sec.
pollbench 2 100 2000
  result with handles 2 processes 100 loops 2000:time  3.184550 sec.
  result with handles 2 processes 100 loops 2000:time  3.251854 sec.
  result with handles 2 processes 100 loops 2000:time  3.209147 sec.
pollbench 5 100 2000
  result with handles 5 processes 100 loops 2000:time  4.135773 sec.
  result with handles 5 processes 100 loops 2000:time  4.117304 sec.
  result with handles 5 processes 100 loops 2000:time  4.119047 sec.


The tbench changes should probably be ignored.  After profiling tbench
I can say that this thoughput difference is _not_ due to the task switcher
change (__switch_to is only 1%).  I left the numbers here to show what
the effect of simply relinking and rebooting the kernel can be.


BTW, the pollbench numbers are not stunningly better than the 500MHz PIII:
pollbench 1 100 5000
  result with handles 1 processes 100 loops 5000:time  9.609487 sec.
pollbench 2 100 2000
  result with handles 2 processes 100 loops 2000:time  4.016496 sec.
pollbench 5 100 2000
  result with handles 5 processes 100 loops 2000:time  4.917921 sec.

I didn't profile the P4.  John has promised P4 oprofile support for
next week, which will be nice.

I did profile Manfred's pollbench on the PIII, uniprocessor build.  Note
that there is only a 5% throughput difference on this machine.  It's all
in __switch_to().   Here the PIII is doing 70k switches/sec.

2.5.54+BK:

c012abbc 534      2.69888     buffered_rmqueue
c0116714 617      3.11837     __wake_up_common
c010a606 635      3.20934     restore_all
c014b038 745      3.76529     do_poll
c013d4dc 757      3.82594     fget
c014551c 766      3.87142     pipe_write
c010a5c4 1249     6.31254     system_call
c014b0f0 1273     6.43384     sys_poll
c01090a4 1775     8.97099     __switch_to
c0116484 1922     9.71394     schedule

2.5.54+BK+backout-patch:

c012abbc 768      3.1024      buffered_rmqueue
c0116714 790      3.19127     __wake_up_common
c010a5e6 809      3.26803     restore_all
c013d4dc 918      3.70834     fget
c014551c 936      3.78105     pipe_write
c014b038 977      3.94668     do_poll
c01090a4 1070     4.32236     __switch_to
c014b0f0 1606     6.48758     sys_poll
c010a5a4 1678     6.77843     system_call
c0116484 2542     10.2686     schedule
