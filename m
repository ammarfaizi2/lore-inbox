Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUDAPJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUDAPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:09:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29670
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262831AbUDAPJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:09:13 -0500
Date: Thu, 1 Apr 2004 17:09:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040401150911.GI18585@dualathlon.random>
References: <20040401020126.GW2143@dualathlon.random> <Pine.LNX.4.44.0404010549540.28566-100000@localhost.localdomain> <20040401133555.GC18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401133555.GC18585@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 03:35:55PM +0200, Andrea Arcangeli wrote:
> Let's forget the "should we allow people to use rw_swap_page_sync to
> swapout/swapin anonymous pages" discussion, there's a major issue that
> my latest patch still doesn't work:
> 
> Writing data to swap (5354 pages): .<1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c01d9b34
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01d9b34>]    Not tainted
> EFLAGS: 00010082   (2.6.4-41.8-default)
> EIP is at radix_tree_delete+0x14/0x160
> eax: 00000004   ebx: c10361c0   ecx: 00000016   edx: 000023ee
> esi: 000023ee   edi: 00000000   ebp: 000000d0   esp: cdee5e1c
> ds: 007b   es: 007b   ss: 0068
> Process bash (pid: 1, threadinfo=cdee4000 task=cdf9d7b0)
> Stack: 00000000 f7b0d200 00000004 00000016 c041d440 c03ffe2e c0108d48 c041d440
>        00000000 000003fd 000026b6 c041d440 c03ffe2e 00000320 0000007b ffff007b
>        ffffff00 c021a39e 00000060 c10361c0 c0341d20 00000056 00000056 00000056
> Call Trace:
>  [<c0108d48>] common_interrupt+0x18/0x20
>  [<c021a39e>] serial_in+0x1e/0x40
>  [<c014fc3c>] swap_free+0x1c/0x30
>  [<c0151597>] remove_exclusive_swap_page+0x97/0x155
>  [<c013bc1f>] __remove_from_page_cache+0x3f/0xa0
>  [<c013bc9b>] remove_from_page_cache+0x1b/0x27
>  [<c014eb59>] rw_swap_page_sync+0xa9/0x1d0
>  [<c013588d>] do_magic_suspend_2+0x27d/0x7d0
>  [<c0275c2d>] do_magic+0x4d/0x130
>  [<c0135310>] software_suspend+0xd0/0xe0
>  [<c01fad86>] acpi_system_write_sleep+0xb5/0xd2
>  [<c01facd1>] acpi_system_write_sleep+0x0/0xd2
>  [<c0153e4e>] vfs_write+0xae/0xf0
>  [<c0153f2c>] sys_write+0x2c/0x50
>  [<c0107dc9>] sysenter_past_esp+0x52/0x79
> 
> Code: 8b 28 8d 7c 24 10 3b 14 ad 00 99 41 c0 0f 87 18 01 00 00 8d
>  <0>Kernel panic: Attempted to kill init!
> 
> 
> Pavel told me a SMP kernel cannot suspend, that's probably why I
> couldn't reproduce, I'll recompile UP and hopefully I will be able to
> reproduce, so I can debug it, and I can try latest Andrew's patch too
> (the one allowing anonymous memory swapin/swapouts too).

I think I got it, this should fix it, I'll checkin into CVS so they can
test it, I still can't test it myself unfortunately, acpi hangs.

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/page_io.c x/mm/page_io.c
--- x-ref/mm/page_io.c	2004-04-01 17:07:10.231289760 +0200
+++ x/mm/page_io.c	2004-04-01 17:07:33.182800600 +0200
@@ -139,7 +139,7 @@ struct address_space_operations swap_aop
 
 /*
  * A scruffy utility function to read or write an arbitrary swap page
- * and wait on the I/O.
+ * and wait on the I/O.  The caller must have a ref on the page.
  */
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
@@ -151,8 +151,16 @@ int rw_swap_page_sync(int rw, swp_entry_
 	lock_page(page);
 
 	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
+	if (unlikely(ret)) {
+		unlock_page(page);
+		return ret;
+	}
+	/*
+	 * get one more reference to make page non-exclusive so
+	 * remove_exclusive_swap_page won't mess with it.
+	 */
+	page_cache_get(page);
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +169,13 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
-	page->mapping = NULL;
+
+	lock_page(page);
+	remove_from_page_cache(page);
+	unlock_page(page);
+	page_cache_release(page);
+	page_cache_release(page);	/* For add_to_page_cache() */
+
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
