Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319105AbSIJNKq>; Tue, 10 Sep 2002 09:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319110AbSIJNKq>; Tue, 10 Sep 2002 09:10:46 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60170 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319105AbSIJNKZ>; Tue, 10 Sep 2002 09:10:25 -0400
Message-ID: <3D7DF05E.7030903@namesys.com>
Date: Tue, 10 Sep 2002 17:15:10 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, green@namesys.com
Subject: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at
 a time)
Content-Type: multipart/mixed;
 boundary="------------070607000106040700090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607000106040700090100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  This patch should only go in if 2.4.20 is 3 weeks or more away, 
otherwise it should wait for the next pre1.

It passes all of our testing, but it is the kind of code that is more 
likely than most to have elusive lurking bugs.  It cannot be tested in 
2.5 first because 2.5 is too broken at this particular moment.  For the 
lkml readers let me say that it also should not go onto any distros 
without three weeks of testing.;-)

It substantially reduces CPU consumption for large writes.  It does so 
by finally ridding the code of that 4k at a time write loop that 
performed a balancing operation and a block allocation for each 4k 
written.   This might be the last substantial patch from Namesys before 
V4.:)  Chris still has some patches that are substantive though which I 
hope he sends in very soon...

It also contains some trivial fixes in the second of the attachments 
from Oleg.

    Adding back mistakenly forgotten "attrs" mount option, fix a problem
    with displacing_large_files allocator option and fix a bug in remounting
    code on remount from readwarite to readwrite mode that can cause livelock
    if there was delayed unlinks scheduled on the filesystem.


Marcelo, since you know how long it will be until 2.4.20, you should 
decide if it will go in.  

Hans

--------------070607000106040700090100
Content-Type: message/rfc822;
 name="changesets for Marcelo (README changes removed)."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changesets for Marcelo (README changes removed)."

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 2571 invoked from network); 10 Sep 2002 12:53:35 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Sep 2002 12:53:35 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 1A583230776; Tue, 10 Sep 2002 16:24:53 +0400 (MSD)
Date: Tue, 10 Sep 2002 16:24:53 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: changesets for Marcelo (README changes removed).
Message-ID: <20020910162452.A7298@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello!

    two mail bodies attached.
    mail1 is reiserfs_file_write stuff.
    mail2 si trivial stuff.

Bye,
    Oleg

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=mail1

Hello!

   These 3 changesets introduce reiserfs_file_write() function
   (split into two parts: multiple unformatted pointers insertion and
   reiserfs_file_write implementation itself.) and export three kernel functions
   that are needed for this implementation (generic_osync_inode,
   block_commit_write, remove_suid).
   This code was tested and is believed to contain no critical bugs as of now.

   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

   Please apply.

Diffstats:

 do_balan.c        |  105 +++++++++++++++++++++++++++---------------------------
 inode.c           |   47 ++++++++++++++++++++----
 tail_conversion.c |    5 +-
 3 files changed, 95 insertions(+), 62 deletions(-)

 fs/reiserfs/bitmap.c           |   20
 fs/reiserfs/file.c             | 1076 ++++++++++++++++++++++++++++++++++++++++-
 fs/reiserfs/inode.c            |    4
 fs/reiserfs/super.c            |    1
 include/linux/reiserfs_fs.h    |    1
 include/linux/reiserfs_fs_sb.h |    1
 6 files changed, 1099 insertions(+), 4 deletions(-)

 kernel/ksyms.c |    3 +++
 mm/filemap.c   |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Plain text patches:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.589   -> 1.590  
#	fs/reiserfs/do_balan.c	1.10    -> 1.11   
#	 fs/reiserfs/inode.c	1.35    -> 1.36   
#	fs/reiserfs/tail_conversion.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	green@angband.namesys.com	1.590
# Added support for unformatted pointers insertion. Implement hole-creation using this new mechanism which is much faster.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/do_balan.c b/fs/reiserfs/do_balan.c
--- a/fs/reiserfs/do_balan.c	Mon Sep  9 09:28:25 2002
+++ b/fs/reiserfs/do_balan.c	Mon Sep  9 09:28:25 2002
@@ -304,8 +304,6 @@
 		    int new_item_len;
 		    int version;
 
-		    RFALSE (!is_direct_le_ih (ih),
-			    "PAP-12075: only direct inserted item can be broken. %h", ih);
 		    ret_val = leaf_shift_left (tb, tb->lnum[0]-1, -1);
 
 		    /* Calculate item length to insert to S[0] */
@@ -328,7 +326,7 @@
 		    version = ih_version (ih);
 
 		    /* Calculate key component, item length and body to insert into S[0] */
-                    set_le_ih_k_offset( ih, le_ih_k_offset( ih ) + tb->lbytes );
+                    set_le_ih_k_offset( ih, le_ih_k_offset( ih ) + tb->lbytes * (is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1) );
 
 		    put_ih_item_len( ih, new_item_len );
 		    if ( tb->lbytes >  zeros_num ) {
@@ -437,23 +435,28 @@
 				ih_item_len( B_N_PITEM_HEAD(tb->L[0],n+item_pos-ret_val)),
 				l_n,body, zeros_num > l_n ? l_n : zeros_num
 				);
-
-			    RFALSE( l_n && 
-				    is_indirect_le_ih(B_N_PITEM_HEAD
-						      (tb->L[0],
-						       n + item_pos - ret_val)),
-				    "PAP-12110: pasting more than 1 unformatted node pointer into indirect item");
-
 			    /* 0-th item in S0 can be only of DIRECT type when l_n != 0*/
 			    {
-			      int version;
-
-			      version = ih_version (B_N_PITEM_HEAD (tbS0, 0));
-			      set_le_key_k_offset (version, B_N_PKEY (tbS0, 0), 
-						   le_key_k_offset (version, B_N_PKEY (tbS0, 0)) + l_n);
-			      version = ih_version (B_N_PITEM_HEAD(tb->CFL[0],tb->lkey[0]));
-			      set_le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFL[0],tb->lkey[0]),
-						   le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFL[0],tb->lkey[0])) + l_n);
+				int version;
+				int temp_l = l_n;
+				
+				RFALSE (ih_item_len (B_N_PITEM_HEAD (tbS0, 0)),
+					"PAP-12106: item length must be 0");
+				RFALSE (comp_short_le_keys (B_N_PKEY (tbS0, 0),
+							    B_N_PKEY (tb->L[0],
+									    n + item_pos - ret_val)),
+					"PAP-12107: items must be of the same file");
+				if (is_indirect_le_ih(B_N_PITEM_HEAD (tb->L[0],
+								      n + item_pos - ret_val)))	{
+				    temp_l = (l_n / UNFM_P_SIZE) * tb->tb_sb->s_blocksize;
+				}
+				/* update key of first item in S0 */
+				version = ih_version (B_N_PITEM_HEAD (tbS0, 0));
+				set_le_key_k_offset (version, B_N_PKEY (tbS0, 0), 
+						     le_key_k_offset (version, B_N_PKEY (tbS0, 0)) + temp_l);
+				/* update left delimiting key */
+				set_le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFL[0],tb->lkey[0]),
+						     le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFL[0],tb->lkey[0])) + temp_l);
 			    }
 
 			    /* Calculate new body, position in item and insert_size[0] */
@@ -522,7 +525,7 @@
 			    );
 		    /* if appended item is indirect item, put unformatted node into un list */
 		    if (is_indirect_le_ih (pasted))
-			set_ih_free_space (pasted, ((struct unfm_nodeinfo*)body)->unfm_freespace);
+			set_ih_free_space (pasted, 0);
 		    tb->insert_size[0] = 0;
 		    zeros_num = 0;
 		}
@@ -550,15 +553,11 @@
 	    { /* new item or its part falls to R[0] */
 		if ( item_pos == n - tb->rnum[0] + 1 && tb->rbytes != -1 )
 		{ /* part of new item falls into R[0] */
-		    int old_key_comp, old_len, r_zeros_number;
+		    loff_t old_key_comp, old_len, r_zeros_number;
 		    const char * r_body;
 		    int version;
 		    loff_t offset;
 
-		    RFALSE( !is_direct_le_ih (ih),
-			    "PAP-12135: only direct item can be split. (%h)", 
-			    ih);
-
 		    leaf_shift_right(tb,tb->rnum[0]-1,-1);
 
 		    version = ih_version(ih);
@@ -567,7 +566,7 @@
 		    old_len = ih_item_len(ih);
 
 		    /* Calculate key component and item length to insert into R[0] */
-                    offset = le_ih_k_offset( ih ) + (old_len - tb->rbytes );
+                    offset = le_ih_k_offset( ih ) + (old_len - tb->rbytes )*(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1);
                     set_le_ih_k_offset( ih, offset );
 		    put_ih_item_len( ih, tb->rbytes);
 		    /* Insert part of the item into R[0] */
@@ -575,13 +574,13 @@
 		    bi.bi_bh = tb->R[0];
 		    bi.bi_parent = tb->FR[0];
 		    bi.bi_position = get_right_neighbor_position (tb, 0);
-		    if ( offset - old_key_comp > zeros_num ) {
+		    if ( (old_len - tb->rbytes) > zeros_num ) {
 			r_zeros_number = 0;
-			r_body = body + offset - old_key_comp - zeros_num;
+			r_body = body + (old_len - tb->rbytes) - zeros_num;
 		    }
 		    else {
 			r_body = body;
-			r_zeros_number = zeros_num - (offset - old_key_comp);
+			r_zeros_number = zeros_num - (old_len - tb->rbytes);
 			zeros_num -= r_zeros_number;
 		    }
 
@@ -692,12 +691,17 @@
 			
 			{
 			  int version;
+			  unsigned long temp_rem = n_rem;
 			  
 			  version = ih_version (B_N_PITEM_HEAD (tb->R[0],0));
+			  if (is_indirect_le_key(version,B_N_PKEY(tb->R[0],0))){
+			      temp_rem = (n_rem / UNFM_P_SIZE) * 
+			                 tb->tb_sb->s_blocksize;
+			  }
 			  set_le_key_k_offset (version, B_N_PKEY(tb->R[0],0), 
-					       le_key_k_offset (version, B_N_PKEY(tb->R[0],0)) + n_rem);
+					       le_key_k_offset (version, B_N_PKEY(tb->R[0],0)) + temp_rem);
 			  set_le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFR[0],tb->rkey[0]), 
-					       le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFR[0],tb->rkey[0])) + n_rem);
+					       le_key_k_offset (version, B_N_PDELIM_KEY(tb->CFR[0],tb->rkey[0])) + temp_rem);
 			}
 /*		  k_offset (B_N_PKEY(tb->R[0],0)) += n_rem;
 		  k_offset (B_N_PDELIM_KEY(tb->CFR[0],tb->rkey[0])) += n_rem;*/
