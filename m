Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUJEPJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUJEPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJEPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:09:27 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:33608 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269043AbUJEPI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:08:29 -0400
Date: Tue, 5 Oct 2004 11:08:26 -0400
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ReiserFS: Cleanup internal use of bh macros
Message-ID: <20041005150826.GB30046@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch cleans up ReiserFS's use of buffer head flags. All direct
access of BH_* are made into macro calls, and all reiserfs-specific
BH_* macro implementations have been removed and replaced with the
BUFFER_FNS implementations found in linux/buffer_head.h

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

 fs/reiserfs/do_balan.c      |    2=20
 fs/reiserfs/fix_node.c      |    2=20
 fs/reiserfs/journal.c       |   94 ++++++++++++++-------------------------=
-----
 fs/reiserfs/namei.c         |    2=20
 include/linux/reiserfs_fs.h |   50 ++++++++---------------
 5 files changed, 52 insertions(+), 98 deletions(-)

Index: linux.t/fs/reiserfs/do_balan.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/do_balan.c	2004-08-12 09:36:58.241945992 -0400
+++ linux.t/fs/reiserfs/do_balan.c	2004-08-12 09:39:47.774173176 -0400
@@ -1341,7 +1341,7 @@ static void check_internal_node (struct=20
=20
 static int locked_or_not_in_tree (struct buffer_head * bh, char * which)
 {
-  if ( (!reiserfs_buffer_prepared(bh) && buffer_locked (bh)) ||
+  if ( (!buffer_journal_prepared (bh) && buffer_locked (bh)) ||
         !B_IS_IN_TREE (bh) ) {
     reiserfs_warning (NULL, "vs-12339: locked_or_not_in_tree: %s (%b)",
                       which, bh);
Index: linux.t/fs/reiserfs/fix_node.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/fix_node.c	2004-08-12 09:36:58.240946144 -0400
+++ linux.t/fs/reiserfs/fix_node.c	2004-08-12 09:39:47.778172568 -0400
@@ -820,7 +820,7 @@ static int  get_empty_nodes(
     RFALSE (p_s_tb->FEB[p_s_tb->cur_blknum],
 	    "PAP-8141: busy slot for new buffer");
=20
-    mark_buffer_journal_new(p_s_new_bh) ;
+    set_buffer_journal_new (p_s_new_bh);
     p_s_tb->FEB[p_s_tb->cur_blknum++] =3D p_s_new_bh;
   }
=20
Index: linux.t/fs/reiserfs/journal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/journal.c	2004-08-12 09:36:58.236946752 -0400
+++ linux.t/fs/reiserfs/journal.c	2004-08-12 09:39:47.783171808 -0400
@@ -122,7 +122,7 @@ static void init_journal_hash(struct sup
 static int reiserfs_clean_and_file_buffer(struct buffer_head *bh) {
   if (bh) {
     clear_buffer_dirty(bh);
-    clear_bit(BH_JTest, &bh->b_state);
+    clear_buffer_journal_test(bh);
   }
   return 0 ;
 }
@@ -388,41 +388,9 @@ static void free_cnode(struct super_bloc
   SB_JOURNAL(p_s_sb)->j_cnode_free_list =3D cn ;
 }
=20
-static int clear_prepared_bits(struct buffer_head *bh) {
-  clear_bit(BH_JPrepared, &bh->b_state) ;
-  clear_bit(BH_JRestore_dirty, &bh->b_state) ;
-  return 0 ;
-}
-
-/* buffer is in current transaction */
-inline int buffer_journaled(const struct buffer_head *bh) {
-  if (bh)
-    return test_bit(BH_JDirty, &bh->b_state) ;
-  else
-    return 0 ;
-}
-
-/* disk block was taken off free list before being in a finished transatio=
n, or written to disk
-** journal_new blocks can be reused immediately, for any purpose
-*/=20
-inline int buffer_journal_new(const struct buffer_head *bh) {
-  if (bh)=20
-    return test_bit(BH_JNew, &bh->b_state) ;
-  else
-    return 0 ;
-}
-
-inline int mark_buffer_journal_new(struct buffer_head *bh) {
-  if (bh) {
-    set_bit(BH_JNew, &bh->b_state) ;
-  }
-  return 0 ;
-}
-
-inline int mark_buffer_not_journaled(struct buffer_head *bh) {
-  if (bh)=20
-    clear_bit(BH_JDirty, &bh->b_state) ;
-  return 0 ;
+static void clear_prepared_bits(struct buffer_head *bh) {
+  clear_buffer_journal_prepared (bh);
+  clear_buffer_journal_restore_dirty (bh);
 }
=20
 /* utility function to force a BUG if it is called without the big
@@ -628,9 +596,9 @@ static void reiserfs_end_ordered_io(stru
 static void submit_logged_buffer(struct buffer_head *bh) {
     get_bh(bh) ;
     bh->b_end_io =3D reiserfs_end_buffer_io_sync ;
-    mark_buffer_notjournal_new(bh) ;
+    clear_buffer_journal_new (bh);
     clear_buffer_dirty(bh) ;
-    if (!test_and_clear_bit(BH_JTest, &bh->b_state))
+    if (!test_clear_buffer_journal_test (bh))
         BUG();
     if (!buffer_uptodate(bh))
         BUG();
@@ -1384,7 +1352,7 @@ free_cnode:
 	/* note, we must clear the JDirty_wait bit after the up to date
 	** check, otherwise we race against our flushpage routine
 	*/
-	if (!test_and_clear_bit(BH_JDirty_wait, &cn->bh->b_state))
+        if (!test_clear_buffer_journal_dirty (cn->bh))
 	    BUG();
=20
         /* undo the inc from journal_mark_dirty */
@@ -1477,7 +1445,7 @@ static int write_one_transaction(struct=20
 	    lock_buffer(tmp_bh);
 	    if (cn->bh && can_dirty(cn) && buffer_dirty(tmp_bh)) {
 		if (!buffer_journal_dirty(tmp_bh) ||
-		    reiserfs_buffer_prepared(tmp_bh))
+		    buffer_journal_prepared(tmp_bh))
 		    BUG();
 		add_to_chunk(chunk, tmp_bh, NULL, write_chunk);
 		ret++;
@@ -1518,11 +1486,11 @@ static int dirty_one_transaction(struct=20
 	     * or restored.  If restored, we need to make sure
 	     * it actually gets marked dirty
 	     */
-	    mark_buffer_notjournal_new(cn->bh) ;
-	    if (test_bit(BH_JPrepared, &cn->bh->b_state)) {
-	        set_bit(BH_JRestore_dirty, &cn->bh->b_state);
+            clear_buffer_journal_new (cn->bh);
+            if (buffer_journal_prepared (cn->bh)) {
+                set_buffer_journal_restore_dirty (cn->bh);
 	    } else {
-	        set_bit(BH_JTest, &cn->bh->b_state);
+                set_buffer_journal_test (cn->bh);
 	        mark_buffer_dirty(cn->bh);
 	    }
         }=20
@@ -2778,8 +2746,8 @@ int journal_mark_dirty(struct reiserfs_t
   }
   p_s_sb->s_dirt =3D 1;
=20
-  prepared =3D test_and_clear_bit(BH_JPrepared, &bh->b_state) ;
-  clear_bit(BH_JRestore_dirty, &bh->b_state);
+  prepared =3D test_clear_buffer_journal_prepared (bh);
+  clear_buffer_journal_restore_dirty (bh);
   /* already in this transaction, we are done */
   if (buffer_journaled(bh)) {
     PROC_INFO_INC( p_s_sb, journal.mark_dirty_already );
@@ -2813,14 +2781,14 @@ int journal_mark_dirty(struct reiserfs_t
   if (buffer_journal_dirty(bh)) {
     count_already_incd =3D 1 ;
     PROC_INFO_INC( p_s_sb, journal.mark_dirty_notjournal );
-    mark_buffer_notjournal_dirty(bh) ;
+    clear_buffer_journal_dirty (bh);
   }
=20
   if (SB_JOURNAL(p_s_sb)->j_len > SB_JOURNAL(p_s_sb)->j_len_alloc) {
     SB_JOURNAL(p_s_sb)->j_len_alloc =3D SB_JOURNAL(p_s_sb)->j_len + JOURNA=
L_PER_BALANCE_CNT ;
   }
=20
-  set_bit(BH_JDirty, &bh->b_state) ;
+  set_buffer_journaled (bh);
=20
   /* now put this guy on the end */
   if (!cn) {
@@ -2914,10 +2882,10 @@ static int remove_from_transaction(struc
   }
   if (bh)
 	remove_journal_hash(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_table, NULL, bh->b=
_blocknr, 0) ;=20
-  mark_buffer_not_journaled(bh) ; /* don't log this one */
+  clear_buffer_journaled  (bh); /* don't log this one */
=20
   if (!already_cleaned) {
-    mark_buffer_notjournal_dirty(bh) ;=20
+    clear_buffer_journal_dirty (bh);
     put_bh(bh) ;
     if (atomic_read(&(bh->b_count)) < 0) {
       reiserfs_warning (p_s_sb, "journal-1752: remove from trans, b_count =
< 0");
@@ -3184,7 +3152,7 @@ int journal_mark_freed(struct reiserfs_t
   }
   /* if it is journal new, we just remove it from this transaction */
   if (bh && buffer_journal_new(bh)) {
-    mark_buffer_notjournal_new(bh) ;
+    clear_buffer_journal_new (bh);
     clear_prepared_bits(bh) ;
     reiserfs_clean_and_file_buffer(bh) ;
     cleaned =3D remove_from_transaction(p_s_sb, blocknr, cleaned) ;
@@ -3214,7 +3182,7 @@ int journal_mark_freed(struct reiserfs_t
 	    /* remove_from_transaction will brelse the buffer if it was=20
 	    ** in the current trans
 	    */
-	    mark_buffer_notjournal_dirty(cn->bh) ;
+            clear_buffer_journal_dirty (cn->bh);
 	    cleaned =3D 1 ;
 	    put_bh(cn->bh) ;
 	    if (atomic_read(&(cn->bh->b_count)) < 0) {
@@ -3320,18 +3288,18 @@ void reiserfs_restore_prepared_buffer(st
     if (!bh) {
 	return ;
     }
-    if (test_and_clear_bit(BH_JRestore_dirty, &bh->b_state) &&
+    if (test_clear_buffer_journal_restore_dirty (bh) &&
 	buffer_journal_dirty(bh)) {
 	struct reiserfs_journal_cnode *cn;
 	cn =3D get_journal_hash_dev(p_s_sb,
 	                          SB_JOURNAL(p_s_sb)->j_list_hash_table,
 				  bh->b_blocknr);
 	if (cn && can_dirty(cn)) {
-	    set_bit(BH_JTest, &bh->b_state);
+            set_buffer_journal_test (bh);
 	    mark_buffer_dirty(bh);
         }
     }
-    clear_bit(BH_JPrepared, &bh->b_state) ;
+    clear_buffer_journal_prepared (bh);
 }
=20
 extern struct tree_balance *cur_tb ;
@@ -3351,10 +3319,10 @@ int reiserfs_prepare_for_journal(struct=20
 	    return 0;
 	lock_buffer(bh);
     }
-    set_bit(BH_JPrepared, &bh->b_state);
+    set_buffer_journal_prepared (bh);
     if (test_clear_buffer_dirty(bh) && buffer_journal_dirty(bh))  {
-	clear_bit(BH_JTest, &bh->b_state);
-	set_bit(BH_JRestore_dirty, &bh->b_state);
+        clear_buffer_journal_test (bh);
+        set_buffer_journal_restore_dirty (bh);
     }
     unlock_buffer(bh);
     return 1;
@@ -3499,7 +3467,7 @@ static int do_journal_end(struct reiserf
   */
   trans_half =3D journal_trans_half(p_s_sb->s_blocksize);
   for (i =3D 0, cn =3D SB_JOURNAL(p_s_sb)->j_first ; cn ; cn =3D cn->next,=
 i++) {
-    if (test_bit(BH_JDirty, &cn->bh->b_state) ) {
+    if (buffer_journaled (cn->bh)) {
       jl_cn =3D get_cnode(p_s_sb) ;
       if (!jl_cn) {
         reiserfs_panic(p_s_sb, "journal-1676, get_cnode returned NULL\n") ;
@@ -3555,9 +3523,9 @@ static int do_journal_end(struct reiserf
   cn =3D SB_JOURNAL(p_s_sb)->j_first ;
   jindex =3D 1 ; /* start at one so we don't get the desc again */
   while(cn) {
-    clear_bit(BH_JNew, &(cn->bh->b_state)) ;
+    clear_buffer_journal_new (cn->bh);
     /* copy all the real blocks into log area.  dirty log blocks */
-    if (test_bit(BH_JDirty, &cn->bh->b_state)) {
+    if (buffer_journaled (cn->bh)) {
       struct buffer_head *tmp_bh ;
       char *addr;
       struct page *page;
@@ -3571,8 +3539,8 @@ static int do_journal_end(struct reiserf
       kunmap(page);
       mark_buffer_dirty(tmp_bh);
       jindex++ ;
-      set_bit(BH_JDirty_wait, &(cn->bh->b_state)) ;=20
-      clear_bit(BH_JDirty, &(cn->bh->b_state)) ;
+      set_buffer_journal_dirty (cn->bh);
+      clear_buffer_journaled (cn->bh);
     } else {
       /* JDirty cleared sometime during transaction.  don't log this one */
       reiserfs_warning(p_s_sb, "journal-2048: do_journal_end: BAD, buffer =
in journal hash, but not JDirty!") ;
Index: linux.t/fs/reiserfs/namei.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/namei.c	2004-08-12 09:36:58.238946448 -0400
+++ linux.t/fs/reiserfs/namei.c	2004-08-12 09:39:47.785171504 -0400
@@ -1289,7 +1289,7 @@ static int reiserfs_rename (struct inode
 	}
=20
 	RFALSE( S_ISDIR(old_inode_mode) &&=20
-		 !reiserfs_buffer_prepared(dot_dot_de.de_bh), "" );
+		 !buffer_journal_prepared(dot_dot_de.de_bh), "" );
=20
 	break;
     }
Index: linux.t/include/linux/reiserfs_fs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/include/linux/reiserfs_fs.h	2004-08-12 09:36:58.244945536 =
-0400
+++ linux.t/include/linux/reiserfs_fs.h	2004-08-12 09:39:47.788171048 -0400
@@ -1711,14 +1711,29 @@ struct reiserfs_journal_header {
 #define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_dev_bd, block, s-=
>s_blocksize)
=20
 enum reiserfs_bh_state_bits {
-    BH_JDirty =3D BH_PrivateStart,
+    BH_JDirty =3D BH_PrivateStart, /* buffer is in current transaction */
     BH_JDirty_wait,
-    BH_JNew,
-    BH_JPrepared,
+    BH_JNew,                     /* disk block was taken off free list bef=
ore
+                                  * being in a finished transaction, or
+                                  * written to disk. Can be reused immed. =
*/
+    BH_JPrepared,
     BH_JRestore_dirty,
     BH_JTest, // debugging only will go away
 };
=20
+BUFFER_FNS(JDirty, journaled);
+TAS_BUFFER_FNS(JDirty, journaled);
+BUFFER_FNS(JDirty_wait, journal_dirty);
+TAS_BUFFER_FNS(JDirty_wait, journal_dirty);
+BUFFER_FNS(JNew, journal_new);
+TAS_BUFFER_FNS(JNew, journal_new);
+BUFFER_FNS(JPrepared, journal_prepared);
+TAS_BUFFER_FNS(JPrepared, journal_prepared);
+BUFFER_FNS(JRestore_dirty, journal_restore_dirty);
+TAS_BUFFER_FNS(JRestore_dirty, journal_restore_dirty);
+BUFFER_FNS(JTest, journal_test);
+TAS_BUFFER_FNS(JTest, journal_test);
+
 /*
 ** transaction handle which is passed around for all journal calls
 */
@@ -1796,37 +1811,8 @@ int journal_transaction_should_end(struc
 int reiserfs_in_journal(struct super_block *p_s_sb, int bmap_nr, int bit_n=
r, int searchall, b_blocknr_t *next) ;
 int journal_begin(struct reiserfs_transaction_handle *, struct super_block=
 *p_s_sb, unsigned long) ;
=20
-int buffer_journaled(const struct buffer_head *bh) ;
-int mark_buffer_journal_new(struct buffer_head *bh) ;
 int reiserfs_allocate_list_bitmaps(struct super_block *s, struct reiserfs_=
list_bitmap *, int) ;
=20
-				/* why is this kerplunked right here? */
-static inline int reiserfs_buffer_prepared(const struct buffer_head *bh) {
-  if (bh && test_bit(BH_JPrepared, &bh->b_state))
-    return 1 ;
-  else
-    return 0 ;
-}
-
-/* buffer was journaled, waiting to get to disk */
-static inline int buffer_journal_dirty(const struct buffer_head *bh) {
-  if (bh)
-    return test_bit(BH_JDirty_wait, &bh->b_state) ;
-  else
-    return 0 ;
-}
-static inline int mark_buffer_notjournal_dirty(struct buffer_head *bh) {
-  if (bh)
-    clear_bit(BH_JDirty_wait, &bh->b_state) ;
-  return 0 ;
-}
-static inline int mark_buffer_notjournal_new(struct buffer_head *bh) {
-  if (bh) {
-    clear_bit(BH_JNew, &bh->b_state) ;
-  }
-  return 0 ;
-}
-
 void add_save_link (struct reiserfs_transaction_handle * th,
 					struct inode * inode, int truncate);
 void remove_save_link (struct inode * inode, int truncate);

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBYrjpLPWxlyuTD7IRAl1CAJ9b3YdfwTamxYZmx4I9ugJ3Wr2YCACgoVUA
Xj8a+7aHFKstBZ4+vKgeZZE=
=sWis
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
