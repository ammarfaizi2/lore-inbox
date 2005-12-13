Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVLMVu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVLMVu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVLMVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:50:26 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:21608 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030248AbVLMVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:50:25 -0500
Message-ID: <439F4206.2040406@ru.mvista.com>
Date: Wed, 14 Dec 2005 00:49:58 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [patch 2.6.15-rc5-mm2] SPI, priority inversion
 tweak
References: <200512131028.49291.david-b@pacbell.net>
In-Reply-To: <200512131028.49291.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you're turning this to be unsafe if the buffer is in use, right? Funny...

David Brownell wrote:

>This is an updated version of the patch from Mark Underwood, handling
>the no-memory case better and using SLAB_KERNEL not SLAB_ATOMIC.
>
>Please apply it on top of the current SPI code in the MM tree.
>
>- Dave
>  
>
>------------------------------------------------------------------------
>
>Update the SPI framework to remove a potential priority inversion case by
>reverting to kmalloc if the pre-allocated DMA-safe buffer isn't available.
>
>From: Mark Underwood <basicmark@yahoo.com>
>Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
>--- g26.orig/drivers/spi/spi.c	2005-12-11 11:06:38.000000000 -0800
>+++ g26/drivers/spi/spi.c	2005-12-13 09:56:22.000000000 -0800
>@@ -541,22 +541,30 @@ int spi_write_then_read(struct spi_devic
> 	int			status;
> 	struct spi_message	message;
> 	struct spi_transfer	x[2];
>+	u8			*local_buf;
> 
> 	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
> 	 * (as a pure convenience thing), but we can keep heap costs
>-	 * out of the hot path.
>+	 * out of the hot path ...
> 	 */
> 	if ((n_tx + n_rx) > SPI_BUFSIZ)
> 		return -EINVAL;
> 
>-	down(&lock);
>+	/* ... unless someone else is using the pre-allocated buffer */
>+	if (down_trylock(&lock)) {
>+		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
>+		if (!local_buf)
>+			return -ENOMEM;
>+	} else
>+		local_buf = buf;
>+
> 	memset(x, 0, sizeof x);
> 
>-	memcpy(buf, txbuf, n_tx);
>-	x[0].tx_buf = buf;
>+	memcpy(local_buf, txbuf, n_tx);
>+	x[0].tx_buf = local_buf;
> 	x[0].len = n_tx;
> 
>-	x[1].rx_buf = buf + n_tx;
>+	x[1].rx_buf = local_buf + n_tx;
> 	x[1].len = n_rx;
> 
> 	/* do the i/o */
>@@ -568,7 +576,11 @@ int spi_write_then_read(struct spi_devic
> 		status = message.status;
> 	}
> 
>-	up(&lock);
>+	if (x[0].tx_buf == buf)
>+		up(&lock);
>+	else
>+		kfree(local_buf);
>+
> 	return status;
> }
> EXPORT_SYMBOL_GPL(spi_write_then_read);
>  
>