@@ -721,13 +725,12 @@
 			leaf_paste_in_buffer(&bi, 0, n_shift, tb->insert_size[0] - n_rem, r_body, r_zeros_number);
 
 			if (is_indirect_le_ih (B_N_PITEM_HEAD(tb->R[0],0))) {
-
+#if 0
 			    RFALSE( n_rem,
 				    "PAP-12160: paste more than one unformatted node pointer");
-
-			    set_ih_free_space (B_N_PITEM_HEAD(tb->R[0],0), ((struct unfm_nodeinfo*)body)->unfm_freespace);
+#endif
+			    set_ih_free_space (B_N_PITEM_HEAD(tb->R[0],0), 0);
 			}
-
 			tb->insert_size[0] = n_rem;
 			if ( ! n_rem )
 			    pos_in_item ++;
@@ -766,7 +769,7 @@
 		    }
 
 		    if (is_indirect_le_ih (pasted))
-			set_ih_free_space (pasted, ((struct unfm_nodeinfo*)body)->unfm_freespace);
+			set_ih_free_space (pasted, 0);
 		    zeros_num = tb->insert_size[0] = 0;
 		}
 	    }
@@ -843,12 +846,6 @@
 		    const char * r_body;
 		    int version;
 
-		    RFALSE( !is_direct_le_ih(ih),
-			/* The items which can be inserted are:
-			   Stat_data item, direct item, indirect item and directory item which consist of only two entries "." and "..".
-			   These items must not be broken except for a direct one. */
-			    "PAP-12205: non-direct item can not be broken when inserting");
-
 		    /* Move snum[i]-1 items from S[0] to S_new[i] */
 		    leaf_move_items (LEAF_FROM_S_TO_SNEW, tb, snum[i] - 1, -1, S_new[i]);
 		    /* Remember key component and item length */
@@ -858,7 +855,7 @@
 
 		    /* Calculate key component and item length to insert into S_new[i] */
                     set_le_ih_k_offset( ih,
-                                le_ih_k_offset(ih) + (old_len - sbytes[i] ) );
+                                le_ih_k_offset(ih) + (old_len - sbytes[i] )*(is_indirect_le_ih(ih)?tb->tb_sb->s_blocksize/UNFM_P_SIZE:1) );
 
 		    put_ih_item_len( ih, sbytes[i] );
 
@@ -868,13 +865,13 @@
 		    bi.bi_parent = 0;
 		    bi.bi_position = 0;
 
-		    if ( le_ih_k_offset (ih) - old_key_comp > zeros_num ) {
+		    if ( (old_len - sbytes[i]) > zeros_num ) {
 			r_zeros_number = 0;
-			r_body = body + (le_ih_k_offset(ih) - old_key_comp) - zeros_num;
+			r_body = body + (old_len - sbytes[i]) - zeros_num;
 		    }
 		    else {
 			r_body = body;
-			r_zeros_number = zeros_num - (le_ih_k_offset (ih) - old_key_comp);
+			r_zeros_number = zeros_num - (old_len - sbytes[i]);
 			zeros_num -= r_zeros_number;
 		    }
 
@@ -995,11 +992,14 @@
 
 			    tmp = B_N_PITEM_HEAD(S_new[i],0);
 			    if (is_indirect_le_ih (tmp)) {
-				if (n_rem)
-				    reiserfs_panic (tb->tb_sb, "PAP-12230: balance_leaf: invalid action with indirect item");
-				set_ih_free_space (tmp, ((struct unfm_nodeinfo*)body)->unfm_freespace);
+				set_ih_free_space (tmp, 0);
+				set_le_ih_k_offset( tmp, le_ih_k_offset(tmp) + 
+					            (n_rem / UNFM_P_SIZE) *
+						    tb->tb_sb->s_blocksize);
+			    } else {
+				set_le_ih_k_offset( tmp, le_ih_k_offset(tmp) + 
+				                    n_rem );
 			    }
-                            set_le_ih_k_offset( tmp, le_ih_k_offset(tmp) + n_rem );
 			}
 
 			tb->insert_size[0] = n_rem;
@@ -1045,7 +1045,7 @@
 
 		    /* if we paste to indirect item update ih_free_space */
 		    if (is_indirect_le_ih (pasted))
-			set_ih_free_space (pasted, ((struct unfm_nodeinfo*)body)->unfm_freespace);
+			set_ih_free_space (pasted, 0);
 		    zeros_num = tb->insert_size[0] = 0;
 		}
 	    }
@@ -1141,11 +1141,12 @@
 		    leaf_paste_in_buffer (&bi, item_pos, pos_in_item, tb->insert_size[0], body, zeros_num);
 
 		    if (is_indirect_le_ih (pasted)) {
-
+#if 0
 			RFALSE( tb->insert_size[0] != UNFM_P_SIZE,
 				"PAP-12280: insert_size for indirect item must be %d, not %d",
 				UNFM_P_SIZE, tb->insert_size[0]);
-			set_ih_free_space (pasted, ((struct unfm_nodeinfo*)body)->unfm_freespace);
+#endif
+			set_ih_free_space (pasted, 0);
 		    }
 		    tb->insert_size[0] = 0;
 		}
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon Sep  9 09:28:25 2002
+++ b/fs/reiserfs/inode.c	Mon Sep  9 09:28:25 2002
@@ -774,36 +774,69 @@
 	       pointer to 'block'-th block use block, which is already
 	       allocated */
 	    struct cpu_key tmp_key;
-	    struct unfm_nodeinfo un = {0, 0};
+	    unp_t unf_single=0; // We use this in case we need to allocate only
+				// one block which is a fastpath
+	    unp_t *un;
+	    __u64 max_to_insert=MAX_ITEM_LEN(inode->i_sb->s_blocksize)/UNFM_P_SIZE;
+	    __u64 blocks_needed;
 
 	    RFALSE( pos_in_item != ih_item_len(ih) / UNFM_P_SIZE,
 		    "vs-804: invalid position for append");
+	    
 	    /* indirect item has to be appended, set up key of that position */
 	    make_cpu_key (&tmp_key, inode,
 			  le_key_k_offset (version, &(ih->ih_key)) + op_bytes_number (ih, inode->i_sb->s_blocksize),
 			  //pos_in_item * inode->i_sb->s_blocksize,
 			  TYPE_INDIRECT, 3);// key type is unimportant
-		  
-	    if (cpu_key_k_offset (&tmp_key) == cpu_key_k_offset (&key)) {
+
+	    blocks_needed = 1 + ((cpu_key_k_offset (&key) - cpu_key_k_offset (&tmp_key)) >> inode->i_sb->s_blocksize_bits);
+	    RFALSE( blocks_needed < 0, "green-805: invalid offset");
+
+	    if ( blocks_needed == 1 ) {
+		un = &unf_single;
+	    } else {
+		un=kmalloc( min(blocks_needed,max_to_insert)*UNFM_P_SIZE,
+			    GFP_ATOMIC); // We need to avoid scheduling.
+		if ( !un) {
+		    un = &unf_single;
+		    blocks_needed = 1;
+		    max_to_insert = 0;
+		} else 
+		    memset(un, 0, UNFM_P_SIZE * min(blocks_needed,max_to_insert));
+	    }
+	    if ( blocks_needed <= max_to_insert) {
 		/* we are going to add target block to the file. Use allocated
 		   block for that */
-		un.unfm_nodenum = cpu_to_le32 (allocated_block_nr);
+		un[blocks_needed-1] = cpu_to_le32 (allocated_block_nr);
 		set_block_dev_mapped (bh_result, allocated_block_nr, inode);
 		bh_result->b_state |= (1UL << BH_New);
 		done = 1;
 	    } else {
 		/* paste hole to the indirect item */
+		// If kmalloc failed, max_to_insert becomes zero and it means we
+		// only have space for one block
+		blocks_needed=max_to_insert?max_to_insert:1;
 	    }
-	    retval = reiserfs_paste_into_item (&th, &path, &tmp_key, (char *)&un, UNFM_P_SIZE);
+	    retval = reiserfs_paste_into_item (&th, &path, &tmp_key, (char *)un, UNFM_P_SIZE * blocks_needed);
+
+	    if (blocks_needed != 1)
+		kfree(un);
+
 	    if (retval) {
 		reiserfs_free_block (&th, allocated_block_nr);
 		goto failure;
 	    }
-	    if (un.unfm_nodenum)
+	    if (done) {
 		inode->i_blocks += inode->i_sb->s_blocksize / 512;
+	    } else {
+		// We need to mark new file size in case this function will be
+		// interrupted/aborted later on. And we may do this only for
+		// holes.
+		inode->i_size += inode->i_sb->s_blocksize * blocks_needed;
+	    }
 	    //mark_tail_converted (inode);
 	}
