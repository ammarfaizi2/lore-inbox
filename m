Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHIQiC>; Fri, 9 Aug 2002 12:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSHIQhq>; Fri, 9 Aug 2002 12:37:46 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:53633 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314938AbSHIQeY>;
	Fri, 9 Aug 2002 12:34:24 -0400
Date: Fri, 9 Aug 2002 20:36:39 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200208091636.g79GadA9007889@bitshadow.namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset implements new block allocator for reiserfs and adds one
   more tail policy. This is a product of continuous NAMESYS research in this
   area. This piece of code incorporates work by Alexander Zarochencev, 
   Jeff Mahoney and Oleg Drokin.
   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

Diffstat:

 fs/reiserfs/bitmap.c           | 1395 +++++++++++++++++++++++------------------
 fs/reiserfs/fix_node.c         |    4 
 fs/reiserfs/hashes.c           |   10 
 fs/reiserfs/inode.c            |   78 --
 fs/reiserfs/journal.c          |   15 
 fs/reiserfs/namei.c            |    4 
 fs/reiserfs/procfs.c           |   33 
 fs/reiserfs/resize.c           |   39 -
 fs/reiserfs/stree.c            |   14 
 fs/reiserfs/super.c            |  155 +++-
 include/linux/reiserfs_fs.h    |  108 ++-
 include/linux/reiserfs_fs_i.h  |    4 
 include/linux/reiserfs_fs_sb.h |   36 -
 13 files changed, 1141 insertions(+), 754 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.747   -> 1.748  
#	 fs/reiserfs/namei.c	1.23    -> 1.24   
#	fs/reiserfs/journal.c	1.22    -> 1.23   
#	fs/reiserfs/hashes.c	1.4     -> 1.5    
#	include/linux/reiserfs_fs_i.h	1.7     -> 1.8    
#	fs/reiserfs/procfs.c	1.5     -> 1.6    
#	fs/reiserfs/fix_node.c	1.16    -> 1.17   
#	 fs/reiserfs/inode.c	1.34    -> 1.35   
#	include/linux/reiserfs_fs.h	1.20    -> 1.21   
#	fs/reiserfs/resize.c	1.5     -> 1.6    
#	 fs/reiserfs/super.c	1.19    -> 1.20   
#	include/linux/reiserfs_fs_sb.h	1.11    -> 1.12   
#	fs/reiserfs/bitmap.c	1.14    -> 1.15   
#	 fs/reiserfs/stree.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/09	green@angband.namesys.com	1.748
# Many files:
#   Merged in new block allocator support, and one more tail policy (shorter tails)
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/bitmap.c	Fri Aug  9 19:31:45 2002
@@ -1,26 +1,70 @@
 /*
  * Copyright 2000-2002 by Hans Reiser, licensing governed by reiserfs/README
  */
+   
+/* Reiserfs block (de)allocator, bitmap-based. */
 
 #include <linux/config.h>
 #include <linux/sched.h>
-#include <linux/reiserfs_fs.h>
+#include <linux/vmalloc.h>
+#include <linux/errno.h>
 #include <linux/locks.h>
-#include <asm/bitops.h>
-#include <linux/list.h>
+#include <linux/kernel.h>
 
-#ifdef CONFIG_REISERFS_CHECK
+#include <linux/reiserfs_fs.h>
+#include <linux/reiserfs_fs_sb.h>
+#include <linux/reiserfs_fs_i.h>
+
+#define PREALLOCATION_SIZE 8
+
+#define INODE_INFO(inode) (&(inode)->u.reiserfs_i)
+
+/* different reiserfs block allocator options */
+
+#define SB_ALLOC_OPTS(s) ((s)->u.reiserfs_sb.s_alloc_options.bits)
+
+#define  _ALLOC_concentrating_formatted_nodes 0
+#define  _ALLOC_displacing_large_files 1
+#define  _ALLOC_displacing_new_packing_localities 2
+#define  _ALLOC_old_hashed_relocation 3
+#define  _ALLOC_new_hashed_relocation 4
+#define  _ALLOC_skip_busy 5
+#define  _ALLOC_displace_based_on_dirid 6
+#define  _ALLOC_hashed_formatted_nodes 7
+#define  _ALLOC_old_way 8
+#define  _ALLOC_hundredth_slices 9
+
+#define  concentrating_formatted_nodes(s)     test_bit(_ALLOC_concentrating_formatted_nodes, &SB_ALLOC_OPTS(s))
+#define  displacing_large_files(s)            test_bit(_ALLOC_displacing_large_files, &SB_ALLOC_OPTS(s))
+#define  displacing_new_packing_localities(s) test_bit(_ALLOC_displacing_new_packing_localities, &SB_ALLOC_OPTS(s))
+
+#define SET_OPTION(optname) \
+   do { \
+        reiserfs_warning("reiserfs: option \"%s\" is set\n", #optname); \
+        set_bit(_ALLOC_ ## optname , &SB_ALLOC_OPTS(s)); \
+    } while(0)
+#define TEST_OPTION(optname, s) \
+    test_bit(_ALLOC_ ## optname , &SB_ALLOC_OPTS(s))
+
+
+/* #define LIMIT(a,b) do { if ((a) > (b)) (a) = (b); } while(0) */
+
+static inline void get_bit_address (struct super_block * s,
+				    unsigned long block, int * bmap_nr, int * offset)
+{
+    /* It is in the bitmap block number equal to the block
+     * number divided by the number of bits in a block. */
+    *bmap_nr = block / (s->s_blocksize << 3);
+    /* Within that bitmap block it is located at bit offset *offset. */
+    *offset = block & ((s->s_blocksize << 3) - 1 );
+    return;
+}
 
-/* this is a safety check to make sure
-** blocks are reused properly.  used for debugging only.
-**
-** this checks, that block can be reused, and it has correct state
-**   (free or busy) 
-*/
+#ifdef CONFIG_REISERFS_CHECK
 int is_reusable (struct super_block * s, unsigned long block, int bit_value)
 {
     int i, j;
-  
+
     if (block == 0 || block >= SB_BLOCK_COUNT (s)) {
 	reiserfs_warning ("vs-4010: is_reusable: block number is out of range %lu (%u)\n",
 			  block, SB_BLOCK_COUNT (s));
@@ -29,104 +73,266 @@
 
     /* it can't be one of the bitmap blocks */
     for (i = 0; i < SB_BMAP_NR (s); i ++)
-	if (block == SB_AP_BITMAP (s)[i]->b_blocknr) {
+	if (block == SB_AP_BITMAP (s)[i].bh->b_blocknr) {
 	    reiserfs_warning ("vs: 4020: is_reusable: "
 			      "bitmap block %lu(%u) can't be freed or reused\n",
 			      block, SB_BMAP_NR (s));
 	    return 0;
 	}
   
-    i = block / (s->s_blocksize << 3);
+    get_bit_address (s, block, &i, &j);
+
     if (i >= SB_BMAP_NR (s)) {
 	reiserfs_warning ("vs-4030: is_reusable: there is no so many bitmap blocks: "
 			  "block=%lu, bitmap_nr=%d\n", block, i);
 	return 0;
     }
 
-    j = block % (s->s_blocksize << 3);
     if ((bit_value == 0 && 
-         reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i]->b_data)) ||
+         reiserfs_test_le_bit(j, SB_AP_BITMAP(s)[i].bh->b_data)) ||
 	(bit_value == 1 && 
-	 reiserfs_test_le_bit(j, SB_AP_BITMAP (s)[i]->b_data) == 0)) {
+	 reiserfs_test_le_bit(j, SB_AP_BITMAP (s)[i].bh->b_data) == 0)) {
 	reiserfs_warning ("vs-4040: is_reusable: corresponding bit of block %lu does not "
 			  "match required value (i==%d, j==%d) test_bit==%d\n",
-		block, i, j, reiserfs_test_le_bit (j, SB_AP_BITMAP (s)[i]->b_data));
+		block, i, j, reiserfs_test_le_bit (j, SB_AP_BITMAP (s)[i].bh->b_data));
+		
 	return 0;
     }
 
     if (bit_value == 0 && block == SB_ROOT_BLOCK (s)) {
 	reiserfs_warning ("vs-4050: is_reusable: this is root block (%u), "
-			  "it must be busy", SB_ROOT_BLOCK (s));
+			  "it must be busy\n", SB_ROOT_BLOCK (s));
 	return 0;
     }
 
     return 1;
 }
+#endif /* CONFIG_REISERFS_CHECK */
 
+/* searches in journal structures for a given block number (bmap, off). If block
+   is found in reiserfs journal it suggests next free block candidate to test. */
+static inline  int is_block_in_journal (struct super_block * s, int bmap, int off, int *next)
+{
+    unsigned int tmp;
 
+    if (reiserfs_in_journal (s, s->s_dev, bmap, off, s->s_blocksize, 1, &tmp)) {
+	if (tmp) {		/* hint supplied */
+	    *next = tmp;
+	    PROC_INFO_INC( s, scan_bitmap.in_journal_hint );
+	} else {
+	    (*next) = off + 1;		/* inc offset to avoid looping. */
+	    PROC_INFO_INC( s, scan_bitmap.in_journal_nohint );
+	}
+	PROC_INFO_INC( s, scan_bitmap.retry );
+	return 1;
+    }
+    return 0;
+}
 
