Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263350AbVBDCAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbVBDCAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVBDB4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:56:30 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:46793 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263188AbVBDBwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:52:06 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
In-Reply-To: <20050201201402.GA31930@elte.hu>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu>  <20050201201402.GA31930@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 03 Feb 2005 20:51:48 -0500
Message-Id: <1107481908.27584.448.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 21:14 +0100, Ingo Molnar wrote:
> i have released the -V0.7.37-02 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> the big change in the patch is increased architecture support: most
> notable i've merged the MIPS patch from Manish Lachwani. Also, the x64
> port should be working again. (To make architecture merges easier in the
> future the timer interrupt is not threaded anymore - if this shows
> latency problems then we'll try to solve it on other ways.)

Ingo, 

I was just about to send you a note about why the timer interrupt as a
thread was a problem, but you changed it here, so it really isn't
anymore. But since your reason is for architecture, and not for this
reason, I'm posting it anyway.

Here was what I was about to send:

I was wondering why the timer interrupt is a thread, because this can
cause some unexpected results.

Say if you have two high priority processes A and B. A is higher than B
and both are higher than the timer interrupt (I'm on x86 so it's IRQ0)

B is doing lots of busy work, and A does a little then sleeps a little.

This is what is happening.  Once A sleeps, B goes off doing lots of busy
work, and A doesn't wake up until B is done, although A had a timeout,
that it missed.

What's going on is that the jiffies are not incrementing.  After the
first time that IRQ 0 goes goes off, the interrupt is disabled. So we
don't get any more interrupts for the timer, and B gets to run as much
as it wants leaving A in the dust.

So my question to you is why even bother having the timer interrupt as
thread.  Maybe make a tasklet or something to do more of it's work, but
let the interrupt go off as much as it wants. Otherwise, you can have
the problem mentioned above. If the fix to this is to either change the
timer interrupt to either NODELAY or just have the processes lower in
priority than the timer, then what's the point to having the timer as a
thread?


OK that was the note I was about to send, but like I stated, it isn't a
problem now that the timer interrupt is back to a hard interrupt. I just
showing this to you so you can see the real problem.  Maybe I'm missing
something, and maybe I'm not. I'll try to write up something that shows
the problem with the timer interrupt as a thread.

Thanks,

-- Steve


