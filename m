Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVJ2SZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVJ2SZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJ2SZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:25:36 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:43478 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751246AbVJ2SZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:25:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7tOvANvePTDaTcDTiHuZe49FNO/+deGUGNR4cu1lti0TdM5aMmwbFv9DUOQNMUJ/rMGAMXTmr8+U5MQJQskD0HC9VO+56kDDybuXDwTlc0Grnu3rdW6crUdPbqCXhEsUFA6j1qBlmtAX1vbzX5hOrWDbhatJgGtOZbW0eMZbRw=
Message-ID: <1ffb4b070510291125j1fad2362xe40843f7719c611d@mail.gmail.com>
Date: Sun, 30 Oct 2005 02:25:34 +0800
From: Mike Lee <eemike@gmail.com>
To: stephen@streetfiresound.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
In-Reply-To: <1130431260.22836.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
	 <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
	 <1130431260.22836.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your info. I am working hard with that.

By the way, i have some problems with the SPI hardware arch. Please correct me.

What in my mind is that SPI clk is only triggered by master and master
read/write at the same time. But how could master know the read data
is valid? is it determine by the protocol driver? In a case, when
master place a tx-only msg to the controller driver, and slave request
to send in the middle of the transaction. The data from slave will
push into the rx buffer of the tx-only msg and finally ignore by the
protocol driver...... I really get confused to this "full" duplex
transmittion. Could anyone tell me the real situation?


Also, in your pxa_spi driver, you always read before write in the
interrupt handler. If rx and tx is pointing to the same buffer,
reading data will always overwrite the tx data. why not write before
read?

I am new to SPI , and with this loose bus structure i could not find a
good reference for me to study deeper. Do you have any reference
source?

Thanks for concern and patience
Mike,Lee

On 10/28/05, Stephen Street <stephen@streetfiresound.com> wrote:
> On Thu, 2005-10-27 at 19:33 +0800, Mike Lee wrote:
> > Dear Stepen
> >    I am now writing another controller driver by david's framework.
> > But leak of debuging layer, could your loopback driver serve for this
> > purpose and how could i use it?
> >
>
> The file pxa2xx_loopback.c should be controller independent, but it does
> require that the hardware (in my case the PXA255 NSSP) support a
> loopback mode (i.e. tx connected to rx).
>
> To create a loopback device for driver you should include:
>
> static struct pxa2xx_spi_chip loopback_chip_info = {
>        .mode = SPI_MODE_3,
>        .tx_threshold = 12,
>        .rx_threshold = 4,
>        .dma_burst_size = 8,
>        .bits_per_word = 8,
>        .timeout_microsecs = 64,
>        .enable_loopback = 1,
> };
>
> static struct spi_board_info streetracer_spi_board_info[] __initdata = {
>        {
>                .modalias = "loopback",
>                .max_speed_hz = 3686400,
>                .bus_num = 2,
>                .chip_select = 3,
>                .controller_data = &loopback_chip_info,
>        },
> };
>
> in your board init code and install the module per your configuration.
> Anything written to /dev/slp23 will be echoed back to /dev/slp23 via the
> "SPI controller".
>
> Hope this helps!
>
> -Stephen
>
>
>


--
-----------------------------------------------
Mike Lee