-		
+
 	if (done == 1)
 	    break;
 	 
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Mon Sep  9 09:28:25 2002
+++ b/fs/reiserfs/tail_conversion.c	Mon Sep  9 09:28:25 2002
@@ -30,7 +30,7 @@
                                 key of unfm pointer to be pasted */
     int	n_blk_size,
       n_retval;	  /* returned value for reiserfs_insert_item and clones */
-    struct unfm_nodeinfo unfm_ptr;  /* Handle on an unformatted node
+    unp_t unfm_ptr;  /* Handle on an unformatted node
 				       that will be inserted in the
 				       tree. */
 
@@ -59,8 +59,7 @@
     
     p_le_ih = PATH_PITEM_HEAD (path);
 
-    unfm_ptr.unfm_nodenum = cpu_to_le32 (unbh->b_blocknr);
-    unfm_ptr.unfm_freespace = 0; // ???
+    unfm_ptr = cpu_to_le32 (unbh->b_blocknr);
     
     if ( is_statdata_le_ih (p_le_ih) )  {
 	/* Insert new indirect item. */


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.590   -> 1.591  
#	  fs/reiserfs/file.c	1.9     -> 1.10   
#	 fs/reiserfs/inode.c	1.36    -> 1.37   
#	include/linux/reiserfs_fs.h	1.22    -> 1.23   
#	 fs/reiserfs/super.c	1.22    -> 1.23   
#	include/linux/reiserfs_fs_sb.h	1.12    -> 1.13   
#	fs/reiserfs/bitmap.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	green@angband.namesys.com	1.591
# Implemented reiserfs_file_write(), to write large amount of data at once into files on reiserfs volumes which should boost write speed somewhat and also should be somewhat more SMP friendly.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Mon Sep  9 09:28:34 2002
+++ b/fs/reiserfs/bitmap.c	Mon Sep  9 09:28:34 2002
@@ -738,7 +738,7 @@
     int rest = amount_needed;
     int nr_allocated;
 
-    while (rest > 0) {
+    while (rest > 0 && start <= finish) {
 	nr_allocated = scan_bitmap (hint->th, &start, finish, 1,
 				    rest + prealloc_size, !hint->formatted_node,
 				    hint->block);
@@ -884,7 +884,9 @@
     if ( !blocks )
 	return;
 
+    spin_lock(&sb->u.reiserfs_sb.bitmap_lock);
     sb->u.reiserfs_sb.reserved_blocks += blocks;
+    spin_unlock(&sb->u.reiserfs_sb.bitmap_lock);
 }
 
 /* Unreserve @blocks amount of blocks in fs pointed by @sb */
@@ -901,6 +903,22 @@
     if ( !blocks )
 	return;
 
+    spin_lock(&sb->u.reiserfs_sb.bitmap_lock);
     sb->u.reiserfs_sb.reserved_blocks -= blocks;
     RFALSE( sb->u.reiserfs_sb.reserved_blocks < 0, "amount of blocks reserved became zero?");
+    spin_unlock(&sb->u.reiserfs_sb.bitmap_lock);
+}
+
+/* This function estimates how much pages we will be able to write to FS
+   used for reiserfs_file_write() purposes for now. */
+int reiserfs_can_fit_pages ( struct super_block *sb /* superblock of filesystem
+						       to estimate space */ )
+{
+	unsigned long space;
+
+	spin_lock(&sb->u.reiserfs_sb.bitmap_lock);
+	space = (SB_FREE_BLOCKS(sb) - sb->u.reiserfs_sb.reserved_blocks) / ( PAGE_CACHE_SIZE/sb->s_blocksize);
+	spin_unlock(&sb->u.reiserfs_sb.bitmap_lock);
+
+	return space;
 }
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Mon Sep  9 09:28:34 2002
+++ b/fs/reiserfs/file.c	Mon Sep  9 09:28:34 2002
@@ -6,6 +6,9 @@
 #include <linux/sched.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+#include <linux/pagemap.h>
+#include <linux/locks.h>
 
 /*
 ** We pack the tails of files on file close, not at the time they are written.
@@ -129,9 +132,1080 @@
     return error ;
 }
 
+/* this function from inode.c would be used here, too */
+extern void restart_transaction(struct reiserfs_transaction_handle *th,
+                                struct inode *inode, struct path *path);
+
+/* I really do not want to play with memory shortage right now, so
+   to simplify the code, we are not going to write more than this much pages at
+   a time. This still should considerably improve performance compared to 4k
+   at a time case. */
+#define REISERFS_WRITE_PAGES_AT_A_TIME 32
+
+/* Allocates blocks for a file to fulfil write request.
+   Maps all unmapped but prepared pages from the list.
+   Updates metadata with newly allocated blocknumbers as needed */
+int reiserfs_allocate_blocks_for_region(
+				struct inode *inode, /* Inode we work with */
+				loff_t pos, /* Writing position */
+				int num_pages, /* number of pages write going
+						  to touch */
+				int write_bytes, /* amount of bytes to write */
+				struct page **prepared_pages, /* array of
+							         prepared pages
+							       */
+				int blocks_to_allocate /* Amount of blocks we
+							  need to allocate to
+							  fit the data into file
+							 */
+				)
+{
+    struct cpu_key key; // cpu key of item that we are going to deal with
+    struct item_head *ih; // pointer to item head that we are going to deal with
+    struct buffer_head *bh; // Buffer head that contains items that we are going to deal with
+    struct reiserfs_transaction_handle th; // transaction handle for transaction we are going to create.
+    __u32 * item; // pointer to item we are going to deal with
+    INITIALIZE_PATH(path); // path to item, that we are going to deal with.
+    b_blocknr_t allocated_blocks[blocks_to_allocate]; // Pointer to a place where allocated blocknumbers would be stored. Right now statically allocated, later that will change.
+    reiserfs_blocknr_hint_t hint; // hint structure for block allocator.
+    size_t res; // return value of various functions that we call.
+    int curr_block; // current block used to keep track of unmapped blocks.
+    int i; // loop counter
+    int itempos; // position in item
+    unsigned int from = (pos & (PAGE_CACHE_SIZE - 1)); // writing position in
+						       // first page
+    unsigned int to = ((pos + write_bytes - 1) & (PAGE_CACHE_SIZE - 1)) + 1; /* last modified byte offset in last page */
+    __u64 hole_size ; // amount of blocks for a file hole, if it needed to be created.
+    int modifying_this_item = 0; // Flag for items traversal code to keep track
+				 // of the fact that we already prepared
+				 // current block for journal
+
+
+    RFALSE(!blocks_to_allocate, "green-9004: tried to allocate zero blocks?");
+
+    /* First we compose a key to point at the writing position, we want to do
+       that outside of any locking region. */
+    make_cpu_key (&key, inode, pos+1, TYPE_ANY, 3/*key length*/);
+
+    /* If we came here, it means we absolutely need to open a transaction,
+       since we need to allocate some blocks */
+    lock_kernel(); // Journaling stuff and we need that.
+    journal_begin(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1); // Wish I know if this number enough
+    reiserfs_update_inode_transaction(inode) ;
+
+    /* Look for the in-tree position of our write, need path for block allocator */
+    res = search_for_position_by_key(inode->i_sb, &key, &path);
+    if ( res == IO_ERROR ) {
+	res = -EIO;
+	goto error_exit;
+    }
+   
+    /* Allocate blocks */
+    /* First fill in "hint" structure for block allocator */
+    hint.th = &th; // transaction handle.
+    hint.path = &path; // Path, so that block allocator can determine packing locality or whatever it needs to determine.
+    hint.inode = inode; // Inode is needed by block allocator too.
+    hint.search_start = 0; // We have no hint on where to search free blocks for block allocator.
+    hint.key = key.on_disk_key; // on disk key of file.
+    hint.block = inode->i_blocks/(inode->i_sb->s_blocksize/512); // Number of disk blocks this file occupies already.
+    hint.formatted_node = 0; // We are allocating blocks for unformatted node.
+    hint.preallocate = 0; // We do not do any preallocation for now.
+
+    /* Call block allocator to allocate blocks */
+    res = reiserfs_allocate_blocknrs(&hint, allocated_blocks, blocks_to_allocate, blocks_to_allocate);
+    if ( res != CARRY_ON ) {
+	if ( res == NO_DISK_SPACE ) {
+	    /* We flush the transaction in case of no space. This way some
+	       blocks might become free */
+	    SB_JOURNAL(inode->i_sb)->j_must_wait = 1;
+	    restart_transaction(&th, inode, &path);
+
+	    /* We might have scheduled, so search again */
+	    res = search_for_position_by_key(inode->i_sb, &key, &path);
+	    if ( res == IO_ERROR ) {
+		res = -EIO;
+		goto error_exit;
+	    }
+
+	    /* update changed info for hint structure. */
+	    res = reiserfs_allocate_blocknrs(&hint, allocated_blocks, blocks_to_allocate, blocks_to_allocate);
+	    if ( res != CARRY_ON ) {
+		res = -ENOSPC; 
+		pathrelse(&path);
+		goto error_exit;
+	    }
+	} else {
+	    res = -ENOSPC;
+	    pathrelse(&path);
+	    goto error_exit;
+	}
+    }
+
+#ifdef __BIG_ENDIAN
+        // Too bad, I have not found any way to convert a given region from
+        // cpu format to little endian format
+    {
+        int i;
+        for ( i = 0; i < blocks_to_allocate ; i++)
+            allocated_blocks[i]=cpu_to_le32(allocated_blocks[i]);
+    }
+#endif
+
+    /* Blocks allocating well might have scheduled and tree might have changed,
+       let's search the tree again */
+    /* find where in the tree our write should go */
+    res = search_for_position_by_key(inode->i_sb, &key, &path);
+    if ( res == IO_ERROR ) {
+	res = -EIO;
+	goto error_exit_free_blocks;
+    }
+
+    bh = get_last_bh( &path ); // Get a bufferhead for last element in path.
+    ih = get_ih( &path );      // Get a pointer to last item head in path.
+    item = get_item( &path );  // Get a pointer to last item in path
+
+    /* Let's see what we have found */
+    if ( res != POSITION_FOUND ) { /* position not found, this means that we
+				      might need to append file with holes
+				      first */
+	// Since we are writing past the file's end, we need to find out if
+	// there is a hole that needs to be inserted before our writing
+	// position, and how many blocks it is going to cover (we need to
+	//  populate pointers to file blocks representing the hole with zeros)
+
+	hole_size = (pos + 1 - (le_key_k_offset( get_inode_item_key_version(inode), &(ih->ih_key))+op_bytes_number(ih, inode->i_sb->s_blocksize))) >> inode->i_sb->s_blocksize_bits;
+
+	if ( hole_size > 0 ) {
+	    int to_paste = min_t(__u64, hole_size, MAX_ITEM_LEN(inode->i_sb->s_blocksize)/UNFM_P_SIZE ); // How much data to insert first time.
+	    /* area filled with zeroes, to supply as list of zero blocknumbers
+	       We allocate it outside of loop just in case loop would spin for
+	       several iterations. */
+	    char *zeros = kmalloc(to_paste*UNFM_P_SIZE, GFP_ATOMIC); // We cannot insert more than MAX_ITEM_LEN bytes anyway.
+	    if ( !zeros ) {
+		res = -ENOMEM;
+		goto error_exit_free_blocks;
+	    }
+	    memset ( zeros, 0, to_paste*UNFM_P_SIZE);
+	    do {
+		to_paste = min_t(__u64, hole_size, MAX_ITEM_LEN(inode->i_sb->s_blocksize)/UNFM_P_SIZE );
+		if ( is_indirect_le_ih(ih) ) {
+		    /* Ok, there is existing indirect item already. Need to append it */
+		    /* Calculate position past inserted item */
+		    make_cpu_key( &key, inode, le_key_k_offset( get_inode_item_key_version(inode), &(ih->ih_key)) + op_bytes_number(ih, inode->i_sb->s_blocksize), TYPE_INDIRECT, 3);
+		    res = reiserfs_paste_into_item( &th, &path, &key, (char *)zeros, UNFM_P_SIZE*to_paste);
+		    if ( res ) {
+			kfree(zeros);
+			goto error_exit_free_blocks;
+		    }
+		} else if ( is_statdata_le_ih(ih) ) {
+		    /* No existing item, create it */
+		    /* item head for new item */
+		    struct item_head ins_ih;
+
+		    /* create a key for our new item */
+		    make_cpu_key( &key, inode, 1, TYPE_INDIRECT, 3);
+
+		    /* Create new item head for our new item */
+		    make_le_item_head (&ins_ih, &key, key.version, 1,
+				       TYPE_INDIRECT, to_paste*UNFM_P_SIZE,
+				       0 /* free space */);
+
+		    /* Find where such item should live in the tree */
+		    res = search_item (inode->i_sb, &key, &path);
+		    if ( res != ITEM_NOT_FOUND ) {
+			/* item should not exist, otherwise we have error */
+			if ( res != -ENOSPC ) {
+			    reiserfs_warning ("green-9008: search_by_key (%K) returned %d\n",
+					       &key, res);
+			}
+			res = -EIO;
+		        kfree(zeros);
+			goto error_exit_free_blocks;
+		    }
+		    res = reiserfs_insert_item( &th, &path, &key, &ins_ih, (char *)zeros);
+		} else {
+		    reiserfs_panic(inode->i_sb, "green-9011: Unexpected key type %K\n", &key);
+		}
+		if ( res ) {
+		    kfree(zeros);
+		    goto error_exit_free_blocks;
+		}
+		/* Now we want to check if transaction is too full, and if it is
+		   we restart it. This will also free the path. */
+		if (journal_transaction_should_end(&th, th.t_blocks_allocated))
+		    restart_transaction(&th, inode, &path);
+
+		/* Well, need to recalculate path and stuff */
+		set_cpu_key_k_offset( &key, cpu_key_k_offset(&key) + to_paste * inode->i_sb->s_blocksize );
+		res = search_for_position_by_key(inode->i_sb, &key, &path);
+		if ( res == IO_ERROR ) {
+		    res = -EIO;
+		    kfree(zeros);
+		    goto error_exit_free_blocks;
+		}
+		bh=get_last_bh(&path);
+		ih=get_ih(&path);
+		item = get_item(&path);
+		hole_size -= to_paste;
+	    } while ( hole_size );
+	    kfree(zeros);
+	}
+    }
+
+    // Go through existing indirect items first
+    // replace all zeroes with blocknumbers from list
+    // Note that if no corresponding item was found, by previous search,
+    // it means there are no existing in-tree representation for file area
+    // we are going to overwrite, so there is nothing to scan through for holes.
+    for ( curr_block = 0, itempos = path.pos_in_item ; curr_block < blocks_to_allocate && res == POSITION_FOUND ; ) {
+
+	if ( itempos >= ih_item_len(ih)/UNFM_P_SIZE ) {
+	    /* We run out of data in this indirect item, let's look for another
+	       one. */
+	    /* First if we are already modifying current item, log it */
+	    if ( modifying_this_item ) {
+		journal_mark_dirty (&th, inode->i_sb, bh);
+		modifying_this_item = 0;
+	    }
+	    /* Then set the key to look for a new indirect item (offset of old
+	       item is added to old item length */
+	    set_cpu_key_k_offset( &key, le_key_k_offset( get_inode_item_key_version(inode), &(ih->ih_key)) + op_bytes_number(ih, inode->i_sb->s_blocksize));
+	    /* Search ofor position of new key in the tree. */
+	    res = search_for_position_by_key(inode->i_sb, &key, &path);
+	    if ( res == IO_ERROR) {
+		res = -EIO;
+		goto error_exit_free_blocks;
+	    }
+	    bh=get_last_bh(&path);
+	    ih=get_ih(&path);
+	    item = get_item(&path);
+	    itempos = path.pos_in_item;
+	    continue; // loop to check all kinds of conditions and so on.
+	}
+	/* Ok, we have correct position in item now, so let's see if it is
+	   representing file hole (blocknumber is zero) and fill it if needed */
+	if ( !item[itempos] ) {
+	    /* Ok, a hole. Now we need to check if we already prepared this
+	       block to be journaled */
+	    while ( !modifying_this_item ) { // loop until succeed
+		/* Well, this item is not journaled yet, so we must prepare
+		   it for journal first, before we can change it */
+		struct item_head tmp_ih; // We copy item head of found item,
+					 // here to detect if fs changed under
+					 // us while we were preparing for
+					 // journal.
+		int fs_gen; // We store fs generation here to find if someone
+			    // changes fs under our feet
+
+		copy_item_head (&tmp_ih, ih); // Remember itemhead
+		fs_gen = get_generation (inode->i_sb); // remember fs generation
+		reiserfs_prepare_for_journal(inode->i_sb, bh, 1); // Prepare a buffer within which indirect item is stored for changing.
+		if (fs_changed (fs_gen, inode->i_sb) && item_moved (&tmp_ih, &path)) {
+		    // Sigh, fs was changed under us, we need to look for new
+		    // location of item we are working with
+
+		    /* unmark prepaerd area as journaled and search for it's
+		       new position */
+		    reiserfs_restore_prepared_buffer(inode->i_sb, bh);
+		    res = search_for_position_by_key(inode->i_sb, &key, &path);
+		    if ( res == IO_ERROR) {
+			res = -EIO;
+			goto error_exit_free_blocks;
+		    }
+		    bh=get_last_bh(&path);
+		    ih=get_ih(&path);
+		    item = get_item(&path);
+		    // Itempos is still the same
+		    continue;
+		}
+		modifying_this_item = 1;
+	    }
+	    item[itempos] = allocated_blocks[curr_block]; // Assign new block
+	    curr_block++;
+	}
+	itempos++;
+    }
+
+    if ( modifying_this_item ) { // We need to log last-accessed block, if it
+				 // was modified, but not logged yet.
+	journal_mark_dirty (&th, inode->i_sb, bh);
+    }
+
+    if ( curr_block < blocks_to_allocate ) {
+	// Oh, well need to append to indirect item, or to create indirect item
+	// if there weren't any
+	if ( is_indirect_le_ih(ih) ) {
+	    // Existing indirect item - append. First calculate key for append
+	    // position. We do not need to recalculate path as it should
+	    // already point to correct place.
+	    make_cpu_key( &key, inode, le_key_k_offset( get_inode_item_key_version(inode), &(ih->ih_key)) + op_bytes_number(ih, inode->i_sb->s_blocksize), TYPE_INDIRECT, 3);
+	    res = reiserfs_paste_into_item( &th, &path, &key, (char *)(allocated_blocks+curr_block), UNFM_P_SIZE*(blocks_to_allocate-curr_block));
+	    if ( res ) {
+		goto error_exit_free_blocks;
+	    }
+	} else if (is_statdata_le_ih(ih) ) {
+	    // Last found item was statdata. That means we need to create indirect item.
+	    struct item_head ins_ih; /* itemhead for new item */
+
+	    /* create a key for our new item */
+	    make_cpu_key( &key, inode, 1, TYPE_INDIRECT, 3); // Position one,
+							    // because that's
+							    // where first
+							    // indirect item
+							    // begins
+	    /* Create new item head for our new item */
+	    make_le_item_head (&ins_ih, &key, key.version, 1, TYPE_INDIRECT,
+			       (blocks_to_allocate-curr_block)*UNFM_P_SIZE,
+			       0 /* free space */);
+	    /* Find where such item should live in the tree */
+	    res = search_item (inode->i_sb, &key, &path);
+	    if ( res != ITEM_NOT_FOUND ) {
+		/* Well, if we have found such item already, or some error
+		   occured, we need to warn user and return error */
+		if ( res != -ENOSPC ) {
+		    reiserfs_warning ("green-9009: search_by_key (%K) returned %d\n",
+			              &key, res);
+		}
+		res = -EIO;
+		goto error_exit_free_blocks;
+	    }
+	    /* Insert item into the tree with the data as its body */
+	    res = reiserfs_insert_item( &th, &path, &key, &ins_ih, (char *)(allocated_blocks+curr_block));
+	} else {
+	    reiserfs_panic(inode->i_sb, "green-9010: unexpected item type for key %K\n",&key);
+	}
+    }
+
+    /* Now the final thing, if we have grew the file, we must update it's size*/
+    if ( pos + write_bytes > inode->i_size) {
+	inode->i_size = pos + write_bytes; // Set new size
+    }
+
+    /* Amount of on-disk blocks used by file have changed, update it */
+    inode->i_blocks += blocks_to_allocate * (inode->i_sb->s_blocksize / 512);
+    reiserfs_update_sd(&th, inode); // And update on-disk metadata
+    // finish all journal stuff now, We are not going to play with metadata
+    // anymore.
+    pathrelse(&path);
+    journal_end(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1);
+    unlock_kernel();
+
+    // go through all the pages/buffers and map the buffers to newly allocated
+    // blocks (so that system knows where to write these pages later).
+    curr_block = 0;
+    for ( i = 0; i < num_pages ; i++ ) {
+	struct page *page=prepared_pages[i]; //current page
+	struct buffer_head *head = page->buffers; // first buffer for a page
+	int block_start, block_end; // in-page offsets for buffers.
+
+	if (!page->buffers)
+	    reiserfs_panic(inode->i_sb, "green-9005: No buffers for prepared page???");
+
+	/* For each buffer in page */
+	for(bh = head, block_start = 0; bh != head || !block_start;
+	    block_start=block_end, bh = bh->b_this_page) {
+	    if (!bh)
+		reiserfs_panic(inode->i_sb, "green-9006: Allocated but absent buffer for a page?");
+	    block_end = block_start+inode->i_sb->s_blocksize;
+	    if (i == 0 && block_end <= from )
+		/* if this buffer is before requested data to map, skip it */
+		continue;
+	    if (i == num_pages - 1 && block_start >= to)
+		/* If this buffer is after requested data to map, abort
+		   processing of current page */
+		break;
+
+	    if ( !buffer_mapped(bh) ) { // Ok, unmapped buffer, need to map it
+		bh->b_dev = inode->i_dev;
+		bh->b_blocknr = le32_to_cpu(allocated_blocks[curr_block]);
+		set_bit(BH_Mapped, &bh->b_state);
+		curr_block++;
+	    }
+	}
+    }
+
+    RFALSE( curr_block > blocks_to_allocate, "green-9007: Used too many blocks? weird");
+
+    return 0;
+
+// Need to deal with transaction here.
+error_exit_free_blocks:
+    pathrelse(&path);
+    // free blocks
+    for( i = 0; i < blocks_to_allocate; i++ )
+	reiserfs_free_block( &th, le32_to_cpu(allocated_blocks[i]));
+
+error_exit:
+    journal_end(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1);
+    unlock_kernel();
+
+    return res;
+}
+
+/* Unlock pages prepared by reiserfs_prepare_file_region_for_write */
+void reiserfs_unprepare_pages(struct page **prepared_pages, /* list of locked pages */
+			      int num_pages /* amount of pages */) {
+    int i; // loop counter
+
+    for (i=0; i < num_pages ; i++) {
+	struct page *page = prepared_pages[i];
+
+	try_to_free_buffers(page,0);
+	kunmap(page);
+	UnlockPage(page);
+	page_cache_release(page);
+    }
+}
+
+/* This function will copy data from userspace to specified pages within
+   supplied byte range */
+int reiserfs_copy_from_user_to_file_region(
+				loff_t pos, /* In-file position */
+				int num_pages, /* Number of pages affected */
+				int write_bytes, /* Amount of bytes to write */
+				struct page **prepared_pages, /* pointer to 
+								 array to
+								 prepared pages
+								*/
+				const char *buf /* Pointer to user-supplied
+						   data*/
+				)
+{
+    long page_fault=0; // status of copy_from_user.
+    int i; // loop counter.
+    int offset; // offset in page
+
+    for ( i = 0, offset = (pos & (PAGE_CACHE_SIZE-1)); i < num_pages ; i++,offset=0) {
+	int count = min_t(int,PAGE_CACHE_SIZE-offset,write_bytes); // How much of bytes to write to this page
+	struct page *page=prepared_pages[i]; // Current page we process.
+
+	/* Bring in the user page. We need to do it to fight some deadlocks
+	   with copying the page to itself and page being inaccessible at
+	   the same time.*/
+	{ volatile unsigned char dummy;
+	    __get_user(dummy, buf);
+	    __get_user(dummy, buf+count-1);
+	    /* We do getuser for beginning and ending of the region just because
+	       userdata may be not page aligned, and therefore data that will
+	       go into one page of file may be splitted onto two actual pages
+	       in userspace */
+	}
+
+	/* Copy data from userspace to the current page */
+	page_fault = __copy_from_user(page_address(page)+offset, buf, count); // Copy the data.
+	/* Flush processor's dcache for this page */
+	flush_dcache_page(page);
+	buf+=count;
+	write_bytes-=count;
+
+	if (page_fault)
+	    break; // Was there a fault? abort.
+    }
+
+    return page_fault?-EFAULT:0;
+}
+
+
+
+/* Submit pages for write. This was separated from actual file copying
+   because we might want to allocate block numbers in-between.
+   This function assumes that caller will adjust file size to correct value. */
+int reiserfs_submit_file_region_for_write(
+				loff_t pos, /* Writing position offset */
+				int num_pages, /* Number of pages to write */
+				int write_bytes, /* number of bytes to write */
+				struct page **prepared_pages /* list of pages */
+				)
+{
+    int status; // return status of block_commit_write.
+    int retval = 0; // Return value we are going to return.
+    int i; // loop counter
+    int offset; // Writing offset in page.
+
+    for ( i = 0, offset = (pos & (PAGE_CACHE_SIZE-1)); i < num_pages ; i++,offset=0) {
+	int count = min_t(int,PAGE_CACHE_SIZE-offset,write_bytes); // How much of bytes to write to this page
+	struct page *page=prepared_pages[i]; // Current page we process.
+
+	status = block_commit_write(page, offset, offset+count); // Note this also kunmaps kmapped page.
+	if ( status )
+	    retval = status; // To not overcomplicate matters We are going to
+			     // submit all the pages even if there was error.
+			     // we only remember error status to report it on
+			     // exit.
+	write_bytes-=count;
+	SetPageReferenced(page);
+	UnlockPage(page); // We unlock the page as it was locked by earlier call
+			  // to grab_cache_page
+	page_cache_release(page);
+    }
+    return retval;
+}
+
+/* Look if passed writing region is going to touch file's tail
+   (if it is present). And if it is, convert the tail to unformatted node */
+int reiserfs_check_for_tail_and_convert( struct inode *inode, /* inode to deal with */
+					 loff_t pos, /* Writing position */
+					 int write_bytes /* amount of bytes to write */
+				        )
+{
+    INITIALIZE_PATH(path); // needed for search_for_position
+    struct cpu_key key; // Key that would represent last touched writing byte.
+    struct item_head *ih; // item header of found block;
+    int res; // Return value of various functions we call.
+    int cont_expand_offset; // We will put offset for generic_cont_expand here
+			    // This can be int just because tails are created
+			    // only for small files.
+ 
+/* this embodies a dependency on a particular tail policy */
+    if ( inode->i_size >= inode->i_sb->s_blocksize*4 ) {
+	/* such a big files do not have tails, so we won't bother ourselves
+	   to look for tails, simply return */
+	return 0;
+    }
+
+    lock_kernel();
+    /* find the item containing the last byte to be written, or if
+     * writing past the end of the file then the last item of the
+     * file (and then we check its type). */
+    make_cpu_key (&key, inode, pos+write_bytes+1, TYPE_ANY, 3/*key length*/);
+    res = search_for_position_by_key(inode->i_sb, &key, &path);
+    if ( res == IO_ERROR ) {
+        unlock_kernel();
+	return -EIO;
+    }
+    ih = get_ih(&path);
+    res = 0;
+    if ( is_direct_le_ih(ih) ) {
+	/* Ok, closest item is file tail (tails are stored in "direct"
+	 * items), so we need to unpack it. */
+	/* To not overcomplicate matters, we just call generic_cont_expand
+	   which will in turn call other stuff and finally will boil down to
+	    reiserfs_get_block() that would do necessary conversion. */
+	cont_expand_offset = le_key_k_offset(get_inode_item_key_version(inode), &(ih->ih_key));
+	pathrelse(&path);
+	res = generic_cont_expand( inode, cont_expand_offset);
+    } else
+	pathrelse(&path);
+
+    unlock_kernel();
+    return res;
+}
+
+/* This functions kmaps and locks pages starting from @pos for @inode.
+   @num_pages pages are locked and stored in
+   @prepared_pages array. Also buffers are allocated for these pages.
+   First and last page of the region is read if it is overwritten only
+   partially. If last page did not exist before write (file hole or file
+   append), it is zeroed, then. 
+   Returns number of unallocated blocks that should be allocated to cover
+   new file data.*/
+int reiserfs_prepare_file_region_for_write(
+				struct inode *inode /* Inode of the file */,
+				loff_t pos, /* position in the file */
+				int num_pages, /* number of pages to
+					          prepare */
+				int write_bytes, /* Amount of bytes to be
+						    overwritten from
+						    @pos */
+				struct page **prepared_pages /* pointer to array
+							       where to store
+							       prepared pages */
+					   )
+{
+    int res=0; // Return values of different functions we call.
+    unsigned long index = pos >> PAGE_CACHE_SHIFT; // Offset in file in pages.
+    int from = (pos & (PAGE_CACHE_SIZE - 1)); // Writing offset in first page
+    int to = ((pos + write_bytes - 1) & (PAGE_CACHE_SIZE - 1)) + 1;
+					 /* offset of last modified byte in last
+				            page */
+    struct address_space *mapping = inode->i_mapping; // Pages are mapped here.
+    int i; // Simple counter
+    int blocks = 0; /* Return value (blocks that should be allocated) */
+    struct buffer_head *bh, *head; // Current bufferhead and first bufferhead
+				   // of a page.
+    unsigned block_start, block_end; // Starting and ending offsets of current
+				     // buffer in the page.
+    struct buffer_head *wait[2], **wait_bh=wait; // Buffers for page, if
+						 // Page appeared to be not up
+						 // to date. Note how we have
+						 // at most 2 buffers, this is
+						 // because we at most may
+						 // partially overwrite two
+						 // buffers for one page. One at                                                 // the beginning of write area
+						 // and one at the end.
+						 // Everything inthe middle gets                                                 // overwritten totally.
+
+    struct cpu_key key; // cpu key of item that we are going to deal with
+    struct item_head *ih = NULL; // pointer to item head that we are going to deal with
+    struct buffer_head *itembuf=NULL; // Buffer head that contains items that we are going to deal with
+    INITIALIZE_PATH(path); // path to item, that we are going to deal with.
+    __u32 * item=0; // pointer to item we are going to deal with
+
+
+    if ( num_pages < 1 ) {
+	reiserfs_warning("green-9001: reiserfs_prepare_file_region_for_write called with zero number of pages to process\n");
+	return -EFAULT;
+    }
+
+    /* We have 2 loops for pages. In first loop we grab and lock the pages, so
+       that nobody would touch these until we release the pages. Then
+       we'd start to deal with mapping buffers to blocks. */
+    for ( i = 0; i < num_pages; i++) {
+	prepared_pages[i] = grab_cache_page(mapping, index + i); // locks the page
+	if ( !prepared_pages[i]) {
+	    res = -ENOMEM;
+	    goto failed_page_grabbing;
+	}
+	kmap(prepared_pages[i]); // MAp the page in conventional RAM.
+	if (!prepared_pages[i]->buffers)
+	    create_empty_buffers(prepared_pages[i], inode->i_dev, inode->i_sb->s_blocksize);
+    }
+
+    /* Let's count amount of blocks for a case where all the blocks
+       overwritten are new (we will substract already allocated blocks later)*/
+    if ( num_pages > 2 )
+	/* These are full-overwritten pages so we count all the blocks in
+	   these pages are counted as needed to be allocated */
+	blocks = (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize) * (num_pages - 2);
+
+    /* count blocks needed for first page (possibly partially written) */
+    blocks += ((PAGE_CACHE_SIZE - from) >> inode->i_sb->s_blocksize_bits) +
+	   !!(from & (inode->i_sb->s_blocksize-1)); /* roundup */
+
+    /* Now we account for last page. If last page == first page (we
+       overwrite only one page), we substract all the blocks past the
+       last writing position in a page out of already calculated number
+       of blocks */
+    blocks += (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize) * (num_pages > 1) -
+	   ((PAGE_CACHE_SIZE - to) >> inode->i_sb->s_blocksize_bits);
+	   /* Note how we do not roundup here since partial blocks still
+		   should be allocated */
+
+    /* Now if all the write area lies past the file end, no point in
+       maping blocks, since there is none, so we just zero out remaining
+       parts of first and last pages in write area (if needed) */
+    if ( (pos & ~(PAGE_CACHE_SIZE - 1)) > inode->i_size ) {
+	if ( from != 0 ) {/* First page needs to be partially zeroed */
+	    memset(page_address(prepared_pages[0]), 0, from);
+	    SetPageUptodate(prepared_pages[0]);
+	}
+	if ( to != PAGE_CACHE_SIZE ) { /* Last page needs to be partially zeroed */
+	    memset(page_address(prepared_pages[num_pages-1])+to, 0, PAGE_CACHE_SIZE - to);
+	    SetPageUptodate(prepared_pages[num_pages-1]);
+	}
+
+	/* Since all blocks are new - use already calculated value */
+	return blocks;
+    }
+
+    /* Well, since we write somewhere into the middle of a file, there is
+       possibility we are writing over some already allocated blocks, so
+       let's map these blocks and substract number of such blocks out of blocks
+       we need to allocate (calculated above) */
+    /* Mask write position to start on blocksize, we do it out of the
+       loop for performance reasons */
+    pos &= ~(inode->i_sb->s_blocksize - 1);
+    /* Set cpu key to the starting position in a file (on left block boundary)*/
+    make_cpu_key (&key, inode, 1 + ((pos) & ~(inode->i_sb->s_blocksize - 1)), TYPE_ANY, 3/*key length*/);
+
+    lock_kernel(); // We need that for at least search_by_key()
+    for ( i = 0; i < num_pages ; i++ ) { 
+	int item_pos=-1; /* Position in indirect item */
+
+	head = prepared_pages[i]->buffers;
+	/* For each buffer in the page */
+	for(bh = head, block_start = 0; bh != head || !block_start;
+	    block_start=block_end, bh = bh->b_this_page) {
+		if (!bh)
+		    reiserfs_panic(inode->i_sb, "green-9002: Allocated but absent buffer for a page?");
+		/* Find where this buffer ends */
+		block_end = block_start+inode->i_sb->s_blocksize;
+		if (i == 0 && block_end <= from )
+		    /* if this buffer is before requested data to map, skip it*/
+		    continue;
+
+		if (i == num_pages - 1 && block_start >= to) {
+		    /* If this buffer is after requested data to map, abort
+		       processing of current page */
+		    break;
+		}
+
+		if ( buffer_mapped(bh) && bh->b_blocknr !=0 ) {
+		    /* This is optimisation for a case where buffer is mapped
+		       and have blocknumber assigned. In case significant amount
+		       of such buffers are present, we may avoid some amount
+		       of search_by_key calls.
+		       Probably it would be possible to move parts of this code
+		       out of BKL, but I afraid that would overcomplicate code
+		       without any noticeable benefit.
+		    */
+		    item_pos++;
+		    /* Update the key */
+		    set_cpu_key_k_offset( &key, cpu_key_k_offset(&key) + inode->i_sb->s_blocksize);
+		    blocks--; // Decrease the amount of blocks that need to be
+			      // allocated
+		    continue; // Go to the next buffer
+		}
+
+		if ( !itembuf || /* if first iteration */
+		     item_pos >= ih_item_len(ih)/UNFM_P_SIZE)
+					     { /* or if we progressed past the
+						  current unformatted_item */
+			/* Try to find next item */
+			res = search_for_position_by_key(inode->i_sb, &key, &path);
+			/* Abort if no more items */
+			if ( res != POSITION_FOUND )
+			    break;
+
+			/* Update information about current indirect item */
+			itembuf = get_last_bh( &path );
+			ih = get_ih( &path );
+			item = get_item( &path );
+			item_pos = path.pos_in_item;
+
+			RFALSE( !is_indirect_le_ih (ih), "green-9003: indirect item expected");
+		}
+
+		/* See if there is some block associated with the file
+		   at that position, map the buffer to this block */
+		if ( get_block_num(item,item_pos) ) {
+		    bh->b_dev = inode->i_dev;
+		    bh->b_blocknr = get_block_num(item,item_pos);
+		    set_bit(BH_Mapped, &bh->b_state);
+		    blocks--; // Decrease the amount of blocks that need to be
+			      // allocated
+		}
+		item_pos++;
+		/* Update the key */
+		set_cpu_key_k_offset( &key, cpu_key_k_offset(&key) + inode->i_sb->s_blocksize);
+	}
+    }
+    pathrelse(&path); // Free the path
+    unlock_kernel();
+
+	/* Now zero out unmappend buffers for the first and last pages of
+	   write area or issue read requests if page is mapped. */
+	/* First page, see if it is not uptodate */
+	if ( !Page_Uptodate(prepared_pages[0]) ) {
+	    head = prepared_pages[0]->buffers;
+
+	    /* For wach buffer in page */
+	    for(bh = head, block_start = 0; bh != head || !block_start;
+		block_start=block_end, bh = bh->b_this_page) {
+
+		if (!bh)
+		    reiserfs_panic(inode->i_sb, "green-9002: Allocated but absent buffer for a page?");
+		/* Find where this buffer ends */
+		block_end = block_start+inode->i_sb->s_blocksize;
+		if ( block_end <= from )
+		    /* if this buffer is before requested data to map, skip it*/
+		    continue;
+		if ( block_start < from ) { /* Aha, our partial buffer */
+		    if ( buffer_mapped(bh) ) { /* If it is mapped, we need to
+						  issue READ request for it to
+						  not loose data */
+			ll_rw_block(READ, 1, &bh);
+			*wait_bh++=bh;
+		    } else { /* Not mapped, zero it */
+			memset(page_address(prepared_pages[0])+block_start, 0, from-block_start);
+			set_bit(BH_Uptodate, &bh->b_state);
+		    }
+		}
+	    }
+	}
+
+	/* Last page, see if it is not uptodate, or if the last page is past the end of the file. */
+	if ( !Page_Uptodate(prepared_pages[num_pages-1]) || 
+	    ((pos+write_bytes)>>PAGE_CACHE_SHIFT) > (inode->i_size>>PAGE_CACHE_SHIFT) ) {
+	    head = prepared_pages[num_pages-1]->buffers;
+
+	    /* for each buffer in page */
+	    for(bh = head, block_start = 0; bh != head || !block_start;
+		block_start=block_end, bh = bh->b_this_page) {
+
+		if (!bh)
+		    reiserfs_panic(inode->i_sb, "green-9002: Allocated but absent buffer for a page?");
+		/* Find where this buffer ends */
+		block_end = block_start+inode->i_sb->s_blocksize;
+		if ( block_start >= to )
+		    /* if this buffer is after requested data to map, skip it*/
+		    break;
+		if ( block_end > to ) { /* Aha, our partial buffer */
+		    if ( buffer_mapped(bh) ) { /* If it is mapped, we need to
+						  issue READ request for it to
+						  not loose data */
+			ll_rw_block(READ, 1, &bh);
+			*wait_bh++=bh;
+		    } else { /* Not mapped, zero it */
+			memset(page_address(prepared_pages[num_pages-1])+to, 0, block_end-to);
+			set_bit(BH_Uptodate, &bh->b_state);
+		    }
+		}
+	    }
+	}
+
+    /* Wait for read requests we made to happen, if necessary */
+    while(wait_bh > wait) {
+	wait_on_buffer(*--wait_bh);
+	if (!buffer_uptodate(*wait_bh)) {
+	    res = -EIO;
+	    goto failed_read;
+	}
+    }
+
+    return blocks;
+failed_page_grabbing:
+    num_pages = i;
+failed_read:
+    reiserfs_unprepare_pages(prepared_pages, num_pages);
+    return res;
+}
+
+/* Write @count bytes at position @ppos in a file indicated by @file
+   from the buffer @buf.  
+
+   generic_file_write() is only appropriate for filesystems that are not seeking to optimize performance and want
+   something simple that works.  It is not for serious use by general purpose filesystems, excepting the one that it was
+   written for (ext2/3).  This is for several reasons:
+
+   * It has no understanding of any filesystem specific optimizations.
+
+   * It enters the filesystem repeatedly for each page that is written.
+
+   * It depends on reiserfs_get_block() function which if implemented by reiserfs performs costly search_by_key
+   * operation for each page it is supplied with. By contrast reiserfs_file_write() feeds as much as possible at a time
+   * to reiserfs which allows for fewer tree traversals.
+
+   * Each indirect pointer insertion takes a lot of cpu, because it involves memory moves inside of blocks.
+
+   * Asking the block allocation code for blocks one at a time is slightly less efficient.
+
+   All of these reasons for not using only generic file write were understood back when reiserfs was first miscoded to
+   use it, but we were in a hurry to make code freeze, and so it couldn't be revised then.  This new code should make
+   things right finally.
+
+   Future Features: providing search_by_key with hints.
+
+*/
+ssize_t reiserfs_file_write( struct file *file, /* the file we are going to write into */
+                             const char *buf, /*  pointer to user supplied data
+(in userspace) */
+                             size_t count, /* amount of bytes to write */
+                             loff_t *ppos /* pointer to position in file that we start writing at. Should be updated to
+                                           * new current position before returning. */ )
+{
+    size_t already_written = 0; // Number of bytes already written to the file.
+    loff_t pos; // Current position in the file.
+    size_t res; // return value of various functions that we call.
+    unsigned long limit = current->rlim[RLIMIT_FSIZE].rlim_cur; // Current filesize limit
+    struct inode *inode = file->f_dentry->d_inode; // Inode of the file that we are writing to.
+    struct page * prepared_pages[REISERFS_WRITE_PAGES_AT_A_TIME];
+				/* To simplify coding at this time, we store
+				   locked pages in array for now */
+    if ( count <= PAGE_CACHE_SIZE || file->f_flags & O_DIRECT)
+        return generic_file_write(file, buf, count, ppos);
+
+    if ( (ssize_t) count < 0 )
+        return -EINVAL;
+
+    if (!access_ok(VERIFY_READ, buf, count))
+        return -EFAULT;
+
+    down(&inode->i_sem); // locks the entire file for just us
+
+    // We are going to duplicate a lot of generic_file_write checks here
+    // for now. I do not have any good idea on how to avoid these now.
+
+    res = -EINVAL;
+    if ( *ppos < 0)
+	goto out;
+
+    res = file->f_error;
+    if ( res ) {
+	file->f_error = 0;
+	goto out;
+    }
+
+    if (file->f_flags & O_APPEND)
+	pos=inode->i_size;
+    else
+	pos=*ppos;
+
+    res = -EFBIG;
+    if ( limit != RLIM_INFINITY) {
+	if (pos >= limit) {
+	    send_sig(SIGXFSZ, current, 0);
+	    goto out;
+	}
+	if ( pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
+	    count = limit - (u32)pos;
+	}
+    }
+
+    // LFS
+    if ( pos + count > MAX_NON_LFS && !(file->f_flags & O_LARGEFILE) ) {
+	if ( pos >= MAX_NON_LFS ) {
+	    send_sig(SIGXFSZ, current, 0);
+	    goto out;
+	}
+	if ( count > MAX_NON_LFS - (u32)pos ) {
+	    count = MAX_NON_LFS - (u32)pos;
+	}
+    }
+
+    // Check we are not going to exceed block limit
+    if ( pos >= inode->i_sb->s_maxbytes) {
+	if ( count || pos > inode->i_sb->s_maxbytes) {
+	    send_sig(SIGXFSZ, current, 0);
+	    goto out;
+	}
+	// zero length writes are ok.
+    }
+
+    res = 0;
+    if ( count == 0 )
+	goto out;
+
+    remove_suid(inode);
+    /* Mark inode dirty only in case times are actually changed.
+       This is to speed things up */
+    {
+	time_t now = CURRENT_TIME;
+	if (inode->i_ctime != now || inode->i_mtime != now) {
+	    inode->i_ctime = inode->i_mtime = now;
+	    mark_inode_dirty_sync(inode);
+	}
+    }
+
+
+    // Ok, we are done with all the checks.
+
+    // Now we should start real work
+
+    /* If we are going to write past the file's packed tail or if we are going
+       to overwrite part of the tail, we need that tail to be converted into
+       unformatted node */
+    res = reiserfs_check_for_tail_and_convert( inode, pos, count);
+    if (res)
+	goto out;
+
+    while ( count > 0) {
+	/* This is the main loop in which we running until some error occures
+	   or until we write all of the data. */
+	int num_pages;/* amount of pages we are going to write this iteration */
+	int write_bytes; /* amount of bytes to write during this iteration */
+	int blocks_to_allocate; /* how much blocks we need to allocate for
+				   this iteration */
+        
+        /*  (pos & (PAGE_CACHE_SIZE-1)) is an idiom for offset into a page of pos*/
+	num_pages = !!((pos+count) & (PAGE_CACHE_SIZE - 1)) + /* round up partial
+							  pages */
+		    ((count + (pos & (PAGE_CACHE_SIZE-1))) >> PAGE_CACHE_SHIFT); 
+						/* convert size to amount of
+						   pages */
+/* all lock_kernels should be changed to lock_supers in reiserfs, but they need to be changed all at once and all together */
+	lock_kernel();
+	if ( num_pages > REISERFS_WRITE_PAGES_AT_A_TIME 
+		|| num_pages > reiserfs_can_fit_pages(inode->i_sb) ) {
+	    /* If we were asked to write more data than we want to or if there
+	       is not that much space, then we shorten amount of data to write
+	       for this iteration. */
+	    num_pages = min_t(int, REISERFS_WRITE_PAGES_AT_A_TIME, reiserfs_can_fit_pages(inode->i_sb));
+	    /* Also we should not forget to set size in bytes accordingly */
+	    write_bytes = num_pages * PAGE_CACHE_SIZE - 
+			    (pos & (PAGE_CACHE_SIZE-1));
+					 /* If position is not on the
+					    start of the page, we need
+					    to substract the offset
+					    within page */
+	} else
+	    write_bytes = count;
+
+	/* reserve the blocks to be allocated later, so that later on
+	   we still have the space to write the blocks to */
+	reiserfs_claim_blocks_to_be_allocated(inode->i_sb, num_pages * (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize));
+	unlock_kernel();
+
+	if ( !num_pages ) { /* If we do not have enough space even for */
+	    res = -ENOSPC;  /* single page, return -ENOSPC */
+	    if ( pos > (inode->i_size & (inode->i_sb->s_blocksize-1)))
+		break; // In case we are writing past the file end, break.
+	    // Otherwise we are possibly overwriting the file, so
+	    // let's set write size to be equal or less than blocksize.
+	    // This way we get it correctly for file holes.
+	    // But overwriting files on absolutelly full volumes would not
+	    // be very efficient. Well, people are not supposed to fill
+	    // 100% of disk space anyway.
+	    write_bytes = min_t(int, count, inode->i_sb->s_blocksize - (pos & (inode->i_sb->s_blocksize - 1)));
+	    num_pages = 1;
+	}
+
+	/* Prepare for writing into the region, read in all the
+	   partially overwritten pages, if needed. And lock the pages,
+	   so that nobody else can access these until we are done.
+	   We get number of actual blocks needed as a result.*/
+	blocks_to_allocate = reiserfs_prepare_file_region_for_write(inode, pos, num_pages, write_bytes, prepared_pages);
+	if ( blocks_to_allocate < 0 ) {
+	    res = blocks_to_allocate;
+	    reiserfs_release_claimed_blocks(inode->i_sb, num_pages * (PAGE_CACHE_SIZE/inode->i_sb->s_blocksize));
+	    break;
+	}
+
+	/* First we correct our estimate of how many blocks we need */
+	reiserfs_release_claimed_blocks(inode->i_sb, num_pages * (PAGE_CACHE_SIZE>>inode->i_sb->s_blocksize_bits) - blocks_to_allocate );
+
+	if ( blocks_to_allocate > 0) {/*We only allocate blocks if we need to*/
+	    /* Fill in all the possible holes and append the file if needed */
+	    res = reiserfs_allocate_blocks_for_region(inode, pos, num_pages, write_bytes, prepared_pages, blocks_to_allocate);
+	} else if ( pos + write_bytes > inode->i_size ) {
+	    /* File might have grown even though no new blocks were added */
+	    inode->i_size = pos + write_bytes;
+	    inode->i_sb->s_op->dirty_inode(inode);
+	}
+
+	/* well, we have allocated the blocks, so it is time to free
+	   the reservation we made earlier. */
+	reiserfs_release_claimed_blocks(inode->i_sb, blocks_to_allocate);
+	if ( res ) {
+	    reiserfs_unprepare_pages(prepared_pages, num_pages);
+	    break;
+	}
+
+/* NOTE that allocating blocks and filling blocks can be done in reverse order
+   and probably we would do that just to get rid of garbage in files after a
+   crash */
+
+	/* Copy data from user-supplied buffer to file's pages */
+	res = reiserfs_copy_from_user_to_file_region(pos, num_pages, write_bytes, prepared_pages, buf);
+	if ( res ) {
+	    reiserfs_unprepare_pages(prepared_pages, num_pages);
+	    break;
+	}
+
+	/* Send the pages to disk and unlock them. */
+	res = reiserfs_submit_file_region_for_write(pos, num_pages, write_bytes, prepared_pages);
+	if ( res )
+	    break;
+
+	already_written += write_bytes;
+	buf += write_bytes;
+	pos = *ppos += write_bytes;
+	count -= write_bytes;
+    }
+
+    if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
+	res = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
+
+    up(&inode->i_sem);
+    return (already_written != 0)?already_written:res;
+
+out:
+    up(&inode->i_sem); // unlock the file on exit.
+    return res;
+}
 struct file_operations reiserfs_file_operations = {
     read:	generic_file_read,
-    write:	generic_file_write,
+    write:	reiserfs_file_write,
     ioctl:	reiserfs_ioctl,
     mmap:	generic_file_mmap,
     release:	reiserfs_file_release,
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon Sep  9 09:28:34 2002
+++ b/fs/reiserfs/inode.c	Mon Sep  9 09:28:34 2002
@@ -913,7 +913,7 @@
 
 
     copy_key (INODE_PKEY (inode), &(ih->ih_key));
-    inode->i_blksize = PAGE_SIZE;
+    inode->i_blksize = PAGE_SIZE*32;
 
     INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
 
@@ -1605,7 +1605,7 @@
 
     // these do not go to on-disk stat data
     inode->i_ino = le32_to_cpu (ih.ih_key.k_objectid);
-    inode->i_blksize = PAGE_SIZE;
+    inode->i_blksize = PAGE_SIZE*32;
     inode->i_dev = sb->s_dev;
   
     // store in in-core inode the key of stat data and version all
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Mon Sep  9 09:28:34 2002
+++ b/fs/reiserfs/super.c	Mon Sep  9 09:28:34 2002
@@ -1261,6 +1261,7 @@
     reiserfs_proc_register( s, "oidmap", reiserfs_oidmap_in_proc );
     reiserfs_proc_register( s, "journal", reiserfs_journal_in_proc );
     init_waitqueue_head (&(s->u.reiserfs_sb.s_wait));
+    s->u.reiserfs_sb.bitmap_lock = SPIN_LOCK_UNLOCKED;
 
     printk("%s\n", reiserfs_get_version_string()) ;
     return s;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Mon Sep  9 09:28:34 2002
+++ b/include/linux/reiserfs_fs.h	Mon Sep  9 09:28:34 2002
@@ -2007,6 +2007,7 @@
 #endif
 void reiserfs_claim_blocks_to_be_allocated( struct super_block *sb, int blocks);
 void reiserfs_release_claimed_blocks( struct super_block *sb, int blocks);
+int reiserfs_can_fit_pages(struct super_block *sb);
 
 /* hashes.c */
 __u32 keyed_hash (const signed char *msg, int len);
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Mon Sep  9 09:28:34 2002
+++ b/include/linux/reiserfs_fs_sb.h	Mon Sep  9 09:28:34 2002
@@ -466,6 +466,7 @@
     reiserfs_proc_info_data_t s_proc_info_data;
     struct proc_dir_entry *procdir;
     int reserved_blocks; /* amount of blocks reserved for further allocations */
+    spinlock_t bitmap_lock; /* this lock on now only used to protect reserved_blocks variable */
 };
 
 /* Definitions of reiserfs on-disk properties: */


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.591   -> 1.592  
#	      kernel/ksyms.c	1.60    -> 1.61   
#	        mm/filemap.c	1.68    -> 1.69   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	green@angband.namesys.com	1.592
# export generic_osync_inode,block_commit_write, remove_suid
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Mon Sep  9 09:28:49 2002
+++ b/kernel/ksyms.c	Mon Sep  9 09:28:49 2002
@@ -215,6 +215,7 @@
 EXPORT_SYMBOL(generic_cont_expand);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
+EXPORT_SYMBOL(block_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_file_read);
@@ -531,6 +532,8 @@
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
 EXPORT_SYMBOL(brw_page);
+EXPORT_SYMBOL(generic_osync_inode);
+EXPORT_SYMBOL(remove_suid);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Sep  9 09:28:49 2002
+++ b/mm/filemap.c	Mon Sep  9 09:28:49 2002
@@ -2906,7 +2906,7 @@
 	return page;
 }
 
