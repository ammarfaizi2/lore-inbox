Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVDHSuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVDHSuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVDHSuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:50:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:38628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262922AbVDHStz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:49:55 -0400
Date: Fri, 8 Apr 2005 11:50:29 -0700
From: Nick Wilson <njw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: [PATCH] Use ALIGN to remove duplicate code
Message-ID: <20050408185029.GA6961@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net> <20050407175042.43c02ae9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407175042.43c02ae9.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:50:42PM -0700, Andrew Morton wrote:
> Nick Wilson <njw@osdl.org> wrote:
> > The first patch adds a generic round_up_pow2() macro to kernel.h. The
> >  remaining patches modify a few files to make use of the new macro.
> 
> We already have ALIGN() and roundup_pow_of_two().

Andrew,

This patch makes use of ALIGN() to remove duplicate round-up code.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 include/linux/a.out.h |    2 +-
 kernel/resource.c     |    2 +-
 lib/bitmap.c          |    3 +--
 mm/bootmem.c          |    6 +++---
 4 files changed, 6 insertions(+), 7 deletions(-)

Index: linux/include/linux/a.out.h
===================================================================
--- linux.orig/include/linux/a.out.h	2005-04-08 10:59:14.000000000 -0700
+++ linux/include/linux/a.out.h	2005-04-08 11:00:40.000000000 -0700
@@ -138,7 +138,7 @@ enum machine_type {
 #endif
 #endif
 
-#define _N_SEGMENT_ROUND(x) (((x) + SEGMENT_SIZE - 1) & ~(SEGMENT_SIZE - 1))
+#define _N_SEGMENT_ROUND(x) ALIGN(x, SEGMENT_SIZE)
 
 #define _N_TXTENDADDR(x) (N_TXTADDR(x)+(x).a_text)
 
Index: linux/kernel/resource.c
===================================================================
--- linux.orig/kernel/resource.c	2005-04-08 10:59:36.000000000 -0700
+++ linux/kernel/resource.c	2005-04-08 11:00:50.000000000 -0700
@@ -263,7 +263,7 @@ static int find_resource(struct resource
 			new->start = min;
 		if (new->end > max)
 			new->end = max;
-		new->start = (new->start + align - 1) & ~(align - 1);
+		new->start = ALIGN(new->start, align);
 		if (alignf)
 			alignf(alignf_data, new, size, align);
 		if (new->start < new->end && new->end - new->start + 1 >= size) {
Index: linux/lib/bitmap.c
===================================================================
--- linux.orig/lib/bitmap.c	2005-04-08 10:59:40.000000000 -0700
+++ linux/lib/bitmap.c	2005-04-08 11:00:59.000000000 -0700
@@ -289,7 +289,6 @@ EXPORT_SYMBOL(__bitmap_weight);
 
 #define CHUNKSZ				32
 #define nbits_to_hold_value(val)	fls(val)
-#define roundup_power2(val,modulus)	(((val) + (modulus) - 1) & ~((modulus) - 1))
 #define unhex(c)			(isdigit(c) ? (c - '0') : (toupper(c) - 'A' + 10))
 #define BASEDEC 10		/* fancier cpuset lists input in decimal */
 
@@ -316,7 +315,7 @@ int bitmap_scnprintf(char *buf, unsigned
 	if (chunksz == 0)
 		chunksz = CHUNKSZ;
 
-	i = roundup_power2(nmaskbits, CHUNKSZ) - CHUNKSZ;
+	i = ALIGN(nmaskbits, CHUNKSZ) - CHUNKSZ;
 	for (; i >= 0; i -= CHUNKSZ) {
 		chunkmask = ((1ULL << chunksz) - 1);
 		word = i / BITS_PER_LONG;
Index: linux/mm/bootmem.c
===================================================================
--- linux.orig/mm/bootmem.c	2005-04-08 10:59:43.000000000 -0700
+++ linux/mm/bootmem.c	2005-04-08 11:05:45.000000000 -0700
@@ -57,7 +57,7 @@ static unsigned long __init init_bootmem
 	pgdat->pgdat_next = pgdat_list;
 	pgdat_list = pgdat;
 
-	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
+	mapsize = ALIGN(mapsize, sizeof(long));
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
 	bdata->node_boot_start = (start << PAGE_SHIFT);
 	bdata->node_low_pfn = end;
@@ -178,7 +178,7 @@ __alloc_bootmem_core(struct bootmem_data
 	} else
 		preferred = 0;
 
-	preferred = ((preferred + align - 1) & ~(align - 1)) >> PAGE_SHIFT;
+	preferred = ALIGN(preferred, align) >> PAGE_SHIFT;
 	preferred += offset;
 	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
@@ -219,7 +219,7 @@ found:
 	 */
 	if (align < PAGE_SIZE &&
 	    bdata->last_offset && bdata->last_pos+1 == start) {
-		offset = (bdata->last_offset+align-1) & ~(align-1);
+		offset = ALIGN(bdata->last_offset, align);
 		BUG_ON(offset > PAGE_SIZE);
 		remaining_size = PAGE_SIZE-offset;
 		if (size < remaining_size) {
_
