Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUDHHJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUDHHJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:09:47 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:46329 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261992AbUDHHJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:09:40 -0400
Subject: Rename bitmap_clear to bitmap_zero, remove CLEAR_BITMAP
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1081408152.10944.339.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 17:09:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, was looking through cpumask_t usage, and this confused me.
Useless churn?  Maybe.

Name: Rename bitmap_clear to bitmap_zero, remove CLEAR_BITMAP
Status: Trivial

clear_bit(n, addr) clears the nth bit.
test_and_clear_bit(n, addr) clears the nth bit.
cpu_clear(n, cpumask) clears the nth bit (vs. cpus_clear()).
bitmap_clear(bitmap, n) clears out all the bits up to n.

Moreover, there's a CLEAR_BITMAP() in linux/types.h which
bitmap_clear() is a wrapper for.

Rename bitmap_clear to bitmap_zero, which is harder to confuse (yes,
it bit me), and make everyone use it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/arch/ia64/sn/kernel/sn2/sn2_smp.c .5891-linux-2.6.5.updated/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- .5891-linux-2.6.5/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-02-18 23:54:12.000000000 +1100
+++ .5891-linux-2.6.5.updated/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-04-08 16:49:15.000000000 +1000
@@ -91,7 +91,7 @@ sn2_global_tlb_purge (unsigned long star
 	short			nasids[NR_NODES], nix;
 	DECLARE_BITMAP(nodes_flushed, NR_NODES);
 
-	CLEAR_BITMAP(nodes_flushed, NR_NODES);
+	bitmap_zero(nodes_flushed, NR_NODES);
 
 	i = 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/drivers/atm/lanai.c .5891-linux-2.6.5.updated/drivers/atm/lanai.c
--- .5891-linux-2.6.5/drivers/atm/lanai.c	2003-10-23 10:02:46.000000000 +1000
+++ .5891-linux-2.6.5.updated/drivers/atm/lanai.c	2004-04-08 16:49:01.000000000 +1000
@@ -1743,7 +1743,7 @@ static void run_service(struct lanai_dev
 		read_lock(&vcc_sklist_lock);
 		vci_bitfield_iterate(lanai, lanai->transmit_ready,
 		    iter_transmit);
-		CLEAR_BITMAP(&lanai->transmit_ready, NUM_VCI);
+		bitmap_zero(&lanai->transmit_ready, NUM_VCI);
 		read_unlock(&vcc_sklist_lock);
 	}
 }
