Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUI3TPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUI3TPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUI3TLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:11:36 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:6507 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269422AbUI3TKM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:10:12 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <200409301816.44649.roland.cassebohm@visionsystems.de>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1096571398.1938.112.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 14:09:58 -0500
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 11:16, Roland Caßebohm wrote: 
> Maybe I can use the functions rs_throttle() and 
> rs_unthrottle(). In rs_unthrottle I could reenable the RX 
> interrupt. So I don't need to add a function in "struct 
> tty_driver". I only need to set the flag TTY_THROTTLED if I 
> disable the interrupt.

The question is when to unthrottle:

Doing it in N_TTY read_chan() does not mean a
flip buffer is available.

Doing it in flush_to_ldisc() could unthrottle
when the ldisc receive buffer is still full.

It is a problem of using a single mechanism to
throttle the receiver in response to
two seperate triggers (flip buffer state and
ldisc receive buffer state).

> Maybe TTY_DONT_FLIP is really don't needed anymore.

The only use I see for TTY_DONT_FLIP is
delaying transfers of data from a flip buffer
to the N_TTY receive buffer via ldisc->receive_buf()
while N_TTY read_chan() is returning data
from the N_TTY receive buffer to the user app.
This behavior maximizes free space in the
N_TTY receive buffer before sending the next
flip buffer to ldisc->receive_buf().

N_TTY ldisc receive buffer access is
protected by tty->read_lock, so not using
TTY_DONT_FLIP wont corrupt this buffer.
However, if there is not enough room in the
N_TTY receive buffer when ldisc->receive_buf()
is called then data is lost.

> I think to be save and fast maybe one way could be, if the 
> flip buffer is full it should be flipped but not processed 
> with tty->ldisc.receive_buf() in the interrupt routine. 
> flush_to_ldisc() has then always to look at both flip buffers 
> and process them.
> If the second flip buffer is still not clean, if the interrupt 
> routine needs to flip it, it has to stop the flow and disable 
> the receive interrupt.
> unthrottle() could then reenable the interrupt.

The gaping hole in the flip buffer scheme is
flush_to_ldisc() can be called from hard IRQ
context while ldisc->receive_buf() is running.

This can flip buffers while ldisc->receive_buf() is
still reading from one of the flip buffers.
That corrupts data if the device ISR overwrites
the buffer before ldisc->receive_buf() finishes
reading from it.

A mechanism is required to prevent flipping
buffers while ldisc->receive_buf() is running.
TTY_DONT_FLIP would work, but is already in
use for the purpose described above :-)

I understand the plan is to eliminate or replace
the flip buffer scheme. I doubt patches tinkering
with the current scheme will be accepted.

-- 
Paul Fulghum
paulkf@microgate.com

