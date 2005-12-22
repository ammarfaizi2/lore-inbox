Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVLVR2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVLVR2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVLVR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:28:36 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:39080 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030210AbVLVR2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:28:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
Date: Thu, 22 Dec 2005 09:28:33 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512181059.14301.david-b@pacbell.net> <43A84730.9020602@ru.mvista.com>
In-Reply-To: <43A84730.9020602@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200512220928.34457.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 10:02 am, Vitaly Wool wrote:
> Hi David --
> 
> just a cuple of notes here and below...
> 
> General one: how is it supposed to set SPI bus clock in this model? I 
> guess that the only option is to set it in txrx_*.

No, as I said separately:  the standard spi_master.setup() call does
this.  Things are arranged so that drivers using this code can splice
in their own code for it ... true bitbangers won't, because the
delays in the I/O loops suffice.  But drivers using "word-at-a-time"
controllers (hardware-assisted shift registers!) will, as will ones
that do "buffer-at-a-time" I/O (e.g. to stuff/unstuff fifos, or set
up non-queued DMA).


> >	if (!spi->max_speed_hz)
> >		spi->max_speed_hz = 500 * 1000;
> >
> >	/* nsecs = max(50, (clock period)/2), be optimistic */
> >	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
> >	if (cs->nsecs < 50)
> >		cs->nsecs = 50;
> >  
> >
> Suggest not to hardcode values here.

I suppose it'd make sense to just fail if max_speed_hz is invalid,
and if there's some board that an bitbang at over 10MHz we should
avoid getting in its way.


> >			/* set up default clock polarity, and activate chip */
> >			if (!chipselect) {
> >				bitbang->chipselect(spi, 1);
> >				ndelay(nsecs);
> >  
> >
> Suggest special enum/define for chipselect value.

Added.  Instead of "1", "BITBANG_CS_ACTIVE" ... which will normally
pull the nCS line low (after setting clock to match CPOL).


> >			/* protocol tweaks before next transfer */
> >			if (t->delay_usecs)
> >				udelay(t->delay_usecs);
> >  
> >
> Suggest nsecs here as well.

The relevant chip delays seem to be specified in usecs ... I don't
like using nsecs for the clock timings, but without doing that it'd
be impractical to define rates at the levels the hardware actually
uses.  There are still some "nsec" leakages out of the real-bitbang
code up to the next level, fixable over time.

 
> >                               /* FIXME if bitbang->use_dma, dma_map_single()
> >                                * before the transfer, and dma_unmap_single()
> >                                * afterwards, for either or both buffers...
> >                                */  
> 
> please *please* *_please_*!!! don't do it! :)
> Let the controller driver do it *only in case it's not working in PIO!*

OK.  That'd be more work for the controller driver, but you're
right that a lot of the drivers using these utilities are rather
likely to be PIO-oriented.  If they want DMA speedups, they can
do the mappings themselves (in cases where the driver didn't
do them already).


> Another one: I just feel comfortabel with using 'bitbang' term for the 
> variety of SPI stuff which this library suits.

You _do_ feel comfortable with it?  I actually feel a bit odd, since
only one of the three driver types is really bitbanging.  And in fact
it still bothers me that the other two tie down a task, but that's
the price for reusing common infrastructure.

- Dave

