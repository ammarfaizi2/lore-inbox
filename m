Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTD2Kxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 06:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTD2Kxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 06:53:55 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10762 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261335AbTD2Kxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 06:53:54 -0400
Date: Tue, 29 Apr 2003 15:05:32 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429150532.A3984@jurassic.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Mon, Apr 28, 2003 at 08:38:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 08:38:27PM +0200, Marc Zyngier wrote:
> As part of my effort to get the Jensen up and running on the latest
> 2.5 kernels, I have introduced some support for the DMA API, rather
> than relying on the generic PCI based one (which introduces problems
> with the EISA bus).

Since the Jensen is the only non-PCI alpha, I'd really prefer to
keep existing pci_* functions as is and make dma_* ones just
wrappers.
Actually what we need is a single function, for now just

struct pci_dev *
pci_dev_to_pci(struct device *dev)
{
	if (dev && dev->bus == &pci_bus_type)
		return = to_pci_dev(dev);
	/* Some day we'll be able to play nicely with "isa_bridge",
	   device parents and dma masks here (hopefully). */
	return NULL;
}

Then the rest would be

static inline dma_addr_t
dma_map_single(struct device *dev, void *cpu_addr, size_t size,
	       enum dma_data_direction dir)
{
	return pci_map_single(pci_dev_to_pci(dev), cpu_addr, size, dir);
}

and so on.

Though it's perfectly ok to have Jensen-specific dma_* stuff.

Ivan.
