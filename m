Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUJEPQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUJEPQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUJEPQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:16:19 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:34120 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269049AbUJEPIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:08:34 -0400
Date: Tue, 5 Oct 2004 11:08:33 -0400
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ReiserFS: Cleanup access of journal (cosmetic)
Message-ID: <20041005150833.GC30046@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch cleans up fs/reiserfs/journal.c such that repeated uses of
SB_JOURNAL(p_s_sb) are removed in favor of a local journal variable.
The compiler won't care, and it makes the code much easier to read.

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

 fs/reiserfs/journal.c          |  710 +++++++++++++++++++++---------------=
-----
 fs/reiserfs/procfs.c           |    2=20
 fs/reiserfs/super.c            |    9=20
 include/linux/reiserfs_fs_sb.h |   16=20
 4 files changed, 386 insertions(+), 351 deletions(-)

Index: linux.t/fs/reiserfs/journal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/journal.c	2004-08-12 14:00:39.917511280 -0400
+++ linux.t/fs/reiserfs/journal.c	2004-08-12 14:00:50.178951304 -0400
@@ -111,7 +111,8 @@ static int dirty_one_transaction(struct=20
 static void flush_async_commits(void *p);
=20
 static void init_journal_hash(struct super_block *p_s_sb) {
-  memset(SB_JOURNAL(p_s_sb)->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(s=
truct reiserfs_journal_cnode *)) ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
+  memset(journal->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reise=
rfs_journal_cnode *)) ;
 }
