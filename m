Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUINKHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUINKHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUINKGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:06:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26060 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269249AbUINKFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:05:37 -0400
Date: Tue, 14 Sep 2004 12:06:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched, ext3: fix scheduling latencies in ext3
Message-ID: <20040914100652.GB24622@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20040914095731.GA24622@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies in the ext3 code, and
it also cleans up the existing lock-break functionality to use the new
primitives.

This patch has been in the -VP patchset for quite some time.

	Ingo

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-ext3.patch"


the attached patch fixes long scheduling latencies in the ext3 code, and
it also cleans up the existing lock-break functionality to use the new
primitives.

This patch has been in the -VP patchset for quite some time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/jbd/checkpoint.c.orig	
+++ linux/fs/jbd/checkpoint.c	
@@ -333,6 +333,10 @@ int log_do_checkpoint(journal_t *journal
 				break;
 			}
 			retry = __flush_buffer(journal, jh, bhs, &batch_count, &drop_count);
+			if (cond_resched_lock(&journal->j_list_lock)) {
+				retry = 1;
+				break;
+			}
 		} while (jh != last_jh && !retry);
 
 		if (batch_count)
@@ -487,6 +491,14 @@ int __journal_clean_checkpoint_list(jour
 				/* Use trylock because of the ranknig */
 				if (jbd_trylock_bh_state(jh2bh(jh)))
 					ret += __try_to_free_cp_buf(jh);
+				/*
+				 * This function only frees up some memory
+				 * if possible so we dont have an obligation
+				 * to finish processing. Bail out if preemption
+				 * requested:
+				 */
+				if (need_resched())
+					goto out;
 			} while (jh != last_jh);
 		}
 	} while (transaction != last_transaction);
--- linux/fs/jbd/commit.c.orig	
+++ linux/fs/jbd/commit.c	
@@ -262,7 +262,7 @@ write_out_data:
 			__journal_file_buffer(jh, commit_transaction,
 						BJ_Locked);
 			jbd_unlock_bh_state(bh);
-			if (need_resched()) {
+			if (lock_need_resched(&journal->j_list_lock)) {
 				spin_unlock(&journal->j_list_lock);
 				goto write_out_data;
 			}
@@ -288,7 +288,7 @@ write_out_data:
 				jbd_unlock_bh_state(bh);
 				journal_remove_journal_head(bh);
 				put_bh(bh);
-				if (need_resched()) {
+				if (lock_need_resched(&journal->j_list_lock)) {
 					spin_unlock(&journal->j_list_lock);
 					goto write_out_data;
 				}
@@ -333,11 +333,7 @@ write_out_data:
 			jbd_unlock_bh_state(bh);
 		}
 		put_bh(bh);
-		if (need_resched()) {
-			spin_unlock(&journal->j_list_lock);
-			cond_resched();
-			spin_lock(&journal->j_list_lock);
-		}
+		cond_resched_lock(&journal->j_list_lock);
 	}
 	spin_unlock(&journal->j_list_lock);
 
@@ -545,6 +541,8 @@ wait_for_iobuf:
 			wait_on_buffer(bh);
 			goto wait_for_iobuf;
 		}
+		if (cond_resched())
+			goto wait_for_iobuf;
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;
@@ -599,6 +597,8 @@ wait_for_iobuf:
 			wait_on_buffer(bh);
 			goto wait_for_ctlbuf;
 		}
+		if (cond_resched())
+			goto wait_for_ctlbuf;
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;
@@ -719,6 +719,7 @@ skip_commit: /* The journal should be un
 	J_ASSERT(commit_transaction->t_shadow_list == NULL);
 	J_ASSERT(commit_transaction->t_log_list == NULL);
 
+restart_loop:
 	while (commit_transaction->t_forget) {
 		transaction_t *cp_transaction;
 		struct buffer_head *bh;
@@ -792,6 +793,8 @@ skip_commit: /* The journal should be un
 			release_buffer_page(bh);
 		}
 		spin_unlock(&journal->j_list_lock);
+		if (cond_resched())
+			goto restart_loop;
 	}
 
 	/* Done with this transaction! */
--- linux/fs/jbd/recovery.c.orig	
+++ linux/fs/jbd/recovery.c	
@@ -354,6 +354,8 @@ static int do_one_pass(journal_t *journa
 		struct buffer_head *	obh;
 		struct buffer_head *	nbh;
 
+		cond_resched();		/* We're under lock_kernel() */
+
 		/* If we already know where to stop the log traversal,
 		 * check right now that we haven't gone past the end of
 		 * the log. */
--- linux/fs/ext3/ialloc.c.orig	
+++ linux/fs/ext3/ialloc.c	
@@ -733,6 +733,7 @@ unsigned long ext3_count_free_inodes (st
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
+		cond_resched();
 	}
 	return desc_count;
 #endif
--- linux/fs/ext3/namei.c.orig	
+++ linux/fs/ext3/namei.c	
@@ -674,6 +674,7 @@ static int dx_make_map (struct ext3_dir_
 			map_tail->hash = h.hash;
 			map_tail->offs = (u32) ((char *) de - base);
 			count++;
+			cond_resched();
 		}
 		/* XXX: do we need to check rec_len == 0 case? -Chris */
 		de = (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
--- linux/fs/ext3/super.c.orig	
+++ linux/fs/ext3/super.c	
@@ -1231,6 +1231,8 @@ static int ext3_fill_super (struct super
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
 
+	unlock_kernel();
+
 	blocksize = sb_min_blocksize(sb, EXT3_MIN_BLOCK_SIZE);
 	if (!blocksize) {
 		printk(KERN_ERR "EXT3-fs: unable to set blocksize\n");
@@ -1576,6 +1578,7 @@ static int ext3_fill_super (struct super
 	percpu_counter_mod(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
+	lock_kernel();
 	return 0;
 
 failed_mount3:
@@ -1597,6 +1600,7 @@ failed_mount:
 out_fail:
 	sb->s_fs_info = NULL;
 	kfree(sbi);
+	lock_kernel();
 	return -EINVAL;
 }
 
@@ -2113,9 +2117,11 @@ int ext3_statfs (struct super_block * sb
 		 * block group descriptors.  If the sparse superblocks
 		 * feature is turned on, then not all groups have this.
 		 */
-		for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++)
+		for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
 			overhead += ext3_bg_has_super(sb, i) +
 				ext3_bg_num_gdb(sb, i);
+			cond_resched();
+		}
 
 		/*
 		 * Every block group has an inode bitmap, a block
--- linux/fs/ext3/balloc.c.orig	
+++ linux/fs/ext3/balloc.c	
@@ -207,6 +207,11 @@ do_more:
 		}
 		jbd_lock_bh_state(bitmap_bh);
 #endif
+		if (need_resched()) {
+			jbd_unlock_bh_state(bitmap_bh);
+			cond_resched();
+			jbd_lock_bh_state(bitmap_bh);
+		}
 		/* @@@ This prevents newly-allocated data from being
 		 * freed and then reallocated within the same
 		 * transaction. 

--JP+T4n/bALQSJXh8--
