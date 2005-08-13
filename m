Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVHMLQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVHMLQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 07:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVHMLQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 07:16:22 -0400
Received: from [81.2.110.250] ([81.2.110.250]:22221 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751328AbVHMLQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 07:16:21 -0400
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, galak@freescale.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linuppc-embedded@freescale.com,
       vbordug@ru.mvista.com
In-Reply-To: <20050812.145809.88701697.davem@davemloft.net>
References: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>
	 <20050812204617.C21152@flint.arm.linux.org.uk>
	 <1123884186.22460.79.camel@localhost.localdomain>
	 <20050812.145809.88701697.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Aug 2005 12:41:20 +0100
Message-Id: <1123933280.6624.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-12 at 14:58 -0700, David S. Miller wrote:
> I like this a lot, and the count return based error handling
> is nice as well.  Should a driver sink any bytes that the
> TTY flip interface couldn't eat or should it just wait for
> the overrun event?

Its really driver dependant. A lot of the hardware doesn't seem to have
much choice. My assumption would be that it is better to stop reading
from the uart if possible and hope you avoid the later overrun on the
chip. Then agai with kmalloc backing the memory allocation it shouldn't
ever happen except perhaps to people with high speed DMA interfaces.

> With respect to that, in fact, there seems to be some questions
> of consistency regarding tty_insert_flip_char() and the
> tty_prepare_*() interfaces.  If tty_insert_flip_char() fails
> to stow away the character (due to memory allocation failure),
> this just happens transparently.  However, when using the

It returns 1 or 0. You can also use tty_buffer_request_room(tty, 1) if
you really want to know if there is a byte free. Its probably cheaper to
just remember the overflow in a static in the irq handler and push it
first next IRQ however.


> tty_prepare_*() stuff the driver just doesn't sink the bytes
> at that time.
> 
> Perhaps there should be some kind of counterpart for
> tty_insert_flip_char() (something like tty_prepare_to_insert_*() or
> whatever) so that the "out-of-space" handling can be made more
> consistent.

Not 100% sure I follow this ?

> 
> Some other things caught my eye while reading this:
> 
> --- linux.vanilla-2.6.13-rc6/drivers/char/hvc_console.c	2005-08-10 13:57:08.000000000 +0100
> +++ linux-2.6.13-rc6/drivers/char/hvc_console.c	2005-07-18 19:06:42.000000000 +0100
>  ...
> +		count = tty_buffer_request_room(tty. N_INBUF);
> 
> that "." should be a "," obviously.  Also:
> 
> --- linux.vanilla-2.6.13-rc6/drivers/char/pcmcia/synclink_cs.c	2005-08-10 13:57:08.000000000 +0100
> +++ linux-2.6.13-rc6/drivers/char/pcmcia/synclink_cs.c	2005-07-25 15:49:51.000000000 +0100
>  ...
> -		printk("%s(%d):rx_ready_async count=%d\n",
> -			__FILE__,__LINE__,tty->flip.count);
> +		printk("%s(%d):rx_ready",
> +			__FILE__,__LINE__);
> 
> The name of the function really is "rx_ready_async", no real need
> to condense it to "rx_ready" and in fact this might confuse someone
> actually reading this debug message.

Thanks

> "smaller than or equal to" size, so I think this test is reversed
> and should instead be:
> 
> +		if(t->size >= size) {
> 
> Keep up the good work :-)

Doh I'd been looking for that bug

