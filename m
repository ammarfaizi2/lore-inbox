Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSFJKoQ>; Mon, 10 Jun 2002 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSFJKoP>; Mon, 10 Jun 2002 06:44:15 -0400
Received: from draco.netpower.no ([212.33.133.34]:37131 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S314446AbSFJKoI>; Mon, 10 Jun 2002 06:44:08 -0400
Date: Mon, 10 Jun 2002 12:43:47 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: patch@luckynet.dynu.com
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH][2.5] introduce new list macros for hfs (5 occ)
Message-ID: <20020610124347.A18644@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think you forgot a list_move() in your patch...
was it meant to be like this?

--- old/fs/hfs/catalog.c	Wed Feb 13 00:40:41 2002
+++ new/fs/hfs/catalog.c	Sun Jun  9 23:52:57 2002
@@ -882,10 +879,8 @@
 		}
 
 		if (!entry->count) {
-		        list_del(&entry->hash);
-			INIT_LIST_HEAD(&entry->hash);
-			list_del(&entry->list);
-			list_add(&entry->list, dispose);
+		    list_del_init(&entry->hash);
+			list_move(&entry->list, dispose);
 			continue;
 		}
 		

And while we're at it, here's patches for the rest of
the files in {fs,net,sound,arch/m68k,arch/sparc64,drivers}/ subdirs.
I'm pretty shure that it covers all. Maybe you've got all of
these in your tree already...

Pre-req: the two new list-macros are here:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=102362676727017&w=2

First the fs/ dir:

--- old/fs/autofs4/expire.c	Tue Jun 12 02:15:27 2001
+++ new/fs/autofs4/expire.c	Sun Jun  9 23:47:12 2002
@@ -200,8 +200,7 @@
 			DPRINTK(("autofs_expire: returning %p %.*s\n",
 				 dentry, (int)dentry->d_name.len, dentry->d_name.name));
 			/* Start from here next time */
-			list_del(&root->d_subdirs);
-			list_add(&root->d_subdirs, &dentry->d_child);
+			list_move(&root->d_subdirs, &dentry->d_child);
 			dget(dentry);
 			spin_unlock(&dcache_lock);
 
--- old/fs/buffer.c	Sun Jun  9 13:18:26 2002
+++ new/fs/buffer.c	Sun Jun  9 23:47:51 2002
@@ -691,8 +691,7 @@
 		struct buffer_head *bh, struct list_head *list)
 {
 	spin_lock(lock);
-	list_del(&bh->b_assoc_buffers);
-	list_add(&bh->b_assoc_buffers, list);
+	list_move(&bh->b_assoc_buffers, list);
 	spin_unlock(lock);
 }
 
--- old/fs/dcache.c	Sun Jun  9 13:18:43 2002
+++ new/fs/dcache.c	Sun Jun  9 23:49:21 2002
@@ -397,8 +397,7 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
+		list_move(tmp, &dentry_unused);
 	}
 
 	/*
@@ -496,8 +495,7 @@
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_move(&dentry->d_lru, dentry_unused.prev);
 			found++;
 		}
 		/*
@@ -560,8 +558,7 @@
 		list_for_each(lp, head) {
 			struct dentry *this = list_entry(lp, struct dentry, d_hash);
 			if (!atomic_read(&this->d_count)) {
-				list_del(&this->d_lru);
-				list_add_tail(&this->d_lru, &dentry_unused);
+				list_move_tail(&this->d_lru, &dentry_unused);
 				found++;
 			}
 		}
@@ -1053,8 +1050,7 @@
 
 	spin_lock(&dcache_lock);
 	/* Move the dentry to the target hash queue */
-	list_del(&dentry->d_hash);
-	list_add(&dentry->d_hash, &target->d_hash);
+	list_move(&dentry->d_hash, &target->d_hash);
 
 	/* Unhash the target: dput() will then get rid of it */
 	list_del_init(&target->d_hash);
--- old/fs/dquot.c	Thu May 30 00:03:03 2002
+++ new/fs/dquot.c	Sun Jun  9 23:50:24 2002
@@ -190,8 +190,7 @@
 
 static inline void remove_dquot_hash(struct dquot *dquot)
 {
-	list_del(&dquot->dq_hash);
-	INIT_LIST_HEAD(&dquot->dq_hash);
+	list_del_init(&dquot->dq_hash);
 }
 
 static inline struct dquot *find_dquot(unsigned int hashent, struct super_block *sb, unsigned int id, int type)
@@ -224,16 +223,14 @@
 /* Move dquot to the head of free list (it must be already on it) */
 static inline void move_dquot_head(struct dquot *dquot)
 {
-	list_del(&dquot->dq_free);
-	list_add(&dquot->dq_free, &free_dquots);
+	list_move(&dquot->dq_free, &free_dquots);
 }
 
 static inline void remove_free_dquot(struct dquot *dquot)
 {
 	if (list_empty(&dquot->dq_free))
 		return;
-	list_del(&dquot->dq_free);
-	INIT_LIST_HEAD(&dquot->dq_free);
+	list_del_init(&dquot->dq_free);
 	dqstats.free_dquots--;
 }
 
@@ -738,8 +735,7 @@
 	while (act_head != tofree_head) {
 		dquot = list_entry(act_head, struct dquot, dq_free);
 		act_head = act_head->next;
-		list_del(&dquot->dq_free);	/* Remove dquot from the list so we won't have problems... */
-		INIT_LIST_HEAD(&dquot->dq_free);
+		list_del_init(&dquot->dq_free);	/* Remove dquot from the list so we won't have problems... */
 		dqput(dquot);
 	}
 	unlock_kernel();
