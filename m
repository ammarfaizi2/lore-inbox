Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTAGTbs>; Tue, 7 Jan 2003 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbTAGTbs>; Tue, 7 Jan 2003 14:31:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267506AbTAGTbq>;
	Tue, 7 Jan 2003 14:31:46 -0500
Date: Tue, 7 Jan 2003 11:37:04 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: george anzinger <george@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 23
In-Reply-To: <3E162A5E.768E9F4@mvista.com>
Message-ID: <Pine.LNX.4.33L2.0301071111210.2498-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,


On Fri, 3 Jan 2003, george anzinger wrote:

| Just in case you might like high res timers...
|
| Now for 2.5.54-bk1

Using exactly 2.5.54-bk1 + the POSIX clocks/timers + HRT patches,
when I run the HRT support test suite (do_test), I'm getting
intermittent (but often) spinlock BUGs.  I've done this both without
and with HIGH_RES_TIMERS enabled (i.e., different kernels built
in the same source tree).
Details are below.

Yes, I expect to be able to run the test suite on a kernel that
doesn't have HIGH_RES_TIMERS enabled...and to see the tests fail.

| -------
| This patch supplies the core changes to implement high
| resolution timers.  Mostly it changes the timer list from
| the multi stage hash (or cascade) list to a single stage
| hash list.  This change makes it easy to configure the list
| size for those who are concerned with performance.  It also
| eliminates the "time out" for the cascade operation every
| 512 jiffies, thus eliminating possibly long preemption
| times.  On input from Stephen Hemminger<shemminger@osdl.org>
| the configuration of the timer list size is no longer
| presented as a configure option.  The code can still be
| change (one line) to use larger or smaller lists.
|
| With this patch applied, the system should boot and run much
| as it does prior to the patch.  This patch depends on the
| POSIX clocks & timers patch in that it assumes the changes
| that patch made to timer.c to remove timer_t.  This
| dependency can be removed if needed.

Couple of questions, please:

1.  With HIGH_RES_TIMERS enabled, are all timers high-res timers,
or does the API allow for some non-high-res timers (regular/normal)
and some high-res-timers?

2.  With HIGH_RES_TIMERS enabled and no apps trying to use high-res
timers, should I be able to detect any additional system overhead
due to the HIGH_RES_TIMERS code?


Thanks,
-- 
~Randy


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2.5.54-bk1 + POSIX/HRT patches, with HIGH_RES_TIMERS=n:

kernel BUG at include/asm/spinlock.h:123!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c0130260>]    Not tainted
EFLAGS: 00010086
EIP is at good_timespec+0x80/0x180
eax: 0000000e   ebx: ee5c471c   ecx: f63d7100   edx: c03e2dec
esi: 00000000   edi: ed50df9c   ebp: ed50df8c   esp: ed50df78
ds: 007b   es: 007b   ss: 0068
Process timer_test (pid: 1970, threadinfo=ed50c000 task=f5b85800)
Stack: c0369bc0 c0130244 ed50c000 ed50df9c 00000000 ed50dfbc c01308d6 00000000
       ed50df9c 00000082 c0150e73 f7193ce4 40016000 00000032 ed50c000 4001526c
       00000000 bfff9778 c0109537 00000000 00000000 bfff90a8 4001526c 00000000
Call Trace:
 [<c0130244>] good_timespec+0x64/0x180
 [<c01308d6>] sys_timer_settime+0x16/0x180
 [<c0150e73>] sys_read+0x33/0x40
 [<c0109537>] system_call+0x7/0xb

Code: 0f 0b 7b 00 64 98 36 c0 59 58 8d b6 00 00 00 00 f0 fe 4b 08

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2.5.54-bk1 + POSIX/HRT patches, with HIGH_RES_TIMERS=y:

kernel BUG at include/asm/spinlock.h:123!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01307a0>]    Not tainted
EFLAGS: 00010086
EIP is at good_timespec+0x80/0x180
eax: 0000000e   ebx: f68c589c   ecx: f6f96300   edx: c03e3aec
esi: 87000007   edi: f6919ed8   ebp: f6919ec8   esp: f6919eb4
ds: 007b   es: 007b   ss: 0068
Process 2timer_test (pid: 1940, threadinfo=f6918000 task=f6bc6b80)
Stack: c036a860 c0130784 00000023 f6919f30 00000001 f6919ee4 c01300b8 87000007
       f6919ed8 00000086 00000023 f6919f30 f6919efc c0127117 f6919f30 f6919f30
       f6bc7130 f6918000 f6919f1c c012829a f6bc7130 f6919f30 f6bc7130 f6919fc4
Call Trace:
 [<c0130784>] good_timespec+0x64/0x180
 [<c01300b8>] schedule_next_timer+0x18/0x50
 [<c0127117>] __dequeue_signal+0x87/0xa0
 [<c012829a>] notify_parent+0x7a/0x290
 [<c01092cd>] handle_signal+0x5d/0xd0
 [<c0222e5f>] copy_to_user+0x2f/0x40
 [<c01285ea>] do_no_restart_syscall+0x10a/0x240
 [<c0109582>] work_resched+0x13/0x15

Code: 0f 0b 7b 00 04 a5 36 c0 59 58 8d b6 00 00 00 00 f0 fe 4b 08

###


