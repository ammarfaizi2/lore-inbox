Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTBVQoH>; Sat, 22 Feb 2003 11:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTBVQoH>; Sat, 22 Feb 2003 11:44:07 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:51924 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S266777AbTBVQoG>; Sat, 22 Feb 2003 11:44:06 -0500
Message-ID: <3E57AB20.1000103@quark.didntduck.org>
Date: Sat, 22 Feb 2003 11:53:52 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix up slabinfo code
Content-Type: multipart/mixed;
 boundary="------------030802090802010601000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030802090802010601000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Move printing the header to s_start, removing the need for the special 
pointer value.

--
				Brian Gerst

--------------030802090802010601000604
Content-Type: text/plain;
 name="slabinfo-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo-1"

diff -urN linux-2.5.62-bk2/mm/slab.c linux/mm/slab.c
--- linux-2.5.62-bk2/mm/slab.c	2003-02-18 01:30:26.000000000 -0500
+++ linux/mm/slab.c	2003-02-22 11:45:35.000000000 -0500
@@ -2194,10 +2194,19 @@
 	struct list_head *p;
 
 	down(&cache_chain_sem);
-	if (!n)
-		return (void *)1;
+	if (!n) {
+		/*
+		 * Output format version, so at least we can change it
+		 * without _too_ many complaints.
+		 */
+		seq_puts(m, "slabinfo - version: 1.2"
+#if STATS
+				" (statistics)"
+#endif
+				"\n");
+	}
 	p = cache_chain.next;
-	while (--n) {
+	while (n--) {
 		p = p->next;
 		if (p == &cache_chain)
 			return NULL;
@@ -2209,8 +2218,6 @@
 {
 	kmem_cache_t *cachep = p;
 	++*pos;
-	if (p == (void *)1)
-		return list_entry(cache_chain.next, kmem_cache_t, next);
 	return cachep->next.next == &cache_chain ? NULL
 		: list_entry(cachep->next.next, kmem_cache_t, next);
 }
@@ -2234,20 +2241,6 @@
 	mm_segment_t old_fs;
 	char tmp; 
 
-
-	if (p == (void*)1) {
-		/*
-		 * Output format version, so at least we can change it
-		 * without _too_ many complaints.
-		 */
-		seq_puts(m, "slabinfo - version: 1.2"
-#if STATS
-				" (statistics)"
-#endif
-				"\n");
-		return 0;
-	}
-
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;

--------------030802090802010601000604--

