Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266921AbUGLR5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUGLR5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266911AbUGLR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:57:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63694 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266913AbUGLR4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:56:37 -0400
Date: Mon, 12 Jul 2004 12:56:05 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: dhowells@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       slprat@us.ibm.com
Subject: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040712175605.GA1735@rx8.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I was looking at your patch for >MAX_ORDER hash tables but it seems that
the patch limits the number of entries to what it thinks are good values
and the i/dhash_entries cmdline options can not exceed this.  Any reason
for this?  This seems to limit the usability of the patch on systems were 
larger allocations that the ones the kernel calculates are desired.

Also, any particular reason why MAX_SYS_HASH_TABLE_ORDER was set to 14?
I am already seeing the need to go higher on my 64GB setup and was 
wondering if this could be bumped up to 19.

I'm sending a patch that get the cmdline options working as the did before
where the could override the kernel calculations and increases 
MAX_SYS_HASH_TABLE_ORDER to 19.  Only tested on PPC64 at the moment.

Andrew - Could you consider this for inclusion into mainline?

Thanks,

-JRS

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1676  -> 1.1677 
#	     mm/page_alloc.c	1.200   -> 1.201  
#	include/linux/mmzone.h	1.58    -> 1.59   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/07/12	jsantos@rx8.austin.ibm.com	1.1677
# - Make ihash_entries and dhash_entries cmdline options behave like they use to.
# - Change MAX_SYS_HASH_TABLE_ORDER to allow very large hashes on very LARGE memory systems.
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Mon Jul 12 12:53:29 2004
+++ b/include/linux/mmzone.h	Mon Jul 12 12:53:29 2004
@@ -26,10 +26,10 @@
  *   permitted by MAX_ORDER, so we allocate with the bootmem allocator, and are
  *   limited to this size
  */
-#if MAX_ORDER > 14
+#if MAX_ORDER > 19
 #define MAX_SYS_HASH_TABLE_ORDER MAX_ORDER
 #else
-#define MAX_SYS_HASH_TABLE_ORDER 14
+#define MAX_SYS_HASH_TABLE_ORDER 19
 #endif
 
 struct free_area {
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Mon Jul 12 12:53:29 2004
+++ b/mm/page_alloc.c	Mon Jul 12 12:53:29 2004
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
 
+		/* limit to 1 bucket per 2^scale bytes of low memory */
+		if (scale > PAGE_SHIFT)
+			numentries >>= (scale - PAGE_SHIFT);
+		else
+			numentries <<= (PAGE_SHIFT - scale);
+	}
+	/* rounded up to nearest power of 2 in size) */
+	numentries = 1UL << (long_log2(numentries) + 1);
+	
 	/* limit allocation size */
 	max = (1UL << (PAGE_SHIFT + MAX_SYS_HASH_TABLE_ORDER)) / bucketsize;
-	if (max > mem)
-		max = mem;
 
-	/* allow the kernel cmdline to have a say */
-	if (!numentries || numentries > max)
+	if (numentries > max)
 		numentries = max;
 
 	log2qty = long_log2(numentries);



