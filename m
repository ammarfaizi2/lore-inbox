Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTGGWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTGGWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:03:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264534AbTGGWCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:02:55 -0400
Date: Mon, 7 Jul 2003 15:11:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Weitai Liu" <liuwt@s-ec.com>
Cc: linuxppc64-dev@lists.linuxppc.org, liuwt@s-ec.com,
       linux-kernel@vger.kernel.org
Subject: Re: About  reiserfs file corruption in 2.5.70 for PPC64
Message-Id: <20030707151111.2f92a488.akpm@osdl.org>
In-Reply-To: <CDENIKBOGMAOLOMEGJGKKEGOCAAA.liuwt@s-ec.com>
References: <CDENIKBOGMAOLOMEGJGKKEGOCAAA.liuwt@s-ec.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Weitai Liu" <liuwt@s-ec.com> wrote:
>
> 
> Hello all,
> 
>       I have tested 2.5.70 for PPC64 on my IBM p630 machine, This system
> runs SuSE Linux 8.1 for PPC64 . Some system files that I have moved to
> other directories on my system will be corrupted randomly, these files
> can be accessed, but their content will be zero partially, e.g., some
> bytes will be zero ("00" ). there is no panic on my system .
> 
>     perhaps  there are  bugs  in reiserfs of 2.5.70 kernel for PPC64.
> 


reiserfs is broken on 64-bit machines.  You'll need this fix:


From: Oleg Drokin <green@namesys.com>

