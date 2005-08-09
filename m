Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVHITkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVHITkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVHITkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:40:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6416 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932272AbVHITka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:40:30 -0400
Date: Tue, 9 Aug 2005 20:40:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <20050809204016.A29945@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <42F8777A.2090609@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F8777A.2090609@yahoo.com.au>; from nickpiggin@yahoo.com.au on Tue, Aug 09, 2005 at 07:29:30PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 07:29:30PM +1000, Nick Piggin wrote:
> Russell King wrote:
> > The usage of "valid ram" here is confusing - that's not what PageReserved
> > is all about.  It's about valid RAM which is managed by method other
> > than the usual page counting.  Non-reserved RAM is also valid RAM, but
> > is managed by the kernel in the usual way.
> 
> Well that is one usage of the PageReserved flag. That one tends
> to be easily covered by VM_RESERVED (ie. it is no longer used that
> way after the patches).
> 
> The remaining problem is, in fact, these "other" uses of PageReserved.
> One usage definitely appears to be "is this page valid RAM?".

Hmm, that sounds like an architecture specific extension above the
basic requirements.

> > The former is available for remap_pfn_range and ioremap, the latter is
> > not.
> 
> I thought ioremap was attempting to avoid remapping physical
> RAM with that check. All drivers I have looked at which allocate
> physical memory then SetPageReserved the pages use remap_pfn_range
> but I admit that's not a huge number (that I have looked at).

They do this because:

1. they want to control when this RAM is freed.
2. remap_pfn_range refuses to map RAM that isn't marked reserved.

To put it another way, they fiddle with the reserved bit because
that's what the current interfaces forces upon them.  I would
dearly like that to go away though.

> > On the other hand, the validity of an apparant RAM address can only be
> > tested using its pfn with pfn_valid().
> 
> I'm fairly sure that's not the case on i386 at least. I think
> pfn_valid will be true if the pfn points to a struct page.
> See arch/i386/mm/init.c:one_highpage_init()

This sounds like i386 is doing something which is a superset of the
base requirements, which is an architecture specific extension.  No
problem with that, but that's i386 folk's problem. 8)

Ok, but I still disagree with replacing something called reserved
with something which leads one to believe that it's intended for
checking whether a struct page is "valid" RAM or not when there's
other interfaces which are supposed to be used for that.

I wonder if we can optimise out the useless "valid" RAM checks
on architectures which don't require this insanity...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
