Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130522AbRBTVRB>; Tue, 20 Feb 2001 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbRBTVQw>; Tue, 20 Feb 2001 16:16:52 -0500
Received: from colorfullife.com ([216.156.138.34]:50185 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130880AbRBTVQq>;
	Tue, 20 Feb 2001 16:16:46 -0500
Message-ID: <3A92DE9F.3A2F14E@colorfullife.com>
Date: Tue, 20 Feb 2001 22:16:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <20010220183513.B5102@bug.ucw.cz> <E14VJjL-0000eK-00@the-village.bc.nu> <20010220215216.C17159@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote:
> 
> > > > +         __asm__ __volatile__(
> > > > +                 "mov %1, %0\n\t"
> > > > +                 : "=r" (i)
> > > > +                 : "r" (kaddr+offset)); /* load tlb entry */
> > > > +         for(i=0;i<size;i+=64) {
> > > > +                 __asm__ __volatile__(
> > > > +                         "prefetchnta (%1, %0)\n\t"
> > > > +                         "prefetchnta 32(%1, %0)\n\t"
> > > > +                         : /* no output */
> > > > +                         : "r" (i), "r" (kaddr+offset));
> > > > +         }
> > > > + }
> > > >   left = __copy_to_user(desc->buf, kaddr + offset, size);
> > > >   kunmap(page);
> > >
> > > This seems bogus -- you need to handle faults --
> > > i.e. __prefetchnta_to_user() ;-).
> >

Ahm. That's file_read_actor, not file_write_actor ;-)
I'm prefetching the kernel space buffer.

> > It wants wrapping nicely. A generic prefetch and prefetchw does help some other
> > cases (scheduler for one).
> >
> > Does the prefetch instruction fault on PIII/PIV then - the K7 one appears not
> > to be a source of faults
> 
> My fault. I was told that prefetch instructions are always
> non-faulting.
>

But there is another problem:

The tlb preloading with a simple 'mov' is not enough:
the Pentium III cpu decodes the 'mov', begins to load the tlb entry -
this will take at least several dozend cpu ticks.

But the cpu continues to decode further instructions. It sees the
'prefetchnta', notices that the tlb entry is not loaded and ignores the
next prefetchnta's (prefetch without tlb is turned into NOP).

--	
	Manfred
