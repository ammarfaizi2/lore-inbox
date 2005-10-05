Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVJEQVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVJEQVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVJEQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:21:42 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:15850 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030208AbVJEQVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:21:41 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=pAGOjIrfIs3GDitYdfq0AWdfNNcs38OWDA8Be/+z4ckSbqSwIXr0KmdmaTUeBRro8
	SQQLB6Rnlu+mX4AnWmbRg==
Date: Wed, 05 Oct 2005 09:21:17 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course we want to use scatter-gather lists.

The only way "of course" applies is if you're accepting requests
from the block layer, which talks in terms of "struct scatterlist".

In my investigations of SPI, I don't happen to have come across any
SPI slave device that would naturally be handled as a block device.
There's lots of flash (and dataflash); that's MTD, not block.


>	The DMA controller 
> mentioned above can handle only 0xFFF transfer units at a transfer so we 
> have to split the large transfers into SG lists.

Odd, I've seen plenty other drivers that just segment large buffers
into multiple DMA transfers ... without wanting "struct scatterlist".

  - Sometimes they turn them into lists of DMA descriptors handled
    by their DMA controller.  Even the silicon designers who talk
    to Linux developers wouldn't choose "struct scatterlist" to
    hold those descriptors

  - More often they just break big buffers into lots of little
    transfers.  Just like PIO, but faster.  (And in fact, they may
    need to prime the pump with some PIO to align the buffer.)

  - Sometimes they just reject segments that are too large to
    handle cleanly at a low level, and require higher level code
    to provide more byte-sized blocks of I/O.

If "now" _were_ the point we need to handle scatterlists, I've shown
a nice efficient way to handle them, already well proven in the context
of another serial bus protocol (USB).


> Moreover, that looks like it may imply redundant data copying.

Absolutely not.  Everything was aimed at zero-copy I/O; why do
you think I carefully described "DMA mapping" everywhere, rather
than "memcpy"?


> Can you please elaborate what you meant by 'readiness to accept DMA 
> addresses' for the controller drivers?

Go look at the parts of the USB stack I mentioned.  That's what I mean.

 - In the one case, DMA-aware controller drivers look at each buffer
   to determine whether they have to manage the mappings themselves.
   If the caller provided the DMA address, they won't set up mappings.

 - In the other case, they always expect their caller to have set
   up the DMA mappings.  (Where "caller" is infrastructure code,
   not the actual driver issuing the I/O request.)

The guts of such drivers would only talk in terms of DMA; the way those
cases differ is how the driver entry/exit points ensure that can be done.


> As far as I see it now, the whole thing looks wrong. The thing that we 
> suggest (i. e. abstract handles for memory allocation set to kmalloc by 
> default) is looking far better IMHO and doesn't require any flags which 
> usage increases uncertainty in the core.

You are conflating memory allocation with DMA mapping.  Those notions
are quite distinct, except for dma_alloc_coherent() where one operation
does both.

The normal goal for drivers is to accept buffers allocated from anywhere
that Documentation/DMA-mapping.txt describes as being DMA-safe ... and
less often, message passing frameworks will do what USB does and accept
DMA addresses rather than CPU addresses.

- Dave

