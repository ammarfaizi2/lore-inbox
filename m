Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275479AbTHJJCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275484AbTHJJCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:02:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:11276 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S275479AbTHJJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:02:36 -0400
Date: Sun, 10 Aug 2003 18:02:41 +0900 (JST)
Message-Id: <20030810.180241.71795022.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810013041.679ddc4c.davem@redhat.com>
References: <20030810081529.GX31810@waste.org>
	<20030810.173215.102258218.yoshfuji@linux-ipv6.org>
	<20030810013041.679ddc4c.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030810013041.679ddc4c.davem@redhat.com> (at Sun, 10 Aug 2003 01:30:41 -0700), "David S. Miller" <davem@redhat.com> says:

> > BTW, we spread ((long) ptr & ~PAGE_MASK); it seems ugly.
> > Why don't we have vert_to_offset(ptr) or something like this?
> > #define virt_to_offset(ptr) ((unsigned long) (ptr) & ~PAGE_MASK)
> > Is this bad idea?
> 
> With some name like "virt_to_pageoff()" it sounds like a great
> idea.

Okay.  How about this?
(I'm going to do the actual conversion soon.)

Index: linux-2.6/include/asm-alpha/mmzone.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-alpha/mmzone.h,v
retrieving revision 1.9
diff -u -r1.9 mmzone.h
--- linux-2.6/include/asm-alpha/mmzone.h	3 Jul 2003 05:47:43 -0000	1.9
+++ linux-2.6/include/asm-alpha/mmzone.h	10 Aug 2003 07:30:53 -0000
@@ -77,6 +77,7 @@
 	     NODE_DATA(kvaddr_to_nid(kaddr))->valid_addr_bitmap)
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
 
Index: linux-2.6/include/asm-alpha/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-alpha/page.h,v
retrieving revision 1.12
diff -u -r1.12 page.h
--- linux-2.6/include/asm-alpha/page.h	13 Jan 2003 23:24:04 -0000	1.12
+++ linux-2.6/include/asm-alpha/page.h	10 Aug 2003 07:30:53 -0000
@@ -90,6 +90,7 @@
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-arm26/memory.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-arm26/memory.h,v
retrieving revision 1.2
diff -u -r1.2 memory.h
--- linux-2.6/include/asm-arm26/memory.h	8 Jun 2003 16:21:42 -0000	1.2
+++ linux-2.6/include/asm-arm26/memory.h	10 Aug 2003 07:30:53 -0000
@@ -86,6 +86,7 @@
 #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
 
 #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define virt_addr_valid(kaddr)	((int)(kaddr) >= PAGE_OFFSET && (int)(kaddr) < (unsigned long)high_memory)
 
 /*
Index: linux-2.6/include/asm-cris/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-cris/page.h,v
retrieving revision 1.7
diff -u -r1.7 page.h
--- linux-2.6/include/asm-cris/page.h	10 Jul 2003 17:33:07 -0000	1.7
+++ linux-2.6/include/asm-cris/page.h	10 Aug 2003 07:30:53 -0000
@@ -50,6 +50,7 @@
  */ 
 
 #define virt_to_page(kaddr)    (mem_map + (((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define VALID_PAGE(page)       (((page) - mem_map) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid((kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6/include/asm-h8300/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-h8300/page.h,v
