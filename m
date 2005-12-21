Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVLUWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVLUWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVLUWP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:15:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5130 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964822AbVLUWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:15:27 -0500
Date: Wed, 21 Dec 2005 22:15:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051221221516.GK1736@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512212221310.651@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512212221310.651@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:33:37PM +0200, Meelis Roos wrote:
> >Hmm, possibly, but could you apply this patch and provide the resulting
> >messages please?  It'll probably cause some character loss when it
> >decides to dump some debugging.
> 
> Here is the full dmesg with it, from ICH2. First messages are from 
> serial port initialisation and the last ones are from running minicom at 
> 9600 as thje console for a cisco.

Urm, this is silly.  Lets look at the first instance.

> lp0: ECP mode
> serial8250: too much work for irq4
> serial8250: port c0452c80(0)
> 0: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
> ...
> 29: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
> 30: jif=fffef262 type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00

This is the first interrupt we apparantly recieved.  We start with
end =  NULL, l = i->head, and pass_counter starts off at zero (as
can be seen in the num line above.)

                up = list_entry(l, struct uart_8250_port, list);

                iir = serial_in(up, UART_IIR);

The IIR for the device reports 0x01 (IIR_NO_INT set) so no interrupt
was pending, so:

                if (!(iir & UART_IIR_NO_INT)) {
                } else if (end == NULL)
                        end = l;

we set our end marker to this port and move on to the next port.

                l = l->next;

Since we only have one port open on this IRQ, l is equal to l->next
so this has no effect.

                if (l == i->head && pass_counter++ > PASS_LIMIT) {

since l is still equal to i->head, we increment the pass counter.

        } while (l != end);

We set end = l above.  Given the comments above, that means that l
_is_ equal to end, so we should exit this loop.

> 31: jif=fffef262 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60

However, strangely we don't exit the loop, but we go around for
another go - since we can see num=1 here, which means pass_counter
is now '1'.

In addition, what's weirder is that iir is still saying NO_INT,
yet we seem to have taken a completely different path through
the code since the LSR value is now set.  This is only set in the
other branch of the if statement, inside serial8250_handle_port().

> 32: jif=fffef262 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60

And we go again... and again...

> 62: jif=fffef262 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
> 63: jif=fffef262 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60

until we hit the PASS_LIMIT and produce this dump.

The rest of the dumps show a very similar situation.  To me, it
looks like your machine is _not_ doing what the C code is telling
it to do.  Compiler bug maybe?

> serial8250: too much work for irq4
> serial8250: port c0452c80(0)
> 0: jif=fffef262 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
> 1: jif=fffef262 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
> 2: jif=fffef262 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
> 3: jif=fffef262 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
> 4: jif=fffef262 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
> 5: jif=fffef262 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
> 6: jif=fffef262 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
> 7: jif=fffef262 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
> 8: jif=fffef262 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
> 9: jif=fffef262 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
> 10: jif=fffef262 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
> 11: jif=fffef262 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
> 12: jif=fffef262 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
> 13: jif=fffef262 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
> 14: jif=fffef262 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
> 15: jif=fffef262 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
> 16: jif=fffef262 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
> 17: jif=fffef262 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
> 18: jif=fffef262 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
> 19: jif=fffef262 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
> 20: jif=fffef262 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
> 21: jif=fffef262 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
> 22: jif=fffef262 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
> 23: jif=fffef262 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
> 24: jif=fffef262 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
> 25: jif=fffef262 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
> 26: jif=fffef262 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
> 27: jif=fffef262 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
> 28: jif=fffef2c8 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60

Ah, a real interrupt for once - a transmit interrupt which we
service, and then...

> 29: jif=fffef2c8 type=00 num=01 iir=c1 lsr=00 => iir=c1 lsr=00

recheck the interrupt status and then exit as we should always
do.  Why this is any different from the previous one I've no
idea... so maybe it can't be a compiler bug...

Unless the compiler is messing up the initialiser for:

        struct list_head *l, *end = NULL;

Could you try placing a:

	BUG_ON(end != NULL);

between:

        spin_lock(&i->lock);

and:

        l = i->head;

in serial8250_interrupt please?

If that doesn't trigger, then I'm all out of ideas.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
