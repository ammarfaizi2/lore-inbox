Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRJZU7s>; Fri, 26 Oct 2001 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279229AbRJZU7i>; Fri, 26 Oct 2001 16:59:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34545 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S279228AbRJZU7a>; Fri, 26 Oct 2001 16:59:30 -0400
Message-ID: <3BD9CE9F.16B2E2B5@mvista.com>
Date: Fri, 26 Oct 2001 13:59:11 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How should we do a 64-bit jiffies?
In-Reply-To: <1164.1003813848@ocs3.intra.ocs.com.au> <3BD52454.218387D9@mvista.com> <9r43b6$1as$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BD52454.218387D9@mvista.com>,
> george anzinger  <george@mvista.com> wrote:
> >
> >I am beginning to think that defining a u64 and casting, i.e.:
> >
> >#define jiffies (unsigned long volitial)jiffies_u64
> >
> >is the way to go.
> 
> ..except for gcc being bad at even 64->32-bit casts like the above.  It
> will usually still load the full 64-bit value, and then only use the low
> bits.
> 
> The efficient and sane way to do it is:
> 
>         /*
>          * The 64-bit value is not volatile - you MUST NOT read it
>          * without holding the spinlock
>          */
Given that the spinlock would have to be spin_lock_irq (jiffies is
updated in clock interrupt code), is there a way to avoid the lock?  The
following code does it for UP systems, given it is not rearranged.  Is
there something like this that will work for 
SMP systems?

 (assumeing the defines below):

	do {
		jiffies_f = jiffies;
		jiffies_64_f = jiffies_64;
	}
	while ( jiffies_f != jiffies);

If all things are in order, this will work on UP.  Order could be
enforced by using locked instructions for the jiffies access...

George


>         u64 jiffies_64;
> 
>         /*
>          * Most people don't necessarily care about the full 64-bit
>          * value, so we can just get the "unstable" low bits without
>          * holding the lock. For historical reasons we also mark
>          * it volatile so that busy-waiting doesn't get optimized
>          * away in old drivers.
>          */
>         #if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
>         #define jiffies (((volatile unsigned long *)&jiffies_64)[0])
>         #else
>         #define jiffies (((volatile unsigned long *)&jiffies_64)[1])
>         #endif
> 
> which looks ugly, but the ugliness is confined to that one place, and
> none of the users will ever have to care..
> 
>                 Linus
