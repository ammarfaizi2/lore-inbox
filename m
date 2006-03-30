Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWC3ISI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWC3ISI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWC3IRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:50 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46931 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932098AbWC3IRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:43 -0500
Message-Id: <20060330081731.538392000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:13 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Ian Kent <raven@themaw.net>,
       Joel Becker <joel.becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Urban Widmark <urban@teststation.com>,
       David Howells <dhowells@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 8/8] fs: use list_move()
Content-Disposition: inline; filename=list-move-fs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B) under fs/.

CC: Ian Kent <raven@themaw.net>
CC: Joel Becker <joel.becker@oracle.com>
CC: Neil Brown <neilb@cse.unsw.edu.au>
CC: Hans Reiser <reiserfs-dev@namesys.com>
CC: Urban Widmark <urban@teststation.com>
CC: David Howells <dhowells@redhat.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/afs/cell.c              |    3 +--
 fs/afs/kafsasyncd.c        |    9 +++------
 fs/afs/server.c            |    6 ++----
 fs/afs/vlocation.c         |    6 ++----
 fs/afs/vnode.c             |    3 +--
 fs/autofs4/expire.c        |    3 +--
 fs/configfs/dir.c          |    6 ++----
 fs/jffs2/erase.c           |   15 +++++----------
 fs/jffs2/nodemgmt.c        |    3 +--
 fs/jffs2/wbuf.c            |    3 +--
 fs/nfsd/nfs4state.c        |    3 +--
 fs/nfsd/nfscache.c         |    3 +--
 fs/ocfs2/dlm/dlmast.c      |    3 +--
 fs/ocfs2/dlm/dlmconvert.c  |    9 +++------
 fs/ocfs2/dlm/dlmlock.c     |    3 +--
 fs/ocfs2/dlm/dlmrecovery.c |    9 +++------
 fs/ocfs2/dlm/dlmthread.c   |    6 ++----
 fs/ocfs2/dlm/dlmunlock.c   |    3 +--
 fs/ocfs2/journal.c         |    3 +--
 fs/reiserfs/journal.c      |    6 ++----
 fs/smbfs/request.c         |    6 ++----
 fs/smbfs/smbiod.c          |    3 +--
 22 files changed, 38 insertions(+), 76 deletions(-)

Index: 2.6-git/fs/autofs4/expire.c
===================================================================
--- 2.6-git.orig/fs/autofs4/expire.c
+++ 2.6-git/fs/autofs4/expire.c
@@ -370,8 +370,7 @@ next:
 		DPRINTK("returning %p %.*s",
 			expired, (int)expired->d_name.len, expired->d_name.name);
 		spin_lock(&dcache_lock);
-		list_del(&expired->d_parent->d_subdirs);
-		list_add(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
+		list_move(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
 		spin_unlock(&dcache_lock);
 		return expired;
 	}
Index: 2.6-git/fs/configfs/dir.c
===================================================================
--- 2.6-git.orig/fs/configfs/dir.c
+++ 2.6-git/fs/configfs/dir.c
@@ -954,8 +954,7 @@ static int configfs_readdir(struct file 
 			/* fallthrough */
 		default:
 			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &parent_sd->s_children);
+				list_move(q, &parent_sd->s_children);
 			}
 			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
 				struct configfs_dirent *next;
@@ -978,8 +977,7 @@ static int configfs_readdir(struct file 
 						 dt_type(next)) < 0)
 					return 0;
 
-				list_del(q);
-				list_add(q, p);
+				list_move(q, p);
 				p = q;
 				filp->f_pos++;
 			}
