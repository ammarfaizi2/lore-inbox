Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWDXVpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWDXVpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDXVpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:45:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22953 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751252AbWDXVpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:45:01 -0400
Date: Mon, 24 Apr 2006 16:44:29 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mulix@mulix.org, ak@suse.de
Subject: [PATCH] mm: add a nopanic option for low bootmem
Message-ID: <20060424214428.GA14575@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a no panic option for low bootmem allocs.  This will
allow for a more graceful handling of "out of memory" for those
callers who wish to handle it.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 307c5ac10c26 include/linux/bootmem.h
--- a/include/linux/bootmem.h	Sat Apr 22 12:21:45 2006
+++ b/include/linux/bootmem.h	Mon Apr 24 09:59:50 2006
@@ -46,6 +46,7 @@
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
 extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
 extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_low_nopanic(unsigned long size, unsigned long align, unsigned long goal);
 extern void * __init __alloc_bootmem_low(unsigned long size,
 					 unsigned long align,
 					 unsigned long goal);
diff -r 307c5ac10c26 mm/bootmem.c
--- a/mm/bootmem.c	Sat Apr 22 12:21:45 2006
+++ b/mm/bootmem.c	Mon Apr 24 09:59:50 2006
@@ -463,3 +463,16 @@
 {
 	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
 }
+
+void * __init __alloc_bootmem_low_nopanic(unsigned long size, 
+					unsigned long align, unsigned long goal)
+{
+	bootmem_data_t *bdata;
+	void *ptr;
+
+	list_for_each_entry(bdata, &bdata_list, list)
+		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 
+						LOW32LIMIT)))
+			return(ptr);
+	return NULL;
+}
