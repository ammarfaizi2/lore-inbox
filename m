Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVCGX5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVCGX5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVCGXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:54:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:10160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbVCGXuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:50:09 -0500
Date: Mon, 7 Mar 2005 15:50:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-Id: <20050307155001.099352b5.akpm@osdl.org>
In-Reply-To: <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050304160451.4c33919c.akpm@osdl.org>
	<1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307123118.3a946bc8.akpm@osdl.org>
	<1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307131113.0fd7477e.akpm@osdl.org>
	<1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
	<1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> In invalidate_inode_pages2_range(), what happens if we lookup a pagevec,
> get a bunch of pages back, but all the pages in the vec are beyond the
> end of the range we want?

hmm, yes.  Another one :(

> @@ -271,12 +271,13 @@ int invalidate_inode_pages2_range(struct
>  			int was_dirty;
>  
>  			lock_page(page);
> +			if (page->mapping == mapping)
> +				next = page->index + 1;
>  			if (page->mapping != mapping || page->index > end) {
>  				unlock_page(page);
>  				continue;
>  			}
>  			wait_on_page_writeback(page);
> -			next = page->index + 1;
>  			if (next == 0)
>  				wrapped = 1;
>  			while (page_mapped(page)) {

truncate_inode_pages_range() seems to dtrt here.  Can we do it in the same
manner in invalidate_inode_pages2_range()?


Something like:


diff -puN mm/truncate.c~invalidate_inode_pages2_range-livelock-fix mm/truncate.c
--- 25/mm/truncate.c~invalidate_inode_pages2_range-livelock-fix	Mon Mar  7 15:47:25 2005
+++ 25-akpm/mm/truncate.c	Mon Mar  7 15:49:09 2005
@@ -305,15 +305,22 @@ int invalidate_inode_pages2_range(struct
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			pgoff_t page_index;
 			int was_dirty;
 
 			lock_page(page);
-			if (page->mapping != mapping || page->index > end) {
+			page_index = page->index;
+			if (page_index > end) {
+				next = page_index;
+				unlock_page(page);
+				break;
+			}
+			if (page->mapping != mapping) {
 				unlock_page(page);
 				continue;
 			}
 			wait_on_page_writeback(page);
-			next = page->index + 1;
+			next = page_index + 1;
 			if (next == 0)
 				wrapped = 1;
 			while (page_mapped(page)) {
@@ -323,7 +330,7 @@ int invalidate_inode_pages2_range(struct
 					 */
 					unmap_mapping_range(mapping,
 					    page->index << PAGE_CACHE_SHIFT,
-					    (end - page->index + 1)
+					    (end - page_index + 1)
 							<< PAGE_CACHE_SHIFT,
 					    0);
 					did_range_unmap = 1;
@@ -332,7 +339,7 @@ int invalidate_inode_pages2_range(struct
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
-					  page->index << PAGE_CACHE_SHIFT,
+					  page_index << PAGE_CACHE_SHIFT,
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
_

