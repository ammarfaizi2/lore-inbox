Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUKJFTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUKJFTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 00:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKJFTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 00:19:41 -0500
Received: from pop.gmx.net ([213.165.64.20]:15046 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261888AbUKJFTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 00:19:34 -0500
X-Authenticated: #21910825
Message-ID: <4191A4E2.7040502@gmx.net>
Date: Wed, 10 Nov 2004 06:19:30 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems there is a bunch of drivers which want to allocate memory as
efficiently as possible in a wide range of allocation sizes. XFS and
NTFS seem to be examples. Implement a generic wrapper to reduce code
duplication.
Functions have the my_ prefixes to avoid name clash with XFS.

Patch is compile tested

Comments/flames?

Regards,
Carl-Daniel
http://www.hailfinger.org/

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>

--- ./linux-2.6.9/mm/slab.c~	2004-11-05 14:27:49.000000000 +0100
+++ ./linux-2.6.9/mm/slab.c	2004-11-10 03:27:19.000000000 +0100
@@ -507,6 +507,8 @@
 #undef CACHE
 };

+size_t MAX_KMALLOC_SIZE;
+
 static struct arraycache_init initarray_cache __initdata =
 	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 static struct arraycache_init initarray_generic __initdata =
@@ -728,6 +730,10 @@
 	struct cache_sizes *sizes;
 	struct cache_names *names;

+#define CACHE(x) MAX_KMALLOC_SIZE = x;
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
+
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -3039,3 +3045,25 @@

 	return size;
 }
+
+void * my_kmem_alloc(size_t size, int flags)
+{
+	void	*ptr = NULL;
+
+	if (size < MAX_KMALLOC_SIZE)
+		ptr = kmalloc(size, flags);
+	if (!ptr)
+		ptr = __vmalloc(size, flags, PAGE_KERNEL);
+	return ptr;
+}
+
+void my_kmem_free(void *ptr)
+{
+	if (((unsigned long)ptr < VMALLOC_START) ||
+	    ((unsigned long)ptr >= VMALLOC_END)) {
+		kfree(ptr);
+	} else {
+		vfree(ptr);
+	}
+}
+
