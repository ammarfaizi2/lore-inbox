Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJCK5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJCK5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVJCK5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:57:49 -0400
Received: from web33014.mail.mud.yahoo.com ([68.142.206.78]:53664 "HELO
	web33014.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932219AbVJCK5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:57:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=acR9RZCLCxDu6QkwRlEa01sFIHaKHpoIRZbFRZ80FBYTnt3bEUzmrDGgejHX6G7kSUh/u3oPTPwhZKLNf+J7MxQ0YdRkyBUaQpdpVtHOQS489zOi9G2bwXxmLNrTZfcNcYBHBZoO8axUH9PNUElGfsojHk3mhWcJt72kyEfiydA=  ;
Message-ID: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com>
Date: Mon, 3 Oct 2005 11:57:48 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20051003044737.7B86CEA568@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > > > I notice that there is no bus lock. Are you expecting the adapter
> > > > driver to handle the fact that its transfer routine could be called
> > > > before a previous call returns?
> > > 
> > > Yes.  The transfer routine is purely async, and its responsibility
> > > is to append that spi_message to the current queue.  (Assuming
> > > the driver isn't a simple pure-PIO driver without a queue...)
> > > 
> > > That's a simple matter of a spin_lock_irqsave/list_add_tail/unlock.
> > > 
> >
> > OK. Thought so. I think that in the documentation (when it gets written ;)
> > we need to warn people that they can only do quick work (adding message
> > to a queue or waking up a kthread) in the transfer routine
> 
> The documented constraint -- right by the declaration of that
> particular method!! -- is that it may not sleep.  That suffices.
> 

Sorry, must have had my glasses on back to front ;)

> 
> >	as it would
> > not be fair for a PIO driver to transfer several KB in what might be
> > interrupt context.
> 
> That's a "quality of implementation" issue.  There are a lot of
> different SPI drivers floating around today that are pure PIO;
> they're used for sensor access, and work in exactly that way.
> (And without any buslock.)
> 
> When the driver is only reading/writing a handful of bytes, PIO
> can easily be "quick" ... and may well be quicker than going
> through a queue manager.  Example:  if SPI is clocked at 8 MHz,
> that's a microsecond per byte.  Add a smidgeon of overhead,
> and call it 5 usecs to read a sensor that way.
> 
> One point of standardizing an API is to support a broad range
> of different controller driver optimization points.  They should
> all work correctly of course.  A DMA driver may be the ticket for
> running from SPI flash ... but setting up DMA for just a couple
> bytes is likely not a win.
> 

True. In our SPI adapter driver we check to see if the transfer is below is certain size in which
case it is quicker to do PIO, otherwise we do DMA.

> 
> > So your asking the adapter to keep a 'personality' for each device on
> > that bus (clock speed, cs & clock mode etc) and then just before the
> > transfer to/from a device is started the adapter takes the 'personality'
> > of that device (i.e. sets clock speed registers if needed etc)?
> 
> As you noted later, yes.  Most of the SPI controllers I've looked
> at will do that in hardware, for that matter.  PCI drivers don't
> need to arbitrate bus access themselves; neither should SPI drivers.
> 

OK. Our hardware doesn't :(, so I'll have to emulate it. It's an interesting idea and as you say
it is more optimal for devices that have this support :).
To make it quicker for devices that don't have this support in hardware how would you feel about
having a 'void *personality' pointer in the spi_device structure which the adapter could use for
storing and accessing the register settings for clock etc for that SPI device?

> 
> > > > > +EXPORT_SYMBOL_GPL(spi_new_device);
> > > >
> > > > I think we should have a bus lock (in the adapter structure) for
> > > > safety, and in the remove routine as well.
> > > 
> > > Why?  I don't see any need for one, at least in the "all drivers
> > > must use this one" category.  Persuade me; what problems would such
> > > a lock solve? 
> > > 
> >
> > Problems with parallel calls to register spi device/unregister
> > spi device/transfer?
> 
> Only an issue if the driver core had bugs ... bugs that would break
> many more things than just SPI.  :)
> 
> 
> > > The parallel port adapter wouldn't use that interface.  It would
> > > instead be using spi_new_device() with board_info matching the
> > > device (Ethernet, EEPROM, USB controller, etc) ...
> >
> > OK. So if I had an array of devices then I have to go though that array
> > and call  spi_new_device() for each one?  Where do I get spi_master
> > from? I need a function to which I can pass the name/bus number to and
> > get a spi_master pointer in return.
> 
> You're the one who's defining the "parallel port adapter with device"
> thing ... so you've got the spi_master that you created.  In fact you
> probably used dev_set_drvdata(dev, master) to keep it handy.
> 

Ahh, but the spi_master structure is in /usr/src/linux/drivers/spi/busses/spi-parport.c and my
array of devices is in ~/spi-work/parprt_adapter_1.c

> 
> 
> > Sorry I didn't make myself clear. I mean check the complete element in
> > the spi_message structure when spi_transfer is called. So:
> >
> > int spi_transfer(struct spi_device *spi, struct spi_message *message)
> > {
> >         if (message->complete)
> >                 /* We have callback so transfer is async */
> >         else
> >                 /* We have no callback so transfer is sync */
> > }
> >
> > Although thinking about it this is probably a bad idea as it could b
> > prone to errors
> 
> That's a large part of why I would never support that model.  :)
> 
> 
> > > > Hmm, using local variables for messages, so DMA adapter drivers have
> > > > to check if this is non-kmalloc'ed space (how?)
> > > 
> > > They can't check that.  It turns out that most current Linuxes
> > > have no issues DMAing a few bytes from the stack.
> >
> > Will the DMA remapping calls work with data from the stack?
> 
> On "most current Linuxes" yes.  All I know about, in fact.
> But it's not guaranteed.

OK. Thanks

Mark

> 
> - Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