=20
 /*
@@ -155,17 +156,18 @@ allocate_bitmap_node(struct super_block=20
=20
 static struct reiserfs_bitmap_node *
 get_bitmap_node(struct super_block *p_s_sb) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_bitmap_node *bn =3D NULL;
-  struct list_head *entry =3D SB_JOURNAL(p_s_sb)->j_bitmap_nodes.next ;
+  struct list_head *entry =3D journal->j_bitmap_nodes.next ;
=20
-  SB_JOURNAL(p_s_sb)->j_used_bitmap_nodes++ ;
+  journal->j_used_bitmap_nodes++ ;
 repeat:
=20
-  if(entry !=3D &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) {
+  if(entry !=3D &journal->j_bitmap_nodes) {
     bn =3D list_entry(entry, struct reiserfs_bitmap_node, list) ;
     list_del(entry) ;
     memset(bn->data, 0, p_s_sb->s_blocksize) ;
-    SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes-- ;
+    journal->j_free_bitmap_nodes-- ;
     return bn ;
   }
   bn =3D allocate_bitmap_node(p_s_sb) ;
@@ -177,24 +179,26 @@ repeat:
 }
 static inline void free_bitmap_node(struct super_block *p_s_sb,
                                     struct reiserfs_bitmap_node *bn) {
-  SB_JOURNAL(p_s_sb)->j_used_bitmap_nodes-- ;
-  if (SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes > REISERFS_MAX_BITMAP_NODES)=
 {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
+  journal->j_used_bitmap_nodes-- ;
+  if (journal->j_free_bitmap_nodes > REISERFS_MAX_BITMAP_NODES) {
     reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
     reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
   } else {
-    list_add(&bn->list, &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-    SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes++ ;
+    list_add(&bn->list, &journal->j_bitmap_nodes) ;
+    journal->j_free_bitmap_nodes++ ;
   }
 }
=20
 static void allocate_bitmap_nodes(struct super_block *p_s_sb) {
   int i ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_bitmap_node *bn =3D NULL ;
   for (i =3D 0 ; i < REISERFS_MIN_BITMAP_NODES ; i++) {
     bn =3D allocate_bitmap_node(p_s_sb) ;
     if (bn) {
-      list_add(&bn->list, &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-      SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes++ ;
+      list_add(&bn->list, &journal->j_bitmap_nodes) ;
+      journal->j_free_bitmap_nodes++ ;
     } else {
       break ; // this is ok, we'll try again when more are needed=20
     }
@@ -245,16 +249,17 @@ static int free_list_bitmaps(struct supe
 }
=20
 static int free_bitmap_nodes(struct super_block *p_s_sb) {
-  struct list_head *next =3D SB_JOURNAL(p_s_sb)->j_bitmap_nodes.next ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
+  struct list_head *next =3D journal->j_bitmap_nodes.next ;
   struct reiserfs_bitmap_node *bn ;
=20
-  while(next !=3D &SB_JOURNAL(p_s_sb)->j_bitmap_nodes) {
+  while(next !=3D &journal->j_bitmap_nodes) {
     bn =3D list_entry(next, struct reiserfs_bitmap_node, list) ;
     list_del(next) ;
     reiserfs_kfree(bn->data, p_s_sb->s_blocksize, p_s_sb) ;
     reiserfs_kfree(bn, sizeof(struct reiserfs_bitmap_node), p_s_sb) ;
-    next =3D SB_JOURNAL(p_s_sb)->j_bitmap_nodes.next ;
-    SB_JOURNAL(p_s_sb)->j_free_bitmap_nodes-- ;
+    next =3D journal->j_bitmap_nodes.next ;
+    journal->j_free_bitmap_nodes-- ;
   }
=20
   return 0 ;
@@ -297,15 +302,16 @@ int reiserfs_allocate_list_bitmaps(struc
 static struct reiserfs_list_bitmap *
 get_list_bitmap(struct super_block *p_s_sb, struct reiserfs_journal_list *=
jl) {
   int i,j ;=20
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_list_bitmap *jb =3D NULL ;
=20
   for (j =3D 0 ; j < (JOURNAL_NUM_BITMAPS * 3) ; j++) {
-    i =3D SB_JOURNAL(p_s_sb)->j_list_bitmap_index ;
-    SB_JOURNAL(p_s_sb)->j_list_bitmap_index =3D (i + 1) % JOURNAL_NUM_BITM=
APS ;
-    jb =3D SB_JOURNAL(p_s_sb)->j_list_bitmap + i ;
-    if (SB_JOURNAL(p_s_sb)->j_list_bitmap[i].journal_list) {
-      flush_commit_list(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap[i].journ=
al_list, 1) ;
-      if (!SB_JOURNAL(p_s_sb)->j_list_bitmap[i].journal_list) {
+    i =3D journal->j_list_bitmap_index ;
+    journal->j_list_bitmap_index =3D (i + 1) % JOURNAL_NUM_BITMAPS ;
+    jb =3D journal->j_list_bitmap + i ;
+    if (journal->j_list_bitmap[i].journal_list) {
+      flush_commit_list(p_s_sb, journal->j_list_bitmap[i].journal_list, 1)=
 ;
+      if (!journal->j_list_bitmap[i].journal_list) {
 	break ;
       }
     } else {
@@ -350,22 +356,23 @@ static struct reiserfs_journal_cnode *al
 */
 static struct reiserfs_journal_cnode *get_cnode(struct super_block *p_s_sb=
) {
   struct reiserfs_journal_cnode *cn ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
=20
   reiserfs_check_lock_depth(p_s_sb, "get_cnode") ;
=20
-  if (SB_JOURNAL(p_s_sb)->j_cnode_free <=3D 0) {
+  if (journal->j_cnode_free <=3D 0) {
     return NULL ;
   }
-  SB_JOURNAL(p_s_sb)->j_cnode_used++ ;
-  SB_JOURNAL(p_s_sb)->j_cnode_free-- ;
-  cn =3D SB_JOURNAL(p_s_sb)->j_cnode_free_list ;
+  journal->j_cnode_used++ ;
+  journal->j_cnode_free-- ;
+  cn =3D journal->j_cnode_free_list ;
   if (!cn) {
     return cn ;
   }
   if (cn->next) {
     cn->next->prev =3D NULL ;
   }
-  SB_JOURNAL(p_s_sb)->j_cnode_free_list =3D cn->next ;
+  journal->j_cnode_free_list =3D cn->next ;
   memset(cn, 0, sizeof(struct reiserfs_journal_cnode)) ;
   return cn ;
 }
@@ -374,18 +381,19 @@ static struct reiserfs_journal_cnode *ge
 ** returns a cnode to the free list=20
 */
 static void free_cnode(struct super_block *p_s_sb, struct reiserfs_journal=
_cnode *cn) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
=20
   reiserfs_check_lock_depth(p_s_sb, "free_cnode") ;
=20
-  SB_JOURNAL(p_s_sb)->j_cnode_used-- ;
-  SB_JOURNAL(p_s_sb)->j_cnode_free++ ;
+  journal->j_cnode_used-- ;
+  journal->j_cnode_free++ ;
   /* memset(cn, 0, sizeof(struct reiserfs_journal_cnode)) ; */
-  cn->next =3D SB_JOURNAL(p_s_sb)->j_cnode_free_list ;
-  if (SB_JOURNAL(p_s_sb)->j_cnode_free_list) {
-    SB_JOURNAL(p_s_sb)->j_cnode_free_list->prev =3D cn ;
+  cn->next =3D journal->j_cnode_free_list ;
+  if (journal->j_cnode_free_list) {
+    journal->j_cnode_free_list->prev =3D cn ;
   }
   cn->prev =3D NULL ; /* not needed with the memset, but I might kill the =
memset, and forget to do this */
-  SB_JOURNAL(p_s_sb)->j_cnode_free_list =3D cn ;
+  journal->j_cnode_free_list =3D cn ;
 }
=20
 static void clear_prepared_bits(struct buffer_head *bh) {
@@ -424,9 +432,10 @@ get_journal_hash_dev(struct super_block=20
=20
 /* returns a cnode with same size, block number and dev as bh in the curre=
nt transaction hash.  NULL if not found */
 static inline struct reiserfs_journal_cnode *get_journal_hash(struct super=
_block *p_s_sb, struct buffer_head *bh) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn ;
   if (bh) {
-    cn =3D  get_journal_hash_dev(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_table,=
 bh->b_blocknr);
+    cn =3D  get_journal_hash_dev(p_s_sb, journal->j_hash_table, bh->b_bloc=
knr);
   }
   else {
     return (struct reiserfs_journal_cnode *)0 ;
@@ -455,6 +464,7 @@ static inline struct reiserfs_journal_cn
 int reiserfs_in_journal(struct super_block *p_s_sb,
                         int bmap_nr, int bit_nr, int search_all,=20
 			b_blocknr_t *next_zero_bit) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn ;
   struct reiserfs_list_bitmap *jb ;
   int i ;
@@ -470,7 +480,7 @@ int reiserfs_in_journal(struct super_blo
   if (search_all) {
     for (i =3D 0 ; i < JOURNAL_NUM_BITMAPS ; i++) {
       PROC_INFO_INC( p_s_sb, journal.in_journal_bitmap );
-      jb =3D SB_JOURNAL(p_s_sb)->j_list_bitmap + i ;
+      jb =3D journal->j_list_bitmap + i ;
       if (jb->journal_list && jb->bitmaps[bmap_nr] &&
           test_bit(bit_nr, (unsigned long *)jb->bitmaps[bmap_nr]->data)) {
 	*next_zero_bit =3D find_next_zero_bit((unsigned long *)
@@ -483,12 +493,12 @@ int reiserfs_in_journal(struct super_blo
=20
   bl =3D bmap_nr * (p_s_sb->s_blocksize << 3) + bit_nr;
   /* is it in any old transactions? */
-  if (search_all && (cn =3D get_journal_hash_dev(p_s_sb, SB_JOURNAL(p_s_sb=
)->j_list_hash_table, bl))) {
+  if (search_all && (cn =3D get_journal_hash_dev(p_s_sb, journal->j_list_h=
ash_table, bl))) {
     return 1;=20
   }
=20
   /* is it in the current transaction.  This should never happen */
-  if ((cn =3D get_journal_hash_dev(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_tabl=
e, bl))) {
+  if ((cn =3D get_journal_hash_dev(p_s_sb, journal->j_hash_table, bl))) {
     BUG();
     return 1;=20
   }
@@ -557,7 +567,8 @@ static void cleanup_freed_for_journal_li
 static int journal_list_still_alive(struct super_block *s,
                                     unsigned long trans_id)
 {
-    struct list_head *entry =3D &SB_JOURNAL(s)->j_journal_list;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
+    struct list_head *entry =3D &journal->j_journal_list;
     struct reiserfs_journal_list *jl;
=20
     if (!list_empty(entry)) {
@@ -823,6 +834,7 @@ loop_next:
 }
=20
 static int flush_older_commits(struct super_block *s, struct reiserfs_jour=
nal_list *jl) {
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
     struct reiserfs_journal_list *other_jl;
     struct reiserfs_journal_list *first_jl;
     struct list_head *entry;
@@ -838,7 +850,7 @@ find_first:
     entry =3D jl->j_list.prev;
     while(1) {
 	other_jl =3D JOURNAL_LIST_ENTRY(entry);
-	if (entry =3D=3D &SB_JOURNAL(s)->j_journal_list ||
+	if (entry =3D=3D &journal->j_journal_list ||
 	    atomic_read(&other_jl->j_older_commits_done))
 	    break;
=20
@@ -875,7 +887,7 @@ find_first:
 		}
 	    }
 	    entry =3D entry->next;
-	    if (entry =3D=3D &SB_JOURNAL(s)->j_journal_list)
+	    if (entry =3D=3D &journal->j_journal_list)
 		return 0;
 	} else {
 	    return 0;
@@ -903,6 +915,7 @@ static int flush_commit_list(struct supe
   int bn ;
   struct buffer_head *tbh =3D NULL ;
   unsigned long trans_id =3D jl->j_trans_id;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (s);
   int barrier =3D 0;
=20
   reiserfs_check_lock_depth(s, "flush_commit_list") ;
@@ -916,7 +929,7 @@ static int flush_commit_list(struct supe
   */
   if (jl->j_len <=3D 0)
     BUG();
-  if (trans_id =3D=3D SB_JOURNAL(s)->j_trans_id)
+  if (trans_id =3D=3D journal->j_trans_id)
     BUG();
=20
   get_journal_list(jl);
@@ -947,8 +960,8 @@ static int flush_commit_list(struct supe
=20
   if (!list_empty(&jl->j_bh_list)) {
       unlock_kernel();
-      write_ordered_buffers(&SB_JOURNAL(s)->j_dirty_buffers_lock,
-                            SB_JOURNAL(s), jl, &jl->j_bh_list);
+      write_ordered_buffers(&journal->j_dirty_buffers_lock,
+                            journal, jl, &jl->j_bh_list);
       lock_kernel();
   }
   if (!list_empty(&jl->j_bh_list))
@@ -957,7 +970,7 @@ static int flush_commit_list(struct supe
    * for the description block and all the log blocks, submit any buffers
    * that haven't already reached the disk
    */
-  atomic_inc(&SB_JOURNAL(s)->j_async_throttle);
+  atomic_inc(&journal->j_async_throttle);
   for (i =3D 0 ; i < (jl->j_len + 1) ; i++) {
     bn =3D SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start+i) %
          SB_ONDISK_JOURNAL_SIZE(s);
@@ -966,7 +979,7 @@ static int flush_commit_list(struct supe
 	ll_rw_block(WRITE, 1, &tbh) ;
     put_bh(tbh) ;
   }
-  atomic_dec(&SB_JOURNAL(s)->j_async_throttle);
+  atomic_dec(&journal->j_async_throttle);
=20
   /* wait on everything written so far before writing the commit=20
    * if we are in barrier mode, send the commit down now
@@ -1017,13 +1030,13 @@ static int flush_commit_list(struct supe
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
   bforget(jl->j_commit_bh) ;
-  if (SB_JOURNAL(s)->j_last_commit_id !=3D 0 &&
-     (jl->j_trans_id - SB_JOURNAL(s)->j_last_commit_id) !=3D 1) {
+  if (journal->j_last_commit_id !=3D 0 &&
+     (jl->j_trans_id - journal->j_last_commit_id) !=3D 1) {
       reiserfs_warning(s, "clm-2200: last commit %lu, current %lu",
-                       SB_JOURNAL(s)->j_last_commit_id,
+                       journal->j_last_commit_id,
 		       jl->j_trans_id);
   }
-  SB_JOURNAL(s)->j_last_commit_id =3D jl->j_trans_id;
+  journal->j_last_commit_id =3D jl->j_trans_id;
=20
   /* now, every commit block is on the disk.  It is safe to allow blocks f=
reed during this transaction to be reallocated */
   cleanup_freed_for_journal_list(s, jl) ;
@@ -1068,6 +1081,7 @@ struct reiserfs_journal_list *, unsigned
 ** block to be reallocated for data blocks if it had been deleted.
 */
 static void remove_all_from_journal_list(struct super_block *p_s_sb, struc=
t reiserfs_journal_list *jl, int debug) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn, *last ;
   cn =3D jl->j_realblock ;
=20
@@ -1081,7 +1095,7 @@ static void remove_all_from_journal_list
                          cn->bh ? 1: 0, cn->state) ;
       }
       cn->state =3D 0 ;
-      remove_journal_hash(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_hash_table, j=
l, cn->blocknr, 1) ;
+      remove_journal_hash(p_s_sb, journal->j_list_hash_table, jl, cn->bloc=
knr, 1) ;
     }
     last =3D cn ;
     cn =3D cn->next ;
@@ -1099,37 +1113,38 @@ static void remove_all_from_journal_list
 */
 static int _update_journal_header_block(struct super_block *p_s_sb, unsign=
ed long offset, unsigned long trans_id) {
   struct reiserfs_journal_header *jh ;
-  if (trans_id >=3D SB_JOURNAL(p_s_sb)->j_last_flush_trans_id) {
-    if (buffer_locked((SB_JOURNAL(p_s_sb)->j_header_bh)))  {
-      wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ;
-      if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
+  if (trans_id >=3D journal->j_last_flush_trans_id) {
+    if (buffer_locked((journal->j_header_bh)))  {
+      wait_on_buffer((journal->j_header_bh)) ;
+      if (!buffer_uptodate(journal->j_header_bh)) {
         reiserfs_panic(p_s_sb, "journal-699: buffer write failed\n") ;
       }
     }
-    SB_JOURNAL(p_s_sb)->j_last_flush_trans_id =3D trans_id ;
-    SB_JOURNAL(p_s_sb)->j_first_unflushed_offset =3D offset ;
-    jh =3D (struct reiserfs_journal_header *)(SB_JOURNAL(p_s_sb)->j_header=
_bh->b_data) ;
+    journal->j_last_flush_trans_id =3D trans_id ;
+    journal->j_first_unflushed_offset =3D offset ;
+    jh =3D (struct reiserfs_journal_header *)(journal->j_header_bh->b_data=
) ;
     jh->j_last_flush_trans_id =3D cpu_to_le32(trans_id) ;
     jh->j_first_unflushed_offset =3D cpu_to_le32(offset) ;
-    jh->j_mount_id =3D cpu_to_le32(SB_JOURNAL(p_s_sb)->j_mount_id) ;
+    jh->j_mount_id =3D cpu_to_le32(journal->j_mount_id) ;
=20
     if (reiserfs_barrier_flush(p_s_sb)) {
 	int ret;
-	lock_buffer(SB_JOURNAL(p_s_sb)->j_header_bh);
-	ret =3D submit_barrier_buffer(SB_JOURNAL(p_s_sb)->j_header_bh);
+	lock_buffer(journal->j_header_bh);
+	ret =3D submit_barrier_buffer(journal->j_header_bh);
 	if (ret =3D=3D -EOPNOTSUPP) {
-	    set_buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh);
+	    set_buffer_uptodate(journal->j_header_bh);
 	    disable_barrier(p_s_sb);
 	    goto sync;
 	}
-	wait_on_buffer(SB_JOURNAL(p_s_sb)->j_header_bh);
-	check_barrier_completion(p_s_sb, SB_JOURNAL(p_s_sb)->j_header_bh);
+	wait_on_buffer(journal->j_header_bh);
+	check_barrier_completion(p_s_sb, journal->j_header_bh);
     } else {
 sync:
-	set_buffer_dirty(SB_JOURNAL(p_s_sb)->j_header_bh) ;
-	sync_dirty_buffer(SB_JOURNAL(p_s_sb)->j_header_bh) ;
+	set_buffer_dirty(journal->j_header_bh) ;
+	sync_dirty_buffer(journal->j_header_bh) ;
     }
-    if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
+    if (!buffer_uptodate(journal->j_header_bh)) {
       reiserfs_warning (p_s_sb, "journal-837: IO error during journal repl=
ay");
       return -EIO ;
     }
@@ -1154,13 +1169,14 @@ static int flush_older_journal_lists(str
 {
     struct list_head *entry;
     struct reiserfs_journal_list *other_jl ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
     unsigned long trans_id =3D jl->j_trans_id;
=20
     /* we know we are the only ones flushing things, no extra race
      * protection is required.
      */
 restart:
-    entry =3D SB_JOURNAL(p_s_sb)->j_journal_list.next;
+    entry =3D journal->j_journal_list.next;
     other_jl =3D JOURNAL_LIST_ENTRY(entry);
     if (other_jl->j_trans_id < trans_id) {
 	/* do not flush all */
@@ -1174,9 +1190,10 @@ restart:
=20
 static void del_from_work_list(struct super_block *s,
                                struct reiserfs_journal_list *jl) {
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
     if (!list_empty(&jl->j_working_list)) {
 	list_del_init(&jl->j_working_list);
-	SB_JOURNAL(s)->j_num_work_lists--;
+	journal->j_num_work_lists--;
     }
 }
=20
@@ -1198,27 +1215,28 @@ static int flush_journal_list(struct sup
   int was_dirty =3D 0 ;
   struct buffer_head *saved_bh ;=20
   unsigned long j_len_saved =3D jl->j_len ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (s);
=20
   if (j_len_saved <=3D 0) {
     BUG();
   }
=20
-  if (atomic_read(&SB_JOURNAL(s)->j_wcount) !=3D 0) {
+  if (atomic_read(&journal->j_wcount) !=3D 0) {
     reiserfs_warning(s, "clm-2048: flush_journal_list called with wcount %=
d",
-                      atomic_read(&SB_JOURNAL(s)->j_wcount)) ;
+                      atomic_read(&journal->j_wcount)) ;
   }
   if (jl->j_trans_id =3D=3D 0)
     BUG();
=20
   /* if flushall =3D=3D 0, the lock is already held */
   if (flushall) {
-      down(&SB_JOURNAL(s)->j_flush_sem);
-  } else if (!down_trylock(&SB_JOURNAL(s)->j_flush_sem)) {
+      down(&journal->j_flush_sem);
+  } else if (!down_trylock(&journal->j_flush_sem)) {
       BUG();
   }
=20
   count =3D 0 ;
-  if (j_len_saved > SB_JOURNAL_TRANS_MAX(s)) {
+  if (j_len_saved > journal->j_trans_max) {
     reiserfs_panic(s, "journal-715: flush_journal_list, length is %lu, tra=
ns id %lu\n", j_len_saved, jl->j_trans_id);
     return 0 ;
   }
@@ -1246,7 +1264,7 @@ static int flush_journal_list(struct sup
   /* loop through each cnode, see if we need to write it,=20
   ** or wait on a more recent transaction, or just ignore it=20
   */
-  if (atomic_read(&(SB_JOURNAL(s)->j_wcount)) !=3D 0) {
+  if (atomic_read(&(journal->j_wcount)) !=3D 0) {
     reiserfs_panic(s, "journal-844: panic journal list is flushing, wcount=
 is not 0\n") ;
   }
   cn =3D jl->j_realblock ;
@@ -1386,16 +1404,16 @@ flush_older_and_return:
   }
   remove_all_from_journal_list(s, jl, 0) ;
   list_del(&jl->j_list);
-  SB_JOURNAL(s)->j_num_lists--;
+  journal->j_num_lists--;
   del_from_work_list(s, jl);
=20
-  if (SB_JOURNAL(s)->j_last_flush_id !=3D 0 &&
-     (jl->j_trans_id - SB_JOURNAL(s)->j_last_flush_id) !=3D 1) {
+  if (journal->j_last_flush_id !=3D 0 &&
+     (jl->j_trans_id - journal->j_last_flush_id) !=3D 1) {
       reiserfs_warning(s, "clm-2201: last flush %lu, current %lu",
-                       SB_JOURNAL(s)->j_last_flush_id,
+                       journal->j_last_flush_id,
 		       jl->j_trans_id);
   }
-  SB_JOURNAL(s)->j_last_flush_id =3D jl->j_trans_id;
+  journal->j_last_flush_id =3D jl->j_trans_id;
=20
   /* not strictly required since we are freeing the list, but it should
    * help find code using dead lists later on
@@ -1409,7 +1427,7 @@ flush_older_and_return:
   jl->j_state =3D 0;
   put_journal_list(s, jl);
   if (flushall)
-    up(&SB_JOURNAL(s)->j_flush_sem);
+    up(&journal->j_flush_sem);
   return 0 ;
 }=20
=20
@@ -1511,9 +1529,10 @@ static int kupdate_transactions(struct s
     unsigned long orig_trans_id =3D jl->j_trans_id;
     struct buffer_chunk chunk;
     struct list_head *entry;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
     chunk.nr =3D 0;
=20
-    down(&SB_JOURNAL(s)->j_flush_sem);
+    down(&journal->j_flush_sem);
     if (!journal_list_still_alive(s, orig_trans_id)) {
 	goto done;
     }
@@ -1539,7 +1558,7 @@ static int kupdate_transactions(struct s
 	entry =3D jl->j_list.next;
=20
 	/* did we wrap? */
-	if (entry =3D=3D &SB_JOURNAL(s)->j_journal_list) {
+	if (entry =3D=3D &journal->j_journal_list) {
 	    break;
         }
 	jl =3D JOURNAL_LIST_ENTRY(entry);
@@ -1553,7 +1572,7 @@ static int kupdate_transactions(struct s
     }
=20
 done:
-    up(&SB_JOURNAL(s)->j_flush_sem);
+    up(&journal->j_flush_sem);
     return ret;
 }
=20
@@ -1576,6 +1595,7 @@ static int flush_used_journal_lists(stru
     struct reiserfs_journal_list *tjl;
     struct reiserfs_journal_list *flush_jl;
     unsigned long trans_id;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
=20
     flush_jl =3D tjl =3D jl;
=20
@@ -1594,7 +1614,7 @@ static int flush_used_journal_lists(stru
 	}
 	len +=3D cur_len;
 	flush_jl =3D tjl;
-	if (tjl->j_list.next =3D=3D &SB_JOURNAL(s)->j_journal_list)
+	if (tjl->j_list.next =3D=3D &journal->j_journal_list)
 	    break;
 	tjl =3D JOURNAL_LIST_ENTRY(tjl->j_list.next);
     }
@@ -1650,21 +1670,22 @@ void remove_journal_hash(struct super_bl
 }
=20
 static void free_journal_ram(struct super_block *p_s_sb) {
-  reiserfs_kfree(SB_JOURNAL(p_s_sb)->j_current_jl,
+  struct reiserfs_journal *journal =3D SB_JOURNAL(p_s_sb);
+  reiserfs_kfree(journal->j_current_jl,
                  sizeof(struct reiserfs_journal_list), p_s_sb);
-  SB_JOURNAL(p_s_sb)->j_num_lists--;
+  journal->j_num_lists--;
=20
-  vfree(SB_JOURNAL(p_s_sb)->j_cnode_free_orig) ;
-  free_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap) ;
+  vfree(journal->j_cnode_free_orig) ;
+  free_list_bitmaps(p_s_sb, journal->j_list_bitmap) ;
   free_bitmap_nodes(p_s_sb) ; /* must be after free_list_bitmaps */
-  if (SB_JOURNAL(p_s_sb)->j_header_bh) {
-    brelse(SB_JOURNAL(p_s_sb)->j_header_bh) ;
+  if (journal->j_header_bh) {
+    brelse(journal->j_header_bh) ;
   }
   /* j_header_bh is on the journal dev, make sure not to release the journ=
al
    * dev until we brelse j_header_bh
    */
-  release_journal_dev(p_s_sb, SB_JOURNAL(p_s_sb));
-  vfree(SB_JOURNAL(p_s_sb)) ;
+  release_journal_dev(p_s_sb, journal);
+  vfree(journal) ;
 }
=20
 /*
@@ -1719,7 +1740,7 @@ static int journal_compare_desc_commit(s
 			               struct reiserfs_journal_commit *commit) {
   if (get_commit_trans_id (commit) !=3D get_desc_trans_id (desc) ||=20
       get_commit_trans_len (commit) !=3D get_desc_trans_len (desc) ||=20
-      get_commit_trans_len (commit) > SB_JOURNAL_TRANS_MAX(p_s_sb) ||=20
+      get_commit_trans_len (commit) > SB_JOURNAL(p_s_sb)->j_trans_max ||
       get_commit_trans_len (commit) <=3D 0=20
   ) {
     return 1 ;
@@ -1755,7 +1776,7 @@ static int journal_transaction_is_valid(
 		     *newest_mount_id) ;
       return -1 ;
     }
-    if ( get_desc_trans_len(desc) > SB_JOURNAL_TRANS_MAX(p_s_sb) ) {
+    if ( get_desc_trans_len(desc) > SB_JOURNAL(p_s_sb)->j_trans_max ) {
       reiserfs_warning(p_s_sb, "journal-2018: Bad transaction length %d en=
countered, ignoring transaction", get_desc_trans_len(desc));
       return -1 ;
     }
@@ -1808,6 +1829,7 @@ static void brelse_array(struct buffer_h
 */
 static int journal_read_transaction(struct super_block *p_s_sb, unsigned l=
ong cur_dblock, unsigned long oldest_start,=20
 				    unsigned long oldest_trans_id, unsigned long newest_mount_id) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_desc *desc ;
   struct reiserfs_journal_commit *commit ;
   unsigned long trans_id =3D 0 ;
@@ -1940,9 +1962,9 @@ abort_replay:
 		 cur_dblock -  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb)) ;
  =20
   /* init starting values for the first transaction, in case this is the l=
ast transaction to be replayed. */
-  SB_JOURNAL(p_s_sb)->j_start =3D cur_dblock - SB_ONDISK_JOURNAL_1st_BLOCK=
(p_s_sb) ;
-  SB_JOURNAL(p_s_sb)->j_last_flush_trans_id =3D trans_id ;
-  SB_JOURNAL(p_s_sb)->j_trans_id =3D trans_id + 1;
+  journal->j_start =3D cur_dblock - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
+  journal->j_last_flush_trans_id =3D trans_id ;
+  journal->j_trans_id =3D trans_id + 1;
   brelse(c_bh) ;
   brelse(d_bh) ;
   reiserfs_kfree(log_blocks, le32_to_cpu(desc->j_len) * sizeof(struct buff=
er_head *), p_s_sb) ;
@@ -2002,6 +2024,7 @@ struct buffer_head * reiserfs_breada (st
 ** On exit, it sets things up so the first transaction will work correctly.
 */
 static int journal_read(struct super_block *p_s_sb) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_desc *desc ;
   unsigned long oldest_trans_id =3D 0;
   unsigned long oldest_invalid_trans_id =3D 0 ;
@@ -2019,20 +2042,20 @@ static int journal_read(struct super_blo
=20
   cur_dblock =3D SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
   reiserfs_info (p_s_sb, "checking transaction log (%s)\n",
-	 bdevname(SB_JOURNAL(p_s_sb)->j_dev_bd, b));
+	 bdevname(journal->j_dev_bd, b));
   start =3D get_seconds();
=20
   /* step 1, read in the journal header block.  Check the transaction it s=
ays=20
   ** is the first unflushed, and if that transaction is not valid,=20
   ** replay is done
   */
-  SB_JOURNAL(p_s_sb)->j_header_bh =3D journal_bread(p_s_sb,
+  journal->j_header_bh =3D journal_bread(p_s_sb,
 					   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +=20
 					   SB_ONDISK_JOURNAL_SIZE(p_s_sb));
-  if (!SB_JOURNAL(p_s_sb)->j_header_bh) {
+  if (!journal->j_header_bh) {
     return 1 ;
   }
-  jh =3D (struct reiserfs_journal_header *)(SB_JOURNAL(p_s_sb)->j_header_b=
h->b_data) ;
+  jh =3D (struct reiserfs_journal_header *)(journal->j_header_bh->b_data) ;
   if (le32_to_cpu(jh->j_first_unflushed_offset) >=3D 0 &&=20
       le32_to_cpu(jh->j_first_unflushed_offset) < SB_ONDISK_JOURNAL_SIZE(p=
_s_sb) &&=20
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
@@ -2071,7 +2094,7 @@ static int journal_read(struct super_blo
   while(continue_replay && cur_dblock < (SB_ONDISK_JOURNAL_1st_BLOCK(p_s_s=
b) + SB_ONDISK_JOURNAL_SIZE(p_s_sb))) {
     /* Note that it is required for blocksize of primary fs device and jou=
rnal
        device to be the same */
-    d_bh =3D reiserfs_breada(SB_JOURNAL(p_s_sb)->j_dev_bd, cur_dblock, p_s=
_sb->s_blocksize,
+    d_bh =3D reiserfs_breada(journal->j_dev_bd, cur_dblock, p_s_sb->s_bloc=
ksize,
 			   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb)=
) ;
     ret =3D journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_tra=
ns_id, &newest_mount_id) ;
     if (ret =3D=3D 1) {
@@ -2122,7 +2145,7 @@ start_log_replay:
     } else if (ret !=3D 0) {
       break ;
     }
-    cur_dblock =3D SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb=
)->j_start ;
+    cur_dblock =3D SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + journal->j_start ;
     replay_count++ ;
    if (cur_dblock =3D=3D oldest_start)
         break;
@@ -2137,23 +2160,23 @@ start_log_replay:
   ** copy the trans_id from the header
   */
   if (valid_journal_header && replay_count =3D=3D 0) {=20
-    SB_JOURNAL(p_s_sb)->j_start =3D le32_to_cpu(jh->j_first_unflushed_offs=
et) ;
-    SB_JOURNAL(p_s_sb)->j_trans_id =3D le32_to_cpu(jh->j_last_flush_trans_=
id) + 1;
-    SB_JOURNAL(p_s_sb)->j_last_flush_trans_id =3D le32_to_cpu(jh->j_last_f=
lush_trans_id) ;
-    SB_JOURNAL(p_s_sb)->j_mount_id =3D le32_to_cpu(jh->j_mount_id) + 1;
+    journal->j_start =3D le32_to_cpu(jh->j_first_unflushed_offset) ;
+    journal->j_trans_id =3D le32_to_cpu(jh->j_last_flush_trans_id) + 1;
+    journal->j_last_flush_trans_id =3D le32_to_cpu(jh->j_last_flush_trans_=
id) ;
+    journal->j_mount_id =3D le32_to_cpu(jh->j_mount_id) + 1;
   } else {
-    SB_JOURNAL(p_s_sb)->j_mount_id =3D newest_mount_id + 1 ;
+    journal->j_mount_id =3D newest_mount_id + 1 ;
   }
   reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1299: Setting "
-                 "newest_mount_id to %lu", SB_JOURNAL(p_s_sb)->j_mount_id)=
 ;
-  SB_JOURNAL(p_s_sb)->j_first_unflushed_offset =3D SB_JOURNAL(p_s_sb)->j_s=
tart ;=20
+                 "newest_mount_id to %lu", journal->j_mount_id) ;
+  journal->j_first_unflushed_offset =3D journal->j_start ;
   if (replay_count > 0) {
     reiserfs_info (p_s_sb, "replayed %d transactions in %lu seconds\n",
 		   replay_count, get_seconds() - start) ;
   }
   if (!bdev_read_only(p_s_sb->s_bdev) &&=20
-       _update_journal_header_block(p_s_sb, SB_JOURNAL(p_s_sb)->j_start,=
=20
-                                   SB_JOURNAL(p_s_sb)->j_last_flush_trans_=
id))
+       _update_journal_header_block(p_s_sb, journal->j_start,
+                                   journal->j_last_flush_trans_id))
   {
       /* replay failed, caller must call free_journal_ram and abort
       ** the mount
@@ -2288,12 +2311,12 @@ int journal_init(struct super_block *p_s
 	return 1 ;
     }
     memset(journal, 0, sizeof(struct reiserfs_journal)) ;
-    INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-    INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
-    INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_working_list);
-    INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_journal_list);
+    INIT_LIST_HEAD(&journal->j_bitmap_nodes) ;
+    INIT_LIST_HEAD (&journal->j_prealloc_list);
+    INIT_LIST_HEAD(&journal->j_working_list);
+    INIT_LIST_HEAD(&journal->j_journal_list);
     if (reiserfs_allocate_list_bitmaps(p_s_sb,
-				       SB_JOURNAL(p_s_sb)->j_list_bitmap,
+				       journal->j_list_bitmap,
  				       SB_BMAP_NR(p_s_sb)))
 	goto free_and_return ;
     allocate_bitmap_nodes(p_s_sb) ;
@@ -2338,108 +2361,108 @@ int journal_init(struct super_block *p_s
 			   "(device %s) does not match to magic found in super "
 			   "block %x",
 			   jh->jh_journal.jp_journal_magic,
-			   bdevname( SB_JOURNAL(p_s_sb)->j_dev_bd, b),
+			   bdevname( journal->j_dev_bd, b),
 			   sb_jp_journal_magic(rs));
 	 brelse (bhjh);
 	 goto free_and_return;
   }
     =20
-  SB_JOURNAL_TRANS_MAX(p_s_sb)      =3D le32_to_cpu (jh->jh_journal.jp_jou=
rnal_trans_max);
-  SB_JOURNAL_MAX_BATCH(p_s_sb)      =3D le32_to_cpu (jh->jh_journal.jp_jou=
rnal_max_batch);
-  SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) =3D le32_to_cpu (jh->jh_journal.jp_jou=
rnal_max_commit_age);
-  SB_JOURNAL_MAX_TRANS_AGE(p_s_sb)  =3D JOURNAL_MAX_TRANS_AGE;
+  journal->j_trans_max      =3D le32_to_cpu (jh->jh_journal.jp_journal_tra=
ns_max);
+  journal->j_max_batch      =3D le32_to_cpu (jh->jh_journal.jp_journal_max=
_batch);
+  journal->j_max_commit_age =3D le32_to_cpu (jh->jh_journal.jp_journal_max=
_commit_age);
+  journal->j_max_trans_age =3D JOURNAL_MAX_TRANS_AGE;
=20
-  if (SB_JOURNAL_TRANS_MAX(p_s_sb)) {
+  if (journal->j_trans_max) {
     /* make sure these parameters are available, assign it if they are not=
 */
-    __u32 initial =3D SB_JOURNAL_TRANS_MAX(p_s_sb);
+    __u32 initial =3D journal->j_trans_max;
     __u32 ratio =3D 1;
    =20
     if (p_s_sb->s_blocksize < 4096)
       ratio =3D 4096 / p_s_sb->s_blocksize;
    =20
-    if (SB_ONDISK_JOURNAL_SIZE(p_s_sb)/SB_JOURNAL_TRANS_MAX(p_s_sb) < JOUR=
NAL_MIN_RATIO)
-      SB_JOURNAL_TRANS_MAX(p_s_sb) =3D SB_ONDISK_JOURNAL_SIZE(p_s_sb) / JO=
URNAL_MIN_RATIO;
-    if (SB_JOURNAL_TRANS_MAX(p_s_sb) > JOURNAL_TRANS_MAX_DEFAULT / ratio)
-      SB_JOURNAL_TRANS_MAX(p_s_sb) =3D JOURNAL_TRANS_MAX_DEFAULT / ratio;
-    if (SB_JOURNAL_TRANS_MAX(p_s_sb) < JOURNAL_TRANS_MIN_DEFAULT / ratio)
-      SB_JOURNAL_TRANS_MAX(p_s_sb) =3D JOURNAL_TRANS_MIN_DEFAULT / ratio;
+    if (SB_ONDISK_JOURNAL_SIZE(p_s_sb)/journal->j_trans_max < JOURNAL_MIN_=
RATIO)
+      journal->j_trans_max =3D SB_ONDISK_JOURNAL_SIZE(p_s_sb) / JOURNAL_MI=
N_RATIO;
+    if (journal->j_trans_max > JOURNAL_TRANS_MAX_DEFAULT / ratio)
+      journal->j_trans_max =3D JOURNAL_TRANS_MAX_DEFAULT / ratio;
+    if (journal->j_trans_max < JOURNAL_TRANS_MIN_DEFAULT / ratio)
+      journal->j_trans_max =3D JOURNAL_TRANS_MIN_DEFAULT / ratio;
    =20
-    if (SB_JOURNAL_TRANS_MAX(p_s_sb) !=3D initial)
+    if (journal->j_trans_max !=3D initial)
       reiserfs_warning (p_s_sb, "sh-461: journal_init: wrong transaction m=
ax size (%u). Changed to %u",
-	      initial, SB_JOURNAL_TRANS_MAX(p_s_sb));
+	      initial, journal->j_trans_max);
=20
-    SB_JOURNAL_MAX_BATCH(p_s_sb) =3D SB_JOURNAL_TRANS_MAX(p_s_sb)*
+    journal->j_max_batch =3D journal->j_trans_max*
       JOURNAL_MAX_BATCH_DEFAULT/JOURNAL_TRANS_MAX_DEFAULT;
   } =20
  =20
-  if (!SB_JOURNAL_TRANS_MAX(p_s_sb)) {
+  if (!journal->j_trans_max) {
     /*we have the file system was created by old version of mkreiserfs=20
       so this field contains zero value */
-    SB_JOURNAL_TRANS_MAX(p_s_sb)      =3D JOURNAL_TRANS_MAX_DEFAULT ;
-    SB_JOURNAL_MAX_BATCH(p_s_sb)      =3D JOURNAL_MAX_BATCH_DEFAULT ; =20
-    SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) =3D JOURNAL_MAX_COMMIT_AGE ;
+    journal->j_trans_max      =3D JOURNAL_TRANS_MAX_DEFAULT ;
+    journal->j_max_batch      =3D JOURNAL_MAX_BATCH_DEFAULT ;
+    journal->j_max_commit_age =3D JOURNAL_MAX_COMMIT_AGE ;
    =20
     /* for blocksize >=3D 4096 - max transaction size is 1024. For block s=
ize < 4096
        trans max size is decreased proportionally */
     if (p_s_sb->s_blocksize < 4096) {
-      SB_JOURNAL_TRANS_MAX(p_s_sb) /=3D (4096 / p_s_sb->s_blocksize) ;
-      SB_JOURNAL_MAX_BATCH(p_s_sb) =3D (SB_JOURNAL_TRANS_MAX(p_s_sb)) * 9 =
/ 10 ;
+      journal->j_trans_max /=3D (4096 / p_s_sb->s_blocksize) ;
+      journal->j_max_batch =3D (journal->j_trans_max) * 9 / 10 ;
     }
   }
=20
-  SB_JOURNAL_DEFAULT_MAX_COMMIT_AGE(p_s_sb) =3D SB_JOURNAL_MAX_COMMIT_AGE(=
p_s_sb);
+  journal->j_default_max_commit_age =3D journal->j_max_commit_age;
=20
   if (commit_max_age !=3D 0) {
-      SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb) =3D commit_max_age;
-      SB_JOURNAL_MAX_TRANS_AGE(p_s_sb) =3D commit_max_age;
+      journal->j_max_commit_age =3D commit_max_age;
+      journal->j_max_trans_age =3D commit_max_age;
   }
=20
   reiserfs_info (p_s_sb, "journal params: device %s, size %u, "
 		 "journal first block %u, max trans len %u, max batch %u, "
 		 "max commit age %u, max trans age %u\n",
-		 bdevname( SB_JOURNAL(p_s_sb)->j_dev_bd, b),
+		 bdevname( journal->j_dev_bd, b),
 		 SB_ONDISK_JOURNAL_SIZE(p_s_sb),
 		 SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb),
-		 SB_JOURNAL_TRANS_MAX(p_s_sb),
-		 SB_JOURNAL_MAX_BATCH(p_s_sb),
-		 SB_JOURNAL_MAX_COMMIT_AGE(p_s_sb),
-		 SB_JOURNAL_MAX_TRANS_AGE(p_s_sb));
+		 journal->j_trans_max,
+		 journal->j_max_batch,
+		 journal->j_max_commit_age,
+		 journal->j_max_trans_age);
=20
   brelse (bhjh);
     =20
-  SB_JOURNAL(p_s_sb)->j_list_bitmap_index =3D 0 ;
+  journal->j_list_bitmap_index =3D 0 ;
   journal_list_init(p_s_sb) ;
=20
-  memset(SB_JOURNAL(p_s_sb)->j_list_hash_table, 0, JOURNAL_HASH_SIZE * siz=
eof(struct reiserfs_journal_cnode *)) ;
+  memset(journal->j_list_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct =
reiserfs_journal_cnode *)) ;
=20
-  INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_dirty_buffers) ;
-  spin_lock_init(&SB_JOURNAL(p_s_sb)->j_dirty_buffers_lock) ;
+  INIT_LIST_HEAD(&journal->j_dirty_buffers) ;
+  spin_lock_init(&journal->j_dirty_buffers_lock) ;
=20
-  SB_JOURNAL(p_s_sb)->j_start =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_len =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_len_alloc =3D 0 ;
-  atomic_set(&(SB_JOURNAL(p_s_sb)->j_wcount), 0) ;
-  atomic_set(&(SB_JOURNAL(p_s_sb)->j_async_throttle), 0) ;
-  SB_JOURNAL(p_s_sb)->j_bcount =3D 0 ;	 =20
-  SB_JOURNAL(p_s_sb)->j_trans_start_time =3D 0 ;	 =20
-  SB_JOURNAL(p_s_sb)->j_last =3D NULL ;	 =20
-  SB_JOURNAL(p_s_sb)->j_first =3D NULL ;    =20
-  init_waitqueue_head(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
-  sema_init(&SB_JOURNAL(p_s_sb)->j_lock, 1);
-  sema_init(&SB_JOURNAL(p_s_sb)->j_flush_sem, 1);
-
-  SB_JOURNAL(p_s_sb)->j_trans_id =3D 10 ; =20
-  SB_JOURNAL(p_s_sb)->j_mount_id =3D 10 ;=20
-  SB_JOURNAL(p_s_sb)->j_state =3D 0 ;
-  atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 0) ;
-  SB_JOURNAL(p_s_sb)->j_cnode_free_list =3D allocate_cnodes(num_cnodes) ;
-  SB_JOURNAL(p_s_sb)->j_cnode_free_orig =3D SB_JOURNAL(p_s_sb)->j_cnode_fr=
ee_list ;
-  SB_JOURNAL(p_s_sb)->j_cnode_free =3D SB_JOURNAL(p_s_sb)->j_cnode_free_li=
st ? num_cnodes : 0 ;
-  SB_JOURNAL(p_s_sb)->j_cnode_used =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_must_wait =3D 0 ;
+  journal->j_start =3D 0 ;
+  journal->j_len =3D 0 ;
+  journal->j_len_alloc =3D 0 ;
+  atomic_set(&(journal->j_wcount), 0) ;
+  atomic_set(&(journal->j_async_throttle), 0) ;
+  journal->j_bcount =3D 0 ;=09
+  journal->j_trans_start_time =3D 0 ;=09
+  journal->j_last =3D NULL ;=09
+  journal->j_first =3D NULL ;
+  init_waitqueue_head(&(journal->j_join_wait)) ;
+  sema_init(&journal->j_lock, 1);
+  sema_init(&journal->j_flush_sem, 1);
+
+  journal->j_trans_id =3D 10 ;
+  journal->j_mount_id =3D 10 ;
+  journal->j_state =3D 0 ;
+  atomic_set(&(journal->j_jlock), 0) ;
+  journal->j_cnode_free_list =3D allocate_cnodes(num_cnodes) ;
+  journal->j_cnode_free_orig =3D journal->j_cnode_free_list ;
+  journal->j_cnode_free =3D journal->j_cnode_free_list ? num_cnodes : 0 ;
+  journal->j_cnode_used =3D 0 ;
+  journal->j_must_wait =3D 0 ;
=20
   init_journal_hash(p_s_sb) ;
-  jl =3D SB_JOURNAL(p_s_sb)->j_current_jl;
+  jl =3D journal->j_current_jl;
   jl->j_list_bitmap =3D get_list_bitmap(p_s_sb, jl);
   if (!jl->j_list_bitmap) {
     reiserfs_warning(p_s_sb, "journal-2005, get_list_bitmap failed for jou=
rnal list 0") ;
@@ -2467,15 +2490,16 @@ free_and_return:
 ** transaction
 */
 int journal_transaction_should_end(struct reiserfs_transaction_handle *th,=
 int new_alloc) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (th->t_super);
   time_t now =3D get_seconds() ;
   /* cannot restart while nested */
   if (th->t_refcount > 1)
     return 0 ;
-  if ( SB_JOURNAL(th->t_super)->j_must_wait > 0 ||
-       (SB_JOURNAL(th->t_super)->j_len_alloc + new_alloc) >=3D SB_JOURNAL_=
MAX_BATCH(th->t_super) ||=20
-       atomic_read(&(SB_JOURNAL(th->t_super)->j_jlock)) ||
-      (now - SB_JOURNAL(th->t_super)->j_trans_start_time) > SB_JOURNAL_MAX=
_TRANS_AGE(th->t_super) ||
-       SB_JOURNAL(th->t_super)->j_cnode_free < (SB_JOURNAL_TRANS_MAX(th->t=
_super) * 3)) {=20
+  if ( journal->j_must_wait > 0 ||
+       (journal->j_len_alloc + new_alloc) >=3D journal->j_max_batch ||
+       atomic_read(&(journal->j_jlock)) ||
+      (now - journal->j_trans_start_time) > journal->j_max_trans_age ||
+       journal->j_cnode_free < (journal->j_trans_max * 3)) {
     return 1 ;
   }
   return 0 ;
@@ -2485,9 +2509,9 @@ int journal_transaction_should_end(struc
 ** kernel_lock to be held
 */
 void reiserfs_block_writes(struct reiserfs_transaction_handle *th) {
-    struct super_block *s =3D th->t_super ;
-    SB_JOURNAL(s)->j_must_wait =3D 1 ;
-    set_bit(WRITERS_BLOCKED, &SB_JOURNAL(s)->j_state) ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (th->t_super);
+    journal->j_must_wait =3D 1 ;
+    set_bit(WRITERS_BLOCKED, &journal->j_state) ;
     return ;
 }
=20
@@ -2495,58 +2519,63 @@ void reiserfs_block_writes(struct reiser
 ** require BKL
 */
 void reiserfs_allow_writes(struct super_block *s) {
-    clear_bit(WRITERS_BLOCKED, &SB_JOURNAL(s)->j_state) ;
-    wake_up(&SB_JOURNAL(s)->j_join_wait) ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
+    clear_bit(WRITERS_BLOCKED, &journal->j_state) ;
+    wake_up(&journal->j_join_wait) ;
 }
=20
 /* this must be called without a transaction started, and does not
 ** require BKL
 */
 void reiserfs_wait_on_write_block(struct super_block *s) {
-    wait_event(SB_JOURNAL(s)->j_join_wait,=20
-               !test_bit(WRITERS_BLOCKED, &SB_JOURNAL(s)->j_state)) ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
+    wait_event(journal->j_join_wait,
+               !test_bit(WRITERS_BLOCKED, &journal->j_state)) ;
 }
=20
 static void queue_log_writer(struct super_block *s) {
     wait_queue_t wait;
-    set_bit(WRITERS_QUEUED, &SB_JOURNAL(s)->j_state);
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
+    set_bit(WRITERS_QUEUED, &journal->j_state);
=20
     /*
      * we don't want to use wait_event here because
      * we only want to wait once.
      */
     init_waitqueue_entry(&wait, current);
-    add_wait_queue(&SB_JOURNAL(s)->j_join_wait, &wait);
+    add_wait_queue(&journal->j_join_wait, &wait);
     set_current_state(TASK_UNINTERRUPTIBLE);
-    if (test_bit(WRITERS_QUEUED, &SB_JOURNAL(s)->j_state))
+    if (test_bit(WRITERS_QUEUED, &journal->j_state))
         schedule();
     current->state =3D TASK_RUNNING;
-    remove_wait_queue(&SB_JOURNAL(s)->j_join_wait, &wait);
+    remove_wait_queue(&journal->j_join_wait, &wait);
 }
=20
 static void wake_queued_writers(struct super_block *s) {
-    if (test_and_clear_bit(WRITERS_QUEUED, &SB_JOURNAL(s)->j_state))
-        wake_up(&SB_JOURNAL(s)->j_join_wait);
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
+    if (test_and_clear_bit(WRITERS_QUEUED, &journal->j_state))
+        wake_up(&journal->j_join_wait);
 }
=20
 static void let_transaction_grow(struct super_block *sb,
                                  unsigned long trans_id)
 {
-    unsigned long bcount =3D SB_JOURNAL(sb)->j_bcount;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (sb);
+    unsigned long bcount =3D journal->j_bcount;
     while(1) {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1);
-	SB_JOURNAL(sb)->j_current_jl->j_state |=3D LIST_COMMIT_PENDING;
-        while ((atomic_read(&SB_JOURNAL(sb)->j_wcount) > 0 ||
-	        atomic_read(&SB_JOURNAL(sb)->j_jlock)) &&
-	       SB_JOURNAL(sb)->j_trans_id =3D=3D trans_id) {
+	journal->j_current_jl->j_state |=3D LIST_COMMIT_PENDING;
+        while ((atomic_read(&journal->j_wcount) > 0 ||
+	        atomic_read(&journal->j_jlock)) &&
+	       journal->j_trans_id =3D=3D trans_id) {
 	    queue_log_writer(sb);
 	}
-	if (SB_JOURNAL(sb)->j_trans_id !=3D trans_id)
+	if (journal->j_trans_id !=3D trans_id)
 	    break;
-	if (bcount =3D=3D SB_JOURNAL(sb)->j_bcount)
+	if (bcount =3D=3D journal->j_bcount)
 	    break;
-	bcount =3D SB_JOURNAL(sb)->j_bcount;
+	bcount =3D journal->j_bcount;
     }
 }
=20
@@ -2590,17 +2619,17 @@ relock:
   */
=20
   if ( (!join && journal->j_must_wait > 0) ||
-     ( !join && (journal->j_len_alloc + nblocks + 2) >=3D SB_JOURNAL_MAX_B=
ATCH(p_s_sb)) ||
+     ( !join && (journal->j_len_alloc + nblocks + 2) >=3D journal->j_max_b=
atch) ||
      (!join && atomic_read(&journal->j_wcount) > 0 && journal->j_trans_sta=
rt_time > 0 &&
-      (now - journal->j_trans_start_time) > SB_JOURNAL_MAX_TRANS_AGE(p_s_s=
b)) ||
+      (now - journal->j_trans_start_time) > journal->j_max_trans_age) ||
      (!join && atomic_read(&journal->j_jlock)) ||
-     (!join && journal->j_cnode_free < (SB_JOURNAL_TRANS_MAX(p_s_sb) * 3))=
) {
+     (!join && journal->j_cnode_free < (journal->j_trans_max * 3))) {
=20
     old_trans_id =3D journal->j_trans_id;
     unlock_journal(p_s_sb) ; /* allow others to finish this transaction */
=20
     if (!join && (journal->j_len_alloc + nblocks + 2) >=3D
-        SB_JOURNAL_MAX_BATCH(p_s_sb) &&
+        journal->j_max_batch &&
 	((journal->j_len + nblocks + 2) * 100) < (journal->j_len_alloc * 75))
     {
 	if (atomic_read(&journal->j_wcount) > 10) {
@@ -2622,7 +2651,7 @@ relock:
     journal_join(&myth, p_s_sb, 1) ;
=20
     /* someone might have ended the transaction while we joined */
-    if (old_trans_id !=3D SB_JOURNAL(p_s_sb)->j_trans_id) {
+    if (old_trans_id !=3D journal->j_trans_id) {
         do_journal_end(&myth, p_s_sb, 1, 0) ;
     } else {
         do_journal_end(&myth, p_s_sb, 1, COMMIT_NOW) ;
@@ -2735,14 +2764,15 @@ int journal_begin(struct reiserfs_transa
 ** if j_len, is bigger than j_len_alloc, it pushes j_len_alloc to 10 + j_l=
en.
 */
 int journal_mark_dirty(struct reiserfs_transaction_handle *th, struct supe=
r_block *p_s_sb, struct buffer_head *bh) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn =3D NULL;
   int count_already_incd =3D 0 ;
   int prepared =3D 0 ;
=20
   PROC_INFO_INC( p_s_sb, journal.mark_dirty );
-  if (th->t_trans_id !=3D SB_JOURNAL(p_s_sb)->j_trans_id) {
+  if (th->t_trans_id !=3D journal->j_trans_id) {
     reiserfs_panic(th->t_super, "journal-1577: handle trans id %ld !=3D cu=
rrent trans id %ld\n",=20
-                   th->t_trans_id, SB_JOURNAL(p_s_sb)->j_trans_id);
+                   th->t_trans_id, journal->j_trans_id);
   }
   p_s_sb->s_dirt =3D 1;
=20
@@ -2767,15 +2797,15 @@ int journal_mark_dirty(struct reiserfs_t
 			    buffer_journal_dirty(bh) ? ' ' : '!') ;
   }
=20
-  if (atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) <=3D 0) {
-    reiserfs_warning (p_s_sb, "journal-1409: journal_mark_dirty returning =
because j_wcount was %d", atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount))) ;
+  if (atomic_read(&(journal->j_wcount)) <=3D 0) {
+    reiserfs_warning (p_s_sb, "journal-1409: journal_mark_dirty returning =
because j_wcount was %d", atomic_read(&(journal->j_wcount))) ;
     return 1 ;
   }
   /* this error means I've screwed up, and we've overflowed the transactio=
n. =20
   ** Nothing can be done here, except make the FS readonly or panic.
   */=20
-  if (SB_JOURNAL(p_s_sb)->j_len >=3D SB_JOURNAL_TRANS_MAX(p_s_sb)) {=20
-    reiserfs_panic(th->t_super, "journal-1413: journal_mark_dirty: j_len (=
%lu) is too big\n", SB_JOURNAL(p_s_sb)->j_len) ;
+  if (journal->j_len >=3D journal->j_trans_max) {
+    reiserfs_panic(th->t_super, "journal-1413: journal_mark_dirty: j_len (=
%lu) is too big\n", journal->j_len) ;
   }
=20
   if (buffer_journal_dirty(bh)) {
@@ -2784,8 +2814,8 @@ int journal_mark_dirty(struct reiserfs_t
     clear_buffer_journal_dirty (bh);
   }
=20
-  if (SB_JOURNAL(p_s_sb)->j_len > SB_JOURNAL(p_s_sb)->j_len_alloc) {
-    SB_JOURNAL(p_s_sb)->j_len_alloc =3D SB_JOURNAL(p_s_sb)->j_len + JOURNA=
L_PER_BALANCE_CNT ;
+  if (journal->j_len > journal->j_len_alloc) {
+    journal->j_len_alloc =3D journal->j_len + JOURNAL_PER_BALANCE_CNT ;
   }
=20
   set_buffer_journaled (bh);
@@ -2799,29 +2829,29 @@ int journal_mark_dirty(struct reiserfs_t
=20
     if (th->t_blocks_logged =3D=3D th->t_blocks_allocated) {
       th->t_blocks_allocated +=3D JOURNAL_PER_BALANCE_CNT ;
-      SB_JOURNAL(p_s_sb)->j_len_alloc +=3D JOURNAL_PER_BALANCE_CNT ;
+      journal->j_len_alloc +=3D JOURNAL_PER_BALANCE_CNT ;
     }
     th->t_blocks_logged++ ;
-    SB_JOURNAL(p_s_sb)->j_len++ ;
+    journal->j_len++ ;
=20
     cn->bh =3D bh ;
     cn->blocknr =3D bh->b_blocknr ;
     cn->sb =3D p_s_sb;
     cn->jlist =3D NULL ;
-    insert_journal_hash(SB_JOURNAL(p_s_sb)->j_hash_table, cn) ;
+    insert_journal_hash(journal->j_hash_table, cn) ;
     if (!count_already_incd) {
       get_bh(bh) ;
     }
   }
   cn->next =3D NULL ;
-  cn->prev =3D SB_JOURNAL(p_s_sb)->j_last ;
+  cn->prev =3D journal->j_last ;
   cn->bh =3D bh ;
-  if (SB_JOURNAL(p_s_sb)->j_last) {
-    SB_JOURNAL(p_s_sb)->j_last->next =3D cn ;
-    SB_JOURNAL(p_s_sb)->j_last =3D cn ;
+  if (journal->j_last) {
+    journal->j_last->next =3D cn ;
+    journal->j_last =3D cn ;
   } else {
-    SB_JOURNAL(p_s_sb)->j_first =3D cn ;
-    SB_JOURNAL(p_s_sb)->j_last =3D cn ;
+    journal->j_first =3D cn ;
+    journal->j_last =3D cn ;
   }
   return 0 ;
 }
@@ -2861,9 +2891,10 @@ int journal_end(struct reiserfs_transact
 static int remove_from_transaction(struct super_block *p_s_sb, b_blocknr_t=
 blocknr, int already_cleaned) {
   struct buffer_head *bh ;
   struct reiserfs_journal_cnode *cn ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   int ret =3D 0;
=20
-  cn =3D get_journal_hash_dev(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_table, bl=
ocknr) ;
+  cn =3D get_journal_hash_dev(p_s_sb, journal->j_hash_table, blocknr) ;
   if (!cn || !cn->bh) {
     return ret ;
   }
@@ -2874,14 +2905,14 @@ static int remove_from_transaction(struc
   if (cn->next) {
     cn->next->prev =3D cn->prev ;
   }
-  if (cn =3D=3D SB_JOURNAL(p_s_sb)->j_first) {
-    SB_JOURNAL(p_s_sb)->j_first =3D cn->next ; =20
+  if (cn =3D=3D journal->j_first) {
+    journal->j_first =3D cn->next ;
   }
-  if (cn =3D=3D SB_JOURNAL(p_s_sb)->j_last) {
-    SB_JOURNAL(p_s_sb)->j_last =3D cn->prev ;
+  if (cn =3D=3D journal->j_last) {
+    journal->j_last =3D cn->prev ;
   }
   if (bh)
-	remove_journal_hash(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_table, NULL, bh->b=
_blocknr, 0) ;=20
+	remove_journal_hash(p_s_sb, journal->j_hash_table, NULL, bh->b_blocknr, 0=
) ;
   clear_buffer_journaled  (bh); /* don't log this one */
=20
   if (!already_cleaned) {
@@ -2892,8 +2923,8 @@ static int remove_from_transaction(struc
     }
     ret =3D 1 ;
   }
-  SB_JOURNAL(p_s_sb)->j_len-- ;
-  SB_JOURNAL(p_s_sb)->j_len_alloc-- ;
+  journal->j_len-- ;
+  journal->j_len_alloc-- ;
   free_cnode(p_s_sb, cn) ;
   return ret ;
 }
@@ -2944,12 +2975,13 @@ static int can_dirty(struct reiserfs_jou
 ** will wait until the current transaction is done/commited before returni=
ng=20
 */
 int journal_end_sync(struct reiserfs_transaction_handle *th, struct super_=
block *p_s_sb, unsigned long nblocks) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
=20
   /* you can sync while nested, very, very bad */
   if (th->t_refcount > 1) {
     BUG() ;
   }
-  if (SB_JOURNAL(p_s_sb)->j_len =3D=3D 0) {
+  if (journal->j_len =3D=3D 0) {
     reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
     journal_mark_dirty(th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
   }
@@ -2961,13 +2993,14 @@ int journal_end_sync(struct reiserfs_tra
 */
 static void flush_async_commits(void *p) {
   struct super_block *p_s_sb =3D p;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_list *jl;
   struct list_head *entry;
=20
   lock_kernel();
-  if (!list_empty(&SB_JOURNAL(p_s_sb)->j_journal_list)) {
+  if (!list_empty(&journal->j_journal_list)) {
       /* last entry is the youngest, commit it and you get everything */
-      entry =3D SB_JOURNAL(p_s_sb)->j_journal_list.prev;
+      entry =3D journal->j_journal_list.prev;
       jl =3D JOURNAL_LIST_ENTRY(entry);
       flush_commit_list(p_s_sb, jl, 1);
   }
@@ -2976,10 +3009,10 @@ static void flush_async_commits(void *p)
    * this is a little racey, but there's no harm in missing
    * the filemap_fdata_write
    */
-  if (!atomic_read(&SB_JOURNAL(p_s_sb)->j_async_throttle)) {
-      atomic_inc(&SB_JOURNAL(p_s_sb)->j_async_throttle);
+  if (!atomic_read(&journal->j_async_throttle)) {
+      atomic_inc(&journal->j_async_throttle);
       filemap_fdatawrite(p_s_sb->s_bdev->bd_inode->i_mapping);
-      atomic_dec(&SB_JOURNAL(p_s_sb)->j_async_throttle);
+      atomic_dec(&journal->j_async_throttle);
   }
 }
=20
@@ -2990,23 +3023,23 @@ static void flush_async_commits(void *p)
 int reiserfs_flush_old_commits(struct super_block *p_s_sb) {
     time_t now ;
     struct reiserfs_transaction_handle th ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
=20
     now =3D get_seconds();
     /* safety check so we don't flush while we are replaying the log during
      * mount
      */
-    if (list_empty(&SB_JOURNAL(p_s_sb)->j_journal_list)) {
+    if (list_empty(&journal->j_journal_list)) {
 	return 0  ;
     }
=20
     /* check the current transaction.  If there are no writers, and it is
      * too old, finish it, and force the commit blocks to disk
      */
-    if (atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) <=3D 0 &&
-        SB_JOURNAL(p_s_sb)->j_trans_start_time > 0 &&
-        SB_JOURNAL(p_s_sb)->j_len > 0 &&
-        (now - SB_JOURNAL(p_s_sb)->j_trans_start_time) >
-	SB_JOURNAL_MAX_TRANS_AGE(p_s_sb))
+    if (atomic_read(&journal->j_wcount) <=3D 0 &&
+        journal->j_trans_start_time > 0 &&
+        journal->j_len > 0 &&
+        (now - journal->j_trans_start_time) > journal->j_max_trans_age)
     {
 	journal_join(&th, p_s_sb, 1) ;
 	reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
@@ -3039,22 +3072,23 @@ static int check_journal_end(struct reis
   int commit_now =3D flags & COMMIT_NOW ;
   int wait_on_commit =3D flags & WAIT ;
   struct reiserfs_journal_list *jl;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
=20
-  if (th->t_trans_id !=3D SB_JOURNAL(p_s_sb)->j_trans_id) {
+  if (th->t_trans_id !=3D journal->j_trans_id) {
     reiserfs_panic(th->t_super, "journal-1577: handle trans id %ld !=3D cu=
rrent trans id %ld\n",=20
-                   th->t_trans_id, SB_JOURNAL(p_s_sb)->j_trans_id);
+                   th->t_trans_id, journal->j_trans_id);
   }
=20
-  SB_JOURNAL(p_s_sb)->j_len_alloc -=3D (th->t_blocks_allocated - th->t_blo=
cks_logged) ;
-  if (atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) > 0) { /* <=3D 0 is all=
owed.  unmounting might not call begin */
-    atomic_dec(&(SB_JOURNAL(p_s_sb)->j_wcount)) ;
+  journal->j_len_alloc -=3D (th->t_blocks_allocated - th->t_blocks_logged)=
 ;
+  if (atomic_read(&(journal->j_wcount)) > 0) { /* <=3D 0 is allowed.  unmo=
unting might not call begin */
+    atomic_dec(&(journal->j_wcount)) ;
   }
=20
   /* BUG, deal with case where j_len is 0, but people previously freed blo=
cks need to be released=20
   ** will be dealt with by next transaction that actually writes something=
, but should be taken
   ** care of in this trans
   */
-  if (SB_JOURNAL(p_s_sb)->j_len =3D=3D 0) {
+  if (journal->j_len =3D=3D 0) {
     BUG();
   }
   /* if wcount > 0, and we are called to with flush or commit_now,
@@ -3063,33 +3097,33 @@ static int check_journal_end(struct reis
   ** Then, we flush the commit or journal list, and just return 0=20
   ** because the rest of journal end was already done for this transaction.
   */
-  if (atomic_read(&(SB_JOURNAL(p_s_sb)->j_wcount)) > 0) {
+  if (atomic_read(&(journal->j_wcount)) > 0) {
     if (flush || commit_now) {
       unsigned trans_id ;
=20
-      jl =3D SB_JOURNAL(p_s_sb)->j_current_jl;
+      jl =3D journal->j_current_jl;
       trans_id =3D jl->j_trans_id;
       if (wait_on_commit)
         jl->j_state |=3D LIST_COMMIT_PENDING;
-      atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 1) ;
+      atomic_set(&(journal->j_jlock), 1) ;
       if (flush) {
-        SB_JOURNAL(p_s_sb)->j_next_full_flush =3D 1 ;
+        journal->j_next_full_flush =3D 1 ;
       }
       unlock_journal(p_s_sb) ;
=20
       /* sleep while the current transaction is still j_jlocked */
-      while(SB_JOURNAL(p_s_sb)->j_trans_id =3D=3D trans_id) {
-	if (atomic_read(&SB_JOURNAL(p_s_sb)->j_jlock)) {
+      while(journal->j_trans_id =3D=3D trans_id) {
+	if (atomic_read(&journal->j_jlock)) {
 	    queue_log_writer(p_s_sb);
         } else {
 	    lock_journal(p_s_sb);
-	    if (SB_JOURNAL(p_s_sb)->j_trans_id =3D=3D trans_id) {
-	        atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 1) ;
+	    if (journal->j_trans_id =3D=3D trans_id) {
+	        atomic_set(&(journal->j_jlock), 1) ;
 	    }
 	    unlock_journal(p_s_sb);
 	}
       }
-      if (SB_JOURNAL(p_s_sb)->j_trans_id =3D=3D trans_id) {
+      if (journal->j_trans_id =3D=3D trans_id) {
           BUG();
       }
       if (commit_now && journal_list_still_alive(p_s_sb, trans_id) &&
@@ -3105,22 +3139,22 @@ static int check_journal_end(struct reis
=20
   /* deal with old transactions where we are the last writers */
   now =3D get_seconds();
-  if ((now - SB_JOURNAL(p_s_sb)->j_trans_start_time) > SB_JOURNAL_MAX_TRAN=
S_AGE(p_s_sb)) {
+  if ((now - journal->j_trans_start_time) > journal->j_max_trans_age) {
     commit_now =3D 1 ;
-    SB_JOURNAL(p_s_sb)->j_next_async_flush =3D 1 ;
+    journal->j_next_async_flush =3D 1 ;
   }
   /* don't batch when someone is waiting on j_join_wait */
   /* don't batch when syncing the commit or flushing the whole trans */
-  if (!(SB_JOURNAL(p_s_sb)->j_must_wait > 0) && !(atomic_read(&(SB_JOURNAL=
(p_s_sb)->j_jlock))) && !flush && !commit_now &&=20
-      (SB_JOURNAL(p_s_sb)->j_len < SB_JOURNAL_MAX_BATCH(p_s_sb))  &&=20
-      SB_JOURNAL(p_s_sb)->j_len_alloc < SB_JOURNAL_MAX_BATCH(p_s_sb) && SB=
_JOURNAL(p_s_sb)->j_cnode_free > (SB_JOURNAL_TRANS_MAX(p_s_sb) * 3)) {
-    SB_JOURNAL(p_s_sb)->j_bcount++ ;
+  if (!(journal->j_must_wait > 0) && !(atomic_read(&(journal->j_jlock))) &=
& !flush && !commit_now &&
+      (journal->j_len < journal->j_max_batch)  &&
+      journal->j_len_alloc < journal->j_max_batch && journal->j_cnode_free=
 > (journal->j_trans_max * 3)) {
+    journal->j_bcount++ ;
     unlock_journal(p_s_sb) ;
     return 0 ;
   }
=20
-  if (SB_JOURNAL(p_s_sb)->j_start > SB_ONDISK_JOURNAL_SIZE(p_s_sb)) {
-    reiserfs_panic(p_s_sb, "journal-003: journal_end: j_start (%ld) is too=
 high\n", SB_JOURNAL(p_s_sb)->j_start) ;
+  if (journal->j_start > SB_ONDISK_JOURNAL_SIZE(p_s_sb)) {
+    reiserfs_panic(p_s_sb, "journal-003: journal_end: j_start (%ld) is too=
 high\n", journal->j_start) ;
   }
   return 1 ;
 }
@@ -3140,12 +3174,13 @@ static int check_journal_end(struct reis
 ** Then remove it from the current transaction, decrementing any counters =
and filing it on the clean list.
 */
 int journal_mark_freed(struct reiserfs_transaction_handle *th, struct supe=
r_block *p_s_sb, b_blocknr_t blocknr) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn =3D NULL ;
   struct buffer_head *bh =3D NULL ;
   struct reiserfs_list_bitmap *jb =3D NULL ;
   int cleaned =3D 0 ;
=20
-  cn =3D get_journal_hash_dev(p_s_sb, SB_JOURNAL(p_s_sb)->j_hash_table, bl=
ocknr);
+  cn =3D get_journal_hash_dev(p_s_sb, journal->j_hash_table, blocknr);
   if (cn && cn->bh) {
       bh =3D cn->bh ;
       get_bh(bh) ;
@@ -3158,7 +3193,7 @@ int journal_mark_freed(struct reiserfs_t
     cleaned =3D remove_from_transaction(p_s_sb, blocknr, cleaned) ;
   } else {
     /* set the bit for this block in the journal bitmap for this transacti=
on */
-    jb =3D SB_JOURNAL(p_s_sb)->j_current_jl->j_list_bitmap;
+    jb =3D journal->j_current_jl->j_list_bitmap;
     if (!jb) {
       reiserfs_panic(p_s_sb, "journal-1702: journal_mark_freed, journal_li=
st_bitmap is NULL\n") ;
     }
@@ -3173,7 +3208,7 @@ int journal_mark_freed(struct reiserfs_t
     cleaned =3D remove_from_transaction(p_s_sb, blocknr, cleaned) ;
=20
     /* find all older transactions with this block, make sure they don't t=
ry to write it out */
-    cn =3D get_journal_hash_dev(p_s_sb,SB_JOURNAL(p_s_sb)->j_list_hash_tab=
le,  blocknr) ;
+    cn =3D get_journal_hash_dev(p_s_sb,journal->j_list_hash_table,  blockn=
r) ;
     while (cn) {
       if (p_s_sb =3D=3D cn->sb && blocknr =3D=3D cn->blocknr) {
 	set_bit(BLOCK_FREED, &cn->state) ;
@@ -3209,8 +3244,9 @@ int journal_mark_freed(struct reiserfs_t
 }
=20
 void reiserfs_update_inode_transaction(struct inode *inode) {
-  REISERFS_I(inode)->i_jl =3D SB_JOURNAL(inode->i_sb)->j_current_jl;
-  REISERFS_I(inode)->i_trans_id =3D SB_JOURNAL(inode->i_sb)->j_trans_id ;
+  struct reiserfs_journal *journal =3D SB_JOURNAL (inode->i_sb);
+  REISERFS_I(inode)->i_jl =3D journal->j_current_jl;
+  REISERFS_I(inode)->i_trans_id =3D journal->j_trans_id ;
 }
=20
 /*
@@ -3222,21 +3258,22 @@ static int __commit_trans_jl(struct inod
 {
     struct reiserfs_transaction_handle th ;
     struct super_block *sb =3D inode->i_sb ;
+    struct reiserfs_journal *journal =3D SB_JOURNAL (sb);
     int ret =3D 0;
=20
     /* is it from the current transaction, or from an unknown transaction?=
 */
-    if (id =3D=3D SB_JOURNAL(sb)->j_trans_id) {
-	jl =3D SB_JOURNAL(sb)->j_current_jl;
+    if (id =3D=3D journal->j_trans_id) {
+	jl =3D journal->j_current_jl;
 	/* try to let other writers come in and grow this transaction */
 	let_transaction_grow(sb, id);
-	if (SB_JOURNAL(sb)->j_trans_id !=3D id) {
+	if (journal->j_trans_id !=3D id) {
 	    goto flush_commit_only;
 	}
=20
 	journal_begin(&th, sb, 1) ;
=20
 	/* someone might have ended this transaction while we joined */
-	if (SB_JOURNAL(sb)->j_trans_id !=3D id) {
+	if (journal->j_trans_id !=3D id) {
 	    reiserfs_prepare_for_journal(sb, SB_BUFFER_WITH_SB(sb), 1) ;
 	    journal_mark_dirty(&th, sb, SB_BUFFER_WITH_SB(sb)) ;
 	    journal_end(&th, sb, 1) ;
@@ -3284,6 +3321,7 @@ int reiserfs_commit_for_inode(struct ino
=20
 void reiserfs_restore_prepared_buffer(struct super_block *p_s_sb,=20
                                       struct buffer_head *bh) {
+    struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
     PROC_INFO_INC( p_s_sb, journal.restore_prepared );
     if (!bh) {
 	return ;
@@ -3292,7 +3330,7 @@ void reiserfs_restore_prepared_buffer(st
 	buffer_journal_dirty(bh)) {
 	struct reiserfs_journal_cnode *cn;
 	cn =3D get_journal_hash_dev(p_s_sb,
-	                          SB_JOURNAL(p_s_sb)->j_list_hash_table,
+	                          journal->j_list_hash_table,
 				  bh->b_blocknr);
 	if (cn && can_dirty(cn)) {
             set_buffer_journal_test (bh);
@@ -3329,12 +3367,13 @@ int reiserfs_prepare_for_journal(struct=20
 }
=20
 static void flush_old_journal_lists(struct super_block *s) {
+    struct reiserfs_journal *journal =3D SB_JOURNAL (s);
     struct reiserfs_journal_list *jl;
     struct list_head *entry;
     time_t now =3D get_seconds();
=20
-    while(!list_empty(&SB_JOURNAL(s)->j_journal_list)) {
-        entry =3D SB_JOURNAL(s)->j_journal_list.next;
+    while(!list_empty(&journal->j_journal_list)) {
+        entry =3D journal->j_journal_list.next;
 	jl =3D JOURNAL_LIST_ENTRY(entry);
 	/* this check should always be run, to send old lists to disk */
 	if (jl->j_timestamp < (now - (JOURNAL_MAX_TRANS_AGE * 4))) {
@@ -3354,6 +3393,7 @@ static void flush_old_journal_lists(stru
 */
 static int do_journal_end(struct reiserfs_transaction_handle *th, struct s=
uper_block  * p_s_sb, unsigned long nblocks,=20
 		          int flags) {
+  struct reiserfs_journal *journal =3D SB_JOURNAL (p_s_sb);
   struct reiserfs_journal_cnode *cn, *next, *jl_cn;=20
   struct reiserfs_journal_cnode *last_cn =3D NULL;
   struct reiserfs_journal_desc *desc ;=20
@@ -3376,17 +3416,17 @@ static int do_journal_end(struct reiserf
=20
   current->journal_info =3D th->t_handle_save;
   reiserfs_check_lock_depth(p_s_sb, "journal end");
-  if (SB_JOURNAL(p_s_sb)->j_len =3D=3D 0) {
+  if (journal->j_len =3D=3D 0) {
       reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
       journal_mark_dirty(th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
   }
=20
   lock_journal(p_s_sb) ;
-  if (SB_JOURNAL(p_s_sb)->j_next_full_flush) {
+  if (journal->j_next_full_flush) {
     flags |=3D FLUSH_ALL ;
     flush =3D 1 ;
   }
-  if (SB_JOURNAL(p_s_sb)->j_next_async_flush) {
+  if (journal->j_next_async_flush) {
     flags |=3D COMMIT_NOW | WAIT;
     wait_on_commit =3D 1;
   }
@@ -3402,7 +3442,7 @@ static int do_journal_end(struct reiserf
   }
=20
   /* check_journal_end might set these, check again */
-  if (SB_JOURNAL(p_s_sb)->j_next_full_flush) {
+  if (journal->j_next_full_flush) {
     flush =3D 1 ;
   }
=20
@@ -3410,7 +3450,7 @@ static int do_journal_end(struct reiserf
   ** j must wait means we have to flush the log blocks, and the real block=
s for
   ** this transaction
   */
-  if (SB_JOURNAL(p_s_sb)->j_must_wait > 0) {
+  if (journal->j_must_wait > 0) {
     flush =3D 1 ;
   }
=20
@@ -3423,23 +3463,23 @@ static int do_journal_end(struct reiserf
 #endif
  =20
   /* setup description block */
-  d_bh =3D journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB=
_JOURNAL(p_s_sb)->j_start) ;=20
+  d_bh =3D journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + jo=
urnal->j_start) ;
   set_buffer_uptodate(d_bh);
   desc =3D (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(d_bh->b_data, 0, d_bh->b_size) ;
   memcpy(get_journal_desc_magic (d_bh), JOURNAL_DESC_MAGIC, 8) ;
-  set_desc_trans_id(desc, SB_JOURNAL(p_s_sb)->j_trans_id) ;
+  set_desc_trans_id(desc, journal->j_trans_id) ;
=20
   /* setup commit block.  Don't write (keep it clean too) this one until a=
fter everyone else is written */
   c_bh =3D  journal_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +=
=20
-		 ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % SB_OND=
ISK_JOURNAL_SIZE(p_s_sb))) ;
+		 ((journal->j_start + journal->j_len + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_s=
b))) ;
   commit =3D (struct reiserfs_journal_commit *)c_bh->b_data ;
   memset(c_bh->b_data, 0, c_bh->b_size) ;
-  set_commit_trans_id(commit, SB_JOURNAL(p_s_sb)->j_trans_id) ;
+  set_commit_trans_id(commit, journal->j_trans_id) ;
   set_buffer_uptodate(c_bh) ;
=20
   /* init this journal list */
-  jl =3D SB_JOURNAL(p_s_sb)->j_current_jl;
+  jl =3D journal->j_current_jl;
=20
   /* we lock the commit before doing anything because
    * we want to make sure nobody tries to run flush_commit_list until
@@ -3452,13 +3492,13 @@ static int do_journal_end(struct reiserf
   commit_trans_id =3D jl->j_trans_id;
=20
   atomic_set(&jl->j_older_commits_done, 0) ;
-  jl->j_trans_id =3D SB_JOURNAL(p_s_sb)->j_trans_id ;
-  jl->j_timestamp =3D SB_JOURNAL(p_s_sb)->j_trans_start_time ;
+  jl->j_trans_id =3D journal->j_trans_id ;
+  jl->j_timestamp =3D journal->j_trans_start_time ;
   jl->j_commit_bh =3D c_bh ;
-  jl->j_start =3D SB_JOURNAL(p_s_sb)->j_start ;
-  jl->j_len =3D SB_JOURNAL(p_s_sb)->j_len ;
-  atomic_set(&jl->j_nonzerolen, SB_JOURNAL(p_s_sb)->j_len) ;
-  atomic_set(&jl->j_commit_left, SB_JOURNAL(p_s_sb)->j_len + 2);
+  jl->j_start =3D journal->j_start ;
+  jl->j_len =3D journal->j_len ;
+  atomic_set(&jl->j_nonzerolen, journal->j_len) ;
+  atomic_set(&jl->j_commit_left, journal->j_len + 2);
   jl->j_realblock =3D NULL ;
=20
   /* The ENTIRE FOR LOOP MUST not cause schedule to occur.
@@ -3466,7 +3506,7 @@ static int do_journal_end(struct reiserf
   ** copy into real block index array in the commit or desc block
   */
   trans_half =3D journal_trans_half(p_s_sb->s_blocksize);
-  for (i =3D 0, cn =3D SB_JOURNAL(p_s_sb)->j_first ; cn ; cn =3D cn->next,=
 i++) {
+  for (i =3D 0, cn =3D journal->j_first ; cn ; cn =3D cn->next, i++) {
     if (buffer_journaled (cn->bh)) {
       jl_cn =3D get_cnode(p_s_sb) ;
       if (!jl_cn) {
@@ -3492,7 +3532,7 @@ static int do_journal_end(struct reiserf
       jl_cn->sb =3D p_s_sb;
       jl_cn->bh =3D cn->bh ;
       jl_cn->jlist =3D jl;
-      insert_journal_hash(SB_JOURNAL(p_s_sb)->j_list_hash_table, jl_cn) ;=
=20
+      insert_journal_hash(journal->j_list_hash_table, jl_cn) ;
       if (i < trans_half) {
 	desc->j_realblock[i] =3D cpu_to_le32(cn->bh->b_blocknr) ;
       } else {
@@ -3502,13 +3542,13 @@ static int do_journal_end(struct reiserf
       i-- ;
     }
   }
-  set_desc_trans_len(desc, SB_JOURNAL(p_s_sb)->j_len) ;
-  set_desc_mount_id(desc, SB_JOURNAL(p_s_sb)->j_mount_id) ;
-  set_desc_trans_id(desc, SB_JOURNAL(p_s_sb)->j_trans_id) ;
-  set_commit_trans_len(commit, SB_JOURNAL(p_s_sb)->j_len);
+  set_desc_trans_len(desc, journal->j_len) ;
+  set_desc_mount_id(desc, journal->j_mount_id) ;
+  set_desc_trans_id(desc, journal->j_trans_id) ;
+  set_commit_trans_len(commit, journal->j_len);
=20
   /* special check in case all buffers in the journal were marked for not =
logging */
-  if (SB_JOURNAL(p_s_sb)->j_len =3D=3D 0) {
+  if (journal->j_len =3D=3D 0) {
     BUG();
   }
=20
@@ -3519,8 +3559,8 @@ static int do_journal_end(struct reiserf
   mark_buffer_dirty(d_bh);
=20
   /* first data block is j_start + 1, so add one to cur_write_start wherev=
er you use it */
-  cur_write_start =3D SB_JOURNAL(p_s_sb)->j_start ;
-  cn =3D SB_JOURNAL(p_s_sb)->j_first ;
+  cur_write_start =3D journal->j_start ;
+  cn =3D journal->j_first ;
   jindex =3D 1 ; /* start at one so we don't get the desc again */
   while(cn) {
     clear_buffer_journal_new (cn->bh);
@@ -3557,28 +3597,28 @@ static int do_journal_end(struct reiserf
   ** so we dirty/relse c_bh in flush_commit_list, with commit_left <=3D 1.
   */
=20
-  SB_JOURNAL(p_s_sb)->j_current_jl =3D alloc_journal_list(p_s_sb);
+  journal->j_current_jl =3D alloc_journal_list(p_s_sb);
=20
   /* now it is safe to insert this transaction on the main list */
-  list_add_tail(&jl->j_list, &SB_JOURNAL(p_s_sb)->j_journal_list);
-  list_add_tail(&jl->j_working_list, &SB_JOURNAL(p_s_sb)->j_working_list);
-  SB_JOURNAL(p_s_sb)->j_num_work_lists++;
+  list_add_tail(&jl->j_list, &journal->j_journal_list);
+  list_add_tail(&jl->j_working_list, &journal->j_working_list);
+  journal->j_num_work_lists++;
=20
   /* reset journal values for the next transaction */
-  old_start =3D SB_JOURNAL(p_s_sb)->j_start ;
-  SB_JOURNAL(p_s_sb)->j_start =3D (SB_JOURNAL(p_s_sb)->j_start + SB_JOURNA=
L(p_s_sb)->j_len + 2) % SB_ONDISK_JOURNAL_SIZE(p_s_sb);
-  atomic_set(&(SB_JOURNAL(p_s_sb)->j_wcount), 0) ;
-  SB_JOURNAL(p_s_sb)->j_bcount =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_last =3D NULL ;
-  SB_JOURNAL(p_s_sb)->j_first =3D NULL ;
-  SB_JOURNAL(p_s_sb)->j_len =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_trans_start_time =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_trans_id++ ;
-  SB_JOURNAL(p_s_sb)->j_current_jl->j_trans_id =3D SB_JOURNAL(p_s_sb)->j_t=
rans_id;
-  SB_JOURNAL(p_s_sb)->j_must_wait =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_len_alloc =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_next_full_flush =3D 0 ;
-  SB_JOURNAL(p_s_sb)->j_next_async_flush =3D 0 ;
+  old_start =3D journal->j_start ;
+  journal->j_start =3D (journal->j_start + journal->j_len + 2) % SB_ONDISK=
_JOURNAL_SIZE(p_s_sb);
+  atomic_set(&(journal->j_wcount), 0) ;
+  journal->j_bcount =3D 0 ;
+  journal->j_last =3D NULL ;
+  journal->j_first =3D NULL ;
+  journal->j_len =3D 0 ;
+  journal->j_trans_start_time =3D 0 ;
+  journal->j_trans_id++ ;
+  journal->j_current_jl->j_trans_id =3D journal->j_trans_id;
+  journal->j_must_wait =3D 0 ;
+  journal->j_len_alloc =3D 0 ;
+  journal->j_next_full_flush =3D 0 ;
+  journal->j_next_async_flush =3D 0 ;
   init_journal_hash(p_s_sb) ;=20
=20
   // make sure reiserfs_add_jh sees the new current_jl before we
@@ -3593,8 +3633,8 @@ static int do_journal_end(struct reiserf
    */
   if (!list_empty(&jl->j_tail_bh_list)) {
       unlock_kernel();
-      write_ordered_buffers(&SB_JOURNAL(p_s_sb)->j_dirty_buffers_lock,
-			    SB_JOURNAL(p_s_sb), jl, &jl->j_tail_bh_list);
+      write_ordered_buffers(&journal->j_dirty_buffers_lock,
+			    journal, jl, &jl->j_tail_bh_list);
       lock_kernel();
   }
   if (!list_empty(&jl->j_tail_bh_list))
@@ -3612,7 +3652,7 @@ static int do_journal_end(struct reiserf
     flush_commit_list(p_s_sb, jl, 1) ;
     flush_journal_list(p_s_sb, jl, 1) ;
   } else if (!(jl->j_state & LIST_COMMIT_PENDING))
-    queue_delayed_work(commit_wq, &SB_JOURNAL(p_s_sb)->j_work, HZ/10);
+    queue_delayed_work(commit_wq, &journal->j_work, HZ/10);
=20
=20
   /* if the next transaction has any chance of wrapping, flush=20
@@ -3620,16 +3660,16 @@ static int do_journal_end(struct reiserf
   ** old flush them as well. =20
   */
 first_jl:
-  list_for_each_safe(entry, safe, &SB_JOURNAL(p_s_sb)->j_journal_list) {
+  list_for_each_safe(entry, safe, &journal->j_journal_list) {
     temp_jl =3D JOURNAL_LIST_ENTRY(entry);
-    if (SB_JOURNAL(p_s_sb)->j_start <=3D temp_jl->j_start) {
-      if ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL_TRANS_MAX(p_s_sb) + 1)=
 >=3D
+    if (journal->j_start <=3D temp_jl->j_start) {
+      if ((journal->j_start + journal->j_trans_max + 1) >=3D
           temp_jl->j_start)
       {
 	flush_used_journal_lists(p_s_sb, temp_jl);
 	goto first_jl;
-      } else if ((SB_JOURNAL(p_s_sb)->j_start +
-                  SB_JOURNAL_TRANS_MAX(p_s_sb) + 1) <
+      } else if ((journal->j_start +
+                  journal->j_trans_max + 1) <
 		  SB_ONDISK_JOURNAL_SIZE(p_s_sb))
       {
           /* if we don't cross into the next transaction and we don't
@@ -3638,11 +3678,11 @@ first_jl:
 	   */
 	  break;
       }
-    } else if ((SB_JOURNAL(p_s_sb)->j_start +
-                SB_JOURNAL_TRANS_MAX(p_s_sb) + 1) >
+    } else if ((journal->j_start +
+                journal->j_trans_max + 1) >
 		SB_ONDISK_JOURNAL_SIZE(p_s_sb))
     {
-      if (((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL_TRANS_MAX(p_s_sb) + 1=
) %
+      if (((journal->j_start + journal->j_trans_max + 1) %
             SB_ONDISK_JOURNAL_SIZE(p_s_sb)) >=3D temp_jl->j_start)
       {
 	flush_used_journal_lists(p_s_sb, temp_jl);
@@ -3658,17 +3698,17 @@ first_jl:
   }
   flush_old_journal_lists(p_s_sb);
=20
-  SB_JOURNAL(p_s_sb)->j_current_jl->j_list_bitmap =3D get_list_bitmap(p_s_=
sb, SB_JOURNAL(p_s_sb)->j_current_jl) ;
+  journal->j_current_jl->j_list_bitmap =3D get_list_bitmap(p_s_sb, journal=
->j_current_jl) ;
=20
-  if (!(SB_JOURNAL(p_s_sb)->j_current_jl->j_list_bitmap)) {
+  if (!(journal->j_current_jl->j_list_bitmap)) {
     reiserfs_panic(p_s_sb, "journal-1996: do_journal_end, could not get a =
list bitmap\n") ;
   }
=20
-  atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 0) ;
+  atomic_set(&(journal->j_jlock), 0) ;
   unlock_journal(p_s_sb) ;
   /* wake up any body waiting to join. */
-  clear_bit(WRITERS_QUEUED, &SB_JOURNAL(p_s_sb)->j_state);
-  wake_up(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
+  clear_bit(WRITERS_QUEUED, &journal->j_state);
+  wake_up(&(journal->j_join_wait)) ;
=20
   if (!flush && wait_on_commit &&
       journal_list_still_alive(p_s_sb, commit_trans_id)) {
Index: linux.t/fs/reiserfs/procfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/procfs.c	2004-08-12 13:59:08.704377784 -0400
+++ linux.t/fs/reiserfs/procfs.c	2004-08-12 14:01:18.661621280 -0400
@@ -399,7 +399,7 @@ static int show_journal(struct seq_file=20
                         DJP( jp_journal_trans_max ),
                         DJP( jp_journal_magic ),
                         DJP( jp_journal_max_batch ),
-                        SB_JOURNAL_MAX_COMMIT_AGE(sb),
+			SB_JOURNAL(sb)->j_max_commit_age,
                         DJP( jp_journal_max_trans_age ),
=20
 			JF( j_1st_reserved_block ),		=09
Index: linux.t/fs/reiserfs/super.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/fs/reiserfs/super.c	2004-08-12 14:00:10.488985096 -0400
+++ linux.t/fs/reiserfs/super.c	2004-08-12 14:00:50.182950696 -0400
@@ -861,6 +861,7 @@ static int reiserfs_remount (struct supe
   unsigned long mount_options =3D REISERFS_SB(s)->s_mount_opt;
   unsigned long safe_mask =3D 0;
   unsigned int commit_max_age =3D (unsigned int)-1;
+  struct reiserfs_journal *journal =3D SB_JOURNAL(s);
=20
   rs =3D SB_DISK_SUPER_BLOCK (s);
=20
@@ -887,14 +888,14 @@ static int reiserfs_remount (struct supe
   REISERFS_SB(s)->s_mount_opt =3D (REISERFS_SB(s)->s_mount_opt & ~safe_mas=
k) |  (mount_options & safe_mask);
=20
   if(commit_max_age !=3D 0 && commit_max_age !=3D (unsigned int)-1) {
-    SB_JOURNAL_MAX_COMMIT_AGE(s) =3D commit_max_age;
-    SB_JOURNAL_MAX_TRANS_AGE(s) =3D commit_max_age;
+    journal->j_max_commit_age =3D commit_max_age;
+    journal->j_max_trans_age =3D commit_max_age;
   }
   else if(commit_max_age =3D=3D 0)
   {
     /* 0 means restore defaults. */
-    SB_JOURNAL_MAX_COMMIT_AGE(s) =3D SB_JOURNAL_DEFAULT_MAX_COMMIT_AGE(s);
-    SB_JOURNAL_MAX_TRANS_AGE(s) =3D JOURNAL_MAX_TRANS_AGE;
+    journal->j_max_commit_age =3D journal->j_default_max_commit_age;
+    journal->j_max_trans_age =3D JOURNAL_MAX_TRANS_AGE;
   }
=20
   if(blocks) {
Index: linux.t/include/linux/reiserfs_fs_sb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.t.orig/include/linux/reiserfs_fs_sb.h	2004-08-12 14:00:09.0022111=
20 -0400
+++ linux.t/include/linux/reiserfs_fs_sb.h	2004-08-12 14:00:50.184950392 -0=
400
@@ -206,11 +206,11 @@ struct reiserfs_journal {
   int j_cnode_used ;	      /* number of cnodes on the used list */
   int j_cnode_free ;          /* number of cnodes on the free list */
=20
-  unsigned int s_journal_trans_max ;           /* max number of blocks in =
a transaction.  */
-  unsigned int s_journal_max_batch ;           /* max number of blocks to =
batch into a trans */
-  unsigned int s_journal_max_commit_age ;      /* in seconds, how old can =
an async commit be */
-  unsigned int s_journal_default_max_commit_age ; /* the default for the m=
ax commit age */
-  unsigned int s_journal_max_trans_age ;       /* in seconds, how old can =
a transaction be */ =20
+  unsigned int j_trans_max ;           /* max number of blocks in a transa=
ction.  */
+  unsigned int j_max_batch ;           /* max number of blocks to batch in=
to a trans */
+  unsigned int j_max_commit_age ;      /* in seconds, how old can an async=
 commit be */
+  unsigned int j_max_trans_age ;       /* in seconds, how old can a transa=
ction be */
+  unsigned int j_default_max_commit_age ; /* the default for the max commi=
t age */
=20
   struct reiserfs_journal_cnode *j_cnode_free_list ;
   struct reiserfs_journal_cnode *j_cnode_free_orig ; /* orig pointer retur=
ned from vmalloc */
@@ -494,12 +494,6 @@ int reiserfs_resize(struct super_block *
=20
 #define SB_DISK_JOURNAL_HEAD(s) (SB_JOURNAL(s)->j_header_bh->)
=20
-#define SB_JOURNAL_TRANS_MAX(s)      (SB_JOURNAL(s)->s_journal_trans_max)
-#define SB_JOURNAL_MAX_BATCH(s)      (SB_JOURNAL(s)->s_journal_max_batch)
-#define SB_JOURNAL_MAX_COMMIT_AGE(s) (SB_JOURNAL(s)->s_journal_max_commit_=
age)
-#define SB_JOURNAL_DEFAULT_MAX_COMMIT_AGE(s) (SB_JOURNAL(s)->s_journal_def=
ault_max_commit_age)
-#define SB_JOURNAL_MAX_TRANS_AGE(s)  (SB_JOURNAL(s)->s_journal_max_trans_a=
ge)
-
 /* A safe version of the "bdevname", which returns the "s_id" field of
  * a superblock or else "Null superblock" if the super block is NULL.
  */

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBYrjwLPWxlyuTD7IRAmKdAKCaXZNX6J43wDHQPglfVxmqYCmJmACcCWFD
X2zepkLc3piD9bHr7fm0W7g=
=oPV1
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
