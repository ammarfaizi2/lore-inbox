Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVH3FFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVH3FFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVH3FFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:05:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932280AbVH3FFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:05:33 -0400
Date: Mon, 29 Aug 2005 22:03:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <1125376431.11949.47.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508292149260.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org> 
 <1125369485.11949.27.camel@gaston> <1125371996.11963.37.camel@gaston> 
 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org> <1125376431.11949.47.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> So what about fixing pci_map_rom() to call pcibios_resource_to_bus() and
> then write the resource back to the BAR ? I'm still a bit annoyed that
> we re-allocate the address while the original one was perfectly good
> (though not enabled) but the above would work.

I just sent you a patch to try.

Btw, as to the re-allocation of an existing address: most of the PCI layer
really does try to avoid re-allocating known good addresses. In fact, I 
thought we did so for ROM resources too: at least pci_read_bases() does 
read the ROM base, and saves it off into the resource structure.

We'll end up re-assigning that saved-off-address if there were resource
clashes, though. And bugs always happen, especially since that code
doesn't get much testing on x86 (there are almost never any interesting
rom resources for _any_ device, and apparently the video device which is
one of the few interesting ones always ends up using the shadow rom thing
on x86 for the primary card).

If you find the thing that causes us to re-assign the address, holler.

(See drivers/pci/probe.c: pci_read_bases() for the code that probes the
old address and saves it into the resource struct. It's called by
pci_setup_device() from the device scanning routines).

			Linus
