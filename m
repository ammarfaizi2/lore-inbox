Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWAAS5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWAAS5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWAAS5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:57:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932232AbWAAS5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:57:00 -0500
Date: Sun, 1 Jan 2006 10:56:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
In-Reply-To: <1136094372.7005.19.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org>
References: <20051229202848.GC29546@elte.hu>  <1135908980.4568.10.camel@mindpipe>
 <20051230080032.GA26152@elte.hu>  <1135990270.31111.46.camel@mindpipe> 
 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>  <1135991732.31111.57.camel@mindpipe>
  <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>  <1136001615.3050.5.camel@mindpipe>
 <20051231042902.GA3428@us.ibm.com>  <1136004855.3050.8.camel@mindpipe> 
 <20051231201426.GD5124@us.ibm.com> <1136094372.7005.19.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Jan 2006, Lee Revell wrote:
> 
> In fact neither of these patches helps, because these RCU callbacks run
> from a tasklet in softirq context, and softirqs are not preemptible
> (unless they are running in threads, see below):

That wasn't why I was hoping they would help..

The actual RCU callback will run uninterruptible, but I was hoping that 
the patch would make it be called more often, and not have thousands of 
events to work on...

> Linus, would you accept CONFIG_PREEMPT_SOFTIRQS to always run softirqs
> in threads (default N of course, it certainly has a slight throughput
> cost) for mainline if Ingo were to submit it?

Actually, I think there's a better solution.

Try just setting maxbatch back to 10 in kernel/rcupdate.c.

The thing is, "maxbatch" doesn't actually _work_ because what happens is 
that the tasklet will continually re-schedule itself, and the caller will 
keep calling it. So maxbatch is actually broken.

However, what happens is that after kernel/softirq.c has called the 
tasklet ten times, and it is still pending, it will do the softirq in a 
thread (see the "max_restart" logic).

Which happens to do the right thing, although I'm pretty convinced that it 
was by mistake (or if on purpose, it depends way too closely on silly 
magic implementation issues).

I raised maxbatch because the dentry RCU problem (since fixed) was 
reported to become less (probably because the scheduling of the softirq's 
delayed the freeing of old dentries further, making the problem worse), 
and because I don't like the subtlety involved in having two layers of 
batching. But hey, it might work, at which point we should just document 
how maxbatch and max_restart interact with each other and with softirqd.

		Linus
