Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTIWQHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIWQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:07:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3334 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S261910AbTIWQHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:07:45 -0400
Date: Tue, 23 Sep 2003 18:06:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jan Evert van Grootheest <j.grootheest@euronext.nl>
Cc: Andrea Arcangeli <andrea@suse.de>, Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923160600.GA4161@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F706046.1000306@euronext.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[replying to both Jan and Andrea at once]

-- Jan:
> I think it is pretty senseless to have a configuation option for the 
> default size of that buffer. Especially if I can, in one of the first rc 
> scripts, do something like 'echo 128 > /proc/sys/kernel/printkbuffer'.
> The only hard requirement for that default size is that all output up 
> till that rc script fits into a buffer of that size.

I totally agree with this possibility, and it's one I proposed too. I only
proposed to keep the default size in order to be able to catch all boot
messages, but I think that if we make this buffer hot-resizable (and a sysctl
is good for this), then we could systematically pre-allocate 64k at boot which
should be enough for boot messages (16k is too short), and could be reduced
if needed by a write to the sysctl. This way, the config option can go away.

> And yes, I do care about that static 64K buffer. I still have an old 
> pentium that only has 16M. Every byte counts!

My previous firewall add 8M, and I second your statement : every byte counts !

> Andrea Arcangeli wrote:
> >>You're only thinking about what distro vendors should do. If all kernels 
> >>should
> >>suit their needs, then there would not be any config anymore, and everyone
> >>would have the same kernel with the same wagon of command line arguments.
> >
> >
> >this is actually not true. Many options are way too costly to recompile
> >every time, or to keep enabled at runtime, it can't be the case for this
> >one. My own self compiled kernel has a very stripped down .config, it's
> >not like a distro kernel with everything included.

I think you're mistaken about what I meant. I didn't mean that I want to
recompile each kernel with a different option, I meant that for a large set
of identical systems, it's more convenient to have a single, stripped down
.config with the most default values, and propagate this same kernel everywhere,
than having to duplicate special kernel parameters in every lilo.conf.

> >the 64k are wasted only when you use the option, if you need more than
> >64k it's unlikely you care about 64k lost.

Absolutely, my concern was most about the case where I need less than 64k and
I have too few memory to agree to waste them.

> > But I'm ok to fix it, it just
> >looks a low priority to fix. Also since you will never use this option
> >anyways since you don't like adding parameters to the kernel, then you
> >don't care about fixing it either, you simply want the additional config
> >option on top of this.

:-)
Andrea, I'm not *that* selfish ! If I did this only for me, I wouldn't even
post it here and risk complaints from people who ask me to add other archs
too. I can live with this as a patch in my kernel, next to your VM and others.
It's just that I felt a need for it on production machines and thought there
were potentially other people in my case. In the same way, I could say that
you're wrong in believing that everyone wants to add a boot option, but I may
be wrong WRT this. That's not the problem. If I asked how to fix it, it's
because I'm interested in doing it myself, but I'm clueless about how to do it
(don't know how to allocate boot mem, don't know how to free it, don't know
if I can reallocate new mem further and free it again by the same means).

> >My whole argument is that being able to do it dynamic is an order of
> >magnitude more important than being able to do it statically, no matter
> >the command line argument and no matter ther 64k lost. You must agree
> >with that. the amount of userbase is just not comparable.

I said I did agree with that, but it's not the same feature. And concerning
the amount of userbase, I agree it's not comparable... I don't imagine desktop
users adding "logbuflen=1048576" to their boot command line, nor can I imagine
them recompiling their kernel changing this option.

> >Not sure what I should do, personally I consider the additional .config
> >option as configuration pollution, but since you care that much I can
> >also change my patch not to reject yours, and to allow the two things to
> >coexist, but I don't think it's really needed. I believe people should
> >be forced to use the kernel params,
^^^^^^^^^^^^^^^^^^^
why do you want to force people to do something the way you think is best ?
I personnaly think that both solutions are a convenient way of achieving the
same goal for different people. Please let them choose.

> >just a mess if each kernel with the same revision number behaves
> >differently, everything becomes less and less predictable.

nothing new here. There are already many options which will make your kernel
behave differently : CPU/ACPI/APM/SCSI/IDE DMA by default/Shutdown Watchdog on
close, to name a few... That's why many of us add a version suffix to
production kernels identifying a known .config.


> >The number of  System.map checks increases and increases before I can
> >identify what kernel is that.

Then don't rely on the default value for your kernels, but only on the boot
option, and the problem is gone. Let us all have the choice. I insist that
your patch is appealing, but it is not the only solution and does not cover
all needs, nor does mine.

Cheers,
Willy


