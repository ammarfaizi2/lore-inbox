Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUCEJlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUCEJlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:41:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54535 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262286AbUCEJla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:41:30 -0500
Date: Fri, 5 Mar 2004 09:41:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial driver / tty issues
Message-ID: <20040305094126.D22156@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1078473270.5703.57.camel@gaston> <20040305085838.B22156@flint.arm.linux.org.uk> <1078477351.6327.65.camel@gaston> <1078478335.5702.79.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078478335.5702.79.camel@gaston>; from benh@kernel.crashing.org on Fri, Mar 05, 2004 at 08:18:56PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 08:18:56PM +1100, Benjamin Herrenschmidt wrote:
>  - most/all serial drivers, when the flip buffer is full, will
> call tty->flip.work.func() directly with the spinlock held. This is
> asking for trouble. I have reproduceable cases where that cause the
> tty layer to try to echo, thus calling back the serial_core
> uart_put_char() which will try to ... take the spinlock. Dead.

Yep - I think we need to drop the spinlock, but by dropping it we need
to check that stuff is still sane after re-acquiring it.

>  - what about the call to tty_flip_buffer_push() done by all
> drivers with the lock held too ? It's fine as long as we don't
> have this low_latency thing set. I suppose nothing but the driver
> itself will set it but I got a bit lost in the serial_core, can
> you just confirm that is ok ?

Again, we should drop the spinlock and re-acquire it afterwards.

>  - I had a couple of times a crash in n_tty_receive_buf() called
> from keventd (from ldisc flip workqueue), apparently racing with
> a close of the port. The scenario is that the close happens, i
> get out of my driver back to serial core which goes back to
> tty_release afaik. At that point (I'm not sure exactly when, maybe
> in the flush of the pending work queues that is done there, maybe
> just on the other CPU), the pending work queue is triggered since
> our input buffer is still full of crap.
> It reliably oopses trying to derefence 0 (writing a byte, it's not
> a memcpy, without a spinlocked region, I haven't spotted exactly
> where in n_tty_receive_buf(), this function is shit to disassemble
> as it seems to get a ton of things inlined).

Well, there does seem to be a race in there in the tty layer.  We
appear to close down the ldisc, and fiddle about with some other
things, and eventually cancel the work queue.

The n_tty close method frees the tty->read_buf, and n_tty_receive_buf()
references said buffer.  If the timing is right, *boom*.

We should cancel the work queue earlier, so we can guarantee that we
won't call the ldisc functions after we've closed them down.

I guess the TTY layer still needs a complete top to bottom overhaul...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
