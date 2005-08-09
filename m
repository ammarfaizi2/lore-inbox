Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVHIOyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVHIOyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVHIOyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:54:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:40424 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964808AbVHIOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:54:50 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.61.0508091548150.13674@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de> <42F7F5AE.6070403@yahoo.com.au>
	 <1123577509.30257.173.camel@gaston>
	 <Pine.LNX.4.61.0508091215490.11660@goblin.wat.veritas.com>
	 <1123597903.30257.204.camel@gaston>
	 <Pine.LNX.4.61.0508091548150.13674@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 16:49:11 +0200
Message-Id: <1123598952.30257.213.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 15:50 +0100, Hugh Dickins wrote:
> On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> > 
> > > But you don't mind if they are refcounted, do you?
> > > Just so long as they start out from 1 so never get freed.
> > 
> > Well, a refcounting bug would let them be freed and kaboom ... That's
> > why a "PG_not_your_ram_dammit" bit would be useful. It could at least
> > BUG_ON when refcount reaches 0 :)
> 
> Okay, great, let's give every struct page two refcounts,
> so if one of them goes wrong, the other one will save us.

You are abusing here :)

 - We already have a refcount
 - We have a field where putting a flag isn't that much of a problem
 - It can be difficult to get page refcounting right when dealing with
   such things, really.

In that case, we basically have an _easy_ way to trigger a useful BUG()
in the page free path when it's a page that should never be returned to
the pool.

Since the "PG_not_in_ram" or whatever we call it flag might be used by
swsusp or others, I suppose it could be useful.

However, I agree that if the end result is to have drivers just change
"PG_reserved" to "PG_not_in_ram" and still be bogus, then we might just
go all the way & drop the flag completely, only relying on the VMA
flags.

Ben.


