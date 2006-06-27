Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWF0Mtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWF0Mtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWF0Mtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:49:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932306AbWF0Mto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:49:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=H+SbwCvMkwgYwpGJI1w5U9X3BzYP/Qxm6BHNk/fAHBjQyBtCnBCfC8403ut+/RgAKve9DJLmDeBX1yNNquQyw84fM0oClFlB9S7w6CvHOZ1gibpnfNdpQXrTmk7ibBpA4qfULKBJMj0NrUtPMtBSgOqC5/lMwAKnCLY4l4iI8U0=
Message-ID: <44A12A75.8080601@innova-card.com>
Date: Tue, 27 Jun 2006 14:54:13 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] bootmem: limit to 80 columns width
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |   42 +++++++++++++++++++++++++++++-------------
 mm/bootmem.c            |   28 ++++++++++++++++++----------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 0e821ca..f55719b 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -44,18 +44,24 @@ typedef struct bootmem_data {
 extern unsigned long bootmem_bootmap_pages (unsigned long);
 extern unsigned long init_bootmem (unsigned long addr, unsigned long memend);
 extern void free_bootmem (unsigned long addr, unsigned long size);
-extern void * __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __alloc_bootmem (unsigned long size,
+			       unsigned long align,
+			       unsigned long goal);
+extern void * __alloc_bootmem_nopanic (unsigned long size,
+				       unsigned long align,
+				       unsigned long goal);
 extern void * __alloc_bootmem_low(unsigned long size,
-					 unsigned long align,
-					 unsigned long goal);
+				  unsigned long align,
+				  unsigned long goal);
 extern void * __alloc_bootmem_low_node(pg_data_t *pgdat,
-					      unsigned long size,
-					      unsigned long align,
-					      unsigned long goal);
+				       unsigned long size,
+				       unsigned long align,
+				       unsigned long goal);
 extern void * __alloc_bootmem_core(struct bootmem_data *bdata,
-		unsigned long size, unsigned long align, unsigned long goal,
-		unsigned long limit);
+				   unsigned long size,
+				   unsigned long align,
+				   unsigned long goal,
+				   unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
@@ -68,10 +74,20 @@ #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low(x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 extern unsigned long free_all_bootmem (void);
-extern void * __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
-extern unsigned long init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
-extern void reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
-extern void free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
+extern void * __alloc_bootmem_node (pg_data_t *pgdat,
+				    unsigned long size,
+				    unsigned long align,
+				    unsigned long goal);
+extern unsigned long init_bootmem_node (pg_data_t *pgdat,
+					unsigned long freepfn,
+					unsigned long startpfn,
+					unsigned long endpfn);
+extern void reserve_bootmem_node (pg_data_t *pgdat,
+				  unsigned long physaddr,
+				  unsigned long size);
+extern void free_bootmem_node (pg_data_t *pgdat,
+			       unsigned long addr,
+			       unsigned long size);
 extern unsigned long free_all_bootmem_node (pg_data_t *pgdat);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
diff --git a/mm/bootmem.c b/mm/bootmem.c
index d0a34fe..ac6a51c 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -104,7 +104,8 @@ static unsigned long __init init_bootmem
  * might be used for boot-time allocations - or it might get added
  * to the free page pool later on.
  */
-static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+					unsigned long size)
 {
 	unsigned long i;
 	/*
@@ -129,7 +130,8 @@ #endif
 		}
 }
 
-static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+				     unsigned long size)
 {
 	unsigned long i;
 	unsigned long start;
@@ -357,17 +359,20 @@ static unsigned long __init free_all_boo
 	return total;
 }
 
-unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn,
+				unsigned long startpfn, unsigned long endpfn)
 {
 	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
 }
 
-void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
+				  unsigned long size)
 {
 	reserve_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
+			       unsigned long size)
 {
 	free_bootmem_core(pgdat->bdata, physaddr, size);
 }
@@ -401,7 +406,8 @@ unsigned long __init free_all_bootmem (v
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
-void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
+				      unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
@@ -412,7 +418,8 @@ void * __init __alloc_bootmem_nopanic(un
 	return NULL;
 }
 
-void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem(unsigned long size, unsigned long align,
+			      unsigned long goal)
 {
 	void *mem = __alloc_bootmem_nopanic(size,align,goal);
 	if (mem)
@@ -426,8 +433,8 @@ void * __init __alloc_bootmem(unsigned l
 }
 
 
-void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size, unsigned long align,
-				   unsigned long goal)
+void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
+				   unsigned long align, unsigned long goal)
 {
 	void *ptr;
 
@@ -440,7 +447,8 @@ void * __init __alloc_bootmem_node(pg_da
 
 #define LOW32LIMIT 0xffffffff
 
-void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
+				  unsigned long goal)
 {
 	bootmem_data_t *bdata;
 	void *ptr;
-- 
1.4.0.g64e8


