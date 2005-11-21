Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVKURjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVKURjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVKURjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:39:18 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:9613 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932399AbVKURjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:39:17 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.14-git] SPI core, refresh
Date: Mon, 21 Nov 2005 09:39:08 -0800
User-Agent: KMail/1.7.1
Cc: dmitry pervushin <dpervushin@gmail.com>,
       Stephen Street <stephen@streetfiresound.com>,
       Komal Shah <komal_shah802003@yahoo.com>
References: <200511102355.11505.david-b@pacbell.net>
In-Reply-To: <200511102355.11505.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511210939.09212.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I thought I'd send out a refresh of this simple SPI framework,
> > updated to build on recent kernels.  The patch description
> > inludes a summary of what changed ... not much, though there
> > is now a Documentation/spi directory with a FAQ-ish writeup.
>
> I'd like to comment you framework;

Thanks, but please remember to CC me directly.  Until today, I didn't
know you had any comments!


> there are some places that still are 
> suspicious to me. First of all, it is better to inline the patch; this
> makes easier commenting etc.

Not when you're using a mailer that mangles inlined patches; sorry,
I usually do try to switch mailers when posting patches to LKML.

    http://marc.theaimsgroup.com/?l=linux-kernel&m=113169588230519&w=2


> My comments follow:
> +       void                    *controller_state;
> +       const void              *controller_data;
>
> Why to use the separate controller_data/controller_state fields ? At
> learuesting qest one of them fits to the platform_data

See the kerneldoc.  Basically "state" is runtime stuff managed by
the controller, and "data" is static stuff that's essentially board
specific configuration for use by the _controller_ driver rather
than the SPI device's driver.  (The platform_data is for static data
used by the SPI device's driver, not the controller driver.)

You can for example see how that's used by looking at Stephen's
PXA2xx SPI driver for the SSP/NSSP/ASSP controllers.  I'm not sure
how many other controller drivers will need that sort of mechanism,
but it does seem that SPI-family protocols do need protocol tweaking
hooks, and that one seems reasonable.


> +struct spi_transfer {
> +       /* it's ok if tx_buf == rx_buf (right?)
> +        * for MicroWire, one buffer must be null
> +        * buffers must work with dma_*map_single() calls
> +        */
> +       const void      *tx_buf;
> +       void            *rx_buf;
> +       unsigned        len;
> +
> +       /* REVISIT for now, these are only for the controller driver's
> +        * use, for recording dma mappings
> +        */
> +       dma_addr_t      tx_dma;
> +       dma_addr_t      rx_dma;
>
> OK, you requesting that tx/rx buffer must be DMA-capable. And why you
> are using stack-allocated buffers, for example, in spi_w8r8 ? 

Those RPC-style (or should I say MicroWire style?) helpers go through
a helper specifically documented as doing (small) copies, into a
DMA-safe buffer.

It'd be really tedious and annoying if drivers had to kmalloc() then
kfree() a temporary buffer whenever they had to do something common
like reading an ADC sample.  The whole point of convenience functions
(like those) is to be convenient!!  

Meanwhile, yes the primary API is set up so using DMA can be the hot
path.  That's pretty much what all kernel driver APIs do any more.
Of course, the controller driver is still free to apply heuristics
like "use PIO except on large transfers".

There are two use cases I was thinking about when I did that API.
One was bulk I/O, as required for the DataFlash driver ... DMA is
important if you're pulling in an executable.  The other was small
sensor-style access, as for ADCs (touchscreen etc) or control
requests issued to audio interfaces.  For the latter, DMA may not
be as important.


> +struct spi_message {
> +       struct spi_transfer     *transfers;
> +       unsigned                n_transfer;
> +
> +       struct spi_device       *spi;
> +
> +       /* completion is reported through a callback */
> +       void                    FASTCALL((*complete)(void *context));
>
> As far as I understand, the protocol driver is requested to call
> complete somewhere after processing the message;

No, the controller driver is REQUIRED to call it.  It's the only way
to report request completion.  The protocol driver provides that
callback ... it's easy to use a "struct completion" there (which is
why it's declared FASTCALL), but that's optional.


> even ignoring my 
> preference to call this function as part of common message processing,
> I'd prefer to see exported/inline function like spi_message_complete
> (struct spi_message* msg). It is not clear that controller driver _must_
> call the `complete' as part of processing message.

If you find the kerneldoc unclear, I take suggestions about what
needs to change.  For example, I don't see how "completion is
reported through a callback" (which you quoted above) could be
interpreted as implying it's not called ...


> +static inline int spi_w8r8(struct spi_device *spi, u8 cmd)
> +{
> +       int                     status;
> +       u8                      result;
> +
> +       status = spi_write_then_read(spi, &cmd, 1, &result, 1);
>
> This breaks the statement that buffers must be dma_single_map'able :(
> Namely, result cannot be mapped.

No, you must have overlooked the definition of the write_then_read()
call.  That's very clearly defined as taking tx and rx buffers that
are not DMA-safe:

+/**
+ * spi_write_then_read - SPI synchronous write followed by read
+ * @spi: device with which data will be exchanged
+ * @txbuf: data to be written (need not be dma-safe)
+ * @n_tx: size of txbuf, in bytes
+ * @rxbuf: buffer into which data will be read
+ * @n_rx: size of rxbuf, in bytes (need not be dma-safe)
+ *
+ * This performs a half duplex MicroWire style transaction with the
+ * device, sending txbuf and then reading rxbuf.  The return value
+ * is zero for success, else a negative errno status code.
+ *
+ * For large transfers, use spi_sync() and dma-safe buffers.
+ */


> +static inline int spi_w8r16(struct spi_device *spi, u8 cmd)
> +{
> +       int                     status;
> +       u16                     result;
> +
> +       status = spi_write_then_read(spi, &cmd, 1, (u8 *) &result, 2);
> +
> +       /* return negative errno or unsigned value */
> +       return (status < 0) ? status : result;
> +}
> Incorrect mixing int (signed int!) and u16. What if spi_write_then_read
> read the value, say, 0xFFFF ? Is it the correct result or -1 indicating
> error ?

That should return ssize_t then.  I confess to doing this work on 32 bit CPUs,
but I know that some of the uCLinux ports want to cope with cases where "int"
might be 16 bits.

- Dave