+/* it searches for a window of zero bits with given minimum and maximum lengths in one bitmap
+ * block; */
+static int scan_bitmap_block (struct reiserfs_transaction_handle *th,
+			      int bmap_n, int *beg, int boundary, int min, int max, int unfm)
+{
+    struct super_block *s = th->t_super;
+    struct reiserfs_bitmap_info *bi=&SB_AP_BITMAP(s)[bmap_n];
+    int end, next;
+    int org = *beg;
+
+    RFALSE(bmap_n >= SB_BMAP_NR (s), "Bitmap %d is out of range (0..%d)\n",bmap_n, SB_BMAP_NR (s) - 1);
+    PROC_INFO_INC( s, scan_bitmap.bmap );
+/* this is unclear and lacks comments, explain how journal bitmaps
+   work here for the reader.  Convey a sense of the design here. What
+   is a window? */
+/* - I mean `a window of zero bits' as in description of this function - Zam. */
 
-#endif /* CONFIG_REISERFS_CHECK */
+    if ( !bi ) {
+	printk("Hey, bitmap info pointer is zero for bitmap %d!\n",bmap_n);
+	return 0;
+    }
+    if (buffer_locked (bi->bh)) {
+       PROC_INFO_INC( s, scan_bitmap.wait );
+       __wait_on_buffer (bi->bh);
+    }
+
+    /* If we know that first zero bit is only one or first zero bit is
+       closer to the end of bitmap than our start pointer */
+    if (bi->first_zero_hint > *beg || bi->free_count == 1)
+	*beg = bi->first_zero_hint;
+
+    while (1) {
+	cont:
+	if (bi->free_count < min)
+		return 0; // No free blocks in this bitmap
+
+	/* search for a first zero bit -- beggining of a window */
+	*beg = reiserfs_find_next_zero_le_bit
+	        ((unsigned long*)(bi->bh->b_data), boundary, *beg);
 
-/* get address of corresponding bit (bitmap block number and offset in it) */
-static inline void get_bit_address (struct super_block * s, unsigned long block, int * bmap_nr, int * offset)
-{
-                                /* It is in the bitmap block number equal to the block number divided by the number of
-                                   bits in a block. */
-    *bmap_nr = block / (s->s_blocksize << 3);
-                                /* Within that bitmap block it is located at bit offset *offset. */
-    *offset = block % (s->s_blocksize << 3);
-    return;
+	if (*beg + min > boundary) { /* search for a zero bit fails or the rest of bitmap block
+				      * cannot contain a zero window of minimum size */
+	    return 0;
+	}
+
+	if (unfm && is_block_in_journal(s,bmap_n, *beg, beg))
+	    continue;
+	/* first zero bit found; we check next bits */
+	for (end = *beg + 1;; end ++) {
+	    if (end >= *beg + max || end >= boundary || reiserfs_test_le_bit (end, bi->bh->b_data)) {
+		next = end;
+		break;
+	    }
+	    /* finding the other end of zero bit window requires looking into journal structures (in
+	     * case of searching for free blocks for unformatted nodes) */
+	    if (unfm && is_block_in_journal(s, bmap_n, end, &next))
+		break;
+	}
+
+	/* now (*beg) points to beginning of zero bits window,
+	 * (end) points to one bit after the window end */
+	if (end - *beg >= min) { /* it seems we have found window of proper size */
+	    int i;
+	    reiserfs_prepare_for_journal (s, bi->bh, 1);
+	    /* try to set all blocks used checking are they still free */
+	    for (i = *beg; i < end; i++) {
+		/* It seems that we should not check in journal again. */
+		if (reiserfs_test_and_set_le_bit (i, bi->bh->b_data)) {
+		    /* bit was set by another process
+		     * while we slept in prepare_for_journal() */
+		    PROC_INFO_INC( s, scan_bitmap.stolen );
+		    if (i >= *beg + min)	{ /* we can continue with smaller set of allocated blocks,
+					   * if length of this set is more or equal to `min' */
+			end = i;
+			break;
+		    }
+		    /* otherwise we clear all bit were set ... */
+		    while (--i >= *beg)
+			reiserfs_test_and_clear_le_bit (i, bi->bh->b_data);
+		    reiserfs_restore_prepared_buffer (s, bi->bh);
+		    *beg = max(org, (int)bi->first_zero_hint);
+		    /* ... and search again in current block from beginning */
+		    goto cont;	
+		}
+	    }
+	    bi->free_count -= (end - *beg);
+
+	    /* if search started from zero_hint bit, and zero hint have not
+                changed since, then we need to update first_zero_hint */
+	    if ( bi->first_zero_hint >= *beg)
+		/* no point in looking for free bit if there is not any */
+		bi->first_zero_hint = (bi->free_count > 0 ) ?
+			reiserfs_find_next_zero_le_bit
+			((unsigned long*)(bi->bh->b_data), s->s_blocksize << 3, end) : (s->s_blocksize << 3);
+
+	    journal_mark_dirty (th, s, bi->bh);
+
+	    /* free block count calculation */
+	    reiserfs_prepare_for_journal (s, SB_BUFFER_WITH_SB(s), 1);
+	    PUT_SB_FREE_BLOCKS(s, SB_FREE_BLOCKS(s) - (end - *beg));
+	    journal_mark_dirty (th, s, SB_BUFFER_WITH_SB(s));
+
+	    return end - (*beg);
+	} else {
+	    *beg = next;
+	}
+    }
 }
 
+/* Tries to find contiguous zero bit window (given size) in given region of
+ * bitmap and place new blocks there. Returns number of allocated blocks. */
+static int scan_bitmap (struct reiserfs_transaction_handle *th,
+			unsigned long *start, unsigned long finish,
+			int min, int max, int unfm, unsigned long file_block)
+{
+    int nr_allocated=0;
+    struct super_block * s = th->t_super;
+    /* find every bm and bmap and bmap_nr in this file, and change them all to bitmap_blocknr
+     * - Hans, it is not a block number - Zam. */
+
+    int bm, off;
+    int end_bm, end_off;
+    int off_max = s->s_blocksize << 3;
+
+    PROC_INFO_INC( s, scan_bitmap.call ); 
+    if ( SB_FREE_BLOCKS(s) <= 0)
+	return 0; // No point in looking for more free blocks
+
+    get_bit_address (s, *start, &bm, &off);
+    get_bit_address (s, finish, &end_bm, &end_off);
+
+    // With this option set first we try to find a bitmap that is at least 10%
+    // free, and if that fails, then we fall back to old whole bitmap scanning
+    if ( TEST_OPTION(skip_busy, s) && SB_FREE_BLOCKS(s) > SB_BLOCK_COUNT(s)/20 ) {
+	for (;bm < end_bm; bm++, off = 0) {
+	    if ( ( off && (!unfm || (file_block != 0))) || SB_AP_BITMAP(s)[bm].free_count > (s->s_blocksize << 3) / 10 )
+		nr_allocated = scan_bitmap_block(th, bm, &off, off_max, min, max, unfm);
+	    if (nr_allocated)
+		goto ret;
+        }
+	get_bit_address (s, *start, &bm, &off);
+    }
+
+    for (;bm < end_bm; bm++, off = 0) {
+	nr_allocated = scan_bitmap_block(th, bm, &off, off_max, min, max, unfm);
+	if (nr_allocated)
+	    goto ret;
+    }
+
+    nr_allocated = scan_bitmap_block(th, bm, &off, end_off + 1, min, max, unfm);
 
-/* There would be a modest performance benefit if we write a version
-   to free a list of blocks at once. -Hans */
-				/* I wonder if it would be less modest
-                                   now that we use journaling. -Hans */
-static void _reiserfs_free_block (struct reiserfs_transaction_handle *th, unsigned long block)
+ ret:
+    *start = bm * off_max + off;
+    return nr_allocated;
+
+}
+
+static void _reiserfs_free_block (struct reiserfs_transaction_handle *th,
+			  b_blocknr_t block)
 {
     struct super_block * s = th->t_super;
     struct reiserfs_super_block * rs;
     struct buffer_head * sbh;
-    struct buffer_head ** apbh;
+    struct reiserfs_bitmap_info *apbi;
     int nr, offset;
 
-  PROC_INFO_INC( s, free_block );
-
-  rs = SB_DISK_SUPER_BLOCK (s);
-  sbh = SB_BUFFER_WITH_SB (s);
-  apbh = SB_AP_BITMAP (s);
-
-  get_bit_address (s, block, &nr, &offset);
-
-  if (nr >= sb_bmap_nr (rs)) {
-	  reiserfs_warning ("vs-4075: reiserfs_free_block: "
-			    "block %lu is out of range on %s\n", 
-			    block, bdevname(s->s_dev));
-	  return;
-  }
-
-  reiserfs_prepare_for_journal(s, apbh[nr], 1 ) ;
-
-  /* clear bit for the given block in bit map */
-  if (!reiserfs_test_and_clear_le_bit (offset, apbh[nr]->b_data)) {
-      reiserfs_warning ("vs-4080: reiserfs_free_block: "
-			"free_block (%04x:%lu)[dev:blocknr]: bit already cleared\n", 
-	    s->s_dev, block);
-  }
-  journal_mark_dirty (th, s, apbh[nr]);
+    PROC_INFO_INC( s, free_block );
 
-  reiserfs_prepare_for_journal(s, sbh, 1) ;
-  /* update super block */
-  set_sb_free_blocks( rs, sb_free_blocks(rs) + 1 );
+    rs = SB_DISK_SUPER_BLOCK (s);
+    sbh = SB_BUFFER_WITH_SB (s);
+    apbi = SB_AP_BITMAP(s);
+  
+    get_bit_address (s, block, &nr, &offset);
+  
+    if (nr >= sb_bmap_nr (rs)) {
+	reiserfs_warning ("vs-4075: reiserfs_free_block: "
+			  "block %lu is out of range on %s\n",
+			  block, bdevname(s->s_dev));
+	return;
+    }
 
-  journal_mark_dirty (th, s, sbh);
-  s->s_dirt = 1;
+    reiserfs_prepare_for_journal(s, apbi[nr].bh, 1 ) ;
+  
+    /* clear bit for the given block in bit map */
+    if (!reiserfs_test_and_clear_le_bit (offset, apbi[nr].bh->b_data)) {
+	reiserfs_warning ("vs-4080: reiserfs_free_block: "
+			  "free_block (%04x:%lu)[dev:blocknr]: bit already cleared\n", 
+			  s->s_dev, block);
+    }
+    if (offset < apbi[nr].first_zero_hint) {
+	apbi[nr].first_zero_hint = offset;
+    }
+    apbi[nr].free_count ++;
+    journal_mark_dirty (th, s, apbi[nr].bh);
+  
+    reiserfs_prepare_for_journal(s, sbh, 1) ;
+    /* update super block */
+    set_sb_free_blocks( rs, sb_free_blocks(rs) + 1 );
+  
+    journal_mark_dirty (th, s, sbh);
 }
 
-void reiserfs_free_block (struct reiserfs_transaction_handle *th, 
-                          unsigned long block) {
+void reiserfs_free_block (struct reiserfs_transaction_handle *th,
+			  unsigned long block) {
     struct super_block * s = th->t_super;
 
     RFALSE(!s, "vs-4061: trying to free block on nonexistent device");
@@ -144,565 +350,558 @@
     _reiserfs_free_block(th, block) ;
 }
 
-/* beginning from offset-th bit in bmap_nr-th bitmap block,
-   find_forward finds the closest zero bit. It returns 1 and zero
-   bit address (bitmap, offset) if zero bit found or 0 if there is no
-   zero bit in the forward direction */
-/* The function is NOT SCHEDULE-SAFE! */
-static int find_forward (struct super_block * s, int * bmap_nr, int * offset, int for_unformatted)
-{
-  int i, j;
-  struct buffer_head * bh;
-  unsigned long block_to_try = 0;
-  unsigned long next_block_to_try = 0 ;
-
-  PROC_INFO_INC( s, find_forward.call );
-
-  for (i = *bmap_nr; i < SB_BMAP_NR (s); i ++, *offset = 0, 
-	       PROC_INFO_INC( s, find_forward.bmap )) {
-    /* get corresponding bitmap block */
-    bh = SB_AP_BITMAP (s)[i];
-    if (buffer_locked (bh)) {
-	PROC_INFO_INC( s, find_forward.wait );
-        __wait_on_buffer (bh);
-    }
-retry:
-    j = reiserfs_find_next_zero_le_bit ((unsigned long *)bh->b_data, 
-                                         s->s_blocksize << 3, *offset);
-
-    /* wow, this really needs to be redone.  We can't allocate a block if
-    ** it is in the journal somehow.  reiserfs_in_journal makes a suggestion
-    ** for a good block if the one you ask for is in the journal.  Note,
-    ** reiserfs_in_journal might reject the block it suggests.  The big
-    ** gain from the suggestion is when a big file has been deleted, and
-    ** many blocks show free in the real bitmap, but are all not free
-    ** in the journal list bitmaps.
-    **
-    ** this whole system sucks.  The bitmaps should reflect exactly what
-    ** can and can't be allocated, and the journal should update them as
-    ** it goes.  TODO.
-    */
-    if (j < (s->s_blocksize << 3)) {
-      block_to_try = (i * (s->s_blocksize << 3)) + j; 
-
-      /* the block is not in the journal, we can proceed */
-      if (!(reiserfs_in_journal(s, s->s_dev, block_to_try, s->s_blocksize, for_unformatted, &next_block_to_try))) {
-	*bmap_nr = i;
-	*offset = j;
-	return 1;
-      } 
-      /* the block is in the journal */
-      else if ((j+1) < (s->s_blocksize << 3)) { /* try again */
-	/* reiserfs_in_journal suggested a new block to try */
-	if (next_block_to_try > 0) {
-	  int new_i ;
-	  get_bit_address (s, next_block_to_try, &new_i, offset);
-
-	  PROC_INFO_INC( s, find_forward.in_journal_hint );
-
-	  /* block is not in this bitmap. reset i and continue
-	  ** we only reset i if new_i is in a later bitmap.
-	  */
-	  if (new_i > i) {
-	    i = (new_i - 1 ); /* i gets incremented by the for loop */
-	    PROC_INFO_INC( s, find_forward.in_journal_out );
-	    continue ;
-	  }
-	} else {
-	  /* no suggestion was made, just try the next block */
-	  *offset = j+1 ;
-	}
-	PROC_INFO_INC( s, find_forward.retry );
-	goto retry ;
-      }
+static void __discard_prealloc (struct reiserfs_transaction_handle * th,
+				struct inode * inode)
+{
+    unsigned long save = inode->u.reiserfs_i.i_prealloc_block ;
+#ifdef CONFIG_REISERFS_CHECK
+    if (inode->u.reiserfs_i.i_prealloc_count < 0)
+	reiserfs_warning("zam-4001:%s: inode has negative prealloc blocks count.\n", __FUNCTION__ );
+#endif  
+    while (inode->u.reiserfs_i.i_prealloc_count > 0) {
+	reiserfs_free_prealloc_block(th,inode->u.reiserfs_i.i_prealloc_block);
+	inode->u.reiserfs_i.i_prealloc_block++;
+	inode->u.reiserfs_i.i_prealloc_count --;
     }
-  }
-    /* zero bit not found */
-    return 0;
+    inode->u.reiserfs_i.i_prealloc_block = save ;
+    list_del (&(inode->u.reiserfs_i.i_prealloc_list));
 }
 
-/* return 0 if no free blocks, else return 1 */
-/* The function is NOT SCHEDULE-SAFE!  
-** because the bitmap block we want to change could be locked, and on its
-** way to the disk when we want to read it, and because of the 
-** flush_async_commits.  Per bitmap block locks won't help much, and 
-** really aren't needed, as we retry later on if we try to set the bit
-** and it is already set.
-*/
-static int find_zero_bit_in_bitmap (struct super_block * s, 
-                                    unsigned long search_start, 
-				    int * bmap_nr, int * offset, 
-				    int for_unformatted)
-{
-  int retry_count = 0 ;
-  /* get bit location (bitmap number and bit offset) of search_start block */
-  get_bit_address (s, search_start, bmap_nr, offset);
-
-    /* note that we search forward in the bitmap, benchmarks have shown that it is better to allocate in increasing
-       sequence, which is probably due to the disk spinning in the forward direction.. */
-    if (find_forward (s, bmap_nr, offset, for_unformatted) == 0) {
-      /* there wasn't a free block with number greater than our
-         starting point, so we are going to go to the beginning of the disk */
-
-retry:
-      search_start = 0; /* caller will reset search_start for itself also. */
-      get_bit_address (s, search_start, bmap_nr, offset);
-      if (find_forward (s, bmap_nr,offset,for_unformatted) == 0) {
-	if (for_unformatted) {	/* why only unformatted nodes? -Hans */
-	  if (retry_count == 0) {
-	    /* we've got a chance that flushing async commits will free up
-	    ** some space.  Sync then retry
-	    */
-	    flush_async_commits(s) ;
-	    retry_count++ ;
-	    goto retry ;
-	  } else if (retry_count > 0) {
-	    /* nothing more we can do.  Make the others wait, flush
-	    ** all log blocks to disk, and flush to their home locations.
-	    ** this will free up any blocks held by the journal
-	    */
-	    SB_JOURNAL(s)->j_must_wait = 1 ;
-	  }
-	}
-        return 0;
-      }
+/* FIXME: It should be inline function */
+void reiserfs_discard_prealloc (struct reiserfs_transaction_handle *th,
+				struct inode * inode)
+{
+    if (inode->u.reiserfs_i.i_prealloc_count) {
+	__discard_prealloc(th, inode);
     }
-  return 1;
 }
 
-/* get amount_needed free block numbers from scanning the bitmap of
-   free/used blocks.
-   
-   Optimize layout by trying to find them starting from search_start
-   and moving in increasing blocknr direction.  (This was found to be
-   faster than using a bi-directional elevator_direction, in part
-   because of disk spin direction, in part because by the time one
-   reaches the end of the disk the beginning of the disk is the least
-   congested).
-
-   search_start is the block number of the left
-   semantic neighbor of the node we create.
-
-   return CARRY_ON if everything is ok
-   return NO_DISK_SPACE if out of disk space
-   return NO_MORE_UNUSED_CONTIGUOUS_BLOCKS if the block we found is not contiguous to the last one
-   
-   return block numbers found, in the array free_blocknrs.  assumes
-   that any non-zero entries already present in the array are valid.
-   This feature is perhaps convenient coding when one might not have
-   used all blocknrs from the last time one called this function, or
-   perhaps it is an archaism from the days of schedule tracking, one
-   of us ought to reread the code that calls this, and analyze whether
-   it is still the right way to code it.
-
-   spare space is used only when priority is set to 1. reiserfsck has
-   its own reiserfs_new_blocknrs, which can use reserved space
-
-   exactly what reserved space?  the SPARE_SPACE?  if so, please comment reiserfs.h.
-
-   Give example of who uses spare space, and say that it is a deadlock
-   avoidance mechanism.  -Hans */
-
-/* This function is NOT SCHEDULE-SAFE! */
-
-static int do_reiserfs_new_blocknrs (struct reiserfs_transaction_handle *th,
-                                     unsigned long * free_blocknrs, 
-				     unsigned long search_start, 
-				     int amount_needed, int priority, 
-				     int for_unformatted,
-				     int for_prealloc)
-{
-  struct super_block * s = th->t_super;
-  int i, j;
-  unsigned long * block_list_start = free_blocknrs;
-  int init_amount_needed = amount_needed;
-  unsigned long new_block = 0 ; 
-
-    if (SB_FREE_BLOCKS (s) < SPARE_SPACE && !priority)
-	/* we can answer NO_DISK_SPACE being asked for new block with
-	   priority 0 */
-	return NO_DISK_SPACE;
-
-  RFALSE( !s, "vs-4090: trying to get new block from nonexistent device");
-  RFALSE( search_start == MAX_B_NUM,
-	  "vs-4100: we are optimizing location based on "
-	  "the bogus location of a temp buffer (%lu).", search_start);
-  RFALSE( amount_needed < 1 || amount_needed > 2,
-	  "vs-4110: amount_needed parameter incorrect (%d)", amount_needed);
-
-  /* We continue the while loop if another process snatches our found
-   * free block from us after we find it but before we successfully
-   * mark it as in use */
-
-  while (amount_needed--) {
-    /* skip over any blocknrs already gotten last time. */
-    if (*(free_blocknrs) != 0) {
-      RFALSE( is_reusable (s, *free_blocknrs, 1) == 0, 
-	      "vs-4120: bad blocknr on free_blocknrs list");
-      free_blocknrs++;
-      continue;
-    }
-    /* look for zero bits in bitmap */
-    if (find_zero_bit_in_bitmap(s,search_start, &i, &j,for_unformatted) == 0) {
-      if (find_zero_bit_in_bitmap(s,search_start,&i,&j, for_unformatted) == 0) {
-				/* recode without the goto and without
-				   the if.  It will require a
-				   duplicate for.  This is worth the
-				   code clarity.  Your way was
-				   admirable, and just a bit too
-				   clever in saving instructions.:-)
-				   I'd say create a new function, but
-				   that would slow things also, yes?
-				   -Hans */
-free_and_return:
-	for ( ; block_list_start != free_blocknrs; block_list_start++) {
-	  reiserfs_free_block (th, *block_list_start);
-	  *block_list_start = 0;
-	}
-	if (for_prealloc) 
-	    return NO_MORE_UNUSED_CONTIGUOUS_BLOCKS;
-	else
-	    return NO_DISK_SPACE;
-      }
+void reiserfs_discard_all_prealloc (struct reiserfs_transaction_handle *th)
+{
+  struct list_head * plist = &SB_JOURNAL(th->t_super)->j_prealloc_list;
+  struct inode * inode;
+  
+  while (!list_empty(plist)) {
+    inode = list_entry(plist->next, struct inode, u.reiserfs_i.i_prealloc_list);
+#ifdef CONFIG_REISERFS_CHECK
+    if (!inode->u.reiserfs_i.i_prealloc_count) {
+      reiserfs_warning("zam-4001:%s: inode is in prealloc list but has no preallocated blocks.\n", __FUNCTION__ );
     }
-    
-    /* i and j now contain the results of the search. i = bitmap block
-       number containing free block, j = offset in this block.  we
-       compute the blocknr which is our result, store it in
-       free_blocknrs, and increment the pointer so that on the next
-       loop we will insert into the next location in the array.  Also
-       in preparation for the next loop, search_start is changed so
-       that the next search will not rescan the same range but will
-       start where this search finished.  Note that while it is
-       possible that schedule has occurred and blocks have been freed
-       in that range, it is perhaps more important that the blocks
-       returned be near each other than that they be near their other
-       neighbors, and it also simplifies and speeds the code this way.  */
-
-    /* journal: we need to make sure the block we are giving out is not
-    ** a log block, horrible things would happen there.
-    */
-    new_block = (i * (s->s_blocksize << 3)) + j; 
-    if (for_prealloc && (new_block - 1) != search_start) {
-      /* preallocated blocks must be contiguous, bail if we didnt find one.
-      ** this is not a bug.  We want to do the check here, before the
-      ** bitmap block is prepared, and before we set the bit and log the
-      ** bitmap. 
-      **
-      ** If we do the check after this function returns, we have to 
-      ** call reiserfs_free_block for new_block, which would be pure
-      ** overhead.
-      **
-      ** for_prealloc should only be set if the caller can deal with the
-      ** NO_MORE_UNUSED_CONTIGUOUS_BLOCKS return value.  This can be
-      ** returned before the disk is actually full
-      */
-      goto free_and_return ;
-    }
-    search_start = new_block ;
-    if (search_start >= reiserfs_get_journal_block(s) &&
-        search_start < (reiserfs_get_journal_block(s) + JOURNAL_BLOCK_COUNT)) {
-	reiserfs_warning("vs-4130: reiserfs_new_blocknrs: trying to allocate log block %lu\n",
-			 search_start) ;
-	search_start++ ;
-	amount_needed++ ;
-	continue ;
-    }
-       
-
-    reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[i], 1) ;
-
-    RFALSE( buffer_locked (SB_AP_BITMAP (s)[i]) || 
-	    is_reusable (s, search_start, 0) == 0,
-	    "vs-4140: bitmap block is locked or bad block number found");
-
-    /* if this bit was already set, we've scheduled, and someone else
-    ** has allocated it.  loop around and try again
-    */
-    if (reiserfs_test_and_set_le_bit (j, SB_AP_BITMAP (s)[i]->b_data)) {
-	reiserfs_restore_prepared_buffer(s, SB_AP_BITMAP(s)[i]) ;
-	amount_needed++ ;
-	continue ;
-    }    
-    journal_mark_dirty (th, s, SB_AP_BITMAP (s)[i]); 
-    *free_blocknrs = search_start ;
-    free_blocknrs ++;
+#endif
+    __discard_prealloc(th, inode);
   }
+}
 
-  reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-  /* update free block count in super block */
-  PUT_SB_FREE_BLOCKS( s, SB_FREE_BLOCKS(s) - init_amount_needed );
-  journal_mark_dirty (th, s, SB_BUFFER_WITH_SB (s));
-  s->s_dirt = 1;
-
-  return CARRY_ON;
-}
-
-// this is called only by get_empty_nodes
-int reiserfs_new_blocknrs (struct reiserfs_transaction_handle *th, unsigned long * free_blocknrs,
-			    unsigned long search_start, int amount_needed) {
-  return do_reiserfs_new_blocknrs(th, free_blocknrs, search_start, amount_needed, 0/*priority*/, 0/*for_formatted*/, 0/*for_prealloc */) ;
-}
-
-
-// called by get_new_buffer and by reiserfs_get_block with amount_needed == 1
-int reiserfs_new_unf_blocknrs(struct reiserfs_transaction_handle *th, unsigned long * free_blocknrs,
-			      unsigned long search_start) {
-  return do_reiserfs_new_blocknrs(th, free_blocknrs, search_start, 
-                                  1/*amount_needed*/,
-				  0/*priority*/, 
-				  1/*for formatted*/,
-				  0/*for prealloc */) ;
-}
-
-#ifdef REISERFS_PREALLOCATE
-
-/* 
-** We pre-allocate 8 blocks.  Pre-allocation is used for files > 16 KB only.
-** This lowers fragmentation on large files by grabbing a contiguous set of
-** blocks at once.  It also limits the number of times the bitmap block is
-** logged by making X number of allocation changes in a single transaction.
-**
-** We are using a border to divide the disk into two parts.  The first part
-** is used for tree blocks, which have a very high turnover rate (they
-** are constantly allocated then freed)
-**
-** The second part of the disk is for the unformatted nodes of larger files.
-** Putting them away from the tree blocks lowers fragmentation, and makes
-** it easier to group files together.  There are a number of different
-** allocation schemes being tried right now, each is documented below.
-**
-** A great deal of the allocator's speed comes because reiserfs_get_block
-** sends us the block number of the last unformatted node in the file.  Once
-** a given block is allocated past the border, we don't collide with the
-** blocks near the search_start again.
-** 
-*/
-int reiserfs_new_unf_blocknrs2 (struct reiserfs_transaction_handle *th, 
-				struct inode       * p_s_inode,
-				unsigned long      * free_blocknrs,
-				unsigned long        search_start)
-{
-  int ret=0, blks_gotten=0;
-  unsigned long border = 0;
-  unsigned long bstart = 0;
-  unsigned long hash_in, hash_out;
-  unsigned long saved_search_start=search_start;
-  int allocated[PREALLOCATION_SIZE];
-  int blks;
-
-  if (!reiserfs_no_border(th->t_super)) {
-    /* we default to having the border at the 10% mark of the disk.  This
-    ** is an arbitrary decision and it needs tuning.  It also needs a limit
-    ** to prevent it from taking too much space on huge drives.
-    */
-    bstart = (SB_BLOCK_COUNT(th->t_super) / 10); 
-  }
-  if (!reiserfs_no_unhashed_relocation(th->t_super)) {
-    /* this is a very simple first attempt at preventing too much grouping
-    ** around the border value.  Since k_dir_id is never larger than the
-    ** highest allocated oid, it is far from perfect, and files will tend
-    ** to be grouped towards the start of the border
-    */
-    border = le32_to_cpu(INODE_PKEY(p_s_inode)->k_dir_id) % (SB_BLOCK_COUNT(th->t_super) - bstart - 1) ;
-  } else if (!reiserfs_hashed_relocation(th->t_super)) {
-      hash_in = le32_to_cpu((INODE_PKEY(p_s_inode))->k_dir_id);
-				/* I wonder if the CPU cost of the
-                                   hash will obscure the layout
-                                   effect? Of course, whether that
-                                   effect is good or bad we don't
-                                   know.... :-) */
-      
-      hash_out = keyed_hash(((char *) (&hash_in)), 4);
-      border = hash_out % (SB_BLOCK_COUNT(th->t_super) - bstart - 1) ;
-  }
-  border += bstart ;
-  allocated[0] = 0 ; /* important.  Allows a check later on to see if at
-                      * least one block was allocated.  This prevents false
-		      * no disk space returns
-		      */
-
-  if ( (p_s_inode->i_size < 4 * 4096) || 
-       !(S_ISREG(p_s_inode->i_mode)) )
-    {
-      if ( search_start < border 
-	   || (
-				/* allow us to test whether it is a
-                                   good idea to prevent files from
-                                   getting too far away from their
-                                   packing locality by some unexpected
-                                   means.  This might be poor code for
-                                   directories whose files total
-                                   larger than 1/10th of the disk, and
-                                   it might be good code for
-                                   suffering from old insertions when the disk
-                                   was almost full. */
-               /* changed from !reiserfs_test3(th->t_super), which doesn't
-               ** seem like a good idea.  Think about adding blocks to
-               ** a large file.  If you've allocated 10% of the disk
-               ** in contiguous blocks, you start over at the border value
-               ** for every new allocation.  This throws away all the
-               ** information sent in about the last block that was allocated
-               ** in the file.  Not a good general case at all.
-               ** -chris
-               */
-	       reiserfs_test4(th->t_super) && 
-	       (search_start > border + (SB_BLOCK_COUNT(th->t_super) / 10))
-	       )
-	   )
-	search_start=border;
-  
-      ret = do_reiserfs_new_blocknrs(th, free_blocknrs, search_start, 
-				     1/*amount_needed*/, 
-				     0/*use reserved blocks for root */,
-				     1/*for_formatted*/,
-				     0/*for prealloc */) ;  
-      return ret;
-    }
-
-  /* take a block off the prealloc list and return it -Hans */
-  if (p_s_inode->u.reiserfs_i.i_prealloc_count > 0) {
-    p_s_inode->u.reiserfs_i.i_prealloc_count--;
-    *free_blocknrs = p_s_inode->u.reiserfs_i.i_prealloc_block++;
-
-    /* if no more preallocated blocks, remove inode from list */
-    if (! p_s_inode->u.reiserfs_i.i_prealloc_count) {
-      list_del(&p_s_inode->u.reiserfs_i.i_prealloc_list);
+/* block allocator related options are parsed here */
+int reiserfs_parse_alloc_options(struct super_block * s, char * options)
+{
+    char * this_char, * value;
+
+    s->u.reiserfs_sb.s_alloc_options.preallocmin = 4;
+    s->u.reiserfs_sb.s_alloc_options.bits = 0; /* clear default settings */
+
+    for (this_char = strtok (options, ":"); this_char != NULL; this_char = strtok (NULL, ":")) {
+	if ((value = strchr (this_char, '=')) != NULL)
+	    *value++ = 0;
+
+	if (!strcmp(this_char, "concentrating_formatted_nodes")) {
+	    int temp;
+	    SET_OPTION(concentrating_formatted_nodes);
+	    temp = (value && *value) ? simple_strtoul (value, &value, 0) : 10;
+	    if (temp <= 0 || temp > 100) {
+		s->u.reiserfs_sb.s_alloc_options.border = 10;
+	    } else {
+		s->u.reiserfs_sb.s_alloc_options.border = 100 / temp;
+	   }
+	    continue;
+	}
+	if (!strcmp(this_char, "displacing_large_files")) {
+	    SET_OPTION(displacing_large_files);
+	    s->u.reiserfs_sb.s_alloc_options.large_file_size =
+		(value && *value) ? simple_strtoul (value, &value, 0) : 16;
+	    continue;
+	}
+	if (!strcmp(this_char, "displacing_new_packing_localities")) {
+	    SET_OPTION(displacing_new_packing_localities);
+	    continue;
+	};
+
+	if (!strcmp(this_char, "old_hashed_relocation")) {
+	    SET_OPTION(old_hashed_relocation);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "new_hashed_relocation")) {
+	    SET_OPTION(new_hashed_relocation);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "hashed_formatted_nodes")) {
+	    SET_OPTION(hashed_formatted_nodes);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "skip_busy")) {
+	    SET_OPTION(skip_busy);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "hundredth_slices")) {
+	    SET_OPTION(hundredth_slices);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "old_way")) {
+	    SET_OPTION(old_way);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "displace_based_on_dirid")) {
+	    SET_OPTION(displace_based_on_dirid);
+	    continue;
+	}
+
+	if (!strcmp(this_char, "preallocmin")) {
+	    s->u.reiserfs_sb.s_alloc_options.preallocmin =
+		(value && *value) ? simple_strtoul (value, &value, 0) : 4;
+	    continue;
+	}
+
+	if (!strcmp(this_char, "preallocsize")) {
+	    s->u.reiserfs_sb.s_alloc_options.preallocsize =
+		(value && *value) ? simple_strtoul (value, &value, 0) : PREALLOCATION_SIZE;
+	    continue;
+	}
+
+	reiserfs_warning("zam-4001: %s : unknown option - %s\n", __FUNCTION__ , this_char);
+	return 1;
     }
-    
-    return ret;
-  }
 
-				/* else get a new preallocation for the file */
-  reiserfs_discard_prealloc (th, p_s_inode);
-  /* this uses the last preallocated block as the search_start.  discard
-  ** prealloc does not zero out this number.
-  */
-  if (search_start <= p_s_inode->u.reiserfs_i.i_prealloc_block) {
-    search_start = p_s_inode->u.reiserfs_i.i_prealloc_block;
-  }
-  
-  /* doing the compare again forces search_start to be >= the border,
-  ** even if the file already had prealloction done.  This seems extra,
-  ** and should probably be removed
-  */
-  if ( search_start < border ) search_start=border; 
-
-  /* If the disk free space is already below 10% we should 
-  ** start looking for the free blocks from the beginning 
-  ** of the partition, before the border line.
-  */
-  if ( SB_FREE_BLOCKS(th->t_super) <= (SB_BLOCK_COUNT(th->t_super) / 10) ) {
-    search_start=saved_search_start;
-  }
+    return 0;
+}
 
-  *free_blocknrs = 0;
-  blks = PREALLOCATION_SIZE-1;
-  for (blks_gotten=0; blks_gotten<PREALLOCATION_SIZE; blks_gotten++) {
-    ret = do_reiserfs_new_blocknrs(th, free_blocknrs, search_start, 
-				   1/*amount_needed*/, 
-				   0/*for root reserved*/,
-				   1/*for_formatted*/,
-				   (blks_gotten > 0)/*must_be_contiguous*/) ;
-    /* if we didn't find a block this time, adjust blks to reflect
-    ** the actual number of blocks allocated
-    */ 
-    if (ret != CARRY_ON) {
-      blks = blks_gotten > 0 ? (blks_gotten - 1) : 0 ;
-      break ;
+static void inline new_hashed_relocation (reiserfs_blocknr_hint_t * hint)
+{
+    char * hash_in;
+    if (hint->formatted_node) {
+	    hash_in = (char*)&hint->key.k_dir_id;
+    } else {
+	if (!hint->inode) {
+	    //hint->search_start = hint->beg;
+	    hash_in = (char*)&hint->key.k_dir_id;
+	} else 
+	    if ( TEST_OPTION(displace_based_on_dirid, hint->th->t_super))
+		hash_in = (char *)(&INODE_PKEY(hint->inode)->k_dir_id);
+	    else
+		hash_in = (char *)(&INODE_PKEY(hint->inode)->k_objectid);
     }
-    allocated[blks_gotten]= *free_blocknrs;
-#ifdef CONFIG_REISERFS_CHECK
-    if ( (blks_gotten>0) && (allocated[blks_gotten] - allocated[blks_gotten-1]) != 1 ) {
-      /* this should be caught by new_blocknrs now, checking code */
-      reiserfs_warning("yura-1, reiserfs_new_unf_blocknrs2: pre-allocated not contiguous set of blocks!\n") ;
-      reiserfs_free_block(th, allocated[blks_gotten]);
-      blks = blks_gotten-1; 
-      break;
+
+    hint->search_start = hint->beg + keyed_hash(hash_in, 4) % (hint->end - hint->beg);
+}
+
+static void inline get_left_neighbor(reiserfs_blocknr_hint_t *hint)
+{
+    struct path * path;
+    struct buffer_head * bh;
+    struct item_head * ih;
+    int pos_in_item;
+    __u32 * item;
+
+    if (!hint->path)		/* reiserfs code can call this function w/o pointer to path
+				 * structure supplied; then we rely on supplied search_start */
+	return;
+
+    path = hint->path;
+    bh = get_last_bh(path);
+    RFALSE( !bh, "green-4002: Illegal path specified to get_left_neighbor\n");
+    ih = get_ih(path);
+    pos_in_item = path->pos_in_item;
+    item = get_item (path);
+
+    hint->search_start = bh->b_blocknr;
+
+    if (!hint->formatted_node && is_indirect_le_ih (ih)) {
+	/* for indirect item: go to left and look for the first non-hole entry
+	   in the indirect item */
+	if (pos_in_item == I_UNFM_NUM (ih))
+	    pos_in_item--;
+//	    pos_in_item = I_UNFM_NUM (ih) - 1;
+	while (pos_in_item >= 0) {
+	    int t=get_block_num(item,pos_in_item);
+	    if (t) {
+		hint->search_start = t;
+		break;
+	    }
+	    pos_in_item --;
+	}
+    } else {
     }
+
+    /* does result value fit into specified region? */
+    return;
+}
+
+/* should be, if formatted node, then try to put on first part of the device
+   specified as number of percent with mount option device, else try to put
+   on last of device.  This is not to say it is good code to do so,
+   but the effect should be measured.  */
+static void inline set_border_in_hint(struct super_block *s, reiserfs_blocknr_hint_t *hint)
+{
+    b_blocknr_t border = SB_BLOCK_COUNT(hint->th->t_super) / s->u.reiserfs_sb.s_alloc_options.border;
+
+    if (hint->formatted_node)
+	hint->end = border - 1;
+    else
+	hint->beg = border;
+}
+
+static void inline displace_large_file(reiserfs_blocknr_hint_t *hint)
+{
+    if ( TEST_OPTION(displace_based_on_dirid, hint->th->t_super))
+	hint->search_start = hint->beg + keyed_hash((char *)(&INODE_PKEY(hint->inode)->k_dir_id), 4) % (hint->end - hint->beg);
+    else
+	hint->search_start = hint->beg + keyed_hash((char *)(&INODE_PKEY(hint->inode)->k_objectid), 4) % (hint->end - hint->beg);
+}
+
+static void inline hash_formatted_node(reiserfs_blocknr_hint_t *hint)
+{
+   char * hash_in;
+
+   if (!hint->inode)
+	hash_in = (char*)&hint->key.k_dir_id;
+    else if ( TEST_OPTION(displace_based_on_dirid, hint->th->t_super))
+	hash_in = (char *)(&INODE_PKEY(hint->inode)->k_dir_id);
+    else
+	hash_in = (char *)(&INODE_PKEY(hint->inode)->k_objectid);
+
+	hint->search_start = hint->beg + keyed_hash(hash_in, 4) % (hint->end - hint->beg);
+}
+
+static int inline this_blocknr_allocation_would_make_it_a_large_file(reiserfs_blocknr_hint_t *hint)
+{
+    return hint->block == hint->th->t_super->u.reiserfs_sb.s_alloc_options.large_file_size;
+}
+
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+static void inline displace_new_packing_locality (reiserfs_blocknr_hint_t *hint)
+{
+    struct key * key = &hint->key;
+
+    hint->th->displace_new_blocks = 0;
+    hint->search_start = hint->beg + keyed_hash((char*)(&key->k_objectid),4) % (hint->end - hint->beg);
+}
 #endif
-    if (blks_gotten==0) {
-      p_s_inode->u.reiserfs_i.i_prealloc_block = *free_blocknrs;
+
+static int inline old_hashed_relocation (reiserfs_blocknr_hint_t * hint)
+{
+    unsigned long border;
+    unsigned long hash_in;
+    
+    if (hint->formatted_node || hint->inode == NULL) {
+	return 0;
     }
-    search_start = *free_blocknrs; 
-    *free_blocknrs = 0;
-  }
-  p_s_inode->u.reiserfs_i.i_prealloc_count = blks;
-  *free_blocknrs = p_s_inode->u.reiserfs_i.i_prealloc_block;
-  p_s_inode->u.reiserfs_i.i_prealloc_block++;
-
-  /* if inode has preallocated blocks, link him to list */
-  if (p_s_inode->u.reiserfs_i.i_prealloc_count) {
-    list_add(&p_s_inode->u.reiserfs_i.i_prealloc_list,
-	     &SB_JOURNAL(th->t_super)->j_prealloc_list);
-  } 
-  /* we did actually manage to get 1 block */
-  if (ret != CARRY_ON && allocated[0] > 0) {
-    return CARRY_ON ;
-  }
-  /* NO_MORE_UNUSED_CONTIGUOUS_BLOCKS should only mean something to
-  ** the preallocation code.  The rest of the filesystem asks for a block
-  ** and should either get it, or know the disk is full.  The code
-  ** above should never allow ret == NO_MORE_UNUSED_CONTIGUOUS_BLOCK,
-  ** as it doesn't send for_prealloc = 1 to do_reiserfs_new_blocknrs
-  ** unless it has already successfully allocated at least one block.
-  ** Just in case, we translate into a return value the rest of the
-  ** filesystem can understand.
-  **
-  ** It is an error to change this without making the
-  ** rest of the filesystem understand NO_MORE_UNUSED_CONTIGUOUS_BLOCKS
-  ** If you consider it a bug to return NO_DISK_SPACE here, fix the rest
-  ** of the fs first.
-  */
-  if (ret == NO_MORE_UNUSED_CONTIGUOUS_BLOCKS) {
-#ifdef CONFIG_REISERFS_CHECK
-    reiserfs_warning("reiser-2015: this shouldn't happen, may cause false out of disk space error");
-#endif
-     return NO_DISK_SPACE; 
-  }
-  return ret;
+
+    hash_in = le32_to_cpu((INODE_PKEY(hint->inode))->k_dir_id);
+    border = hint->beg + (unsigned long) keyed_hash(((char *) (&hash_in)), 4) % (hint->end - hint->beg - 1);
+    if (border > hint->search_start)
+	hint->search_start = border;
+
+    return 1;
 }
 
+static int inline old_way (reiserfs_blocknr_hint_t * hint)
+{
+    unsigned long border;
+    
+    if (hint->formatted_node || hint->inode == NULL) {
+	return 0;
+    }
 
-static void __discard_prealloc (struct reiserfs_transaction_handle * th,
-				struct inode * inode)
+      border = hint->beg + le32_to_cpu(INODE_PKEY(hint->inode)->k_dir_id) % (hint->end  - hint->beg);
+    if (border > hint->search_start)
+	hint->search_start = border;
+
+    return 1;
+}
+
+static void inline hundredth_slices (reiserfs_blocknr_hint_t * hint)
 {
-  unsigned long save = inode->u.reiserfs_i.i_prealloc_block ;
-  while (inode->u.reiserfs_i.i_prealloc_count > 0) {
-    reiserfs_free_prealloc_block(th,inode->u.reiserfs_i.i_prealloc_block);
-    inode->u.reiserfs_i.i_prealloc_block++;
-    inode->u.reiserfs_i.i_prealloc_count --;
-  }
-  inode->u.reiserfs_i.i_prealloc_block = save ; 
-  list_del (&(inode->u.reiserfs_i.i_prealloc_list));
+    struct key * key = &hint->key;
+    unsigned long slice_start;
+
+    slice_start = (keyed_hash((char*)(&key->k_dir_id),4) % 100) * (hint->end / 100);
+    if ( slice_start > hint->search_start || slice_start + (hint->end / 100) <= hint->search_start) {
+	hint->search_start = slice_start;
+    }
 }
 
+static void inline determine_search_start(reiserfs_blocknr_hint_t *hint,
+					  int amount_needed)
+{
+    struct super_block *s = hint->th->t_super;
+    hint->beg = 0;
+    hint->end = SB_BLOCK_COUNT(s) - 1;
+
+    /* This is former border algorithm. Now with tunable border offset */
+    if (concentrating_formatted_nodes(s))
+	set_border_in_hint(s, hint);
+
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    /* whenever we create a new directory, we displace it.  At first we will
+       hash for location, later we might look for a moderately empty place for
+       it */
+    if (displacing_new_packing_localities(s)
+	&& hint->th->displace_new_blocks) {
+	displace_new_packing_locality(hint);
+
+	/* we do not continue determine_search_start,
+	 * if new packing locality is being displaced */
+	return;
+    }				      
+#endif
 
-void reiserfs_discard_prealloc (struct reiserfs_transaction_handle *th, 
-				struct inode * inode)
+    /* all persons should feel encouraged to add more special cases here and
+     * test them */
+
+    if (displacing_large_files(s) && !hint->formatted_node
+	&& this_blocknr_allocation_would_make_it_a_large_file(hint)) {
+	displace_large_file(hint);
+	return;
+    }
+
+    /* attempt to copy a feature from old block allocator code */
+    if (TEST_OPTION(old_hashed_relocation, s) && !hint->formatted_node) {
+	old_hashed_relocation(hint);
+    }
+
+    /* if none of our special cases is relevant, use the left neighbor in the
+       tree order of the new node we are allocating for */
+    if (hint->formatted_node && TEST_OPTION(hashed_formatted_nodes,s)) {
+	hash_formatted_node(hint);
+	return;
+    } 
+
+    get_left_neighbor(hint);
+
+    /* Mimic old block allocator behaviour, that is if VFS allowed for preallocation,
+       new blocks are displaced based on directory ID. Also, if suggested search_start
+       is less than last preallocated block, we start searching from it, assuming that
+       HDD dataflow is faster in forward direction */
+    if ( TEST_OPTION(old_way, s)) {
+	if (!hint->formatted_node) {
+	    if ( !reiserfs_hashed_relocation(s))
+		old_way(hint);
+	    else if (!reiserfs_no_unhashed_relocation(s))
+		old_hashed_relocation(hint);
+
+	    if ( hint->inode && hint->search_start < hint->inode->u.reiserfs_i.i_prealloc_block)
+		hint->search_start = hint->inode->u.reiserfs_i.i_prealloc_block;
+	}
+	return;
+    }
+
+    /* This is an approach proposed by Hans */
+    if ( TEST_OPTION(hundredth_slices, s) && ! (displacing_large_files(s) && !hint->formatted_node)) {
+	hundredth_slices(hint);
+	return;
+    }
+
+    if (TEST_OPTION(old_hashed_relocation, s))
+	old_hashed_relocation(hint);
+    if (TEST_OPTION(new_hashed_relocation, s))
+	new_hashed_relocation(hint);
+    return;
+}
+
+static int determine_prealloc_size(reiserfs_blocknr_hint_t * hint)
 {
-#ifdef CONFIG_REISERFS_CHECK
-  if (inode->u.reiserfs_i.i_prealloc_count < 0)
-     reiserfs_warning("zam-4001:%s: inode has negative prealloc blocks count.\n", __FUNCTION__);
-#endif  
-    if (inode->u.reiserfs_i.i_prealloc_count > 0) {
-    __discard_prealloc(th, inode);
-  }
-      }
+    /* make minimum size a mount option and benchmark both ways */
+    /* we preallocate blocks only for regular files, specific size */
+    /* benchmark preallocating always and see what happens */
+
+    hint->prealloc_size = 0;
+
+    if (!hint->formatted_node && hint->preallocate) {
+	if (S_ISREG(hint->inode->i_mode)
+	    && hint->inode->i_size >= hint->th->t_super->u.reiserfs_sb.s_alloc_options.preallocmin * hint->inode->i_sb->s_blocksize)
+	    hint->prealloc_size = hint->th->t_super->u.reiserfs_sb.s_alloc_options.preallocsize - 1;
+    }
+    return CARRY_ON;
+}
+
+/* XXX I know it could be merged with upper-level function;
+   but may be result function would be too complex. */
+static inline int allocate_without_wrapping_disk (reiserfs_blocknr_hint_t * hint,
+					 b_blocknr_t * new_blocknrs,
+					 b_blocknr_t start, b_blocknr_t finish,
+					 int amount_needed, int prealloc_size)
+{
+    int rest = amount_needed;
+    int nr_allocated;
 
-void reiserfs_discard_all_prealloc (struct reiserfs_transaction_handle *th)
+    while (rest > 0) {
+	nr_allocated = scan_bitmap (hint->th, &start, finish, 1,
+				    rest + prealloc_size, !hint->formatted_node,
+				    hint->block);
+
+	if (nr_allocated == 0)	/* no new blocks allocated, return */
+	    break;
+	
+	/* fill free_blocknrs array first */
+	while (rest > 0 && nr_allocated > 0) {
+	    * new_blocknrs ++ = start ++;
+	    rest --; nr_allocated --;
+	}
+
+	/* do we have something to fill prealloc. array also ? */
+	if (nr_allocated > 0) {
+	    /* it means prealloc_size was greater that 0 and we do preallocation */
+	    list_add(&INODE_INFO(hint->inode)->i_prealloc_list,
+		     &SB_JOURNAL(hint->th->t_super)->j_prealloc_list);
+	    INODE_INFO(hint->inode)->i_prealloc_block = start;
+	    INODE_INFO(hint->inode)->i_prealloc_count = nr_allocated;
+	    break;
+	}
+    }
+
+    return (amount_needed - rest);
+}
+
+static inline int blocknrs_and_prealloc_arrays_from_search_start
+    (reiserfs_blocknr_hint_t *hint, b_blocknr_t *new_blocknrs, int amount_needed)
 {
-  struct list_head * plist = &SB_JOURNAL(th->t_super)->j_prealloc_list;
-  struct inode * inode;
-  
-  while (!list_empty(plist)) {
-    inode = list_entry(plist->next, struct inode, u.reiserfs_i.i_prealloc_list);
-#ifdef CONFIG_REISERFS_CHECK
-    if (!inode->u.reiserfs_i.i_prealloc_count) {
-      reiserfs_warning("zam-4001:%s: inode is in prealloc list but has no preallocated blocks.\n", __FUNCTION__);
+    struct super_block *s = hint->th->t_super;
+    b_blocknr_t start = hint->search_start;
+    b_blocknr_t finish = SB_BLOCK_COUNT(s) - 1;
+    int second_pass = 0;
+    int nr_allocated = 0;
+
+    determine_prealloc_size(hint);
+    while((nr_allocated
+	  += allocate_without_wrapping_disk(hint, new_blocknrs + nr_allocated, start, finish,
+					  amount_needed - nr_allocated, hint->prealloc_size))
+	  < amount_needed) {
+
+	/* not all blocks were successfully allocated yet*/
+	if (second_pass) {	/* it was a second pass; we must free all blocks */
+	    while (nr_allocated --)
+		reiserfs_free_block(hint->th, new_blocknrs[nr_allocated]);
+
+	    return NO_DISK_SPACE;
+	} else {		/* refine search parameters for next pass */
+	    second_pass = 1;
+	    finish = start;
+	    start = 0;
+	    continue;
+	}
     }
-#endif    
-    __discard_prealloc(th, inode);
+    return CARRY_ON;
+}
+
+/* grab new blocknrs from preallocated list */
+/* return amount still needed after using them */
+static int use_preallocated_list_if_available (reiserfs_blocknr_hint_t *hint,
+					       b_blocknr_t *new_blocknrs, int amount_needed)
+{
+    struct inode * inode = hint->inode;
+
+    if (INODE_INFO(inode)->i_prealloc_count > 0) {
+	while (amount_needed) {
+
+	    *new_blocknrs ++ = INODE_INFO(inode)->i_prealloc_block ++;
+	    INODE_INFO(inode)->i_prealloc_count --;
+
+	    amount_needed --;
+
+	    if (INODE_INFO(inode)->i_prealloc_count <= 0) {
+		list_del(&inode->u.reiserfs_i.i_prealloc_list);  
+		break;
+	    }
+	}
     }
+    /* return amount still needed after using preallocated blocks */
+    return amount_needed;
+}
+
+int reiserfs_allocate_blocknrs(reiserfs_blocknr_hint_t *hint,
+			       b_blocknr_t * new_blocknrs, int amount_needed,
+			       int reserved_by_us /* Amount of blocks we have
+						      already reserved */)
+{
+    int initial_amount_needed = amount_needed;
+    int ret;
+
+    /* Check if there is enough space, taking into account reserved space */
+    if ( SB_FREE_BLOCKS(hint->th->t_super) - hint->th->t_super->u.reiserfs_sb.reserved_blocks <
+	 amount_needed - reserved_by_us)
+        return NO_DISK_SPACE;
+    /* should this be if !hint->inode &&  hint->preallocate? */
+    /* do you mean hint->formatted_node can be removed ? - Zam */
+    /* hint->formatted_node cannot be removed because we try to access
+       inode information here, and there is often no inode assotiated with
+       metadata allocations - green */
+
+    if (!hint->formatted_node && hint->preallocate) {
+	amount_needed = use_preallocated_list_if_available
+	    (hint, new_blocknrs, amount_needed);
+	if (amount_needed == 0)	/* all blocknrs we need we got from
+                                   prealloc. list */
+	    return CARRY_ON;
+	new_blocknrs += (initial_amount_needed - amount_needed);
+    }
+
+    /* find search start and save it in hint structure */
+    determine_search_start(hint, amount_needed);
+
+    /* allocation itself; fill new_blocknrs and preallocation arrays */
+    ret = blocknrs_and_prealloc_arrays_from_search_start
+	(hint, new_blocknrs, amount_needed);
+
+    /* we used prealloc. list to fill (partially) new_blocknrs array. If final allocation fails we
+     * need to return blocks back to prealloc. list or just free them. -- Zam (I chose second
+     * variant) */
+
+    if (ret != CARRY_ON) {
+	while (amount_needed ++ < initial_amount_needed) {
+	    reiserfs_free_block(hint->th, *(--new_blocknrs));
+	}
+    }
+    return ret;
+}
+
+/* These 2 functions are here to provide blocks reservation to the rest of kernel */
+/* Reserve @blocks amount of blocks in fs pointed by @sb. Caller must make sure
+   there are actually this much blocks on the FS available */
+void reiserfs_claim_blocks_to_be_allocated( 
+				      struct super_block *sb, /* super block of
+							        filesystem where
+								blocks should be
+								reserved */
+				      int blocks /* How much to reserve */
+					  )
+{
+
+    /* Fast case, if reservation is zero - exit immediately. */
+    if ( !blocks )
+	return;
+
+    sb->u.reiserfs_sb.reserved_blocks += blocks;
+}
+
+/* Unreserve @blocks amount of blocks in fs pointed by @sb */
+void reiserfs_release_claimed_blocks( 
+				struct super_block *sb, /* super block of
+							  filesystem where
+							  blocks should be
+							  reserved */
+				int blocks /* How much to unreserve */
+					  )
+{
+
+    /* Fast case, if unreservation is zero - exit immediately. */
+    if ( !blocks )
+	return;
+
+    sb->u.reiserfs_sb.reserved_blocks -= blocks;
+    RFALSE( sb->u.reiserfs_sb.reserved_blocks < 0, "amount of blocks reserved became zero?");
 }
-#endif
diff -Nru a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
--- a/fs/reiserfs/fix_node.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/fix_node.c	Fri Aug  9 19:31:45 2002
@@ -795,8 +795,8 @@
   else /* If we have enough already then there is nothing to do. */
     return CARRY_ON;
 
-  if ( reiserfs_new_blocknrs (p_s_tb->transaction_handle, a_n_blocknrs,
-			      PATH_PLAST_BUFFER(p_s_tb->tb_path)->b_blocknr, n_amount_needed) == NO_DISK_SPACE )
+  if ( reiserfs_new_form_blocknrs (p_s_tb, a_n_blocknrs,
+                                   n_amount_needed) == NO_DISK_SPACE )
     return NO_DISK_SPACE;
 
   /* for each blocknumber we just got, get a buffer and stick it on FEB */
diff -Nru a/fs/reiserfs/hashes.c b/fs/reiserfs/hashes.c
--- a/fs/reiserfs/hashes.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/hashes.c	Fri Aug  9 19:31:45 2002
@@ -19,6 +19,7 @@
 //
 
 #include <asm/types.h>
+#include <asm/page.h>
 
 
 
@@ -57,7 +58,6 @@
 	u32 pad;
 	int i;
  
-
 	//	assert(len >= 0 && len < 256);
 
 	pad = (u32)len | ((u32)len << 8);
@@ -92,7 +92,7 @@
 	{
 	    	//assert(len < 16);
 		if (len >= 16)
-		    *(int *)0 = 0;
+		    BUG();
 
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
@@ -118,7 +118,7 @@
 	{
 	    	//assert(len < 12);
 		if (len >= 12)
-		    *(int *)0 = 0;
+		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -139,7 +139,7 @@
 	{
 	    	//assert(len < 8);
 		if (len >= 8)
-		    *(int *)0 = 0;
+		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -156,7 +156,7 @@
 	{
 	    	//assert(len < 4);
 		if (len >= 4)
-		    *(int *)0 = 0;
+		    BUG();
 		a = b = c = d = pad;
 		for(i = 0; i < len; i++)
 		{
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/inode.c	Fri Aug  9 19:31:45 2002
@@ -155,33 +155,6 @@
     }
 }
 
-
-
-
-/* we need to allocate a block for new unformatted node.  Try to figure out
-   what point in bitmap reiserfs_new_blocknrs should start from. */
-static b_blocknr_t find_tag (struct buffer_head * bh, struct item_head * ih,
-			     __u32 * item, int pos_in_item)
-{
-  __u32 block ;
-  if (!is_indirect_le_ih (ih))
-	 /* something more complicated could be here */
-	 return bh->b_blocknr;
-
-  /* for indirect item: go to left and look for the first non-hole entry in
-	  the indirect item */
-  if (pos_in_item == I_UNFM_NUM (ih))
-	 pos_in_item --;
-  while (pos_in_item >= 0) {
-	 block = get_block_num(item, pos_in_item) ;
-	 if (block)
-		return block ;
-	 pos_in_item --;
-  }
-  return bh->b_blocknr;
-}
-
-
 /* reiserfs_get_block does not need to allocate a block only if it has been
    done already or non-hole position has been found in the indirect item */
 static inline int allocation_needed (int retval, b_blocknr_t allocated, 
@@ -344,10 +317,10 @@
     ** kmap schedules
     */
     if (!p) {
-    p = (char *)kmap(bh_result->b_page) ;
-    if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
-        goto research;
-    }
+	p = (char *)kmap(bh_result->b_page) ;
+	if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
+	    goto research;
+	}
     }
     p += offset ;
     memset (p, 0, inode->i_sb->s_blocksize);
@@ -527,24 +500,24 @@
 }
 
 static inline int _allocate_block(struct reiserfs_transaction_handle *th,
+			   long block,
                            struct inode *inode, 
 			   b_blocknr_t *allocated_block_nr, 
-			   unsigned long tag,
+			   struct path * path,
 			   int flags) {
   
 #ifdef REISERFS_PREALLOCATE
     if (!(flags & GET_BLOCK_NO_ISEM)) {
-        return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr, tag);
+        return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr, path, block);
     }
 #endif
-    return reiserfs_new_unf_blocknrs (th, allocated_block_nr, tag);
+    return reiserfs_new_unf_blocknrs (th, allocated_block_nr, path, block);
 }
 
 static int reiserfs_get_block (struct inode * inode, long block,
 			       struct buffer_head * bh_result, int create)
 {
     int repeat, retval;
-    unsigned long tag;
     b_blocknr_t allocated_block_nr = 0;// b_blocknr_t is unsigned long
     INITIALIZE_PATH(path);
     int pos_in_item;
@@ -623,7 +596,6 @@
 
     if (allocation_needed (retval, allocated_block_nr, ih, item, pos_in_item)) {
 	/* we have to allocate block for the unformatted node */
-	tag = find_tag (bh, ih, item, pos_in_item);
 	if (!transaction_started) {
 	    pathrelse(&path) ;
 	    journal_begin(&th, inode->i_sb, jbegin_count) ;
@@ -632,7 +604,7 @@
 	    goto research ;
 	}
 
-	repeat = _allocate_block(&th, inode, &allocated_block_nr, tag, create);
+	repeat = _allocate_block(&th, block, inode, &allocated_block_nr, &path, create);
 
 	if (repeat == NO_DISK_SPACE) {
 	    /* restart the transaction to give the journal a chance to free
@@ -640,7 +612,7 @@
 	    ** research if we succeed on the second try
 	    */
 	    restart_transaction(&th, inode, &path) ; 
-	    repeat = _allocate_block(&th, inode,&allocated_block_nr,tag,create);
+	    repeat = _allocate_block(&th, block, inode, &allocated_block_nr, NULL, create);
 
 	    if (repeat != NO_DISK_SPACE) {
 		goto research ;
@@ -791,10 +763,10 @@
 	    add_to_flushlist(inode, unbh) ;
 
 	    /* mark it dirty now to prevent commit_write from adding
-	    ** this buffer to the inode's dirty buffer list
-	    */
+	     ** this buffer to the inode's dirty buffer list
+	     */
 	    __mark_buffer_dirty(unbh) ;
-		  
+
 	    //inode->i_blocks += inode->i_sb->s_blocksize / 512;
 	    //mark_tail_converted (inode);
 	} else {
@@ -1493,7 +1465,7 @@
    directory) or reiserfs_new_symlink (to insert symlink body if new
    object is symlink) or nothing (if new object is regular file) */
 struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th,
-				   const struct inode * dir, int mode, 
+				   struct inode * dir, int mode, 
 				   const char * symname, 
 				   int i_size, /* 0 for regular, EMTRY_DIR_SIZE for dirs,
 						  strlen (symname) for symlinks)*/
@@ -1617,6 +1589,10 @@
 	set_inode_sd_version (inode, STAT_DATA_V2);
     
     /* insert the stat data into the tree */
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    if (dir->u.reiserfs_i.new_packing_locality)
+	th->displace_new_blocks = 1;
+#endif
     retval = reiserfs_insert_item (th, &path_to_key, &key, &ih, (char *)(&sd));
     if (retval) {
 	iput (inode);
@@ -1625,6 +1601,10 @@
 	return NULL;
     }
 
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    if (!th->displace_new_blocks)
+	dir->u.reiserfs_i.new_packing_locality = 0;
+#endif
     if (S_ISDIR(mode)) {
 	/* insert item with "." and ".." */
 	retval = reiserfs_new_directory (th, &ih, &path_to_key, dir);
@@ -1782,16 +1762,16 @@
     reiserfs_update_inode_transaction(p_s_inode) ;
     windex = push_journal_writer("reiserfs_vfs_truncate_file") ;
     if (update_timestamps)
-           /* we are doing real truncate: if the system crashes before the last
-              transaction of truncating gets committed - on reboot the file
-              either appears truncated properly or not truncated at all */
-           add_save_link (&th, p_s_inode, 1);
+	    /* we are doing real truncate: if the system crashes before the last
+	       transaction of truncating gets committed - on reboot the file
+	       either appears truncated properly or not truncated at all */
+	add_save_link (&th, p_s_inode, 1);
     reiserfs_do_truncate (&th, p_s_inode, page, update_timestamps) ;
     pop_journal_writer(windex) ;
     journal_end(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 + 1 ) ;
 
     if (update_timestamps)
-       remove_save_link (p_s_inode, 1/* truncate */);
+	remove_save_link (p_s_inode, 1/* truncate */);
 
     if (page) {
         length = offset & (blocksize - 1) ;
@@ -2073,13 +2053,13 @@
     */
     if (pos > inode->i_size) {
 	struct reiserfs_transaction_handle th ;
-	lock_kernel() ;
+	lock_kernel();
 	journal_begin(&th, inode->i_sb, 1) ;
 	reiserfs_update_inode_transaction(inode) ;
 	inode->i_size = pos ;
 	reiserfs_update_sd(&th, inode) ;
 	journal_end(&th, inode->i_sb, 1) ;
-	unlock_kernel() ;
+	unlock_kernel();
     }
  
     ret = generic_commit_write(f, page, from, to) ;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/journal.c	Fri Aug  9 19:31:45 2002
@@ -508,14 +508,12 @@
 **
 */
 int reiserfs_in_journal(struct super_block *p_s_sb, kdev_t dev, 
-                        unsigned long bl, int size, int search_all, 
-			unsigned long *next_zero_bit) {
+                        int bmap_nr, int bit_nr, int size, int search_all, 
+			unsigned int *next_zero_bit) {
   struct reiserfs_journal_cnode *cn ;
   struct reiserfs_list_bitmap *jb ;
   int i ;
-  int bmap_nr = bl / (p_s_sb->s_blocksize << 3) ;
-  int bit_nr = bl % (p_s_sb->s_blocksize << 3) ;
-  int tmp_bit ;
+  unsigned long bl;
 
   *next_zero_bit = 0 ; /* always start this at zero. */
 
@@ -535,15 +533,15 @@
       jb = SB_JOURNAL(p_s_sb)->j_list_bitmap + i ;
       if (jb->journal_list && jb->bitmaps[bmap_nr] &&
           test_bit(bit_nr, (unsigned long *)jb->bitmaps[bmap_nr]->data)) {
-	tmp_bit = find_next_zero_bit((unsigned long *)
+	*next_zero_bit = find_next_zero_bit((unsigned long *)
 	                             (jb->bitmaps[bmap_nr]->data),
 	                             p_s_sb->s_blocksize << 3, bit_nr+1) ; 
-	*next_zero_bit = bmap_nr * (p_s_sb->s_blocksize << 3) + tmp_bit ;
 	return 1 ;
       }
     }
   }
 
+  bl = bmap_nr * (p_s_sb->s_blocksize << 3) + bit_nr;
   /* is it in any old transactions? */
   if (search_all && (cn = get_journal_hash_dev(SB_JOURNAL(p_s_sb)->j_list_hash_table, dev,bl,size))) {
     return 1; 
@@ -1811,7 +1809,8 @@
   jl = SB_JOURNAL_LIST(ct->p_s_sb) + ct->jindex ;
 
   flush_commit_list(ct->p_s_sb, SB_JOURNAL_LIST(ct->p_s_sb) + ct->jindex, 1) ; 
-  if (jl->j_len > 0 && atomic_read(&(jl->j_nonzerolen)) > 0 && 
+
+  if (jl->j_len > 0 && atomic_read(&(jl->j_nonzerolen)) > 0 &&
       atomic_read(&(jl->j_commit_left)) == 0) {
     kupdate_one_transaction(ct->p_s_sb, jl) ;
   }
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/namei.c	Fri Aug  9 19:31:45 2002
@@ -603,6 +603,10 @@
     */
     INC_DIR_INODE_NLINK(dir)
 
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    /* set flag that new packing locality created and new blocks for the content     * of that directory are not displaced yet */
+    dir->u.reiserfs_i.new_packing_locality = 1;
+#endif
     mode = S_IFDIR | mode;
     inode = reiserfs_new_inode (&th, dir, mode, 0/*symlink*/,
 				old_format_only (dir->i_sb) ? EMPTY_DIR_SIZE_V1 : EMPTY_DIR_SIZE,
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/procfs.c	Fri Aug  9 19:31:45 2002
@@ -118,7 +118,7 @@
 #define SF( x ) ( r -> x )
 #define SFP( x ) SF( s_proc_info_data.x )
 #define SFPL( x ) SFP( x[ level ] )
-#define SFPF( x ) SFP( find_forward.x )
+#define SFPF( x ) SFP( scan_bitmap.x )
 #define SFPJ( x ) SFP( journal.x )
 
 #define D2C( x ) le16_to_cpu( x )
@@ -189,7 +189,7 @@
 			reiserfs_no_unhashed_relocation( sb ) ? "NO_UNHASHED_RELOCATION " : "",
 			reiserfs_hashed_relocation( sb ) ? "UNHASHED_RELOCATION " : "",
 			reiserfs_test4( sb ) ? "TEST4 " : "",
-			dont_have_tails( sb ) ? "NO_TAILS " : "TAILS ",
+			have_large_tails( sb ) ? "TAILS " : have_small_tails(sb)?"SMALL_TAILS ":"NO_TAILS ",
 			replay_only( sb ) ? "REPLAY_ONLY " : "",
 			reiserfs_dont_log( sb ) ? "DONT_LOG " : "LOG ",
 			convert_reiserfs( sb ) ? "CONV " : "",
@@ -319,27 +319,30 @@
 	r = &sb->u.reiserfs_sb;
 
 	len += sprintf( &buffer[ len ], "free_block: %lu\n"
-			"find_forward:"
-			"         wait"
-			"         bmap"
-			"        retry"
-			" journal_hint"
-			"  journal_out"
+			"  scan_bitmap:"
+			"          wait"
+			"          bmap"
+			"         retry"
+			"        stolen"
+			"  journal_hint"
+			"journal_nohint"
 			"\n"
-			" %12lu"
-			" %12lu"
-			" %12lu"
-			" %12lu"
-			" %12lu"
-			" %12lu"
+			" %14lu"
+			" %14lu"
+			" %14lu"
+			" %14lu"
+			" %14lu"
+			" %14lu"
+			" %14lu"
 			"\n",
 			SFP( free_block ),
 			SFPF( call ), 
 			SFPF( wait ), 
 			SFPF( bmap ),
 			SFPF( retry ),
+			SFPF( stolen ),
 			SFPF( in_journal_hint ),
-			SFPF( in_journal_out ) );
+			SFPF( in_journal_nohint ) );
 
 	procinfo_epilogue( sb );
 	return reiserfs_proc_tail( len, buffer, start, offset, count, eof );
diff -Nru a/fs/reiserfs/resize.c b/fs/reiserfs/resize.c
--- a/fs/reiserfs/resize.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/resize.c	Fri Aug  9 19:31:45 2002
@@ -19,7 +19,8 @@
 int reiserfs_resize (struct super_block * s, unsigned long block_count_new)
 {
 	struct reiserfs_super_block * sb;
-	struct buffer_head ** bitmap, * bh;
+        struct reiserfs_bitmap_info *bitmap;
+	struct buffer_head * bh;
 	struct reiserfs_transaction_handle th;
 	unsigned int bmap_nr_new, bmap_nr;
 	unsigned int block_r_new, block_r;
@@ -103,26 +104,26 @@
 	
 	    /* allocate additional bitmap blocks, reallocate array of bitmap
 	     * block pointers */
-	    bitmap = reiserfs_kmalloc(sizeof(struct buffer_head *) * bmap_nr_new, GFP_KERNEL, s);
+	    bitmap = vmalloc(sizeof(struct reiserfs_bitmap_info) * bmap_nr_new);
 	    if (!bitmap) {
 		printk("reiserfs_resize: unable to allocate memory.\n");
 		return -ENOMEM;
 	    }
 	    for (i = 0; i < bmap_nr; i++)
-		bitmap[i] = SB_AP_BITMAP(s)[i];
+		bitmap[i].bh = SB_AP_BITMAP(s)[i].bh;
 	    for (i = bmap_nr; i < bmap_nr_new; i++) {
-		bitmap[i] = getblk(s->s_dev, i * s->s_blocksize * 8, s->s_blocksize);
-		memset(bitmap[i]->b_data, 0, sb->s_blocksize);
-		reiserfs_test_and_set_le_bit(0, bitmap[i]->b_data);
-
-		mark_buffer_dirty(bitmap[i]) ;
-		mark_buffer_uptodate(bitmap[i], 1);
-		ll_rw_block(WRITE, 1, bitmap + i);
-		wait_on_buffer(bitmap[i]);
+		bitmap[i].bh = getblk(s->s_dev, i * s->s_blocksize * 8, s->s_blocksize);
+		memset(bitmap[i].bh->b_data, 0, sb->s_blocksize);
+		reiserfs_test_and_set_le_bit(0, bitmap[i].bh->b_data);
+
+		mark_buffer_dirty(bitmap[i].bh) ;
+		mark_buffer_uptodate(bitmap[i].bh, 1);
+		ll_rw_block(WRITE, 1, &bitmap[i].bh);
+		wait_on_buffer(bitmap[i].bh);
 	    }	
 	    /* free old bitmap blocks array */
-	    reiserfs_kfree(SB_AP_BITMAP(s), 
-			   sizeof(struct buffer_head *) * bmap_nr, s);
+	    vfree(SB_AP_BITMAP(s)); 
+			   
 	    SB_AP_BITMAP(s) = bitmap;
 	}
 	
@@ -130,17 +131,17 @@
 	journal_begin(&th, s, 10);
 
 	/* correct last bitmap blocks in old and new disk layout */
-	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr - 1], 1);
+	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr - 1].bh, 1);
 	for (i = block_r; i < s->s_blocksize * 8; i++)
 	    reiserfs_test_and_clear_le_bit(i, 
-					   SB_AP_BITMAP(s)[bmap_nr - 1]->b_data);
-	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr - 1]);
+					   SB_AP_BITMAP(s)[bmap_nr - 1].bh->b_data);
+	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr - 1].bh);
 
-	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr_new - 1], 1);
+	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr_new - 1].bh, 1);
 	for (i = block_r_new; i < s->s_blocksize * 8; i++)
 	    reiserfs_test_and_set_le_bit(i,
-					 SB_AP_BITMAP(s)[bmap_nr_new - 1]->b_data);
-	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr_new - 1]);
+					 SB_AP_BITMAP(s)[bmap_nr_new - 1].bh->b_data);
+	journal_mark_dirty(&th, s, SB_AP_BITMAP(s)[bmap_nr_new - 1].bh);
  
  	/* update super */
 	reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/stree.c	Fri Aug  9 19:31:45 2002
