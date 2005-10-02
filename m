Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJBMgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJBMgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 08:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVJBMgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 08:36:22 -0400
Received: from web33009.mail.mud.yahoo.com ([68.142.206.73]:31357 "HELO
	web33009.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751090AbVJBMgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 08:36:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=I9hVktazIItQXHelnaLsZcJeOCVwYnJ4456w9qUgY9zr+wQ2LPNOOFjn4fnR6qRuhzvGTxMmHIoKOlOCgXZ8xEPQOri12ZRacDbDDv2QHgXgEu8W1NlPQ1jf0MRZnFzl/kWsjK4odvi3UTJJGq2icfvF8fKbxLbkCPqpBPNXkK8=  ;
Message-ID: <20051002123618.37423.qmail@web33009.mail.mud.yahoo.com>
Date: Sun, 2 Oct 2005 13:36:18 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050930010208.F410EE9E6B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> Sorry for the delay getting back to these comments; I wanted to
> give them proper attention, which kept not arriving.
> 

I'm glad I'm not the only one :)

> 
> > Date: Sun, 18 Sep 2005 15:45:20 +0100 (BST)
> > From: Mark Underwood <basicmark@yahoo.com>
> 
> First comments for <linux/spi.h>:
> 
> > > +struct spi_device { /* this proxies the device through a master */
> > > + struct device  dev;
> > > + struct spi_master *master;
> > > + u32   max_speed_hz;
> > > + u8   chip_select;
> > > + u8   mode;
> > > +#define SPI_CPHA 0x01  /* clock phase */
> > > +#define SPI_CPOL 0x02  /* clock polarity */
> > > +#define SPI_MODE_0 (0|0)
> > > +#define SPI_MODE_1 (0|SPI_CPHA)
> > > +#define SPI_MODE_2 (SPI_CPOL|0)
> > > +#define SPI_MODE_3 (SPI_CPOL|SPI_CPHA)
> >
> > Would be more flexable to have this in the message or even
> > the spi_transfer structure. Although I
> > don't know who would need this flexability.
> 
> In this case, I don't see a benefit.  The chips support only one
> signaling method at a time.  It can be changed between requests,
> by calling spi_setup(...), but even that will be rare.  I don't
> think there's any point to encouraging finer grained changes.
> 
> 
> > > +struct spi_master {
> > > + ...
> > > +};
> >
> > I notice that there is no bus lock. Are you expecting the adapter
> > driver to handle the fact that its transfer routine could be called
> > before a previous call returns?
> 
> Yes.  The transfer routine is purely async, and its responsibility
> is to append that spi_message to the current queue.  (Assuming
> the driver isn't a simple pure-PIO driver without a queue...)
> 
> That's a simple matter of a spin_lock_irqsave/list_add_tail/unlock.
> 

OK. Thought so. I think that in the documentation (when it gets written ;) we need to warn people
that they can only do quick work (adding message to a queue or waking up a kthread) in the
transfer routine as it would not be fair for a PIO driver to transfer several KB in what might be
interrupt context.

> 
> > > +struct spi_transfer {
> > > + /* it's ok if tx_buf == rx_buf (right?)
> > > +  * for MicroWire, one buffer must be null
> > > +  * buffers must work with dma_*map_single() calls
> > > +  */
> > > + void  *tx_buf, *rx_buf;
> > > + unsigned len;
> > > +};
> >
> > I would like more flexability. I might want to toggle the CS line within
> > a message or another CS line which is really a GPO pin used for register
> > select. For example a char LCD with SPI interface
> > would require this and yes, they do exist! I've used one :).
> 
> I've been persuaded that at least the "toggle chipselect" thing
> is needed, because of chips like the CS8415A (or ISTR some EEPROMs)
> that read by starting a write (to set a data pointer), dropping
> chipselect temporarily, then issuing the read.  Those all need
> to be treated as single "spi_message".
> 

More convergence, good :)

> 
> > > +
> > > + /* Optionally leave this chipselect active afterward */
> > > + unsigned  csrel_disable:1;
> >
> > This would be a disaster as anther SPI device driver might have
> > put a transfer straight after this one, in which case that message
> > would be sent to both devices :(, or has the driver that did this
> > take a lock on the bus? If so what lock?.
> 
> That's not how it works.  No spi_message starts unless _only_ that
> device's chipselect is active.  If some other chipselect is still
> active, it must first be turned off.  No lock needed, beyond the fact
> that the controller has only one queue and driver ... that driver
> ensures many correctness issues, not just this one.

I see. Sorry I'm mixing up our subsytems :(.

> 
> The point of that option is to minimize the overhead of starting a
> new transaction to a "favored" device.  I understand that's needed
> with some of the CORGI (Zaurus) touchscreen support.  (Along with
> some other funky stuff like vertical retrace synchronization!)
> 

Yes that is something that I have started to think about with respect to adding messages in
callback context (e.g. a network device which you have to to a write/read combination to get the
amount of data in the buffer and then just contine reading to get the data). But I want to get
what we have at the moment sorted before moving onto things like that.

> 
> > > + /* completion is reported this way */
> > > + void    (*complete)(void *context);
> > > + void   *context;
> > > + unsigned  actual_length;
> > > + int   status;
> > > +
> > > + /* for optional controller driver use */
> > > + struct list_head queue;
> >
> > If your putting this here wouldn't it make sense to also add
> > a list_head to the adapter structure?
> 
> That's only the first of many chunks of driver-private data
> they'll need.  And as I've commented before, there's no business
> any other software has touching that queue ... assuming the
> controller driver is even written to use a queue.
> 
> (Many current SPI drivers just spin using PIO to complete requests,
> and they could be pretty easily converted to this framework without
> forcing that character to change right away ...)
> 
> 
> > > +};
> >
> > Clock speed should also be in this structure as a SPI device might
> > want to change the speed it's clocked at for each message.
> > For example MMC cards are probed at 400KHz but can be read/written to
> > at up to 25MHz.
> 
> The way I see that being done is by just calling spi_setup() to
> update the device speed.  That's a direct mirror of how it's
> done in the MMC (or PCMCIA) stacks:  a separate call to set
> the I/O mode parameters.
> 
> 
> > A priv pointer would be very usefull as I could allocate enough
> > memory for my message structure plus the transfer items and any
> > other thing(s) that I need to store and then set priv to point to
> > my area of memory (like you can for skb's).
> 
> Yes, the latest version has spi_message.state, a void *pointer
> for use by whoever currently owns that message.
> 

Thank you :)

> 
> > > +static inline int
> > > +spi_setup(struct spi_device *spi)
> > > +{
> > > + return spi->master->setup(spi);
> > > +}
> > > +
> >
> > Where would this be used? Surely only the adapter could do this
> > as the SPI device driver and core only knows when it sends the
> > request for a transfer, not when the transfer actually happens.
> 
> See above ... that's how the clock speed would be changed, or
> how various other long-lasting SPI protocol tweaks would kick in.
> 
> This doesn't _need_ to touch chip registers, though it can.
> It just changes i/o characterics for that specific device.
> 

So your asking the adapter to keep a 'personality' for each device on that bus (clock speed, cs &
clock mode etc) and then just before the transfer to/from a device is started the adapter takes
the 'personality' of that device (i.e. sets clock speed registers if needed etc)?

> 
> > > +static inline int
> > > +spi_async(struct spi_device *spi, struct spi_message *message)
> > > +{
> > > + message->dev = spi;
> > > + return spi->master->transfer(spi, message);
> > > +}
> >
> >
> > Couldn't/shouldn't this be in the core, otherwise it looks like
> > you can only do sync transfers (or
> > maybe some comment to say that it's in the header file).
> 
> The header file IS part of the core, and that's where that little
> routine is declared (so no need for a comment saying that).  The
> headerdefines the interface to the core.  Code running in an IRQ
> (or BH) will use spi_async(), while code running in a sleeping
> context could use spi_sync() if it likes.
> 
> And spi_sync() is sort-of-core; really it's just a veneer over
> that core async I/O primitive, but one that's so small (and easy
> to use) that it's worth paying the price to have it "everywhere".
> 
> (Remember, we're still talking about 2 KBytes ARM object code...)
> 
> 
> > > +static inline void
> > > +spi_unregister_device(struct spi_device *spi)
> > > +{
> > > + if (spi)
> > > +  device_unregister(&spi->dev);
> > > +}
> > > +
> >
> > Couldn't/shouldn't this be in the core, otherwise it looks like
> > you can only register a device and
> > not unregister (or maybe some comment to say that it's in the header file).
> 
> That immediately follows the spi_new_device() declaration;
> the device would have been registered using that call.
> 
> Really, I don't see much need for either function except to
> handle the sort of "hotplug an SPI adapter" code you were
> talking about.  The reason they're inlined there is not
> because they're "not core"; it's because they'll be used
> so infrequenty that nobody else should pay the cost for
> them to exist.
> 

OK.

> 
> And now stuff from "spi.c":
> 
> > > +static int spi_suspend(struct device *dev, pm_message_t message)
> > > +{
> > > + if (dev->driver && dev->driver->suspend)
> > > +  return dev->driver->suspend(dev, message, SUSPEND_POWER_DOWN);
> > > + else
> > > +  return 0;
> > > +}
> 
> Actually those aren't quite right; the dev->power.power_state fields
> need to be updated.  Otherwise only sysfs will be doing it.
> 
> > > +static int spi_resume(struct device *dev)
> > > +{
> > > + if (dev->driver && dev->driver->resume)
> > > +  return dev->driver->resume(dev, RESUME_POWER_ON);
> > > + else
> > > +  return 0;
> > > +}
> >
> > What happens about all the devices sitting on the adapter?
> 
> That's the suspend routine for those devices.  The adapter
> would have a separate suspend routine ...
> 
> > Does the driver core suspend them for you? If so could you
> > show me where because I missed it.
> 
> Good point.  It's arguably a weakness in the driver core.
> Meanwhile, what I've done elsewhere is basically
> 
>  device_for_each_driver(... fail_if_not_suspended);
> 
> The invariant for the spi_master would be that it needs to
> ensure that its children (the spi_device objects) are all
> suspended -- if they have a driver, that is.
> 

OK. Thats what I did. I guess the reason that the driver core can't do it is because some busses
may have to do it differently from others.

> 
> > > +struct spi_device *__init_or_module
> > > +spi_new_device(struct spi_master *master, struct spi_board_info *chip)
> > > +{
> > > + ...
> > > +
> > > + /* drivers may modify this default i/o setup */
> > > + status = master->setup(proxy);
> >
> > How would this work if two devices work in a different mode?
> >
> > Example:
> > SPI device A works in mode 0 and so the adapter is setup to mode 0.
> > SPI device B works in mode 1 and so the adapter is setup to mode 1.
> 
> That's the wrong starting point.  It's not the adapter that's set
> to a given mode ... it's the interactions with a given device.
> 
> > Device A does a transfer, which it should be done in mode 0, but
> > the transfer is actually done in
> > mode 1 as the last call to setup was for mode 1.
> 
> No, device A would never be used in the wrong mode.  That's
> a constraint that the spi_master must implement.
> 
> 
> > Setting up of the mode and clock should only be done in the context
> > of a message (and I mean when a message is transfered, not when it's
> > queued) as then and only then are the settings relevant and
> > you can guaranty that your not interfering with the settings for
> > other devices on the bus.
> 
> Not exactly.  Think of different kinds of SPI controller:
> 
>   * Like the PXA SSP.  An spi_master for that controller will either
>     implement its own chipselects using GPIOs, manually bank-switching
>     the registers ... or it won't use chipselects, so it'll never
>     need to change the registers.  Either way, the register settings
>     will be associated with the device, not the controller.
> 
>     So master->setup() can just update the copy of the registers
>     used for that device, and they'll be used to set up the controller
>     the next time a transfer to that device is started.

Right, so the answer to one of my questions above is yes, the adapter is expected to store a
'personality' for each device on the bus for adapters that don't support it in hardware.
This does mean that if a SPI driver wants to send messages at different speeds in the callback of
the current message it would have to change the speed for the next message.

> 
>   * Like the AT91rm9200 SPI.  Each chipselect has a dedicated
>     register covering mode, clock, and some delays.
> 
>     So master->setup() can just update the registers directly,
>     it won't need to copy them when it starts a transfer, and
>     starting a transfer involves fewer register writes.
> 
> If the driver for an SPI controller gets the settings wrong, that'd
> be a bug just like reading or writing the wrong data.
> 
> 
> > > +EXPORT_SYMBOL_GPL(spi_new_device);
> >
> > I think we should have a bus lock (in the adapter structure) for
> > safety, and in the remove routine as well.
> 
> Why?  I don't see any need for one, at least in the "all drivers
> must use this one" category.  Persuade me; what problems would such
> a lock solve? 
> 

Problems with parallel calls to register spi device/unregister spi device/transfer?

> 
> > > +int __init_or_module  // would be __init except for SPI_EXAMPLE
> > > +spi_register_board_info(struct spi_board_info const *info, unsigned n)
> > > +...
> >
> > This function should call scan_boardinfo as there may be devices in this
> > list that sit on adapters that have been registered already.
> 
> Not easily.  Remember, this is called from the board init code,
> normally in arch_initcall() which is before drivers are expected
> to start registering...
> 
> 
> > Please can we have a 'undo' version (the general rule being you
> > should be able to undo what you have done ;), i.e.
> 
> That rule isn't really followed for board init code though.  There's
> no point, since it's not like the board could transmogrify itself!
> The parts registered there can't physically vanish.
> 
> 
> > spi_unregister_board_info as I might have two different parallel port
> > boards (one with EEPROM and one with Ethernet for example) and I
> > don't want to have to reset my PC to switch between the two.
> 
> The parallel port adapter wouldn't use that interface.  It would
> instead be using spi_new_device() with board_info matching the
> device (Ethernet, EEPROM, USB controller, etc) ...

OK. So if I had an array of devices then I have to go though that array and call  spi_new_device()
for each one?
Where do I get spi_master from? I need a function to which I can pass the name/bus number to and
get a spi_master pointer in return.

> 
> Then those devices would automatically vanish (in the latest code)
> when when the adapter calls the spi_unregister_master() routine.  
> 
> 
> > > +int __init_or_module
> > > +spi_register_master(struct device *dev, struct spi_master *master)
> > > +{
> > > + static atomic_t  dyn_bus_id = ATOMIC_INIT(0);
> > > + int   status = -ENODEV;
> > > +
> > > + if (list_empty(&board_list)) {
> > > +  dev_dbg(dev, "spi board info is missing\n");
> > > +  goto done;
> > > + }
> >
> > Why is the fact the there is no board information registered at the moment
> > a reason to fail?
> > I thought I could register adapters and board/platform information in any
> > order I wanted.
> 
> It's not; I recenty ripped that code out.  For your case of a
> parallel port adapter, there would never be one.  Only for
> "normal" situations would "nothing declared" be fishy, and
> it's not really worth even a warning.
> 
> 
> > > +void spi_unregister_master(struct spi_master *master)
> > > +{
> > > +/* REVISIT when do children get deleted? */
> > > + class_device_unregister(&master->cdev);
> > > +
> > > + put_device(master->cdev.dev);
> > > + master->cdev.dev = NULL;
> > > +
> > > +}
> > > +EXPORT_SYMBOL_GPL(spi_unregister_master);
> > > +
> >
> > Does this work? Adding a child device will cause the parent devices
> > ref count to be incremented so
> > surely you have to release all the children first.
> 
> I finally revisited that and added the code to unregister the
> children (right there).
> 

OK. There is an example of how to do this in my code :)

> 
> > > +int spi_sync(struct spi_device *spi, struct spi_message *message)
> > > +{
> > > + DECLARE_COMPLETION(done);
> > > + int status;
> > > +
> > > + message->complete = spi_sync_complete;
> > > + message->context = &done;
> > > + status = spi_async(spi, message);
> > > + if (status == 0)
> > > +  wait_for_completion(&done);
> > > + message->context = NULL;
> > > + return status;
> > > +}
> > > +EXPORT_SYMBOL(spi_sync);
> >
> > Why not combine spi_sync and spi_async and just check for a NULL pointer
> > in callback? If the callback/complete pointer is NULL then it's a sync
> > transfer else it's an async transfer.
> 
> No, there is only ** one ** way to report completion and that's
> through the callback.  All transfers are async at the low level.
> This small wrapper just uses the async notification callback to
> wake up a thread, so that thread has a synchronous model.
> 

Sorry I didn't make myself clear. I mean check the complete element in the spi_message structure
when spi_transfer is called. So:

int spi_transfer(struct spi_device *spi, struct spi_message *message)
{
        if (message->complete)
                /* We have callback so transfer is async */
        else
                /* We have no callback so transfer is sync */
}

Although thinking about it this is probably a bad idea as it could be prone to errors as people
who want an async transfer might forget/not need to set the complete element and would get a sync
transfer instead :(.

> 
> > > +/**
> > > + * spi_w8r8 - SPI synchronous 8 bit write followed by 8 bit read
> > > + * @spi: device with which data will be exchanged
> > > + * @cmd: command to be written before data is read back
> > > + *
> > > + * This returns the (unsigned) eight bit number returned by the
> > > + * device, or else a negative error code.
> > > + */
> 
> > > +/**
> > > + * spi_w8r16 - SPI synchronous 8 bit write followed by 16 bit read
> > > + * @spi: device with which data will be exchanged
> > > + * @cmd: command to be written before data is read back
> > > + *
> > > + * This returns the (unsigned) sixteen bit number returned by the
> > > + * device, or else a negative error code.
> > > + */
> >
> > Should these live in the core? I know they don't take up much space
> > but if I don't need them why should I have to have them?
> > What about putting these as inline functions in spi.h?
> 
> Agreed.  The latest version does just that ... but it also has
> a new helper function to call (write X bytes, read Y bytes back)
> to help keep the nonsharable/inlined parts small.
> 
> 
> > Hmm, using local variables for messages, so DMA adapter drivers have
> > to check if this is non-kmalloc'ed space (how?)
> 
> They can't check that.  It turns out that most current Linuxes
> have no issues DMAing a few bytes from the stack.

Will the DMA remapping calls work with data from the stack?

> 
> But if we ever get a version where that's an issue -- or someone
> feels compelled to clean up that little issue, despite the fact that
> doing that creates a performance hit! -- the write_then_read() call
> could get some minor tweaks.
> 
> 
> > and either do a non DMA transfer or copy the data into a kmalloc'ed
> > area of memory to do the DMA from/to. It would make the adapter drivers
> > life easier if we stipulated that all messages must be kmalloc'ed.
> 
> The true requirement is already documented:  that all buffers must
> work with dma_{map,unmap}_single().  That's less restrictive than
> saying they've got to come from kmalloc().
> 

OK. That's what I meant :)

> 
> The "maybe-nice" thing that's not supported there is letting
> drivers provide their own DMA addresses, already mapped.  If we
> ever need such a thing, it can be done; but IMO there's not a
> lot of point to it quite yet.  Wait until we have the block
> layer handing scatterlists down to some SPI device; then the
> dma_map_sg() stuff will make us want that

I agree.

Mark

> 
> - Dave
> 
> 
> > Mark
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
