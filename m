Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUAGRis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUAGRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:38:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44917 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266258AbUAGRil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:38:41 -0500
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
	<m1smirlppt.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401070803320.12602@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2004 10:32:04 -0700
In-Reply-To: <Pine.LNX.4.58.0401070803320.12602@home.osdl.org>
Message-ID: <m165fnll63.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 7 Jan 2004, Eric W. Biederman wrote:
> > 
> > However insert_resource does not quite match what I think needs to
> > happen.  After a pci quirk applies insert_resource I will get
> > something like:
> > 
> > fff0000-ffffffff : BIOS ROM Window
> >   ffff0000-ffffffff : reserved
> > 
> > With the reserved region still present and marked as BUSY.
> 
> I would suggest ignoring it. Not only because being overly complicated is 
> bad, but simply because nobody should care. 
> 
> At some point adding extra regions is _purely_ for "documentation" 
> reasons, and while that may be nice, it's not worth worrying about. The 
> only thing you really want from a _correctness_ standpoint is to make sure 
> that nobody else will try to allocate their stuff in that area, and your 
> "BIOS ROM Window" resource should do that already. 

Right it is a documentation thing.  The case that causes me to pull
my hair are Itanium boards.  Typically they have 6 or 7 1MB rom chips,
for their firmware.  My goal with going down this road last was so
user space could figure out which rom chip is at which address and
how those correspond to mtd devices.

Using the existing interfaces to export this information looked like
the cleanest way to make certain that information was available until 
I ran into snags like the above.  And once I replace the BIOS I can
fix these things at the source, but...

> > Would it be reasonable to write a variant of request_resource that just
> > drops BIOS resources.
> 
> It would not be impossible to just have a "force_resource()" that would
> simply override _any_ existing resource, but quite frankly, I'd be more
> nervous about that.

Same here.
 
> We could also mark the e820 non-RAM resources with some special
> IORESOURCE_TENTATIVE flag, and allow just overriding those. 
>
> But even the simple "insert_resource()" has some potential problems: if 
> the BIOS has allocated the minimal window for itself (64kB at 0xffff0000), 
> and has allocated some _other_ chip at 0xfffe0000 that the kernel doesn't 
> know about yet, your insert_resource() would do the wrong thing and claim 
> the whole area for the BIOS writing. 
>
> Maybe that doesn't happen, but it's something to think about.

Agreed.  In practice it does not happen, but it is worth thinking
about.

The important thing to maintain is that nothing else grabs the
area the BIOS reserves with a dynamic resource.  So as long as
there is a resource over that area the kernel is safe, even
if I do grab it with insert_resources it does not really matter
to the rest of the kernel because someone has it.

The ROM chips actually have ID's so I can always positively identify
those, I just don't always know their count.  The worst case would be
the rom chip probe causing problems.  And that can be avoided by
simply not loading the driver so I think we are fairly safe.

In the case where I open up the decoder beyond the size it is
currently set for I can test for conflicts, from other devices.
The only reason I would not see another device at that point
is if either (a) there are ordering problems in the kernel or
(b) a SMM bios is doing truly stupid things.  The case where
there is a device there and we aren't using it is not a problem
because I am just reserving a region of the address space.

Now that I have thought about it some more I think the right
was to do with IORESOURCE_TENATIVE it instead of removing tenative
resources to just push them aside.  So in my terrible case I would
get:

fff0000-ffffffff : BIOS ROM Window
fffffff-ffffffff : reserved

And that cleans up all of the structure freeing problems.  I guess I
can do that right now with ____request_resource after I find the
conflict and confirm it has the name "reserved".  I still like the
tenative idea because then any one else who needs the same
functionality would not need to reimplement it.
 
> At some point, the _correct_ answer may be: don't do complex things, and
> write a bootable floppy (without any OS at all, or a really minimal one)  
> to do BIOS rom updates.

That works to some extent.  But it actually a lot more dangerous because
you have to be there in person to verify everything is working fine, and to
insert the floppy.  Doing it from Linux I can update the entire an
entire cluster in a minute, and verify everything automatically.  And
it happens faster because I can load it all over the network.

Eric
