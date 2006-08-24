Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWHXRUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWHXRUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWHXRUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:20:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48064 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030403AbWHXRUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:20:22 -0400
Subject: Re: Serial custom speed deprecated?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-serial@vger.kernel.org, "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <m3bqqap09a.fsf@defiant.localdomain>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	 <1156411101.3012.15.camel@pmac.infradead.org>
	 <m3bqqap09a.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 18:41:33 +0100
Message-Id: <1156441293.3007.184.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 18:27 +0200, ysgrifennodd Krzysztof Halasa:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> >> If custom speeds are deprecated, what's the new method for setting
> >> them? Specifically, how can the SPD_CUST functionality be accomplished
> >> without that flag? I've checked 2.5.64 and 2.6.17, and don't see how
> >> it is possible. 
> >
> > We need a way to set the baud rate as an _integer_ instead of the Bxxxx
> > flags.
> 
> Does that mean that standard things like termios will use:
> #define B9600   9600
> #define B19200 19200

That would have been very smart when Linus did Linux 0.12, unfortunately
he didn't and we've also got no spare bits. Worse still if we exported
them that way glibc has now way to map new speeds onto the old ones for
applications.

The speed_t values in the termios struct are also Bfoo encoded so it
turns out don't help.

At this point I think we need

-	An ioctl to set/get the actual baud rate input/output
-	Some kind of termios flag to indicate they are being used (as we have
CBAUDEX now). [We could "borrow" the 4Mbit one and dual use it IMHO]

For drivers tty_get_baud_rate would return the actual speed as before.

We would need a driver ->set_speed method for the cases where
- ioctl is called to set specific board rate
- OR termios values for tty speed change
- While we are at it we might want to make ->set_termios also allowed to
fail

[and if you had no ->set_speed method non standard speeds would be
refused by the tty layer for back compat]

Anyone got any problems with this before I go and implement it ?






