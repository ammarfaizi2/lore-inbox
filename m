Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbULRBVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbULRBVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 20:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbULRBVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 20:21:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:8884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262808AbULRBVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 20:21:33 -0500
Date: Fri, 17 Dec 2004 17:21:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Pearson <james-p@moving-picture.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-Id: <20041217172104.00da3517.akpm@osdl.org>
In-Reply-To: <41C37AB6.10906@moving-picture.com>
References: <41C316BC.1020909@moving-picture.com>
	<20041217151228.GA17650@logos.cnet>
	<41C37AB6.10906@moving-picture.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Pearson <james-p@moving-picture.com> wrote:
>
> It seems the inode cache has priority over cached file data.

It does.  If the machine is full of unmapped clean pagecache pages the
kernel won't even try to reclaim inodes.  This should help a bit:

--- 24/mm/vmscan.c~a	2004-12-17 17:18:31.660254712 -0800
+++ 24-akpm/mm/vmscan.c	2004-12-17 17:18:41.821709936 -0800
@@ -659,13 +659,13 @@ int fastcall try_to_free_pages_zone(zone
 
 		do {
 			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages, &failed_swapout);
-			if (nr_pages <= 0)
-				return 1;
 			shrink_dcache_memory(vm_vfs_scan_ratio, gfp_mask);
 			shrink_icache_memory(vm_vfs_scan_ratio, gfp_mask);
 #ifdef CONFIG_QUOTA
 			shrink_dqcache_memory(vm_vfs_scan_ratio, gfp_mask);
 #endif
+			if (nr_pages <= 0)
+				return 1;
 			if (!failed_swapout)
 				failed_swapout = !swap_out(classzone);
 		} while (--tries);
_


>  What triggers the 'normal ageing round'? Is it possible to trigger this 
>  earlier (at a lower memory usage), or give a higher priority to cached data?

You could also try lowering /proc/sys/vm/vm_mapped_ratio.  That will cause
inodes to be reaped more easily, but will also cause more swapout.
