Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSGaCAp>; Tue, 30 Jul 2002 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGaCAp>; Tue, 30 Jul 2002 22:00:45 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:15268 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S317638AbSGaCAo>; Tue, 30 Jul 2002 22:00:44 -0400
Message-ID: <3D474442.6040804@quark.didntduck.org>
Date: Tue, 30 Jul 2002 21:58:26 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor slabinfo cleanup
Content-Type: multipart/mixed;
 boundary="------------020405060004020203080400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020405060004020203080400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the use of a magic pointer value to print the
slabinfo version header.  Resend against latest BK snapshot.

-- 
				Brian Gerst

--------------020405060004020203080400
Content-Type: text/plain;
 name="slabinfo-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo-2"

diff -urN linux-bk/mm/slab.c linux/mm/slab.c
--- linux-bk/mm/slab.c	Tue Jul 30 20:59:28 2002
+++ linux/mm/slab.c	Tue Jul 30 21:56:02 2002
@@ -1904,10 +1904,22 @@
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
@@ -1919,8 +1931,6 @@
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
-	if (p == (void *)1)
-		return &cache_cache;
 	cachep = list_entry(cachep->next.next, kmem_cache_t, next);
 	return cachep == &cache_cache ? NULL : cachep;
 }
@@ -1941,22 +1951,6 @@
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

--------------020405060004020203080400--

