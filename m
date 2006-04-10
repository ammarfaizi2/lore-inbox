Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWDJUDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWDJUDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWDJUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:03:47 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:15760 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932128AbWDJUDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:03:47 -0400
Message-ID: <443ABA1A.1060801@gmail.com>
Date: Tue, 11 Apr 2006 00:03:38 +0400
From: Vitaly Wool <vitalywool@gmail.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
CC: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH][2.16.17-rc1-mm2] spi: Added spi master
 driver for Freescale MPC83xx SPI controller
References: <Pine.LNX.4.44.0604101414500.5501-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0604101414500.5501-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kumar Gala wrote:

>+irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data,
>+			    struct pt_regs * ptregs)
>+{
>+	struct mpc83xx_spi *mpc83xx_spi = context_data;
>+	u32 event;
>+	irqreturn_t ret = IRQ_NONE;
>+
>+	/* Get interrupt events(tx/rx) */
>+	event = mpc83xx_spi_read_reg(&mpc83xx_spi->base->event);
>+
>+	/* We need handle RX first */
>+	if (event & SPIE_NE) {
>+		u32 rx_data = mpc83xx_spi_read_reg(&mpc83xx_spi->base->receive);
>+
>+		if (mpc83xx_spi->rx)
>+			mpc83xx_spi->get_rx(rx_data, mpc83xx_spi);
>+
>+		ret = IRQ_HANDLED;
>+	}
>+
>+	if ((event & SPIE_NF) == 0)
>+		/* spin until TX is done */
>+		while (((event =
>+			 mpc83xx_spi_read_reg(&mpc83xx_spi->base->event)) &
>+						SPIE_NF) == 0)
>+			 ;
>  
>
This is a potentially endless loop so two questions here.
First, did you do any measurements on how long it can loop here?
The, what if a bus error occurs and this bit is never set?

>+
>+	mpc83xx_spi->count -= 1;
>+	if (mpc83xx_spi->count) {
>+		if (mpc83xx_spi->tx) {
>+			u32 word = mpc83xx_spi->get_tx(mpc83xx_spi);
>+			mpc83xx_spi_write_reg(&mpc83xx_spi->base->transmit,
>+					      word);
>+		}
>+	} else {
>+		complete(&mpc83xx_spi->done);
>+	}
>  
>
So, if it's not SPIE_NF, it's not marked as HANDLED?

Vitaly