-inline void remove_suid(struct inode *inode)
+void remove_suid(struct inode *inode)
 {
 	unsigned int mode;
 

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=mail2

Hello!

    These 3 changesets are trivial changes to reiserfs:
    adding back mistakenly forgotten "attrs" mount option, fix a problem
    with displacing_large_files allocator option and fix a bug in remounting
    code on remount from readwarite to readwrite mode that can cause livelock
    if there was delayed unlinks scheduled on the filesystem.

    You can pull these from: bk://thebsh.namesys.com/bk/reiser3-linux-2.4

    Please apply.

Diffstats:

 super.c |    1 +
 1 files changed, 1 insertion(+)

 fs/reiserfs/inode.c         |    2 +-
 include/linux/reiserfs_fs.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

 super.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Plain text patches:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.589   -> 1.590  
#	 fs/reiserfs/super.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	green@angband.namesys.com	1.590
# reiserfs: Mistakenly forgotten inode attributes option was added back.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Sep 10 13:49:45 2002
+++ b/fs/reiserfs/super.c	Tue Sep 10 13:49:45 2002
@@ -569,6 +569,7 @@
 		{"hash", 'h', hash, FORCE_HASH_DETECT},
 		
 		{"resize", 'r', 0, -1},
+		{"attrs", 0, 0, REISERFS_ATTRS},
 		{NULL, 0, 0, 0}
     };
 	


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.590   -> 1.591  
#	 fs/reiserfs/inode.c	1.35    -> 1.36   
#	include/linux/reiserfs_fs.h	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	green@angband.namesys.com	1.591
# reiserfs: Take into account file information even when not doing preallocation. Files a bug with displacing_large_files option
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue Sep 10 13:49:46 2002
+++ b/fs/reiserfs/inode.c	Tue Sep 10 13:49:46 2002
@@ -511,7 +511,7 @@
         return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr, path, block);
     }
 #endif