--- old/fs/file_table.c	Thu Apr 25 01:26:49 2002
+++ new/fs/file_table.c	Sun Jun  9 23:51:31 2002
@@ -118,8 +118,7 @@
 		file_list_lock();
 		file->f_dentry = NULL;
 		file->f_vfsmnt = NULL;
-		list_del(&file->f_list);
-		list_add(&file->f_list, &free_list);
+		list_move(&file->f_list, &free_list);
 		files_stat.nr_free_files++;
 		file_list_unlock();
 		dput(dentry);
@@ -146,8 +145,7 @@
 {
 	if(atomic_dec_and_test(&file->f_count)) {
 		file_list_lock();
-		list_del(&file->f_list);
-		list_add(&file->f_list, &free_list);
+		list_move(&file->f_list, &free_list);
 		files_stat.nr_free_files++;
 		file_list_unlock();
 	}
@@ -158,8 +156,7 @@
 	if (!list)
 		return;
 	file_list_lock();
-	list_del(&file->f_list);
-	list_add(&file->f_list, list);
+	list_move(&file->f_list, list);
 	file_list_unlock();
 }
 
--- old/fs/fs-writeback.c	Sun Jun  9 13:18:26 2002
+++ new/fs/fs-writeback.c	Sun Jun  9 23:52:03 2002
@@ -92,8 +92,7 @@
 		 * it (that would break s_dirty time-ordering).
 		 */
 		if (!was_dirty) {
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &sb->s_dirty);
+			list_move(&inode->i_list, &sb->s_dirty);
 		}
 	}
 out:
@@ -133,8 +132,7 @@
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 
-	list_del(&inode->i_list);
-	list_add(&inode->i_list, &sb->s_locked_inodes);
+	list_move(&inode->i_list, &sb->s_locked_inodes);
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -250,8 +248,7 @@
 		__writeback_single_inode(inode, really_sync, nr_to_write);
 		if (sync_mode == WB_SYNC_HOLD) {
 			mapping->dirtied_when = jiffies;
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &inode->i_sb->s_dirty);
+			list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		}
 		if (current_is_pdflush())
 			writeback_release(bdi);
--- old/fs/inode.c	Sun Jun  9 13:18:43 2002
+++ new/fs/inode.c	Sun Jun  9 23:53:52 2002
@@ -189,8 +189,7 @@
 	}
 	atomic_inc(&inode->i_count);
 	if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, &inode_in_use);
+		list_move(&inode->i_list, &inode_in_use);
 	}
 	inodes_stat.nr_unused--;
 }
