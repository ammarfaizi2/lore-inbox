Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWCaSpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWCaSpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWCaSpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:45:50 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:40834 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750959AbWCaSpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:45:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=GuNxbmgMWFiKq4ZtZz9gWe4qG1t2P/DZKhv01wsa6paCLM+3SaO8KWkrKdOe9zeekOLcDtGeZZzukXvD7GFMzwKICYTT9xnZ3tuZipxpb7j88GQtEybM+vcA44jPq2PhD5x6aAuH01fD7z9Ml0RnkwQR8INjuK7hg/Kv5v/1r0c=  ;
Message-ID: <442CED15.7000303@yahoo.com.au>
Date: Fri, 31 Mar 2006 18:49:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice SPLICE_F_MOVE support
References: <20060330131530.GI13476@suse.de> <20060330131915.GJ13476@suse.de>
In-Reply-To: <20060330131915.GJ13476@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090609000908050307090706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000908050307090706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> Hi,
> 
> This applies on top of the splice #3 just posted, adding support for
> moving of pages. The caller can use the SPLICE_F_MOVE flag to the splice
> syscall to ask the kernel to try and move pages, if needed.
> 
> Disclaimer: this works for me, but may have vm issues that I missed.
> CC'ing Nick :-)
> 

Like Andrew said, you can't check PageLRU without holding zone->lru_lock.
The page release code can get away with it only because the page refcount
is 0 at that point. Also, you can't reliably remove pages from the LRU
unless the refcount is 0. Ever.

The following (untested) is something like what I had in mind, and should
get stealing closer to working. I've only given it a quick review so far
(btw. why do you only unlock the page if it hasn't been stolen?)

With this patch, the ->steal will indicate if the page had been on the
LRU or not. If not, then add it; if yes, then do nothing.

There is no caller of ->steal yet that wants the page off the LRU (is
there?). That's a bit harder.

---

--------------090609000908050307090706
Content-Type: text/plain;
 name="splice-fix-lruops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="splice-fix-lruops.patch"

Index: linux-2.6/fs/pipe.c
===================================================================
--- linux-2.6.orig/fs/pipe.c
+++ linux-2.6/fs/pipe.c
@@ -124,7 +124,7 @@ static void anon_pipe_buf_unmap(struct p
 static int anon_pipe_buf_steal(struct pipe_inode_info *info,
 			       struct pipe_buffer *buf)
 {
-	buf->stolen = 1;
+	buf->flags |= PIPE_BUF_FLAG_STOLEN;
 	return 0;
 }
 
Index: linux-2.6/fs/splice.c
===================================================================
--- linux-2.6.orig/fs/splice.c
+++ linux-2.6/fs/splice.c
@@ -45,17 +45,8 @@ static int page_cache_pipe_buf_steal(str
 	if (!remove_mapping(page_mapping(page), page))
 		return 1;
 
-	if (PageLRU(page)) {
-		struct zone *zone = page_zone(page);
+	buf->flags |= PIPE_BUF_FLAG_STOLEN | PIPE_BUF_FLAG_LRU;
 
-		spin_lock_irq(&zone->lru_lock);
-		BUG_ON(!PageLRU(page));
-		__ClearPageLRU(page);
-		del_page_from_lru(zone, page);
-		spin_unlock_irq(&zone->lru_lock);
-	}
-
-	buf->stolen = 1;
 	return 0;
 }
 
@@ -64,7 +55,7 @@ static void page_cache_pipe_buf_release(
 {
 	page_cache_release(buf->page);
 	buf->page = NULL;
-	buf->stolen = 0;
+	buf->flags &= ~(PIPE_BUF_FLAG_STOLEN|PIPE_BUF_FLAG_LRU);
 }
 
 static void *page_cache_pipe_buf_map(struct file *file,
@@ -91,7 +82,7 @@ static void *page_cache_pipe_buf_map(str
 static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
 				      struct pipe_buffer *buf)
 {
-	if (!buf->stolen)
+	if (!(buf->flags & PIPE_BUF_FLAG_STOLEN))
 		unlock_page(buf->page);
 	kunmap(buf->page);
 }
@@ -386,11 +377,13 @@ static int pipe_to_file(struct pipe_inod
 	if (sd->flags & SPLICE_F_MOVE) {
 		if (buf->ops->steal(info, buf))
 			goto find_page;
-
 		page = buf->page;
-		if (add_to_page_cache_lru(page, mapping, index,
-						mapping_gfp_mask(mapping)))
+		if (add_to_page_cache(page, mapping, index,
+					mapping_gfp_mask(mapping)))
 			goto find_page;
+
+		if (!(buf->flags & PIPE_BUF_FLAG_LRU))
+			lru_cache_add(page);
 	} else {
 find_page:
 		ret = -ENOMEM;
@@ -435,7 +428,7 @@ find_page:
 	if (ret)
 		goto out;
 
-	if (!buf->stolen) {
+	if (!(buf->flags & PIPE_BUF_FLAG_STOLEN)) {
 		char *dst = kmap_atomic(page, KM_USER0);
 
 		memcpy(dst + offset, src + buf->offset, sd->len);
@@ -452,7 +445,7 @@ find_page:
 out:
 	if (ret < 0)
 		unlock_page(page);
-	if (!buf->stolen)
+	if (!(buf->flags & PIPE_BUF_FLAG_STOLEN))
 		page_cache_release(page);
 	buf->ops->unmap(info, buf);
 	return ret;
Index: linux-2.6/include/linux/pipe_fs_i.h
===================================================================
--- linux-2.6.orig/include/linux/pipe_fs_i.h
+++ linux-2.6/include/linux/pipe_fs_i.h
@@ -5,11 +5,14 @@
 
 #define PIPE_BUFFERS (16)
 
+#define PIPE_BUF_FLAG_STOLEN	0x01
+#define PIPE_BUF_FLAG_LRU	0x02
+
 struct pipe_buffer {
 	struct page *page;
 	unsigned int offset, len;
 	struct pipe_buf_operations *ops;
-	unsigned int stolen;
+	unsigned int flags;
 };
 
 struct pipe_buf_operations {
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -177,7 +177,7 @@ void lru_add_drain(void)
 	put_cpu();
 }
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SMP
 static void lru_add_drain_per_cpu(void *dummy)
 {
 	lru_add_drain();

--------------090609000908050307090706--
Send instant messages to your online friends http://au.messenger.yahoo.com 
