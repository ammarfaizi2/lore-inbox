Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbSLNNvm>; Sat, 14 Dec 2002 08:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSLNNvm>; Sat, 14 Dec 2002 08:51:42 -0500
Received: from angband.namesys.com ([212.16.7.85]:10368 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267613AbSLNNve>; Sat, 14 Dec 2002 08:51:34 -0500
Date: Sat, 14 Dec 2002 16:21:08 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
Message-ID: <20021214162108.A3452@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFA53DA.DE6788C1@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Dec 13, 2002 at 01:40:42PM -0800, Andrew Morton wrote:

> This seems wrong.  This could be a newly-allocated pagecache page.  It is not
> yet fully uptodate.  If (say) the subsequent copy_from_user gets a fault then
> it appears that this now-uptodate pagecache page will leak uninitialised stuff?

Ok, after all I think we do not need this uptodate stuff at all.

Find below the patch that address all the issues you've brought.
It is on top of previous one.
Do you think it is ok now?

Bye,
    Oleg

===== fs/reiserfs/bitmap.c 1.25 vs edited =====
--- 1.25/fs/reiserfs/bitmap.c	Sat Dec  7 17:08:04 2002
+++ edited/fs/reiserfs/bitmap.c	Sat Dec 14 14:48:15 2002
@@ -913,7 +913,7 @@
 	unsigned long space;
 
 	spin_lock(&REISERFS_SB(sb)->bitmap_lock);
-	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) / ( PAGE_CACHE_SIZE/sb->s_blocksize);
+	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) >> ( PAGE_CACHE_SHIFT - sb->s_blocksize_bits);
 	spin_unlock(&REISERFS_SB(sb)->bitmap_lock);
 
 	return space;
===== fs/reiserfs/do_balan.c 1.16 vs edited =====
--- 1.16/fs/reiserfs/do_balan.c	Sat Dec  7 13:37:19 2002
+++ edited/fs/reiserfs/do_balan.c	Sat Dec 14 15:35:55 2002
@@ -341,7 +341,7 @@
 		    version = ih_version (ih);
 
 		    /* Calculate key component, item length and body to insert into S[0] */
-                    set_le_ih_k_offset( ih, le_ih_k_offset( ih ) + tb->lbytes * (is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1) );
+                    set_le_ih_k_offset( ih, le_ih_k_offset( ih ) + (tb->lbytes >> (is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize_bits - UNFM_P_SHIFT:0)) );
 
 		    put_ih_item_len( ih, new_item_len );
 		    if ( tb->lbytes >  zeros_num ) {
@@ -463,7 +463,7 @@
 					"PAP-12107: items must be of the same file");
 				if (is_indirect_le_ih(B_N_PITEM_HEAD (tb->L[0],
 								      n + item_pos - ret_val)))	{
-				    temp_l = (l_n / UNFM_P_SIZE) * tb->tb_sb->s_blocksize;
+				    temp_l = (l_n / UNFM_P_SIZE) << tb->tb_sb->s_blocksize_bits;
 				}
 				/* update key of first item in S0 */
 				version = ih_version (B_N_PITEM_HEAD (tbS0, 0));
@@ -581,7 +581,7 @@
 		    old_len = ih_item_len(ih);
 
 		    /* Calculate key component and item length to insert into R[0] */
-                    offset = le_ih_k_offset( ih ) + (old_len - tb->rbytes )*(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1);
+                    offset = le_ih_k_offset( ih ) + ((old_len - tb->rbytes )>>(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize_bits - UNFM_P_SHIFT:0));
                     set_le_ih_k_offset( ih, offset );
 		    put_ih_item_len( ih, tb->rbytes);
 		    /* Insert part of the item into R[0] */
@@ -710,8 +710,8 @@
 			  
 			  version = ih_version (B_N_PITEM_HEAD (tb->R[0],0));
 			  if (is_indirect_le_key(version,B_N_PKEY(tb->R[0],0))){
-			      temp_rem = (n_rem / UNFM_P_SIZE) * 
-			                 tb->tb_sb->s_blocksize;
+			      temp_rem = n_rem >> (tb->tb_sb->s_blocksize -
+					 UNFM_P_SHIFT);
 			  }
 			  set_le_key_k_offset (version, B_N_PKEY(tb->R[0],0), 
 					       le_key_k_offset (version, B_N_PKEY(tb->R[0],0)) + temp_rem);
@@ -870,7 +870,7 @@
 
 		    /* Calculate key component and item length to insert into S_new[i] */
                     set_le_ih_k_offset( ih,
-                                le_ih_k_offset(ih) + (old_len - sbytes[i] )*(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1) );
+                                le_ih_k_offset(ih) + ((old_len - sbytes[i] )>>(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize_bits - UNFM_P_SHIFT:0)) );
 
 		    put_ih_item_len( ih, sbytes[i] );
 
