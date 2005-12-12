Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVLLPUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVLLPUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLLPUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:20:03 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:54177 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750809AbVLLPUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:20:01 -0500
Date: Mon, 12 Dec 2005 18:20:26 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: [PATCH 2.6-git 0/4] SPI core refresh
Message-Id: <20051212182026.4e393d5a.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

this message fill be followed by the following four ones:
1) updated SPI core from Dmitry Pervushin/Vitaly Wool
2) Atmel MTD dataflash driver port for this core
3) SPI controller driver for Philips SPI controller
4) dumb EEPROM driver for EEPROM chip on SPI bus

This SPI core features:
* multiple SPI controller support
* multiple devices on the same bus support
* DMA support
* synchronous and asynchronous transfers
* library for asynchronous transfers on the bus using kernel threads
* character device interface
* custom lightweight SPI message allocation mechanism

The SPI core is now closer to the other one, David Brownell's. For instance, spi_driver structure is now the same, and some API functions are mostly quite similar. Even the footprint is now similar (~2k .text on ARM) :)

However, there are some differences I'd like to summarize:
* this core doesn't support hotplug, and David's does (we'll post this support later in a separate patch)
* our core is transparent for DMA transfers (allocation of DMA-safe buffer is triggered by the message flag set by the caller) and David's one implies limitations on tx/rx buffers passed (which can be easily resolved in the controller driver though)
* our core implements thread-based asynchronous message handling (as an option!) which seems to be the best way to go for most cases. i. e. PXA SSP driver from Stephen would be a lot more lightweight and will gain more performance if it used this method instead of multiple tasklets scheduling (as of now)
* our core hides the SPI message internals and David's exposes them to the outer world. This is in way more robust since the only way to allocate the message is through the API
* our core uses uniform message structure for all transfers and "chains" such messages, and David's uses separate spi_transfer array which hold the chain and is attached to the message structure. It's arguable which one is better; at least ours allows to easily change the message inetrnals w/o affecting actual drivers and use versatile message allocation techniques
* our core allows to omit callbacks for sync transfers which is a reasonable thing IMO (if it's a sync transfer, then the caller will just wait, so having a default callback that just waits-for-completion is rational)
* our core provides more straightfoward means (leading to improved readability of the actual drivers) to express the same things, i. e instead of
>	message->status = -EIO;
>	if (message->complete) {
>		message->complete(message->context);
>	}
one is only to do
>	spimsg_complete(message, -EIO);
or, instead of
>		if (!message->transfers[state->index].cs_change)
>			state->cs_control(PXA2XX_CS_DEASSERT);
one is to do
>		if (spimsg_get_flags(cur_msg) & SPI_M_CSKEEP)
>			state->cs_control(PXA2XX_CS_DEASSERT);
* other minor differences... maybe David's gonna add some here.

Vitaly
