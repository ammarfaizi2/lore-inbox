Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVJaTRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVJaTRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJaTRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:17:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932482AbVJaTRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:17:05 -0500
Date: Mon, 31 Oct 2005 11:16:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Subject: Re: [patch 1/14] s390: statistics infrastructure.
Message-Id: <20051031111659.14fdc055.akpm@osdl.org>
In-Reply-To: <OFF65B1AC3.67015638-ONC12570AB.00340CB7-C12570AB.0054A095@de.ibm.com>
References: <OFF65B1AC3.67015638-ONC12570AB.00340CB7-C12570AB.0054A095@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke3 <MPESCHKE@de.ibm.com> wrote:
>
> Andrew,
> 
> > I agree with Christoph on this: please present it as a Kconfigurable
> > generic option
> 
> Sure. Scanning through the kernel configuration with menuconfig, I see
> several options:
>   general setup,
>   library routines,
>   profiling support,
>   device drivers (the most obvious potential exploiters,
>                   though not the only ones),
>   kernel hacking.
> Please advise.

Nothing really fits, does it.

There is a patch in -mm which moves oprofile and kprobes into a new
"instrumentation" menu.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/broken-out/moving-kprobes-and-oprofile-to-instrumentation-support-menu.patch

I held off on merging that because the oprofile guys asked "why bother".  I
guess the statistics infrastructure answers that question.  I'll send it
on.

> 
> ...
>
> > (If we end up deciding to keep all this in arch/s390 then I guess
> > we can live with s390 peculiarities though)
> 
> I will be happy to see some feature like this included outside arch/s390.
> What is about lib/, or kernel/?

lib/, I guess.

It could concievably go in fs/debugfs, depending upon how tightly coupled
it is to debugfs.

> > > +        list_for_each_entry(seg, &rb->seg_lh, list)
> > > +                    break;
> >
> > eh?   Something's gone rather wrong here.
> 
> Intention here is to find the entry at the list's head.
> Should work, though it might look fishy at first sight.
> A substitute for this construct would look like this:
> 
>    seg = list_entry(rb->seg_lh.next, struct sgrb_seg, list);
> 
> I don't feel very comfortably messing with pointers inside struct
> list_head. I know many people don't object. But IMHO the next and prev
> pointers look like implementation specifics of list heads that are nicely
> abstracted away for almost any purpose by list_for_each() and friends -
> with the exception of something like the above.
> 
> Anyway, I will change these and similar lines if you want me to.

Yes, we do poke inside list_head a lot and yes, it does feel a bit wrong.

Do whatever you think is best here.  A little explanatory comment would
help.

> > > +/**
> > > + * sgrb_produce_nooverwrite - put an entry into the ringbuffer
> > > + *     if there is room whithout the need to overwrite the oldest
> >
> > spello
> 
> Thanks. Will fix it along with a few more that have gone unnoticed so far.

I noticed that there was a /* in there somewhere where a kerneldoc /** was
intended.

> I don't think it would be beneficial to do locking inside these
> functions, because exploiters most likely do some locking anyway.

Yes, caller-provided locking is superior.

> ...
> > Can you help us decide whether there's actually any point in making
> > it generic?
> > What problems was it designed to solve, and what additional
> > problems might it all be useful for?
> 
> I am convinced that its worthwile to provide some statictics facility
> for any device driver programmer or whoever thinks about implementing
> statistics for his devices or algorithms.

OK, thanks.  Let's take a closer look at the actual facilities in the next
iteration.

