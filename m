Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVCDFBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVCDFBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCDE7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:59:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26563 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261499AbVCCTkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:40:24 -0500
Date: Thu, 3 Mar 2005 20:40:20 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Crash in ext3 while extracting 2.6.11 (on 2.6.11-rc5-something)
Message-ID: <20050303194020.GA13708@atrey.karlin.mff.cuni.cz>
References: <20050302180633.GA25304@ppc.vc.cvut.cz> <20050303131004.GA16512@atrey.karlin.mff.cuni.cz> <20050303144949.GH22176@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20050303144949.GH22176@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> On Thu, Mar 03, 2005 at 02:10:04PM +0100, Jan Kara wrote:
> >   Hello,
> > 
> > >    I've noticed that 2.6.11 is released, so I run (flawlessly) 'bk pull',
> > > and now I'm trying to export tree from 'bk' by doing 'bk export -tplain
> > > /tmp/linux-2.6.11'.  Unfortunately I tried it twice, and twice it died
> > > with same crash in log_do_checkpoint (see below).  Anybody has a clue
> > > what it could be?  When I hit alt-sysrq-s, sync takes about 10 seconds,
> > > so box had to have lots of disk caches dirtied when crash occured.
> > > 
> > >   Box is dual opteron rev cg, kernel has enabled all possible debug
> > > options.  Problem seems to occur on 2.6.11-rc4-something too, it just
> > > begins with crash in ext3_inode_dirty because I have rc4-something built
> > > without memory poisoning (probably).
> > > 
> > >   I've not noticed any other problems, and it was possible to extract
> > > 2.6.11-rc5-something on Monday with 2.6.11-rc4-something, which crashes
> > > now too.  I'll run 'fsck -f', maybe it will help things a bit...
> > > 
> > > Bootdata ok (command line is BOOT_IMAGE=Linux ro root=801 ramdisk=0 console=tty0 console=ttyS0,115200 nmi_watchdog=2 psmouse_noext=1 verbose)
> > > Linux version 2.6.11-rc5-2065-64 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #1 SMP Mon Feb 28 22:15:10 CET 2005
> > > 
> > > stack segment: 0000 [1] PREEMPT SMP 
> > > CPU 0 
> >   I don't see here a reason why the machine crashed (some NULL pointer
> > deref or what...). It would be useful to know it. Also could you run
> > gdb on vmlinux a find out where exactly in the function the oops
> > occured?
> 
> It died because of dereferencing RBP which contained memory poisoning
> signature:
> 
> 0xffffffff801d9996 <log_do_checkpoint+246>:     lock btsl $0x13,0x0(%rbp)
> 
> apparently x86-64 generates #SS for %rbp non-canonical addresses too, like 
> i386 does with %ebp segment overruns.
> 
> Crash occured in bit_spin_trylock called by jbd_trylock_bh_state from log_do_checkpoint
> (fs/jbd/checkpoint.c:636), because jh2bh (jh->b_bh) returned poisoned pattern 
> - apparently somebody else freed journal_head while we were holding pointer
> to it.  No idea how it happened.
  could you try applying attached patch and reproducing the problem? If