@@ -271,8 +270,7 @@
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			list_del_init(&inode->i_hash);
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, dispose);
+			list_move(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
 			count++;
 			continue;
@@ -389,9 +387,8 @@
 			continue;
 		if (atomic_read(&inode->i_count))
 			continue;
-		list_del(tmp);
 		list_del_init(&inode->i_hash);
-		list_add(tmp, freeable);
+		list_move(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
 		if (!--goal)
@@ -813,8 +810,7 @@
 
 	if (!list_empty(&inode->i_hash)) {
 		if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &inode_unused);
+			list_move(&inode->i_list, &inode_unused);
 		}
 		inodes_stat.nr_unused++;
 		spin_unlock(&inode_lock);
--- old/fs/intermezzo/psdev.c	Thu May 30 00:00:29 2002
+++ new/fs/intermezzo/psdev.c	Sun Jun  9 23:55:14 2002
@@ -162,8 +162,7 @@
                 if (tmp->rq_unique == hdr.unique) {
                         req = tmp;
                       /* unlink here: keeps search length minimal */
-                        list_del(&req->rq_chain);
-                      INIT_LIST_HEAD(&req->rq_chain);
+                        list_del_init(&req->rq_chain);
                         CDEBUG(D_PSDEV,"Eureka opc %d uniq %d!\n",
                                hdr.opcode, hdr.unique);
                         break;
@@ -1442,8 +1441,7 @@
                 schedule();
 
         }
-      list_del(&req->rq_chain); 
-      INIT_LIST_HEAD(&req->rq_chain); 
+      list_del_init(&req->rq_chain); 
         remove_wait_queue(&req->rq_sleep, &wait);
         current->state = TASK_RUNNING;
 
--- old/fs/jffs2/erase.c	Tue Mar 19 13:08:47 2002
+++ new/fs/jffs2/erase.c	Sun Jun  9 23:56:17 2002
@@ -61,8 +61,7 @@
 	if (!instr) {
 		printk(KERN_WARNING "kmalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		spin_lock_bh(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		spin_unlock_bh(&c->erase_completion_lock);
 		return;
@@ -93,8 +92,7 @@
 		/* Erase failed immediately. Refile it on the list */
 		D1(printk(KERN_DEBUG "Erase at 0x%08x failed: %d. Refiling on erase_pending_list\n", jeb->offset, ret));
 		spin_lock_bh(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		spin_unlock_bh(&c->erase_completion_lock);
 		return;
@@ -106,8 +104,7 @@
 		printk(KERN_WARNING "Erase at 0x%08x failed immediately: errno %d\n", jeb->offset, ret);
 
 	spin_lock_bh(&c->erase_completion_lock);
-	list_del(&jeb->list);
-	list_add(&jeb->list, &c->bad_list);
+	list_move(&jeb->list, &c->bad_list);
 	c->nr_erasing_blocks--;
 	c->bad_size += c->sector_size;
 	c->erasing_size -= c->sector_size;
@@ -156,8 +153,7 @@
 {
 	D1(printk(KERN_DEBUG "Erase completed successfully at 0x%08x\n", jeb->offset));
 	spin_lock(&c->erase_completion_lock);
-	list_del(&jeb->list);
-	list_add_tail(&jeb->list, &c->erase_complete_list);
+	list_move_tail(&jeb->list, &c->erase_complete_list);
 	spin_unlock(&c->erase_completion_lock);
 }
 
@@ -167,8 +163,7 @@
 	 spin_lock(&c->erase_completion_lock);
 	 c->erasing_size -= c->sector_size;
 	 c->bad_size += c->sector_size;
-	 list_del(&jeb->list);
-	 list_add(&jeb->list, &c->bad_list);
+	 list_move(&jeb->list, &c->bad_list);
 	 c->nr_erasing_blocks--;
 	 spin_unlock(&c->erase_completion_lock);
 	 wake_up(&c->erase_wait);
--- old/fs/jffs2/nodemgmt.c	Tue Mar 19 13:08:47 2002
+++ new/fs/jffs2/nodemgmt.c	Sun Jun  9 23:58:27 2002
@@ -177,8 +177,7 @@
 				struct jffs2_eraseblock *ejeb;
 
 				ejeb = list_entry(c->erasable_list.next, struct jffs2_eraseblock, list);
-				list_del(&ejeb->list);
-				list_add_tail(&ejeb->list, &c->erase_pending_list);
+				list_move_tail(&ejeb->list, &c->erase_pending_list);
 				c->nr_erasing_blocks++;
 				D1(printk(KERN_DEBUG "jffs2_do_reserve_space: Triggering erase of erasable block at 0x%08x\n",
 					  ejeb->offset));
@@ -427,10 +426,8 @@
 	} else if (jeb == c->gcblock) {
 		D2(printk(KERN_DEBUG "Not moving gcblock 0x%08x to dirty_list\n", jeb->offset));
 	} else if (jeb->dirty_size == ref->totlen) {
-		D1(printk(KERN_DEBUG "Eraseblock at 0x%08x is freshly dirtied. Removing from clean list...\n", jeb->offset));
-		list_del(&jeb->list);
-		D1(printk(KERN_DEBUG "...and adding to dirty_list\n"));
-		list_add_tail(&jeb->list, &c->dirty_list);
+		D1(printk(KERN_DEBUG "Eraseblock at 0x%08x is freshly dirtied. Moving from clean list to dirty_list\n", jeb->offset));
+		list_move_tail(&jeb->list, &c->dirty_list);
 	}
 
 	spin_unlock_bh(&c->erase_completion_lock);
--- old/fs/jffs2/wbuf.c	Tue Mar 19 13:08:47 2002
+++ new/fs/jffs2/wbuf.c	Sun Jun  9 23:58:41 2002
@@ -61,8 +61,7 @@
 		return;
 
 	list_for_each_safe(this, next, &c->erasable_pending_wbuf_list) {
-		list_del(this);
-		list_add_tail(this, &c->erasable_list);
+		list_move_tail(this, &c->erasable_list);
 	}
 }
 
--- old/fs/jffs2/scan.c	Tue Mar 19 13:08:47 2002
+++ new/fs/jffs2/scan.c	Sun Jun  9 23:59:10 2002
@@ -806,11 +806,10 @@
 {
 	struct list_head *n = head->next;
 
-	list_del(head);
 	while(count--) {
 		n = n->next;
 	}
-	list_add(head, n);
+	list_move(head, n);
 }
 
 static void jffs2_rotate_lists(struct jffs2_sb_info *c)
--- old/fs/jfs/jfs_dmap.c	Sun Jun  9 13:18:27 2002
+++ new/fs/jfs/jfs_dmap.c	Sun Jun  9 23:59:21 2002
@@ -552,8 +552,7 @@
 
 				/* move bp after tblock in logsync list */
 				LOGSYNC_LOCK(log);
-				list_del(&mp->synclist);
-				list_add(&mp->synclist, &tblk->synclist);
+				list_move(&mp->synclist, &tblk->synclist);
 				LOGSYNC_UNLOCK(log);
 			}
 
--- old/fs/jfs/jfs_imap.c	Thu May 30 00:00:30 2002
+++ new/fs/jfs/jfs_imap.c	Sun Jun  9 23:59:33 2002
@@ -2819,8 +2819,7 @@
 			mp->lsn = lsn;
 			/* move mp after tblock in logsync list */
 			LOGSYNC_LOCK(log);
-			list_del(&mp->synclist);
-			list_add(&mp->synclist, &tblk->synclist);
+			list_move(&mp->synclist, &tblk->synclist);
 			LOGSYNC_UNLOCK(log);
 		}
 		/* inherit younger/larger clsn */
--- old/fs/jfs/jfs_logmgr.c	Sun Jun  9 13:18:43 2002
+++ new/fs/jfs/jfs_logmgr.c	Sun Jun  9 23:59:43 2002
@@ -290,8 +290,7 @@
 			tblk->lsn = mp->lsn;
 
 			/* move tblock after page on logsynclist */
-			list_del(&tblk->synclist);
-			list_add(&tblk->synclist, &mp->synclist);
+			list_move(&tblk->synclist, &mp->synclist);
 		}
 	}
 
