Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVHPOfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVHPOfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVHPOfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 10:35:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36780 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965253AbVHPOfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 10:35:53 -0400
Date: Tue, 16 Aug 2005 10:35:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ryan Brown <some.nzguy@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
In-Reply-To: <20050816035353.GA8411@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0508161009010.4823-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, Ingo Molnar wrote:

> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > --- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 21:23:45.000000000 +0200
> > +++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:03:33.000000000 +0200
> > @@ -506,13 +506,11 @@ error:
> >         }
> > 
> >         /* any errors get returned through the urb completion */
> > -       local_irq_save (flags);
> > +       local_irq_save_nort (flags);
> >         spin_lock (&urb->lock);
> >         if (urb->status == -EINPROGRESS)
> >                 urb->status = status;
> >         spin_unlock (&urb->lock);
> >         usb_hcd_giveback_urb (hcd, urb, NULL);
> > -       local_irq_restore (flags);
> > +       local_irq_restore_nort (flags);
> >         return 0;
> >  }
> 
> i'm wondering whether we could/should also fix this upstream - and 
> whether this [making the IRQ flags disabling a NOP on -RT] is the right 
> fix. Why does the USB hcd.c code do this in the first place? Disabling 
> interrupts during usb_hcd_giveback_urb() [but not holding the urb->lock] 
> might serialize on UP, but it has no serialization effect on SMP and is 
> hence potentially buggy. Is there something i'm missing about this code?
> 
> the normal way of using urb->lock would be spin_lock_irqsave() and 
> spin_lock_irqrestore(), not the 'detached' method seen above.

I don't know much about the real-time preemption work, but I can explain 
what the code was supposed to be doing.

Interrupts are disabled during usb_hcd_giveback_urb because that's how it
was done originally and nobody has made an effort to remove this
assumption from the USB device drivers.  There's no real reason for it
other than historical inertia.  It's not done for serialization -- there's
no need for serialization since an URB can't be resubmitted before the
previous callback occurs (unless a driver is badly broken).  The
"detached" method is used simply to avoid an extra pair of enable/disable
instructions.

Personally I think it would be an improvement if we changed things to
allow callbacks with interrupts enabled.  This would require a lot of 
auditing of USB drivers, but in the end it should prove worthwhile.

> > similar fix, completions need not have irqs disabled on PREEMPT_RT 
> > right?
> 
> correct, PREEMPT_RT is very strict about the use of the interrupt flags.  
> A fair portion of the now-illegal API uses are also SMP bugs on 
> upstream, so these details are worth pursuing.
> 
> > --- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 22:03:33.000000000 +0200
> > +++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:32:54.000000000 +0200
> > @@ -538,7 +538,7 @@ void usb_hcd_poll_rh_status(struct usb_h
> >         if (length > 0) {
> > 
> >                 /* try to complete the status urb */
> > -               local_irq_save (flags);
> > +               local_irq_save_nort (flags);
> >                 spin_lock(&hcd_root_hub_lock);
> >                 urb = hcd->status_urb;
> >                 if (urb) {
> > @@ -562,7 +562,7 @@ void usb_hcd_poll_rh_status(struct usb_h
> >                         usb_hcd_giveback_urb (hcd, urb, NULL);
> >                 else
> >                         hcd->poll_pending = 1;
> > -               local_irq_restore (flags);
> > +               local_irq_restore_nort (flags);
> 
> same question: why are interrupts being kept disabled longer, and why is 
> usb_hcd_giveback_urb() called with interrupts disabled? (I tried to use 
> spin_lock_irqsave/irqrestore() in earlier -RT versions, but people 
> reported hangs and USB misbehavior, which might be related. I'm worried 
> that your _nort patch could cause similar misbehavior.)

Same answer as above: The call is done with interrupts disabled because 
it was always done that way.

> how about (naively) extending the urb->lock to cover 
> usb_hcd_giveback_urb() calls too - does that cause a deadlock or is it 
> unsafe in some other way?

It would cause a deadlock.  Not to mention that this is not what urb->lock
is intended for (protection of urb->status).

Alan Stern

