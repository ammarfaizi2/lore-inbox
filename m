Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263405AbUCTN3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUCTN3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:29:40 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39625
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263405AbUCTN3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:29:34 -0500
Date: Sat, 20 Mar 2004 14:30:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320133025.GH9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only bugreport I've got so far for the latest anon_vma code is from
Jens, and it's a device driver bug in my opinion, but I'd like to have a
definitive confirmation from you about the ->nopage API.

I changed ->nopage like this to catch bugs:

retry:
	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);

	/*
	 * non-ram cannot be mapped via ->nopage, it must
	 * be mapped via remap_page_range instead synchronously
	 * in the ->mmap device driver callback.
	 *
	 * PageReserved pages can be mapped as far as they're under
	 * a VM_RESERVED vma.
	 */
	BUG_ON(!pfn_valid(page_to_pfn(new_page)));

	/* ->nopage cannot return swapcache */
	BUG_ON(PageSwapCache(new_page));
	/* ->nopage cannot return anonymous pages */
	BUG_ON(PageAnon(new_page));

	/*
	 * This is the entry point for memory under VM_RESERVED vmas.
	 * That memory will not be tracked by the vm. These aren't
	 * real anonymous pages, they're "device" reserved pages
	 * instead.
	 * These pages under VM_RESERVED vmas are the only pages mapped
	 * by the VM into userspace with page->as.mapping = NULL.
	 */
	reserved = vma->vm_flags & VM_RESERVED;
	BUG_ON(!reserved && (!new_page->mapping || PageReserved(new_page)));


really it would not be mandatory for me to enforce the last BUG_ON,
since we don't do the pagetable walk anymore to unmap stuff, but I think
it's nicer to enforce the model in the drivers so if we'll ever want to
do the pagetable walk again, we could, if we giveup then we'll be unable
to go back to the pagetable walk. I'm not saying that we'll ever want to
go back, but since most drivers are already setting VM_RESREVED
correctly to work with 2.4, I believe it worth to maintain this
abstraction so if we really want we can go back.

Anyways returning to the non-ram returned by ->nopage see the below
email exchange with Jens. the bug triggering of course is the
BUG_ON(!pfn_valid(page_to_pfn(new_page))).

If we want to return non-ram, we could, but I believe we should change
the API to return a pfn not a page_t * if we want to.

----- Forwarded message from Andrea Arcangeli <andrea@suse.de> -----

Date: Sat, 20 Mar 2004 14:21:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>

On Fri, Mar 19, 2004 at 01:32:13PM +0100, Jens Axboe wrote:
> kernel BUG at mm/memory.c:1412!
> invalid operand: 0000 [#1]
> SMP 
> CPU:    1
> EIP:    0060:[<c01407fe>]    Not tainted
> EFLAGS: 00010216   (2.6.4-0-axboe) 
> EIP is at do_no_page+0x42c/0x4dc
> eax: 01f80000   ebx: 00000000   ecx: 00001000   edx: f0c5be78
> esi: f0860280   edi: c0453880   ebp: f0c5bec0   esp: f0c5be88
> ds: 007b   es: 007b   ss: 0068
> Process mplayer (pid: 1500, threadinfo=f0c5a000 task=f149d300)
> Stack: f7f997a0 f7f997a0 00000282 f06fec80 f0c5bea8 00000000 f7d8c984
> 40b0e000 
>        f0860280 f1267800 00000001 f0c5a000 f0866c38 c0453880 f0c5bf0c
> c01415da 
>        00000000 f0866c38 f08b3408 00000000 000081ff 405ae7a3 1be20e55
> f7de0480 
> Call Trace:
>  [<c01415da>] handle_mm_fault+0xf3/0x694
>  [<c011674d>] do_page_fault+0x16c/0x535
>  [<c0144179>] __do_mmap_pgoff+0x34c/0x643
>  [<c010c44a>] do_mmap2+0x7a/0xa8
>  [<c01165e1>] do_page_fault+0x0/0x535
>  [<c0106aad>] error_code+0x2d/0x38

a device driver is returning a non-ram page via ->nopage.

I don't think this has ever been safe, it's just that my more robust
anon_vma code is trapping this bug, I think non-ram pages should use
remap_file_pages not ->nopage.

Let's assume I'm wrong and you can return non-ram via ->nopage (even
ignoring the API would be totally incorrect since one should return a
'pfn' not a 'page_t *' if really ->nopage can return non-ram), let's
take plain 2.6.5-rc1 (w/o my anon_vma code)

	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
[..]
	if (pte_none(*page_table)) {
		if (!PageReserved(new_page))
			++mm->rss;
		flush_icache_page(vma, new_page);
		entry = mk_pte(new_page, vma->vm_page_prot);
		if (write_access)
			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
		set_pte(page_table, entry);
		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
		pte_unmap(page_table);


PageReserved(new_page) is already reading random memory, that could even
genrate a machine exception on amd64 or ia64 and lock the box hard.

then it goes ahead and it even does page_add_rmap(new_page), writing
new_page->pte_chain in non-ram with, again potentially crashing the box.
It's ironic that Andrew removed a pfn_valid check in front of
page_add_rmap just in 2.6.5-rc1 (previous kernels wouldn't overwrite
random non-ram there, but still the unrecoverable machine check was
still there simply due the PageReserved).

So I think my anon_vma code is right forbidding non-ram to be returned
by ->nopage, and the device driver should be fixed.

If you disagree, I can change ->nopage to survive a non-ram page, but
besides the API of returning a page_t * would be misleading, this would
be a new feature, and it wouldn't work stable with mainline kernels
(regardless if page_add_rmap starts with a pfn_valid check or not).

----- End forwarded message -----
