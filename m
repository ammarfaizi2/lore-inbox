Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWINTgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWINTgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWINTga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:36:30 -0400
Received: from web31515.mail.mud.yahoo.com ([68.142.198.144]:21335 "HELO
	web31515.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751076AbWINTga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:36:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x0nRMrc3LCQcMjjMdhnSX0bbtMuMadXJKbGz09oQJQWUJOK8J/CG0EB4uwJXbRq6NRDB0bLai2OG4/FUy6hicqacb0pvR2cZTtI6AzYJXjcn6kaGE1PqTKYJ41aiFv535aDmv60UJqO8uWct2YXk2VTb2utTOmMTbWER0IlrpGA=  ;
Message-ID: <20060914193624.41856.qmail@web31515.mail.mud.yahoo.com>
Date: Thu, 14 Sep 2006 12:36:24 -0700 (PDT)
From: Jonathan Day <imipak@yahoo.com>
Subject: Re: Sharing memory between kernelspace and userspace
To: ray-gmail@madrabbit.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2c0942db0609141105q63883747sc1f40c1a33ffce3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for some absolutely wonderful suggestions.

--- Ray Lee <madrabbit@gmail.com> wrote:

> On 9/13/06, Jonathan Day <imipak@yahoo.com> wrote:
> > 1. I need a kernel driver to be able to allocate
> and
> > deallocate, on a totally dynamic basis, userspace
> > memory that is reachable by multiple applications.
> 
> Is there no possible way you can do the memory
> allocation fully in
> userspace? Let userspace allocate shared memory
> visible to multiple
> processes, and pass that into the kernel for it to
> write to.

I guess I could - I'd need a userspace program that
was guaranteed to be running to handle the memory
management, but that's really no different than any of
the other daemons.

> If this is as high-speed as you imply, then you
> *really* don't want to
> be doing this on the fly (let alone from inside the
> kernel). All the
> high-bandwidth stuff I've worked on preallocated its
> buffers, as later
> on in the processing there are no hard guarantees as
> to either how
> much memory one can acquire *or* how long it will
> take to do so.
> Either one of those is a deal-breaker when dealing
> with fast data
> rates.

You are absolutely right and preallocation is
definitely best. The problem lies in not knowing how
much to pre-allocate, which either means using
discontiguous chunks of memory or lots of copying -
neither of which is good.

One hack-around I played with was to go right ahead
and pre-allocate reasonable fixed-sized buffers, which
would be physically discontiguous, and then massage
the virtual memory tables so that anything outside of
the kernel would see a single, continuous block.
(Massaging an index is much faster than manipulating
data.) As far as I can tell, though, the VMM is simply
not designed for Evil Geeks to go re-organizing the
virtual layout in any kind of sane way.

An alternative would be to have a generic
pre-allocated dumping zone, where anything larger than
the zone would get space allocated on-the-fly, but
where initial data would be dumped as normal (giving
the kernel time to do the allocation) and copied into
the start of the final buffer in the CPU's spare time.

Beyond that, I'm stumped for ideas.

> > 3. I would truly value some suggestions on which
> of
> > the many ways of communicating with the kernel
> would
> > offer the best way to handle a truly horrible
> number
> > of very simple signals. Speed, here, is an
> absolute
> > must. According to my boss, residual sanity on my
> part
> > is not.
> 
> Just send a message down an fd? The
> wakeup/context-switch is the
> expensive part of that, I think, at least when
> dealing with only a few
> dozen fds. Or change it to be level- rather than
> edge-triggered, to
> coalesce the horrific number of events getting
> crammed down the
> processing side.

Good ideas.

> It sounds like this is the cheapest part of the
> process, so not worth
> the effort of optimizing it as much as finding
> better ways to do the
> rest of it.

I would concur completely with that.

> > I'm having what is probably the world's
> second-dumbest
> > problem. What I want to do is have a driver in
> > kernelspace be able to allocate multiple chunks of
> > memory that can be shared with userspace without
> > having to do copies.
> 
> Have userspace ask the driver if anyone has
> allocated it yet, if not,
> userspace allocates it and hands the pointer to it
> back to the driver
> so that it can hand it back out to the other calling
> processes who
> also want to subscribe to that data stream.

As good as done. That's going to be relatively easy to
implement.

> If another userspace process races with the first
> trying to ask if a
> buffer is available (first asked already, but hasn't
> yet given the
> driver the info), then the driver puts the second
> process to sleep
> until it's ready to hand back the buffer.

Ok. That should be doable. All requestees would need
to be slept, as the time to malloc is unknown. The
driver, on getting the data back, would need to finish
any sleepifying it was doing before jumping to the
unsleep    & deliver.

> > There are several problems, however, that make
> this
> > nasty. First, since the time before the kernel
> driver
> > or user application can start (and therefore
> finish)
> > processing a block of data is non-deterministic
> and
> > there is a requirement the mechanism be as close
> to
> > non-blocking as possible, so I need to be able to
> > create and destroy chunks entirely on-the-fly with
> the
> > least risk of either the driver or the application
> > ending up with unexpectedly invalid pointers.
> 
> Creating chunks on the fly is, I think, an operation
> that can take an
> arbitrary amount of time. If you *really* want to do
> that, you should
> instead just allocate as much as possible in the
> first place, and then
> you do your own memory management on blocks inside
> of that, never
> invoking the kernel's memory services after the
> initial allocation.

You covered a few possibilities earlier and I've added
a few to the list, so I think we can eliminate the
kernel memory allocation. Which is a BIG relief.

> > The second problem is that the interface between
> > kernelspace and userspace is handling messages
> rather
> > than packets, so I've absolutely no idea in
> advance
> > how big a chunk is going to be. That is only known
> > just prior to the data being put in the chunk
> > allocated for it. Messages can be big (the specs
> > require the ability to send a message up to 2Gb in
> > size) which - if I'm reading the docs correctly -
> > means I can't create the chunks in kernelspace.
> 
> Surely this is just an issue of writing the chunk to
> free memory?
> Either you have the memory available or you don't.
> If you do, no
> problem. If you don't, then you're screwed
> regardless, as allocating
> on the fly is not guaranteed to help you out.

It's all down to how fast free memory can be reserved,
how to avoid blocking small messages when a large
message is inbound but takes excessive time to
deliver, and how to minimise memory fragmentation.

There are going to be options which - to someone less
experienced in the heavy fine-tuning like myself -
would seem inefficient but which (in practice) provide
overall much better performance than alternatives.
Further, in a parallel architecture, what is efficient
at one scale may or may not be at another.

Thanks for your help - it is greatly appreciated - and
please feel free to forward any other thoughts you
might have.

Jonathan Day

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
