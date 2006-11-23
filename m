Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757443AbWKWTXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443AbWKWTXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757444AbWKWTXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:23:25 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:43538 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1757443AbWKWTXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:23:24 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm1
Date: Thu, 23 Nov 2006 20:24:14 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061123021703.8550e37e.akpm@osdl.org> <200611231223.48703.m.kozlowski@tuxland.pl> <20061123103607.af7ae8b0.akpm@osdl.org>
In-Reply-To: <20061123103607.af7ae8b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611232024.15179.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> > 	Hmmm ... didn't apply cleanly.
> > 
> > patching file kernel/tsacct.c
> > Hunk #1 FAILED at 97.
> > 1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej
> 
> I think your local tree is not clean.

Nope. I've seen it on three boxes.
 
> > Anyway this is what I get on my laptop:
> > 
> > =================================
> > [ INFO: inconsistent lock state ]
> > 2.6.19-rc6-mm1 #1
> > ---------------------------------
> > inconsistent {hardirq-on-R} -> {in-hardirq-W} usage.
> 
> hm, nested read_lock_irq()+read_unlock_irq() in the readahead code..

I guess what you meant was sth like the patch below. That helped. Thanks.

--- linux-2.6.19-rc6-mm1-a/mm/readahead.c	2006-11-23 20:03:53.000000000 +0100
+++ linux-2.6.19-rc6-mm1-b/mm/readahead.c	2006-11-23 19:57:26.000000000 +0100
@@ -1227,10 +1227,10 @@ static inline unsigned long inactive_pag

 /*
  * Count/estimate cache hits in range [begin, end).
- * The estimation is simple and optimistic.
+ * The estimation is simple and optimistic. The caller must hold tree_lock.
  */
 #define CACHE_HIT_HASH_KEY	29	/* some prime number */
-static int count_cache_hit(struct address_space *mapping,
+static int __count_cache_hit(struct address_space *mapping,
 						pgoff_t begin, pgoff_t end)
 {
 	int size = end - begin;
@@ -1243,14 +1243,12 @@ static int count_cache_hit(struct addres
 	 * behavior guarantees a readahead when (size < ra_max) and
 	 * (readahead_hit_rate >= 8).
 	 */
-	read_lock_irq(&mapping->tree_lock);
 	for (i = 0; i < 8;) {
 		struct page *page = radix_tree_lookup(&mapping->page_tree,
 			begin + size * ((i++ * CACHE_HIT_HASH_KEY) & 7) / 8);
 		if (inactive_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
 			break;
 	}
-	read_unlock_irq(&mapping->tree_lock);

 	return size * count / i;
 }
@@ -1282,7 +1280,7 @@ static unsigned long count_history_pages
 	 */
 	if (!(ra->flags & RA_FLAG_NFSD)) {
 		unsigned long hit_rate = max(readahead_hit_rate, 1);
-		if (count_cache_hit(mapping, head, offset) * hit_rate < count)
+		if (__count_cache_hit(mapping, head, offset) * hit_rate < count)
 			count = 0;
 	}



-- 
Regards,

	Mariusz Kozlowski