@@ -1009,8 +1009,7 @@
 			    if (is_indirect_le_ih (tmp)) {
 				set_ih_free_space (tmp, 0);
 				set_le_ih_k_offset( tmp, le_ih_k_offset(tmp) + 
-					            (n_rem / UNFM_P_SIZE) *
-						    tb->tb_sb->s_blocksize);
+					            (n_rem >> (tb->tb_sb->s_blocksize_bits - UNFM_P_SHIFT)));
 			    } else {
 				set_le_ih_k_offset( tmp, le_ih_k_offset(tmp) + 
 				                    n_rem );
===== fs/reiserfs/file.c 1.19 vs edited =====
--- 1.19/fs/reiserfs/file.c	Sat Dec  7 17:08:04 2002
+++ edited/fs/reiserfs/file.c	Sat Dec 14 16:19:50 2002
@@ -142,15 +142,11 @@
     return error ;
 }
 
-/* this function from inode.c would be used here, too */
-extern void restart_transaction(struct reiserfs_transaction_handle *th,
-                                struct inode *inode, struct path *path);
-
 /* I really do not want to play with memory shortage right now, so
    to simplify the code, we are not going to write more than this much pages at
    a time. This still should considerably improve performance compared to 4k
-   at a time case. */
-#define REISERFS_WRITE_PAGES_AT_A_TIME 32
+   at a time case. This is 32 pages of 4k size. */
+#define REISERFS_WRITE_PAGES_AT_A_TIME (128 * 1024) / PAGE_CACHE_SIZE
 
 /* Allocates blocks for a file to fulfil write request.
    Maps all unmapped but prepared pages from the list.
@@ -217,7 +213,7 @@
     hint.inode = inode; // Inode is needed by block allocator too.
     hint.search_start = 0; // We have no hint on where to search free blocks for block allocator.
     hint.key = key.on_disk_key; // on disk key of file.
-    hint.block = inode->i_blocks/(inode->i_sb->s_blocksize/512); // Number of disk blocks this file occupies already.
+    hint.block = inode->i_blocks>>(inode->i_sb->s_blocksize_bits-9); // Number of disk blocks this file occupies already.
     hint.formatted_node = 0; // We are allocating blocks for unformatted node.
     hint.preallocate = 0; // We do not do any preallocation for now.
 
@@ -346,7 +342,7 @@
 		    restart_transaction(&th, inode, &path);
 
 		/* Well, need to recalculate path and stuff */
-		set_cpu_key_k_offset( &key, cpu_key_k_offset(&key) + to_paste * inode->i_sb->s_blocksize );
+		set_cpu_key_k_offset( &key, cpu_key_k_offset(&key) + (to_paste << inode->i_blkbits));
 		res = search_for_position_by_key(inode->i_sb, &key, &path);
 		if ( res == IO_ERROR ) {
 		    res = -EIO;
@@ -492,7 +488,7 @@
     }
 
     /* Amount of on-disk blocks used by file have changed, update it */
-    inode->i_blocks += blocks_to_allocate * (inode->i_sb->s_blocksize / 512);
+    inode->i_blocks += blocks_to_allocate << (inode->i_blkbits - 9);
     reiserfs_update_sd(&th, inode); // And update on-disk metadata
     // finish all journal stuff now, We are not going to play with metadata
     // anymore.
@@ -775,18 +771,18 @@
     if ( num_pages > 2 )
 	/* These are full-overwritten pages so we count all the blocks in
 	   these pages are counted as needed to be allocated */
-	blocks = (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize) * (num_pages - 2);
+	blocks = (num_pages - 2) << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 
     /* count blocks needed for first page (possibly partially written) */
-    blocks += ((PAGE_CACHE_SIZE - from) >> inode->i_sb->s_blocksize_bits) +
+    blocks += ((PAGE_CACHE_SIZE - from) >> inode->i_blkbits) +
 	   !!(from & (inode->i_sb->s_blocksize-1)); /* roundup */
 
     /* Now we account for last page. If last page == first page (we
        overwrite only one page), we substract all the blocks past the
        last writing position in a page out of already calculated number
        of blocks */
-    blocks += (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize) * (num_pages > 1) -
-	   ((PAGE_CACHE_SIZE - to) >> inode->i_sb->s_blocksize_bits);
+    blocks += ((num_pages > 1) << (PAGE_CACHE_SHIFT-inode->i_blkbits)) -
+	   ((PAGE_CACHE_SIZE - to) >> inode->i_blkbits);
 	   /* Note how we do not roundup here since partial blocks still
 		   should be allocated */
 
@@ -798,13 +794,11 @@
 	    char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
 	    memset(kaddr, 0, from);
 	    kunmap_atomic( kaddr, KM_USER0);
