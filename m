Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUHVEsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUHVEsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUHVEsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:48:32 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:43636 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266126AbUHVEsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:48:03 -0400
Message-ID: <412824BE.4040801@yahoo.com.au>
Date: Sun, 22 Aug 2004 14:44:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fix PID hash sizing
Content-Type: multipart/mixed;
 boundary="------------000406080607020600090105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000406080607020600090105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I see PID hash sizing problems on an Opteron.
I thought this got fixed a while ago? Hm.


--------------000406080607020600090105
Content-Type: text/x-patch;
 name="pid-hash-alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pid-hash-alloc.patch"



Export nr_kernel_pages, nr_all_pages. Use nr_kernel_pages when sizing
the PID hash. This fixes a sizing problem I'm seeing with the x86-64 kernel
on an Opteron.


---

 linux-2.6-npiggin/include/linux/bootmem.h |    3 +++
 linux-2.6-npiggin/kernel/pid.c            |    2 +-
 linux-2.6-npiggin/mm/page_alloc.c         |    4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff -puN kernel/pid.c~pid-hash-alloc kernel/pid.c
--- linux-2.6/kernel/pid.c~pid-hash-alloc	2004-08-22 14:28:46.000000000 +1000
+++ linux-2.6-npiggin/kernel/pid.c	2004-08-22 14:34:13.000000000 +1000
@@ -276,7 +276,7 @@ int kgdb_pid_init_done; /* so we don't c
 void __init pidhash_init(void)
 {
 	int i, j, pidhash_size;
-	unsigned long megabytes = max_pfn >> (20 - PAGE_SHIFT);
+	unsigned long megabytes = nr_kernel_pages >> (20 - PAGE_SHIFT);
 
 	pidhash_shift = max(4, fls(megabytes * 4));
 	pidhash_shift = min(12, pidhash_shift);
diff -puN include/linux/bootmem.h~pid-hash-alloc include/linux/bootmem.h
--- linux-2.6/include/linux/bootmem.h~pid-hash-alloc	2004-08-22 14:28:46.000000000 +1000
+++ linux-2.6-npiggin/include/linux/bootmem.h	2004-08-22 14:28:46.000000000 +1000
@@ -67,6 +67,9 @@ extern void * __init __alloc_bootmem_nod
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
+extern unsigned long __initdata nr_kernel_pages;
+extern unsigned long __initdata nr_all_pages;
+
 extern void *__init alloc_large_system_hash(const char *tablename,
 					    unsigned long bucketsize,
 					    unsigned long numentries,
diff -puN mm/page_alloc.c~pid-hash-alloc mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~pid-hash-alloc	2004-08-22 14:29:02.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-08-22 13:41:11.000000000 +1000
@@ -55,8 +55,8 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
-static unsigned long __initdata nr_kernel_pages;
-static unsigned long __initdata nr_all_pages;
+unsigned long __initdata nr_kernel_pages;
+unsigned long __initdata nr_all_pages;
 
 /*
  * Temporary debugging check for pages not lying within a given zone.

_

--------------000406080607020600090105--
