Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVLVQkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVLVQkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLVQkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:40:36 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:59003 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965166AbVLVQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:40:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
Date: Thu, 22 Dec 2005 08:40:33 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
References: <20051222180449.4335a8e6.vwool@ru.mvista.com>
In-Reply-To: <20051222180449.4335a8e6.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512220840.34152.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 December 2005 7:04 am, Vitaly Wool wrote:
> Hi David,
> 
> inlined is the small patch that adds set_clock function to the spi_bitbang structure.

This is actually not needed.  Clocks are set through the setup() method
in the spi_master, and controller drivers are (courtesy of the library
approach) free to provide their own.  Drivers for word-at-a-time hardware
would still need to call spi_bitbang_setup() in their own setup() code,
to set up the per-device controller_state, and spi_bitbang_cleanup() in
their own cleanup() code, to deallocate it.


> Currently SPI bus clock can be configured either in chipselect() (which is _wrong_)
> or in txrx_buf (also doesn't encourage me much). Making it a separate function adds
> readability for the code.   Also, it seems to be redundant to set clock on each
> transfer, so it's proposed to do per-message clock setting. If SPI bus clock
> setting involves some PLL reconfiguration it's definitely gonna save some time.  

Exactly why there's already spi_setup() in the common infrastruture,
and why the spi_bitbang_{setup,cleanup}() routines are exported for
simple drivers to shift-register level hardware.  The real "bang four
bits into protocol" style drivers won't need that since the bitbang
setup() calls calculate the delays used to satisfy those timings.
But hardware drivers -- for word-at-a-time or buffer-at-a-time style
usage -- would need that to set the clock dividers.

- Dave


/**
 * spi_setup -- setup SPI mode and clock rate
 * @spi: the device whose settings are being modified
 *
 * SPI protocol drivers may need to update the transfer mode if the
 * device doesn't work with the mode 0 default.  They may likewise need
 * to update clock rates or word sizes from initial values.  This function
 * changes those settings, and must be called from a context that can sleep.
 */
static inline int
spi_setup(struct spi_device *spi)
{
        return spi->master->setup(spi);
}


