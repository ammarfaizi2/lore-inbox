Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVJILR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVJILR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVJILR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 07:17:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9747 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932270AbVJILRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 07:17:25 -0400
Date: Sun, 9 Oct 2005 12:17:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051009111718.GA13144@flint.arm.linux.org.uk>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk> <20051009100909.GF5150@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009100909.GF5150@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 12:09:09PM +0200, Samuel Thibault wrote:
> Russell King, le Sun 09 Oct 2005 09:37:24 +0100, a ?crit :
> > What I was thinking of was to use some of the spare termios cflag bits
> > to select the flow control.  You'd only want one flow control type at
> > one time though.  Eg: define two fields, each to select the signal.
> > 
> > 0 - RTS
> > 1 - DTR
> > 
> > 0 - CTS
> > 1 - DTR
> > 2 - DSR
> 
> It looks fine, but it might not be sufficient for expressing that:
> 
> - some flow control use RTS to indicate that DTE is ready to send data,
> - some other use it to indicate that DTE wants to send data. (and CTS is
> used for acknowledgment of this),

Agreed - and that's one extra bit of control information.

> - some other use it as a strobe for acknowledging characters, some other
> use it as a strobe for acknowledging frames (announced by CTS).

The last has no business being in the serial driver though - the driver
knows nothing about frames of characters.  It's more a userland (in
which case it's TIOCM* ioctls) or ldisc issue (tty_driver->tiocmset).

> > However, bear in mind that the majority of the more inteligent 8250-
> > compatible UARTs with large FIFOs only do hardware flow control on
> > RTS/CTS
> 
> Hardward flow control is usually performed in software. Can't their
> hardware implementation of hardware flow control be disabled when
> control method is not usual RTS/CTS?

You missed the point.  Of course the hardware flow control can be
disabled.  However, if you do have on-chip CTS flow control disabled
with UARTs with large FIFOs, and remote end says "stop sending", the
characters already in the FIFO will be sent, which may be up to
64 or even 128 characters instead of the usual 16 or so with the
16550A.  If the remote end only has room for 32 more characters,
you're into an overrun condition at every "stop sending" event.

Hence, people must expect a DTR/DSR software-based hardware flow
control to be less reliable than using RTS/CTS (with an adapter to
swap the RTS/CTS pins for DTR/DSR) with advanced 8250-based UARTs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
