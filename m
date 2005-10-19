Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVJSUBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVJSUBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJSUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:01:40 -0400
Received: from gold.veritas.com ([143.127.12.110]:49339 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751277AbVJSUBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:01:39 -0400
Date: Wed, 19 Oct 2005 21:00:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rohit Seth <rohit.seth@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <1129748733.339.90.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com> 
 <20051018143438.66d360c4.akpm@osdl.org>  <1129673824.19875.36.camel@akash.sc.intel.com>
  <20051018172549.7f9f31da.akpm@osdl.org>  <1129692330.24309.44.camel@akash.sc.intel.com>
  <20051018210721.4c80a292.akpm@osdl.org>  <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
 <1129748733.339.90.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Oct 2005 20:01:38.0472 (UTC) FILETIME=[EA618280:01C5D4E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for your helpful answers in other mail: much appreciated.

On Wed, 19 Oct 2005, Rohit Seth wrote:
> On Wed, 2005-10-19 at 16:48 +0100, Hugh Dickins wrote:
> > 
> > What happens when the hugetlb file is truncated down and back up after
> > the mmap?  Truncating down will remove a page from the mmap and flush TLB.
> > Truncating up will let accesses to the gone page pass the valid...off test.
> > But we've no support for hugetlb faulting in this version: so won't it get
> > get stuck in a tight loop?
> 
> First of all, there is currently no support of extending the hugetlb
> file size using truncate in 2.6.14. (I agree that part is broken).  So
> the above scenario can not happen.

I was forgetting that extending ftruncate wasn't supported in 2.6.14 and
earlier, yes.  But I'm afraid the above scenario can still happen there:
extending is done, not by ftruncate, but by (somewhere else) mmapping the
larger size.   So your fix may still cause a tight infinite fault loop.

> For the prefaulting hugepage case that exist today, I would assume that
> (if someone does extend ) using truncate to extend the hugetlb file size
> support, would update the PTEs of all the processes that have those
> hugepages mapped (just like when truncating it down currently kernel
> clear the ptes from all the processes PT).

Sorry, no, you're dreaming there.  And I very much doubt we'd want
to implement such a behaviour!  (But yes, it's a good example of why
several of us are quite unhappy with the extend-to-fill-mmap behaviour.)

> > If it's decided that this issue is actually an ia64 one, and does need to
> > be fixed right now, then I'd have thought your idea of fixing it at the
> > ia64 end better: arch/ia64/mm/fault.c already has code for discarding
> > faults on speculative loads, and ia64 has an RGN_HPAGE set aside for
> > hugetlb, so shouldn't it just discard speculative loads on that region?
> 
> This has nothing to do with speculative load fault on IA-64.  

As you made clear in your other mail: sorry for wasting your time
with my ignorant confusions!

Hugh
