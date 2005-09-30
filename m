Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVI3RtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVI3RtN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVI3RtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:49:12 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:16822 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S932544AbVI3RtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:49:12 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=Pm3Xc2AmKwpDJ0aFkzbvM+/YKXeLxXKPvNCuZqib/Ki/zfNWXFj89qOybMrOIbn9Q
	kKo/YkO3SGCQMG+jFrnJw==
Date: Fri, 30 Sep 2005 10:48:31 -0700
From: David Brownell <david-b@pacbell.net>
To: torvalds@osdl.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, daniel.ritz@gmx.ch,
       akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282334.58365.rjw@sisk.pl>
 <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509290032.26815.daniel.ritz@gmx.ch>
 <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <Pine.LNX.4.64.0509300926590.3378@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509300926590.3378@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050930174832.0A4F8EA537@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 30 Sep 2005 09:33:13 -0700 (PDT)
> From: Linus Torvalds <torvalds@osdl.org>
>
> On Wed, 28 Sep 2005, David Brownell wrote:
> > 
> > You could try adding
> > 
> > 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> > 
> > near the end of ohci_pci_suspend().  
>
> Btw, wouldn't this make more sense in ohci_hub_suspend()? That would pair 
> up with the resume, and there seems to be nothing PCI-specific about this?
>
> There are other callers of suspend than just the PCI bus suspend.
>
> Just wondering..

Actually, no it wouldn't make sense.

Think of the OHCI driver as being in two parts:  (a) downstream links,
the guts of OHCI which I'll summarize here as being the root hub;
and (b) the upstream link, a PCI or SOC bus.  Both parts have their
own power management rules.

Now the OHCI controller itself supports four internal states, one of
which is called SUSPEND.  It's the lowest power state that all OHCI
silicon supports.  It's the state the controller enters whenever the
root hub suspends.

The OHCI driver keeps the controller in that OHCI_USB_SUSPEND state
whenever it can ... like when no devices are connected, or when all
connected devices have been suspended.  At this very second, most
OHCIs running Linux are probably in this state.

And the way the controller leaves the SUSPEND state is to issue an IRQ
when someone connects a new USB device, or a suspended device (like a
USB keyboard or mouse) issues a wakeup signal.

You can see what that means.  Disabling IRQs in ohci_hub_suspend()
would mean the controller couldn't wake up for new devices etc.
USB would just "not work".

It might not be appropriate to disable that in the PCI glue either;
I came across a comment from Benjamin Herrenschmidt a while back,
that some "legacy" PCI systems drive system wakeup through normal
IRQs rather than through PME#.  That dovetails nicely with your
comments about disabling IRQs during suspend being ungood.  :)

- Dave

