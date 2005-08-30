Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVH3ClI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVH3ClI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVH3ClI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:41:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:24789 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932085AbVH3ClH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:41:07 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200508261859.j7QIxT0I016917@hera.kernel.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 12:38:04 +1000
Message-Id: <1125369485.11949.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 11:59 -0700, Linux Kernel Mailing List wrote:
> tree d8b7aaaec93de93841b46e8e05a3b454d05bd357
> parent 26aad69e3dd854abe9028ca873fb40b410a39dd7
> author Linus Torvalds <torvalds@g5.osdl.org> Sat, 27 Aug 2005 00:49:22 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 27 Aug 2005 00:49:22 -0700
> 
> Ignore disabled ROM resources at setup
> 
> Writing even a disabled value seems to mess up some matrox graphics
> cards.  It may be a card-related issue, but we may also be writing
> reserved low bits in the result.
> 
> This was a fall-out of switching x86 over to the generic PCI resource
> allocation code, and needs more debugging.  In particular, the old x86
> code defaulted to not doing any resource allocations at all for ROM
> resources.
> 
> In the meantime, this has been reported to make X happier by Helge
> Hafting <helgehaf@aitel.hist.no>.

This "fix" also seems to break all powermac laptops around :( In fact,
it might break any user of pci_map_rom() as it exposes a bug in that
function.

The problem is that their firmware doesn't assign a ROM resource as they
have no ROM on the video chip (like most laptops). radeonfb and aty128fb
among others will call pci_map_rom() to try to find an x86 BIOS ROM with
some config tables in it.

pci_map_rom "sees" that the resource is unassigned by testing the parent
pointer, and calls pci_assign_resource() which, with this new patch,
will do nothing.

Unfortunately, pci_map_rom will not notice this failure, and will
happily ioremap & access the bogus resource, thus causing the crash.
I'll come up with a fix for pci_map_rom later today.

While looking there, I also noticed pci_map_rom_copy() stuff and I'm
surprised it was ever accepted in the tree. While I can understand that
we might need to keep a cached copy of the ROM content (due to cards
like matrox who can't enable both the ROM and the BARs among other
issues), the whole idea of whacking a kernel virtual pointer in the
struct resource->start of the ROM bar is just too disgusting for words
and will probably cause "intersting" side effects in /proc, sysfs and
others... Shouldn't we just have a pointer in pci_dev for the optional
"ROM cache" instead ?

Ben.


