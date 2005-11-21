Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVKUV1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVKUV1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKUV1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:27:41 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:31575 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750833AbVKUV1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:27:40 -0500
From: David Brownell <david-b@pacbell.net>
To: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI
Date: Mon, 21 Nov 2005 13:27:33 -0800
User-Agent: KMail/1.7.1
Cc: dmitry pervushin <dpervushin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
References: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com>
In-Reply-To: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211327.34349.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 12:15 pm, Mark Underwood wrote:
> 
> --- dmitry pervushin <dpervushin@gmail.com> wrote:
> 
> > The list of main differences between David Brownell's SPI framework (A)
> > and my one (B):

A == http://marc.theaimsgroup.com/?l=linux-kernel&m=113169588230519&w=2
plus a handful of rather minor tweaks (ssize_t, comments, etc).

B == http://sourceforge.net/mailarchive/message.php?msg_id=13824397
but it needs updates to match current 2.6.15-rc code.


> > - (A) uses more complicated structure of SPI message, that contains one
> >   or more atomic transfers, and (B)
> >   offers the only spi_msg that represents the atomic transfer on SPI bus.
> >   The similar approach can be implemented
> >   in (B), and actually is implemented. But my imp[ression is that
> >   such enhancement may be added later..
> 
> I wouldn't have said that the message structure in (A) is more complex then (B). For example, in
> (B) you have many flags which controls things like SPI mode which are not needed in every message.
> Once the SPI controller has been setup for a particular slave device you don't need to constantly
> send this information. 

And in fact, constantly sending it means some drivers will have to waste
time constantly checking it, in case it changed.  If that setup is stored
in controller registers, it's a lot better to just have the setup() call
be responsible for changing the communication parameters.  (This is the
approach used by both MMC and PCMCIA, for what it's worth...)


> In (B) how to do you handle SPI devices which require to send several messages with out releasing
> their cs? There are/will be some devices which require this. 

In fact, that's why the transfer segments are grouped.  One builds SPI
protocol requests out of several such segments.  A very common idiom is
writing a command, then reading its response.  Chipselect must stay
active during the whole sequence.

Adding support for such a basic mechanism "later" doesn't seem like
a good idea to me.


> > - (A) uses workqueues to queue and handle SPI messages, and (B)
> >   allocates the kernel thread to the same purpose.
> >   Using workqueues is not very good solution in real-time environment; I
> >   think that allocating and starting the 
> >   separate thread will give us more predictable and stable results;
> 
> Where does (A) use a workqueue? (A) doesn't use a workqueue or thread and instead leaves it up to
> the adapter driver how to handle the messages that it gets sent (which in the case of some drivers
> will mean no thread or workqueue). (B) is _forcing_ a thread on the adapter which the adapter may
> not need. 

Exactly.  That's one of the things I meant when I recently listed some of the
top goals of the framework I did:

(a) SPI shouldn't perpetuate the driver model botches of I2C;
(b) ditto I2C's "everything is synchronous" botches;
(c) it should work well with DMA, to support things like DataFlash;
(d) given the variety of SPI chips, protocol controls are needed;
(e) place minimal implementation constraints on controller drivers.

So for example one way you know that (c) is well met is that it's the same
approach used in USB (both host and peripheral/gadget sides); that's been
working well for quite a few years now.  (Despite comments from Dmitry
and Vitaly to the contrary.)

 
> > - (A) has some assumptions on buffers that are passed down to spi
> >   functions.

Make that "requirements"; FWIW they're the same ones that apply to all
other kernel driver frameworks I've seen:  that buffers be DMA-safe.
It would not be helpful (IMO) to define different rules; that's also
called the "Principle of Least Astonishment".  :)


> >   If some controller driver (or bus driver 
> >   in terms of (B)) tries to perform DMA transfers, it must copy the
> >   passed buffers to some memory allocated
> >   using GFP_DMA flag and map it using dma_map_single.

Based on this and other comments from Dmitry/Vitaly, I suspect they
don't see how the Linux DMA APIs work.  The correct statement is that if
a controller driver wants to use DMA, it must dma_{map,unmap}_single().
The upper level drivers don't _need_ to worry about that.

However, some key infrastructure is in place to let SPI protocol drivers
(the ones passing messages through the controller then the bus) provide
pre-mapped buffers if the eventually _want_ to do that.  They'd likely be
allocated with dma_alloc_coherent() or through a dma_pool.  That would be
useful for cases like an MMC/SD block driver that talks SPI, since the
scatterlists will come down from the block layer ... lower level drivers
should be able to ignore details like how dma_{map,unmap}_sg() works.


> >   From the other 
> >   hand, (B) relies on callbacks provided 
> >   by SPI device driver to allocate memory for DMA transfers, but keeps
> >   ability to pass user-allocated buffers down
> >   to SPI functions by specifying flags in SPI message. SPI message being
> >   a fundamental essense looks better to me when 
> >   it's as simple as possible. Especially when we don't lose any
> >   flexibility which is exacly our case (buffers that are
> >   allocated as well as message itself/provided by user, DMA-capable
> >   buffers..)	
> 
> But allocating and freeing buffer is a core kernel thing not a SPI thing. To me you are adding
> more complexity then is needed and your saying this is keeping things simple? 

That's how I read his comments too.  Moreover, that particular kind of
complexity is the confusing kind ... it makes it a lot harder to see what's
going on, since it's all hidden behind layers of indirection.  Indirection
is of course useful sometimes.  But not in this case, where there are much
simpler idioms, with the advantage that most other kernel APIs use them.


> > - (A) retrieves SPI message from the queue in sequential order (FIFO),

Only with respect to a given device.  It would make no sense to reorder the
queue so that writing X, then Y, then Z would morph into "X Z Y" or "Z Y X".  :)

