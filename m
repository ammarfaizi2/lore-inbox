Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUDNSzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUDNSzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:55:33 -0400
Received: from florence.buici.com ([206.124.142.26]:5766 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261602AbUDNSzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:55:19 -0400
Date: Wed, 14 Apr 2004 11:55:13 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: Debugging a crash where user code pages are unexpectedly unmapped (v2.6.5)
Message-ID: <20040414185513.GA1813@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with kernel 2.6.5 on an ARM920 CPU.  The scenario is an
embedded system with 32MiB of RAM and root mounted over NFS.  No swap.
The application is copying a very large (41MiB) file.

  # micro_cp c0 c1

Before the copying finishes, the program terminates.  I've debugged
enough to discover that the crash comes from the fact that the kernel
has unmapped the program's code page.  Here's the stack trace:

    #0  0xc0024ea8 in cpu_arm922_set_pte ()
    #1  0xc005bcb8 in try_to_unmap_one (page=0xc1005758, paddr=0xc0342820)
	at pgtable.h:66
    #2  0xc005be70 in try_to_unmap (page=0xc1005758) at mm/rmap.c:402
    #3  0xc00521a0 in shrink_list (page_list=0xc02e5e44, gfp_mask=208, 
	nr_scanned=0xc02e5ed8) at mm/vmscan.c:314
    #4  0xc0052858 in shrink_cache (zone=0xc01d19c8, gfp_mask=208, max_scan=-9, 
	total_scanned=0xc02e5ed8) at mm/vmscan.c:529
    #5  0xc0053660 in balance_pgdat (pgdat=0xc01d19c8, nr_pages=0, ps=0xc02e5f0c)
	at mm/vmscan.c:976
    #6  0xc0053828 in kswapd (p=0xc0342020) at mm/vmscan.c:1060

And here's the struct page being unmapped.

    (gdb) p/x *page
    $6 = {flags = 0x4010009, count = {counter = 0x3}, list = {next = 0xc11e71d8, 
	prev = 0xc11e71d8}, mapping = 0xc11e71c8, index = 0x0, lru = {
	next = 0x100100, prev = 0x200200}, pte = {chain = 0xc0342820, 
	direct = 0xc0342820}, private = 0x0}

This direct mapped page contains the whole application since it's only
a dozen lines of C.

It looks like what's happening is that the page cache is filling all
of RAM and then it starts attacking code pages.  I've observed that it
unmaps not just this application, but all user-mode program's pages.

So, 

  1) The page flags indicate that the page isn't active.  Is that a
     problem?
  2) When I set the system memory to 8MiB, this problem doesn't occur.
     Hmm.
  3) This doesn't happen when I use FTP or when I just transfer data
     over the network.  It seems clear that this is related to the
     page cache.

Troubleshooting advice is welcome.

Cheers.
