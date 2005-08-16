Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVHPDxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVHPDxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVHPDxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:53:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44264 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965094AbVHPDxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:53:53 -0400
Date: Tue, 16 Aug 2005 05:53:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ryan Brown <some.nzguy@gmail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050816035353.GA8411@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <20050815111804.GA26161@elte.hu> <1124138128.15180.7.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124138128.15180.7.camel@twins>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> --- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 21:23:45.000000000 +0200
> +++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:03:33.000000000 +0200
> @@ -506,13 +506,11 @@ error:
>         }
> 
>         /* any errors get returned through the urb completion */
> -       local_irq_save (flags);
> +       local_irq_save_nort (flags);
>         spin_lock (&urb->lock);
>         if (urb->status == -EINPROGRESS)
>                 urb->status = status;
>         spin_unlock (&urb->lock);
>         usb_hcd_giveback_urb (hcd, urb, NULL);
> -       local_irq_restore (flags);
> +       local_irq_restore_nort (flags);
>         return 0;
>  }

i'm wondering whether we could/should also fix this upstream - and 
whether this [making the IRQ flags disabling a NOP on -RT] is the right 
fix. Why does the USB hcd.c code do this in the first place? Disabling 
interrupts during usb_hcd_giveback_urb() [but not holding the urb->lock] 
might serialize on UP, but it has no serialization effect on SMP and is 
hence potentially buggy. Is there something i'm missing about this code?

the normal way of using urb->lock would be spin_lock_irqsave() and 
spin_lock_irqrestore(), not the 'detached' method seen above.

> similar fix, completions need not have irqs disabled on PREEMPT_RT 
> right?

correct, PREEMPT_RT is very strict about the use of the interrupt flags.  
A fair portion of the now-illegal API uses are also SMP bugs on 
upstream, so these details are worth pursuing.

> --- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 22:03:33.000000000 +0200
> +++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:32:54.000000000 +0200
> @@ -538,7 +538,7 @@ void usb_hcd_poll_rh_status(struct usb_h
>         if (length > 0) {
> 
>                 /* try to complete the status urb */
> -               local_irq_save (flags);
> +               local_irq_save_nort (flags);
>                 spin_lock(&hcd_root_hub_lock);
>                 urb = hcd->status_urb;
>                 if (urb) {
> @@ -562,7 +562,7 @@ void usb_hcd_poll_rh_status(struct usb_h
>                         usb_hcd_giveback_urb (hcd, urb, NULL);
>                 else
>                         hcd->poll_pending = 1;
> -               local_irq_restore (flags);
> +               local_irq_restore_nort (flags);

same question: why are interrupts being kept disabled longer, and why is 
usb_hcd_giveback_urb() called with interrupts disabled? (I tried to use 
spin_lock_irqsave/irqrestore() in earlier -RT versions, but people 
reported hangs and USB misbehavior, which might be related. I'm worried 
that your _nort patch could cause similar misbehavior.)

how about (naively) extending the urb->lock to cover 
usb_hcd_giveback_urb() calls too - does that cause a deadlock or is it 
unsafe in some other way?

	Ingo