-	    SetPageUptodate(prepared_pages[0]);
 	}
 	if ( to != PAGE_CACHE_SIZE ) { /* Last page needs to be partially zeroed */
 	    char *kaddr = kmap_atomic(prepared_pages[num_pages-1], KM_USER0);
 	    memset(kaddr+to, 0, PAGE_CACHE_SIZE - to);
 	    kunmap_atomic( kaddr, KM_USER0);
-	    SetPageUptodate(prepared_pages[num_pages-1]);
 	}
 
 	/* Since all blocks are new - use already calculated value */
@@ -921,7 +915,7 @@
 			char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
 			memset(kaddr+block_start, 0, from-block_start);
 			kunmap_atomic( kaddr, KM_USER0);
-			set_bit(BH_Uptodate, &bh->b_state);
+			set_buffer_uptodate(bh);
 		    }
 		}
 	    }
@@ -953,7 +947,7 @@
 			char *kaddr = kmap_atomic(prepared_pages[num_pages-1], KM_USER0);
 			memset(kaddr+to, 0, block_end-to);
 			kunmap_atomic( kaddr, KM_USER0);
-			set_bit(BH_Uptodate, &bh->b_state);
+			set_buffer_uptodate(bh);
 		    }
 		}
 	    }
@@ -1127,7 +1121,7 @@
 	       for this iteration. */
 	    num_pages = min_t(int, REISERFS_WRITE_PAGES_AT_A_TIME, reiserfs_can_fit_pages(inode->i_sb));
 	    /* Also we should not forget to set size in bytes accordingly */
-	    write_bytes = num_pages * PAGE_CACHE_SIZE - 
+	    write_bytes = (num_pages << PAGE_CACHE_SHIFT) - 
 			    (pos & (PAGE_CACHE_SIZE-1));
 					 /* If position is not on the
 					    start of the page, we need
@@ -1138,7 +1132,7 @@
 
 	/* reserve the blocks to be allocated later, so that later on
 	   we still have the space to write the blocks to */
-	reiserfs_claim_blocks_to_be_allocated(inode->i_sb, num_pages * (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize));
+	reiserfs_claim_blocks_to_be_allocated(inode->i_sb, num_pages << (PAGE_CACHE_SHIFT - inode->i_blkbits));
 	reiserfs_write_unlock(inode->i_sb);
 
 	if ( !num_pages ) { /* If we do not have enough space even for */
@@ -1162,12 +1156,12 @@
 	blocks_to_allocate = reiserfs_prepare_file_region_for_write(inode, pos, num_pages, write_bytes, prepared_pages);
 	if ( blocks_to_allocate < 0 ) {
 	    res = blocks_to_allocate;
-	    reiserfs_release_claimed_blocks(inode->i_sb, num_pages * (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize));
+	    reiserfs_release_claimed_blocks(inode->i_sb, num_pages << (PAGE_CACHE_SHIFT - inode->i_blkbits));
 	    break;
 	}
 
 	/* First we correct our estimate of how many blocks we need */
-	reiserfs_release_claimed_blocks(inode->i_sb, num_pages * (PAGE_CACHE_SIZE>>inode->i_sb->s_blocksize_bits) - blocks_to_allocate );
+	reiserfs_release_claimed_blocks(inode->i_sb, (num_pages << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits)) - blocks_to_allocate );
 
 	if ( blocks_to_allocate > 0) {/*We only allocate blocks if we need to*/
 	    /* Fill in all the possible holes and append the file if needed */
===== fs/reiserfs/inode.c 1.70 vs edited =====
--- 1.70/fs/reiserfs/inode.c	Sat Dec  7 17:08:04 2002
+++ edited/fs/reiserfs/inode.c	Sat Dec 14 14:59:00 2002
@@ -816,7 +816,7 @@
 		/* We need to mark new file size in case this function will be
 		   interrupted/aborted later on. And we may do this only for
 		   holes. */
-		inode->i_size += inode->i_sb->s_blocksize * blocks_needed;
+		inode->i_size += blocks_needed << inode->i_blkbits;
 	    }
 	    //mark_tail_converted (inode);
 	}
===== include/linux/reiserfs_fs.h 1.46 vs edited =====
--- 1.46/include/linux/reiserfs_fs.h	Sat Dec  7 17:08:04 2002
+++ edited/include/linux/reiserfs_fs.h	Sat Dec 14 16:08:21 2002
@@ -1268,6 +1268,7 @@
 
 /* Size of pointer to the unformatted node. */
 #define UNFM_P_SIZE (sizeof(unp_t))
+#define UNFM_P_SHIFT 2
 
 // in in-core inode key is stored on le form
 #define INODE_PKEY(inode) ((struct key *)(REISERFS_I(inode)->i_key))
@@ -1838,7 +1839,7 @@
 void padd_item (char * item, int total_length, int length);
 
 /* inode.c */
-
+void restart_transaction(struct reiserfs_transaction_handle *th, struct inode *inode, struct path *path);
 void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
