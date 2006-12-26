Return-Path: <linux-kernel-owner+w=401wt.eu-S932725AbWLZRVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWLZRVY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWLZRVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:21:24 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:55103 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbWLZRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:21:23 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 12:21:23 EST
Message-ID: <1167153681.45915a11a02fb@imp3-g19.free.fr>
Date: Tue, 26 Dec 2006 18:21:21 +0100
From: dimitri.gorokhovik@free.fr
To: mpm@selenic.com, linux-mm@kvack.org
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 2.6.20-rc2] MM: SLOB is broken by recent cleanup of slab.h
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 87.88.35.208
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>

Recent cleanup of slab.h broke SLOB allocator: the routine kmem_cache_init
has now the __init attribute for both slab.c and slob.c. This routine cannot
be removed after init in the case of slob.c -- it serves as a timer callback.

Provide a separate timer callback routine, call it once from kmem_cache_init,
keep the __init attribute on the latter.

Signed-off-by: Dimitri Gorokhovik <dimitri.gorokhovik@free.fr>

---

--- linux-2.6.20-rc2-orig/mm/slob.c	2006-12-26 15:12:21.000000000 +0100
+++ linux-2.6.20-rc2/mm/slob.c	2006-12-26 18:02:28.000000000 +0100
@@ -60,6 +60,8 @@ static DEFINE_SPINLOCK(slob_lock);
 static DEFINE_SPINLOCK(block_lock);

 static void slob_free(void *b, int size);
+static void slob_timer_cbk(void);
+

 static void *slob_alloc(size_t size, gfp_t gfp, int align)
 {
@@ -326,7 +328,7 @@ const char *kmem_cache_name(struct kmem_
 EXPORT_SYMBOL(kmem_cache_name);

 static struct timer_list slob_timer = TIMER_INITIALIZER(
-	(void (*)(unsigned long))kmem_cache_init, 0, 0);
+	(void (*)(unsigned long))slob_timer_cbk, 0, 0);

 int kmem_cache_shrink(struct kmem_cache *d)
 {
@@ -339,7 +341,12 @@ int kmem_ptr_validate(struct kmem_cache
 	return 0;
 }

-void kmem_cache_init(void)
+void __init kmem_cache_init(void)
+{
+	slob_timer_cbk();
+}
+
+static void slob_timer_cbk(void)
 {
 	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);

