Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUBCAa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUBCAa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:30:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:44673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265150AbUBCAa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:30:27 -0500
Date: Mon, 2 Feb 2004 16:30:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: <200402030009.i1309TeY016316@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
References: <200402030009.i1309TeY016316@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Feb 2004, Roland McGrath wrote:
> 
> On second thought, why is it necessary to have the caller tell
> handle_mm_fault "write" vs "copy"?  The existing "write" flag says do COW
> and mark it dirty.  Why not just redefine it not to also mean "make the pte
> writable", but rather "make the pte as writable as the vma says"?
> i.e., just replace pte_mkwrite(pte) with pte_modify(pte, vma->vm_page_prot)
> throughout.  That way we don't have to change all the arch/*/fault.c callers.

I think you're right, we could do it that way too. And that should 
actually fix the problem that "do_wp_page()" doesn't even get the 
"write_access" status at all (since it is _only_ called for writes).

So yes, that should work.

> I think this question is orthogonal to my concern about follow_page.

The follow_page issue should be fixable by just marking the _page_ dirty 
inside the ptrace routines. I think we do that anyway (or we'd already be 
buggy wrt perfectly normal writes).

Ie the sequence would be:

 - handle_mm_fault(write/copy)
	This makes sure that we have done a COW. There is no other real 
	issue, but we obviously _do_ need to make sure that a private copy
	gets split. Marking it dirty is necessary: otherwise the private
	page might be thrown out by the pageout, resulting in the virtual 
	page being re-loaded with a clean (shared) copy. That would be 
	bad.

 - follow_page() looks up the page
	The page may indeed have been written out here (very unlikely, 
	but for the sake of the argument, let's assume so). However, that 
	doesn't matter - what matters is that the VM must not "re-share" 
	the page, so that if the mapping was private, we'll still have a 
	private page.

	Marking it dirty will guarantee this: even if the virtual page 
	gets evicted, it then gets evicted as a _swap_ page, not as a
	demand-loadable clean page.

 - we write to the page, and mark the "struct page" dirty with SetPageDirty()
	Now the page tables might be marked clean (but only if the thing 
	was a shared mapping), but because we marked the page dirty, we
	are guaranteed to not lose the data we wrote.

Do you see any holes in this?

		Linus
