Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUGMWJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUGMWJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266907AbUGMWJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:09:35 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:29193 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266919AbUGMWJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:09:10 -0400
Date: Tue, 13 Jul 2004 15:08:38 -0700
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>,
       "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       Paul Davis <paul@linuxaudiosystems.com>, florin@sgi.com,
       linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought?
Message-ID: <20040713220838.GA22781@nietzsche.lynx.com>
References: <20040712172458.2659db52.akpm@osdl.org> <008501c468d2$405d8c70$161b14ac@boromir> <20040713191224.GA22237@nietzsche.lynx.com> <006901c4692b$074996f0$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006901c4692b$074996f0$161b14ac@boromir>
User-Agent: Mutt/1.5.6+20040523i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:44:59PM +0100, Martijn Sipkema wrote:
[...]
> The worst case latency is the one that counts and that is the contended case. If
> you could guarantee no contention then the worst case latency would be the
> very fast uncontended case, but I doubt there are many (any?) examples of this in
> practice. There are valid uses of mutexes with priority inheritance/ceiling protocol;
> the poeple making the POSIX standard aren't stupid...

There are cases where you have to use priority inheritance, but the schemes that are
typically used either have a kind of exhaustive analysis backing it or uses a simple
late detection scheme. In a general purpose OS, the latter is useful for various kind
of overload cases. But if your system is constantly using that specific case, then it's
a sign the contention in the kernel must *also* be a problem under SMP conditions. The
constant use of priority inheritance overloads the scheduler, puts pressure on the
cache and other negative things that hurt CPU local performance of the system.

The reason why I mention this is because of Linux's hand-crafted nature of dealing
with this. These are basically contention problems expressed in a different manner.
The traditional Linux method is the correct method of deal with this in a general
purpose OS. This also applies to application structure as well. The use of these
mechanisms need to be thought out before application.

> > > It is often heard in the Linux audio community that mutexes are not realtime
> > > safe and a lock-free ringbuffer should be used instead. Using such a lock-free
> > > ringbuffer requires non-standard atomic integer operations and does not
> > > guarantee memory synchronization (and should probably not perform
> > > significantly better than a decent mutex implementation) and is thus not
> > > portable.
> > 
> > It's to decouple the system from various time related problems with jitter.
> > It's critical to use this since the nature of Linus is so temporally coarse
> > that these techniques must be used to "smooth" over latency problems in the
> > Linux kernel.

> Either use mutexes or POSIX message queues... the latter also are not
> intended for realtime use under Linux (though they are meant for it in
> POSIX), since they don't allocate memory on creation.
 
The nature these kind of applications push into a very demanding space where
typical methodologies surrounding the use of threads goes out the window. Pushing
both the IO and CPU resources of a kernel is the common case and often you have to
roll your own APIs, synchronization mechanisms to deal with these problem. Simple
Posix API and traditional mutexes are a bit too narrow in scope to solve these
cross system concurrency problems. It's not trivial stuff at all and can span
from loosely to tightly coupled systems, yes, all for pro-audio/video.

Posix and friends in these cases simply aren't good enough to cut it.

> > I personally would love to see these audio applications run on a first-class
> > basis under Linux. Unfortunately, that won't happen until it gets near real
> > time support prevasively through the kernel just like in SGI's IRIX. Multimedia
> > applications really need to be under a hard real time system with special
> > scheduler support so that CPU resources, IO channels can be throttled.
> > 
> > The techniques Linux media folks are using now are basically a coarse hack
> > to get things basically working. This won't change unless some fundamental
> > concurrency issues (moving to a preemptive kernel with interrupt threads, etc..)
> > change in Linux. Scattering preemption points manually over 2.6 is starting to
> > look unmanable from all of the stack traces I've been reading in these latency
> > related threads.
> 
> Improving the mutex and mqueue implementations to better support realtime
> use would be a significant improvement I think, making Linux quite suitable
> for realtime audio use.

Yes and no. This really all really needs to be hard real time in the long run.
With things like Tivo and other embedded application putting high demand on kernel
resources this kind of stuff needs to go into the Linux kernel sooner rather than
later so that Linux can keep up with current industry tracks.

That's my two cents. :)

bill