--- old/fs/jfs/jfs_txnmgr.c	Sun Jun  9 13:18:43 2002
+++ new/fs/jfs/jfs_txnmgr.c	Mon Jun 10 00:00:58 2002
@@ -2963,11 +2963,8 @@
 				    &jfs_ip->anon_inode_list)
 					continue;
 
-				/* Take off anon_list */
-				list_del(&jfs_ip->anon_inode_list);
-
-				/* Put on anon_list2 */
-				list_add(&jfs_ip->anon_inode_list,
+				/* Move from anon_list to anon_list2 */
+				list_move(&jfs_ip->anon_inode_list,
 					 &TxAnchor.anon_list2);
 			}
 		}
--- old/fs/libfs.c	Thu May 30 00:00:50 2002
+++ new/fs/libfs.c	Mon Jun 10 00:01:19 2002
@@ -74,8 +74,7 @@
 					n--;
 				p = p->next;
 			}
-			list_del(&cursor->d_child);
-			list_add_tail(&cursor->d_child, p);
+			list_move_tail(&cursor->d_child, p);
 			spin_unlock(&dcache_lock);
 		}
 	}
@@ -115,8 +114,7 @@
 		default:
 			spin_lock(&dcache_lock);
 			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &dentry->d_subdirs);
+				list_move(q, &dentry->d_subdirs);
 			}
 			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
 				struct dentry *next;
@@ -129,8 +127,7 @@
 					return 0;
 				spin_lock(&dcache_lock);
 				/* next is still alive */
-				list_del(q);
-				list_add(q, p);
+				list_move(q, p);
 				p = q;
 				filp->f_pos++;
 			}
--- old/fs/mpage.c	Thu May 30 00:03:04 2002
+++ new/fs/mpage.c	Mon Jun 10 00:01:55 2002
@@ -516,8 +516,7 @@
 			if (!PageActive(page) && PageLRU(page)) {
 				spin_lock(&pagemap_lru_lock);
 				if (!PageActive(page) && PageLRU(page)) {
-					list_del(&page->lru);
-					list_add(&page->lru, &inactive_list);
+					list_move(&page->lru, &inactive_list);
 				}
 				spin_unlock(&pagemap_lru_lock);
 			}
--- old/fs/namespace.c	Thu May 30 00:03:04 2002
+++ new/fs/namespace.c	Mon Jun 10 00:02:10 2002
@@ -263,8 +263,7 @@
 	LIST_HEAD(kill);
 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_list);
