Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbULGVQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbULGVQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbULGVQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:16:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:29365 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261943AbULGVNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:13:43 -0500
Date: Tue, 7 Dec 2004 22:23:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Mark Hemment <markhe@nextd.demon.co.uk>,
       akpm@osdl.org
Subject: [PATCH][2/2] fix unchecked returns from kmalloc() (in mm/slab.c)
Message-ID: <Pine.LNX.4.61.0412072213320.3320@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem reported by Katrina Tsipenyuk and the Fortify Software engineering
team in thread with subject "PROBLEM: unchecked returns from kmalloc() in
linux-2.6.10-rc2".

Unfortunately I'm not very familliar with the code in question, and since 
I didn't find a really good way to deal with a failing kmalloc() here I 
settled for second best which is to add a BUG_ON() in case kmalloc fails. 
This will at least crash in a sane way at the point the problem occoures 
rather than getting strange problems at a (possibly) later time. If 
someone who's familliar with how this code works has a better solution 
then please step forward :) but in the mean time I think this is at least 
a slight improvement over the current situation.

Patch has been compile tested and boot tested and didn't blow up 
instantly, but please review before applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk2-orig/mm/slab.c linux-2.6.10-rc3-bk2/mm/slab.c
--- linux-2.6.10-rc3-bk2-orig/mm/slab.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk2/mm/slab.c	2004-12-07 21:27:20.000000000 +0100
@@ -804,6 +804,7 @@ void __init kmem_cache_init(void)
 		void * ptr;
 		
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(ptr == NULL);	/* FIXME: Can a failed kmalloc be handled better? */
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
 		memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init));
@@ -811,6 +812,7 @@ void __init kmem_cache_init(void)
 		local_irq_enable();
 	
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(ptr == NULL);	/* FIXME: Can a failed kmalloc be handled better? */
 		local_irq_disable();
 		BUG_ON(ac_data(malloc_sizes[0].cs_cachep) != &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),



