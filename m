Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUCaPHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCaPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:07:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30410
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261989AbUCaPHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:07:18 -0500
Date: Wed, 31 Mar 2004 17:07:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040331150718.GC2143@dualathlon.random>
References: <20040326075343.GB12484@dualathlon.random> <Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu> <20040326175842.GC9604@dualathlon.random> <Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu> <20040329172248.GR3808@dualathlon.random> <Pine.GSO.4.58.0403291240040.14450@eecs2340u20.engin.umich.edu> <20040329180109.GW3808@dualathlon.random> <20040329124027.36335d93.akpm@osdl.org> <20040329223900.GK3808@dualathlon.random> <20040329144243.393d21a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329144243.393d21a8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 02:42:43PM -0800, Andrew Morton wrote:
> diff -puN mm/page_io.c~rw_swap_page_sync-fix mm/page_io.c
> --- 25/mm/page_io.c~rw_swap_page_sync-fix	Mon Mar 29 14:41:08 2004
> +++ 25-akpm/mm/page_io.c	Mon Mar 29 14:41:28 2004
> @@ -139,7 +139,7 @@ struct address_space_operations swap_aop
>  
>  /*
>   * A scruffy utility function to read or write an arbitrary swap page
> - * and wait on the I/O.
> + * and wait on the I/O.  The caller must have a ref on the page.
>   */
>  int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
>  {
> @@ -151,8 +151,7 @@ int rw_swap_page_sync(int rw, swp_entry_
>  	lock_page(page);
>  
>  	BUG_ON(page->mapping);
> -	page->mapping = &swapper_space;
> -	page->index = entry.val;
> +	add_to_page_cache(page, &swapper_space, entry.val, GFP_NOIO);
>  
>  	if (rw == READ) {
>  		ret = swap_readpage(NULL, page);
> @@ -161,7 +160,12 @@ int rw_swap_page_sync(int rw, swp_entry_
>  		ret = swap_writepage(page, &swap_wbc);
>  		wait_on_page_writeback(page);
>  	}
> -	page->mapping = NULL;
> +
> +	lock_page(page);
> +	remove_from_page_cache(page);
> +	unlock_page(page);
> +	page_cache_release(page);	/* For add_to_page_cache() */
> +
>  	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
>  		ret = -EIO;
>  	return ret;

I checked this into CVS last night and today I got this new oops in
bugzilla:

hda: completing PM request, resume
Writing data to swap (18536 pages): .<1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c01daf24
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01daf24>]    Tainted: P
EFLAGS: 00010082   (2.6.4-40.3-default)
EIP is at radix_tree_delete+0x14/0x160
eax: 00000004   ebx: c16b6880   ecx: 00000016   edx: 00001d69
esi: 00001d69   edi: 00000010   ebp: 000011ae   esp: f7329e1c
ds: 007b   es: 007b   ss: 0068
Process powersaved (pid: 4216, threadinfo=f7328000 task=f751f250)
Stack: 00000000 f51b6e00 00000004 00000006 f6326200 f63262bc 0000002e c0108d48
       c041f4c0 00000000 000003fd 000026cd c041f4c0 c03ffd45 00000320 0000007b
       0000007b ffffff00 c021b78e c16b6880 c0342d60 000011ae 000011ae 000011ae
Call Trace:
 [<c0108d48>] common_interrupt+0x18/0x20
 [<c021b78e>] serial_in+0x1e/0x40
 [<c0150f2c>] swap_free+0x1c/0x30
 [<c0152897>] remove_exclusive_swap_page+0x97/0x155
 [<c013be2f>] __remove_from_page_cache+0x3f/0xa0
 [<c013beab>] remove_from_page_cache+0x1b/0x27
 [<c014fe5c>] rw_swap_page_sync+0x9c/0x1b0
 [<c0135a9d>] do_magic_suspend_2+0x27d/0x7d0
 [<c0125fb0>] process_timeout+0x0/0x10
 [<c011ad1e>] __wake_up+0xe/0x20
 [<f952be8d>] snd_intel8x0_suspend+0x1d/0x40 [snd_intel8x0]
 [<c01e3586>] pci_device_suspend+0x16/0x20
 [<c027701d>] do_magic+0x4d/0x130
 [<c0135520>] software_suspend+0xd0/0xe0
 [<c01fc176>] acpi_system_write_sleep+0xb5/0xd2
 [<c01fc0c1>] acpi_system_write_sleep+0x0/0xd2
 [<c015514e>] vfs_write+0xae/0xf0
 [<c015522c>] sys_write+0x2c/0x50
 [<c0107dc9>] sysenter_past_esp+0x52/0x79

Code: 8b 28 8d 7c 24 10 3b 14 ad a0 b9 41 c0 0f 87 18 01 00 00 8d

the oops is in a different place. It seems to bomb in
__remove_from_page_cache while calling radix_tree_delete like if the
radix_tree_insert didn't work out. I believe it's because you're not
checking for the retval of add_to_page_cache, if it runs oom in the
radix tree insert it will crash. You used GFP_NOIO, that's wrong, it
should be GFP_KERNEL to guarantee allocation. There's no reason to use
GFP_NOIO as far as I can tell.

Furthermore I was thinking your patch is still too lowlevel, it's better
to use the swapcache entry/exit points that already do the hardness
checks and page_cache_release automatically plus it pins the swap page
so there's no risk of disk corruption etc...

So I rewritten the fix this way:


diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/page_io.c x/mm/page_io.c
--- x-ref/mm/page_io.c	2004-03-31 16:57:25.505978008 +0200
+++ x/mm/page_io.c	2004-03-31 17:06:07.028694504 +0200
@@ -139,7 +139,7 @@ struct address_space_operations swap_aop
 
 /*
  * A scruffy utility function to read or write an arbitrary swap page
- * and wait on the I/O.
+ * and wait on the I/O.  The caller must have a ref on the page.
  */
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
@@ -149,10 +149,9 @@ int rw_swap_page_sync(int rw, swp_entry_
 	};
 
 	lock_page(page);
-
-	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+	ret = add_to_swap_cache(page, entry);
+	if (unlikely(ret))
+		goto out_unlock;
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +160,12 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
-	page->mapping = NULL;
+
+	lock_page(page);
+	delete_from_swap_cache(page);
+ out_unlock:
+	unlock_page(page);
+
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;


I hope this will work (untested).