-    return reiserfs_new_unf_blocknrs (th, allocated_block_nr, path, block);
+    return reiserfs_new_unf_blocknrs (th, inode, allocated_block_nr, path, block);
 }
 
 static int reiserfs_get_block (struct inode * inode, long block,
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue Sep 10 13:49:46 2002
+++ b/include/linux/reiserfs_fs.h	Tue Sep 10 13:49:46 2002
@@ -1970,13 +1970,14 @@
 }
 
 extern inline int reiserfs_new_unf_blocknrs (struct reiserfs_transaction_handle *th,
+					     struct inode *inode,
 					     b_blocknr_t *new_blocknrs,
 					     struct path * path, long block)
 {
     reiserfs_blocknr_hint_t hint = {
 	th: th,
 	path: path,
-	inode: NULL,
+	inode: inode,
 	block: block,
 	formatted_node: 0,
 	preallocate: 0



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.592   -> 1.593  
#	 fs/reiserfs/super.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/10	green@angband.namesys.com	1.593
# reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Sep 10 13:49:47 2002
+++ b/fs/reiserfs/super.c	Tue Sep 10 13:49:47 2002
@@ -664,7 +664,7 @@
   }
 
   if (*mount_flags & MS_RDONLY) {
-    /* remount rean-only */
+    /* remount read-only */
     if (s->s_flags & MS_RDONLY)
       /* it is read-only already */
       return 0;
@@ -680,6 +680,10 @@
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
   } else {
+    /* remount read-write */
+    if (!(s->s_flags & MS_RDONLY))
+	return 0; /* We are read-write already */
+
     s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;

--/04w6evG8XlLl3ft--



--------------070607000106040700090100--

