Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVJCErn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJCErn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVJCErn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:47:43 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:46519 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932153AbVJCErm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:47:42 -0400
X-ORBL: [69.107.75.50]
Date: Sun, 02 Oct 2005 21:47:37 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: dpervushin@ru.mvista.com
References: <20051002123618.37423.qmail@web33009.mail.mud.yahoo.com>
In-Reply-To: <20051002123618.37423.qmail@web33009.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003044737.7B86CEA568@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I notice that there is no bus lock. Are you expecting the adapter
> > > driver to handle the fact that its transfer routine could be called
> > > before a previous call returns?
> > 
> > Yes.  The transfer routine is purely async, and its responsibility
> > is to append that spi_message to the current queue.  (Assuming
> > the driver isn't a simple pure-PIO driver without a queue...)
> > 
> > That's a simple matter of a spin_lock_irqsave/list_add_tail/unlock.
> > 
>
> OK. Thought so. I think that in the documentation (when it gets written ;)
> we need to warn people that they can only do quick work (adding message
> to a queue or waking up a kthread) in the transfer routine

The documented constraint -- right by the declaration of that
particular method!! -- is that it may not sleep.  That suffices.


>	as it would
> not be fair for a PIO driver to transfer several KB in what might be
> interrupt context.

That's a "quality of implementation" issue.  There are a lot of
different SPI drivers floating around today that are pure PIO;
they're used for sensor access, and work in exactly that way.
(And without any buslock.)

When the driver is only reading/writing a handful of bytes, PIO
can easily be "quick" ... and may well be quicker than going
through a queue manager.  Example:  if SPI is clocked at 8 MHz,
that's a microsecond per byte.  Add a smidgeon of overhead,
and call it 5 usecs to read a sensor that way.

One point of standardizing an API is to support a broad range
of different controller driver optimization points.  They should
all work correctly of course.  A DMA driver may be the ticket for
running from SPI flash ... but setting up DMA for just a couple
bytes is likely not a win.


> So your asking the adapter to keep a 'personality' for each device on
> that bus (clock speed, cs & clock mode etc) and then just before the
> transfer to/from a device is started the adapter takes the 'personality'
> of that device (i.e. sets clock speed registers if needed etc)?

As you noted later, yes.  Most of the SPI controllers I've looked
at will do that in hardware, for that matter.  PCI drivers don't
need to arbitrate bus access themselves; neither should SPI drivers.


> > > > +EXPORT_SYMBOL_GPL(spi_new_device);
> > >
> > > I think we should have a bus lock (in the adapter structure) for
> > > safety, and in the remove routine as well.
> > 
> > Why?  I don't see any need for one, at least in the "all drivers
> > must use this one" category.  Persuade me; what problems would such
> > a lock solve? 
> > 
>
> Problems with parallel calls to register spi device/unregister
> spi device/transfer?

Only an issue if the driver core had bugs ... bugs that would break
many more things than just SPI.  :)


> > The parallel port adapter wouldn't use that interface.  It would
> > instead be using spi_new_device() with board_info matching the
> > device (Ethernet, EEPROM, USB controller, etc) ...
>
> OK. So if I had an array of devices then I have to go though that array
> and call  spi_new_device() for each one?  Where do I get spi_master
> from? I need a function to which I can pass the name/bus number to and
> get a spi_master pointer in return.

You're the one who's defining the "parallel port adapter with device"
thing ... so you've got the spi_master that you created.  In fact you
probably used dev_set_drvdata(dev, master) to keep it handy.



> Sorry I didn't make myself clear. I mean check the complete element in
> the spi_message structure when spi_transfer is called. So:
>
> int spi_transfer(struct spi_device *spi, struct spi_message *message)
> {
>         if (message->complete)
>                 /* We have callback so transfer is async */
>         else
>                 /* We have no callback so transfer is sync */
> }
>
> Although thinking about it this is probably a bad idea as it could b
> prone to errors

That's a large part of why I would never support that model.  :)


> > > Hmm, using local variables for messages, so DMA adapter drivers have
> > > to check if this is non-kmalloc'ed space (how?)
> > 
> > They can't check that.  It turns out that most current Linuxes
> > have no issues DMAing a few bytes from the stack.
>
> Will the DMA remapping calls work with data from the stack?

On "most current Linuxes" yes.  All I know about, in fact.
But it's not guaranteed.

- Dave

