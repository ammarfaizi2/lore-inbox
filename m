Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbSLENE6>; Thu, 5 Dec 2002 08:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbSLENE6>; Thu, 5 Dec 2002 08:04:58 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:55047 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267315AbSLENE5>; Thu, 5 Dec 2002 08:04:57 -0500
Date: Thu, 5 Dec 2002 16:12:05 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [BKPATCH] allow pci primary peer busses to have parents
Message-ID: <20021205161205.A6419@jurassic.park.msu.ru>
References: <200212041718.gB4HIO702869@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212041718.gB4HIO702869@localhost.localdomain>; from James.Bottomley@SteelEye.com on Wed, Dec 04, 2002 at 11:18:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:18:24AM -0600, James Bottomley wrote:
> Now that the generic device model allows a coherent bus tree to be built

Unfortunately it doesn't. Currently those legacy, PnP, EISA devices all have
virtual parents, which has nothing to do with reality. Modern systems
(including most PCs) hang these buses off PCI bus using PCI-to-{E}ISA
bridge. Such systems must be able to register these buses upon
discovery of the ISA bridges (from pci layer), and use them as a
parent device for legacy/isa/pnp stuff. This will be absolutely required
if DMA operations are moved from pci_dev to the generic device.

> -struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops, void 
> *sysdata)
> +struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int 
> bus, struct pci_ops *ops, void *sysdata)
>  {
> -	struct pci_bus *b = pci_alloc_primary_bus(bus);
> +	struct pci_bus *b = pci_alloc_primary_bus_parented(parent, bus);
>  	if (b) {
>  		b->sysdata = sysdata;
>  		b->ops = ops;

The `sysdata' arg already contains info about parent host-to-pci controller
on many platforms. I don't think that we need to duplicate it with
another one.
I was thinking about something like this instead of `sysdata':

struct io_controller {		/* Level 0 I/O controller */
	... arch specific fields ...;
	... generic fields ...;	/* like `index' */
	struct device dev;
}

Ivan.