Index: 2.6-git/fs/nfsd/nfs4state.c
===================================================================
--- 2.6-git.orig/fs/nfsd/nfs4state.c
+++ 2.6-git/fs/nfsd/nfs4state.c
@@ -482,8 +482,7 @@ move_to_confirmed(struct nfs4_client *cl
 
 	dprintk("NFSD: move_to_confirm nfs4_client %p\n", clp);
 	list_del_init(&clp->cl_strhash);
-	list_del_init(&clp->cl_idhash);
-	list_add(&clp->cl_idhash, &conf_id_hashtbl[idhashval]);
+	list_move(&clp->cl_idhash, &conf_id_hashtbl[idhashval]);
 	strhashval = clientstr_hashval(clp->cl_recdir);
 	list_add(&clp->cl_strhash, &conf_str_hashtbl[strhashval]);
 	renew_client(clp);
Index: 2.6-git/fs/nfsd/nfscache.c
===================================================================
--- 2.6-git.orig/fs/nfsd/nfscache.c
+++ 2.6-git/fs/nfsd/nfscache.c
@@ -103,8 +103,7 @@ nfsd_cache_shutdown(void)
 static void
 lru_put_end(struct svc_cacherep *rp)
 {
-	list_del(&rp->c_lru);
-	list_add_tail(&rp->c_lru, &lru_head);
+	list_move_tail(&rp->c_lru, &lru_head);
 }
 
 /*
Index: 2.6-git/fs/reiserfs/journal.c
===================================================================
--- 2.6-git.orig/fs/reiserfs/journal.c
+++ 2.6-git/fs/reiserfs/journal.c
@@ -834,8 +834,7 @@ static int write_ordered_buffers(spinloc
 		get_bh(bh);
 		if (test_set_buffer_locked(bh)) {
 			if (!buffer_dirty(bh)) {
-				list_del_init(&jh->list);
-				list_add(&jh->list, &tmp);
+				list_move(&jh->list, &tmp);
 				goto loop_next;
 			}
 			spin_unlock(lock);
@@ -855,8 +854,7 @@ static int write_ordered_buffers(spinloc
 			ret = -EIO;
 		}
 		if (buffer_dirty(bh)) {
-			list_del_init(&jh->list);
-			list_add(&jh->list, &tmp);
+			list_move(&jh->list, &tmp);
 			add_to_chunk(&chunk, bh, lock, write_ordered_chunk);
 		} else {
 			reiserfs_free_jh(bh);
Index: 2.6-git/fs/smbfs/request.c
===================================================================
--- 2.6-git.orig/fs/smbfs/request.c
+++ 2.6-git/fs/smbfs/request.c
@@ -398,8 +398,7 @@ static int smb_request_send_req(struct s
 	if (!(req->rq_flags & SMB_REQ_TRANSMITTED))
 		goto out;
 
-	list_del_init(&req->rq_queue);
-	list_add_tail(&req->rq_queue, &server->recvq);
+	list_move_tail(&req->rq_queue, &server->recvq);
 	result = 1;
 out:
 	return result;
@@ -433,8 +432,7 @@ int smb_request_send_server(struct smb_s
 	result = smb_request_send_req(req);
 	if (result < 0) {
 		server->conn_error = result;
-		list_del_init(&req->rq_queue);
-		list_add(&req->rq_queue, &server->xmitq);
+		list_move(&req->rq_queue, &server->xmitq);
 		result = -EIO;
 		goto out;
 	}
Index: 2.6-git/fs/smbfs/smbiod.c
===================================================================
--- 2.6-git.orig/fs/smbfs/smbiod.c
+++ 2.6-git/fs/smbfs/smbiod.c
@@ -183,8 +183,7 @@ int smbiod_retry(struct smb_sb_info *ser
 		if (req->rq_flags & SMB_REQ_RETRY) {
 			/* must move the request to the xmitq */
 			VERBOSE("retrying request %p on recvq\n", req);
-			list_del(&req->rq_queue);
-			list_add(&req->rq_queue, &server->xmitq);
+			list_move(&req->rq_queue, &server->xmitq);
 			continue;
 		}
 #endif
