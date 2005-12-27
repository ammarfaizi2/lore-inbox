Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVL0UVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVL0UVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 15:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVL0UVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 15:21:47 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:35135 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S1751064AbVL0UVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 15:21:47 -0500
X-Author: vitalhome@rbcmail.ru from [10.1.27.2] ([82.179.192.198]) via Free Mail POCHTA.RU
Message-ID: <43B1A237.2080808@ru.mvista.com>
Date: Tue, 27 Dec 2005 23:21:11 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SPI: add support for PNX/SPI controller
References: <20051223171506.76aba97a.vwool@ru.mvista.com> <200512270925.28806.david-b@pacbell.net>
In-Reply-To: <200512270925.28806.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Friday 23 December 2005 6:15 am, Vitaly Wool wrote:
>  
>
>>(PNX0106 and PNX4008, namely) based on spi_bitbang library 
>>    
>>
>
>Good!  Does need work yet though...
>  
>
Yup...

>> # Add new SPI master controllers in alphabetical order above this line
>>    
>>
>
>Note how it says "above", yet you've added yours ... below!  :(
>
>
>  
>
>> #
>> 
>>+config SPI_PNX
>>+	tristate "PNX SPI bus support"
>>+	depends on ARCH_PNX4008 && SPI_BITBANG
>>    
>>
>
>... also added the eeprom so it shows in the list of controller drivers!!
>
>  
>
Oh sorry. Stupid me... Not that it matters really since this driver's 
not yet mature enough anyway.

>  
>
>>+config SPI_EEPROM
>>+	tristate "SPI EEPROM"
>>+	depends on SPI
>>+
>> 
>>    
>>
>
>  
>
>>+#define lock_device( dev )	/* down( &dev->sem ); */
>>+#define unlock_device( dev )	/* up( &dev->sem );   */
>>    
>>
>
>Not clear why you'd want such stuff ... better to just remove
>NOPs like that.
>
>  
>
They caused problems on 2.6.10... I might have uncommented that but I 
saw no reason. This driver is now is in FYI state :)

>
>  
>
>>+static void
>>+spi_pnx_chipselect(struct spi_device *spi, int is_on)
>>+{
>>+	spipnx_arch_cs(spi, is_on);
>>+}
>>    
>>
>
>I see that "arch" hook is actually just toggling a DMA line.
>Did you notice how Stephen's PXA code handled that?  The
>"controller_data" was a board-specific GPIO toggle function,
>as provided in the board_info that implicitly defines the
>relevant device.
>
>Plus, activating the chip does more than just toggling some
>arch-specific GPIO.  It has to set the right SPI mode, of
>which CPOL must be set _before_ chipselect goes active.
>And it has to set the transfer clock, for chips like yours
>which are multiplexing devices using software.
>  
>
Yep, the current way of doing stuff is a sort of abuse to the driver's 
model.
It's just "put #ifdefs out of the C dode" thing. We're gonna rewrite 
that using controller_data but in our case that's gonna be a structure 
with several functions and data needed. We have more arch-specific stuff 
to care about than Stephen's PXA code, so we just didn't bother at the 
moment; but anyway you're right.

>
>  
>
>>+static int spi_pnx_xfer(struct spi_device *spidev, struct spi_transfer *t)
>>+{
>>    
>>
>...
>  
>
>>+	if (spidev->max_speed_hz)
>>+		spi_pnx_set_clock_rate(spidev->max_speed_hz / 1000, regs);
>>    
>>
>
>Just do it the one time, when activating that chip's selection.
>  
>
Nm really in our case, we have to reset the chip at each direction 
change due to hardware bug.

>
>...
>  
>
>>+	if (t->tx_buf) {
>>+		dat = (u8 *)t->tx_buf;
>>+		regs->con |= SPIPNX_CON_RXTX;
>>+		regs->ier |= SPIPNX_IER_EOT;
>>+		regs->con &= ~SPIPNX_CON_SHIFT_OFF;
>>+		regs->frm = len;
>>+
>>+		if (dd->dma_mode && len >= FIFO_CHUNK_SIZE) {
>>+			void *dmasafe = NULL;
>>+			if (t->tx_dma)
>>    
>>
>
>That's not actually correct, since zero might be a legal DMA address.
>Unfortunately we have no DMA_ADDR_INVALID to test against, so this
>will need to suffice for now.  (And I updated the spi_bitbang code
>to ensure that address _is_ zeroed  when the message didn't set up
>the DMA addresses already, matching the default behavior.)
>  
>
Hmm, DMA_ADDR_INVALID... (u_long)-1 ?

>
>  
>
>>+				params.dma_buffer = t->tx_dma;
>>+			else {
>>+				dmasafe = kmalloc(len, SLAB_KERNEL);
>>+				if (!dmasafe) {
>>+					len = 0;
>>+					goto out;
>>+				}
>>+				params.dma_buffer = dma_map_single(dev->parent, dmasafe, len, DMA_TO_DEVICE);
>>+				memcpy(dmasafe, dat, len);
>>    
>>
>
>You do know this is incorrect don't you?  Call dma_map_single()
>if you need a dma address.  The caller already guaranteed that the
>input address is dma-safe.
>  
>
Well it didn't :) See eeprom.c.
It's not the way to go however, but it's nice to have ability to add DMA 
safety in some controller drivers working with weird device drivers :/

>...
>  
>
>>+	}
>>+
>>+	if (t->rx_buf) {
>>    
>>
>...
>  
>
>>+	}
>>    
>>
>
>That RX bit sure looks wrong to me ... as if, given an spi_transfer
>with both TX and RX buffers, it will execute them in sequence (half
>duplex) rather than concurrently (full duplex).  SPI is full duplex,
>and this code should be too.  If it can't implement that, then it
>should be reporting an error if both rx and tx are requested, rather
>than doing the wrong thing.
>  
>
This particular controller is full duplex but it has some hw problems 
working in FD mode.
This is a workaround for FD which looks ok to me.

>  
>
>>+	if (rc < 0)
>>+		goto out;
>>+
>>+	data = kzalloc(sizeof *data, GFP_KERNEL);
>>    
>>
>
>You don't need that kzalloc, it was already done for you by virtue of
>your telling spi_alloc_master() to do so.  But then you saved that
>memory into "pnx" not "data" (bug! wrong size!).  What you should be
>doing is nesting your bitbang structure inside the "data" thing.
>
>  
>
Agreed.

>Likewise, mark this __exit.  And I suspect you're using some kernel
>older than 2.6.15-rc6 ... ;)
>  
>
Definitely, it was quickly ported from 2.6.10.

>I notice your header file was mostly inline function declarations,
>even for basic parts like clocking and DMA.  That's best as part
>of the driver itself, if it's not following some framework like
>the <asm/hardware/clock.h> API on ARM.
>  
>
Well, these all platform-specific functions are gonna be in 
controller_data some day... hopefully soon.

Vitaly

