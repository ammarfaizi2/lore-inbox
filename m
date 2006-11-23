Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWKWSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWKWSgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 13:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757373AbWKWSgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 13:36:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757359AbWKWSgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 13:36:18 -0500
Date: Thu, 23 Nov 2006 10:36:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1
Message-Id: <20061123103607.af7ae8b0.akpm@osdl.org>
In-Reply-To: <200611231223.48703.m.kozlowski@tuxland.pl>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<200611231223.48703.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 12:23:48 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> 
> Hello,
> 
> 	Hmmm ... didn't apply cleanly.
> 
> patching file kernel/tsacct.c
> Hunk #1 FAILED at 97.
> 1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej

I think your local tree is not clean.

> Anyway this is what I get on my laptop:
> 
> =================================
> [ INFO: inconsistent lock state ]
> 2.6.19-rc6-mm1 #1
> ---------------------------------
> inconsistent {hardirq-on-R} -> {in-hardirq-W} usage.

hm, nested read_lock_irq()+read_unlock_irq() in the readahead code..

--- a/mm/readahead.c~readahead-context-based-method-locking-fix
+++ a/mm/readahead.c
@@ -1171,10 +1171,10 @@ static inline unsigned long inactive_pag
 
 /*
  * Count/estimate cache hits in range [begin, end).
- * The estimation is simple and optimistic.
+ * The estimation is simple and optimistic.  The caller must hold tree_lock.
  */
 #define CACHE_HIT_HASH_KEY	29	/* some prime number */
-static int count_cache_hit(struct address_space *mapping,
+static int __count_cache_hit(struct address_space *mapping,
 						pgoff_t begin, pgoff_t end)
 {
 	int size = end - begin;
@@ -1187,14 +1187,12 @@ static int count_cache_hit(struct addres
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
_

