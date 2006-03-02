Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWCBFXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCBFXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 00:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWCBFXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 00:23:40 -0500
Received: from ns1.suse.de ([195.135.220.2]:14763 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750926AbWCBFXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 00:23:40 -0500
From: Neil Brown <neilb@suse.de>
To: Tony Griffiths <tonyg@agile.tv>
Date: Thu, 2 Mar 2006 16:22:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.33060.524391.21108@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Fixes for NFS file truncation race condition(s)
In-Reply-To: message from Tony Griffiths on Thursday March 2
References: <44067961.20709@agile.tv>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 2, tonyg@agile.tv wrote:
> Attached are two file, the first being a diff patch file, and the second 
> being a test program that can be used to invoke the problem and confirm 
> that it has been fixed after the patches are applied.
> 
...
> 
> kernel BUG at lib/radix-tree.c:372!

....


Hey, I've been looking at that bug too!  It a good one :-)

I think your patch addresses the symptom rather than the cause.  It
tries to notice that the race has been lost and avoid an oops.

The following patch - which I sent to Trond (nfs maintainer) for
passing on upstream (though much of the patch is from him in the first
place) fixes the cause, which is subtle.

NeilBrown

----------------------------------------

Subject: Nfs: Avoid races between writebacks and truncation
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Patch-mainline: pending
References: 144058

Author: Trond Myklebust <Trond.Myklebust@netapp.com> (Modified by NeilBrown <neilb@suse.de>)
Currently, there is no serialisation between NFS asynchronous writebacks
and truncation at the page level due to the fact that nfs_sync_inode()
cannot lock the pages that it is about to write out.

This means that it is possible to be flushing out data (and calling something
like set_page_writeback()) while the page cache is busy evicting the page.
Oops...

Use the hooks provided in try_to_release_page() to ensure that dirty pages
are not evictged before being written out to store.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Neil Brown <neilb@suse.de>


Index: linux-2.6.15/fs/nfs/file.c
===================================================================
--- linux-2.6.15.orig/fs/nfs/file.c	2006-02-24 14:56:42.000000000 +1100
+++ linux-2.6.15/fs/nfs/file.c	2006-03-02 13:42:42.000000000 +1100
@@ -316,6 +316,23 @@
 	return status;
 }
 
+static int nfs_invalidate_page(struct page *page, unsigned long offset)
+{
+	BUG_ON(PagePrivate(page));
+	return 1;
+}
+
+static int nfs_release_page(struct page *page, gfp_t gfp)
+{
+	/* If this was called, then PagePrivate is set, so we have
+	 * pending write back, so the page cannot be released.
+	 * However we can clear the Uptodate flag so we get the desired
+	 * effect of the page being invalidated.
+	 */
+	ClearPageUptodate(page);
+	return 0;
+}
+
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -324,6 +341,8 @@
 	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,
 	.commit_write = nfs_commit_write,
+	.invalidatepage = nfs_invalidate_page,
+	.releasepage = nfs_release_page,
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
Index: linux-2.6.15/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.15.orig/fs/nfs/pagelist.c	2006-02-24 14:56:42.000000000 +1100
+++ linux-2.6.15/fs/nfs/pagelist.c	2006-03-02 13:40:23.000000000 +1100
@@ -85,6 +85,7 @@
 	atomic_set(&req->wb_complete, 0);
 	req->wb_index	= page->index;
 	page_cache_get(page);
+	SetPagePrivate(page);
 	req->wb_offset  = offset;
 	req->wb_pgbase	= offset;
 	req->wb_bytes   = count;
@@ -147,8 +148,10 @@
  */
 void nfs_clear_request(struct nfs_page *req)
 {
-	if (req->wb_page) {
-		page_cache_release(req->wb_page);
+	struct page *page = req->wb_page;
+	if (page != NULL) {
+		ClearPagePrivate(page);
+		page_cache_release(page);
 		req->wb_page = NULL;
 	}
 }
