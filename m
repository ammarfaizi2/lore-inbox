Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131762AbRCQVbD>; Sat, 17 Mar 2001 16:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbRCQVax>; Sat, 17 Mar 2001 16:30:53 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:694 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131762AbRCQVap>; Sat, 17 Mar 2001 16:30:45 -0500
Date: Sat, 17 Mar 2001 13:29:54 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>, <mc@CS.Stanford.EDU>
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <3AB35289.791E6B2C@uow.edu.au>
Message-ID: <Pine.GSO.4.31.0103171310240.23979-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your reporting is a little misleading here.

Thanks for verifying these bugs ;)

The interrupt checker checks for inconsistent interrupt states. For
example, if a function has one exit point with interrupt disabled, and
another exit point with interrupt enabled, the checker will report an
error at the second exit point. The code snippets are automatically culled
from the source based on the line number in the error report. So the
reporting is sometimes misleading. I'll put the actuall line number in the
comments.

>
> Yes, there's a bug in this function - the `return -EPERM'
> doesn't do a `restore_flags()'.  But there is no bug
> in the place you've reported.
>
> (Personally, I think *any* C function which has more than
>  one `return' statement is a bug, and we see a classic
>  instance here of one of the problems which this practice
>  can cause.  Religious issue. )


It may be better to have two exit points, one for normal path and one for
error path. All error handling code can be put at the end of the function.

>
>
> > ...
>
> > [BUG] error path
> >
> > /u2/acc/oses/linux/2.4.1/drivers/net/wan/comx-hw-mixcom.c:505:MIXCOM_open: ERROR:INTR:514:562: Interrupts inconsistent, severity `20':562
> >
> >         }
> >
> > Start --->
> >         save_flags(flags); cli();
> >
> >         if(hw->channel==1) {
> >                 request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name);
> >         }
> >
> >         if(hw->channel==0 && !(ch->init_status & IRQ_ALLOCATED)) {
> >
> >         ... DELETED 38 lines ...
> >
> >                         procfile->mode = S_IFREG |  0444;
> >                 }
> >         }
> >
> > Error --->
> >         return 0;
> > }
>
> There's another problem here.  We're calling request_region()
> inside cli().  request_region() can sleep.
>
> On SMP, cli() does all sorts of bizarre things which are
> quite different between different architectures.  I don't
> know if this practice is actually unsafe on any architectures,
> but it is really bad practice.  It's certainly the case that
> schedue() will enable interrupts for you, so whatever you're
> protecting won't be protected!
>
> So I'd add `sleep inside cli()' to your list of things to
> look out for.
>
> Does your tool have the ability to track which functions
> can and can't sleep?  This is a very common source of bug.
> Grab a spinlock, then call a function which calls a function
> which calls a function which calls kmalloc(GFP_KERNEL).  Unless
> the spinlock is always protected by a semaphore, this can deadlock.
>
> >
> > /u2/acc/oses/linux/2.4.1/drivers/scsi/eata_dma.c:490:eata_queue: ERROR:INTR:464:506: Interrupts inconsistent, severity `20':506
> >
> >     save_flags(flags);
> > Start --->
> >     cli();
> >
> > #if 0
> >     for (x = 1, sh = first_HBA; x <= registered_HBAs; x++, sh = SD(sh)->next) {
> >       if(inb((uint)sh->base + HA_RAUXSTAT) & HA_AIRQ) {
> >             printk("eata_dma: scsi%d interrupt pending in eata_queue.\n"
> >                    "          Calling interrupt handler.\n", sh->host_no);
> >
> >         ... DELETED 32 lines ...
> >
> >             printk(KERN_CRIT "eata_queue pid %ld, HBA QUEUE FULL..., "
> >                    "returning DID_BUS_BUSY\n", cmd->pid));
> >         done(cmd);
> >         restore_flags(flags);
> > Error --->
> >         return(0);
> >     }
> >     ccb = &hd->ccb[y];
>
> Something's gone a little wrong here.  The bug is in fact about
> 20 lines higher up.
>
>
> Generally: yes, everything you've found needs fixing.
>

