Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVHUVVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVHUVVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHUVVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:21:05 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:25517 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751121AbVHUVVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:21:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=heuZxBsdwuiDlWmgJ41FbMRd7G+AR28FUQU6eDVpfBadviF0WVIYhcdDLr9o0NABfUNErjoZ6EE1/S/RNkoG5m8mS2ySwW9bDRcLZW4YfnuGHwMctauSGrmVYzXUjKnxz4K6OGAB0txMvoE2e7WcevRz/s9G+dnM4I04mmxEDE8=
Message-ID: <9a87484905082114215083f424@mail.gmail.com>
Date: Sun, 21 Aug 2005 23:21:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050821202141.78795.qmail@web33305.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a87484905082111205d27c1aa@mail.gmail.com>
	 <20050821202141.78795.qmail@web33305.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/05, Danial Thom <danial_thom@yahoo.com> wrote:
> 
> 
> --- Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> > On 8/21/05, Jesper Juhl <jesper.juhl@gmail.com>
> > wrote:
> > > On 8/21/05, Danial Thom
> > <danial_thom@yahoo.com> wrote:
> > > > >
> > > > Ok, well you'll have to explain this one:
> > > >
> > > > "Low latency comes at the cost of decreased
> > > > throughput - can't have both"
> > > >
> > > > Seems to be a bit backwards. Threading the
> > kernel
> > > > adds latency, so its the additional latency
> > in
> > > > the kernel that causes the drop in
> > throughput. Do
> > > > you mean that kernel performance has been
> > > > sacrificed in order to be able to service
> > other
> > > > threads more quickly, even when there are
> > no
> > > > other threads to be serviced?
> > > >
> > >
> > > Ok, let me start with the way HZ influences
> > things.
> > >
> > [snip]
> >
> > A small followup.
> >
> > I'm not saying that the value of HZ or your
> > preempt setting (whatever
> > it may be) is definately the cause of your
> > problem. All I'm saying is
> > that it might be a contributing factor, so it's
> > probably something
> > that's worth a little bit of time testing.
> >
> > In many cases people running a server on
> > resonably new hardware with
> > HZ=1000 and full preempt won't even notice, but
> > that's depending on
> > the load on the server and what jobs it has.
> > For some tasks it
> > matters, for some the differences in
> > performance is negligible.
> >
> > You problem could very well be something else
> > entirely, but try a
> > kernel build with PREEMPT_NONE and HZ=100 and
> > see if it makes a big
> > difference (or if that's your current config,
> > then try the opposite,
> > HZ=1000 and PREEMPT). If it does make a
> > difference, then that's a
> > valuable piece of information to report on the
> > list. If it turns out
> > it makes next to no difference at all, then
> > that as well is relevant
> > information as then people will know that HZ &
> > preempt is not the
> > cause and can focus on finding the problem
> > elsewhere.
> >
> Yes. Hz isn't going to make much difference on a
> 2.0Ghz opteron, but I can see how premption can
> cause packet loss. Shouldn't packet processing be
> the highest priority process? It seems pointless
> to "keep the audio buffers full" if you're
> dropping packets as a result.
> 
> Also some clown typing on the keyboard shouldn't
> cause packet loss. Trading network integrity for
> snappy responsiveness is a bad trade.
> 

Since you choose to reply to a public list on a private email I guess
I should post the bit I'd [snip]'d above, so everyone else can get the
whole picture  :

On 8/21/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 8/21/05, Danial Thom <danial_thom@yahoo.com> wrote:
> > >
> > Ok, well you'll have to explain this one:
> >
> > "Low latency comes at the cost of decreased
> > throughput - can't have both"
> >
> > Seems to be a bit backwards. Threading the kernel
> > adds latency, so its the additional latency in
> > the kernel that causes the drop in throughput. Do
> > you mean that kernel performance has been
> > sacrificed in order to be able to service other
> > threads more quickly, even when there are no
> > other threads to be serviced?
> >
> 
> Ok, let me start with the way HZ influences things.
> 
> The value of HZ was increased from 100 to 1000 in 2.6.x (and later
> made a config option so people can choose at compile time between 100,
> 250 & 1000).
> 
> This means that in 2.6 you have ten times as many timer interrupts
> happening every second compared to 2.4.  This is great for things that
> need to be served on short notice, like audio buffers that need to be
> filled *now* before the music skips and can't wait 10ms bacause the
> user will notice. But, all those interrupts add overhead and thus the
> total amount of work that can be done every second will be slightly
> lower even though response times are good.   For a desktop HZ=1000 is
> usually a very nice thing, but for a server that doesn't need good
> response times (low latency) HZ=100 or HZ=250 will provide better
> overall throughput and is often preferable.
> 
> It's more or less the same thing with kernel preemption. When the
> kernel is fully preemtible it means that kernel functions can be
> interrupted at (almost) any time if there happens to be a higher
> priority process/thread that is runnable. When the kernel is not
> preemtible, system calls etc always run to completion before being
> interrupted.
> 
> Preemption is great for interactive applications where you want user
> interfaces to respond fast, want multimedia applications to be able to
> refill buffers at regular intervals (with great precision on the
> timing) etc.  With preempt, such high applications will be able to
> interrupt/preempt other lower priority processes (like a background
> run of updatedb running from cron for example) even when those
> processes are in the middle of a system call, whereas without
> preemption they are forced to wait several milliseconds for the other
> apps syscall to complete before they can get a chance to run - which
> the user notices as sluggish gui response, music or video skips etc.
> 
> There are a few prices you pay for preemption.  1) extra overhead for
> bookkeeping (is it safe to preempt now, more locks need to be taken
> and dropped to make it safe etc).  2) preempted processes don't get to
> run for the entire duration of their timeslice in one go.  3) You get
> more context switch overhead - when the kernel has to switch between
> apps more often it needs to save and restore process context more
> often.
> All of this hurts overall throughput but gives you nice interactive
> response times (low latency).
> 
> So, you can't have both at once. You can't get maximum throughput at
> the same time as you get very low response times. It's one or the
> other depending on your need.
> 
> With 2.4 you have HZ=100, no preemption. So there you have a kernel
> optimized for maximum throughput, but latencies are high which is a
> pain for interactive and multimedia apps.
> 
> With 2.6, the default is HZ=1000 and preempt = PREEMPT_NONE  which is
> a compromise.
> But luckily you can modify the default.  As I already mentioned above,
> you can pick between HZ=100, 250 & 1000 these days, and the preemtion
> model gives you 3 choices :
> 
> PREEMPT_NONE - No Forced Preemption (Server)
> PREEMPT_VOLUNTARY - Voluntary Kernel Preemption (Desktop)
> PREEMPT - Preemptible Kernel (Low-Latency Desktop)
> 
> So you are free to mix and match to get the kernel behaviour that
> suits you best for any given task.
> 
> Personally I run (most) my servers with HZ=100 and PREEMPT_NONE
> and my personal desktop at home has HZ=1000 and PREEMPT.
> 
> 
> Did that make things a little more clear?
> 
> 


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
