Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbRE1VOM>; Mon, 28 May 2001 17:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbRE1VOB>; Mon, 28 May 2001 17:14:01 -0400
Received: from empD-port20.net.McMaster.CA ([130.113.193.26]:19972 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263151AbRE1VNs>; Mon, 28 May 2001 17:13:48 -0400
Date: Mon, 28 May 2001 14:21:05 -0400
Message-Id: <200105281821.f4SIL5000350@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Kieu <haiquy@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.5-ac2 OOPs when run pppd ?
In-Reply-To: <3B125E62.1DD4712E@uow.edu.au>
In-Reply-To: <20010528084855.10604.qmail@web10402.mail.yahoo.com>
	<E154NQp-000386-00@the-village.bc.nu>
	<3B125E62.1DD4712E@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Alan Cox wrote:
> > 
> > > Yeas it is stil the same as 2.4.5-ac1, but did not
> > > happen with 2.4.5; You can try running pppd in the
> > > console (tty1) without any argument.
> > 
> > Looks like an interaction with the newer console locking code. The BUG() is
> > caused when the ppp code tries to write to the console from inside an
> > interrupt handler [now not allowed]
> 
> I wondered if there were more cases.
> 
> In the (as-yet-unsent) Linus patch I've added an
> 
> 	if (in_interrupt()) {
> 		shout_loudly();
> 		return;
> 	}
> 
> in three places to catch this possibility.   I'll prepare
> a -ac diff.
> 
> 
> This is a fundamental problem.
> 
> - The console is a tty device
> - tty devices are callable from interrupts
> - the console is very stateful and needs locking
> - the locking must be interrupt-safe (irqsave)
> - the console is very slow.
> 
> net result: we block interrupts for ages.  It's
> an exceptional situation.  I hope Linus buys this
> line of reasoning :)

How about having a helper function for interrupt handlers which queues
characters to be sent to the console? kconsoled anyone? Blocking
interrupts is quite distressing, so we need to be consoled ;-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
