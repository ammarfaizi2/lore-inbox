Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVCHQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVCHQzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVCHQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:55:39 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:33743 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261418AbVCHQza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:55:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=ioBg3df6mu/Oiubyisb7ZRcjIwO22an0znqhp/geCMPv2kWMpQ84v6bZvFq/5ceBvstmSRDUFW9whg0yqGYdhNGt1HNPpEWRh+djhEepCLDw3H7ComQ1MFMrcrgic4RKtyRAJUGr7LsvtsDNHec8+iAzku9bwhtvwChzpcSPw4k=
Message-ID: <2cd57c9005030808554fd3c337@mail.gmail.com>
Date: Wed, 9 Mar 2005 00:55:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: akpm@osdl.org
Subject: [patch] mnt_init() cleanup
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello akpm,

At the very beginning in 2.4 days, in mnt_init(), mount_hashtable
allocation page order was determined at runtime. Later the page order
got fixed to 0. This patch cleanups it.


Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>

diff -Nrup 2.6.11/fs/namespace.c 2.6.11-cy/fs/namespace.c
--- 2.6.11/fs/namespace.c	2005-03-03 17:11:56.000000000 +0800
+++ 2.6.11-cy/fs/namespace.c	2005-03-08 04:52:30.000000000 +0800
@@ -1392,16 +1392,14 @@ static void __init init_mount_tree(void)
 void __init mnt_init(unsigned long mempages)
 {
 	struct list_head *d;
-	unsigned long order;
 	unsigned int nr_hash;
 	int i;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	order = 0; 
 	mount_hashtable = (struct list_head *)
-		__get_free_pages(GFP_ATOMIC, order);
+		__get_free_page(GFP_ATOMIC);
 
 	if (!mount_hashtable)
 		panic("Failed to allocate mount hash table\n");
@@ -1411,7 +1409,7 @@ void __init mnt_init(unsigned long mempa
 	 * We don't guarantee that "sizeof(struct list_head)" is necessarily
 	 * a power-of-two.
 	 */
-	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct list_head);
+	nr_hash = PAGE_SIZE / sizeof(struct list_head);
 	hash_bits = 0;
 	do {
 		hash_bits++;
@@ -1426,7 +1424,7 @@ void __init mnt_init(unsigned long mempa
 	hash_mask = nr_hash-1;
 
 	printk("Mount-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
+			nr_hash, 0, PAGE_SIZE);
 
 	/* And initialize the newly allocated array */
 	d = mount_hashtable;
-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
