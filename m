Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUAGQBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUAGQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:01:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33908 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266224AbUAGQA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:00:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it>
	<m37k054uqu.fsf@averell.firstfloor.org>
	<Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
	<20040106040546.GA77287@colin2.muc.de>
	<Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
	<20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
	<20040106094442.GB44540@colin2.muc.de>
	<Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
	<20040106153706.GA63471@colin2.muc.de>
	<m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
	<m13casmk28.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401062116230.12602@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2004 08:53:50 -0700
In-Reply-To: <Pine.LNX.4.58.0401062116230.12602@home.osdl.org>
Message-ID: <m1smirlppt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 6 Jan 2004, Eric W. Biederman wrote:
> > If I wanted to flash my ROM what I need to do is:
> >
> > [ horrorcase deleted ]
> > 
> > So to do this cleanly it looks like I need to write a pci quirk for
> > the southbridge.  Adding a BAR that enables decodes to the BIOS ROM chip.  
> > And that quirk should always be present, so that nothing even thinks
> > of using that region for something else.
> 
> Sounds correct. However, the BIOS map will still clash with this quirk, so 
> there may be some double resource allocations in the resource maps. The 
> quirks get run _after_ the memory setup has run, which is why you end up 
> with this problem:
> 
> > The very practical question.  After the BIOS has allocated:
> > 0xFFFF0000 - 0xFFFFFFFF how do I allocate
> > 0xFFF00000 - 0xFFFFFFFF in the pci quirk?
> 
> And _this_ is the only really nasty case. It's nasty exactly because the 
> BIOS is involved, and we have _no_ idea why the heck the BIOS marked 
> certain areas reserved.
> 
> The resource allocation code in kernel/resource.c _will_ help you if you 
> want to do this right. The internal "__request_resource()" function will 
> pinpoint any conflicting entry, and in fact we already have a 
> "insert_resource()" that uses exactly this to try to "fix up" these 
> issues.

Last time I was looking I got as far as __request_resource, but
it was and still is private to resource.c so it needs a wrapper around
it that does something useful.
 
> The "insert_resource()" function is able to put "new" resources below old
> ones, but it does assume that the the resources are fully overlapping in 
> _some_ way. It will correctly insert your PCI quirk (because the BIOS 
> allocation is wholly inside of the quirk you want to add), but it would 
> _not_ be able to handle two different regions conflicting.

And this looks like a useful wrapper, that comes very close to what
I need.  insert_resource is new since last time I looked so I missed
it.

> And such a conflict could happen if the BIOS uses a single "reserved" 
> region for two different PCI resources. Then your quirk might cover one of 
> the PCI resources fully, but wouldn't cover the whole BIOS "reserved" 
> area. "insert_resource()" would still be happy if your quirk is wholly 
> inside, but it would _not_ be happy if your quirk is bigger than the BIOS 
> allocation in one direction but not the other.
> 
> See?

Yes.  insert_resource does has it's limitations but it doesn't look
like I am likely to run into them.
 
> Right now, the ia64 port actually does _exactly_ this to mark all the
> strange PCI window stuff into the resource tree. For a different reason,
> but with a number of similar issues.

It comes very close, to that what this weird case needs.  And things
are at least close enough now that I can hack something up for 2.6.

However insert_resource does not quite match what I think needs to
happen.  After a pci quirk applies insert_resource I will get
something like:

fff0000-ffffffff : BIOS ROM Window
  ffff0000-ffffffff : reserved

With the reserved region still present and marked as BUSY.  Ideally
the map driver would carve up the window into sub regions for each
ROM chip.  Usually that is just one sub region but it is possible to
have multiple ROMs in it.  So I would expect to wind up with something like:

fff0000-ffffffff : BIOS ROM Window
  fffc0000-ffffffff : mtd0
  ffff0000-ffffffff : reserved

But that again runs afoul of the reserved region so it really won't
work.  I could again use insert_resource and wind up with:

fff0000-ffffffff : BIOS ROM Window
  fffc0000-ffffffff : mtd0
    ffff0000-ffffffff : reserved

But that is increasingly a hack instead of a clean solution.  Would it
be reasonable to write a variant of request_resource that just drops
BIOS resources.  I can live with the restrictions of the current
insert_resource, but especially if I do this in a quirk I just want
the BIOS resources to go away.

Eric

