Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbUKVUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbUKVUOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUKVUMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:12:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:18316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262519AbUKVUKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:10:48 -0500
Date: Mon, 22 Nov 2004 12:10:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411221206040.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de>  <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
 <1101151780.20006.69.camel@d845pe> <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Linus Torvalds wrote:
>
> This is exactly what you are already doing with SCI, thanks to
> "acpi_pic_sci_set_trigger()", no?
> 
> So I'm really suggesting that instead of disabling the PCI irq routing, it 
> should do exactly the same thing that SCI already does. Namely make sure 
> that ELCR is set correctly for it.

In fact, we would even use the same function for it (the only thing that
makes it SCI-specific right now is the "printk()" that says "SCI IRQ", the
rest really is totally generic.

So how about renaming "acpi_pic_sci_set_trigger()" to not have the "sci" 
part in there, and remove it's dependence on CONFIG_ACPI_BUS, and just 
using it in "apic_pci_link_add()" to make sure that any PCI links we find 
to be enabled have the right ELCR. That's _logical_, since if we were to 
actually enable them, we'd set ELCR right. So literally the only 
difference between disabling them at boot (and then re-enabling them when 
a driver finds them) _is_ that ELCR setting..

And that would make me much happier, because it's a "minimally intrusive" 
thing to do.

		Linus
