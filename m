Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSLIEpm>; Sun, 8 Dec 2002 23:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSLIEpm>; Sun, 8 Dec 2002 23:45:42 -0500
Received: from smtp.sw.oz.au ([203.31.96.1]:61969 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S262804AbSLIEpl>;
	Sun, 8 Dec 2002 23:45:41 -0500
Date: Mon, 9 Dec 2002 15:53:16 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH 2.5.50] madvise_willneed makes bad limit comparison
Message-ID: <20021209155316.E12270@aurema.com>
References: <20021209150426.D12270@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021209150426.D12270@aurema.com>; from kingsley@aurema.com on Mon, Dec 09, 2002 at 03:04:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trivial patch against 2.5.50, similar to the patch I sent earlier for
2.4.20, to fix the bad rss limit comparision in 'madvise_willneed'.


diff -urN linux-2.5.50/mm/madvise.c linux-2.5.50patched/mm/madvise.c
--- linux-2.5.50/mm/madvise.c   Thu Nov 28 09:35:53 2002
+++ linux-2.5.50patched/mm/madvise.c    Mon Dec  9 15:20:48 2002
@@ -75,10 +75,12 @@
 
        /* Make sure this doesn't exceed the process's max rss. */
        error = -EIO;
-       rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
-                               LONG_MAX; /* default: see resource.h */
-       if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
-               return error;
+       rlim_rss = current->rlim[RLIMIT_RSS].rlim_cur;
+       if (rlim_rss != RLIM_INFINITY) {
+               rlim_rss >>= PAGE_SHIFT;
+               if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
+                       return error;
+       }
 
        do_page_cache_readahead(file->f_dentry->d_inode->i_mapping, file, start, end - start);
        return 0;


-- 
		Kingsley
