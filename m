Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVKASff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVKASff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKASff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:35:35 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:35997 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751102AbVKASfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:35:34 -0500
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Mike Lee <eemike@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1ffb4b070510291125j1fad2362xe40843f7719c611d@mail.gmail.com>
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
	 <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
	 <1130431260.22836.19.camel@localhost.localdomain>
	 <1ffb4b070510291125j1fad2362xe40843f7719c611d@mail.gmail.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Tue, 01 Nov 2005 10:35:31 -0800
Message-Id: <1130870131.10324.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 02:25 +0800, Mike Lee wrote:
> Thanks for your info. I am working hard with that.
> 
Sorry for delayed response.

I'm assuming the you board is configured with the PXA as a SPI master
and the chip you are talking to is the slave (part number of the slave
chip would be helpful).  Which SSP port are you trying to use?

> What in my mind is that SPI clk is only triggered by master and master
> read/write at the same time. But how could master know the read data
> is valid? 
The master determines when the data is valid by asserting the slave chip
select.

> is it determine by the protocol driver? 
Yes, but setup by the board init code.

> In a case, when
> master place a tx-only msg to the controller driver, and slave request
> to send in the middle of the transaction. The data from slave will
> push into the rx buffer of the tx-only msg and finally ignore by the
> protocol driver...... 
I do not believe this can happen when the PXA is in master mode and the
chip is a slave.

> I really get confused to this "full" duplex
> transmittion. Could anyone tell me the real situation?
> 
The PXA SPI master setup only generates a spi data clock when there is
data in the tx fifo thus to read you must write first even if you only
send zeros. The SSP port can be setup to use a free running clock but
this leads to coordination problems with the chip select and is a
limited use when the PXA is the SPI master.  To make this work you will
need to allow the SSP to manage the chip select, see the PXA
documentation.

I would strongly recommend attaching a logic analyzer to the SSP port
you are trying to get working.

> 
> Also, in your pxa_spi driver, you always read before write in the
> interrupt handler. If rx and tx is pointing to the same buffer,
> reading data will always overwrite the tx data. why not write before
> read?
See above. Must write to read.

> 
> I am new to SPI , and with this loose bus structure i could not find a
> good reference for me to study deeper. Do you have any reference
> source?
I never found any documentation on the net, usually the data-sheet for
the chip you are talking to specifies the SPI requirements (master,
slave, clocks, chip selects, etc). Can you send me a link to the chip?

-Stephen