it is really oops because bh was set to NULL when freeing journal head
then the patch should catch it and write the place where we freed the
journal head...

								Thanks
									Honza

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jhdebug-2.6.11.diff"

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/jbd/checkpoint.c linux-2.6.11-jhdebug/fs/jbd/checkpoint.c
--- linux-2.6.11/fs/jbd/checkpoint.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.11-jhdebug/fs/jbd/checkpoint.c	2005-03-03 19:53:04.000000000 +0100
@@ -59,7 +59,7 @@ static int __try_to_free_cp_buf(struct j
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		__journal_remove_checkpoint(jh);
 		jbd_unlock_bh_state(bh);
-		journal_remove_journal_head(bh);
+		journal_remove_journal_head(bh, "__try_to_free_cp_buf");
 		BUFFER_TRACE(bh, "release");
 		__brelse(bh);
 		ret = 1;
@@ -182,7 +182,7 @@ static int __cleanup_transaction(journal
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			__journal_remove_checkpoint(jh);
 			jbd_unlock_bh_state(bh);
-			journal_remove_journal_head(bh);
+			journal_remove_journal_head(bh, "__cleanup_transaction");
 			__brelse(bh);
 			ret = 1;
 		} else {
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/jbd/commit.c linux-2.6.11-jhdebug/fs/jbd/commit.c
--- linux-2.6.11/fs/jbd/commit.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.11-jhdebug/fs/jbd/commit.c	2005-03-03 19:57:38.000000000 +0100
@@ -286,7 +286,7 @@ write_out_data:
 					goto write_out_data;
 				__journal_unfile_buffer(jh);
 				jbd_unlock_bh_state(bh);
-				journal_remove_journal_head(bh);
+				journal_remove_journal_head(bh, "commit_transaction_1");
 				put_bh(bh);
 				if (lock_need_resched(&journal->j_list_lock)) {
 					spin_unlock(&journal->j_list_lock);
@@ -327,7 +327,7 @@ write_out_data:
 		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
 			__journal_unfile_buffer(jh);
 			jbd_unlock_bh_state(bh);
-			journal_remove_journal_head(bh);
+			journal_remove_journal_head(bh, "commit_transaction_2");
 			put_bh(bh);
 		} else {
 			jbd_unlock_bh_state(bh);
@@ -560,7 +560,7 @@ wait_for_iobuf:
 		 * which were created by journal_write_metadata_buffer().
 		 */
 		BUFFER_TRACE(bh, "dumping temporary bh");
-		journal_put_journal_head(jh);
+		journal_put_journal_head(jh, "commit_transaction_4");
 		__brelse(bh);
 		J_ASSERT_BH(bh, atomic_read(&bh->b_count) == 0);
 		free_buffer_head(bh);
@@ -609,7 +609,7 @@ wait_for_iobuf:
 		BUFFER_TRACE(bh, "ph5: control buffer writeout done: unfile");
 		clear_buffer_jwrite(bh);
 		journal_unfile_buffer(journal, jh);
-		journal_put_journal_head(jh);
+		journal_put_journal_head(jh, "commit_transaction_b");
 		__brelse(bh);		/* One for getblk */
 		/* AKPM: bforget here */
 	}
@@ -676,7 +676,7 @@ wait_for_iobuf:
 		if (unlikely(ret == -EIO))
 			err = -EIO;
 		put_bh(bh);		/* One for getblk() */
-		journal_put_journal_head(descriptor);
+		journal_put_journal_head(descriptor, "commit_transaction_c");
 	}
 
 	/* End of a transaction!  Finally, we can do checkpoint
@@ -768,7 +768,7 @@ restart_loop:
 			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 			__journal_unfile_buffer(jh);
 			jbd_unlock_bh_state(bh);
-			journal_remove_journal_head(bh);  /* needs a brelse */
+			journal_remove_journal_head(bh, "commit_transaction_3");  /* needs a brelse */
 			release_buffer_page(bh);
 		}
 		spin_unlock(&journal->j_list_lock);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/jbd/journal.c linux-2.6.11-jhdebug/fs/jbd/journal.c
--- linux-2.6.11/fs/jbd/journal.c	2005-01-05 17:19:33.000000000 +0100
+++ linux-2.6.11-jhdebug/fs/jbd/journal.c	2005-03-03 19:50:52.000000000 +0100
@@ -1756,7 +1756,7 @@ struct journal_head *journal_grab_journa
 	return jh;
 }
 
