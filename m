Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266060AbUAFBPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbUAFBPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:15:19 -0500
Received: from smtp4.hy.skanova.net ([195.67.199.133]:64487 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S266060AbUAFBNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:13:32 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	<200401041242.47410.kernel@kolivas.org>
	<slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>
	<200401041658.57796.kernel@kolivas.org>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jan 2004 02:09:56 +0100
In-Reply-To: <200401041658.57796.kernel@kolivas.org>
Message-ID: <m2ptdxq3vf.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> On Sun, 4 Jan 2004 14:32, Tim Connors wrote:
> > > Not quite. The scheduler retains high priority for X for longer so it's
> > > no new dynamic adjustment of any sort, just better cpu usage by X (which
> > > is why it's smoother now at nice 0 than previously).
> > >
> > > > If either the scheduler or xterm was a bit smarter or
> > > > used different thresholds, the problem would go away. It would also
> > > > explain why there are people who cannot reproduce it. Perhaps a
> > > > somewhat faster or slower system makes the problem go away. Honnestly,
> > > > it's the first time that I notice that my xterms are jump-scrolling, it
> > > > was so much fluid anyway.
> > >
> > > Very thorough but not a scheduler problem as far as I'm concerned. Can
> > > you not disable smooth scrolling and force jump scrolling?
> >
> > AFAIK the definition of jump scrolling is that if xterm is falling
> > behind, it jumps. Jump scrolling is enabled by default.
> >
> > What this slowness means is that xterm is getting CPU at just the
> > right moments that it isn't falling behind, so it doesn't jump - which
> > means X gets all the CPU to redraw, which means your ls/dmesg anything
> > else that reads from disk[1] doesn't get any CPU.
> >
> > Xterm is already functioning as designed - you can't force jump
> > scrolling to jump more - it is at the mercy of how it gets
> > scheduled. If there is nothing more in the pipe to draw, it has to
> > draw.
> >
> > These bloody interactive changes to make X more responsive are at the
> > expense of anything that does *real* work.
> 
> Harsh words considering it is the timing sensitive nature of xterm that relies 
> on X running out of steam in the old scheduler design to appear smooth.

But the scheduler is also far from fair in this situation. If I run

        perl -e 'for(;;){printf("ddddddddddddddddddddddddddd\n");}'

in an xterm, the system enters a steady state where top shows:

Cpu(s): 78.3% us, 20.9% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.9% si
Mem:     61660k total,    60544k used,     1116k free,     4568k buffers
Swap:   104824k total,    22064k used,    82760k free,    17596k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2562 root      15   0 17284 7088 7664 S 39.2 11.5   3:21.20 X
 2755 petero    15   0  5652 3260 4528 S 31.7  5.3   1:53.89 xterm
 2808 petero    25   0  3424 1248 2744 R  3.9  2.0   0:01.71 perl
 2807 petero    16   0  1764  940 1636 R  1.6  1.5   0:00.87 top

What happens is that X and xterm start with highest possible
interactivity credit and CURRENT_BONUS, because they were mostly idle
before the test started. The perl program starts at some PR>15 and
slowly climbs to 25. Its interactivity credit remains at 0. As soon as
the perl process delivers one line of output to xterm, xterm and later
X are scheduled, because they have a smaller priority value than
perl. When they have finished scrolling one line, perl is scheduled
again and produces another line of output.

However, since X and xterm both have HIGH_CREDIT and CURRENT_BONUS ==
MAX_BONUS, they only get charged 1/10th of their runtime, because of
this code in schedule():

	if (HIGH_CREDIT(prev))
		run_time /= (CURRENT_BONUS(prev) ? : 1);

Since both processes spend approximately 50% of their time sleeping,
the sleep_avg increase in recalc_task_prio() is more than enough to
keep the processes at maximum interactivity level forever.

The situation for the perl process is that it always loses the cpu a
short time before it would voluntarily go to sleep. The perl process
gets approximately 4% cpu, but it wants 4+epsilon percent cpu, so it
is considered a cpu hog, and eventually gets maximum punishment
(PR=25).

The end result is that the perl process, which requires very little
cpu time, is considered a cpu hog, and the two real cpu hogs (X and
xterm) are considered interactive. This is not a transient state. The
situation does not go away until I kill the perl process or start some
other cpu hog to disturb the scheduler.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