retrieving revision 1.2
diff -u -r1.2 page.h
--- linux-2.6/include/asm-h8300/page.h	17 Apr 2003 23:27:57 -0000	1.2
+++ linux-2.6/include/asm-h8300/page.h	10 Aug 2003 07:30:53 -0000
@@ -84,7 +84,7 @@
 
 #define MAP_NR(addr)		(((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT)
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
-#define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
Index: linux-2.6/include/asm-i386/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/page.h,v
retrieving revision 1.25
diff -u -r1.25 page.h
--- linux-2.6/include/asm-i386/page.h	31 Mar 2003 22:29:20 -0000	1.25
+++ linux-2.6/include/asm-i386/page.h	10 Aug 2003 07:30:53 -0000
@@ -133,6 +133,7 @@
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* !CONFIG_DISCONTIGMEM */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6/include/asm-ia64/mmzone.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ia64/mmzone.h,v
retrieving revision 1.5
diff -u -r1.5 mmzone.h
--- linux-2.6/include/asm-ia64/mmzone.h	6 Mar 2003 21:34:32 -0000	1.5
+++ linux-2.6/include/asm-ia64/mmzone.h	10 Aug 2003 07:30:53 -0000
@@ -63,6 +63,7 @@
 				(VALID_MEM_KADDR(_kvtp))	\
 					? BANK_MEM_MAP_BASE(_kvtp) + BANK_MAP_NR(_kvtp)	\
 					: NULL;})
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 /*
  * Given a page struct entry, return the physical address that the page struct represents.
Index: linux-2.6/include/asm-ia64/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ia64/page.h,v
retrieving revision 1.18
diff -u -r1.18 page.h
--- linux-2.6/include/asm-ia64/page.h	21 Jun 2003 16:19:17 -0000	1.18
+++ linux-2.6/include/asm-ia64/page.h	10 Aug 2003 07:30:53 -0000
@@ -101,6 +101,7 @@
 #  define pfn_valid(pfn)	((pfn) < max_mapnr)
 # endif
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define page_to_pfn(page)	((unsigned long) (page - mem_map))
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
Index: linux-2.6/include/asm-m68k/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-m68k/page.h,v
retrieving revision 1.11
diff -u -r1.11 page.h
--- linux-2.6/include/asm-m68k/page.h	13 Apr 2003 09:55:02 -0000	1.11
+++ linux-2.6/include/asm-m68k/page.h	10 Aug 2003 07:30:53 -0000
@@ -179,6 +179,7 @@
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
 
 #define virt_to_page(kaddr)	(mem_map + (((unsigned long)(kaddr)-PAGE_OFFSET) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
 #define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
Index: linux-2.6/include/asm-m68knommu/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-m68knommu/page.h,v
retrieving revision 1.4
diff -u -r1.4 page.h
--- linux-2.6/include/asm-m68knommu/page.h	7 Jul 2003 00:20:14 -0000	1.4
+++ linux-2.6/include/asm-m68knommu/page.h	10 Aug 2003 07:30:53 -0000
@@ -85,6 +85,7 @@
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
 
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
Index: linux-2.6/include/asm-mips/mmzone.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-mips/mmzone.h,v
retrieving revision 1.2
diff -u -r1.2 mmzone.h
--- linux-2.6/include/asm-mips/mmzone.h	1 Aug 2003 05:40:55 -0000	1.2
+++ linux-2.6/include/asm-mips/mmzone.h	10 Aug 2003 07:30:54 -0000
@@ -84,6 +84,7 @@
 	((((page)-(page)->zone->zone_mem_map) + (page)->zone->zone_start_pfn) \
 	 << PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(MIPS64_NR(kaddr))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-mips/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-mips/page.h,v
retrieving revision 1.7
diff -u -r1.7 page.h
--- linux-2.6/include/asm-mips/page.h	1 Aug 2003 05:40:55 -0000	1.7
+++ linux-2.6/include/asm-mips/page.h	10 Aug 2003 07:30:54 -0000
@@ -115,6 +115,7 @@
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-parisc/mmzone.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-parisc/mmzone.h,v
retrieving revision 1.2
diff -u -r1.2 mmzone.h
--- linux-2.6/include/asm-parisc/mmzone.h	30 Oct 2002 23:00:20 -0000	1.2
+++ linux-2.6/include/asm-parisc/mmzone.h	10 Aug 2003 07:30:54 -0000
@@ -24,6 +24,7 @@
 	+ ((paddr) >> PAGE_SHIFT))
 
 #define virt_to_page(kvaddr) phys_to_page(__pa(kvaddr))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 /* This is kind of bogus, need to investigate performance of doing it right */
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
Index: linux-2.6/include/asm-parisc/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-parisc/page.h,v
retrieving revision 1.5
diff -u -r1.5 page.h
--- linux-2.6/include/asm-parisc/page.h	13 Jan 2003 23:24:04 -0000	1.5
+++ linux-2.6/include/asm-parisc/page.h	10 Aug 2003 07:30:54 -0000
@@ -106,6 +106,7 @@
 
 #ifndef CONFIG_DISCONTIGMEM
 #define virt_to_page(kaddr)     (mem_map + (__pa(kaddr) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 #endif  /* !CONFIG_DISCONTIGMEM */
 
