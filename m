Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbWLVUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWLVUGA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLVUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:05:59 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:25661 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752531AbWLVUF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:05:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZHZSD/RfQR0OF4BOJy1dQ+NAEXLYYYRTcduoOTrxAZauUkqf/R1Gp2WkJzcO7W7Ch3wmmlicq/zMXc/tBbczXOzanJmlVdsiF8T5BYVw+CFXuhpd70yPR1T80bQU1DUmwslbr9I4jfavTT0+99Ufq3L5tvWYw3Cth6U7wzMfj3g=  ;
X-YMail-OSG: MDX.RdYVM1kz1FfUF30jrOVe7emkEzt2aT2Ph.SiX1FvmKn19EoZBlzph7jpC_Zcelu6rCFXWD4.LB4_bRPGRqMJBGtTRhvp.mVRNRyBtHWHf1jHFJTvWX4v9AN_8HN0J1YXfGymV8woYJLrHwtLKMDIFrsGY03OuHR6Bc84D.F_zR6udvahTJVGOC6j
From: David Brownell <david-b@pacbell.net>
To: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
Date: Fri, 22 Dec 2006 12:05:55 -0800
User-Agent: KMail/1.7.1
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Patrice Vilchez <patrice.vilchez@rfo.atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <4582BD29.4020203@rfo.atmel.com> <458A875D.3000801@rfo.atmel.com> <458A9CCB.5050108@rfo.atmel.com>
In-Reply-To: <458A9CCB.5050108@rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200612221205.55750.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 December 2006 6:40 am, Nicolas Ferre wrote:
> Nicolas Ferre a écrit :
> >>> As the SPI underlying code behaves quite differently from a 
> >>> controller driver to another whan not having a tx_buf filled,
> >>> I have add a zerroed buffer to give to the spi layer while
> >>> receiving data. 
> >>
> >> You must be working with a buggy controller driver then.  That part of
> >> this patch should never be needed.  It's expected that rx-only transfers
> >> will omit a tx buf; all controller drivers must handle that case.
> > 
> > I said that because it is true that most of spi controller drivers 
> > manage rx only transactions filling the tx buffer with zerros but the 
> > spi_s3c24xx.c driver seems to fill with ones (line 177 hw_txbyte())
> > 
> > Anyway, I will check in our controller driver to sort this out.
> 
> I dug a bit into this.

I always like to see followup on such issues.  :)


> Well, in the atmel_spi driver code, we use previous rx buffer if we do 
> not provide a tx_buf (as it is said that in struct spi_transfer 
> comments,  "If the transmit buffer is null, undefined data will be 
> shifted out while filling rx_buf").

That seems like a reasonable approach.  If it's undefined, the only
reasons I can think of to not use the rx buffer are that:

 (a) the cachelines might not be managed correctly during DMA ...
     i.e. to defend against a bug in the controller driver; and
 (b) that writing such _defined_ data would be a "covert channel"
     in the security sense.

Now, (a) is just a bug to fix, and in most cases (b) won't be an
issue since even if the system with that driver is being evaluated
at a level where such channels matter, the hardware hooked up via
SPI will probably already be trusted.  (Unless the system allows
thing like MMC or SD cards...)  However, see below.


> So, the touchscreen controller sees sometimes a "start" condition (bit 7 
> of a control byte). It then takes the control byte and sets trash bits 
> as a configuration.

Actually, now that I look at it I see that the docs for both the
ads7846 and the ads7843 show that DIN/MOSI should be zero/low
after the command is given, while reading DOUT/MISO.

Which means that the real issue here is that the driver was wrong
in the first place to not explicitly write zeroes while it's reading
back that data.

The testing I've done with it involved two controller drivers which
do happen to interpret "undefined" as "write zeros":  omap_uwire,
which I'm guessing does so in hardware (MicroWire is half duplex),
and pxa2xx_spi, which explicitly writes zeros (null_writer).


> I ran into those troubles and add a zerroed buffer as tx.
> 
> Do you think that shifting zerros out when a tx_buf is not specified is 
> the desired behavior ?

I'm leaning towards a "yes" there -- changing the spec for spi_transfer.

The alternative would seem to mean teaching the SPI interface about
two different kinds of "rx only" transfers, one with "must tx zero"
semantics and the other with "tx data doesn't matter" (and security
audits would define it anyway, to avoid covert channels).  And I can't
easily justify that.

For now, I'd suggest you update the atmel_spi driver so that it shifts
zeroes in that case; can't hurt (too much).  And I'll forward the issue
to the SPI list.  If nobody there objects, I'll send patches to update
the spec for spi_transfer, and the s3c driver.

- Dave