@@ -1621,9 +1621,9 @@
     
     do_balance(&s_cut_balance, NULL, NULL, c_mode);
     if ( n_is_inode_locked ) {
-	/* we've done an indirect->direct conversion.  when the data block 
-	** was freed, it was removed from the list of blocks that must 
-	** be flushed before the transaction commits, so we don't need to 
+	/* we've done an indirect->direct conversion.  when the data block
+	** was freed, it was removed from the list of blocks that must
+	** be flushed before the transaction commits, so we don't need to
 	** deal with it here.
 	*/
 	p_s_inode->u.reiserfs_i.i_flags &= ~i_pack_on_close_mask;
@@ -1814,6 +1814,9 @@
     int                 retval;
 
     init_tb_struct(th, &s_paste_balance, th->t_super, p_s_search_path, n_pasted_size);
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    s_paste_balance.key = p_s_key->on_disk_key;
+#endif
     
     while ( (retval = fix_nodes(M_PASTE, &s_paste_balance, NULL, p_c_body)) == REPEAT_SEARCH ) {
 	/* file system changed while we were in the fix_nodes */
@@ -1824,7 +1827,7 @@
 	    goto error_out ;
 	}
 	if (retval == POSITION_FOUND) {
-	    reiserfs_warning ("PAP-5710: reiserfs_paste_into_item: entry or pasted byte (%K) exists", p_s_key);
+	    reiserfs_warning ("PAP-5710: reiserfs_paste_into_item: entry or pasted byte (%K) exists\n", p_s_key);
 	    retval = -EEXIST ;
 	    goto error_out ;
 	}
@@ -1859,6 +1862,9 @@
     int                 retval;
 
     init_tb_struct(th, &s_ins_balance, th->t_super, p_s_path, IH_SIZE + ih_item_len(p_s_ih));
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+    s_ins_balance.key = key->on_disk_key;
+#endif
 
     /*
     if (p_c_body == 0)
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Aug  9 19:31:45 2002
+++ b/fs/reiserfs/super.c	Fri Aug  9 19:31:45 2002
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
@@ -329,9 +330,9 @@
   journal_release(&th, s) ;
 
   for (i = 0; i < SB_BMAP_NR (s); i ++)
-    brelse (SB_AP_BITMAP (s)[i]);
+    brelse (SB_AP_BITMAP (s)[i].bh);
 
-  reiserfs_kfree (SB_AP_BITMAP (s), sizeof (struct buffer_head *) * SB_BMAP_NR (s), s);
+  vfree (SB_AP_BITMAP (s));
 
   brelse (SB_BUFFER_WITH_SB (s));
 
@@ -342,6 +343,11 @@
 		      s->u.reiserfs_sb.s_kmallocs);
   }
 
+  if (s->u.reiserfs_sb.reserved_blocks != 0) {
+    reiserfs_warning ("green-2005: reiserfs_put_super: reserved blocks left %d\n",
+		      s->u.reiserfs_sb.reserved_blocks);
+  }
+
   reiserfs_proc_unregister( s, "journal" );
   reiserfs_proc_unregister( s, "oidmap" );
   reiserfs_proc_unregister( s, "on-disk-super" );
@@ -433,6 +439,13 @@
     {NULL, 0}
 };
 
+const arg_desc_t tails[] = {
+    {"on", REISERFS_LARGETAIL},
+    {"off", -1},
+    {"small", REISERFS_SMALLTAIL},
+    {NULL, 0}
+};
+
 
 /* proceed only one option from a list *cur - string containing of mount options
    opts - array of options which are accepted
@@ -440,7 +453,7 @@
    in the input - pointer to the argument is stored here
    bit_flags - if option requires to set a certain bit - it is set here
    return -1 if unknown option is found, opt->arg_required otherwise */
-static int reiserfs_getopt (char ** cur, opt_desc_t * opts, char ** opt_arg,
+static int reiserfs_getopt ( struct super_block * s, char ** cur, opt_desc_t * opts, char ** opt_arg,
 			    unsigned long * bit_flags)
 {
     char * p;
@@ -462,11 +475,19 @@
 	*(*cur) = '\0';
 	(*cur) ++;
     }
-    
+
+    if ( !strncmp (p, "alloc=", 6) ) {
+	/* Ugly special case, probably we should redo options parser so that
+	   it can understand several arguments for some options, also so that
+	   it can fill several bitfields with option values. */
+	reiserfs_parse_alloc_options( s, p + 6);
+	return 0;
+    }
+	
     /* for every option in the list */
     for (opt = opts; opt->option_name; opt ++) {
 	if (!strncmp (p, opt->option_name, strlen (opt->option_name))) {
-	    if (bit_flags && opt->bitmask)
+	    if (bit_flags && opt->bitmask != -1 )
 		set_bit (opt->bitmask, bit_flags);
 	    break;
 	}
@@ -515,7 +536,7 @@
     /* values possible for this option are listed in opt->values */
     for (arg = opt->values; arg->value; arg ++) {
 	if (!strcmp (p, arg->value)) {
-	    if (bit_flags && arg->bitmask)
+	    if (bit_flags && arg->bitmask != -1 )
 		set_bit (arg->bitmask, bit_flags);
 	    return opt->arg_required;
 	}
@@ -527,7 +548,7 @@
 
 
 /* returns 0 if something is wrong in option string, 1 - otherwise */
-static int reiserfs_parse_options (char * options, /* string given via mount's -o */
+static int reiserfs_parse_options (struct super_block * s, char * options, /* string given via mount's -o */
 				   unsigned long * mount_options,
 				   /* after the parsing phase, contains the
 				      collection of bitflags defining what
@@ -538,15 +559,16 @@
     char * arg = NULL;
     char * pos;
     opt_desc_t opts[] = {
-		{"notail", 0, 0, NOTAIL},
+		{"tails", 't', tails, -1},
+		{"notail", 0, 0, -1}, /* Compatibility stuff, so that -o notail for old setups still work */
 		{"conv", 0, 0, REISERFS_CONVERT}, 
-		{"nolog", 0, 0, 0},
+		{"nolog", 0, 0, -1},
 		{"replayonly", 0, 0, REPLAYONLY},
 		
-		{"block-allocator", 'a', balloc, 0}, 
+		{"block-allocator", 'a', balloc, -1}, 
 		{"hash", 'h', hash, FORCE_HASH_DETECT},
 		
-		{"resize", 'r', 0, 0},
+		{"resize", 'r', 0, -1},
 		{NULL, 0, 0, 0}
     };
 	
@@ -555,9 +577,12 @@
 	/* use default configuration: create tails, journaling on, no
 	   conversion to newest format */
 	return 1;
+    else
+	/* Drop defaults to zeroes */
+	*mount_options = 0;
     
     for (pos = options; pos; ) {
-	c = reiserfs_getopt (&pos, opts, &arg, mount_options);
+	c = reiserfs_getopt (s, &pos, opts, &arg, mount_options);
 	if (c == -1)
 	    /* wrong option is given */
 	    return 0;
@@ -612,7 +637,7 @@
 
   rs = SB_DISK_SUPER_BLOCK (s);
 
-  if (!reiserfs_parse_options(data, &mount_options, &blocks))
+  if (!reiserfs_parse_options(s, data, &mount_options, &blocks))
   	return 0;
 
 #define SET_OPT( opt, bits, super )					\
@@ -620,7 +645,8 @@
 	    ( super ) -> u.reiserfs_sb.s_mount_opt |= ( 1 << ( opt ) )
 
   /* set options in the super-block bitmask */
-  SET_OPT( NOTAIL, mount_options, s );
+  SET_OPT( REISERFS_SMALLTAIL, mount_options, s );
+  SET_OPT( REISERFS_LARGETAIL, mount_options, s );
   SET_OPT( REISERFS_NO_BORDER, mount_options, s );
   SET_OPT( REISERFS_NO_UNHASHED_RELOCATION, mount_options, s );
   SET_OPT( REISERFS_HASHED_RELOCATION, mount_options, s );
@@ -677,32 +703,84 @@
   return 0;
 }
 
+/* load_bitmap_info_data - Sets up the reiserfs_bitmap_info structure from disk.
+ * @sb - superblock for this filesystem
+ * @bi - the bitmap info to be loaded. Requires that bi->bh is valid.
+ *
+ * This routine counts how many free bits there are, finding the first zero
+ * as a side effect. Could also be implemented as a loop of test_bit() calls, or
+ * a loop of find_first_zero_bit() calls. This implementation is similar to
+ * find_first_zero_bit(), but doesn't return after it finds the first bit.
+ * Should only be called on fs mount, but should be fairly efficient anyways.
+ *
+ * bi->first_zero_hint is considered unset if it == 0, since the bitmap itself
+ * will * invariably occupt block 0 represented in the bitmap. The only
+ * exception to this is when free_count also == 0, since there will be no
+ * free blocks at all.
+ */
+static void load_bitmap_info_data (struct super_block *sb,
+                                   struct reiserfs_bitmap_info *bi)
+{
+    __u32 *cur = (__u32 *)bi->bh->b_data;
+
+    while ((char *)cur < (bi->bh->b_data + sb->s_blocksize)) {
+
+	/* No need to scan if all 0's or all 1's.
+	 * Since we're only counting 0's, we can simply ignore all 1's */
+	if (*cur == 0) {
+	    if (bi->first_zero_hint == 0) {
+		bi->first_zero_hint = ((char *)cur - bi->bh->b_data) << 3;
+	    }
+	    bi->free_count += 32;
+	} else if (*cur != ~0L) {
+	    int b;
+	    for (b = 0; b < 32; b++) {
+		if (!test_bit (b, cur)) {
+		    bi->free_count ++;
+		    if (bi->first_zero_hint == 0)
+			bi->first_zero_hint =
+					(((char *)cur - bi->bh->b_data) << 3) + b;
+		    }
+		}
+	    }
+	cur ++;
+    }
+
+#ifdef CONFIG_REISERFS_CHECK
+// This outputs a lot of unneded info on big FSes
+//    reiserfs_warning ("bitmap loaded from block %d: %d free blocks\n",
+//		      bi->bh->b_blocknr, bi->free_count);
+#endif
+}
 
 static int read_bitmaps (struct super_block * s)
 {
     int i, bmp;
 
-    SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * SB_BMAP_NR(s), GFP_NOFS, s);
+    SB_AP_BITMAP (s) = vmalloc (sizeof (struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
     if (SB_AP_BITMAP (s) == 0)
       return 1;
+    memset (SB_AP_BITMAP (s), 0, sizeof (struct reiserfs_bitmap_info) * SB_BMAP_NR(s));
+
     for (i = 0, bmp = REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
  	 i < SB_BMAP_NR(s); i++, bmp = s->s_blocksize * 8 * i) {
-      SB_AP_BITMAP (s)[i] = getblk (s->s_dev, bmp, s->s_blocksize);
-      if (!buffer_uptodate(SB_AP_BITMAP(s)[i]))
-	ll_rw_block(READ, 1, SB_AP_BITMAP(s) + i); 
+      SB_AP_BITMAP (s)[i].bh = sb_getblk (s, bmp);
+      if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh))
+	ll_rw_block(READ, 1, &SB_AP_BITMAP(s)[i].bh); 
     }
     for (i = 0; i < SB_BMAP_NR(s); i++) {
-      wait_on_buffer(SB_AP_BITMAP (s)[i]);
-      if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
+      wait_on_buffer(SB_AP_BITMAP (s)[i].bh);
+      if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
 	reiserfs_warning("sh-2029: reiserfs read_bitmaps: "
 			 "bitmap block (#%lu) reading failed\n",
-			 SB_AP_BITMAP(s)[i]->b_blocknr);
+			 SB_AP_BITMAP(s)[i].bh->b_blocknr);
 	for (i = 0; i < SB_BMAP_NR(s); i++)
-	  brelse(SB_AP_BITMAP(s)[i]);
-	reiserfs_kfree(SB_AP_BITMAP(s), sizeof(struct buffer_head *) * SB_BMAP_NR(s), s);
+	  brelse(SB_AP_BITMAP(s)[i].bh);
+	vfree(SB_AP_BITMAP(s));
 	SB_AP_BITMAP(s) = NULL;
 	return 1;
       }
+      load_bitmap_info_data (s, SB_AP_BITMAP (s) + i);
     }   
     return 0;
 }
@@ -714,16 +792,17 @@
   int bmp1 = (REISERFS_OLD_DISK_OFFSET_IN_BYTES / s->s_blocksize) + 1;  /* first of bitmap blocks */
 
   /* read true bitmap */
-  SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * sb_bmap_nr(rs), GFP_NOFS, s);
+  SB_AP_BITMAP (s) = vmalloc (sizeof (struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
   if (SB_AP_BITMAP (s) == 0)
     return 1;
 
-  memset (SB_AP_BITMAP (s), 0, sizeof (struct buffer_head *) * sb_bmap_nr(rs));
+  memset (SB_AP_BITMAP (s), 0, sizeof (struct reiserfs_buffer_info *) * sb_bmap_nr(rs));
 
   for (i = 0; i < sb_bmap_nr(rs); i ++) {
-    SB_AP_BITMAP (s)[i] = reiserfs_bread (s, bmp1 + i, s->s_blocksize);
-    if (!SB_AP_BITMAP (s)[i])
+    SB_AP_BITMAP (s)[i].bh = reiserfs_bread (s, bmp1 + i, s->s_blocksize);
+    if (!SB_AP_BITMAP (s)[i].bh)
       return 1;
+    load_bitmap_info_data (s, SB_AP_BITMAP (s) + i);
   }
 
   return 0;
@@ -736,7 +815,7 @@
   char * buf;
 
   while (i < SB_BLOCK_COUNT (s)) {
-    buf = SB_AP_BITMAP (s)[i / (s->s_blocksize * 8)]->b_data;
+    buf = SB_AP_BITMAP (s)[i / (s->s_blocksize * 8)].bh->b_data;
     if (!reiserfs_test_le_bit (i % (s->s_blocksize * 8), buf))
       free ++;
     i ++;
@@ -848,10 +927,11 @@
   }
 
   for (i = 0; i < SB_BMAP_NR(s) ; i++) {
-    ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i])) ;
-    wait_on_buffer(SB_AP_BITMAP(s)[i]) ;
-    if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
-      printk("reread_meta_blocks, error reading bitmap block number %d at %ld\n", i, SB_AP_BITMAP(s)[i]->b_blocknr) ;
+    ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i].bh)) ;
+    wait_on_buffer(SB_AP_BITMAP(s)[i].bh) ;
+    if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
+      printk("reread_meta_blocks, error reading bitmap block number %d at
+      %ld\n", i, SB_AP_BITMAP(s)[i].bh->b_blocknr) ;
       return 1 ;
     }
   }
