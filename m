Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVHBRMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVHBRMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVHBRMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:12:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbVHBRMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:12:02 -0400
Date: Tue, 2 Aug 2005 10:11:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050802205023.B16660@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org>
References: <42EC9410.8080107@roarinelk.homelinux.net>
 <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org>
 <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org>
 <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain>
 <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru>
 <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Ivan Kokshaysky wrote:
> 
> Right, and this hurts the cardbus as well...
> But it should be pretty easy to learn the PCI layer to allocate above
> PCIBIOS_MIN_IO _only_ when we allocate on the root bus.
> Something like this (completely untested)?

I think you'd have to follow the "transparent" case down.. And even then 
you'd have the half-transparent case to worry about it.

So I think it would be much easier to just make the change in
"pci_bus_alloc_resource()", and say that if the parent resource that we're
testing starts at some non-zero value, we just use that instead of "min"  
when we call down to allocate_resource(). That gets it for MEM resources 
too.

Something like the following (also _totally_ untested, but even simpler 
than yours). It basically says: if the parent resource starts at non-zero, 
we use that as the starting point for allocations, otherwise the passed-in 
value.

That, together with changing PCIBIOS_MIN_IO to 0x2000 (or even 0x4000)  
might be the ticket...

		Linus

----
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -60,7 +60,9 @@ pci_bus_alloc_resource(struct pci_bus *b
 			continue;
 
 		/* Ok, try it out.. */
-		ret = allocate_resource(r, res, size, min, -1, align,
+		ret = allocate_resource(r, res, size,
+					r->start ? : min,
+					-1, align,
 					alignf, alignf_data);
 		if (ret == 0)
 			break;
