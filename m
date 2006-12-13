Return-Path: <linux-kernel-owner+w=401wt.eu-S965066AbWLMSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWLMSvE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWLMSvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:51:04 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26042 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965061AbWLMSvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:51:01 -0500
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1166031601.9127.1.camel@lade.trondhjem.org>
References: <1166011958.32332.97.camel@twins>
	 <1166012781.5695.18.camel@lade.trondhjem.org>
	 <1166022082.32332.126.camel@twins>
	 <1166031601.9127.1.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 19:48:34 +0100
Message-Id: <1166035714.32332.159.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 12:40 -0500, Trond Myklebust wrote:
> On Wed, 2006-12-13 at 16:01 +0100, Peter Zijlstra wrote:

> > @@ -386,12 +380,13 @@ int invalidate_inode_pages2_range(struct
> >  					  PAGE_CACHE_SIZE, 0);
> >  				}
> >  			}
> > -			was_dirty = test_clear_page_dirty(page);
> > +			was_dirty = PageDirty(page);
> >  			if (!invalidate_complete_page2(mapping, page)) {
> >  				if (was_dirty)
> >  					set_page_dirty(page);
>                                           ^^^^^^^^^^^^^^^^^^^^^
> 
> Why would you still need this?

Hmm yeah, that doesn't make sense. What kind of twist did I get my brain
into.

This should do. 

Hmm, does this agree with the DIO path? I just noticed
generic_file_direct_IO() also uses invalidate_inode_pages2_range().
I think it does, its looks like all they want is to ensure nothing
remains in the pagecache after a write, which itself ensures nothing is
dirty to begin with.


---
Delay clearing the dirty page state till after we've invalidated the
page in invalidate_complete_page2(). This gives try_to_release_pages() a
chance to flush dirty data.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfs/file.c |    2 --
 mm/truncate.c |   14 ++------------
 2 files changed, 2 insertions(+), 14 deletions(-)

Index: linux-2.6-git/fs/nfs/file.c
===================================================================
--- linux-2.6-git.orig/fs/nfs/file.c	2006-12-13 19:41:09.000000000 +0100
+++ linux-2.6-git/fs/nfs/file.c	2006-12-13 19:42:18.000000000 +0100
@@ -320,8 +320,6 @@ static int nfs_release_page(struct page 
 	 */
 	if (!(gfp & __GFP_FS))
 		return 0;
-	/* Hack... Force nfs_wb_page() to write out the page */
-	set_page_dirty(page);
 	return !nfs_wb_page(page_file_mapping(page)->host, page);
 }
 
Index: linux-2.6-git/mm/truncate.c
===================================================================
--- linux-2.6-git.orig/mm/truncate.c	2006-12-13 19:41:09.000000000 +0100
+++ linux-2.6-git/mm/truncate.c	2006-12-13 19:42:56.000000000 +0100
@@ -306,19 +306,14 @@ invalidate_complete_page2(struct address
 	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
+	test_clear_page_dirty(page);
 	write_lock_irq(&mapping->tree_lock);
-	if (PageDirty(page))
-		goto failed;
-
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
-failed:
-	write_unlock_irq(&mapping->tree_lock);
-	return 0;
 }
 
 /**
@@ -350,7 +345,6 @@ int invalidate_inode_pages2_range(struct
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index;
-			int was_dirty;
 
 			lock_page(page);
 			if (page->mapping != mapping) {
@@ -386,12 +380,8 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page2(mapping, page)) {
-				if (was_dirty)
-					set_page_dirty(page);
+			if (!invalidate_complete_page2(mapping, page))
 				ret = -EIO;
-			}
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);


