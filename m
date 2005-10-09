Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVJIIhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVJIIhd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVJIIhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:37:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36111 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932246AbVJIIhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:37:32 -0400
Date: Sun, 9 Oct 2005 09:37:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051009083724.GA14335@flint.arm.linux.org.uk>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 02:21:30AM +0200, Samuel Thibault wrote:
> Russell King, le Sun 09 Oct 2005 01:01:53 +0100, a ?crit :
> > > How could this look like in userspace?
> > 
> > I think they should be termios settings - existing programs know how
> > to handle termios to get what they want. 
> 
> Hence a new field in the termios structure?
> 
> There was a discussion about this back in 2000:
> 
> http://marc.theaimsgroup.com/?t=96514848800003&r=1&w=2
> 
> and more precisely a remind of SVR4's termiox structure with an added
> x_hflag:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=96523146720678&w=2
> 
> I'm not sure about how we'd want to implement that. The SVR4 approach
> (orthogonal input/output flow control selection) doesn't seem right to
> me: there are really peculiar flow controls that involve both ways. A
> mere enumeration of possible methods might be better.

What I was thinking of was to use some of the spare termios cflag bits
to select the flow control.  You'd only want one flow control type at
one time though.  Eg: define two fields, each to select the signal.

0 - RTS
1 - DTR

0 - CTS
1 - DTR
2 - DSR

You still want CRTSCTS to enable hardware flow control though - which
is what programs expect to happen with that flag enabled.  RTS/CTS
flow control would be type 0 above for compatibility with existing
programs.

However, bear in mind that the majority of the more inteligent 8250-
compatible UARTs with large FIFOs only do hardware flow control on
RTS/CTS - attempting to simulate hardware flow control on the other
signals could end up with up to 64 or 128 characters being sent after
the transmit handshake is deasserted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