@@ -2158,8 +2158,8 @@ static int __init lanai_dev_open(struct 
 	/* Basic device fields */
 	lanai->number = atmdev->number;
 	lanai->num_vci = NUM_VCI;
-	CLEAR_BITMAP(&lanai->backlog_vccs, NUM_VCI);
-	CLEAR_BITMAP(&lanai->transmit_ready, NUM_VCI);
+	bitmap_zero(&lanai->backlog_vccs, NUM_VCI);
+	bitmap_zero(&lanai->transmit_ready, NUM_VCI);
 	lanai->naal0 = 0;
 #ifdef USE_POWERDOWN
 	lanai->nbound = 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/drivers/ieee1394/ieee1394_types.h .5891-linux-2.6.5.updated/drivers/ieee1394/ieee1394_types.h
--- .5891-linux-2.6.5/drivers/ieee1394/ieee1394_types.h	2003-11-28 12:27:23.000000000 +1100
+++ .5891-linux-2.6.5.updated/drivers/ieee1394/ieee1394_types.h	2004-04-08 16:49:08.000000000 +1000
@@ -24,7 +24,7 @@ struct hpsb_tlabel_pool {
 
 #define HPSB_TPOOL_INIT(_tp)			\
 do {						\
-	CLEAR_BITMAP((_tp)->pool, 64);		\
+	bitmap_zero((_tp)->pool, 64);		\
 	spin_lock_init(&(_tp)->lock);		\
 	(_tp)->next = 0;			\
 	(_tp)->allocations = 0;			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/drivers/scsi/atari_NCR5380.c .5891-linux-2.6.5.updated/drivers/scsi/atari_NCR5380.c
--- .5891-linux-2.6.5/drivers/scsi/atari_NCR5380.c	2003-09-22 10:27:33.000000000 +1000
+++ .5891-linux-2.6.5.updated/drivers/scsi/atari_NCR5380.c	2004-04-08 16:48:46.000000000 +1000
@@ -329,7 +329,7 @@ static void __init init_tags( void )
     for( target = 0; target < 8; ++target ) {
 	for( lun = 0; lun < 8; ++lun ) {
 	    ta = &TagAlloc[target][lun];
-	    CLEAR_BITMAP( ta->allocated, MAX_TAGS );
+	    bitmap_zero(ta->allocated, MAX_TAGS);
 	    ta->nr_allocated = 0;
 	    /* At the beginning, assume the maximum queue size we could
 	     * support (MAX_TAGS). This value will be decreased if the target
@@ -438,7 +438,7 @@ static void free_all_tags( void )
     for( target = 0; target < 8; ++target ) {
 	for( lun = 0; lun < 8; ++lun ) {
 	    ta = &TagAlloc[target][lun];
-	    CLEAR_BITMAP( ta->allocated, MAX_TAGS );
+	    bitmap_zero(ta->allocated, MAX_TAGS);
 	    ta->nr_allocated = 0;
 	}
     }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/include/asm-generic/cpumask_array.h .5891-linux-2.6.5.updated/include/asm-generic/cpumask_array.h
--- .5891-linux-2.6.5/include/asm-generic/cpumask_array.h	2004-01-10 13:59:33.000000000 +1100
+++ .5891-linux-2.6.5.updated/include/asm-generic/cpumask_array.h	2004-04-08 16:51:29.000000000 +1000
@@ -16,7 +16,7 @@
 
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
-#define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
+#define cpus_clear(map)		bitmap_zero((map).mask, NR_CPUS)
 #define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
 #define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
 #define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/include/asm-i386/mpspec.h .5891-linux-2.6.5.updated/include/asm-i386/mpspec.h
--- .5891-linux-2.6.5/include/asm-i386/mpspec.h	2004-04-05 09:04:44.000000000 +1000
+++ .5891-linux-2.6.5.updated/include/asm-i386/mpspec.h	2004-04-08 16:51:40.000000000 +1000
@@ -52,7 +52,7 @@ typedef struct physid_mask physid_mask_t
 
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
-#define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
+#define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
 #define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/include/asm-x86_64/mpspec.h .5891-linux-2.6.5.updated/include/asm-x86_64/mpspec.h
--- .5891-linux-2.6.5/include/asm-x86_64/mpspec.h	2004-04-05 09:04:46.000000000 +1000
+++ .5891-linux-2.6.5.updated/include/asm-x86_64/mpspec.h	2004-04-08 16:51:45.000000000 +1000
@@ -211,7 +211,7 @@ typedef struct physid_mask physid_mask_t
 
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
-#define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
+#define physids_clear(map)			bitmap_zero((map).mask, MAX_APICS)
 #define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/include/linux/bitmap.h .5891-linux-2.6.5.updated/include/linux/bitmap.h
--- .5891-linux-2.6.5/include/linux/bitmap.h	2004-03-12 07:57:24.000000000 +1100
+++ .5891-linux-2.6.5.updated/include/linux/bitmap.h	2004-04-08 16:46:38.000000000 +1000
@@ -16,9 +16,9 @@ int bitmap_equal(const unsigned long *bi
 			unsigned long *bitmap2, int bits);
 void bitmap_complement(unsigned long *bitmap, int bits);
 
-static inline void bitmap_clear(unsigned long *bitmap, int bits)
+static inline void bitmap_zero(unsigned long *bitmap, int bits)
 {
-	CLEAR_BITMAP((unsigned long *)bitmap, bits);
+	memset(bitmap, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
 }
 
 static inline void bitmap_fill(unsigned long *bitmap, int bits)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/include/linux/types.h .5891-linux-2.6.5.updated/include/linux/types.h
--- .5891-linux-2.6.5/include/linux/types.h	2003-09-29 10:26:05.000000000 +1000
+++ .5891-linux-2.6.5.updated/include/linux/types.h	2004-04-08 16:46:23.000000000 +1000
@@ -8,8 +8,6 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
-#define CLEAR_BITMAP(name,bits) \
-	memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
 #endif
 
 #include <linux/posix_types.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/lib/bitmap.c .5891-linux-2.6.5.updated/lib/bitmap.c
--- .5891-linux-2.6.5/lib/bitmap.c	2004-04-05 09:04:48.000000000 +1000
+++ .5891-linux-2.6.5.updated/lib/bitmap.c	2004-04-08 16:51:12.000000000 +1000
@@ -78,7 +78,7 @@ void bitmap_shift_right(unsigned long *d
 	DECLARE_BITMAP(__shr_tmp, MAX_BITMAP_BITS);
 
 	BUG_ON(bits > MAX_BITMAP_BITS);
-	bitmap_clear(__shr_tmp, bits);
+	bitmap_zero(__shr_tmp, bits);
 	for (k = 0; k < bits - shift; ++k)
 		if (test_bit(k + shift, src))
 			set_bit(k, __shr_tmp);
@@ -93,7 +93,7 @@ void bitmap_shift_left(unsigned long *ds
 	DECLARE_BITMAP(__shl_tmp, MAX_BITMAP_BITS);
 
 	BUG_ON(bits > MAX_BITMAP_BITS);
-	bitmap_clear(__shl_tmp, bits);
+	bitmap_zero(__shl_tmp, bits);
 	for (k = bits; k >= shift; --k)
 		if (test_bit(k - shift, src))
 			set_bit(k, __shl_tmp);
@@ -223,7 +223,7 @@ int bitmap_parse(const char __user *ubuf
 	int c, old_c, totaldigits, ndigits, nchunks, nbits;
 	u32 chunk;
 
-	bitmap_clear(maskp, nmaskbits);
+	bitmap_zero(maskp, nmaskbits);
 
 	nchunks = nbits = totaldigits = c = 0;
 	do {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5891-linux-2.6.5/mm/page_alloc.c .5891-linux-2.6.5.updated/mm/page_alloc.c
--- .5891-linux-2.6.5/mm/page_alloc.c	2004-04-05 09:04:49.000000000 +1000
+++ .5891-linux-2.6.5.updated/mm/page_alloc.c	2004-04-08 16:45:17.000000000 +1000
@@ -1209,7 +1209,7 @@ static void __init build_zonelists(pg_da
 	local_node = pgdat->node_id;
 	load = numnodes;
 	prev_node = local_node;
-	CLEAR_BITMAP(used_mask, MAX_NUMNODES);
+	bitmap_zero(used_mask, MAX_NUMNODES);
 	while ((node = find_next_best_node(local_node, used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

