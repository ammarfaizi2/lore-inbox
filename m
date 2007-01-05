Return-Path: <linux-kernel-owner+w=401wt.eu-S1750718AbXAEVf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXAEVf0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXAEVf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:35:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34166 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXAEVfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:35:24 -0500
Date: Fri, 5 Jan 2007 13:34:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <Pine.LNX.4.64.0701051147090.28519@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0701051329420.3661@woody.osdl.org>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
 <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
 <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051109300.28395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0701051122040.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051147090.28519@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2007, Christoph Lameter wrote:
> 
> It looks as if most code handling the dirty bits already uses the page 
> lock?

Much does. But I did some debugging (when trying to figure out the VM 
corruption), and certainly not all of it does. And when I looked at some 
of the code-paths, I was not at all sure that we could always get the 
lock easily.

> According to the comments: Most callers of __set_page_dirty_nobuffers hold 
> the page lock. The only exception seems to be zap_pte_range where we 
> transfer the dirty information from the pte to the page. This is now much 
> rarer since the dirty mmap tracking patches make the fault handler deal 
> with it.

No, it still happens as frequently as before - because the page must STAY 
dirty while it's writable. So it's still dirty when unmapped.

What the dirty mmap tracking patches do is that if a _lot_ of pages are 
dirty, we'll do the balancing, and at that point, if we end up doing IO, 
we mark them clean in the page tables again. 

But don't think that they aren't dirty in the page tables, and that 
zap-page range doesn't do stuff. I made that thinko myself at some point, 
but it's wrong.

> Still, the page dirtying in zap_pte_range remains a potential trouble spot 
> for the remaining cases in which we need to dirty pages there since it is 
> not rate limited. There is a potential cause for creating deadlocks 
> because too many pages were dirtied and the file system cannot allocate 
> enough memory for writeout.

Well, this is what the dirty mmap tracking should finally have fixed. We 
know we have only a _limited_ number of dirty pages, in a way that we 
never knew before.

But afaik, it wasn't just zap_pte_range(), it was something else too that 
didn't have the page lock.  Maybe I remember wrongly, though.

Anyway, the fundamental issue doesn't go away: the page lock isn't 
actually the worst of the dirty bit handling.

		Linus
