Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVLCKDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVLCKDX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 05:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLCKDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 05:03:23 -0500
Received: from gold.veritas.com ([143.127.12.110]:32083 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751228AbVLCKDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 05:03:22 -0500
Date: Sat, 3 Dec 2005 10:03:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@vger.kernel.org
Subject: Re: [2.6.15-rc1+ regression] do_file_page bug introduced in recent
 rework
In-Reply-To: <200512020111.56671.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0512031000360.8984@goblin.wat.veritas.com>
References: <200512020111.56671.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Dec 2005 10:03:07.0140 (UTC) FILETIME=[C225DC40:01C5F7F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Blaisorblade wrote:
> I recently found a bug introduced in your commit 
> 65500d234e74fc4e8f18e1a429bc24e51e75de4a, i.e. between 2.6.14 and 2.6.15-rc1, 
> about do_file_page changes wrt remap_file_pages and MAP_POPULATE.
> 
> Quoting from the changelog (which is wrong):
> 
>     do_file_page's fallback to do_no_page dates from a time when we were 
> testing
>     pte_file by using it wherever possible: currently it's peculiar to 
> nonlinear
>     vmas, so just check that.  BUG_ON if not?  Better not, it's probably page
>     table corruption, so just show the pte: hmm, there's a pte_ERROR macro, 
> let's
>     use that for do_wp_page's invalid pfn too.
> 
> This is false:
> 
> do_mmap_pgoff:
>         if (flags & MAP_POPULATE) {
>                 up_write(&mm->mmap_sem);
>                 sys_remap_file_pages(addr, len, 0,
>                                         pgoff, flags & MAP_NONBLOCK);
>                 down_write(&mm->mmap_sem);
>         }
> 
> So, with MAP_POPULATE|MAP_NONBLOCK passed, you can get a linear PAGE_FILE pte 
> in a !VM_NONLINEAR vma.
> 
> That PTE is very useless since it doesn't add any information, I know that, so 
> avoiding that possible installation is a possible fix, but for now it's 
> simpler to change the test in do_file_page(). Btw, in fact I discovered this 
> bug while I was implementing this optimization (working again on 
> remap_file_pages() patches of this summer).
> 
> Indeed, the condition to test (and to possibly BUG_ON/pte_ERROR) is that 
> ->populate must exist for the sys_remap_file_pages call to work.

I'm puzzled.  Both filemap_populate and shmem_populate
now test VM_NONLINEAR before calling install_file_pte.

Hugh
