Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVEZE4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEZE4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEZE4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:56:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:61160 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261199AbVEZE4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:56:31 -0400
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ralf@linux-mips.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1117081814.9076.38.camel@gaston>
References: <1117080454.9076.25.camel@gaston>
	 <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
	 <1117081633.9076.35.camel@gaston>  <1117081814.9076.38.camel@gaston>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:55:57 +1000
Message-Id: <1117083357.9076.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ok, just wanted some feedback from you. Some people prefer that I whack
> > some "token" in the vitual address at map time, or that I compare the
> > vaddr at unmap time with all PCI busses IO ranges or that sort of ugly
> > thing, it sounds to me simpler to just pass along the bar number, but I
> > wanted your and Greg's ack first.
> 
> Oh, and MIPS seems to be broken here ... it's like ppc, it's ioremap'ing
> MMIO and just using an existing mapped stuff for IO, but unconditionally
> iounmap's on pci_iounmap()... unless there is some arch black magic in
> there, that seems broken. Ralph, should I fix it while I'm at it ?

Hrm... in fact, It complicates life for drivers. There already a few
using it, and there are cases, like sym53c8xx_2, that do something like

	int bar = dodgy_logic_to_find_what_bar_to_use();

	foo = pci_iomap(dev, bar, pci_resource_len(dev, bar));

And in a completely different function, a simple

	pci_iounmap(dev, foo);

To pass the bar in there requires to either add a field to the driver
"instance" structure or to reproduce the "dodgy logic".

I've fixed them all, but I don't like the patch that much.

It may be simpler indeed for me to actually only complicate the ppc &
ppc64 pci_iounmap() implementation and have it compare the virtual
address against known PCI IO spaces...

Ben.