Index: 2.6-git/fs/afs/cell.c
===================================================================
--- 2.6-git.orig/fs/afs/cell.c
+++ 2.6-git/fs/afs/cell.c
@@ -413,8 +413,7 @@ int afs_server_find_by_peer(const struct
 
 	/* we found it in the graveyard - resurrect it */
  found_dead_server:
-	list_del(&server->link);
-	list_add_tail(&server->link, &cell->sv_list);
+	list_move_tail(&server->link, &cell->sv_list);
 	afs_get_server(server);
 	afs_kafstimod_del_timer(&server->timeout);
 	spin_unlock(&cell->sv_gylock);
Index: 2.6-git/fs/afs/kafsasyncd.c
===================================================================
--- 2.6-git.orig/fs/afs/kafsasyncd.c
+++ 2.6-git/fs/afs/kafsasyncd.c
@@ -136,8 +136,7 @@ static int kafsasyncd(void *arg)
 			if (!list_empty(&kafsasyncd_async_attnq)) {
 				op = list_entry(kafsasyncd_async_attnq.next,
 						struct afs_async_op, link);
-				list_del(&op->link);
-				list_add_tail(&op->link,
+				list_move_tail(&op->link,
 					      &kafsasyncd_async_busyq);
 			}
 
@@ -204,8 +203,7 @@ void afs_kafsasyncd_begin_op(struct afs_
 	init_waitqueue_entry(&op->waiter, kafsasyncd_task);
 	add_wait_queue(&op->call->waitq, &op->waiter);
 
-	list_del(&op->link);
-	list_add_tail(&op->link, &kafsasyncd_async_busyq);
+	list_move_tail(&op->link, &kafsasyncd_async_busyq);
 
 	spin_unlock(&kafsasyncd_async_lock);
 
@@ -223,8 +221,7 @@ void afs_kafsasyncd_attend_op(struct afs
 
 	spin_lock(&kafsasyncd_async_lock);
 
-	list_del(&op->link);
-	list_add_tail(&op->link, &kafsasyncd_async_attnq);
+	list_move_tail(&op->link, &kafsasyncd_async_attnq);
 
 	spin_unlock(&kafsasyncd_async_lock);
 
Index: 2.6-git/fs/afs/server.c
===================================================================
--- 2.6-git.orig/fs/afs/server.c
+++ 2.6-git/fs/afs/server.c
@@ -123,8 +123,7 @@ int afs_server_lookup(struct afs_cell *c
  resurrect_server:
 	_debug("resurrecting server");
 
-	list_del(&zombie->link);
-	list_add_tail(&zombie->link, &cell->sv_list);
+	list_move_tail(&zombie->link, &cell->sv_list);
 	afs_get_server(zombie);
 	afs_kafstimod_del_timer(&zombie->timeout);
 	spin_unlock(&cell->sv_gylock);
@@ -168,8 +167,7 @@ void afs_put_server(struct afs_server *s
 	}
 
 	spin_lock(&cell->sv_gylock);
-	list_del(&server->link);
-	list_add_tail(&server->link, &cell->sv_graveyard);
+	list_move_tail(&server->link, &cell->sv_graveyard);
 
 	/* time out in 10 secs */
 	afs_kafstimod_add_timer(&server->timeout, 10 * HZ);
Index: 2.6-git/fs/afs/vlocation.c
===================================================================
--- 2.6-git.orig/fs/afs/vlocation.c
+++ 2.6-git/fs/afs/vlocation.c
@@ -326,8 +326,7 @@ int afs_vlocation_lookup(struct afs_cell
 	/* found in the graveyard - resurrect */
 	_debug("found in graveyard");
 	atomic_inc(&vlocation->usage);
-	list_del(&vlocation->link);
-	list_add_tail(&vlocation->link, &cell->vl_list);
+	list_move_tail(&vlocation->link, &cell->vl_list);
 	spin_unlock(&cell->vl_gylock);
 
 	afs_kafstimod_del_timer(&vlocation->timeout);
@@ -478,8 +477,7 @@ static void __afs_put_vlocation(struct a
 	}
 
 	/* move to graveyard queue */
-	list_del(&vlocation->link);
-	list_add_tail(&vlocation->link,&cell->vl_graveyard);
+	list_move_tail(&vlocation->link,&cell->vl_graveyard);
 
 	/* remove from pending timeout queue (refcounted if actually being
 	 * updated) */
Index: 2.6-git/fs/afs/vnode.c
===================================================================
--- 2.6-git.orig/fs/afs/vnode.c
+++ 2.6-git/fs/afs/vnode.c
@@ -104,8 +104,7 @@ static void afs_vnode_finalise_status_up
 					vnode->cb_expiry * HZ);
 
 		spin_lock(&afs_cb_hash_lock);
-		list_del(&vnode->cb_hash_link);
-		list_add_tail(&vnode->cb_hash_link,
+		list_move_tail(&vnode->cb_hash_link,
 			      &afs_cb_hash(server, &vnode->fid));
 		spin_unlock(&afs_cb_hash_lock);
 
Index: 2.6-git/fs/jffs2/erase.c
===================================================================
--- 2.6-git.orig/fs/jffs2/erase.c
+++ 2.6-git/fs/jffs2/erase.c
@@ -54,8 +54,7 @@ static void jffs2_erase_block(struct jff
 	if (!instr) {
 		printk(KERN_WARNING "kmalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		spin_lock(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		c->dirty_size += c->sector_size;
 		jeb->dirty_size = c->sector_size;
@@ -87,8 +86,7 @@ static void jffs2_erase_block(struct jff
 		/* Erase failed immediately. Refile it on the list */
 		D1(printk(KERN_DEBUG "Erase at 0x%08x failed: %d. Refiling on erase_pending_list\n", jeb->offset, ret));
 		spin_lock(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		c->dirty_size += c->sector_size;
 		jeb->dirty_size = c->sector_size;
@@ -162,8 +160,7 @@ static void jffs2_erase_succeeded(struct
 {
 	D1(printk(KERN_DEBUG "Erase completed successfully at 0x%08x\n", jeb->offset));
 	spin_lock(&c->erase_completion_lock);
-	list_del(&jeb->list);
-	list_add_tail(&jeb->list, &c->erase_complete_list);
+	list_move_tail(&jeb->list, &c->erase_complete_list);
 	spin_unlock(&c->erase_completion_lock);
 	/* Ensure that kupdated calls us again to mark them clean */
 	jffs2_erase_pending_trigger(c);
@@ -179,8 +176,7 @@ static void jffs2_erase_failed(struct jf
 		if (!jffs2_write_nand_badblock(c, jeb, bad_offset)) {
 			/* We'd like to give this block another try. */
 			spin_lock(&c->erase_completion_lock);
-			list_del(&jeb->list);
-			list_add(&jeb->list, &c->erase_pending_list);
+			list_move(&jeb->list, &c->erase_pending_list);
 			c->erasing_size -= c->sector_size;
 			c->dirty_size += c->sector_size;
 			jeb->dirty_size = c->sector_size;
@@ -192,8 +188,7 @@ static void jffs2_erase_failed(struct jf
 	spin_lock(&c->erase_completion_lock);
 	c->erasing_size -= c->sector_size;
 	c->bad_size += c->sector_size;
-	list_del(&jeb->list);
-	list_add(&jeb->list, &c->bad_list);
+	list_move(&jeb->list, &c->bad_list);
 	c->nr_erasing_blocks--;
 	spin_unlock(&c->erase_completion_lock);
 	wake_up(&c->erase_wait);
Index: 2.6-git/fs/jffs2/nodemgmt.c
===================================================================
--- 2.6-git.orig/fs/jffs2/nodemgmt.c
+++ 2.6-git/fs/jffs2/nodemgmt.c
@@ -207,8 +207,7 @@ static int jffs2_find_nextblock(struct j
 			struct jffs2_eraseblock *ejeb;
 
 			ejeb = list_entry(c->erasable_list.next, struct jffs2_eraseblock, list);
-			list_del(&ejeb->list);
-			list_add_tail(&ejeb->list, &c->erase_pending_list);
+			list_move_tail(&ejeb->list, &c->erase_pending_list);
 			c->nr_erasing_blocks++;
 			jffs2_erase_pending_trigger(c);
 			D1(printk(KERN_DEBUG "jffs2_find_nextblock: Triggering erase of erasable block at 0x%08x\n",
Index: 2.6-git/fs/jffs2/wbuf.c
===================================================================
--- 2.6-git.orig/fs/jffs2/wbuf.c
+++ 2.6-git/fs/jffs2/wbuf.c
@@ -382,8 +382,7 @@ static void jffs2_wbuf_recover(struct jf
 	if (first_raw == &jeb->first_node) {
 		jeb->last_node = NULL;
 		D1(printk(KERN_DEBUG "Failing block at %08x is now empty. Moving to erase_pending_list\n", jeb->offset));
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->nr_erasing_blocks++;
 		jffs2_erase_pending_trigger(c);
 	}
Index: 2.6-git/fs/ocfs2/dlm/dlmast.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmast.c
+++ 2.6-git/fs/ocfs2/dlm/dlmast.c
@@ -381,8 +381,7 @@ do_ast:
 	ret = DLM_NORMAL;
 	if (past->type == DLM_AST) {
 		/* do not alter lock refcount.  switching lists. */
-		list_del_init(&lock->list);
-		list_add_tail(&lock->list, &res->granted);
+		list_move_tail(&lock->list, &res->granted);
 		mlog(0, "ast: adding to granted list... type=%d, "
 			  "convert_type=%d\n", lock->ml.type, lock->ml.convert_type);
 		if (lock->ml.convert_type != LKM_IVMODE) {
Index: 2.6-git/fs/ocfs2/dlm/dlmconvert.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmconvert.c
+++ 2.6-git/fs/ocfs2/dlm/dlmconvert.c
@@ -231,8 +231,7 @@ switch_queues:
 
 	lock->ml.convert_type = type;
 	/* do not alter lock refcount.  switching lists. */
-	list_del_init(&lock->list);
-	list_add_tail(&lock->list, &res->converting);
+	list_move_tail(&lock->list, &res->converting);
 
 unlock_exit:
 	spin_unlock(&lock->spinlock);
@@ -248,8 +247,7 @@ void dlm_revert_pending_convert(struct d
 				struct dlm_lock *lock)
 {
 	/* do not alter lock refcount.  switching lists. */
-	list_del_init(&lock->list);
-	list_add_tail(&lock->list, &res->granted);
+	list_move_tail(&lock->list, &res->granted);
 	lock->ml.convert_type = LKM_IVMODE;
 	lock->lksb->flags &= ~(DLM_LKSB_GET_LVB|DLM_LKSB_PUT_LVB);
 }
@@ -294,8 +292,7 @@ enum dlm_status dlmconvert_remote(struct
 	res->state |= DLM_LOCK_RES_IN_PROGRESS;
 	/* move lock to local convert queue */
 	/* do not alter lock refcount.  switching lists. */
-	list_del_init(&lock->list);
-	list_add_tail(&lock->list, &res->converting);
+	list_move_tail(&lock->list, &res->converting);
 	lock->convert_pending = 1;
 	lock->ml.convert_type = type;
 
Index: 2.6-git/fs/ocfs2/dlm/dlmlock.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmlock.c
+++ 2.6-git/fs/ocfs2/dlm/dlmlock.c
@@ -239,8 +239,7 @@ static enum dlm_status dlmlock_remote(st
 		mlog(0, "%s: $RECOVERY lock for this node (%u) is "
 		     "mastered by %u; got lock, manually granting (no ast)\n",
 		     dlm->name, dlm->node_num, res->owner);
-		list_del_init(&lock->list);
-		list_add_tail(&lock->list, &res->granted);
+		list_move_tail(&lock->list, &res->granted);
 	}
 	spin_unlock(&res->spinlock);
 
Index: 2.6-git/fs/ocfs2/dlm/dlmrecovery.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmrecovery.c
+++ 2.6-git/fs/ocfs2/dlm/dlmrecovery.c
@@ -905,13 +905,11 @@ static void dlm_move_reco_locks_to_list(
 			mlog(0, "found lockres owned by dead node while "
 				  "doing recovery for node %u. sending it.\n",
 				  dead_node);
-			list_del_init(&res->recovering);
-			list_add_tail(&res->recovering, list);
+			list_move_tail(&res->recovering, list);
 		} else if (res->owner == DLM_LOCK_RES_OWNER_UNKNOWN) {
 			mlog(0, "found UNKNOWN owner while doing recovery "
 				  "for node %u. sending it.\n", dead_node);
-			list_del_init(&res->recovering);
-			list_add_tail(&res->recovering, list);
+			list_move_tail(&res->recovering, list);
 		}
 	}
 	spin_unlock(&dlm->spinlock);
@@ -1529,8 +1527,7 @@ static int dlm_process_recovery_data(str
 
 			/* move the lock to its proper place */
 			/* do not alter lock refcount.  switching lists. */
-			list_del_init(&lock->list);
-			list_add_tail(&lock->list, queue);
+			list_move_tail(&lock->list, queue);
 			spin_unlock(&res->spinlock);
 
 			mlog(0, "just reordered a local lock!\n");
Index: 2.6-git/fs/ocfs2/dlm/dlmthread.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmthread.c
+++ 2.6-git/fs/ocfs2/dlm/dlmthread.c
@@ -318,8 +318,7 @@ converting:
 
 		target->ml.type = target->ml.convert_type;
 		target->ml.convert_type = LKM_IVMODE;
-		list_del_init(&target->list);
-		list_add_tail(&target->list, &res->granted);
+		list_move_tail(&target->list, &res->granted);
 
 		BUG_ON(!target->lksb);
 		target->lksb->status = DLM_NORMAL;
@@ -380,8 +379,7 @@ blocked:
 		     target->ml.type, target->ml.node);
 
 		// target->ml.type is already correct
-		list_del_init(&target->list);
-		list_add_tail(&target->list, &res->granted);
+		list_move_tail(&target->list, &res->granted);
 
 		BUG_ON(!target->lksb);
 		target->lksb->status = DLM_NORMAL;
Index: 2.6-git/fs/ocfs2/dlm/dlmunlock.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/dlm/dlmunlock.c
+++ 2.6-git/fs/ocfs2/dlm/dlmunlock.c
@@ -271,8 +271,7 @@ void dlm_commit_pending_unlock(struct dl
 void dlm_commit_pending_cancel(struct dlm_lock_resource *res,
 			       struct dlm_lock *lock)
 {
-	list_del_init(&lock->list);
-	list_add_tail(&lock->list, &res->granted);
+	list_move_tail(&lock->list, &res->granted);
 	lock->ml.convert_type = LKM_IVMODE;
 }
 
Index: 2.6-git/fs/ocfs2/journal.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/journal.c
+++ 2.6-git/fs/ocfs2/journal.c
@@ -222,8 +222,7 @@ void ocfs2_handle_add_inode(struct ocfs2
 	BUG_ON(!list_empty(&OCFS2_I(inode)->ip_handle_list));
 
 	OCFS2_I(inode)->ip_handle = handle;
-	list_del(&(OCFS2_I(inode)->ip_handle_list));
-	list_add_tail(&(OCFS2_I(inode)->ip_handle_list), &(handle->inode_list));
+	list_move_tail(&(OCFS2_I(inode)->ip_handle_list), &(handle->inode_list));
 }
 
 static void ocfs2_handle_unlock_inodes(struct ocfs2_journal_handle *handle)

--
