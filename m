Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbTDIFqr (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDIFqq (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:46:46 -0400
Received: from palrel12.hp.com ([156.153.255.237]:60390 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262778AbTDIFqo (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 01:46:44 -0400
Date: Tue, 8 Apr 2003 22:58:22 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304090558.h395wMiQ004136@napali.hpl.hp.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: kmalloc_sizes.h breakage
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone forgot that the cache_sizes array needs to be NULL terminated.
This, combined with the NFSD 64-bit binary compatibility breakage
caused instant kernel death because kmalloc() (via NFSD) would attempt
to alloc a huge chunk of memory and run past the end of the
cache_sizes array.  In other words, a fun evening chasing down bugs.
Not.

(The patch also gets rid of some trailing whitespace, in case you
 wonder about those "invisible" changes.)

	--david

===== mm/slab.c 1.73 vs edited =====
--- 1.73/mm/slab.c	Thu Mar 27 21:16:47 2003
+++ edited/mm/slab.c	Tue Apr  8 17:52:44 2003
@@ -387,14 +387,15 @@
 };
 
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
-static struct { 
-	char *name; 
+static struct {
+	char *name;
 	char *name_dma;
-} cache_names[] = { 
+} cache_names[] = {
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
 #include <linux/kmalloc_sizes.h>
+	{ 0, }
 #undef CACHE
-}; 
+};
 
 struct arraycache_init initarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 struct arraycache_init initarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
