Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSGIWuA>; Tue, 9 Jul 2002 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSGIWuA>; Tue, 9 Jul 2002 18:50:00 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:2209 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S317446AbSGIWt7>; Tue, 9 Jul 2002 18:49:59 -0400
Message-ID: <3D2B67F9.1060000@quark.didntduck.org>
Date: Tue, 09 Jul 2002 18:47:21 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor slabinfo cleanup
Content-Type: multipart/mixed;
 boundary="------------060004000902070902020006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060004000902070902020006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the use of a magic pointer value to print the 
slabinfo version header.

--
				Brian Gerst

--------------060004000902070902020006
Content-Type: text/plain;
 name="slabinfo-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo-1"

diff -urN linux-2.5.25/mm/slab.c linux/mm/slab.c
--- linux-2.5.25/mm/slab.c	Mon Jul  8 14:00:33 2002
+++ linux/mm/slab.c	Mon Jul  8 14:10:36 2002
@@ -1885,10 +1885,22 @@
 	struct list_head *p;
 
 	down(&cache_chain_sem);
-	if (!n)
-		return (void *)1;
+	if (!n) {
+		/*
+		 * Output format version, so at least we can change it
+		 * without _too_ many complaints.
+		 */
+		seq_puts(m, "slabinfo - version: 1.1"
+#if STATS
+				" (statistics)"
+#endif
+#ifdef CONFIG_SMP
+				" (SMP)"
+#endif
+				"\n");
+	};
 	p = &cache_cache.next;
-	while (--n) {
+	while (n--) {
 		p = p->next;
 		if (p == &cache_cache.next)
 			return NULL;
@@ -1900,8 +1912,6 @@
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
-	if (p == (void *)1)
-		return &cache_cache;
 	cachep = list_entry(cachep->next.next, kmem_cache_t, next);
 	return cachep == &cache_cache ? NULL : cachep;
 }
@@ -1922,22 +1932,6 @@
 	unsigned long	num_slabs;
 	const char *name; 
 
-	if (p == (void*)1) {
-		/*
-		 * Output format version, so at least we can change it
-		 * without _too_ many complaints.
-		 */
-		seq_puts(m, "slabinfo - version: 1.1"
-#if STATS
-				" (statistics)"
-#endif
-#ifdef CONFIG_SMP
-				" (SMP)"
-#endif
-				"\n");
-		return 0;
-	}
-
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;

--------------060004000902070902020006--

