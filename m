Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEQUWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEQUWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUEQUWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:22:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:53704 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261505AbUEQUWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:22:30 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1084807424.20437.60.camel@watt.suse.com>
References: <200405132232.01484.elenstev@mesatop.com>
	 <20040517022816.GA14939@work.bitmover.com>
	 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	 <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040517141427.GD29054@work.bitmover.com>
	 <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
	 <20040517145217.GA30695@work.bitmover.com>
	 <Pine.LNX.4.58.0405170758260.25502@ppc970.osdl.org>
	 <1084807424.20437.60.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1084825489.20437.390.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 16:24:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 11:23, Chris Mason wrote:

> You've described it correctly for reiserfs though, we unlock the page
> too soon.  I'll fix the page locking for reiserfs_file_write.  Steven,
> we need to figure out why you're seeing this on ext3.  

Steven, could you give this a try as well?  It is against 2.6.6-mm3, but
should work against vanilla too:

reiserfs_file_write unlocks the pages it operated on before updating
i_size.  This can lead to races with writepage, who checks i_size when
deciding how much of the file to zero out.

This patch also replaces SetPageReferenced with mark_page_accessed() in
reiserfs_file_write

Index: linux.mm/fs/reiserfs/file.c
===================================================================
--- linux.mm.orig/fs/reiserfs/file.c	2004-05-17 13:42:02.000000000 -0400
+++ linux.mm/fs/reiserfs/file.c	2004-05-17 16:22:35.135105528 -0400
@@ -10,6 +10,7 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
@@ -678,10 +679,6 @@
 			     // we only remember error status to report it on
 			     // exit.
 	write_bytes-=count;
-	SetPageReferenced(page);
-	unlock_page(page); // We unlock the page as it was locked by earlier call
-			  // to grab_cache_page
-	page_cache_release(page);
     }
     /* now that we've gotten all the ordered buffers marked dirty,
      * we can safely update i_size and close any running transaction
@@ -718,6 +715,17 @@
 	reiserfs_write_unlock(inode->i_sb);
     }
     th->t_trans_id = 0;
+
+    /* 
+     * we have to unlock the pages after updating i_size, otherwise
+     * we race with writepage
+     */
+    for ( i = 0; i < num_pages ; i++) {
+	struct page *page=prepared_pages[i];
+	unlock_page(page); 
+	mark_page_accessed(page);
+	page_cache_release(page);
+    }
     return retval;
 }
 


