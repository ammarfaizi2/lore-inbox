Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264913AbSKEQsS>; Tue, 5 Nov 2002 11:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbSKEQsS>; Tue, 5 Nov 2002 11:48:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21745 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264913AbSKEQsQ>;
	Tue, 5 Nov 2002 11:48:16 -0500
Message-ID: <3DC7F7C4.6170BC5A@mvista.com>
Date: Tue, 05 Nov 2002 08:54:28 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Paris <jim@jtan.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Paris wrote:
> 
> > > Any comments?
> >
> > Have a play with it, if your idea works when you deliberately disturb it
> > then send in a patch
> 
> This works well.

But it does introduce a hiccup in time.  One could just do
an odd read IF that is all that is wrong.  Your code could
also be correcting for other ills...

-g
> 
> -jim
> 
> diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
> --- linux-2.4.18/arch/i386/kernel/time.c        Fri Mar 15 18:28:53 2002
> +++ linux-2.4.18-jim/arch/i386/kernel/time.c    Tue Nov  5 11:22:02 2002
> @@ -501,6 +501,16 @@
> 
>                 count = inb_p(0x40);    /* read the latched count */
>                 count |= inb(0x40) << 8;
> +
> +               /* Any unpaired read will cause the above to swap MSB/LSB
> +                  forever.  Try to detect this and reset the counter. */
> +               if (count > LATCH) {
> +                       outb_p(0x34, 0x43);
> +                       outb_p(LATCH & 0xff, 0x40);
> +                       outb(LATCH >> 8, 0x40);
> +                       count = LATCH - 1;
> +               }
> +
>                 spin_unlock(&i8253_lock);
> 
>                 count = ((LATCH-1) - count) * TICK_SIZE;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
