Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135883AbRECSM4>; Thu, 3 May 2001 14:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135879AbRECSMq>; Thu, 3 May 2001 14:12:46 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135870AbRECSM1>; Thu, 3 May 2001 14:12:27 -0400
Date: Thu, 3 May 2001 11:12:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <E14vNFo-0005uM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105031106030.30573-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 May 2001, Alan Cox wrote:
> 
> Obvious one is to go to the next power of two clear. 

The question is mainly _which_ power of two. 

I don't think we can round up infinitely, as that might just end up
causing us to not have any PCI space at all. Or we could end up deciding
that real PCI space is memory, and then getting a clash when a real device
tries to register its bios-allocated area that clashes with our extreme
rounding.

I suspect it would be safe to round up to the next megabyte, possibly up
to 64MB or so. But much more would make me nervous.

Any suggestions? 

> Semi related question: To do I2O properly I need to grab PCI bus space and
> 'loan' it to the controller when I configure it. Im wondering what the
> preferred approach there is.

Do the same thing that the yenta driver does, just do a 

	root = pci_find_parent_resource(dev, res);
	allocate_resource(root, res, size, min, max, align, NULL, NULL);

and keep it allocated (and then the i2o driver can do sub-allocations
within that resource by doing "allocate_resource(res, ...)").

		Linus