@@ -1033,7 +1113,12 @@
 
     memset (&s->u.reiserfs_sb, 0, sizeof (struct reiserfs_sb_info));
 
-    if (reiserfs_parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
+    /* Set default values for options: non-aggressive tails */
+    s->u.reiserfs_sb.s_mount_opt = ( 1 << REISERFS_SMALLTAIL );
+    /* default block allocator option: skip_busy */
+    s->u.reiserfs_sb.s_alloc_options.bits = ( 1 << 5);
+
+    if (reiserfs_parse_options (s, (char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
 	return NULL;
     }
 
@@ -1183,10 +1268,10 @@
     if (SB_DISK_SUPER_BLOCK (s)) {
 	for (j = 0; j < SB_BMAP_NR (s); j ++) {
 	    if (SB_AP_BITMAP (s))
-		brelse (SB_AP_BITMAP (s)[j]);
+		brelse (SB_AP_BITMAP (s)[j].bh);
 	}
 	if (SB_AP_BITMAP (s))
-	    reiserfs_kfree (SB_AP_BITMAP (s), sizeof (struct buffer_head *) * SB_BMAP_NR (s), s);
+	    vfree (SB_AP_BITMAP (s));
     }
     if (SB_BUFFER_WITH_SB (s))
 	brelse(SB_BUFFER_WITH_SB (s));
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Fri Aug  9 19:31:45 2002
+++ b/include/linux/reiserfs_fs.h	Fri Aug  9 19:31:45 2002
@@ -55,6 +55,7 @@
 #define USE_INODE_GENERATION_COUNTER
 
 #define REISERFS_PREALLOCATE
+#define DISPLACE_NEW_PACKING_LOCALITIES
 #define PREALLOCATION_SIZE 8
 
 /* n must be power of 2 */
@@ -184,7 +185,7 @@
    time cost for a 4 block file and saves an amount of space that is
    less significant as a percentage of space, or so goes the hypothesis.
    -Hans */
-#define STORE_TAIL_IN_UNFM(n_file_size,n_tail_size,n_block_size) \
+#define STORE_TAIL_IN_UNFM_S1(n_file_size,n_tail_size,n_block_size) \
 (\
   (!(n_tail_size)) || \
   (((n_tail_size) > MAX_DIRECT_ITEM_LEN(n_block_size)) || \
@@ -197,6 +198,18 @@
      ( (n_tail_size) >=   (MAX_DIRECT_ITEM_LEN(n_block_size) * 3)/4) ) ) \
 )
 
+/* Another strategy for tails, this one means only create a tail if all the
+   file would fit into one DIRECT item.
+   Primary intention for this one is to increase performance by decreasing
+   seeking.
+*/   
+#define STORE_TAIL_IN_UNFM_S2(n_file_size,n_tail_size,n_block_size) \
+(\
+  (!(n_tail_size)) || \
+  (((n_file_size) > MAX_DIRECT_ITEM_LEN(n_block_size)) ) \
+)
+
+
 
 /*
  * values for s_state field
@@ -1323,6 +1336,10 @@
 
   int fs_gen;                  /* saved value of `reiserfs_generation' counter
 			          see FILESYSTEM_CHANGED() macro in reiserfs_fs.h */
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+  struct key  key;	      /* key pointer, to pass to block allocator or
+				 another low-level subsystem */
+#endif
 } ;
 
 /* These are modes of balancing */
@@ -1558,7 +1575,7 @@
 int push_journal_writer(char *w) ;
 int pop_journal_writer(int windex) ;
 int journal_transaction_should_end(struct reiserfs_transaction_handle *, int) ;
-int reiserfs_in_journal(struct super_block *p_s_sb, kdev_t dev, unsigned long bl, int size, int searchall, unsigned long *next) ;
+int reiserfs_in_journal(struct super_block *p_s_sb, kdev_t dev, int bmap_nr, int bit_nr, int size, int searchall, unsigned int *next) ;
 int journal_begin(struct reiserfs_transaction_handle *, struct super_block *p_s_sb, unsigned long) ;
 struct super_block *reiserfs_get_super(kdev_t dev) ;
 void flush_async_commits(struct super_block *p_s_sb) ;
@@ -1706,8 +1723,8 @@
 #define file_size(inode) ((inode)->i_size)
 #define tail_size(inode) (file_size (inode) & (block_size (inode) - 1))
 
-#define tail_has_to_be_packed(inode) (!dont_have_tails ((inode)->i_sb) &&\
-!STORE_TAIL_IN_UNFM(file_size (inode), tail_size(inode), block_size (inode)))
+#define tail_has_to_be_packed(inode) (have_large_tails ((inode)->i_sb)?\
+!STORE_TAIL_IN_UNFM_S1(file_size (inode), tail_size(inode), block_size (inode)):have_small_tails ((inode)->i_sb)?!STORE_TAIL_IN_UNFM_S2(file_size (inode), tail_size(inode), block_size (inode)):0 )
 
 void padd_item (char * item, int total_length, int length);
 
