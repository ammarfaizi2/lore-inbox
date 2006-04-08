Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWDHBZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWDHBZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDHBZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:25:09 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:36766 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751390AbWDHBZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:25:07 -0400
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Fri, 7 Apr 2006 18:25:06 -0700
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vitalywool@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org> <200604070909.08266.david-b@pacbell.net> <CD0F0EAE-B3C0-4C03-BB90-99E65C16EC4F@kernel.crashing.org>
In-Reply-To: <CD0F0EAE-B3C0-4C03-BB90-99E65C16EC4F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071825.06607.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 10:04 am, Kumar Gala wrote:

> > Well, not the _only_ way.  The polling-type txrx_word() calls are
> > also full duplex.  My point is more that it's bad/inefficient to
> > incur both IRQ _and_ task switch overheads per word, when it would
> > be a lot simpler to just have the IRQ handler do its normal job.

Not that you actually _need_ an IRQ handler to be correct, in any case.


> > (And that's even true if you've turned hard IRQ handlers into threads
> > for PREEMPT_RT or whatever.  In that case the "IRQ overhead" is a
> > task switch, but you're still saving _additional_ task switches.)
> 
> This makes more sense about what I'm doing that is wasteful.   
> However, I'm not sure exactly where I should plug into things.

Only using interfaces below the line in spi_bitbang that says
it's the "SECOND PART".


> I think you are saying to continue using spi_bitbang_transfer &  
> spi_bitbang_work, but have spi_bitbang_work call my own bitbang- 
>  >txrx_bufs().

Yes.  Consider several different ways to implement that I/O loop:

	- Interrupt plus two context switches per byte (what you have now),
	  no per-buffer context switch

	- Interrupt per byte, plus one context switch pair per buffer
	  (what I've described)

	- pure PIO per byte, no context switches (as if you polled
	  the registers rather than using an IRQ)

Any of them could be correct, but one of them is a lot worse in terms
of CPU overhead when you aim at tranfer rates of even just a few MBytes
per second.  (It's the one with lots of needless context switching.)

That pure PIO model will sometimes be very appropriate; if the SPI clock
is fast enough, it can be less overhead than the IRQ driven one.

- Dave



