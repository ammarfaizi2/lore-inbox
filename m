Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWDJUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWDJUWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDJUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:22:36 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:27692 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751178AbWDJUWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:22:35 -0400
In-Reply-To: <443ABA1A.1060801@gmail.com>
References: <Pine.LNX.4.44.0604101414500.5501-100000@gate.crashing.org> <443ABA1A.1060801@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB5A4A6A-BCD0-4DD0-A0F4-E155495EDCC6@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH][2.16.17-rc1-mm2] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Mon, 10 Apr 2006 15:22:38 -0500
To: Vitaly Wool <vitalywool@gmail.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 10, 2006, at 3:03 PM, Vitaly Wool wrote:

> Hi,
>
> Kumar Gala wrote:
>
>> +irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data,
>> +			    struct pt_regs * ptregs)
>> +{
>> +	struct mpc83xx_spi *mpc83xx_spi = context_data;
>> +	u32 event;
>> +	irqreturn_t ret = IRQ_NONE;
>> +
>> +	/* Get interrupt events(tx/rx) */
>> +	event = mpc83xx_spi_read_reg(&mpc83xx_spi->base->event);
>> +
>> +	/* We need handle RX first */
>> +	if (event & SPIE_NE) {
>> +		u32 rx_data = mpc83xx_spi_read_reg(&mpc83xx_spi->base->receive);
>> +
>> +		if (mpc83xx_spi->rx)
>> +			mpc83xx_spi->get_rx(rx_data, mpc83xx_spi);
>> +
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	if ((event & SPIE_NF) == 0)
>> +		/* spin until TX is done */
>> +		while (((event =
>> +			 mpc83xx_spi_read_reg(&mpc83xx_spi->base->event)) &
>> +						SPIE_NF) == 0)
>> +			 ;
>>
> This is a potentially endless loop so two questions here.
> First, did you do any measurements on how long it can loop here?
> The, what if a bus error occurs and this bit is never set?

In my measurements the if is never true, so we never spin.

I wasn't particular happy about the spinning for ever, wasn't sure  
what would be better.  I need to ensure we've gotten both a TX & RX  
event before transmitting the next character.  I'm open to  
suggestions on how to do this better.

>> +
>> +	mpc83xx_spi->count -= 1;
>> +	if (mpc83xx_spi->count) {
>> +		if (mpc83xx_spi->tx) {
>> +			u32 word = mpc83xx_spi->get_tx(mpc83xx_spi);
>> +			mpc83xx_spi_write_reg(&mpc83xx_spi->base->transmit,
>> +					      word);
>> +		}
>> +	} else {
>> +		complete(&mpc83xx_spi->done);
>> +	}
>>
> So, if it's not SPIE_NF, it's not marked as HANDLED?

I wasn't sure what the best thing here was.  In truth we will only  
get an interrupt if SPIE_NF is set so it should always be handled.


