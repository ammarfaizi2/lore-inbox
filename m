Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRADKvj>; Thu, 4 Jan 2001 05:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbRADKv3>; Thu, 4 Jan 2001 05:51:29 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:42514 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S130272AbRADKvX>;
	Thu, 4 Jan 2001 05:51:23 -0500
Date: Thu, 4 Jan 2001 11:51:59 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-irda@PASTA.cs.uit.no
Cc: mzyngier@freesurf.fr, linux-kernel@vger.kernel.org
Subject: Re: [Linux-IrDA]Re: [IrDA+SMP] Lockup in handle_IRQ_event
Message-ID: <20010104115159.D7660@paradigm.rfc822.org>
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org> <3A53B356.32353C01@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A53B356.32353C01@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 10:18:46AM +1100
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 10:18:46AM +1100, Andrew Morton wrote:
> Marc ZYNGIER wrote:
> > 
> > Hi all,
> > 
> > Having just started playing with IrDA on my dual celeron (Abit "APIC
> > error..." BP6), I managed to kill it every single time (NMI watchdog
> > in handle_IRQ_event) while connecting to my mobile phone (in fact,
> > when closing the connection to the phone. even 'cat /dev/ircomm0' will
> > do...). This is perfectly repeatable.
> > 
> 
> Try this:
> 
> --- linux-2.4.0-prerelease/net/irda/irqueue.c	Tue Nov 21 20:11:22 2000
> +++ linux-akpm/net/irda/irqueue.c	Thu Jan  4 10:14:10 2001
> @@ -436,7 +436,7 @@
>  
>  	/* Release lock */
>  	if ( hashbin->hb_type & HB_GLOBAL) {
> -		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
> +		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
>  
>  	} else if ( hashbin->hb_type & HB_LOCAL) {
>  		restore_flags( flags);

BTW: What i have seen in the ircomm_tty.c (2.2.18):

    647     save_flags(flags);
    648     cli();
    649 
    650     skb = self->tx_skb;
    651     self->tx_skb = NULL;
    652 
    653     restore_flags(flags);

and a lot of other places simply use "save_flags(flags); cli();
restore_flags()". Can someone enlighten me how this is supposed to work
on SMP machines ? AFAIK "cli()" only disables IRQs on the local
CPU so a different CPU could easily stumple half way as this
is definitly non atomic. Or is the tty layer protected by some
"big tty lock" ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
