Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVE0Xc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVE0Xc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVE0Xc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:32:56 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:6160 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262659AbVE0XcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:32:10 -0400
Date: Fri, 27 May 2005 16:36:45 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527233645.GA2283@nietzsche.lynx.com>
References: <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429715DE.6030008@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 10:43:10PM +1000, Nick Piggin wrote:
> Yes I did see that post of yours, but I didn't really understand the
> explaination. (I hope I don't quote you out of context, please correct
> me if so).
> 
> I don't see why you would have problems crossing kernel "concurrency
> domains" with the nanokernel approach. Presumably your hard-RT guest
> kernel or its tasks aren't going to go to the Linux image in order
> to satisfy a hard RT request.

The typical work being done in dual kernel scenarios involves moving
"all things needing RT" into the host RT kernel's domain. You use the
host kernel's threading APIs, etc... Graphics drivers and drivers of
all types need to be retargetted to the host kernel. You do this for
all drivers where you have an RT interest.

This kind of work removes it from running within the Linux guest image.
So now you have a situation where you have to use the host kernel's
APIs for application development or RT guarantees can't be met.

Think about X11, all of it. Is X11 something you want to run in the
host kernel's domain ? What is that going to entail ? What do you do
when you have multipule graphics output devices and need to respond
to vertical trace interrupts ? Move all of the kernel support drivers
into the host domain ?

That's a bit rough. You're stuck with programming in one domain and
there's not possibility of directly "getting at" lower level drivers,
special RT sockets, etc... because all of these subsystems have to
be retargetted towards the RT host domain. There's a very big API
program barrier to how you might want to write a common application
to take advantage of hard RT constraints.

It's tricky. You have to cross into the Linux image using some kind
message queue system an effectively marshall requests back and forth.
Getting at known syscalls is probably ok in that you can use a library
to link and some loader trickery to offload the development costs.

Now think about this. You're a single kernel engineer. You don't have
the resources to make every kernel subsystems hard RT capable. You
have this idea where you'd like get at SGI's XFS's homogenous object
storage to stream video data with guaranteed IO rates. This needs to
be running in an RT domain so that guarantees can be tightly controlled
since you're running an app that doing multipule file streaming of
those objects. What kernel subsystems does this include ?

It includes the VFS system, parts of the VM, all of the IO subsystems
including SCSI/IDE and IO schedulers, etc..., the softirq subsystem
supporting the SCSI layers and IO schedulers, all the parts of XFS
itself. The list goes on.

Think about making that entire chain of subsystems available under RT
control in a dual kernel system where you have a thick boundary
marshalling this access ? You'd have to port much of the kernel into
that host RT domain to even consider getting any kind of control over
XFS. That's massive.

A single image kernel isn't going to solve all of the contention
issue regarding locking, but it's obviously much easier to work with
and there's a much higher probability to make that entire kernel path
work with respect to thread priority. This is because it's possible
to reengineer those path to be lock-free if you so choose, etc... so
that the request is processed and submitted to an IO request queue
directly.

The system can be broken down into finer parts and access to all parts
of it in that chain is direct, linear even, without having to worry
about a decoupling layer in dual kernel system. Dual kernels might be
lock-free, but the submission of messages is still a synchronization
point. It's not a mutex, but it's still a concurrent structure that
protects the thread from the system it's calling at the moment. The
queuing, system to system partitioning, itself doesn't fix the long
execution paths of the Linux kernel image or contention within that
guest kernel.

Think of this in terms of how a wider scoped project regarding
concurrency would be overly complicated by a dual kernel system like
that. If you think about it, then you'll realize that a single kernel
image is much better if you're going down a more sophisticated road
like that.

This is just the kernel. What if you wanted to, say, export a real time
TCP/IP socket to a userspace RT app ? what's the subsystem call chain
there ? Say you want to do this within an X11 application talking to
ALSA devices ? Obviously the dual kernel model is going to break down
very shortly after the set of requirements are known and submitted.
Single image systems are clearly superior in that regard even with
the existing lock structure adding indeterminancy via priority
inheritance.

It's not just latency alone that's the issue. It's the application
programming domain that really the problem and how the needs of that
app it projects itself across the entire kernel and all supporting
subsystems. It's a large scale software design argument that drives
this track for me and it's how I think it should be viewed.

Super hard RT latencies are obivously going to not call into the
kernel for non-deterministic operations. These are more typical of
traditional RT applications. If they are properly written, then
they should run similarly to hard RT systems if you scope out a set
of priority for them to run in above the interactive priorities and
the overall system.

> Also, you said "I have to think about things like dcache_lock, route
> tables, access to various IO system like SCSI and TCP/IP, etc...",
> but at first glance, those locks and structures are exactly why you
> wouldn't want to do hard-rt work along side general purpose work in
> the Linux kernel.
> 
> And quite how they would interfere with the hard-rt guest, you didn't
> make clear.
> 
> "A single system image makes access to this direct unlike dual kernel
> system where you need some kind of communication coupling. Resource
> access is direct."
> 
> ... but you still need the locks, right?

... 

> >as a nanokernel. The scheduler paths are riddled with SMP rebalancing
> >stuff and the like which contributes to overall system latency. Remove
> >those things and replace it with things like direct CPU pining and you'll
> >start seeing those numbers collapse. There are also TLB issues, but there
> >are many way of reducing and stripping down this kernel to reach so called
> >nanokernel times. Nanokernel times are overidealized IMO. It's not
> >because of design necessarily, but because of implementation issues that
> >add more latency to the deterministic latency time constant.
> >
> 
> Is this one reason why a nanokernel is better, then? So you wouldn't
> have to worry about the SMP rebalancing, and TLB issues, and everything
> else in your Linux kernel?

... 

>From what I've seen, the Linux interrupt paths are about as optimized
as it gets. It seems that the SMP support and other things that make up
a general purpose system are what slow latency down, but it can be replaced
with other things that are less dependent on dynamic computations if
there's a need for it. Ingo has the last word on this track.

For most folks, anything below 20us has been referred to as "bragging
rights" by a cowork of mine here. The vast majority of apps don't really
need anything tigher. This isn't the case for all RT apps, but I still
think this is largely true.

Keep in mind this is not a complete system by far, so you have to keep
the current practical aspects out of what will be the finished product
in the future. There's a lot more to be done here.

> I'm not sure if you exactly answered my concerns in that thread
> (or I didn't understand). It would be great if you could help me
> out a bit here, because I feel I must be missing something here.

Was this better ? :) I'm blow a lot of development time writing up all
of these emails this week.

bill