@@ -1733,7 +1750,7 @@
 
 
 struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th, 
-				   const struct inode * dir, int mode, 
+				   struct inode * dir, int mode, 
 				   const char * symname, int item_len,
 				   struct dentry *dentry, struct inode *inode, int * err);
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode);
@@ -1909,22 +1926,87 @@
 struct buffer_head * get_FEB (struct tree_balance *);
 
 /* bitmap.c */
+
+/* structure contains hints for block allocator, and it is a container for
+ * arguments, such as node, search path, transaction_handle, etc. */
+ struct __reiserfs_blocknr_hint {
+     struct inode * inode;		/* inode passed to allocator, if we allocate unf. nodes */
+     long block;			/* file offset, in blocks */
+     struct key key;
+     struct path * path;		/* search path, used by allocator to deternine search_start by
+					 * various ways */
+     struct reiserfs_transaction_handle * th; /* transaction handle is needed to log super blocks and
+					       * bitmap blocks changes  */
+     b_blocknr_t beg, end;
+     b_blocknr_t search_start;		/* a field used to transfer search start value (block number)
+					 * between different block allocator procedures
+					 * (determine_search_start() and others) */
+    int prealloc_size;			/* is set in determine_prealloc_size() function, used by underlayed
+					 * function that do actual allocation */
+
+    int formatted_node:1;		/* the allocator uses different polices for getting disk space for
+					 * formatted/unformatted blocks with/without preallocation */
+    int preallocate:1;
+};
+
+typedef struct __reiserfs_blocknr_hint reiserfs_blocknr_hint_t;
+
+int reiserfs_parse_alloc_options (struct super_block *, char *);
 int is_reusable (struct super_block * s, unsigned long block, int bit_value);
 void reiserfs_free_block (struct reiserfs_transaction_handle *th, unsigned long);
