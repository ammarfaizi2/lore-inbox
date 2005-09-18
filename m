Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVIROpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVIROpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVIROpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:45:25 -0400
Received: from web30305.mail.mud.yahoo.com ([68.142.200.98]:39869 "HELO
	web30305.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751108AbVIROpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:45:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6G+1W1YM8YE2v4CPA/8CDapINRRatd9fgDX1wiJimIie+hqtXqwkrIXohkpj1+mb8i1r6ZRqTUqmfPkXbjAadDHYbo5iVFTXIlyMaj3tUc6htr65LxhwUojXbDVU/WhdP/1e/8mAHSKaeKT2+5iJAs0G4rlxQkZNgGP+OGxXfaI=  ;
Message-ID: <20050918144520.36950.qmail@web30305.mail.mud.yahoo.com>
Date: Sun, 18 Sep 2005 15:45:20 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050916032556.11B00C10BD@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:
-= snip =-

> I attach the latest snapshot of my code.  You'll notice two changes:
> (a) suspend/resume calls; this code seems pretty complete except for
> the protocol tweaking options; (b) a new method that'll be handy
> when doing things like hotplugging a card with an SPI controller
> and a few soldered-on SPI devices.  (Like that USB prototype.)
> 
> - Dave
> 

-= snip =-

> +struct spi_device { /* this proxies the device through a master */
> + struct device  dev;
> + struct spi_master *master;
> + u32   max_speed_hz;
> + u8   chip_select;
> + u8   mode;
> +#define SPI_CPHA 0x01  /* clock phase */
> +#define SPI_CPOL 0x02  /* clock polarity */
> +#define SPI_MODE_0 (0|0)
> +#define SPI_MODE_1 (0|SPI_CPHA)
> +#define SPI_MODE_2 (SPI_CPOL|0)
> +#define SPI_MODE_3 (SPI_CPOL|SPI_CPHA)

Would be more flexable to have this in the message or even the spi_transfer structure. Although I
don't know who would need this flexability.

-= snip =-

> +struct spi_master {
> + struct class_device cdev;
> +
> + /* other than zero (== assign one dynamically), bus_num is fully
> +  * board-specific.  usually that simplifies to being SOC-specific.
> +  * for example:  one SOC has three SPI controllers, numbered 1..3,
> +  * and one board's schematics might show it using SPI-2.  software
> +  * would normally use bus_num=2 for that controller.
> +  */
> + u16   bus_num;
> +
> + /* chipselects will be integral to many controllers, while others
> +  * might use board-specific GPIOs.
> +  */
> + u16   num_chipselect;
> +
> + /* setup mode and clock, etc */
> + int   (*setup)(struct spi_device *spi);
> +
> + /* bidirectional bulk transfers
> +  * + transfer() may not sleep
> +  * + to a given spi_device, message queueing is pure fifo
> +  * + if there are multiple spi_device children, the i/o queue
> +  *   arbitration algorithm is unspecified (round robin, fifo,
> +  *   priority, reservations, preemption, etc)
> +  * + the master's main job is to process its message queue,
> +  *   selecting a chip then transferring data
> +  * + for now there's no remove-from-queue operation, or
> +  *   any other request management
> +  */
> + int   (*transfer)(struct spi_device *spi,
> +      struct spi_message *mesg);
> +};

I notice that there is no bus lock. Are you expecting the adapter driver to handle the fact that
its transfer routine could be called before a previous call returns?

-= snip =-

> +struct spi_transfer {
> + /* it's ok if tx_buf == rx_buf (right?)
> +  * for MicroWire, one buffer must be null
> +  * buffers must work with dma_*map_single() calls
> +  */
> + void  *tx_buf, *rx_buf;
> + unsigned len;
> +};

I would like more flexability. I might want to toggle the CS line within a message or another CS
line which is really a GPO pin used for register select. For example a char LCD with SPI interface
would require this and yes, they do exist! I've used one :).

> +
> +/* spi messages will often be stack-allocated */
> +struct spi_message {
> + struct spi_transfer *transfers;
> + unsigned  n_transfer;
> +
> + struct spi_device *dev;

If you call this element *dev might it not confuse people into thinking that this is for a device
structure? That's why I used sdev.

> +
> + /* Optionally leave this chipselect active afterward */
> + unsigned  csrel_disable:1;

This would be a disaster as anther SPI device driver might have put a transfer straight after this
one, in which case that message would be sent to both devices :(, or has the driver that did this
take a lock on the bus? If so what lock?.

> +
> + /* completion is reported this way */
> + void    (*complete)(void *context);
> + void   *context;
> + unsigned  actual_length;
> + int   status;
> +
> + /* for optional controller driver use */
> + struct list_head queue;

If your putting this here wouldn't it make sense to also add a list_head to the adapter structure?

> +};

Clock speed should also be in this structure as a SPI device might want to change the speed it's
clocked at for each message. For example MMC cards are probed at 400KHz but can be read/written to
at up to 25MHz.

A priv pointer would be very usefull as I could allocate enough memory for my message structure 
plus the transfer items and any other thing(s) that I need to store and then set priv to point to
my area of memory (like you can for skb's).

> +
> +/**
> + * spi_setup -- setup SPI mode and clock rate
> + * @spi: the device whose settings are being modified
> + *
> + * SPI protocol drivers may need to update the transfer mode if the
> + * device doesn't work with the mode 0 default.  They may likewise need
> + * to update clock rates.  This function changes those settings,
> + * and must be called from a context that can sleep.
> + */
> +static inline int
> +spi_setup(struct spi_device *spi)
> +{
> + return spi->master->setup(spi);
> +}
> +

Where would this be used? Surely only the adapter could do this as the SPI device driver and core
only knows when it sends the request for a transfer, not when the transfer actually happens.

> +
> +/* synchronous SPI transfers; these may sleep uninterruptibly */
> +extern int spi_sync(struct spi_device *spi, struct spi_message *message);
> +extern int spi_w8r8(struct spi_device *spi, u8 cmd);
> +extern int spi_w8r16(struct spi_device *spi, u8 cmd);
> +
> +
> +/**
> + * spi_async -- asynchronous SPI transfer
> + * @spi: device with which data will be exchanged
> + * @message: describes the data transfers, including completion callback
> + *
> + * This call may be used in_irq in other contexts which can't sleep,
> + * as well as from task contexts which can sleep.
> + *
> + * The completion callback is invoked in a context which can't sleep.
> + * Before that invocation, the value of message->status is undefined.
> + * When the callback is issue, message->status holds either zero (to
> + * indicate complete success) or a negative error code.
> + */
> +static inline int
> +spi_async(struct spi_device *spi, struct spi_message *message)
> +{
> + message->dev = spi;
> + return spi->master->transfer(spi, message);
> +}


Couldn't/shouldn't this be in the core, otherwise it looks like you can only do sync transfers (or
maybe some comment to say that it's in the header file).

-= snip =-

> +static inline void
> +spi_unregister_device(struct spi_device *spi)
> +{
> + if (spi)
> +  device_unregister(&spi->dev);
> +}
> +

Couldn't/shouldn't this be in the core, otherwise it looks like you can only register a device and
not unregister (or maybe some comment to say that it's in the header file).

-= snip =-

> +/* suspend/resume in "struct device_driver" don't really need that
> + * strange third parameter, so we just make it a constant and expect
> + * drivers to ignore it.
> + */
> +static int spi_suspend(struct device *dev, pm_message_t message)
> +{
> + if (dev->driver && dev->driver->suspend)
> +  return dev->driver->suspend(dev, message, SUSPEND_POWER_DOWN);
> + else
> +  return 0;
> +}
> +
> +static int spi_resume(struct device *dev)
> +{
> + if (dev->driver && dev->driver->resume)
> +  return dev->driver->resume(dev, RESUME_POWER_ON);
> + else
> +  return 0;
> +}

What happens about all the devices sitting on the adapter?
Does the driver core suspend them for you? If so could you show me where because I missed it.

-= snip=-

> +struct spi_device *__init_or_module
> +spi_new_device(struct spi_master *master, struct spi_board_info *chip)
> +{
> + struct spi_device *proxy;
> + struct device  *dev = master->cdev.dev;
> + int   status;
> +
> + /* NOTE:  caller did any chip->bus_num checks necessary */
> +
> + /* only one child per chipselect, ever */
> + if (device_for_each_child(dev, chip, check_child))
> +  return NULL;
> +
> + if (!class_device_get(&master->cdev))
> +  return NULL;
> +
> + proxy = kzalloc(sizeof *proxy, GFP_KERNEL);
> + if (!proxy) {
> +  dev_err(dev, "can't alloc dev for cs%d\n",
> +   chip->chip_select);
> +  goto fail;
> + }
> + proxy->master = master;
> + proxy->chip_select = chip->chip_select;
> + proxy->max_speed_hz = chip->max_speed_hz;
> +
> + snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
> +   "%s.%u-%s", master->cdev.class_id,
> +   chip->chip_select, chip->modalias);
> + proxy->dev.parent = dev;
> + proxy->dev.bus = &spi_bus_type;
> + proxy->dev.platform_data = chip->platform_data;
> + proxy->dev.release = spidev_release;
> +
> + /* drivers may modify this default i/o setup */
> + status = master->setup(proxy);

How would this work if two devices work in a different mode?

Example:
SPI device A works in mode 0 and so the adapter is setup to mode 0.
SPI device B works in mode 1 and so the adapter is setup to mode 1.
Device A does a transfer, which it should be done in mode 0, but the transfer is actually done in
mode 1 as the last call to setup was for mode 1.

Setting up of the mode and clock should only be done in the context of a message (and I mean when
a message is transfered, not when it's queued) as then and only then are the settings relevant and
you can guaranty that your not interfering with the settings for other devices on the bus.

> + if (status < 0) {
> +  dev_dbg(dev, "can't %s %s, status %d\n",
> +    "setup", proxy->dev.bus_id, status);
> +  goto fail;
> + }
> +
> + status = device_register(&proxy->dev);
> + if (status < 0) {
> +  dev_dbg(dev, "can't %s %s, status %d\n",
> +    "add", proxy->dev.bus_id, status);
> +fail:
> +  class_device_put(&master->cdev);
> +  kfree(proxy);
> +  return NULL;
> + }
> + dev_dbg(dev, "registered child %s\n", proxy->dev.bus_id);
> + return proxy;
> +}
> +EXPORT_SYMBOL_GPL(spi_new_device);

I think we should have a bus lock (in the adapter structure) for safety, and in the remove routine
as well.

-= snip =-

> +int __init_or_module  // would be __init except for SPI_EXAMPLE
> +spi_register_board_info(struct spi_board_info const *info, unsigned n)
> +{
> + struct boardinfo *bi;
> +
> + bi = kmalloc (sizeof (*bi) + n * sizeof (*info), GFP_KERNEL);
> + if (!bi)
> +  return -ENOMEM;
> + bi->n_board_info = n;
> + memcpy(bi->board_info, info, n * sizeof (*info));
> +
> + down(&board_lock);
> + list_add_tail(&bi->list, &board_list);
> + up(&board_lock);
> + return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_register_board_info);

This function should call scan_boardinfo as there may be devices in this list that sit on adapters
that have been registered already.

Please can we have a 'undo' version (the general rule being you should be able to undo what you
have done ;), i.e. spi_unregister_board_info as I might have two different parallel port boards
(one with EEPROM and one with Ethernet for example) and I don't want to have to reset my PC to
switch between the two.

-= snip =-

> +int __init_or_module
> +spi_register_master(struct device *dev, struct spi_master *master)
> +{
> + static atomic_t  dyn_bus_id = ATOMIC_INIT(0);
> + int   status = -ENODEV;
> +
> + if (list_empty(&board_list)) {
> +  dev_dbg(dev, "spi board info is missing\n");
> +  goto done;
> + }

Why is the fact the there is no board information registered at the moment a reason to fail?
I thought I could register adapters and board/platform information in any order I wanted.

-= snip =-

> +void spi_unregister_master(struct spi_master *master)
> +{
> +/* REVISIT when do children get deleted? */
> + class_device_unregister(&master->cdev);
> +
> + put_device(master->cdev.dev);
> + master->cdev.dev = NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(spi_unregister_master);
> +

Does this work? Adding a child device will cause the parent devices ref count to be incremented so
surely you have to release all the children first.

-= snip =-

> +int spi_sync(struct spi_device *spi, struct spi_message *message)
> +{
> + DECLARE_COMPLETION(done);
> + int status;
> +
> + message->complete = spi_sync_complete;
> + message->context = &done;
> + status = spi_async(spi, message);
> + if (status == 0)
> +  wait_for_completion(&done);
> + message->context = NULL;
> + return status;
> +}
> +EXPORT_SYMBOL(spi_sync);

Why not combine spi_sync and spi_async and just check for a NULL pointer in callback? If the
callback/complete pointer is NULL then it's a sync transfer else it's an async transfer.

> +
> +/**
> + * spi_w8r8 - SPI synchronous 8 bit write followed by 8 bit read
> + * @spi: device with which data will be exchanged
> + * @cmd: command to be written before data is read back
> + *
> + * This returns the (unsigned) eight bit number returned by the
> + * device, or else a negative error code.
> + */
> +int spi_w8r8(struct spi_device *spi, u8 cmd)
> +{
> + int   status;
> + struct spi_message message;
> + struct spi_transfer x[2];
> + u8   result;
> +
> + x[0].tx_buf = &cmd;
> + x[0].rx_buf = NULL;
> + x[0].len = 1;
> +
> + x[1].tx_buf = NULL;
> + x[1].rx_buf = &result;
> + x[1].len = 1;
> +
> + /* do the i/o */
> + message.transfers = &x[0];
> + message.n_transfer = ARRAY_SIZE(x);
> + status = spi_sync(spi, &message);
> +
> + /* return negative errno or unsigned value */
> + return (status < 0) ? status : result;
> +}
> +EXPORT_SYMBOL(spi_w8r8);
> +
> +/**
> + * spi_w8r16 - SPI synchronous 8 bit write followed by 16 bit read
> + * @spi: device with which data will be exchanged
> + * @cmd: command to be written before data is read back
> + *
> + * This returns the (unsigned) sixteen bit number returned by the
> + * device, or else a negative error code.
> + */
> +int spi_w8r16(struct spi_device *spi, u8 cmd)
> +{
> + int   status;
> + struct spi_message message;
> + struct spi_transfer x[2];
> + u16   result;
> +
> + x[0].tx_buf = &cmd;
> + x[0].rx_buf = NULL;
> + x[0].len = 1;
> +
> + x[1].tx_buf = NULL;
> + x[1].rx_buf = &result;
> + x[1].len = 2;
> +
> + /* do the i/o */
> + message.transfers = &x[0];
> + message.n_transfer = ARRAY_SIZE(x);
> + status = spi_sync(spi, &message);
> +
> + /* return negative errno or unsigned value */
> + return (status < 0) ? status : result;
> +}
> +EXPORT_SYMBOL(spi_w8r16);
> +

Should these live in the core? I know they don't take up much space but if I don't need them why
should I have to have them?
What about putting these as inline functions in spi.h?

Hmm, using local variables for messages, so DMA adapter drivers have to check if this is
non-kmalloc'ed space (how?) and either do a non DMA transfer or copy the data into a kmalloc'ed
area of memory to do the DMA from/to. It would make the adapter drivers life easier if we
stipulated that all messages must be kmalloc'ed.

Mark



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
