Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965819AbWKED4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965819AbWKED4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbWKED4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:56:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:38300 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965819AbWKED4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:56:11 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <1162697533.28571.131.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 14:55:53 +1100
Message-Id: <1162698953.28571.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 19:46 -0800, Linus Torvalds wrote:
> 
> On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> >
> > Make the generic lib/iomap.c use arch provided MMIO accessors when
> > available for big endian and repeat operations. Also while at it,
> > fix the *_be version which are currently broken for PIO
> 
> Just rip the _be versions out, methinks.
> 
> Also, what does your "writesb()" actually look like? I assume it's the 
> exact same thing as the generic one, with just another barrier. No? 

With our old naming (we used _ins* for the base operations, the PIO ones
just calling them with a magic offset) :

void _insb(const volatile u8 __iomem *port, void *buf, long count)
{
        u8 *tbuf = buf;
        u8 tmp;

        if (unlikely(count <= 0))
                return;
        asm volatile("sync");
        do {
                tmp = *port;
                asm volatile("eieio");
                *tbuf++ = tmp;
        } while (--count != 0);
        asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
}
EXPORT_SYMBOL(_insb);

void _outsb(volatile u8 __iomem *port, const void *buf, long count)
{
        const u8 *tbuf = buf;

        if (unlikely(count <= 0))
                return;
        asm volatile("sync");
        do {
                *port = *tbuf++;
        } while (--count != 0);
        asm volatile("sync");
}
EXPORT_SYMBOL(_outsb);

I'm not even entirely sure that the insb one is correct, maybe it should
or-in all the values to get a proper data dependency that acutally
depends on all previous loads to pass to the twi instructions (it's a
conditional trap instruction with the condition set as never, it forces
the CPU to think the data has been consumed and thus, in conjunction
with the subsequent isync, forces the loads to be performed before any
further code can execute).

The store also has two barriers as you can see. That's mostly related to
the need for very synchronous IOs to please drivers, though the second
one could be replaced with

	get_paca()->io_sync = 1;	

(Which is a new mecanism we introduced recently to tell spin_unlock that
one or previous MMIO stores might need a sync before we unlock. Looks
like we didn't update the "s" functions when adding that).

Ben.



