Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWJEPgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWJEPgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWJEPgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:36:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:31257 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932132AbWJEPgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:36:09 -0400
To: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org
Subject: D-cache aliasing issue in __block_prepare_write
From: Monakhov Dmitriy <dmonakhov@openvz.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
Date: Thu, 05 Oct 2006 19:16:46 +0400
Message-ID: <87ejtmn675.fsf@sw.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

It's seems I've found D-cache aliasing issue in fs/buffer.c
 
 1902  static int __block_prepare_write(struct inode *inode, struct page *page,
 1903                  unsigned from, unsigned to, get_block_t *get_block)
......
 1951               kaddr = kmap_atomic(page, KM_USER0);
 1952               if (block_end > to)
 1953                       memset(kaddr+to, 0,
 1954                               block_end-to);
 1955               if (block_start < from)
 1956                       memset(kaddr+block_start,
 1957                               0, from-block_start);
 1958               flush_dcache_page(page);
##### We call flush_dcache_page() due to page was changed 
##### and user space mapping potentially exist.
 1959               kunmap_atomic(kaddr, KM_USER0);
......

 2008                          clear_buffer_new(bh);
 2009                          kaddr = kmap_atomic(page, KM_USER0);
 2010                          memset(kaddr+block_start, 0, bh->b_size);
 2011                          kunmap_atomic(kaddr, KM_USER0);
###### Here we have absolutely identical situation. 
###### D-cache have to be flushed here too.
###### It seems it is just  forgotten here.
 
 2012                          set_buffer_uptodate(bh);
 2013                          mark_buffer_dirty(bh);
 2014                  }
 2015  next_bh:
 2016                  block_start = block_end;
 2017                  bh = bh->b_this_page;
 2018          } while (bh != head);
 2019          return err;
 2020  }


 nobh_commit_write() has analogical issue

 2515          kaddr = kmap_atomic(page, KM_USER0);
 2516          memset(kaddr, 0, PAGE_CACHE_SIZE);
###### flush_dcache_page()  have to called here
###### It seems it is just  forgotten here too.
 2517          kunmap_atomic(kaddr, KM_USER0);
 2518          SetPageUptodate(page);
 2519          set_page_dirty(page);

x86 does not have cache aliasing problems, the problem could
show up only on marginal archs, ia64 is the most frequently used.

Following is the patch against 2.6.18 fix this issue:


--=-=-=
Content-Disposition: inline; filename=diff-buffer-flush-dcache-page

diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..b2652aa 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2008,6 +2008,7 @@ static int __block_prepare_write(struct 
 			clear_buffer_new(bh);
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr+block_start, 0, bh->b_size);
+			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
@@ -2514,6 +2515,7 @@ failed:
 	 */
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
+	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
 	SetPageUptodate(page);
 	set_page_dirty(page);

--=-=-=--

