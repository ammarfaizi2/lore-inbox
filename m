Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUJLXTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUJLXTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJLXTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:19:07 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52640
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268059AbUJLXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:18:26 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Huey <bhuey@lnxw.com>
Cc: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>
In-Reply-To: <20041012223642.GB30966@nietzsche.lynx.com>
References: <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
	 <1097607049.9548.108.camel@dhcp153.mvista.com>
	 <1097610393.19549.69.camel@thomas>
	 <20041012211201.GA28590@nietzsche.lynx.com>
	 <1097618415.19549.190.camel@thomas>
	 <20041012223642.GB30966@nietzsche.lynx.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1097622634.19549.235.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 01:10:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 00:36, Bill Huey wrote:
> On Wed, Oct 13, 2004 at 12:00:16AM +0200, Thomas Gleixner wrote:
> > On Tue, 2004-10-12 at 23:12, Bill Huey wrote:
> > > My tree is stable. I was able to hammer this machine for 2-3 days straight
> > > (no networking, that's another major can of worms) with deadlocking
> > > using multipule mass "find / -exec egrep" of some sort that stress both
> > > process creation and all parts of the IO system.
> > 
> > He, a system without networking is a real measurement ? Ever heard of
> > hackbench in combination with ping -f ?
> 
> The problem with doing this project is to create an identically
> functioning system that's correct. The current track taking by Monta Vista
> is highly unstable given the lack of locking throughout their kernel. It
> has all of the complexities of mutex style conventions without any debugging
> methodology attached to it. It's no longer the spinlock universe that
> Linux is using since a deadlock situation just leaves use running in
> cpu_idle wondering what is going on.
> 
> It's something that needs to be address in the large scheme of the project.

Ack.

> > > That graph that I saw from Lee is consistent with my results in that a
> > > deadlock prone system will have phenomenal latency performance at the
> > > expense of being absolutely incorrect. It's just a flat out broken
> > > system at this point that they've released.
> > 
> > Thats a major problem caused by "dumb" priority inheritence. The goal is
> > not priority inheritence at the very end. It's proxy execution, where
> > priority inheritence is a subset.
> 
> This has been articulate a couple of times by both me and Ingo (recent email).
> The MV's system is highly unstable, not because of priority inheritance,
> but because of basic lock violation in the lock graph itself. It's another kind
> of SMP granularity problem. The hard problem was just what Ingo was saying and
> it's higher, but higher in the graph.

Can you point me a bit more clear on what you are talking about ?

> > > Yes, I agree, but the convention needs to be standardized.
> > 
> > That's all I was talking about.
> 
> Yeah, it needs to be done. I like the "_" methodology that both Monta Vista
> and Ingo are using. I'll convert my stuff over to using it when I'm finished
> with a couple of large items here.

That's totaly fucked up. Compile XFS with that and you are toast. That's
ugly and not understandable/fixable for anybody in the universe without
more ugly and less understandable hacks. Yes I managed to get XFS up,
but I refuse to show the patch, because it's making me barf when I look
into it.

_spinlock = spinlock
spinlock = mutex
_mutex = semaphore
semphore = whatever
....

That's violating every single aspect of software design. That's messing
up the whole kernel.

What have we at the very end ? A endless mess of non understandable
macros, which are resolved by compiler magic ? Where nobody can see on
the first look, which kind of concurrency control you are using ? That's
a nice thing to do some proof of concept implementation, but it can not
be a solution for something what is targeted to go into mainline. The
frequency of T4-T7 patches including the small fixes posted on LKML is
just a proof of this.

> > I'm not talking about automatic conversion of rules. I'm talking about
> > automatic conversion of different concurrency controls into a
> > equivillance function, which lets you better identify the neccecary
> > manual changes and leaves room for simple and non intrusive replacement
> > implementations.
> 
> This is kind of a sketchy problem. So far all of what I've seen really needs
> to be done manually and can be done using the all of the normal Linux locking
> and scheduler/interrupt masking primitives. I'd hate to see another system
> added to this that solves a problem that may not exist. Please, correct
> me if I'm not understanding you.

We have spinlocks, mutexes, semaphores and preemption as types of
concurrency control implementations in the kernel. They represent
different grades of access exclusion control.

But all of them have one in common. Exclusive access to resources.

So the natural consequence is to convert _all_ concurrency control
mechanisms into a single identifiable one. That's a purely semantical
conversion, in terms of macro replacement, where no functional change
takes place.

After you have done this, it is much more easier to 

a) identify the nested places, as you have to look for exactly one
pattern instead of N
b) to easy experiment with replacment functions 
c) to make clear which changes to the code you are making

substituting

enter_critical_section(SPIN_LOCK,....) by
enter_critical_section(XYZ_MUTEX,....) is
understandable for most of the people. 

Changing it by hidden gcc magic is not.

The bad thing of hidden gcc magic is that you will not be able to
analyse nested concurrency controls in one go. You have to figure out
what the heck spin_lock vs. _spin_lock vs. semaphore vs. _semaphore vs.
mutex vs. _mutex means.

So cleaning up the purely semantical (clear wording sense) way is the
first step to go instead of changing a bunch of macros over the place
and break the half of the kernel compile.

tglx