-static void __journal_remove_journal_head(struct buffer_head *bh)
+static void __journal_remove_journal_head(struct buffer_head *bh, char *info)
 {
 	struct journal_head *jh = bh2jh(bh);
 
@@ -1786,6 +1786,7 @@ static void __journal_remove_journal_hea
 			jh->b_bh = NULL;	/* debug, really */
 			clear_buffer_jbd(bh);
 			__brelse(bh);
+			strncpy(jh->info, info, sizeof(jh->info)-1);
 			journal_free_journal_head(jh);
 		} else {
 			BUFFER_TRACE(bh, "journal_head was locked");
@@ -1806,10 +1807,10 @@ static void __journal_remove_journal_hea
  * time.  Once the caller has run __brelse(), the buffer is eligible for
  * reaping by try_to_free_buffers().
  */
-void journal_remove_journal_head(struct buffer_head *bh)
+void journal_remove_journal_head(struct buffer_head *bh, char *info)
 {
 	jbd_lock_bh_journal_head(bh);
-	__journal_remove_journal_head(bh);
+	__journal_remove_journal_head(bh, info);
 	jbd_unlock_bh_journal_head(bh);
 }
 
@@ -1817,7 +1818,7 @@ void journal_remove_journal_head(struct 
  * Drop a reference on the passed journal_head.  If it fell to zero then try to
  * release the journal_head from the buffer_head.
  */
-void journal_put_journal_head(struct journal_head *jh)
+void journal_put_journal_head(struct journal_head *jh, char *info)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
@@ -1825,7 +1826,7 @@ void journal_put_journal_head(struct jou
 	J_ASSERT_JH(jh, jh->b_jcount > 0);
 	--jh->b_jcount;
 	if (!jh->b_jcount && !jh->b_transaction) {
-		__journal_remove_journal_head(bh);
+		__journal_remove_journal_head(bh, info);
 		__brelse(bh);
 	}
 	jbd_unlock_bh_journal_head(bh);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/jbd/transaction.c linux-2.6.11-jhdebug/fs/jbd/transaction.c
--- linux-2.6.11/fs/jbd/transaction.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.11-jhdebug/fs/jbd/transaction.c	2005-03-03 20:00:11.000000000 +0100
@@ -759,7 +759,7 @@ int journal_get_write_access(handle_t *h
 	 * log thread also manipulates.  Make sure that the buffer
 	 * completes any outstanding IO before proceeding. */
 	rc = do_get_write_access(handle, jh, 0, credits);
-	journal_put_journal_head(jh);
+	journal_put_journal_head(jh, "journal_get_write_access");
 	return rc;
 }
 
@@ -837,7 +837,7 @@ int journal_get_create_access(handle_t *
 	 */
 	JBUFFER_TRACE(jh, "cancelling revoke");
 	journal_cancel_revoke(handle, jh);
-	journal_put_journal_head(jh);
+	journal_put_journal_head(jh, "get_create_access");
 out:
 	return err;
 }
@@ -914,7 +914,7 @@ repeat:
 	}
 	jbd_unlock_bh_state(bh);
 out:
-	journal_put_journal_head(jh);
+	journal_put_journal_head(jh, "journal_get_undo_access");
 	if (committed_data)
 		kfree(committed_data);
 	return err;
@@ -1075,7 +1075,7 @@ no_journal:
 		__brelse(bh);
 	}
 	JBUFFER_TRACE(jh, "exit");
-	journal_put_journal_head(jh);
+	journal_put_journal_head(jh, "journal_dirty_data");
 	return 0;
 }
 
