Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVKNRhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVKNRhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKNRhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:37:54 -0500
Received: from [85.21.88.2] ([85.21.88.2]:48267 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751207AbVKNRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:37:53 -0500
Subject: Re: [patch 2.6.14-git] SPI core, refresh
From: dmitry pervushin <dpervushin@gmail.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511102355.11505.david-b@pacbell.net>
References: <200511102355.11505.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 20:32:10 +0300
Message-Id: <1131989530.5700.24.camel@fj-laptop.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 23:55 -0800, David Brownell wrote:
> I thought I'd send out a refresh of this simple SPI framework,
> updated to build on recent kernels.  The patch description
> inludes a summary of what changed ... not much, though there
> is now a Documentation/spi directory with a FAQ-ish writeup.
I'd like to comment you framework; there are some places that still are
suspicious to me. First of all, it is better to inline the patch; this
makes easier commenting etc.
My comments follow:
+       void                    *controller_state;
+       const void              *controller_data;
Why to use the separate controller_data/controller_state fields ? At
learuesting qest one of them fits to the platform_data
+struct spi_transfer {
+       /* it's ok if tx_buf == rx_buf (right?)
+        * for MicroWire, one buffer must be null
+        * buffers must work with dma_*map_single() calls
+        */
+       const void      *tx_buf;
+       void            *rx_buf;
+       unsigned        len;
+
+       /* REVISIT for now, these are only for the controller driver's
+        * use, for recording dma mappings
+        */
+       dma_addr_t      tx_dma;
+       dma_addr_t      rx_dma;
OK, you requesting that tx/rx buffer must be DMA-capable. And why you
are using stack-allocated buffers, for example, in spi_w8r8 ? If
protocol driver is not enough smart to transfer small amouts of data not
using DMA, this could crash the system...
+struct spi_message {
+       struct spi_transfer     *transfers;
+       unsigned                n_transfer;
+
+       struct spi_device       *spi;
+
+       /* completion is reported through a callback */
+       void                    FASTCALL((*complete)(void *context));
As far as I understand, the protocol driver is requested to call
complete somewhere after processing the message; even ignoring my
preference to call this function as part of common message processing,
I'd prefer to see exported/inline function like spi_message_complete
(struct spi_message* msg). It is not clear that controller driver _must_
call the `complete' as part of processing message.
+static inline int spi_w8r8(struct spi_device *spi, u8 cmd)
+{
+       int                     status;
+       u8                      result;
+
+       status = spi_write_then_read(spi, &cmd, 1, &result, 1);
This breaks the statement that buffers must be dma_single_map'able :(
Namely, result cannot be mapped.
+/**
+ * spi_w8r16 - SPI synchronous 8 bit write followed by 16 bit read
+ * @spi: device with which data will be exchanged
+ * @cmd: command to be written before data is read back
+ *
+ * This returns the (unsigned) sixteen bit number returned by the
+ * device, or else a negative error code.  Callable only from
+ * contexts that can sleep.
+ *
+ * The number is returned in wire-order, which is at least sometimes
+ * big-endian.
+ */
+static inline int spi_w8r16(struct spi_device *spi, u8 cmd)
+{
+       int                     status;
+       u16                     result;
+
+       status = spi_write_then_read(spi, &cmd, 1, (u8 *) &result, 2);
+
+       /* return negative errno or unsigned value */
+       return (status < 0) ? status : result;
+}
Incorrect mixing int (signed int!) and u16. What if spi_write_then_read
read the value, say, 0xFFFF ? Is it the correct result or -1 indicating
error ?


+       if (status < 0) {
+               dev_dbg(dev, "can't %s %s, status %d\n",
+                               "add", proxy->dev.bus_id, status);
+fail:
+               class_device_put(&master->cdev);
+               kfree(proxy);
+               return NULL;
+       }
Using goto to the middle of compound statement... I personally do not
like this. This can be easily moved out of block.

There will be more comments...
-- 
cheers, dmitry pervushin

