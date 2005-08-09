Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVHIJPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVHIJPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVHIJPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:15:30 -0400
Received: from gold.veritas.com ([143.127.12.110]:64633 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932476AbVHIJP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:15:29 -0400
Date: Tue, 9 Aug 2005 10:15:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <20050809080853.A25492@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de>
 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
 <20050809080853.A25492@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 09:14:13.0099 (UTC) FILETIME=[B567BBB0:01C59CC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Russell King wrote:
> On Tue, Aug 09, 2005 at 02:59:53PM +1000, Nick Piggin wrote:
> > That would work for swsusp, but there are other users that want to
> > know if a struct page is valid ram (eg. ioremap), so in that case
> > swsusp would not be able to mess with the flag.
> 
> The usage of "valid ram" here is confusing - that's not what PageReserved
> is all about.  It's about valid RAM which is managed by method other
> than the usual page counting.

You're right (though I imagine might sometimes be holes rather than RAM).

PageReserved is about those pages which are managed by PageReserved.
But quite what it means is unclear, one of the reasons to eliminate it.
(Why is kernel text PageReserved?)

> Non-reserved RAM is also valid RAM, but
> is managed by the kernel in the usual way.
> 
> The former is available for remap_pfn_range and ioremap, the latter is
> not.

And the caller of remap_pfn_range (and occasionally ioremap?) uses
SetPageReserved to move pages from the latter to the former category,
so that they will work successfully on it.

Seems very silly to me.  A little key we give the caller,
so the caller can reassure us "I know what I'm doing".

I think Nick is treating the "use" of PageReserved in ioremap much too
reverentially.  Fine to leave its removal from there to a later stage,
but why shouldn't that also be removed?

With or without PageReserved, driver writers should be careful to apply
ioremap to the areas they intend.  And when they do get it wrong (setting
a window on the wrong range of RAM), the new VM_RESERVED handling makes
sure that at least those wrong pages won't be freed when unmapped.

Hugh
