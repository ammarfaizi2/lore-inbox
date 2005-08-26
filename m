Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVHZSy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVHZSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVHZSy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:54:59 -0400
Received: from silver.veritas.com ([143.127.12.111]:64162 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030188AbVHZSy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:54:58 -0400
Date: Fri, 26 Aug 2005 19:56:57 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ross Biro <ross.biro@gmail.com>
cc: Rik van Riel <riel@redhat.com>, Ray Fucillo <fucillo@intersystems.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <8783be6605082611206dce314e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508261946310.8708@goblin.wat.veritas.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
  <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> 
 <430E6FD4.9060102@yahoo.com.au>  <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
  <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> 
 <430F26AA.80901@yahoo.com.au> <430F4A9E.3060903@intersystems.com> 
 <Pine.LNX.4.63.0508261349550.25015@cuia.boston.redhat.com>
 <8783be6605082611206dce314e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 18:54:58.0308 (UTC) FILETIME=[A7CA6C40:01C5AA6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Ross Biro wrote:
> On 8/26/05, Rik van Riel <riel@redhat.com> wrote:
> > 
> > Filling in all the page table entries at the first fault to
> > a VMA doesn't make much sense, IMHO.
> > 
> > I suspect we would be better off without that extra complexity,
> > unless there is a demonstrated benefit to it.
> 
> You are probably right, but do you want to put in a patch that might
> have a big performance impact in either direction with out verifying
> it?
> 
> My suggestion is safe, but most likely sub-optimal.  What everyone
> else is suggesting may be far better, but needs to be verified first.

It all has to be verified, and the problem will be that some things
fare well and others badly: how to reach a balanced decision?
Following your suggestion is no more safe than not following it.

> I'm suggesting that we change the code to do the same work fork would
> have done on the first page fault immediately, since it's easy to
> argue that it's not much worse than we have now and much better in
> many cases, and then try to experiment and figure out  what the
> correct solution is.

We don't know what work fork would have done, that information was in
the ptes we decided not to bother to copy.  Perhaps every pte of the
vma was set, perhaps none, perhaps only one.

Also, doing it at fault time has significantly more work to do than
just zipping along the ptes incrementing page counts and clearing bits.
I think; but probably much less extra work than I originally imagined,
since Andrew gave us the gang lookup of the page cache.

All the same, I'm with Rik: one of the great virtues of the original
idea was its simplicity; I'd prefer not to add complexity.

Hugh
