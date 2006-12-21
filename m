Return-Path: <linux-kernel-owner+w=401wt.eu-S965154AbWLUOlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWLUOlz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWLUOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:41:55 -0500
Received: from mail.atmel.fr ([81.80.104.162]:54722 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965154AbWLUOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:41:54 -0500
Message-ID: <458A9CCB.5050108@rfo.atmel.com>
Date: Thu, 21 Dec 2006 15:40:11 +0100
From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Organization: atmel
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Patrice Vilchez <patrice.vilchez@rfo.atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
References: <4582BD29.4020203@rfo.atmel.com> <200612201513.09705.david-b@pacbell.net> <458A875D.3000801@rfo.atmel.com>
In-Reply-To: <458A875D.3000801@rfo.atmel.com>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 8bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Ferre a écrit :
>>> As the SPI underlying code behaves quite differently from a 
>>> controller driver
>>> to another whan not having a tx_buf filled, I have add a zerroed 
>>> buffer to give
>>> to the spi layer while receiving data.
>>
>> You must be working with a buggy controller driver then.  That part of
>> this patch should never be needed.  It's expected that rx-only transfers
>> will omit a tx buf; all controller drivers must handle that case.
> 
> I said that because it is true that most of spi controller drivers 
> manage rx only transactions filling the tx buffer with zerros but the 
> spi_s3c24xx.c driver seems to fill with ones (line 177 hw_txbyte())
> 
> Anyway, I will check in our controller driver to sort this out.

I dug a bit into this.
Well, in the atmel_spi driver code, we use previous rx buffer if we do 
not provide a tx_buf (as it is said that in struct spi_transfer 
comments,  "If the transmit buffer is null, undefined data will be 
shifted out while filling rx_buf").
So, the touchscreen controller sees sometimes a "start" condition (bit 7 
of a control byte). It then takes the control byte and sets trash bits 
as a configuration. I ran into those troubles and add a zerroed buffer 
as tx.

Do you think that shifting zerros out when a tx_buf is not specified is 
the desired behavior ?

Regards,
-- 
Nicolas Ferre


