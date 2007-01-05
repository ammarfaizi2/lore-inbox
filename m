Return-Path: <linux-kernel-owner+w=401wt.eu-S1422690AbXAETeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbXAETeG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbXAETeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:34:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54162 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422693AbXAETeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:34:04 -0500
Date: Fri, 5 Jan 2007 11:33:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <Pine.LNX.4.64.0701051109300.28395@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0701051122040.3661@woody.osdl.org>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
 <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
 <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051109300.28395@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2007, Christoph Lameter wrote:
> 
> Maybe we should require taking the page lock before the dirty bits are 
> modified?

I think it's been suggested several times.

However, a lot of the code isn't really amenable to it as it stands now. 
We very much tend to call it in critical sections, and you have to move 
them all out of the locks they are now.

The dirty mmap patches actually did some of that, exactly because they 
wanted to replace "set_page_dirty()" with "set_page_dirty_balance()", 
which can obviously block. However, the _current_ kernels don't seem to 
have the bug, and quite frankly, I think it's at least partly because 
we've cleaned up and simplified the dirty bit handling even if Andrew 
apparently disagrees.

So one of the biggest need for dirty bit cleanup is with the _old_ 
kernels, the ones before the dirty mmap patches. Nobody is going to do 
that, I think - it would just be crazy.

> That way we can avoid all the artistic code in there right now. 

"Artistic". Good word. That said, most of the code in there needs its own 
locks for other reasons (ie the reason __set_page_dirty_nobuffers() ends 
up taking the tree-lock is because of the radix tree bits, which can NOT 
be protected by per-page locks _anyway_).

So I don't think you'd actually really get rid of any "artistic" code.

The real "artistry" is the fact that we actually do things in 
"set_page_dirty()" even if the page was marked dirty before, exactly 
because we need to re-dirty any meta-data (ie buffers). And THAT is what 
causes a lot of the strangeness. And again, that really doesn't have much 
to do with the page lock - the meta-data tends to generally have its own 
locks again, and it really is a _separate_ issue from the "dirty" bit 
itself.

So I agree: set_page_dirty() is ugly, but I don't think the real problem 
has anything to do with the page lock.

The real confusion comes from how the "dirty" bit means "_some_ part of 
this page may or may not be dirty", and that "set_page_dirty()" really not 
only needs to set that bit, but also make sure that we know that now ALL 
of this page is dirty. That particular confusion takes some time to 
assimilate, and the bug in 2.6.19 was due to missing the subtlety.

And that particular confusion we've had forever, and I think the bug in 
older kernels is probably due to some other place also having missed 
something subtle wrt that thing. For example, anything that 
tests/sets/clear just the dirty bit on its own is pretty much buggy by 
design, even if it _happens_ to work.

This is partly why I got rid of the old "[test_]clear_page_dirty()", 
because it just was confused about the whole thing, and seemed to think 
that it was just a simple bit. 

		Linus