-		list_add(&p->mnt_list, &kill);
+		list_move(&p->mnt_list, &kill);
 	}
 
 	while (!list_empty(&kill)) {
--- old/fs/nfs/write.c	Thu May 30 00:03:04 2002
+++ new/fs/nfs/write.c	Mon Jun 10 00:02:20 2002
@@ -338,8 +338,7 @@
 	if (!NFS_WBACK_BUSY(req))
 		printk(KERN_ERR "NFS: unlocked request attempted unhashed!\n");
 	inode = req->wb_inode;
-	list_del(&req->wb_hash);
-	INIT_LIST_HEAD(&req->wb_hash);
+	list_del_init(&req->wb_hash);
 	nfsi = NFS_I(inode);
 	nfsi->npages--;
 	if ((nfsi->npages == 0) != list_empty(&nfsi->writeback))



And the net/ subdir:

--- old/net/core/dev.c	Sun Jun  9 13:18:45 2002
+++ new/net/core/dev.c	Sun Jun  9 23:40:09 2002
@@ -1596,8 +1596,7 @@
 
 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
 			local_irq_disable();
-			list_del(&dev->poll_list);
-			list_add_tail(&dev->poll_list, &queue->poll_list);
+			list_move_tail(&dev->poll_list, &queue->poll_list);
 			if (dev->quota < 0)
 				dev->quota += dev->weight;
 			else


And the sound/ subdir:

--- old/sound/core/timer.c	Sun Mar 10 16:31:08 2002
+++ new/sound/core/timer.c	Sun Jun  9 23:32:39 2002
@@ -179,8 +179,7 @@
 			master = (snd_timer_instance_t *)list_entry(q, snd_timer_instance_t, open_list);
 			if (slave->slave_class == master->slave_class &&
 			    slave->slave_id == master->slave_id) {
-				list_del(&slave->open_list);
-				list_add_tail(&slave->open_list, &master->slave_list_head);
+				list_move_tail(&slave->open_list, &master->slave_list_head);
 				slave->master = master;
 				return;
 			}
@@ -205,8 +204,7 @@
 		slave = (snd_timer_instance_t *)list_entry(p, snd_timer_instance_t, open_list);
 		if (slave->slave_class == master->slave_class &&
 		    slave->slave_id == master->slave_id) {
-			list_del(p);
-			list_add_tail(p, &master->slave_list_head);
+			list_move_tail(p, &master->slave_list_head);
 			spin_lock_irqsave(&slave_active_lock, flags);
 			/* protected here so that timer_start() doesn't start
 			 * this slave yet.
@@ -299,8 +297,7 @@
 		/* remove slave links */
 		list_for_each_safe(p, n, &timeri->slave_list_head) {
 			slave = (snd_timer_instance_t *)list_entry(p, snd_timer_instance_t, open_list);
-			list_del(p);
-			list_add_tail(p, &snd_timer_slave_list);
+			list_move_tail(p, &snd_timer_slave_list);
 			spin_lock_irqsave(&slave_active_lock, flags);
 			slave->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
 			list_del_init(&slave->active_list);
@@ -335,8 +332,7 @@
 
 static int snd_timer_start1(snd_timer_t *timer, snd_timer_instance_t *timeri, unsigned long sticks)
 {
-	list_del(&timeri->active_list);
-	list_add_tail(&timeri->active_list, &timer->active_list_head);
+	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |= SNDRV_TIMER_IFLG_START;
@@ -524,8 +520,7 @@
 					timer->running--;
 				}
 				/* relink to done_list */
-				list_del(p);
-				list_add_tail(p, &done_list_head);
+				list_move_tail(p, &done_list_head);
 				atomic_inc(&ti->in_use);
 			}
 		}
@@ -557,8 +552,7 @@
 	list_for_each_safe(p, n, &done_list_head) {
 		ti = (snd_timer_instance_t *)list_entry(p, snd_timer_instance_t, active_list);
 		/* append to active_list */
-		list_del(p);
-		list_add_tail(p, &timer->active_list_head);
+		list_move_tail(p, &timer->active_list_head);
 		spin_unlock(&timer->lock);
 		if (ti->callback)
 			ti->callback(ti, resolution, ti->ticks, ti->callback_data);
--- old/sound/pci/emu10k1/memory.c	Thu May  2 21:42:43 2002
+++ new/sound/pci/emu10k1/memory.c	Sun Jun  9 23:35:06 2002
@@ -259,8 +259,7 @@
 	spin_lock_irqsave(&emu->memblk_lock, flags);
 	if (blk->mapped_page >= 0) {
 		/* update order link */
-		list_del(&blk->mapped_order_link);
-		list_add_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
+		list_move_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
 		spin_unlock_irqrestore(&emu->memblk_lock, flags);
 		return 0;
 	}


And the drives/ subdir:

--- old/drivers/char/h8.c	Sun Jun  9 13:18:24 2002
+++ new/drivers/char/h8.c	Mon Jun 10 00:12:46 2002
@@ -454,7 +454,6 @@
         }
         /* get first element from queue */
         qp = list_entry(h8_freeq.next, h8_cmd_q_t, link);
-        list_del(&qp->link);
 
         restore_flags(flags);
 
@@ -468,7 +467,7 @@
         save_flags(flags); cli();
 
         /* XXX this actually puts it at the start of cmd queue, bug? */
-        list_add(&qp->link, &h8_cmdq);
+        list_move(&qp->link, &h8_cmdq);
 
         restore_flags(flags);
 
@@ -505,9 +504,8 @@
          * it on the active queue.
          */
         qp = list_entry(h8_cmdq.next, h8_cmd_q_t, link);
-        list_del(&qp->link);
         /* XXX should this go to the end of the active queue? */
-        list_add(&qp->link, &h8_actq);
+        list_move(&qp->link, &h8_actq);
         h8_state = H8_XMIT;
         if (h8_debug & 0x1)
                 Dprintk("h8_start_new_cmd: Starting a command\n");
--- old/drivers/ieee1394/ieee1394_core.c	Thu Apr 25 01:26:39 2002
+++ new/drivers/ieee1394/ieee1394_core.c	Mon Jun 10 00:14:15 2002
@@ -776,8 +776,7 @@
                 packet = list_entry(lh, struct hpsb_packet, list);
 		next = lh->next;
                 if (time_before(packet->sendtime + expire, jiffies)) {
-                        list_del(&packet->list);
-                        list_add(&packet->list, &expiredlist);
+                        list_move(&packet->list, &expiredlist);
                 }
         }
 
--- old/drivers/ieee1394/nodemgr.c	Thu Apr 25 01:26:39 2002
+++ new/drivers/ieee1394/nodemgr.c	Mon Jun 10 00:14:44 2002
@@ -745,15 +745,13 @@
 					 struct hpsb_protocol_driver *driver)
 {
 	ud->driver = driver;
-	list_del(&ud->driver_list);
-	list_add_tail(&ud->driver_list, &driver->unit_directories);
+	list_move_tail(&ud->driver_list, &driver->unit_directories);
 }
 
 static void nodemgr_release_unit_directory(struct unit_directory *ud)
 {
 	ud->driver = NULL;
-	list_del(&ud->driver_list);
-	list_add_tail(&ud->driver_list, &unit_directory_list);
+	list_move_tail(&ud->driver_list, &unit_directory_list);
 }
 
 void hpsb_release_unit_directory(struct unit_directory *ud)
--- old/drivers/ieee1394/raw1394.c	Thu Apr 25 01:26:39 2002
+++ new/drivers/ieee1394/raw1394.c	Mon Jun 10 00:15:18 2002
@@ -95,8 +95,7 @@
         struct file_info *fi = req->file_info;
 
         spin_lock_irqsave(&fi->reqlists_lock, flags);
-        list_del(&req->list);
-        list_add_tail(&req->list, &fi->req_complete);
+        list_move_tail(&req->list, &fi->req_complete);
         spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
         up(&fi->complete_sem);
--- old/drivers/ieee1394/sbp2.c	Thu Apr 25 01:26:39 2002
+++ new/drivers/ieee1394/sbp2.c	Mon Jun 10 00:17:03 2002
@@ -710,8 +710,7 @@
 	sbp2_spin_lock(&hi->sbp2_request_packet_lock, flags);
 	free_tlabel(hi->host, LOCAL_BUS | request_packet->packet->node_id,
 		    request_packet->packet->tlabel);
-	list_del(&request_packet->list);
-	list_add_tail(&request_packet->list, &hi->sbp2_req_free);
+	list_move_tail(&request_packet->list, &hi->sbp2_req_free);
 	sbp2_spin_unlock(&hi->sbp2_request_packet_lock, flags);
 
 	return;
