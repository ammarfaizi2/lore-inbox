Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGZJJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGZJJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGZJJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:09:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7041 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265082AbUGZJJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:09:02 -0400
Subject: Re: preempt timing violations
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040726085002.GA25519@elte.hu>
References: <1090813907.6936.56.camel@mindpipe>
	 <20040726085002.GA25519@elte.hu>
Content-Type: text/plain
Message-Id: <1090832953.6936.114.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 05:09:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 04:50, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Latency with 2.6.8-rc2 + voluntary-preempt-I4 is the best so far. 
> > After extended testing there only seem to be a few hot spots.  In
> > several minutes I saw an 11ms violation, a 14ms violation, and several
> > 2ms violations.
> > 
> > get_user_pages() is much better in 2.6.8-rc1-mm1 than 2.6.8-rc2.  Is
> > there any chance of getting the fix into mainline?
> 
> in -J3 i've added a cond_resched to the latency-generating point of
> get_user_pages(). (The biggest latencies happen via
> make_pages_present(), which gets triggered by mlockall()/MAP_LOCKED.)
> 

OK, great, this is the biggest remaing issue with -I4, because jackd
does that a lot.

> > 2ms non-preemptible critical section violated 1 ms preempt threshold
> > starting at unmap_vmas+0x1ff/0x210 and ending at
> > unmap_vmas+0x1f5/0x210
> 
> this is the normal sys_exit()->exit_mmap()->unmap_vmas() path. It's
> weird that it generated a 2ms latency. What are the values of
> voluntary_preemption and kernel_preemption on your current kernel? With
> a 2:0 setting we ought to have a reschedule point every 32 pages.  Do
> you know which application triggers this latency and is it easy to
> reproduce?
> 

2 and 1.  Now that I think about it, this could have happened during
bootup, before my rc.local set these.  I will try passing them on the
kernel command line. 

Not sure I understand the difference between 2:1 and 2:0.   Would the
latter make the kernel only preemptible at the voluntary preemption
points?

> > 14ms non-preemptible critical section violated 1 ms preempt threshold 
> > starting at tty_write+0x1b6/0x290 and ending at schedule+0x2fd/0x5b0
> 
> does this one trigger when you are using the VGA console? (or fbcon)?
> 
> it's not immediately obvious to me precisely where this latency comes
> from, it would be nice to know how to reproduce it.

It think this one was caused by switching virtual consoles.  At one
point Andrew Morton suggested I remove the (un)lock_kernel calls from
do_tty_write.  This fixed the problem, with no detectable side effects. 
Maybe this could be incorporated into voluntary-preempt, it would be
useful to have more than one person to test it.

Lee

