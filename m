Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbUDFFRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUDFFRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:17:08 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:15877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263621AbUDFFRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:17:01 -0400
Date: Tue, 6 Apr 2004 06:16:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040406061646.B14800@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040406042222.GP2234@dualathlon.random>; from andrea@suse.de on Tue, Apr 06, 2004 at 06:22:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:22:22AM +0200, Andrea Arcangeli wrote:
> What really happens is that you get errors with my tree because xfs in
> some unlikely case is messing with set_bit on the page->private of slab
> pages of order > 0.

Yes, that case would be a filesystem with blocksize < PAGE_SIZE and a buffer
with a size of > PAGE_SIZE && < MAX_SLAB_SIZE.

Can you try the patch below (testing it now, but I'm pretty sure it'll fix it)
instead of all the kmalloc changes?:

--- linux-2.5/fs/xfs/linux/xfs_buf.c	2004-04-02 20:10:56.000000000 +0200
+++ linux-2.6.5-aa3/fs/xfs/linux/xfs_buf.c	2004-04-06 09:13:05.275317568 +0200
@@ -448,7 +448,8 @@ _pagebuf_lookup_pages(
 				if (flags & PBF_READ)
 					pb->pb_locked = 1;
 				good_pages--;
-			} else if (!PagePrivate(page)) {
+			} else if ((pb->pb_flags & _PBF_PAGECACHE) &&
+					!PagePrivate(page)) {
 				unsigned long	i, range;
 
 				/*
@@ -1289,7 +1290,8 @@ bio_end_io_pagebuf(
 			SetPageError(page);
 		} else if (blocksize == PAGE_CACHE_SIZE) {
 			SetPageUptodate(page);
-		} else if (!PagePrivate(page)) {
+		} else if ((pb->pb_flags & _PBF_PAGECACHE) &&
+				!PagePrivate(page)) {
 			unsigned int	j, range;
 
 			ASSERT(blocksize < PAGE_CACHE_SIZE);
