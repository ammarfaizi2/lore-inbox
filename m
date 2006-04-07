Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWDGQJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWDGQJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:09:10 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:19035 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932449AbWDGQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:09:09 -0400
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [spi-devel-general] Re: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Fri, 7 Apr 2006 09:09:07 -0700
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@kernel.crashing.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org> <200604062222.05661.david-b@pacbell.net> <44362DDE.3010203@gmail.com>
In-Reply-To: <44362DDE.3010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604070909.08266.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 2:16 am, Vitaly Wool wrote:
> Hi,
> 
> > I guess I'm surprised you're not using txrx_buffers() and having
> > that whole thing be IRQ driven, so the per-word cost eliminates
> > the task scheduling.  You already paid for IRQ handling ... why
> > not have it store the rx byte into the buffer, and write the tx
> > byte froom the other buffer?  That'd be cheaper than what you're
> > doing now ... in both time and code.  Only wake up a task at
> > the end of a given spi_transfer().
> >   
> I might be completely wrong here, but I was asking myself this very 
> question, and it looks like that's the way to implement full duplex 
> transfers.

Well, not the _only_ way.  The polling-type txrx_word() calls are
also full duplex.  My point is more that it's bad/inefficient to
incur both IRQ _and_ task switch overheads per word, when it would
be a lot simpler to just have the IRQ handler do its normal job.

(And that's even true if you've turned hard IRQ handlers into threads
for PREEMPT_RT or whatever.  In that case the "IRQ overhead" is a
task switch, but you're still saving _additional_ task switches.)


> For txrx_buffers to be properly implemented, you need to take a lot of 
> things into account. 

No more than the usual sort of driver thing.  SPI is a lot simpler
than most hardware, it's just a fancy shift register.  There's not
a lot of configuration possible, and not much can go wrong.


> The main idea is not to lose the data in the  
> receive buffer due to overflow, and thus you need to set up 'Rx buffer 
> not free' int or whatever similar which will actually trigger after the 
> first word is sent.

I think of it more as "after first word is received", but they are
the same event ... you can't send a word without receiving one, or
receive one without sending one.  SPI is fundamentally full duplex.

Now, if you have a FIFO as well as a shift register, then yes the
synchronization can get tricky.  It should still be possible to
have the RX and TX buffers be identical though.


> So therefore implementing txrx_buffers within these  
> conditions doesn't make much sense IMHO, unless you meant having a 
> separate thread to read from the Rx buffer, which is woken up on, say, 
> half-full Rx buffer.

I'll disagree on any need for a separate thread.  Kumar's IRQ handler
was already reading the RX byte and storing it.  However, he stored it
in a scratch byte ... rather than putting it right into the RX buffer.
There's no point to incurring extra costs like that (or like the extra
context switch overhead).

- Dave

