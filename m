Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWILTKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWILTKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWILTKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:10:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030280AbWILTKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:10:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912174339.GA19707@waste.org> 
References: <20060912174339.GA19707@waste.org>  <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> 
To: Matt Mackall <mpm@selenic.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 20:10:32 +0100
Message-ID: <15193.1158088232@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:

> > +		for (i = 0; i < (1 << bb->order); i++) {
> > +			SetPageSlab(page);
> > +			page++;
> > +		}
> 
> for ( ; page < page + (1 << bb->order), page++)
>       SetPageSlab(page);

Ugh.  No.  You can't do that.  "page < page + X" will be true until "page + X"
wraps the end of memory.

> > +				for (i = 0; i < (1 << bb->order); i++) {
> > +					if (!TestClearPageSlab(page))
> > +						BUG();
> > +					page++;
> > +				}
> 
> Please drop the BUG. We've already established it's on our lists by
> this point.

I disagree.  Let's catch accidental reuse of pages.  It should, however, be
marked unlikely().

> You just broke the bit that shrinks the arena.

How?  This is only called once when things are being initialised.  There can
be no SLOB objects allocated prior to that point.

> I don't like this patch. We've just grown SLOB by about 10% everywhere
> to make nommu happy. Is this needed because nommu is doing something
> special for MMU-less machines or because it's doing something bogus?

See preceding discussion on LKML.

kobjsize() needs to work out how to calculate the size of an object.  One of
the main classes of object it might be given is slab/slob objects.  Either
these should be marked with PG_slab as per the slab allocator, of kobjsize()
has to go and walk all the slab allocator or slob allocator lists to find out
whether this page belongs to them.  Only then can it know whether or not it
can trust the page metadata as slab/slob metadata or not.

> Looking through all the users of kobjsize, it seems we always know
> what the type is (and it's usually a VMA). I instead propose we use
> ksize on objects we know to be SLAB/SLOB-allocated and add a new
> function (kpagesize?) to size other objects where nommu needs it.

Yes, we might have a VMA, but no, we do not know how big the object we've
_actually_ been given by whoever is.  kmalloc() doesn't tell us that and
get_unmapped_area() doesn't tell us that but we want it to account correctly
for the ammount of memory allocated.

You say "use ksize on objects we know to be SLAB/SLOB-allocated" which is the
whole point of PG_slab.

> As for whether SLOB should emulate PG_slab on general principles, as
> far as I can tell, PG_slab should be considered a private debugging
> aid to SLAB. All the other users look rather bogus to my eye.
>
> If anything, SLOB should internally abuse PG_slab to mark big pages
> and dispense with its bigblocks lists.

It's not abuse.  SLOB is a drop-in replacement for the SLAB allocator,
therefore PG_slab belongs to it instead of SLAB.


Anyway, if you've got a better idea, then patch please.

David
