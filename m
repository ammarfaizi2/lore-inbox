Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSLID4x>; Sun, 8 Dec 2002 22:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSLID4x>; Sun, 8 Dec 2002 22:56:53 -0500
Received: from gw.softway.com.au ([203.31.96.1]:35340 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S262500AbSLID4w>;
	Sun, 8 Dec 2002 22:56:52 -0500
Date: Mon, 9 Dec 2002 15:04:26 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH 2.4.20] madvise_willneed makes bad limit comparison
Message-ID: <20021209150426.D12270@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

'madvise_willneed' makes an incorrect rss limit comparison.  It
directly compares rlim[RLIMIT_RSS].rlim_cur to rss. The former is in
bytes, whereas the latter is in pages.  The fix for this is trivial.

[As an aside, one question is whether this limit check is needed at
all.  Most rss limit enforcement implementations that I've seen are
'soft', whereas this would give the limit 'hard' semantics.  Do we
really want 'hard' limit semantics?]


diff -urN linux-2.4.20/mm/filemap.c linux-2.4.20patched/mm/filemap.c
--- linux-2.4.20/mm/filemap.c   Mon Dec  9 14:19:13 2002
+++ linux-2.4.20patched/mm/filemap.c    Mon Dec  9 14:36:08 2002
@@ -2471,10 +2471,12 @@
 
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
 
        /* round to cluster boundaries if this isn't a "random" area. */
        if (!VM_RandomReadHint(vma)) {


--
		Kingsley
