Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVJ0QlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVJ0QlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVJ0QlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:41:04 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:27106 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751254AbVJ0QlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:41:03 -0400
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Mike Lee <eemike@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
In-Reply-To: <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
	 <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Thu, 27 Oct 2005 09:41:00 -0700
Message-Id: <1130431260.22836.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 19:33 +0800, Mike Lee wrote:
> Dear Stepen
>    I am now writing another controller driver by david's framework.
> But leak of debuging layer, could your loopback driver serve for this
> purpose and how could i use it?
> 

The file pxa2xx_loopback.c should be controller independent, but it does
require that the hardware (in my case the PXA255 NSSP) support a
loopback mode (i.e. tx connected to rx).

To create a loopback device for driver you should include:

static struct pxa2xx_spi_chip loopback_chip_info = {
	.mode = SPI_MODE_3,
	.tx_threshold = 12,
	.rx_threshold = 4,
	.dma_burst_size = 8,
	.bits_per_word = 8,
	.timeout_microsecs = 64,
	.enable_loopback = 1,
};

static struct spi_board_info streetracer_spi_board_info[] __initdata = {
	{
		.modalias = "loopback",
		.max_speed_hz = 3686400,
		.bus_num = 2,
		.chip_select = 3,
		.controller_data = &loopback_chip_info,
	},
};

in your board init code and install the module per your configuration.
Anything written to /dev/slp23 will be echoed back to /dev/slp23 via the
"SPI controller".

Hope this helps!

-Stephen


