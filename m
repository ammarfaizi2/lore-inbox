Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUIHDRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUIHDRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbUIHDRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:17:08 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:39397 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S269015AbUIHDQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:16:53 -0400
Date: Tue, 7 Sep 2004 20:16:53 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] possible reiserfs deadlock in 2.6.8.1
Message-ID: <Pine.LNX.4.58.0409072016090.12274@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

below is a possible deadlock in the linux-2.6.8.1 reiserfs code found by
a static deadlock checker I'm writing.  Let me know if it looks valid
and/or whether the output is too cryptic.    Note, one of the locks is
through a struct pointer, so the deadlock depends on both acquisitions
being to the same struct.

Thanks,
Dawson

ERROR:DEADLOCK: 2 thread cycle:
     lock_kernel  <<===>>  *jl->struct reiserfs_journal_list->j_commit_lock

   thread 1: lock_kernel ==>> *jl->struct reiserfs_journal_list->j_commit_lock
       trace 1: ncalls=1, ncond=3
          fs/reiserfs/journal.c:flush_async_commits
             2933: static void flush_async_commits(void *p) {
             2934:   struct super_block *p_s_sb = p;
             2935:   struct reiserfs_journal_list *jl;
             2936:   struct list_head *entry;
             2937:
===>         2938:   lock_kernel();
             2939:   if (!list_empty(&SB_JOURNAL(p_s_sb)->j_journal_list)) {
             2940:       /* last entry is the youngest, commit it and you get everything */
             2941:       entry = SB_JOURNAL(p_s_sb)->j_journal_list.prev;
             2942:       jl = JOURNAL_LIST_ENTRY(entry);
===>         2943:       flush_commit_list(p_s_sb, jl, 1);

             fs/reiserfs/journal.c:flush_commit_list
                906: */
                907: static int flush_commit_list(struct super_block *s, struct reiserfs_journal_list *jl, int flushall) {
                908:   int i;
                909:   int bn ;
                910:   struct buffer_head *tbh = NULL ;
                ...
                932:     }
                933:   }
                934:
                935:   /* make sure nobody is trying to flush this one at the same time */
===>            936:   down(&jl->j_commit_lock);


       trace 3: ncalls=2, ncond=4
          fs/reiserfs/namei.c:reiserfs_create
             587: 		struct nameidata *nd)
             588: {
             589:     int retval;
             590:     struct inode * inode;
             591:     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 ;
             ...
             600:         return retval;
             601:
             602:     locked = reiserfs_cache_default_acl (dir);
             603:
			// [NOTE: this calls lock_kernel()!]
===>         604:     reiserfs_write_lock(dir->i_sb);
             ...
             618:
             619:     inode->i_op = &reiserfs_file_inode_operations;
             620:     inode->i_fop = &reiserfs_file_operations;
             621:     inode->i_mapping->a_ops = &reiserfs_address_space_operations ;
             622:
             ...
             624: 				inode, 1/*visible*/);
             625:     if (retval) {
             626: 	inode->i_nlink--;
             627: 	reiserfs_update_sd (&th, inode);
===>         628: 	journal_end(&th, dir->i_sb, jbegin_count) ;
             fs/reiserfs/journal.c:journal_end
                2799:
                2800: int journal_end(struct reiserfs_transaction_handle *th, struct super_block *p_s_sb, unsigned long nblocks) {
                2801:   if (!current->journal_info && th->t_refcount > 1)
                2802:     reiserfs_warning (p_s_sb, "REISER-NESTING: th NULL, refcount %d",
                2803:                       th->t_refcount);
                ...
                2817:       th->t_trans_id = 0;
                2818:     }
                2819:     return 0;
                2820:   } else {
===>            2821:     return do_journal_end(th, p_s_sb, nblocks, 0) ;
                fs/reiserfs/journal.c:do_journal_end
                   3313: static int do_journal_end(struct reiserfs_transaction_handle *th, struct super_block  * p_s_sb, unsigned long nblocks,
                   3314: 		          int flags) {
                   3315:   struct reiserfs_journal_cnode *cn, *next, *jl_cn;
                   3316:   struct reiserfs_journal_cnode *last_cn = NULL;
                   3317:   struct reiserfs_journal_desc *desc ;
                   ...
                   3403:    * we want to make sure nobody tries to run flush_commit_list until
                   3404:    * the new transaction is fully setup, and we've already flushed the
                   3405:    * ordered bh list
                   3406:    */
===>               3407:   down(&jl->j_commit_lock);


     -----------
   thread 2: *jl->struct reiserfs_journal_list->j_commit_lock ==>> lock_kernel
       trace 1: ncalls=0, ncond=0
          fs/reiserfs/journal.c:do_journal_end
             3313: static int do_journal_end(struct reiserfs_transaction_handle *th, struct super_block  * p_s_sb, unsigned long nblocks,
             3314: 		          int flags) {
	     ...
===>         3407:   down(&jl->j_commit_lock);
             ...
             3552:   if (!list_empty(&jl->j_tail_bh_list)) {
             3553:       unlock_kernel();
             3554:       write_ordered_buffers(&SB_JOURNAL(p_s_sb)->j_dirty_buffers_lock,
             3555: 			    SB_JOURNAL(p_s_sb), jl, &jl->j_tail_bh_list);
===>         3556:       lock_kernel();
     -----------
