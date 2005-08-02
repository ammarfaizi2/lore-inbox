Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVHBQut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVHBQut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVHBQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:50:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:7149 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261643AbVHBQur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:50:47 -0400
Date: Tue, 2 Aug 2005 20:50:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050802205023.B16660@jurassic.park.msu.ru>
References: <42EC9410.8080107@roarinelk.homelinux.net> <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org> <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org>; from torvalds@osdl.org on Tue, Aug 02, 2005 at 08:48:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 08:48:21AM -0700, Linus Torvalds wrote:
> The problem with this is that it only papers over the bug. 
> 
> I don't mind trying to allocate at higher addresses per se: we used to
> have the starting point be 0x4000 at some point, and that part is fine.  
> The problem is that this also screws us if somebody has a PCI bridge with
> an IO window that is at a lower address than 0x2000 - now the PCI layer 
> will refuse to try to allocate within it, and you'll replace one bug by 
> another.

Right, and this hurts the cardbus as well...
But it should be pretty easy to learn the PCI layer to allocate above
PCIBIOS_MIN_IO _only_ when we allocate on the root bus.
Something like this (completely untested)?

Ivan.

--- linux/drivers/pci/setup-res.c.orig	Fri Jun 17 23:48:29 2005
+++ linux/drivers/pci/setup-res.c	Tue Aug  2 20:44:59 2005
@@ -113,11 +113,12 @@ int pci_assign_resource(struct pci_dev *
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	unsigned long size, min, align;
+	unsigned long size, min, align, min_io;
 	int ret;
 
+	min_io = (bus->self && !bus->self->transparent) ? 0 : PCIBIOS_MIN_IO;
 	size = res->end - res->start + 1;
-	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+	min = (res->flags & IORESOURCE_IO) ? min_io : PCIBIOS_MIN_MEM;
 	/* The bridge resources are special, as their
 	   size != alignment. Sizing routines return
 	   required alignment in the "start" field. */
