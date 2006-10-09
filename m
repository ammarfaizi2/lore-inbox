Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933000AbWJITPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbWJITPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933004AbWJITPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:15:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933000AbWJITPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:15:14 -0400
Date: Mon, 9 Oct 2006 12:14:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: User switchable HW mappings & cie
In-Reply-To: <452A35FF.50009@tungstengraphics.com>
Message-ID: <Pine.LNX.4.64.0610091151380.3952@g5.osdl.org>
References: <1160347065.5926.52.camel@localhost.localdomain>
 <452A35FF.50009@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-44270651-1160421255=:3952"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-44270651-1160421255=:3952
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 9 Oct 2006, Thomas Hellström wrote:
> 
> One problem that occurs is that the rule for ptes with non-backing struct
> pages
> Which I think was introduced in 2.6.16:
> 
>    pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)

No.

No such rule exists.

The above is true only fora _very_ special case, namely the case of 
allowing a COW-mapping of a non-backing-store set. And the _only_ case 
where that even makes sense is /dev/mem, and quite frankly, even there the 
only reason it exists is just one or two legacy programs that really did 
use COW mappings on something that really shouldn't be COW-mapped.

(I think the only program that did was actually something that tried to 
read the BIOS tables and mapped /dev/mem privately but read-write, and 
then edited the BIOS mappings in place).

So _especially_ with 2.6.16+, using a non-backing-store mapping is really 
really easy: you just use

	int vm_insert_page(struct vm_area_struct *vma, unsigned long addr, struct page *page)

and you're done (if a ref-counted page is what is wanted).

That one requires a "struct page *", because all current users had that as 
their standard setup (ie direct rendering etc), but the thing is, the VM 
these days really doesn't care.

However, if you don't want to have a ref-counted page, you just use 
VM_PFNMAP, and insert any random pte you damn well want.

Once you have set VM_PFNMAP, and the mapping is _not_ a cow mapping, the 
page something points to will never actually be used for anything but 
mapping (modulo bugs, of course, but the new VM is a hell of a lot more 
straightforward in this, and the whole "vm_normal_page()" thing is really 
trivial).

So you never have any "struct page *" associated with it at all, and no 
refcounting is taking place - you always act purely on a pfn and a page 
protection thing (ie effectively a "pte_t").

NOTE! The important part here is really to just understand the fact that 
COW mappings are special. So you need to make sure that you always map 
such a thing "shared" (and if you have security issues, it obviously needs 
to be just marked read-only - "shared" does _not_ imply that it might be 
read-write).

COW-mappings (and _only_ cow-mappings) have the added rule of how the page 
offsets need to be handled, since otherwise there is no way to distinguish 
between somethign that got mapped originally, and something that got 
COW'ed (where the latter _does_ need reference counting, of course, since 
it's a regular page that has been copied into the address space).

It's probably also a good idea to map such things as VM_DONTCOPY, since 
they probably don't make sense across forks, and it slows down forking to 
copy the page tables. And add a VM_INSERTPAGE, although right now that 
doesn't actually do anything special (but it was originally meant to be a 
"we've done single-page random things, and so you can't _assume_ the 
virtual-address/pg_off thing to hold", so setting it is a good idea just 
for consistency).

Anyway, so right now you can use "vm_insert_page()" and it will increment 
the page count and add things to the rmap lists, which is what current 
users want. But if you don't have a normal page, you should be able to 
basically avoid that part entirely, and just use

	set_pte_at(mm, addr, pte, make-up-a-pte-here);

and you're done (of course, you need to use all the appropriate magic to 
set up the pte, ie you'd normally have something like

	pte = get_locked_pte(mm, addr, &ptl);
	..
	pte_unmap_unlock(pte, ptl);

around it). Note that "vm_insert_page()" is _not_ for VM_PFNMAP mappings, 
exactly because it does actually increment page counts. It's for a 
"normal" mapping that just wants to insert a reference-counted page.

		Linus
--21872808-44270651-1160421255=:3952--