It's specifically _undefined_ how requests going to different devices are ordered.
Some hardware will be happier if things are synchronized (e.g. to a vertical
retrace IRQ), some systems might need to prioritize certain devices, and so on.

I do think FIFO makes a good general policy, for boards without any of those
special requirements.


> >   but (B) provides more flexible way by providing
> >   special callback to retrieve next message from queue. This callback may
> >   implement its own discipline of scheduling 
> >   SPI messages. In any way, the default is FIFO.
> 
> I think (A) is missing a method of adding extra spi_message(s) in callback to extend the current
> transfer on that SPI device. I can imagine a case where you will be required to read status
> information from a device and in this status information is the length of the data it has just
> received (for example if it was a network adapter). Straight after reading this information the
> device would start sending the data it has received but when the read status message was issued
> the length of the data wasn't known.

Do you actually have hardware which works that way?  That would be an example
of a system that needs some specific prioritization of transfers (see below).


> Currently with (A) we would have to stop the transfer and 
> restart the whole thing again, this time using the length of the data we found form the last
> message. 

Well, each transfer segement would clearly stop, but if that segment had
the flag set which says "leave chipselect active", then the controller
driver would have the flexibility to prioritize transfers to that chip.


> A better solution would to be able to add an extra message during the callback from the first
> message as now we know then length we can setup a transfer that would be the correct size.
> However, this message must be the next message that the adapter sends as if another message for
> another SPI device was sent before then the cs line of the device we are talking to would be
> deselected and we would have to start again. 

I suspect that in terms of API, *if* that semantic is really needed (as in,
you have hardware that needs it) then it should be made into a flag in
the spi_message.

Clearly, it'd make things more complicated for the SPI controller driver;
drivers that don't implement that semantic would need to know when it's
required, so they could fail cleanly.  And drivers that _do_ know about it
would need to avoid doing things like shuffling completions off to some
tasklet (while starting the next transfer ASAP, getting I/O overlap) ...
they'd need to make stronger guarantees about transaction sequencing, at
a certain cost in terms of potential throughput.


> My proposal is that in the callback from a spi_message being sent it returns a pointer to the next
> spi_message which the adapter will send before it continues sending any other messages (this is
> like the adapter being locked by the SPI device), if no other messages need to be sent atomically
> in the callback of current message then the SPI device driver would just return NULL. 

The thing I don't like about that model is that, just like the Linux-USB API
for interrupt and isochronous transfers in the 2.4 kernels, it swallows fault
modes so that drivers can't know when things break.

Better IMO to just keep the same API in all cases, and require that callback
to directly submit a (new?) transfer if that's needed.  If the controller
can't accept it, it'll know right away, and then the protocol driver will be
able to do something appropriate.

 
> > - (A) uses standartized way to provide CS information, and (B) relies on
> >   functional drivers callbacks, which looks more
> >   flexible to me.
> 
> I'm not sure what you mean here. You need to provide the cs numbers with SPI device in order for
> the core to create the unique addres and entry in sysfs. 

I'm not sure what he means either.  :)

Stephen's PXA2xx SPI driver uses callbacks internally, but that's kind of
specific to that PXA hardware ... there's no chipselect handled by the
controller, one of the dozens of GPIOs must be chosen and that's clearly
a board-specific mechanism (uses controller_data as I recall).  He tells
me he plans to post the latest version of that -- many updates including
PXA255 SSP support (not just NSSP) and code shrinkage -- early next week.

But most of the SPI controllers I've seen just have a fixed number of
chipselects, typically four, handled directly by the controller.  That's
why the "standardized way" is just to use a 0..N chipselect number.


> However, (A) is not checking to see if the cs that a registering device wants to use is already in
> use, this needs to be added, and the same is true for registering spi masters. 

Yes, I even have a "FIXME Paranoia argues that ..." comment in that code.  I think
the best way to handle that is probably to get the driver name out of the device
name, thereby punting that check to the driver model.  So the devices would have
names like "spi3.2" and the driver name would be in "modalias"; I think that'll
be a simple enough change to the framework, now that I've thought of it.  This is
not a case where we _need_ to act much like platform_device.

- Dave

