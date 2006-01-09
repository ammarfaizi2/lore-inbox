Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWAIA0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWAIA0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWAIA0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:26:22 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47039 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965010AbWAIA0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:26:21 -0500
Date: Sun, 8 Jan 2006 19:26:02 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: John Rigg <lk@sound-man.co.uk>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt2 x86_64 SMP instability
In-Reply-To: <20060108230724.GA4197@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601081923430.26375@gandalf.stny.rr.com>
References: <20060108230724.GA4197@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jan 2006, John Rigg wrote:

> I've just compiled 2.6.15-rt2 on x86_64 SMP (dual Opteron) and it's giving
> a lot of weird instabilities. If I start jackd (this is an audio workstation)
> with realtime privileges from an xterm I get a lot of spurious xruns. When I
> first start it, moving the mouse makes the xruns scroll off the screen.
> That stops for a couple of minutes, during which there's a slow but
> steady stream of xruns. After two or three minutes the xruns suddenly
> scroll off the screen too quickly to read, and keep going until the jack
> watchdog timer kills jackd (the latter is usually caused by the two
> wordclock-locked sound cards losing sync with each other, which
> shouldn't happen). Sometimes X locks up shortly after this and it needs
> a hard reboot.
>
> None of the above happens with a non-rt kernel, and I've had the same
> thing with 2.6.15-rt1 and every 2.6.15-rcx-rtx kernel I tried.
>
> Here's an excerpt from dmesg that may shed some light on this:
>
> <snip>
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> Time: tsc clocksource has been installed.
> check_monotonic_clock: monotonic inconsistency detected!
> 	from         26cbf3ad (650900397) to         260079b7 (637565367).
> softirq-timer/1/13[CPU#1]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
>
> Call Trace:<ffffffff801361e2>{__WARN_ON+114} <ffffffff8015141d>{check_monotonic_clock+109}
>        <ffffffff80151cfc>{get_realtime_clock+92} <ffffffff8014eed1>{hrtimer_run_queues+49}
>        <ffffffff8013fc87>{run_timer_softirq+455} <ffffffff8013b4c0>{ksoftirqd+304}
>        <ffffffff8013b390>{ksoftirqd+0} <ffffffff8013b390>{ksoftirqd+0}
>        <ffffffff8014c009>{kthread+217} <ffffffff80131258>{schedule_tail+136}
>        <ffffffff8010f076>{child_rip+8} <ffffffff8014bf30>{kthread+0}
>        <ffffffff8010f06e>{child_rip+0}

Yep, this is a known issue, with the x86_64 SMP.  The timestamp counter
does not run in sync with each cpu, so the timing gets all screwed up.
If you want to fix this, boot with the command line option idle=poll.
But, unfortunately, this means that the cpu will waste energy even when
it's not doing anything.

I'm looking into ways to fix this for my main machine which is also a
x86_64 SMP.

-- Steve

