Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRFNVrW>; Thu, 14 Jun 2001 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264092AbRFNVrN>; Thu, 14 Jun 2001 17:47:13 -0400
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:40404 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264080AbRFNVrG>; Thu, 14 Jun 2001 17:47:06 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
Date: Thu, 14 Jun 2001 23:46:40 +0200
Message-Id: <20010614214640.22919@smtp.wanadoo.fr>
In-Reply-To: <15145.11801.823664.36512@pizda.ninka.net>
In-Reply-To: <15145.11801.823664.36512@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I beleive there will always be need for some platform specific
> > hacking at probe-time to handle those, but we can at least make
> > the inx/outx functions/macros compatible with such a scheme,
> > possibly by requesting an ioremap equivalent to be done so that
> > we stop passing them real PIO addresses, but a cookie obtained
> > in various platform specific ways.
>
>The cookie can be encoded into the address itself.
>
>This is why readl() etc. take one arg, the address, not a billion
>other arguments like some systems do.

Right, I don't want an additional parameter. Just a clear definition
that, like read/writex(), the in/outx() functions "address" parameter
is not a magic IO address, but a cookie obtained from an ioremap-like
function.

Now, the parameter passed to that ioremap-like function are a different
story. I beleive it could be something like

isa_pioremap(domain, address, size)  for ISA-like PIO
isa_ioremap(domain, address, size)   for ISA-like mem

domain can be 0 for "default" case (or maybe -1 as 0 is a valid
domain number and we may want the default domain to be another one)

For PCI PIOs, we need a pioremap(pci_dev, address, size) counterpart
to ioremap, as mapping of IO space is usually different on each domain.

A nice side-effect of enforcing those rules is that we no-longer need
to have the entire IO space of all domain beeing mapped in kernel virtual
space all the time as it's the case now (at least on PPC), thus saving
kernel virtual address space.

Now, we can argue on the "pioremap" name itself ;)

A typical use is a fbdev driver for a VGA-compatible PCI card. Some of
these still require some "legacy" access before beeing fully useable with
PCI MMIO only. Such driver can use isa_pioremap & isa_ioremap with the
domain number extracted from the pci_dev of the card in order to generate
those necessary cycles.

Ben.