@@ -913,9 +912,8 @@
 	unsigned long flags;
 
 	sbp2_spin_lock(&scsi_id->sbp2_command_orb_lock, flags);
-	list_del(&command->list);
+	list_move_tail(&command->list, &scsi_id->sbp2_command_orb_completed);
 	sbp2util_free_command_dma(command);
-	list_add_tail(&command->list, &scsi_id->sbp2_command_orb_completed);
 	sbp2_spin_unlock(&scsi_id->sbp2_command_orb_lock, flags);
 }
 
--- old/drivers/ieee1394/amdtp.c	Thu Apr 25 01:26:39 2002
+++ new/drivers/ieee1394/amdtp.c	Mon Jun 10 00:17:34 2002
@@ -392,8 +392,7 @@
 	 * back to the free list, and notify any waiters.
 	 */
 	spin_lock(&s->packet_list_lock);
-	list_del(&pl->link);
-	list_add_tail(&pl->link, &s->free_packet_lists);
+	list_move_tail(&pl->link, &s->free_packet_lists);
 	spin_unlock(&s->packet_list_lock);
 
 	wake_up_interruptible(&s->packet_list_wait);
--- old/drivers/md/lvm-snap.c	Thu May  2 21:44:08 2002
+++ new/drivers/md/lvm-snap.c	Mon Jun 10 00:19:05 2002
@@ -109,11 +109,8 @@
 		    kdev_same(exception->rdev_org, org_dev))
 		{
 			if (i)
-			{
 				/* fun, isn't it? :) */
-				list_del(next);
-				list_add(next, hash_table);
-			}
+				list_move(next, hash_table);
 			ret = exception;
 			break;
 		}
--- old/drivers/md/md.c	Thu May 30 00:03:02 2002
+++ new/drivers/md/md.c	Mon Jun 10 00:20:03 2002
@@ -626,8 +626,7 @@
 		MD_BUG();
 		return;
 	}
-	list_del(&rdev->same_set);
-	INIT_LIST_HEAD(&rdev->same_set);
+	list_del_init(&rdev->same_set);
 	rdev->mddev->nb_dev--;
 	printk(KERN_INFO "md: unbind<%s,%d>\n", partition_name(rdev->dev),
 						 rdev->mddev->nb_dev);
@@ -680,13 +679,11 @@
 		MD_BUG();
 	unlock_rdev(rdev);
 	free_disk_sb(rdev);
-	list_del(&rdev->all);
-	INIT_LIST_HEAD(&rdev->all);
+	list_del_init(&rdev->all);
 	if (rdev->pending.next != &rdev->pending) {
 		printk(KERN_INFO "md: (%s was pending)\n",
 			partition_name(rdev->dev));
-		list_del(&rdev->pending);
-		INIT_LIST_HEAD(&rdev->pending);
+		list_del_init(&rdev->pending);
 	}
 #ifndef MODULE
 	md_autodetect_dev(rdev->dev);
@@ -745,8 +742,7 @@
 		schedule();
 
 	del_mddev_mapping(mddev, mk_kdev(MD_MAJOR, mdidx(mddev)));
-	list_del(&mddev->all_mddevs);
-	INIT_LIST_HEAD(&mddev->all_mddevs);
+	list_del_init(&mddev->all_mddevs);
 	kfree(mddev);
 	MOD_DEC_USE_COUNT;
 }
@@ -1935,8 +1931,7 @@
 					continue;
 				}
 				printk(KERN_INFO "md:  adding %s ...\n", partition_name(rdev->dev));
-				list_del(&rdev->pending);
-				list_add(&rdev->pending, &candidates);
+				list_move(&rdev->pending, &candidates);
 			}
 		}
 		/*
@@ -1963,8 +1958,7 @@
 		printk(KERN_INFO "md: created md%d\n", mdidx(mddev));
 		ITERATE_RDEV_GENERIC(candidates,pending,rdev,tmp) {
 			bind_rdev_to_array(rdev, mddev);
-			list_del(&rdev->pending);
-			INIT_LIST_HEAD(&rdev->pending);
+			list_del_init(&rdev->pending);
 		}
 		autorun_array(mddev);
 	}
--- old/drivers/net/ppp_generic.c	Thu May  2 21:44:08 2002
+++ new/drivers/net/ppp_generic.c	Mon Jun 10 00:21:55 2002
@@ -2406,8 +2406,7 @@
 	while ((list = list->next) != &new_channels) {
 		pch = list_entry(list, struct channel, list);
 		if (pch->file.index == unit) {
-			list_del(&pch->list);
-			list_add(&pch->list, &all_channels);
+			list_move(&pch->list, &all_channels);
 			return pch;
 		}
 	}
--- old/drivers/s390/block/dasd.c	Sun Jun  9 13:18:41 2002
+++ new/drivers/s390/block/dasd.c	Mon Jun 10 00:25:11 2002
@@ -1547,11 +1547,12 @@
 			goto restart;
 		}
 
-		/* Dechain request from device request queue ... */
+		/*
+		 * Move request from device request queue
+		 * to the list of final requests.
+		 */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of final requests. */
-		list_add_tail(&cqr->list, final_queue);
+		list_move_tail(&cqr->list, final_queue);
 	}
 }
 
@@ -1710,11 +1711,12 @@
 			__dasd_process_erp(device, cqr);
 			continue;
 		}
