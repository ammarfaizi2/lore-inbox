Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSIOF7M>; Sun, 15 Sep 2002 01:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSIOF7M>; Sun, 15 Sep 2002 01:59:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6534 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317855AbSIOF7L>;
	Sun, 15 Sep 2002 01:59:11 -0400
Message-ID: <3D8422BB.5070104@us.ibm.com>
Date: Sat, 14 Sep 2002 23:03:39 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: [PATCH] add vmalloc stats to meminfo
Content-Type: multipart/mixed;
 boundary="------------090600040808040105060604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090600040808040105060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some workloads like to eat up a lot of vmalloc space.  It is often hard to tell
whether this is because the area is too small, or just too fragmented.  This 
makes it easy to determine.

-- 
Dave Hansen
haveblue@us.ibm.com


--------------090600040808040105060604
Content-Type: text/plain;
 name="vmalloc-stats-2.5.34-mm4-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmalloc-stats-2.5.34-mm4-2.patch"

diff -ur linux-2.5.34-mm4/fs/proc/proc_misc.c linux-2.5.34-mm4-vmalloc-stats/fs/proc/proc_misc.c
--- linux-2.5.34-mm4/fs/proc/proc_misc.c	Sat Sep 14 21:23:54 2002
+++ linux-2.5.34-mm4-vmalloc-stats/fs/proc/proc_misc.c	Sat Sep 14 22:38:12 2002
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -128,6 +129,40 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+struct vmalloc_info {
+	unsigned long used;
+	unsigned long largest_chunk;
+};
+
+static struct vmalloc_info get_vmalloc_info(void)
+{
+	unsigned long prev_end = VMALLOC_START;
+	struct vm_struct* vma;
+	struct vmalloc_info vmi;
+	vmi.used = 0;
+
+	read_lock(&vmlist_lock);
+	
+	if(!vmlist) 
+		vmi.largest_chunk = (VMALLOC_END-VMALLOC_START);
+	else 
+		vmi.largest_chunk = 0;
+	
+	for (vma = vmlist; vma; vma = vma->next) {
+		unsigned long free_area_size = 
+			(unsigned long)vma->addr - prev_end;
+		vmi.used += vma->size;
+		if (vmi.largest_chunk < free_area_size ) 
+			vmi.largest_chunk = free_area_size;
+		prev_end = vma->size + (unsigned long)vma->addr;
+	}
+	if(VMALLOC_END-prev_end > vmi.largest_chunk)
+		vmi.largest_chunk = VMALLOC_END-prev_end;
+	
+	read_unlock(&vmlist_lock);
+	return vmi;
+}
+
 extern atomic_t vm_committed_space;
 
 static int meminfo_read_proc(char *page, char **start, off_t off,
@@ -138,6 +173,8 @@
 	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
+	unsigned long vmtot;
+	struct vmalloc_info vmi;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive);
@@ -150,6 +187,11 @@
 	si_swapinfo(&i);
 	committed = atomic_read(&vm_committed_space);
 
+	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
+	vmi = get_vmalloc_info();
+	vmi.used >>= 10;
+	vmi.largest_chunk >>= 10;
+
 	/*
 	 * Tagged format, for easy grepping and expansion.
 	 */
@@ -174,7 +216,10 @@
 		"Slab:         %8lu kB\n"
 		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
-		"ReverseMaps:  %8lu\n",
+		"ReverseMaps:  %8lu\n"
+		"VmalTotal:    %8lu kB\n"
+		"VmalUsed:     %8lu kB\n"
+		"VmalChunk:    %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -195,7 +240,10 @@
 		K(ps.nr_slab),
 		K(committed),
 		K(ps.nr_page_table_pages),
-		ps.nr_reverse_maps
+		ps.nr_reverse_maps,
+		vmtot,
+		vmi.used,
+		vmi.largest_chunk
 		);
 
 #ifdef CONFIG_HUGETLB_PAGE


--------------090600040808040105060604--

