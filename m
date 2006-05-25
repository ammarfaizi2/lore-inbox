Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWEYF4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWEYF4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWEYF4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:56:53 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:45415 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965053AbWEYF4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:56:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pFKXFlVPtEaD9KVfM4i06G6UnOorfXnnGpRw6XSQEVNm63i+cWoBeUKs45JjlvI4PxzPWW9IsmTOe/2t8VuNZd2JsWAuGexdFIr4wJEtpMnHws3OJ3g8LS7XaUU78iMZSIGW5vMLDugO7lp3/0hOXKlvyJA/mODconv+kz4v+hI=  ;
Message-ID: <44754708.5090406@yahoo.com.au>
Date: Thu, 25 May 2006 15:56:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
References: <20060524111246.420010595@localhost.localdomain> <348469539.42623@ustc.edu.cn>
In-Reply-To: <348469539.42623@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>Define some common used macros for the read-ahead logics.
>
>Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
>---
>
> mm/readahead.c |   14 ++++++++++++--
> 1 files changed, 12 insertions(+), 2 deletions(-)
>
>--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
>+++ linux-2.6.17-rc4-mm3/mm/readahead.c
>@@ -5,6 +5,8 @@
>  *
>  * 09Apr2002	akpm@zip.com.au
>  *		Initial version.
>+ * 21May2006	Wu Fengguang <wfg@mail.ustc.edu.cn>
>+ *		Adaptive read-ahead framework.
>  */
> 
> #include <linux/kernel.h>
>@@ -14,6 +16,14 @@
> #include <linux/blkdev.h>
> #include <linux/backing-dev.h>
> #include <linux/pagevec.h>
>+#include <linux/writeback.h>
>+#include <linux/nfsd/const.h>
>

How come you're adding these includes?

>+
>+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
>+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
>
Don't really like the names. Don't think they do anything for clarity, but
if you can come up with something better for PAGES_BYTE I might change my
mind ;) (just forget about PAGES_KB - people know what *1024 means)

Also: the replacements are wrong: if you've defined VM_MAX_READAHEAD to be
4095 bytes, you don't want the _actual_ readahead to be 4096 bytes, do you?
It is saying nothing about minimum, so presumably 0 is the correct choice.


>+
>+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
>+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
>

Again, it is probably easier just to use the expanded version. Then the
reader can immediately say: ah, the next page on the LRU list (rather
than, maybe, the next page in the pagecache).

> 
> void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
> {
>@@ -21,7 +31,7 @@ void default_unplug_io_fn(struct backing
> EXPORT_SYMBOL(default_unplug_io_fn);
> 
> struct backing_dev_info default_backing_dev_info = {
>-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
>+	.ra_pages	= PAGES_KB(VM_MAX_READAHEAD),
> 	.state		= 0,
> 	.capabilities	= BDI_CAP_MAP_COPY,
> 	.unplug_io_fn	= default_unplug_io_fn,
>@@ -50,7 +60,7 @@ static inline unsigned long get_max_read
> 
> static inline unsigned long get_min_readahead(struct file_ra_state *ra)
> {
>-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
>+	return PAGES_KB(VM_MIN_READAHEAD);
> }
> 
> static inline void reset_ahead_window(struct file_ra_state *ra)
>
>--
>

Send instant messages to your online friends http://au.messenger.yahoo.com 
