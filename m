Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbUAGFcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAGFcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:32:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:43164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266135AbUAGFcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:32:18 -0500
Date: Tue, 6 Jan 2004 21:32:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <m13casmk28.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0401062116230.12602@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
 <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
 <m13casmk28.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Eric W. Biederman wrote:
> > 
> > What you should do for resources you know about is to just _create_ them.
> 
> Which I can do.   But what if the BIOS has marked them as reserved?
> The BIOS always does this for ROM chips.  And it sounds like this occasionally
> happens for AGP apertures.

So? The resource functions will refuse to insert an overlapping resource
and return an error, so if the BIOS already did it through a proper e820
map, then it's a no-op.

But that's fine - it's _supposed_ to be a no-op in that case.

> Or to oops when the module is unloaded, when you try and free the resource.

Or, more appropriately, if it's a fixed resource (which it will be, if
this is some special chipset feature), you don't ever try to free it. Just
leave it be. Just make sure that the resource name etc points to stable
data (and "pci_name(dev)" is a good such data).

See the quirk entries in drivers/pci/quirks.c.

Alternatively, you actually keep track of whether it was your resource or
not, the error code will have told you. Don't try to release something 
that wasn't yours.

> If I wanted to flash my ROM what I need to do is:
>
> [ horrorcase deleted ]
> 
> So to do this cleanly it looks like I need to write a pci quirk for
> the southbridge.  Adding a BAR that enables decodes to the BIOS ROM chip.  
> And that quirk should always be present, so that nothing even thinks
> of using that region for something else.

Sounds correct. However, the BIOS map will still clash with this quirk, so 
there may be some double resource allocations in the resource maps. The 
quirks get run _after_ the memory setup has run, which is why you end up 
with this problem:

> The very practical question.  After the BIOS has allocated:
> 0xFFFF0000 - 0xFFFFFFFF how do I allocate
> 0xFFF00000 - 0xFFFFFFFF in the pci quirk?

And _this_ is the only really nasty case. It's nasty exactly because the 
BIOS is involved, and we have _no_ idea why the heck the BIOS marked 
certain areas reserved.

The resource allocation code in kernel/resource.c _will_ help you if you 
wan tto do this right. The internal "__request_resource()" function will 
pinpoint any conflicting entry, and in fact we already have a 
"insert_resource()" that uses exactly this to try to "fix up" these 
issues.

The "insert_resource()" function is able to put "new" resources below old
ones, but it does assume that the the resources are fully overlapping in 
_some_ way. It will correctly insert your PCI quirk (because the BIOS 
allocation is wholly inside of the quirk you want to add), but it would 
_not_ be able to handle two different regions conflicting.

And such a conflict could happen if the BIOS uses a single "reserved" 
region for two different PCI resources. Then your quirk might cover one of 
the PCI resources fully, but wouldn't cover the whole BIOS "reserved" 
area. "insert_resource()" would still be happy if your quirk is wholly 
inside, but it would _not_ be happy if your quirk is bigger than the BIOS 
allocation in one direction but not the other.

See?

Right now, the ia64 port actually does _exactly_ this to mark all the
strange PCI window stuff into the resource tree. For a different reason,
but with a number of similar issues.

		Linus
