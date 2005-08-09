Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVHIPek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVHIPek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVHIPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:34:40 -0400
Received: from silver.veritas.com ([143.127.12.111]:13427 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964794AbVHIPej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:34:39 -0400
Date: Tue, 9 Aug 2005 16:36:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <1123598952.30257.213.camel@gaston>
Message-ID: <Pine.LNX.4.61.0508091621220.14003@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au>  <200508090710.00637.phillips@arcor.de>
 <42F7F5AE.6070403@yahoo.com.au>  <1123577509.30257.173.camel@gaston> 
 <Pine.LNX.4.61.0508091215490.11660@goblin.wat.veritas.com> 
 <1123597903.30257.204.camel@gaston>  <Pine.LNX.4.61.0508091548150.13674@goblin.wat.veritas.com>
 <1123598952.30257.213.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 15:34:39.0309 (UTC) FILETIME=[DAE2F7D0:01C59CF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> On Tue, 2005-08-09 at 15:50 +0100, Hugh Dickins wrote:
> > On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> > > 
> > > Well, a refcounting bug would let them be freed and kaboom ... That's
> > > why a "PG_not_your_ram_dammit" bit would be useful. It could at least
> > > BUG_ON when refcount reaches 0 :)
> > 
> > Okay, great, let's give every struct page two refcounts,
> > so if one of them goes wrong, the other one will save us.
> 
> You are abusing here :)

Yeah, I was: sorry!

>  - We already have a refcount
>  - We have a field where putting a flag isn't that much of a problem
>  - It can be difficult to get page refcounting right when dealing with
>    such things, really.

Probably easier to get the page refcounting right with these than with
most.  Getting refcounting wrong is always bad.

> In that case, we basically have an _easy_ way to trigger a useful BUG()
> in the page free path when it's a page that should never be returned to
> the pool.

As bad_page already does on various other flags (though it clears those,
whereas this one you'd prefer not to clear).   Hmm, okay, though I'm not
sure it's worth its own page flag if they're in short supply.

> Since the "PG_not_in_ram" or whatever we call it flag might be used by
> swsusp or others, I suppose it could be useful.

Any flag used elsewhere, which is incompatible with being freed, should
be checked for no cost in free_pages_ok/prep_new_page/bad_page, yes.

> However, I agree that if the end result is to have drivers just change
> "PG_reserved" to "PG_not_in_ram" and still be bogus, then we might just
> go all the way & drop the flag completely, only relying on the VMA
> flags.

Yes: if any driver ever has to manipulate it,
either the flag is misdefined or the driver is beyond the pale.

Hugh
