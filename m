Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUEXEpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUEXEpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUEXEpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:45:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:23265 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263893AbUEXEpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:45:31 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085373839.14969.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 14:44:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-24 at 14:36, Linus Torvalds wrote:
> On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
> > 
> > Typically, you can have a thread faulting on a page. It goes through hash_page,
> > doesn't find the entry, and gets to do_page_fault(). However, just before it
> > takes the mm sem, another thread actually mmap's that page in. Thus we end up
> > in handle_pte_fault() with a present PTE which has a valid mapping already.
> 
> Ok, with you so far. But I don't see how you get to set_pte() that way, 
> since handle_pte_fault() will re-test the pte_present() bit, and never 
> even try to set_pte() if one already exists. Hmm?

No, it doesn't. It tests it, if !present, it goes to do_no_page,
do_file_page or do_swap_page, but the,i if present, it does:

	entry = pte_mkyoung(entry);
	ptep_establish(vma, address, pte, entry);
	update_mmu_cache(vma, address, entry);
	pte_unmap(pte);
	spin_unlock(&mm->page_table_lock);
	return VM_FAULT_MINOR;

Which is, I think, the software PAGE_ACCESSED path used on some archs.

(ptep_establish does set_pte)

Ben.


