Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUGMC6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUGMC6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUGMC6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:58:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17051 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262906AbUGMC5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:57:20 -0400
Date: Mon, 12 Jul 2004 21:56:43 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: dhowells@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       slpratt@us.ibm.com
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040713025643.GA7498@austin.ibm.com>
References: <20040712175605.GA1735@rx8.austin.ibm.com> <20040713023721.GA7461@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20040713023721.GA7461@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jose R. Santos <jrsantos@austin.ibm.com> [2004-07-12 21:37:21 -0500]:
> Actualy, it doesnt look like we need MAX_SYS_HASH_TABLE_ORDER at all so
> I'm resending the patch which now limits the max size of a hash table to
> 1/16 total memory pages.  This would keep people from doing dangerous
> things when using the hash_entries.

Forgot to attache the patch. :)

-JRS

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hash_entries_cmdline_first2.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1678  -> 1.1679 
#	     mm/page_alloc.c	1.202   -> 1.203  
#	include/linux/mmzone.h	1.60    -> 1.61   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/07/12	jsantos@rx8.austin.ibm.com	1.1679
# - Make ihash_entries and dhash_entries cmdline option behave like it use to.
# - Remove MAX_SYS_HASH_TABLE_ORDER.  Limit the max size to 1/16 the total number of pages.
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Mon Jul 12 21:17:10 2004
+++ b/include/linux/mmzone.h	Mon Jul 12 21:17:10 2004
@@ -20,18 +20,6 @@
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
 
-/*
- * system hash table size limits
- * - on large memory machines, we may want to allocate a bigger hash than that
- *   permitted by MAX_ORDER, so we allocate with the bootmem allocator, and are
- *   limited to this size
- */
-#if MAX_ORDER > 14
-#define MAX_SYS_HASH_TABLE_ORDER MAX_ORDER
-#else
-#define MAX_SYS_HASH_TABLE_ORDER 14
-#endif
-
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		*map;
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Mon Jul 12 21:17:10 2004
+++ b/mm/page_alloc.c	Mon Jul 12 21:17:10 2004
@@ -2000,31 +2000,30 @@
 				     unsigned int *_hash_shift,
 				     unsigned int *_hash_mask)
 {
-	unsigned long mem, max, log2qty, size;
+	unsigned long max, log2qty, size;
 	void *table;
 
-	/* round applicable memory size up to nearest megabyte */
-	mem = consider_highmem ? nr_all_pages : nr_kernel_pages;
-	mem += (1UL << (20 - PAGE_SHIFT)) - 1;
-	mem >>= 20 - PAGE_SHIFT;
-	mem <<= 20 - PAGE_SHIFT;
-
-	/* limit to 1 bucket per 2^scale bytes of low memory (rounded up to
-	 * nearest power of 2 in size) */
-	if (scale > PAGE_SHIFT)
-		mem >>= (scale - PAGE_SHIFT);
-	else
-		mem <<= (PAGE_SHIFT - scale);
-
-	mem = 1UL << (long_log2(mem) + 1);
+	/* allow the kernel cmdline to have a say */
+	if (!numentries) {
+		/* round applicable memory size up to nearest megabyte */
+		numentries = consider_highmem ? nr_all_pages : nr_kernel_pages;
+		numentries += (1UL << (20 - PAGE_SHIFT)) - 1;
+		numentries >>= 20 - PAGE_SHIFT;
+		numentries <<= 20 - PAGE_SHIFT;
 
-	/* limit allocation size */
-	max = (1UL << (PAGE_SHIFT + MAX_SYS_HASH_TABLE_ORDER)) / bucketsize;
-	if (max > mem)
-		max = mem;
+		/* limit to 1 bucket per 2^scale bytes of low memory */
+		if (scale > PAGE_SHIFT)
+			numentries >>= (scale - PAGE_SHIFT);
+		else
+			numentries <<= (PAGE_SHIFT - scale);
+	}
+	/* rounded up to nearest power of 2 in size */
+	numentries = 1UL << (long_log2(numentries) + 1);
+	
+	/* limit allocation size to 1/16 total memory */
+	max = ((nr_all_pages << PAGE_SHIFT)/16) / bucketsize;
 
-	/* allow the kernel cmdline to have a say */
-	if (!numentries || numentries > max)
+	if (numentries > max)
 		numentries = max;
 
 	log2qty = long_log2(numentries);

--FCuugMFkClbJLl1L--