@@ -1250,7 +1250,7 @@ int journal_forget (handle_t *handle, st
 		if (jh->b_cp_transaction) {
 			__journal_file_buffer(jh, transaction, BJ_Forget);
 		} else {
-			journal_remove_journal_head(bh);
+			journal_remove_journal_head(bh, "journal_forget");
 			__brelse(bh);
 			if (!buffer_jbd(bh)) {
 				spin_unlock(&journal->j_list_lock);
@@ -1556,7 +1556,7 @@ __journal_try_to_free_buffer(journal_t *
 			/* A written-back ordered data buffer */
 			JBUFFER_TRACE(jh, "release data");
 			__journal_unfile_buffer(jh);
-			journal_remove_journal_head(bh);
+			journal_remove_journal_head(bh, "__journal_try_to_free_buffer1");
 			__brelse(bh);
 		}
 	} else if (jh->b_cp_transaction != 0 && jh->b_transaction == 0) {
@@ -1564,7 +1564,7 @@ __journal_try_to_free_buffer(journal_t *
 		if (jh->b_jlist == BJ_None) {
 			JBUFFER_TRACE(jh, "remove from checkpoint list");
 			__journal_remove_checkpoint(jh);
-			journal_remove_journal_head(bh);
+			journal_remove_journal_head(bh, "__journal_try_to_free_buffer2");
 			__brelse(bh);
 		}
 	}
@@ -1633,7 +1633,7 @@ int journal_try_to_free_buffers(journal_
 
 		jbd_lock_bh_state(bh);
 		__journal_try_to_free_buffer(journal, bh);
-		journal_put_journal_head(jh);
+		journal_put_journal_head(jh, "journal_try_to_free_buffers");
 		jbd_unlock_bh_state(bh);
 		if (buffer_jbd(bh))
 			goto busy;
@@ -1669,7 +1669,7 @@ static int __dispose_buffer(struct journ
 		may_free = 0;
 	} else {
 		JBUFFER_TRACE(jh, "on running transaction");
-		journal_remove_journal_head(bh);
+		journal_remove_journal_head(bh, "__dispose_buffer");
 		__brelse(bh);
 	}
 	return may_free;
@@ -1778,7 +1778,7 @@ static int journal_unmap_buffer(journal_
 			spin_unlock(&journal->j_list_lock);
 			jbd_unlock_bh_state(bh);
 			spin_unlock(&journal->j_state_lock);
-			journal_put_journal_head(jh);
+			journal_put_journal_head(jh, "journal_unmap_buffer_1");
 			return ret;
 		} else {
 			/* There is no currently-running transaction. So the
@@ -1792,7 +1792,7 @@ static int journal_unmap_buffer(journal_
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
 				spin_unlock(&journal->j_state_lock);
-				journal_put_journal_head(jh);
+				journal_put_journal_head(jh, "journal_unmap_buffer_2");
 				return ret;
 			} else {
 				/* The orphan record's transaction has
@@ -1816,7 +1816,7 @@ static int journal_unmap_buffer(journal_
 		spin_unlock(&journal->j_list_lock);
 		jbd_unlock_bh_state(bh);
 		spin_unlock(&journal->j_state_lock);
-		journal_put_journal_head(jh);
+		journal_put_journal_head(jh, "journal_unmap_buffer_3");
 		return 0;
 	} else {
 		/* Good, the buffer belongs to the running transaction.
@@ -1830,7 +1830,7 @@ static int journal_unmap_buffer(journal_
 	}
 
 zap_buffer:
-	journal_put_journal_head(jh);
+	journal_put_journal_head(jh, "journal_unmap_buffer_4");
 zap_buffer_no_jh:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
@@ -2045,7 +2045,7 @@ void journal_refile_buffer(journal_t *jo
 
 	__journal_refile_buffer(jh);
 	jbd_unlock_bh_state(bh);
-	journal_remove_journal_head(bh);
+	journal_remove_journal_head(bh, "journal_refile_buffer");
 
 	spin_unlock(&journal->j_list_lock);
 	__brelse(bh);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/include/linux/jbd.h linux-2.6.11-jhdebug/include/linux/jbd.h
--- linux-2.6.11/include/linux/jbd.h	2005-03-03 18:58:40.000000000 +0100
+++ linux-2.6.11-jhdebug/include/linux/jbd.h	2005-03-03 20:04:11.000000000 +0100
@@ -316,6 +316,10 @@ BUFFER_FNS(Freed, freed)
 
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
+	if (!jh->b_bh) {
+		printk(KERN_ERR "JH without BH! Info: %s\n", jh->info);
+		dump_stack();
+	}
 	return jh->b_bh;
 }
 
@@ -918,8 +922,8 @@ extern int	   journal_force_commit(journ
  */
 struct journal_head *journal_add_journal_head(struct buffer_head *bh);
 struct journal_head *journal_grab_journal_head(struct buffer_head *bh);
-void journal_remove_journal_head(struct buffer_head *bh);
-void journal_put_journal_head(struct journal_head *jh);
+void journal_remove_journal_head(struct buffer_head *bh, char *info);
+void journal_put_journal_head(struct journal_head *jh, char *info);
 
 /*
  * handle management
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/include/linux/journal-head.h linux-2.6.11-jhdebug/include/linux/journal-head.h
--- linux-2.6.11/include/linux/journal-head.h	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6.11-jhdebug/include/linux/journal-head.h	2005-03-03 19:49:42.000000000 +0100
@@ -80,6 +80,8 @@ struct journal_head {
 	 * [j_list_lock]
 	 */
 	struct journal_head *b_cpnext, *b_cpprev;
+	/* Debug info */
+	char info[32];
 };
 
 #endif		/* JOURNAL_HEAD_H_INCLUDED */

--CE+1k2dSO48ffgeK--