-		/* Dechain request from device request queue ... */
+		/*
+		 * Move request from device request queue
+		 * to the list of flushed requests.
+		 */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of flushed requests. */
-		list_add_tail(&cqr->list, &flush_queue);
+		list_move_tail(&cqr->list, &flush_queue);
 	}
 	spin_unlock_irq(get_irq_lock(device->devinfo.irq));
 	/* Now call the callback function of flushed requests */
--- old/drivers/usb/class/audio.c	Thu May 30 00:00:48 2002
+++ new/drivers/usb/class/audio.c	Mon Jun 10 00:26:26 2002
@@ -3832,8 +3832,7 @@
 		return;
 	}
 	down(&open_sem);
-	list_del(&s->audiodev);
-	INIT_LIST_HEAD(&s->audiodev);
+	list_del_init(&s->audiodev);
 	s->usbdev = NULL;
 	/* deregister all audio and mixer devices, so no new processes can open this device */
 	for(list = s->audiolist.next; list != &s->audiolist; list = list->next) {
--- old/drivers/usb/class/usb-midi.c	Sun Jun  9 13:18:42 2002
+++ new/drivers/usb/class/usb-midi.c	Mon Jun 10 00:26:46 2002
@@ -2072,8 +2072,7 @@
 		return;
 	}
 	down(&open_sem);
-	list_del(&s->mididev);
-	INIT_LIST_HEAD(&s->mididev);
+	list_del_init(&s->mididev);
 	s->usbdev = NULL;
 
 	for ( list = s->midiDevList.next; list != &s->midiDevList; list = list->next ) {
--- old/drivers/usb/core/devio.c	Thu May 30 00:00:48 2002
+++ new/drivers/usb/core/devio.c	Mon Jun 10 00:27:34 2002
@@ -215,8 +215,7 @@
         unsigned long flags;
         
         spin_lock_irqsave(&ps->lock, flags);
-        list_del(&as->asynclist);
-        INIT_LIST_HEAD(&as->asynclist);
+        list_del_init(&as->asynclist);
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
@@ -228,8 +227,7 @@
         spin_lock_irqsave(&ps->lock, flags);
         if (!list_empty(&ps->async_completed)) {
                 as = list_entry(ps->async_completed.next, struct async, asynclist);
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
         }
         spin_unlock_irqrestore(&ps->lock, flags);
         return as;
@@ -247,8 +245,7 @@
                 p = p->next;
                 if (as->userurb != userurb)
                         continue;
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
                 spin_unlock_irqrestore(&ps->lock, flags);
                 return as;
         }
@@ -263,8 +260,7 @@
 	struct siginfo sinfo;
 
         spin_lock(&ps->lock);
