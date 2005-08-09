Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVHILNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVHILNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 07:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHILNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 07:13:36 -0400
Received: from silver.veritas.com ([143.127.12.111]:38221 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932515AbVHILNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 07:13:35 -0400
Date: Tue, 9 Aug 2005 12:15:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <42F88514.9080104@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de>
 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
 <20050809080853.A25492@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
 <42F88514.9080104@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 11:13:33.0369 (UTC) FILETIME=[61423A90:01C59CD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Nick Piggin wrote:
> Hugh Dickins wrote:
> > I think Nick is treating the "use" of PageReserved in ioremap much too
> > reverentially.  Fine to leave its removal from there to a later stage,
> > but why shouldn't that also be removed?
> 
> Well, as far as I had been able to gather, ioremap is trying to
> ensure it does indeed only hit one of these holes, and not valid
> RAM.

Who can tell?  rmk's mail sugggests it should work on some valid RAM.

ioremap is making a similar check to the one remap_pfn_range used
to make; but I see no good reason for it at all.  ioremap should be
allowed to map whatever the caller asked, just as memset is allowed
to set whatever the caller asked.  It's up to the caller to get it
right, not for the function to demand the added reassurance of some
mysterious page flag being set.

(But in what I said earlier about VM_RESERVE making sure wrong pages
not freed, I was confused and confusing ioremap with remap_pfn_range.)

> I thought the fact that it *won't* bail out when encountering
> kernel text or remap_pfn_range'ed pages was only due to PG_reserved
> being the proverbial jack of all trades, master of none.
> 
> I could be wrong here though.
> 
> But in either case: I agree that it is probably not a great loss
> to remove the check, although considering it will be needed for
> swsusp anyway...

swsusp (and I think crashdump has a similar need) is a very different
case: it's approaching memory from the zone/mem_map end, with no(?) idea
of how the different pages are used: needs to save all the info while
avoiding those areas which would give trouble.  I can well imagine it
needs either a page flag or a table lookup to decide that.

But ioremap and remap_pfn_range are coming from drivers which (we hope)
know what they're mapping these particular areas for.  If it's provable
that the meaning which swsusp needs is equally usable for a little sanity
check in ioremap, okay, but I'm sceptical.

Hugh