Index: linux-2.6/include/asm-ppc/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ppc/page.h,v
retrieving revision 1.14
diff -u -r1.14 page.h
--- linux-2.6/include/asm-ppc/page.h	26 Feb 2003 03:12:12 -0000	1.14
+++ linux-2.6/include/asm-ppc/page.h	10 Aug 2003 07:30:54 -0000
@@ -123,6 +123,7 @@
 #define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		(((pfn) - PPC_PGSTART) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-ppc64/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-ppc64/page.h,v
retrieving revision 1.14
diff -u -r1.14 page.h
--- linux-2.6/include/asm-ppc64/page.h	5 May 2003 00:57:02 -0000	1.14
+++ linux-2.6/include/asm-ppc64/page.h	10 Aug 2003 07:30:54 -0000
@@ -198,6 +198,7 @@
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6/include/asm-s390/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-s390/page.h,v
retrieving revision 1.10
diff -u -r1.10 page.h
--- linux-2.6/include/asm-s390/page.h	14 Apr 2003 18:27:30 -0000	1.10
+++ linux-2.6/include/asm-s390/page.h	10 Aug 2003 07:30:54 -0000
@@ -174,6 +174,7 @@
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-sh/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sh/page.h,v
retrieving revision 1.5
diff -u -r1.5 page.h
--- linux-2.6/include/asm-sh/page.h	2 Jul 2003 05:34:18 -0000	1.5
+++ linux-2.6/include/asm-sh/page.h	10 Aug 2003 07:30:54 -0000
@@ -94,6 +94,7 @@
 #define pfn_to_page(pfn)	(mem_map + (pfn) - PFN_START)
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PFN_START)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6/include/asm-sparc/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sparc/page.h,v
retrieving revision 1.10
diff -u -r1.10 page.h
--- linux-2.6/include/asm-sparc/page.h	3 May 2003 17:28:36 -0000	1.10
+++ linux-2.6/include/asm-sparc/page.h	10 Aug 2003 07:30:54 -0000
@@ -165,6 +165,7 @@
 #define pfn_to_page(pfn)        (mem_map + (pfn))
 #define page_to_pfn(page)       ((unsigned long)((page) - mem_map))
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6/include/asm-sparc64/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-sparc64/page.h,v
retrieving revision 1.13
diff -u -r1.13 page.h
--- linux-2.6/include/asm-sparc64/page.h	13 Jan 2003 23:24:04 -0000	1.13
+++ linux-2.6/include/asm-sparc64/page.h	10 Aug 2003 07:30:54 -0000
@@ -123,6 +123,7 @@
 #define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
 #define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr)>>PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 #define pfn_valid(pfn)		(((pfn)-(pfn_base)) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
Index: linux-2.6/include/asm-um/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-um/page.h,v
retrieving revision 1.5
diff -u -r1.5 page.h
--- linux-2.6/include/asm-um/page.h	6 Feb 2003 04:13:38 -0000	1.5
+++ linux-2.6/include/asm-um/page.h	10 Aug 2003 07:30:54 -0000
@@ -36,6 +36,7 @@
 extern struct page *phys_to_page(unsigned long phys);
 
 #define virt_to_page(v) (phys_to_page(__pa(v)))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 
 extern struct page *page_mem_map(struct page *page);
 
Index: linux-2.6/include/asm-v850/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-v850/page.h,v
retrieving revision 1.4
diff -u -r1.4 page.h
--- linux-2.6/include/asm-v850/page.h	13 Apr 2003 09:55:02 -0000	1.4
+++ linux-2.6/include/asm-v850/page.h	10 Aug 2003 07:30:54 -0000
@@ -127,6 +127,7 @@
 #define MAP_NR(kaddr) \
   (((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	(mem_map + MAP_NR (kaddr))
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define page_to_virt(page) \
   ((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
Index: linux-2.6/include/asm-x86_64/page.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-x86_64/page.h,v
retrieving revision 1.12
diff -u -r1.12 page.h
--- linux-2.6/include/asm-x86_64/page.h	21 Jun 2003 16:18:33 -0000	1.12
+++ linux-2.6/include/asm-x86_64/page.h	10 Aug 2003 07:30:54 -0000
@@ -122,6 +122,7 @@
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_pageoff(kaddr)	((unsigned long)(kaddr) & ~PAGE_MASK)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
