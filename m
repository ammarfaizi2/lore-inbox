Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVEZPTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVEZPTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVEZPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:19:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:35516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261325AbVEZPTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:19:11 -0400
Date: Thu, 26 May 2005 08:21:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: ralf@linux-mips.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
In-Reply-To: <1117083357.9076.49.camel@gaston>
Message-ID: <Pine.LNX.4.58.0505260813510.2307@ppc970.osdl.org>
References: <1117080454.9076.25.camel@gaston>  <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
  <1117081633.9076.35.camel@gaston>  <1117081814.9076.38.camel@gaston>
 <1117083357.9076.49.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 May 2005, Benjamin Herrenschmidt wrote:
> 
> 	foo = pci_iomap(dev, bar, pci_resource_len(dev, bar));

Btw, this kind of code should be just

	foo = pci_iomap(dev, bar, 0);

because the third argument is _not_ a length, it's a _maximum_ length we 
need to map, with zero meaning "everything" (as does ~0ul, of course, but 
zero is obviously easier).

The only people who want to use non-zero are things like frame-buffers
that might have hundreds of megabytes of memory, but the kernel only needs
to map the actual thing visible on the screen.

> And in a completely different function, a simple
> 
> 	pci_iounmap(dev, foo);
> 
> It may be simpler indeed for me to actually only complicate the ppc &
> ppc64 pci_iounmap() implementation and have it compare the virtual
> address against known PCI IO spaces...

Yeah. It shouldn't be a problem on 64-bit architectures, and even on 
32-bit ones the IO-port range really _should_ be fairly small, and a small 
amount of special casing should hopefully fix it.

A lot of architectures end up having to separate PIO and MMIO anyway,
which is - together with hysterical raisins, of course - why the existing
interfaces just assumed that was possible.

		Linus
