Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFQJ3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTFQJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:29:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:11525 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261428AbTFQJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:29:07 -0400
Date: Tue, 17 Jun 2003 13:41:56 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617134156.A2473@jurassic.park.msu.ru>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617044948.GA1172@krispykreme>; from anton@samba.org on Tue, Jun 17, 2003 at 02:49:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 02:49:48PM +1000, Anton Blanchard wrote:
> And only creates /proc/bus/pci entries for the first domain.

Err, this definitely breaks X on alpha. On small and mid-range
machines we always have pci_domain_nr(bus) == bus->number.
Practically, it's only Marvel where we could overflow an 8-bit
bus number.

> Finally there was some shuffling required to make pci_bus_exists work
> (passing in a pci_bus *, ->sysdata and ->number must be initialised
> before calling it). There are some uses of pci_bus_exists in x86 that
> will need updating.
> 
> Thoungts?

Looks good to me, except this (see above):

> +	/* Backwards compatibility for domain 0 only */
> +	if (pci_domain_nr(dev->bus) != 0)
> +		return 0;

How about this instead?

	/* Backwards compatibility for first N PCI domains. */
	if (pci_domain_nr(dev->bus) > PCI_PROC_MAX_DOMAIN)
		return 0;

PCI_PROC_MAX_DOMAIN could be defined in asm/pci.h (255 on alpha), default 0.

Ivan.