-int reiserfs_new_blocknrs (struct reiserfs_transaction_handle *th,
-			   unsigned long * pblocknrs, unsigned long start_from, int amount_needed);
-int reiserfs_new_unf_blocknrs (struct reiserfs_transaction_handle *th,
-			       unsigned long * pblocknr, unsigned long start_from);
+int reiserfs_allocate_blocknrs(reiserfs_blocknr_hint_t *, b_blocknr_t * , int, int);
+extern inline int reiserfs_new_form_blocknrs (struct tree_balance * tb,
+					      b_blocknr_t *new_blocknrs, int amount_needed)
+{
+    reiserfs_blocknr_hint_t hint = {
+	th:tb->transaction_handle,
+	path: tb->tb_path,
+	inode: NULL,
+	key: tb->key,
+	block: 0,
+	formatted_node:1
+    };
+    return reiserfs_allocate_blocknrs(&hint, new_blocknrs, amount_needed, 0);
+}
+
+extern inline int reiserfs_new_unf_blocknrs (struct reiserfs_transaction_handle *th,
+					     b_blocknr_t *new_blocknrs,
+					     struct path * path, long block)
+{
+    reiserfs_blocknr_hint_t hint = {
+	th: th,
+	path: path,
+	inode: NULL,
+	block: block,
+	formatted_node: 0,
+	preallocate: 0
+    };
+    return reiserfs_allocate_blocknrs(&hint, new_blocknrs, 1, 0);
+}
+
 #ifdef REISERFS_PREALLOCATE
