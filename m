Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVH3DYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVH3DYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVH3DYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:24:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:54229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932112AbVH3DYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:24:33 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1125369485.11949.27.camel@gaston>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 13:19:56 +1000
Message-Id: <1125371996.11963.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> pci_map_rom "sees" that the resource is unassigned by testing the parent
> pointer, and calls pci_assign_resource() which, with this new patch,
> will do nothing.

Ok, it won't do nothing in fact. It's worse. It will return 0 (success),
will actually assign a completely new address to the resource, will
update the resource structure ... and will _not_ update the PCI resource
BAR for the ROM.

That is very bad and definitely not what you want, wether it's ppc, x86
or anything else. Either fail (don't assign the resource at all) or if
you assign it, keep the BAR in sync with the struct resource.

Also, why do we re-allocate a new address for it ? It's been properly
allocated a non-conflicting address by the firmware ... That's a big
problem I have with our common code as well.
pci_assign_unassigned_resource() doesn't do what it claims: it will
re-assign all resources, not only the unassigned ones, at least as soon
as it spots a brige, and pci_assign_resource() here called by
pci_map_rom() will re-assign even if the address there was already
correct.

At this point, i'm not sure what the proper fix it.

Ben.


