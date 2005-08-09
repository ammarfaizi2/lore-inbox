Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVHIUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVHIUPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVHIUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:15:35 -0400
Received: from silver.veritas.com ([143.127.12.111]:61085 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964928AbVHIUPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:15:34 -0400
Date: Tue, 9 Aug 2005 21:17:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Daniel Phillips <phillips@arcor.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <200508100514.13672.phillips@arcor.de>
Message-ID: <Pine.LNX.4.61.0508092112050.16395@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de>
 <42F7F5AE.6070403@yahoo.com.au> <200508100514.13672.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 20:15:34.0128 (UTC) FILETIME=[19243F00:01C59D1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Daniel Phillips wrote:
> On Tuesday 09 August 2005 10:15, Nick Piggin wrote:
> > Daniel Phillips wrote:
> > > Why don't you pass the vma in zap_details?
> >
> > Possibly. I initially did it that way, but it ended up fattening
> > paths that don't use details.
> 
> It should not, it only affects, hmm, less than 10 places, each at the 
> beginning of a massive call chain, e.g., in madvise_dontneed:
> 
> -	zap_page_range(vma, start, end - start, NULL);
> +	zap_page_range(start, end - start, &(struct zap){ .vma = vma });
> 
> > And this way is less intrusive.
> 
> Nearly the same I think, and makes forward progress in controlling this 
> middle-aged belly roll of an internal API.

I much prefer how Nick has it, with vma passed separately as a regular
argument.  details is for packaging up some details only required in
unlikely circumstances, normally it's NULL and not filled in at all.

You can argue that (vma->vm_flags & VM_RESERVED) is precisely that
kind of detail.  But personally I find it rather odd that vma isn't
an explicit argument to zap_pte_range already - I find it very useful
when trying to shed light on the rmap.c:BUG, for example.

There might be a case for packaging repeated arguments into structures
(though several of these levels are inlined anyway), but that's some
other exercise entirely, shouldn't get in the way of removing Reserved.

Hugh