>From the time of reiserfs_file_write inclusion all 64bit arches were not
able to work with reiserfs for pretty stupid reason (incorrect "unsigned
long" definition of blocknumber type).

Following patch fixes the problem.



 25-akpm/fs/reiserfs/bitmap.c           |   26 +++++++++++++-------------
 25-akpm/fs/reiserfs/do_balan.c         |    6 +++---
 25-akpm/fs/reiserfs/fix_node.c         |    6 +++---
 25-akpm/fs/reiserfs/inode.c            |    2 +-
 25-akpm/fs/reiserfs/journal.c          |   16 ++++++++--------
 25-akpm/fs/reiserfs/stree.c            |    2 +-
 25-akpm/include/linux/reiserfs_fs.h    |   12 ++++++------
 25-akpm/include/linux/reiserfs_fs_sb.h |    2 +-
 8 files changed, 36 insertions(+), 36 deletions(-)

diff -puN fs/reiserfs/bitmap.c~reiserfs-64-bit-fix fs/reiserfs/bitmap.c
--- 25/fs/reiserfs/bitmap.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/bitmap.c	Mon Jul  7 14:10:03 2003
@@ -43,7 +43,7 @@
     test_bit(_ALLOC_ ## optname , &SB_ALLOC_OPTS(s))
 
 static inline void get_bit_address (struct super_block * s,
-				    unsigned long block, int * bmap_nr, int * offset)
+				    b_blocknr_t block, int * bmap_nr, int * offset)
 {
     /* It is in the bitmap block number equal to the block
      * number divided by the number of bits in a block. */
@@ -54,7 +54,7 @@ static inline void get_bit_address (stru
 }
 
 #ifdef CONFIG_REISERFS_CHECK
-int is_reusable (struct super_block * s, unsigned long block, int bit_value)
+int is_reusable (struct super_block * s, b_blocknr_t block, int bit_value)
 {
     int i, j;
 
@@ -107,7 +107,7 @@ int is_reusable (struct super_block * s,
 static inline  int is_block_in_journal (struct super_block * s, int bmap, int
 off, int *next)
 {
-    unsigned long tmp;
+    b_blocknr_t tmp;
 
     if (reiserfs_in_journal (s, bmap, off, 1, &tmp)) {
 	if (tmp) {              /* hint supplied */
@@ -235,7 +235,7 @@ static int scan_bitmap_block (struct rei
 /* Tries to find contiguous zero bit window (given size) in given region of
  * bitmap and place new blocks there. Returns number of allocated blocks. */
 static int scan_bitmap (struct reiserfs_transaction_handle *th,
-			unsigned long *start, unsigned long finish,
+			b_blocknr_t *start, b_blocknr_t finish,
 			int min, int max, int unfm, unsigned long file_block)
 {
     int nr_allocated=0;
@@ -281,7 +281,7 @@ static int scan_bitmap (struct reiserfs_
 }
 
 static void _reiserfs_free_block (struct reiserfs_transaction_handle *th,
-				  unsigned long block)
+				  b_blocknr_t block)
 {
     struct super_block * s = th->t_super;
     struct reiserfs_super_block * rs;
@@ -327,7 +327,7 @@ static void _reiserfs_free_block (struct
 }
 
 void reiserfs_free_block (struct reiserfs_transaction_handle *th, 
-                          unsigned long block)
+                          b_blocknr_t block)
 {
     struct super_block * s = th->t_super;
 
@@ -340,7 +340,7 @@ void reiserfs_free_block (struct reiserf
 
 /* preallocated blocks don't need to be run through journal_mark_freed */
 void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
-                          unsigned long block) {
+                          b_blocknr_t block) {
     RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
     RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
     _reiserfs_free_block(th, block) ;
@@ -589,15 +589,15 @@ static inline void displace_new_packing_
 
 static inline int old_hashed_relocation (reiserfs_blocknr_hint_t * hint)
 {
-    unsigned long border;
-    unsigned long hash_in;
+    b_blocknr_t border;
+    u32 hash_in;
     
     if (hint->formatted_node || hint->inode == NULL) {
 	return 0;
       }
 
     hash_in = le32_to_cpu((INODE_PKEY(hint->inode))->k_dir_id);
-    border = hint->beg + (unsigned long) keyed_hash(((char *) (&hash_in)), 4) % (hint->end - hint->beg - 1);
+    border = hint->beg + (u32) keyed_hash(((char *) (&hash_in)), 4) % (hint->end - hint->beg - 1);
     if (border > hint->search_start)
 	hint->search_start = border;
 
@@ -606,7 +606,7 @@ static inline int old_hashed_relocation 
   
 static inline int old_way (reiserfs_blocknr_hint_t * hint)
 {
-    unsigned long border;
+    b_blocknr_t border;
     
     if (hint->formatted_node || hint->inode == NULL) {
 	return 0;
@@ -622,7 +622,7 @@ static inline int old_way (reiserfs_bloc
 static inline void hundredth_slices (reiserfs_blocknr_hint_t * hint)
 {
     struct key * key = &hint->key;
-    unsigned long slice_start;
+    b_blocknr_t slice_start;
 
     slice_start = (keyed_hash((char*)(&key->k_dir_id),4) % 100) * (hint->end / 100);
     if ( slice_start > hint->search_start || slice_start + (hint->end / 100) <= hint->search_start) {
@@ -910,7 +910,7 @@ void reiserfs_release_claimed_blocks( 
 int reiserfs_can_fit_pages ( struct super_block *sb /* superblock of filesystem
 						       to estimate space */ )
 {
-	unsigned long space;
+	b_blocknr_t space;
 
 	spin_lock(&REISERFS_SB(sb)->bitmap_lock);
 	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) >> ( PAGE_CACHE_SHIFT - sb->s_blocksize_bits);
diff -puN fs/reiserfs/do_balan.c~reiserfs-64-bit-fix fs/reiserfs/do_balan.c
--- 25/fs/reiserfs/do_balan.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/do_balan.c	Mon Jul  7 14:10:03 2003
@@ -1250,12 +1250,12 @@ static void store_thrown (struct tree_ba
 
 static void free_thrown(struct tree_balance *tb) {
     int i ;
-    unsigned long blocknr ;
+    b_blocknr_t blocknr ;
     for (i = 0; i < sizeof (tb->thrown)/sizeof (tb->thrown[0]); i++) {
 	if (tb->thrown[i]) {
 	    blocknr = tb->thrown[i]->b_blocknr ;
 	    if (buffer_dirty (tb->thrown[i]))
-	      printk ("free_thrown deals with dirty buffer %ld\n", blocknr);
+	      printk ("free_thrown deals with dirty buffer %d\n", blocknr);
 	    brelse(tb->thrown[i]) ; /* incremented in store_thrown */
 	    reiserfs_free_block (tb->transaction_handle, blocknr);
 	}
@@ -1339,7 +1339,7 @@ int get_right_neighbor_position (struct 
 
 #ifdef CONFIG_REISERFS_CHECK
 
-int is_reusable (struct super_block * s, unsigned long block, int bit_value);
+int is_reusable (struct super_block * s, b_blocknr_t block, int bit_value);
 static void check_internal_node (struct super_block * s, struct buffer_head * bh, char * mes)
 {
   struct disk_child * dc;
diff -puN fs/reiserfs/fix_node.c~reiserfs-64-bit-fix fs/reiserfs/fix_node.c
--- 25/fs/reiserfs/fix_node.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/fix_node.c	Mon Jul  7 14:10:03 2003
@@ -758,7 +758,7 @@ static int  get_empty_nodes(
             ) {
   struct buffer_head  * p_s_new_bh,
     		      *	p_s_Sh = PATH_H_PBUFFER (p_s_tb->tb_path, n_h);
-  unsigned long	      *	p_n_blocknr,
+  b_blocknr_t	      *	p_n_blocknr,
     			a_n_blocknrs[MAX_AMOUNT_NEEDED] = {0, };
   int       		n_counter,
    			n_number_of_freeblk,
@@ -879,7 +879,7 @@ static int  is_left_neighbor_in_cache(
             ) {
   struct buffer_head  * p_s_father, * left;
   struct super_block  * p_s_sb = p_s_tb->tb_sb;
-  unsigned long         n_left_neighbor_blocknr;
+  b_blocknr_t		n_left_neighbor_blocknr;
   int                   n_left_neighbor_position;
 
   if ( ! p_s_tb->FL[n_h] ) /* Father of the left neighbor does not exist. */
@@ -2501,7 +2501,7 @@ void unfix_nodes (struct tree_balance * 
     /* deal with list of allocated (used and unused) nodes */
     for ( i = 0; i < MAX_FEB_SIZE; i++ ) {
 	if ( tb->FEB[i] ) {
-	    unsigned long blocknr  = tb->FEB[i]->b_blocknr ;
+	    b_blocknr_t blocknr  = tb->FEB[i]->b_blocknr ;
 	    /* de-allocated block which was not used by balancing and
                bforget about buffer for it */
 	    brelse (tb->FEB[i]);
diff -puN fs/reiserfs/inode.c~reiserfs-64-bit-fix fs/reiserfs/inode.c
--- 25/fs/reiserfs/inode.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/inode.c	Mon Jul  7 14:10:03 2003
@@ -506,7 +506,7 @@ int reiserfs_get_block (struct inode * i
 			struct buffer_head * bh_result, int create)
 {
     int repeat, retval;
-    b_blocknr_t allocated_block_nr = 0;// b_blocknr_t is unsigned long
+    b_blocknr_t allocated_block_nr = 0;// b_blocknr_t is (unsigned) 32 bit int
     INITIALIZE_PATH(path);
     int pos_in_item;
     struct cpu_key key;
diff -puN fs/reiserfs/journal.c~reiserfs-64-bit-fix fs/reiserfs/journal.c
--- 25/fs/reiserfs/journal.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/journal.c	Mon Jul  7 14:10:03 2003
@@ -507,7 +507,7 @@ int dump_journal_writers(void) {
 */
 int reiserfs_in_journal(struct super_block *p_s_sb,
                         int bmap_nr, int bit_nr, int search_all, 
-			unsigned long *next_zero_bit) {
+			b_blocknr_t *next_zero_bit) {
   struct reiserfs_journal_cnode *cn ;
   struct reiserfs_list_bitmap *jb ;
   int i ;
@@ -761,7 +761,7 @@ reiserfs_panic(s, "journal-539: flush_co
 */
 static struct reiserfs_journal_list *find_newer_jl_for_cn(struct reiserfs_journal_cnode *cn) {
   struct super_block *sb = cn->sb;
-  unsigned long blocknr = cn->blocknr ;
+  b_blocknr_t blocknr = cn->blocknr ;
 
   cn = cn->hprev ;
   while(cn) {
@@ -791,7 +791,7 @@ static void remove_all_from_journal_list
   while(cn) {
     if (cn->blocknr != 0) {
       if (debug) {
-        printk("block %lu, bh is %d, state %ld\n", cn->blocknr, cn->bh ? 1: 0, 
+        printk("block %u, bh is %d, state %ld\n", cn->blocknr, cn->bh ? 1: 0,
 	        cn->state) ;
       }
       cn->state = 0 ;
@@ -1105,7 +1105,7 @@ static int kupdate_one_transaction(struc
 {
     struct reiserfs_journal_list *pjl ; /* previous list for this cn */
     struct reiserfs_journal_cnode *cn, *walk_cn ;
-    unsigned long blocknr ;
+    b_blocknr_t blocknr ;
     int run = 0 ;
     int orig_trans_id = jl->j_trans_id ;
     struct buffer_head *saved_bh ; 
@@ -2421,7 +2421,7 @@ int journal_end(struct reiserfs_transact
 **
 ** returns 1 if it cleaned and relsed the buffer. 0 otherwise
 */
-static int remove_from_transaction(struct super_block *p_s_sb, unsigned long blocknr, int already_cleaned) {
+static int remove_from_transaction(struct super_block *p_s_sb, b_blocknr_t blocknr, int already_cleaned) {
   struct buffer_head *bh ;
   struct reiserfs_journal_cnode *cn ;
   int ret = 0;
@@ -2474,7 +2474,7 @@ static int remove_from_transaction(struc
 */
 static int can_dirty(struct reiserfs_journal_cnode *cn) {
   struct super_block *sb = cn->sb;
-  unsigned long blocknr = cn->blocknr  ;
+  b_blocknr_t blocknr = cn->blocknr  ;
   struct reiserfs_journal_cnode *cur = cn->hprev ;
   int can_dirty = 1 ;
   
@@ -2710,7 +2710,7 @@ static int check_journal_end(struct reis
 **
 ** Then remove it from the current transaction, decrementing any counters and filing it on the clean list.
 */
-int journal_mark_freed(struct reiserfs_transaction_handle *th, struct super_block *p_s_sb, unsigned long blocknr) {
+int journal_mark_freed(struct reiserfs_transaction_handle *th, struct super_block *p_s_sb, b_blocknr_t blocknr) {
   struct reiserfs_journal_cnode *cn = NULL ;
   struct buffer_head *bh = NULL ;
   struct reiserfs_list_bitmap *jb = NULL ;
@@ -2719,7 +2719,7 @@ int journal_mark_freed(struct reiserfs_t
   if (reiserfs_dont_log(th->t_super)) {
     bh = sb_find_get_block(p_s_sb, blocknr) ;
     if (bh && buffer_dirty (bh)) {
-      printk ("journal_mark_freed(dont_log): dirty buffer on hash list: %lx %ld\n", bh->b_state, blocknr);
+      printk ("journal_mark_freed(dont_log): dirty buffer on hash list: %lx %d\n", bh->b_state, blocknr);
       BUG ();
     }
     brelse (bh);
diff -puN fs/reiserfs/stree.c~reiserfs-64-bit-fix fs/reiserfs/stree.c
--- 25/fs/reiserfs/stree.c~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/fs/reiserfs/stree.c	Mon Jul  7 14:10:03 2003
@@ -102,7 +102,7 @@ inline int  comp_short_keys (const struc
   int n_key_length = REISERFS_SHORT_KEY_LEN;
 
   p_s_le_u32 = (__u32 *)le_key;
-  p_s_cpu_u32 = (__u32 *)cpu_key;
+  p_s_cpu_u32 = (__u32 *)&cpu_key->on_disk_key;
   for( ; n_key_length--; ++p_s_le_u32, ++p_s_cpu_u32 ) {
     if ( le32_to_cpu (*p_s_le_u32) < *p_s_cpu_u32 )
       return -1;
diff -puN include/linux/reiserfs_fs.h~reiserfs-64-bit-fix include/linux/reiserfs_fs.h
--- 25/include/linux/reiserfs_fs.h~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/include/linux/reiserfs_fs.h	Mon Jul  7 14:10:03 2003
@@ -269,7 +269,7 @@ int is_reiserfs_jr (struct reiserfs_supe
 #define NO_BALANCING_NEEDED  (-4)
 #define NO_MORE_UNUSED_CONTIGUOUS_BLOCKS (-5)
 
-typedef unsigned long b_blocknr_t;
+typedef __u32 b_blocknr_t;
 typedef __u32 unp_t;
 
 struct unfm_nodeinfo {
@@ -570,7 +570,7 @@ extern void reiserfs_warning (const char
 static inline int uniqueness2type (__u32 uniqueness) CONSTF;
 static inline int uniqueness2type (__u32 uniqueness)
 {
-    switch (uniqueness) {
+    switch ((int)uniqueness) {
     case V1_SD_UNIQUENESS: return TYPE_STAT_DATA;
     case V1_INDIRECT_UNIQUENESS: return TYPE_INDIRECT;
     case V1_DIRECT_UNIQUENESS: return TYPE_DIRECT;
@@ -1730,11 +1730,11 @@ int journal_release_error(struct reiserf
 int journal_end(struct reiserfs_transaction_handle *, struct super_block *, unsigned long) ;
 int journal_end_sync(struct reiserfs_transaction_handle *, struct super_block *, unsigned long) ;
 int journal_mark_dirty_nolog(struct reiserfs_transaction_handle *, struct super_block *, struct buffer_head *bh) ;
-int journal_mark_freed(struct reiserfs_transaction_handle *, struct super_block *, unsigned long blocknr) ;
+int journal_mark_freed(struct reiserfs_transaction_handle *, struct super_block *, b_blocknr_t blocknr) ;
 int push_journal_writer(char *w) ;
 int pop_journal_writer(int windex) ;
 int journal_transaction_should_end(struct reiserfs_transaction_handle *, int) ;
-int reiserfs_in_journal(struct super_block *p_s_sb, int bmap_nr, int bit_nr, int searchall, unsigned long *next) ;
+int reiserfs_in_journal(struct super_block *p_s_sb, int bmap_nr, int bit_nr, int searchall, b_blocknr_t *next) ;
 int journal_begin(struct reiserfs_transaction_handle *, struct super_block *p_s_sb, unsigned long) ;
 void flush_async_commits(struct super_block *p_s_sb) ;
 
@@ -2105,8 +2105,8 @@ struct buffer_head * get_FEB (struct tre
 typedef struct __reiserfs_blocknr_hint reiserfs_blocknr_hint_t;
 
 int reiserfs_parse_alloc_options (struct super_block *, char *);
-int is_reusable (struct super_block * s, unsigned long block, int bit_value);
-void reiserfs_free_block (struct reiserfs_transaction_handle *th, unsigned long);
+int is_reusable (struct super_block * s, b_blocknr_t block, int bit_value);
+void reiserfs_free_block (struct reiserfs_transaction_handle *th, b_blocknr_t);
 int reiserfs_allocate_blocknrs(reiserfs_blocknr_hint_t *, b_blocknr_t * , int, int);
 extern inline int reiserfs_new_form_blocknrs (struct tree_balance * tb,
 					      b_blocknr_t *new_blocknrs, int amount_needed)
diff -puN include/linux/reiserfs_fs_sb.h~reiserfs-64-bit-fix include/linux/reiserfs_fs_sb.h
--- 25/include/linux/reiserfs_fs_sb.h~reiserfs-64-bit-fix	Mon Jul  7 14:10:03 2003
+++ 25-akpm/include/linux/reiserfs_fs_sb.h	Mon Jul  7 14:10:03 2003
@@ -133,7 +133,7 @@ typedef enum {
 struct reiserfs_journal_cnode {
   struct buffer_head *bh ;		 /* real buffer head */
   struct super_block *sb ;		 /* dev of real buffer head */
-  unsigned long blocknr ;		 /* block number of real buffer head, == 0 when buffer on disk */		 
+  __u32 blocknr ;		 /* block number of real buffer head, == 0 when buffer on disk */
   long state ;
   struct reiserfs_journal_list *jlist ;  /* journal list this cnode lives in */
   struct reiserfs_journal_cnode *next ;  /* next in transaction list */

_