-int reiserfs_new_unf_blocknrs2 (struct reiserfs_transaction_handle *th, 
-				struct inode * inode,
-				unsigned long * pblocknr, 
-				unsigned long start_from);
+extern inline int reiserfs_new_unf_blocknrs2(struct reiserfs_transaction_handle *th,
+					     struct inode * inode,
+					     b_blocknr_t *new_blocknrs,
+					     struct path * path, long block)
+{
+    reiserfs_blocknr_hint_t hint = {
+	th: th,
+	path: path,
+	inode: inode,
+	block: block,
+	formatted_node: 0,
+	preallocate: 1
+    };
+    return reiserfs_allocate_blocknrs(&hint, new_blocknrs, 1, 0);
+}
 
 void reiserfs_discard_prealloc (struct reiserfs_transaction_handle *th, 
 				struct inode * inode);
 void reiserfs_discard_all_prealloc (struct reiserfs_transaction_handle *th);
 #endif
+void reiserfs_claim_blocks_to_be_allocated( struct super_block *sb, int blocks);
+void reiserfs_release_claimed_blocks( struct super_block *sb, int blocks);
 
 /* hashes.c */
 __u32 keyed_hash (const signed char *msg, int len);
diff -Nru a/include/linux/reiserfs_fs_i.h b/include/linux/reiserfs_fs_i.h
--- a/include/linux/reiserfs_fs_i.h	Fri Aug  9 19:31:45 2002
+++ b/include/linux/reiserfs_fs_i.h	Fri Aug  9 19:31:45 2002
@@ -44,6 +44,10 @@
     struct list_head i_prealloc_list;	/* per-transaction list of inodes which
 					 * have preallocated blocks */
   
