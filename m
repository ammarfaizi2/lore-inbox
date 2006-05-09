Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWEJAAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWEJAAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEJAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:00:54 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:46002 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932289AbWEJAAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:00:53 -0400
Date: Tue, 9 May 2006 18:59:46 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       mulix@mulix.org
Subject: [PATCH 3/5] mm: create __alloc_bootmem_low_nopanic
Message-ID: <20060509235946.GG22385@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Andi Kleen's suggestion in the review of our Calgary IOMMU code, I
tried to use the alloc_bootmem_nopanic when allocing bootmem.
Unfortunately, it needs low mem for our translation tables, so we needed
a new function to do this.

I have updated swiotlb to take advantage of this new function in the
patch following this one.

This patch has been tested individually and cumulatively on x86_64 and
cross-compile tested on IA64.  Since I have no IA64 hardware, any
testing on that platform would be appreciated.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 235bc05ff8b1 -r 9459ba92585b include/linux/bootmem.h
--- a/include/linux/bootmem.h	Mon May  8 16:17:49 2006
+++ b/include/linux/bootmem.h	Mon May  8 16:30:29 2006
@@ -54,6 +54,9 @@
 extern void * __init __alloc_bootmem_low(unsigned long size,
 					 unsigned long align,
 					 unsigned long goal);
+extern void * __init __alloc_bootmem_low_nopanic(unsigned long size,
+						 unsigned long align,
+						 unsigned long goal);
 extern void * __init __alloc_bootmem_low_node(pg_data_t *pgdat,
 					      unsigned long size,
 					      unsigned long align,
diff -r 235bc05ff8b1 -r 9459ba92585b mm/bootmem.c
--- a/mm/bootmem.c	Mon May  8 16:17:49 2006
+++ b/mm/bootmem.c	Mon May  8 16:30:29 2006
@@ -473,3 +473,16 @@
 {
 	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
 }
+
+void * __init __alloc_bootmem_low_nopanic(unsigned long size,
+		unsigned long align, unsigned long goal)
+{
+	bootmem_data_t *bdata;
+	void *ptr;
+
+	list_for_each_entry(bdata, &bdata_list, list)
+		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal,
+						LOW32LIMIT)))
+			return ptr;
+	return NULL;
+}
