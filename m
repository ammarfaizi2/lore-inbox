Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUEXFKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUEXFKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbUEXFKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:10:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:42441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263963AbUEXFKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:10:20 -0400
Date: Sun, 23 May 2004 22:10:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
       linux-mm@kvack.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <1085373839.14969.42.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>  <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
  <1085371988.15281.38.camel@gaston>  <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
> 
> No, it doesn't. It tests it, if !present, it goes to do_no_page,
> do_file_page or do_swap_page, but the,i if present, it does:
> 
> 	entry = pte_mkyoung(entry);
> 	ptep_establish(vma, address, pte, entry);
> 	update_mmu_cache(vma, address, entry);
> 	pte_unmap(pte);
> 	spin_unlock(&mm->page_table_lock);
> 	return VM_FAULT_MINOR;
> 
> Which is, I think, the software PAGE_ACCESSED path used on some archs.
> 
> (ptep_establish does set_pte)

Ahh.. That's a bug, methinks.

The reason it's a bug is that if you do this, you can lose the dirty bit 
being written on some other CPU asynchronously.

In other words, I think it's pretty much always a bug to do a "set_pte()"
with an existing pte in place, exactly because you lose information. You
are trying to cover up the bug in ppc64-specific code, but I think that
what you found is actually a (really really) unlikely race condition that
can have serious consequences.

Or am I missing something else?

[ grep grep grep ]

Looks like "break_cow()" and "do_wp_page()" are safe, but only because
they always sets the dirty bit, and any other bits end up being pretty 
much "don't care if we miss an accessed bit update" or something.

Hmm. Maybe I'm wrong. If this really is buggy, it's been buggy this way 
basically forever. That code is _not_ new, it's some of the oldes code in 
the whole VM since the original three-level code rewrite. I think. Of 
course, back then SMP wasn't an issue, and this seems to have survived all 
the SMP fixes.

Who else has been working on the page tables that could verify this for 
me? Ingo? Ben LaHaise? I forget who even worked on this, because it's so 
long ago we went through all the atomicity issues with the page table 
updates on SMP. There may be some reason that I'm overlooking that 
explains why I'm full of sh*t.

		Linus
