Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUEXEOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUEXEOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUEXEOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:14:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:11233 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263881AbUEXEOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:14:36 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085371988.15281.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 14:13:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-24 at 13:47, Linus Torvalds wrote:
> On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
> > 
> > There is a subtle race which can cause set_pte to be called on ppc64 on
> > a PTE that is already present (that normally doesn't happen for us) and
> > which itself, in the proper race condition, can trigger a duplicate hash
> > entry to be added to the hash table (very bad).
> 
> So how exactly can the pte already be present? It's definitely illegal, 
> since if that actually happened, that would imply a memory leak (whatever 
> previous page was there just got silently dropped). 

Paulus and I identified a couple of cases in the page fault path. One typical is
the software accessed bit thing at the end of handle_pte_fault() where we cab
do

	entry = pte_mkyoung(entry);
	ptep_establish(vma, address, pte, entry);
	update_mmu_cache(vma, address, entry);

On a PTE that is present. That normally shouldn't happen as since the PTE is
present, we shouldn't have reached do_page_fault() in the first place, but
there is a window where that can happen, though that would be broken userspace
code.

Typically, you can have a thread faulting on a page. It goes through hash_page,
doesn't find the entry, and gets to do_page_fault(). However, just before it
takes the mm sem, another thread actually mmap's that page in. Thus we end up
in handle_pte_fault() with a present PTE which has a valid mapping already.

The risk here is that since we have a present PTE, we can at any time (another
thread/cpu ?) get it into the hash table. Our set_pte would then possibly replace
the PTE valid entry (with the same valid PTE entry) except that we lost the
HASH_PTE bit and hash index, thus we lose track of the one already in the hash
table in any. That mean we leave a dangling PTE in the hash, which is a very
bad thing.

I agree the race is very small and only possible with broken userland code I
suppose, but it could create all sort of bad things with the kernel, so it
needs to be fixed anyway. (It can panic on iSeries for example, or cause
undefined MMU behaviour).

There might be other similar cases where we set_pte a present PTE, that's
the one we have analyzed.

Ben.


