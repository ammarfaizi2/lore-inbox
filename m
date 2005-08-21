Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVHUVDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVHUVDo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVHUVDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:03:44 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:20910 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751089AbVHUVDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:03:43 -0400
Message-ID: <4308EC0F.9060703@colorfullife.com>
Date: Sun, 21 Aug 2005 23:03:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Eric Dumazet <dada1@cosmosbay.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab: removes local_irq_save()/local_irq_restore() pair
Content-Type: multipart/mixed;
 boundary="------------020907060301030107030403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907060301030107030403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Proposed by and based on a patch from Eric Dumazet <dada1@cosmosbay.com>:
This patch removes unnecessary critical section in ksize() function, as 
cli/sti are rather expensive on modern CPUS.
It additionally adds a docbook entry for ksize() and further simplifies 
the code.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------020907060301030107030403
Content-Type: text/plain;
 name="patch-slab-ksize2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-ksize2"

--- 2.6/mm/slab.c	2005-08-14 12:09:18.000000000 +0200
+++ build-2.6/mm/slab.c	2005-08-21 22:54:04.000000000 +0200
@@ -3073,20 +3073,24 @@
 }
 #endif
 
+/**
+ * ksize - get the actual amount of memory allocated for a given object
+ * @objp: Pointer to the object
+ *
+ * kmalloc may internally round up allocations and return more memory
+ * than requested. ksize() can be used to determine the actual amount of
+ * memory allocated. The caller may use this additional memory, even though
+ * a smaller amount of memory was initially specified with the kmalloc call.
+ * The caller must guarantee that objp points to a valid object previously
+ * allocated with either kmalloc() or kmem_cache_alloc(). The object
+ * must not be freed during the duration of the call.
+ */
 unsigned int ksize(const void *objp)
 {
-	kmem_cache_t *c;
-	unsigned long flags;
-	unsigned int size = 0;
-
-	if (likely(objp != NULL)) {
-		local_irq_save(flags);
-		c = GET_PAGE_CACHE(virt_to_page(objp));
-		size = kmem_cache_size(c);
-		local_irq_restore(flags);
-	}
+	if (unlikely(objp == NULL))
+		return 0;
 
-	return size;
+	return obj_reallen(GET_PAGE_CACHE(virt_to_page(objp)));
 }
 
 

--------------020907060301030107030403--
