Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTLPN41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTLPN41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:56:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7555 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261753AbTLPN4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:56:21 -0500
Date: Tue, 16 Dec 2003 08:57:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.53.0312160846530.17690@chaos>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Maciej W. Rozycki wrote:

> On Mon, 15 Dec 2003, George Anzinger wrote:
>
> > >  Hmm, you could have simply asked... ;-)  Anyway, an inclusion is doable,
> > > I guess.
> >
> > I suspect I did, but most likey the wrong place.  In any case, I would like to
> > think that "read the source, Luke" is the right answer.
>
>  Certainly it is, but not necessarily the only one. ;-)
>
> > So, while I am in the asking mode, is there a simple way to turn off the PIT
> > interrupt without changing the PIT program?  I would like a way to stop the
> > interrupts AND also stop the NMIs that it generates for the watchdog.  I suspect
> > that this is a bit more complex that it would appear, due to how its wired.
>
>  Well, in PC/AT compatible implementations, the counter #0 of the PIT has
> its gate hardwired to active, so you cannot mask the PIT output itself.
> So the only other choices are either reprogramming the counter to a mode
> that won't cause periodic triggers (which is probably the easiest way, but
> you don't want to do that for some purpose, right?) or reprogramming
> interrupt controllers not to accept interrupts arriving from the PIT.
>
>  Note that Linux may behave strangely then. ;-)
>

Masking OFF the timer channel 0 in the interrupt controller
is probably the easiest thing to do. The port is read-write,
and the OCW default to having it accessible.

	movw	$0x21, %dx	# Controller 0, mask register
	inb	%dx, %al	# Get mask
	orb	$1, %al		# Mask off bit 0
	outb	%al, %dx	# Write it back

You can reenable by:

	movw	$0x21, %dx
	inb	%dx, %al
	andb	$~1, %al
	outb	%al, %dx

With port numbers less that 256, you actually don't need the
DX register but I forget if the AT&T assembler needs a $ before
the port number when doing this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


