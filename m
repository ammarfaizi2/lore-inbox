Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSC0Tjp>; Wed, 27 Mar 2002 14:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313085AbSC0Tj0>; Wed, 27 Mar 2002 14:39:26 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:3993 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S313083AbSC0TjT>;
	Wed, 27 Mar 2002 14:39:19 -0500
Subject: [RFC] kmem_cache_zalloc
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Mar 2002 13:39:17 -0600
Message-Id: <1017257958.16305.168.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the interest of whittling down the changes that XFS makes to the core
kernel, I thought I'd start throwing out some the easier self-contained
modifications for discussion.

XFS adds a kmem_cache_zalloc function to mm/slab.c, it does what you
might expect:  kmem_cache_alloc + memset

Is this something that might be considered for inclusion in the core
kernel, or should we roll it back into fs/xfs?

Thanks,

-Eric

--- 18.1/mm/slab.c Fri, 07 Dec 2001 09:35:49 +1100 kaos (linux-2.4/j/5_slab.c 1.2.1.2.1.2.1.3.1.3 644)
+++ 18.11/mm/slab.c Mon, 07 Jan 2002 13:27:25 +1100 kaos (linux-2.4/j/5_slab.c 1.2.1.2.1.7 644)
@@ -1567,6 +1567,23 @@ void kmem_cache_free (kmem_cache_t *cach
 	local_irq_restore(flags);
 }
 
+void *
+kmem_cache_zalloc(kmem_cache_t *cachep, int flags)
+{
+	void    *ptr;
+	ptr = __kmem_cache_alloc(cachep, flags);
+	if (ptr)
+#if DEBUG
+		memset(ptr, 0, cachep->objsize -
+			(cachep->flags & SLAB_RED_ZONE ? 2*BYTES_PER_WORD : 0));
+#else
+		memset(ptr, 0, cachep->objsize);
+#endif
+
+	return ptr;
+}
+
+


-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

