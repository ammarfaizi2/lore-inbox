Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSKESul>; Tue, 5 Nov 2002 13:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSKESul>; Tue, 5 Nov 2002 13:50:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265085AbSKESuj>; Tue, 5 Nov 2002 13:50:39 -0500
Date: Tue, 5 Nov 2002 13:57:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jim Paris <jim@jtan.com>
cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
In-Reply-To: <20021105124234.A5837@neurosis.mit.edu>
Message-ID: <Pine.LNX.3.95.1021105134951.410A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Jim Paris wrote:

> > BTW, why not trying to resync, with something like :
> > 
> >    if (count >= LATCH)
> > 	count = (count >> 8) | inb(0x40) << 8;
> 
> That's best if we really are out of sync, but it's hard to tell.  It
> could be that the 8253's latch value got clobbered somehow, in which
> case we definitely want to fix that or our timer interrupts will come
> out at the wrong rate.  We also still need to double-check that
> count < LATCH after your code.
> 
> Unless we assume that an unpaired read is more common than having the
> latch value clobbered in some other way, then I think just resetting
> the counter should be okay.  Since none of this _should_ ever happen
> (but did on my system, grr), it's probably not worth making it too
> complicated just to try to figure out what went wrong.
> 
> Updated patch with the printk and corrected conditional is below.
> 
> -jim
> 
> diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
> --- linux-2.4.18/arch/i386/kernel/time.c	Fri Mar 15 18:28:53 2002
> +++ linux-2.4.18-jim/arch/i386/kernel/time.c	Tue Nov  5 12:39:38 2002
> @@ -501,6 +501,18 @@
>  
>  		count = inb_p(0x40);    /* read the latched count */
>  		count |= inb(0x40) << 8;
> +
> +		/* Any unpaired read will cause the above to swap MSB/LSB
> +		   forever.  Try to detect this and reset the counter. */
> +		if (count >= LATCH) {
> +			printk(KERN_WARNING 
> +			       "i8253 count too high! resetting..\n");
> +			outb_p(0x34, 0x43);
> +			outb_p(LATCH & 0xff, 0x40);
> +			outb(LATCH >> 8, 0x40);
> +			count = LATCH - 1;
> +		}
> +
>  		spin_unlock(&i8253_lock);
>  
>  		count = ((LATCH-1) - count) * TICK_SIZE;
> -

No! You will break many machines. You cannot use out_p() when
writing the latch it __must__ be out(). the "_p" puts a write
to another port between the two writes. That will screw up
the internal state-machine of most PITs including AMD-SC520.

Again, any time you must make two consecutive writes to the
same device port to set it, you must not use the "_p" version.
The above latch setting must be:

	outb(LATCH & 0xff, 0x40);
	outb(LATCH >> 8,   0x40);

Of course, the second write could have a "_p" option, but
you won't need it.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


