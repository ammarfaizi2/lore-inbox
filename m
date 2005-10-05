Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVJEIG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVJEIG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVJEIG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:06:28 -0400
Received: from [85.21.88.2] ([85.21.88.2]:38033 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932571AbVJEIG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:06:26 -0400
Message-ID: <434389DD.8030309@ru.mvista.com>
Date: Wed, 05 Oct 2005 12:07:57 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
References: <20051004201835.8DC32EE96F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20051004201835.8DC32EE96F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Brownell wrote:

>Hi Vitaly,
>
>  
>
>>can you please describe the data flow in case of DMA transfer? Thanks!
>>    
>>
>
>In the current model, the controller driver handles it (assuming
>that it uses DMA not PIO):
>
> - Use dma_map_single() at some point between the master->transfer()
>   call and the time the DMA address is handed to DMA hardware.
>  
>
So that implies calling dma_map_single() for the memory allocated in stack?
I'm afraid I know at least one target which won't work with this 
approach (Philips ARM926-driven board with ARM PrimeCell DMA controller).

> - Probably store those addresses in the spi_transfer struct, using
>   rx_dma and/or tx_dma as appropriate.
>
> - After the DMA transfer completes, call dma_unmap_single() before
>   calling spi_message.complete(spi_message.context).
>
>There are two fancier approaches to consider for sometime later, both
>of which have been used for several years now by host-side USB.
>
>  * SPI controller drivers could require the mappings to already
>    have been done, and stored in {rx,tx}_dma fields.  When those
>    drivers are using DMA, they'd only use those DMA addresses.
>
>    The way host-side USB does that is by having usbcore do work
>    on all the submit and giveback paths.  Currently this SPI
>    framework doesn't do "core" work on those paths; spi_async()
>    just calls directly to the controller driver (no overhead!)
>    and the completion reports likewise go right from controller
>    driver back to the submitter (also, no overhead).
>
>  * Drivers for SPI slave chips might sometimes want to provide their
>    own rx_dma and/or tx_dma values ... either because they mapped the
>    buffers themselves -- great for dma_map_sg()! -- or because the
>    memory came from dma_alloc_coherent().
>  
>
Of course we want to use scatter-gather lists. The DMA controller 
mentioned above can handle only 0xFFF transfer units at a transfer so we 
have to split the large transfers into SG lists.

>    This implies that the controller drivers are ready to accept
>    those DMA addresses, and that there are per-buffer flags saying
>    whether its DMA address is also valid (vs just its CPU address).
>    
>Note that the slave-side USB support only supports the latter, which
>means the USB peripheral controller drivers with DMA support decide
>on a per-request basis whether to do the DMA mappings.  I'd lean
>towards doing that with SPI; it's a bunch simpler.
>  
>
Doesn't look straightforward to me.
Moreover, that looks like it may imply redundant data copying.
Can you please elaborate what you meant by 'readiness to accept DMA 
addresses' for the controller drivers?

As far as I see it now, the whole thing looks wrong. The thing that we 
suggest (i. e. abstract handles for memory allocation set to kmalloc by 
default) is looking far better IMHO and doesn't require any flags which 
usage increases uncertainty in the core.

>Right now DMA isn't on my priority list, but I'd be glad to see
>someone else take further steps there.  Anyone doing bulk I/O to an
>SPI flash chip at 50 MHz is surely going to want DMA for it!
>  
>
Yep, as well as for SPI SD/MMC controllers, SPI WiFi modules, SPI 
Bluetooth modules, etc. etc.

Best regards,
   Vitaly
