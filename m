Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbUKIN2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUKIN2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKIN2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:28:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20228 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261310AbUKIN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:28:15 -0500
Date: Tue, 9 Nov 2004 13:28:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line status changes.
Message-ID: <20041109132810.A15570@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1099659997.20469.71.camel@localhost.localdomain> <20041109012212.463009c7.akpm@osdl.org> <1099998437.6081.68.camel@localhost.localdomain> <1099998926.15462.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1099998926.15462.21.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 09, 2004 at 11:15:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:15:30AM +0000, Alan Cox wrote:
> On Maw, 2004-11-09 at 11:07, David Woodhouse wrote:
> > + *	tty_status_change -	notify of line status changes
> > + *	@tty: terminal
> > + *
> > + *	Helper for informing the line discipline that the modem
> > + *	status lines may have changed.
> > + */
> > +
> > +void tty_status_changed(struct tty_struct *tty)
> > +{
> > +	struct tty_ldisc *ld = tty_ldisc_ref(tty);
> > +	if(ld) {
> > +		if(ld->status_changed)
> > +			ld->status_changed(tty);
> > +		tty_ldisc_deref(ld);
> > +	}
> > +}
> > +
> 
> This is the wrong way to do it. I've been trying this and discarded it.
> The problem is that data arrival is asynchronous to the event which
> means you've not got a clue how to combine the status change and the
> data stream. This in itself makes the whole feature useless.

The status change and character receive are asynchronous with respect
to each other anyway.  Consider the case where the serial port says
"we have characters waiting" - we receive a FIFO full of characters.
It then says that the modem status has changed.

You don't actually know when the modem status changed.  It may have
changed before any of these characters were received because character
receiption is is highest priority.

Even if you poll the MSR register after you receive every FIFO character,
you still don't know whether the modem status changed before or after
that character was received.

Therefore, anything which relies on knowing precisely when the modem
status changed in the character stream is unfortunately broken by the
limitations of 8250-based hardware.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