+    int new_packing_locality:1;		/* new_packig_locality is created; new blocks
+					 * for the contents of this directory should be
+					 * displaced */
+
     /* we use these for fsync or O_SYNC to decide which transaction
     ** needs to be committed in order for this inode to be properly
     ** flushed */
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Fri Aug  9 19:31:45 2002
+++ b/include/linux/reiserfs_fs_sb.h	Fri Aug  9 19:31:45 2002
@@ -241,6 +241,8 @@
   unsigned long t_trans_id ;    /* sanity check, equals the current trans id */
   struct super_block *t_super ; /* super for this FS when journal_begin was 
                                    called. saves calls to reiserfs_get_super */
+  int displace_new_blocks:1;	/* if new block allocation occurres, that block
+				   should be displaced from others */
 } ;
 
 /*
@@ -324,6 +326,14 @@
 
 typedef __u32 (*hashf_t) (const signed char *, int);
 
+struct reiserfs_bitmap_info
+{
+    // FIXME: Won't work with block sizes > 8K
+    __u16  first_zero_hint;
+    __u16  free_count;
+    struct buffer_head *bh; /* the actual bitmap */
+};
+
 struct proc_dir_entry;
 
 #if defined( CONFIG_PROC_FS ) && defined( CONFIG_REISERFS_PROC_INFO )
@@ -368,14 +378,15 @@
   stat_cnt_t need_r_neighbor[ 5 ];
 
   stat_cnt_t free_block;
-  struct __find_forward_stats {
+  struct __scan_bitmap_stats {
 	stat_cnt_t call;
 	stat_cnt_t wait;
 	stat_cnt_t bmap;
 	stat_cnt_t retry;
 	stat_cnt_t in_journal_hint;
-	stat_cnt_t in_journal_out;
-  } find_forward;
+	stat_cnt_t in_journal_nohint;
+	stat_cnt_t stolen;
+  } scan_bitmap;
   struct __journal_stats {
 	stat_cnt_t in_journal;
 	stat_cnt_t in_journal_bitmap;
@@ -405,7 +416,7 @@
 				/* both the comment and the choice of
                                    name are unclear for s_rs -Hans */
     struct reiserfs_super_block * s_rs;           /* Pointer to the super block in the buffer */
-    struct buffer_head ** s_ap_bitmap;       /* array of buffers, holding block bitmap */
+    struct reiserfs_bitmap_info * s_ap_bitmap;
     struct reiserfs_journal *s_journal ;		/* pointer to journal information */
     unsigned short s_mount_state;                 /* reiserfs state (valid, invalid) */
   
@@ -418,6 +429,16 @@
                                    here (currently - NOTAIL, NOLOG,
                                    REPLAYONLY) */
 
+    struct {			/* This is a structure that describes block allocator options */
+	unsigned long bits;	/* Bitfield for enable/disable kind of options */
+	unsigned long large_file_size; /* size started from which we consider file to be a large one(in blocks) */
+	int border;		/* percentage of disk, border takes */
+	int preallocmin;	/* Minimal file size (in blocks) starting from which we do preallocations */
+	int preallocsize;	/* Number of blocks we try to prealloc when file
+				   reaches preallocmin size (in blocks) or
+				   prealloc_list is empty. */
+    } s_alloc_options;
+
 				/* Comment? -Hans */
     wait_queue_head_t s_wait;
 				/* To be obsoleted soon by per buffer seals.. -Hans */
@@ -444,6 +465,7 @@
     int s_is_unlinked_ok;
     reiserfs_proc_info_data_t s_proc_info_data;
     struct proc_dir_entry *procdir;
+    int reserved_blocks; /* amount of blocks reserved for further allocations */
 };
 
 /* Definitions of reiserfs on-disk properties: */
@@ -451,7 +473,8 @@
 #define REISERFS_3_6 1
 
 /* Mount options */
-#define NOTAIL 0  /* -o notail: no tails will be created in a session */
+#define REISERFS_LARGETAIL 0  /* large tails will be created in a session */
+#define REISERFS_SMALLTAIL 17  /* small (for files less than block size) tails will be created in a session */
 #define REPLAYONLY 3 /* replay journal and return 0. Use by fsck */
 #define REISERFS_NOLOG 4      /* -o nolog: turn journalling off */
 #define REISERFS_CONVERT 5    /* -o conv: causes conversion of old
@@ -499,7 +522,8 @@
 #define reiserfs_hashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
 #define reiserfs_test4(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_TEST4))
 
-#define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
+#define have_large_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_LARGETAIL))
+#define have_small_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_SMALLTAIL))
 #define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
 #define reiserfs_dont_log(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NOLOG))
 #define reiserfs_attrs(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_ATTRS))
