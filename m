Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTBJRrY>; Mon, 10 Feb 2003 12:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTBJRrY>; Mon, 10 Feb 2003 12:47:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46679 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261934AbTBJRrV>; Mon, 10 Feb 2003 12:47:21 -0500
To: suparna@in.ibm.com
Cc: Corey Minyard <cminyard@mvista.com>, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210174243.B11250@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Feb 2003 10:56:43 -0700
In-Reply-To: <20030210174243.B11250@in.ibm.com>
Message-ID: <m18ywoyq78.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Sun, Feb 09, 2003 at 11:39:27AM -0700, Eric W. Biederman wrote:
> > Corey Minyard <cminyard@mvista.com> writes:
> > 
> > With respect to DMA and SMP handling for kexec on panic that case is
> > much trickier.  A lot of the normal methods simply don't apply because
> > by definition in a panic something is broken, and that something may
> > be the code we need to cleanly shutdown the hardware.  But I an not
> > ready to sacrifice a method that works well in a properly working
> > kernel just because the panic case can't use it.
> > 
> > In getting it working I suggest we start with the easy cases, where
> > DMA and SMP are not big issues.  And then we can have a working
> > framework.
> 
> I'd agree. That was also the idea behind the patch we'd just posted 
> for LKCD. With a basic working framework in hand that works for 
> simpler cases, we can now keep working on addressing more and harder 
> situations bit by bit.

Agreed.  I guess the primary question is can we trust the current
device shutdown + reboot notifier path or do we need to make some
large changes to avoid it.

> Are you trying to address the possibility that DMA is overwriting
> memory we are using in the recovery code, due to a runaway driver
> or other code passing a wrong memory address to a device (e.g. in 
> a corrupted command area) ?

Not primarily.  Instead I am trying to address the possibility that
DMA is overwriting the recovery code due to a device not being shutdown
properly.  Though it would happen to cover many cases of the wrong
memory address being passed to a device.

> I'm wondering if just reserving 
> an area of memory would help. As long as the address is visible/
> accessible by the device (i.e. unless we have the h/w support to
> apply protection at that level), can we really be safe in those
> weird or rare cases ?  Disabling the bus-master sounds like a
> more dependable option for that (via device shutdown or reboot 
> notifiers as suitable) if it can be done.

Basically using a reserved area of memory is an alternative to 
device shutdown or calling the reboot notifiers.  If the device shutdown
code is reliable enough we can go with that...

The other piece that a reserved area of memory is that you can
simplify the other cases because you don't need to do anything
before the dump because everything is preserved.

> Placing the recovery code in a safe reserved area (that the
> running kernel may not know about or may be protected),
> may reduce the possibility of the panic/buggy kernel overwriting 
> it, but will it help the DMA case ?

Yes, for the same reasons.   I am definitely not trying to address the
case of buggy hardware.

> > The one piece I don't know about is how to prioritize which pieces of
> > memory are written out first.  It is certainly a desirable feature
> > but do we need that, if we can preserve everything?  Or is it easy
> > enough to get the prioritizing information that we don't care.
> 
> LKCD has support for doing that - it provides for specifying dump
> levels, to dump just a header, kernel pages, all in-use pages and
> full-memory.  This can be tuned/extended for some more intermediate
> levels (e.g. header + stack traces for all cpus). 

And that is why I though of it.   I need to review how that portion
of the code is done.  The one downside of the simplifications that
come with a reserved area of memory is they make knowing the set of
kernel allocations a challenge.

However in most cases all in-use pages ~= full-memory.  
And the kernel pages can be computed statically.  For more
I guess it would be necessary to pass information regarding
the current kernels data structures for tracking free memory
to the dumper.  So the functionality does not need to be lost,
but providing it becomes a different problem.

> There is also some work-in-progress code for more granular 
> dump customisation as a future item.
> 
> While the patch I'd posted has been designed so that ideally 
> it should be possible to preserve everything, I'm still not 
> certain if the compression we get is good enough for all cases 
> (e.g a heavily loaded system with lots of non-redundant data) 
> -- we really need to play around with the implementation and 
> tune it. 

And I am certain that with a preserved memory area we can
preserve everything without compression.

> Secondly, for a large memory system, it could take a 
> bit of time to compress all pages, and we might just want to 
> dump potentially more relevant data (e.g kernel pages) for 
> some kind of problems. It was easy enough to do this with some 
> simple heuristics like dumping inuse pages which are nonlru.

I see.  So you are definitely have some interesting heuristics
to pick which pages to dump.  I hate to break that but..

Eric