-        list_del(&as->asynclist);
-        list_add_tail(&as->asynclist, &ps->async_completed);
+        list_move_tail(&as->asynclist, &ps->async_completed);
         spin_unlock(&ps->lock);
         wake_up(&ps->wait);
 	if (as->signr) {
@@ -284,8 +280,7 @@
         spin_lock_irqsave(&ps->lock, flags);
         while (!list_empty(&ps->async_pending)) {
                 as = list_entry(ps->async_pending.next, struct async, asynclist);
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
                 spin_unlock_irqrestore(&ps->lock, flags);
                 /* usb_unlink_urb calls the completion handler with status == -ENOENT */
                 usb_unlink_urb(as->urb);
@@ -528,8 +523,7 @@
 	unsigned int i;
 
 	lock_kernel();
-	list_del(&ps->list);
-	INIT_LIST_HEAD(&ps->list);
+	list_del_init(&ps->list);
 	if (ps->dev) {
 		for (i = 0; ps->ifclaimed && i < 8*sizeof(ps->ifclaimed); i++)
 			if (test_bit(i, &ps->ifclaimed))
--- old/drivers/usb/core/hub.c	Thu May 30 00:03:03 2002
+++ new/drivers/usb/core/hub.c	Mon Jun 10 00:28:32 2002
@@ -499,10 +499,8 @@
 	spin_lock_irqsave(&hub_event_lock, flags);
 
 	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
+	list_del_init(&hub->event_list);
+	list_del_init(&hub->hub_list);
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
@@ -519,10 +517,8 @@
 	spin_lock_irqsave(&hub_event_lock, flags);
 
 	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
+	list_del_init(&hub->event_list);
+	list_del_init(&hub->hub_list);
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
@@ -946,8 +942,7 @@
 		hub = list_entry(tmp, struct usb_hub, event_list);
 		dev = hub->dev;
 
-		list_del(tmp);
-		INIT_LIST_HEAD(tmp);
+		list_del_init(tmp);
 
 		down(&hub->khubd_sem); /* never blocks, we were on list */
 		spin_unlock_irqrestore(&hub_event_lock, flags);
--- old/drivers/usb/core/inode.c	Sun Jun  9 13:18:42 2002
+++ new/drivers/usb/core/inode.c	Mon Jun 10 00:38:51 2002
@@ -672,8 +672,7 @@
 	}
 	while (!list_empty(&dev->filelist)) {
 		ds = list_entry(dev->filelist.next, struct dev_state, list);
-		list_del(&ds->list);
-		INIT_LIST_HEAD(&ds->list);
+		list_del_init(&ds->list);
 		down_write(&ds->devsem);
 		ds->dev = NULL;
 		up_write(&ds->devsem);
--- old/drivers/usb/host/uhci.c	Thu May 30 00:00:49 2002
+++ new/drivers/usb/host/uhci.c	Mon Jun 10 00:40:16 2002
@@ -2009,8 +2009,7 @@
 
 		/* Check if the URB timed out */
 		if (u->timeout && time_after_eq(jiffies, up->inserttime + u->timeout)) {
-			list_del(&u->urb_list);
-			list_add_tail(&u->urb_list, &list);
+			list_move_tail(&u->urb_list, &list);
 		}
 
 		spin_unlock(&u->lock);
--- old/drivers/usb/host/usb-ohci.c	Sun Jun  9 13:18:42 2002
+++ new/drivers/usb/host/usb-ohci.c	Mon Jun 10 00:40:41 2002
@@ -2434,8 +2434,7 @@
 		usb_free_bus (ohci->bus);
 	}
 
-	list_del (&ohci->ohci_hcd_list);
-	INIT_LIST_HEAD (&ohci->ohci_hcd_list);
+	list_del_init (&ohci->ohci_hcd_list);
 
 	ohci_mem_cleanup (ohci);
     
--- old/drivers/usb/host/uhci-hcd.c	Sun Jun  9 13:18:42 2002
+++ new/drivers/usb/host/uhci-hcd.c	Mon Jun 10 00:42:39 2002
@@ -1773,10 +1773,8 @@
 			uhci_fsbr_timeout(uhci, u);
 
 		/* Check if the URB timed out */
-		if (u->timeout && time_after_eq(jiffies, up->inserttime + u->timeout)) {
-			list_del(&up->urb_list);
-			list_add_tail(&up->urb_list, &list);
-		}
+		if (u->timeout && time_after_eq(jiffies, up->inserttime + u->timeout))
+			list_move_tail(&up->urb_list, &list);
 
 		spin_unlock(&u->lock);
 	}
--- old/drivers/usb/host/hc_simple.c	Thu May 30 00:03:03 2002
+++ new/drivers/usb/host/hc_simple.c	Mon Jun 10 00:45:28 2002
@@ -222,8 +222,7 @@
 		if (urb->transfer_flags & (USB_ASYNC_UNLINK | USB_TIMEOUT_KILLED)) {
 			/* asynchron with callback */
 
-			list_del (&urb->urb_list);	/* relink the urb to the del list */
-			list_add (&urb->urb_list, &hci->del_list);
+			list_move (&urb->urb_list, &hci->del_list);	/* relink the urb to the del list */
 			spin_unlock_irqrestore (&usb_urb_lock, flags);
 
 		} else {
@@ -235,8 +234,7 @@
 			comp = urb->complete;
 			urb->complete = NULL;
 
-			list_del (&urb->urb_list);	/* relink the urb to the del list */
-			list_add (&urb->urb_list, &hci->del_list);
+			list_move (&urb->urb_list, &hci->del_list);	/* relink the urb to the del list */
 
 			spin_unlock_irqrestore (&usb_urb_lock, flags);
 
@@ -560,8 +558,7 @@
 	epd_t *ed = &hci_dev->ed[qu_pipeindex (urb->pipe)];
 
 	DBGFUNC ("enter qu_next_urb\n");
-	list_del (&urb->urb_list);
-	INIT_LIST_HEAD (&urb->urb_list);
+	list_del_init (&urb->urb_list);
 	if (ed->pipe_head == urb) {
 
 #ifdef HC_URB_TIMEOUT
@@ -574,8 +571,7 @@
 
 		if (!list_empty (&ed->urb_queue)) {
 			urb = list_entry (ed->urb_queue.next, struct urb, urb_list);
-			list_del (&urb->urb_list);
-			INIT_LIST_HEAD (&urb->urb_list);
+			list_del_init (&urb->urb_list);
 			ed->pipe_head = urb;
 			qu_queue_active_urb (hci, urb, ed);
 		} else {
@@ -756,8 +752,7 @@
 		 * only when the new SOF happens */
 
 		lh = hci->bulk_list.next;
-		list_del (&hci->bulk_list);
-		list_add (&hci->bulk_list, lh);
+		list_move (&hci->bulk_list, lh);
 	}
 	return 0;
 }
--- old/drivers/usb/host/hc_sl811.c	Thu May 30 00:03:03 2002
+++ new/drivers/usb/host/hc_sl811.c	Mon Jun 10 00:45:42 2002
@@ -1206,8 +1206,7 @@
 	usb_deregister_bus (hci->bus);
 	usb_free_bus (hci->bus);
 
-	list_del (&hci->hci_hcd_list);
-	INIT_LIST_HEAD (&hci->hci_hcd_list);
+	list_del_init (&hci->hci_hcd_list);
 
 	kfree (hci);
 }
--- old/drivers/usb/media/dabusb.c	Thu May 30 00:00:29 2002
+++ new/drivers/usb/media/dabusb.c	Mon Jun 10 00:45:56 2002
@@ -80,8 +80,7 @@
 		goto err;
 	}
 	tmp = src->next;
-	list_del (tmp);
-	list_add_tail (tmp, dst);
+	list_move_tail (tmp, dst);
 
   err:	spin_unlock_irqrestore (&s->lock, flags);
 	return ret;
--- old/drivers/usb/serial/ipaq.c	Thu May 30 00:00:49 2002
+++ new/drivers/usb/serial/ipaq.c	Mon Jun 10 00:47:13 2002
@@ -401,8 +401,7 @@
 		pkt->written += count;
 		priv->queue_len -= count;
 		if (pkt->written == pkt->len) {
-			list_del(&pkt->list);
-			list_add(&pkt->list, &priv->freelist);
+			list_move(&pkt->list, &priv->freelist);
 			priv->free_len += PACKET_SIZE;
 		}
 		if (room == 0) {
