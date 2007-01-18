Return-Path: <linux-kernel-owner+w=401wt.eu-S1752066AbXARRLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbXARRLm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXARRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:11:42 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4475 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbXARRLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:11:41 -0500
Date: Thu, 18 Jan 2007 17:11:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Beattie <brianb@apcon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about break and sysrq on a serial console (2.6.19.1)
Message-ID: <20070118171133.GE31418@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Beattie <brianb@apcon.com>,
	linux-kernel@vger.kernel.org
References: <1169078214.16802.17.camel@brianb> <20070118091326.GB32068@flint.arm.linux.org.uk> <1169137187.16802.26.camel@brianb> <20070118164747.GD31418@flint.arm.linux.org.uk> <1169139169.16802.31.camel@brianb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169139169.16802.31.camel@brianb>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 08:52:49AM -0800, Brian Beattie wrote:
> On Thu, 2007-01-18 at 16:47 +0000, Russell King wrote:
> > On Thu, Jan 18, 2007 at 08:19:47AM -0800, Brian Beattie wrote:
> > > On Thu, 2007-01-18 at 09:13 +0000, Russell King wrote:
> > > > On Wed, Jan 17, 2007 at 03:56:54PM -0800, Brian Beattie wrote:
> > > > > I'm trying to do a SYSRQ over a serial console.  As I understand it a
> > > > > break will do that, but I'm not seeing the SYSRQ.  In looking at
> > > > > uart_handle_break() in drivers/serial/8250.c it looks like the code will
> > > > > toggle port->sysrq, rather than just setting it when the port is a
> > > > > console.  I think the correct code would be to move the "port->sysrq =
> > > > > 0;" to follow the closing brace on the next line, or am I missing
> > > > > something.
> > > > 
> > > > Thereby preventing the action of <break> (which may be to cause a SAK
> > > > event, which would be rather important on a console to ensure that
> > > > you're really logging in rather than typing your password into another
> > > > users program which just looks like a login program.)
> > > > 
> > > > Note that the sequence for sysrq is:
> > > > 
> > > > (non-break characters or nothing) <break> <sysrq-char>
> > > > 
> > > well the code as is, is not working.  Printk's tell me that
> > > uart_handle_break() is called repeatedly while the break condition is
> > > active, toggling port->sysrq so that it's a 50/50 chance on whether
> > > port->sysrq will be set or cleared when the break condition ends.  On
> > > the other hand the 8250 break condition handling code is not working
> > > anyway, so the problem may be that the 8250 code is not calling
> > > uart_handle_break() correctly.
> > 
> > Please learn to use the "reply to all" button when using mailing lists.
> I don't post much to LKML, I realized after I hit send I needed to reply
> all.
> > 
> > Works fine here.  Which UART are you actually using?  At a guess, it's
> > probably a bad clone which does not have a correct break implementation.
> 
> it's the built-in mpc8349 powerpc uart.

Well, it looks like this UART has a differing behaviour to proper 16xxx
UARTs - it says that the BI will be cleared when a stop bit is received
in addition to when the LSR is read.  That means that unless you check
the LSR while the break condition is present, you may never know one
existed.

Standard 8250-compatible UARTs only clear the BI when the LSR is read.

As for the rest of the description, it's quite loose.  It doesn't really
say under what conditions the BI bit is set, but I suggest that your UART
repeatedly (and incorrectly) sets the BI bit when no *new* break condition
exists.  That would certainly explain your behaviour.

Again, standard 8250-compatible UARTs don't do this.

Not sure how to fix this without other people seeing a behavioural
change.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
