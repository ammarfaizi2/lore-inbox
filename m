Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVKPI6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVKPI6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVKPI6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:58:15 -0500
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:32700 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030244AbVKPI6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:58:13 -0500
Message-ID: <437AF4A2.6060206@namesys.com>
Date: Wed, 16 Nov 2005 00:58:10 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vs <vs@thebsh.namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 7/8] reiser4-try_capture_block-update.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050704000108040606010708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704000108040606010708
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------050704000108040606010708
Content-Type: message/rfc822;
 name="[PATCH 7/8] reiser4-try_capture_block-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 7/8] reiser4-try_capture_block-update.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24472 invoked from network); 15 Nov 2005 17:00:16 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:16 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id 52C6871D999; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 7/8] reiser4-try_capture_block-update.patch
Message-ID: <437A1402.mail7JU111ZHQ@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="DXX40QE201-=-1R43H1FBZC-CUT-HERE-AQLXT1P5CT-=-W6SU9EORCA"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--DXX40QE201-=-1R43H1FBZC-CUT-HERE-AQLXT1P5CT-=-W6SU9EORCA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--DXX40QE201-=-1R43H1FBZC-CUT-HERE-AQLXT1P5CT-=-W6SU9EORCA
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-try_capture_block-update.patch"


From: Alex Zarochentsev <zam@namesys.com>

try_capture_block:
	avoid holding more than two spinlocks at a time.
	avoid to capture at read requests if
		the node wasn't captured before
wake_up_all_lopri_owners: 
	don't wake the same thread up twice
Cleanup.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/lock.c   |    5 
 fs/reiser4/tree.c   |    7 
 fs/reiser4/txnmgr.c |  630 ++++++++++------------------------------------------
 3 files changed, 126 insertions(+), 516 deletions(-)

diff -puN fs/reiser4/lock.c~reiser4-try_capture_block-update fs/reiser4/lock.c
--- linux-2.6.14-mm2/fs/reiser4/lock.c~reiser4-try_capture_block-update	2005-11-15 17:19:58.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/lock.c	2005-11-15 17:19:59.000000000 +0300
@@ -252,10 +252,9 @@ static void wake_up_all_lopri_owners(zno
 		if (!handle->signaled) {
 			handle->signaled = 1;
 			atomic_inc(&handle->owner->nr_signaled);
+			/* Wake up a single process */
+			__reiser4_wake_up(handle->owner);
 		}
-		/* Wake up a single process */
-		__reiser4_wake_up(handle->owner);
-
 		spin_unlock_stack(handle->owner);
 	}
 }
diff -puN fs/reiser4/tree.c~reiser4-try_capture_block-update fs/reiser4/tree.c
--- linux-2.6.14-mm2/fs/reiser4/tree.c~reiser4-try_capture_block-update	2005-11-15 17:19:58.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/tree.c	2005-11-15 17:19:59.000000000 +0300
@@ -792,13 +792,8 @@ void forget_znode(lock_handle * handle)
 	 * invalidation does not allow other threads to waste cpu time is a busy
 	 * loop, trying to lock dying object.  The exception is in the flush
 	 * code when we take node directly from atom's capture list.*/
-
-	write_unlock_zlock(&node->lock);
-	/* and, remove from atom's capture list. */
-	uncapture_znode(node);
-	write_lock_zlock(&node->lock);
-
 	invalidate_lock(handle);
+	uncapture_znode(node);
 }
 
 /* Check that internal item at @pointer really contains pointer to @child. */
diff -puN fs/reiser4/txnmgr.c~reiser4-try_capture_block-update fs/reiser4/txnmgr.c
--- linux-2.6.14-mm2/fs/reiser4/txnmgr.c~reiser4-try_capture_block-update	2005-11-15 17:19:58.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/txnmgr.c	2005-11-15 17:19:59.000000000 +0300
@@ -253,24 +253,15 @@ static void capture_assign_txnh_nolock(t
 
 static void capture_assign_block_nolock(txn_atom * atom, jnode * node);
 
-static int capture_assign_block(txn_handle * txnh, jnode * node);
-
-static int capture_assign_txnh(jnode * node, txn_handle * txnh,
-			       txn_capture mode, int can_coc);
-
 static void fuse_not_fused_lock_owners(txn_handle * txnh, znode * node);
 
 static int capture_init_fusion(jnode * node, txn_handle * txnh,
 			       txn_capture mode, int can_coc);
 
-static int capture_fuse_wait(jnode * node, txn_handle * txnh, txn_atom * atomf,
-			     txn_atom * atomh, txn_capture mode);
+static int capture_fuse_wait(txn_handle *, txn_atom *, txn_atom *, txn_capture);
 
 static void capture_fuse_into(txn_atom * small, txn_atom * large);
 
-static int capture_copy(jnode * node, txn_handle * txnh, txn_atom * atomf,
-			txn_atom * atomh, txn_capture mode, int can_coc);
-
 void invalidate_list(struct list_head *);
 
 /* GENERIC STRUCTURES */
@@ -1865,158 +1856,99 @@ static int commit_txnh(txn_handle * txnh
    released.  The external interface (try_capture) manages re-aquiring the jnode lock
    in the failure case.
 */
-static int
-try_capture_block(txn_handle * txnh, jnode * node, txn_capture mode,
-		  txn_atom ** atom_alloc, int can_coc)
+static int try_capture_block(
+	txn_handle * txnh, jnode * node, txn_capture mode,
+	txn_atom ** atom_alloc)
 {
-	int ret;
 	txn_atom *block_atom;
 	txn_atom *txnh_atom;
 
 	/* Should not call capture for READ_NONCOM requests, handled in try_capture. */
 	assert("jmacd-567", CAPTURE_TYPE(mode) != TXN_CAPTURE_READ_NONCOM);
 
-	/* FIXME-ZAM-HANS: FIXME_LATER_JMACD Should assert that atom->tree == node->tree somewhere. */
-
+	/* FIXME-ZAM-HANS: FIXME_LATER_JMACD Should assert that atom->tree ==
+	 * node->tree somewhere. */
 	assert("umka-194", txnh != NULL);
 	assert("umka-195", node != NULL);
 
 	/* The jnode is already locked!  Being called from try_capture(). */
 	assert_spin_locked(&(node->guard));
-
 	block_atom = node->atom;
 
 	/* Get txnh spinlock, this allows us to compare txn_atom pointers but it doesn't
 	   let us touch the atoms themselves. */
 	spin_lock_txnh(txnh);
-
 	txnh_atom = txnh->atom;
 
-	if (txnh_atom != NULL && block_atom == txnh_atom) {
-		spin_unlock_txnh(txnh);
-		return 0;
-	}
-	/* NIKITA-HANS: nothing */
-	if (txnh_atom != NULL) {
-		/* It is time to perform deadlock prevention check over the
-		   node we want to capture.  It is possible this node was
-		   locked for read without capturing it. The optimization
-		   which allows to do it helps us in keeping atoms independent
-		   as long as possible but it may cause lock/fuse deadlock
-		   problems.
-
-		   A number of similar deadlock situations with locked but not
-		   captured nodes were found.  In each situation there are two
-		   or more threads: one of them does flushing while another
-		   one does routine balancing or tree lookup.  The flushing
-		   thread (F) sleeps in long term locking request for node
-		   (N), another thread (A) sleeps in trying to capture some
-		   node already belonging the atom F, F has a state which
-		   prevents immediately fusion .
-
-		   Deadlocks of this kind cannot happen if node N was properly
-		   captured by thread A. The F thread fuse atoms before
-		   locking therefore current atom of thread F and current atom
-		   of thread A became the same atom and thread A may proceed.
-		   This does not work if node N was not captured because the
-		   fusion of atom does not happens.
-
-		   The following scheme solves the deadlock: If
-		   longterm_lock_znode locks and does not capture a znode,
-		   that znode is marked as MISSED_IN_CAPTURE.  A node marked
-		   this way is processed by the code below which restores the
-		   missed capture and fuses current atoms of all the node lock
-		   owners by calling the fuse_not_fused_lock_owners()
-		   function.
-		 */
-
-		if (		// txnh_atom->stage >= ASTAGE_CAPTURE_WAIT &&
-			   jnode_is_znode(node) && znode_is_locked(JZNODE(node))
-			   && JF_ISSET(node, JNODE_MISSED_IN_CAPTURE)) {
+	if (txnh_atom == NULL) {
+		if (block_atom == NULL) {
 			spin_unlock_txnh(txnh);
-			JF_CLR(node, JNODE_MISSED_IN_CAPTURE);
 			spin_unlock_jnode(node);
-			fuse_not_fused_lock_owners(txnh, JZNODE(node));
+			return atom_begin_and_assign_to_txnh(atom_alloc, txnh);
+		} else {
+			atomic_inc(&block_atom->refcount);
+			spin_unlock_jnode(node);
+			if (!spin_trylock_atom(block_atom)) {
+				spin_unlock_txnh(txnh);
+				spin_lock_atom(block_atom);
+				spin_lock_txnh(txnh);
+			}
+			if (node->atom != block_atom || txnh->atom != NULL) {
+				spin_unlock_txnh(txnh);
+				atom_dec_and_unlock(block_atom);
+				return RETERR(-E_REPEAT);
+			}
+			atomic_dec(&block_atom->refcount);
+			if (block_atom->stage > ASTAGE_CAPTURE_WAIT ||
+			    (block_atom->stage == ASTAGE_CAPTURE_WAIT &&
+			     block_atom->txnh_count != 0))
+				return capture_fuse_wait(txnh, block_atom, NULL, mode);
+			capture_assign_txnh_nolock(block_atom, txnh);
+			spin_unlock_txnh(txnh);
+			spin_unlock_atom(block_atom);
 			return RETERR(-E_REPEAT);
 		}
-	}
-
-	if (block_atom != NULL) {
-		/* The block has already been assigned to an atom. */
-
-		/* case (block_atom == txnh_atom) is already handled above */
-		if (txnh_atom == NULL) {
-
-			/* The txnh is unassigned, try to assign it. */
-			ret = capture_assign_txnh(node, txnh, mode, can_coc);
-			if (ret != 0) {
-				/* E_REPEAT or otherwise */
-				assert_spin_not_locked(&(txnh->hlock));
-				assert_spin_not_locked(&(node->guard));
-				return ret;
-			}
-
-			/* Either the txnh is now assigned to the block's atom or the read-request was
-			   granted because the block is committing.  Locks still held. */
-		} else {
-			if (mode & TXN_CAPTURE_DONT_FUSE) {
+	} else {
+		if (JF_ISSET(node, JNODE_MISSED_IN_CAPTURE)) {
+			JF_CLR(node, JNODE_MISSED_IN_CAPTURE);
+			if (jnode_is_znode(node) && znode_is_locked(JZNODE(node))) {
 				spin_unlock_txnh(txnh);
 				spin_unlock_jnode(node);
-				/* we are in a "no-fusion" mode and @node is
-				 * already part of transaction. */
-				return RETERR(-E_NO_NEIGHBOR);
-			}
-			/* In this case, both txnh and node belong to different atoms.  This function
-			   returns -E_REPEAT on successful fusion, 0 on the fall-through case. */
-			ret = capture_init_fusion(node, txnh, mode, can_coc);
-			if (ret != 0) {
-				assert_spin_not_locked(&(txnh->hlock));
-				assert_spin_not_locked(&(node->guard));
-				return ret;
+				fuse_not_fused_lock_owners(txnh, JZNODE(node));
+				return RETERR(-E_REPEAT);
 			}
-
-			/* The fall-through case is read request for committing block.  Locks still
-			   held. */
 		}
-
-	} else if ((mode & TXN_CAPTURE_WTYPES) != 0) {
-
-		/* In this case, the page is unlocked and the txnh wishes exclusive access. */
-
-		if (txnh_atom != NULL) {
-			/* The txnh is already assigned: add the page to its atom. */
-			ret = capture_assign_block(txnh, node);
-			if (ret != 0) {
-				/* E_REPEAT or otherwise */
-				assert_spin_not_locked(&(txnh->hlock));
-				assert_spin_not_locked(&(node->guard));
-				return ret;
+		if (block_atom == NULL) {
+			atomic_inc(&txnh_atom->refcount);
+			spin_unlock_txnh(txnh);
+			if (!spin_trylock_atom(txnh_atom)) {
+				spin_unlock_jnode(node);
+				spin_lock_atom(txnh_atom);
+				spin_lock_jnode(node);
 			}
-
-			/* Success: Locks are still held. */
-
+			if (txnh->atom != txnh_atom || node->atom != NULL
+				|| JF_ISSET(node, JNODE_IS_DYING)) {
+				spin_unlock_jnode(node);
+				atom_dec_and_unlock(txnh_atom);
+				return RETERR(-E_REPEAT);
+			}
+			atomic_dec(&txnh_atom->refcount);
+			capture_assign_block_nolock(txnh_atom, node);
+			spin_unlock_atom(txnh_atom);
 		} else {
-
-			/* In this case, neither txnh nor page are assigned to
-			 * an atom. */
-			spin_unlock_jnode(node);
+			if (txnh_atom != block_atom) {
+				if (mode & TXN_CAPTURE_DONT_FUSE) {
+					spin_unlock_txnh(txnh);
+					spin_unlock_jnode(node);
+					/* we are in a "no-fusion" mode and @node is
+					 * already part of transaction. */
+					return RETERR(-E_NO_NEIGHBOR);
+				}
+				return capture_init_fusion(node, txnh, mode, 1);
+			}
 			spin_unlock_txnh(txnh);
-			return atom_begin_and_assign_to_txnh(atom_alloc, txnh);
 		}
-
-	} else {
-		/* The jnode is uncaptured and its a read request -- fine. */
-		assert("jmacd-411",
-		       CAPTURE_TYPE(mode) == TXN_CAPTURE_READ_ATOMIC);
 	}
-
-	/* Successful case: both jnode and txnh are still locked. */
-	assert_spin_locked(&(txnh->hlock));
-	assert_spin_locked(&(node->guard));
-
-	/* Release txnh lock, return with the jnode still locked. */
-	spin_unlock_txnh(txnh);
-
 	return 0;
 }
 
@@ -2048,10 +1980,6 @@ build_capture_mode(jnode * node, znode_l
 		/* In this case (read lock at a non-leaf) there's no reason to
 		 * capture. */
 		/* cap_mode = TXN_CAPTURE_READ_NONCOM; */
-
-		/* Mark this node as "MISSED".  It helps in further deadlock
-		 * analysis */
-		JF_SET(node, JNODE_MISSED_IN_CAPTURE);
 		return 0;
 	}
 
@@ -2072,33 +2000,32 @@ build_capture_mode(jnode * node, znode_l
             cannot be processed immediately as it was requested in flags,
 	    < 0 - other errors.
 */
-int
-try_capture(jnode * node, znode_lock_mode lock_mode,
-	    txn_capture flags, int can_coc)
+int try_capture(jnode * node, znode_lock_mode lock_mode,
+		txn_capture flags, int can_coc)
 {
 	txn_atom *atom_alloc = NULL;
 	txn_capture cap_mode;
 	txn_handle *txnh = get_current_context()->trans;
-#if REISER4_COPY_ON_CAPTURE
-	int coc_enabled = 1;
-#endif
 	int ret;
 
 	assert_spin_locked(&(node->guard));
 
       repeat:
+	if (JF_ISSET(node, JNODE_IS_DYING))
+		return RETERR(-EINVAL);
+	if (node->atom != NULL && txnh->atom == node->atom)
+		return 0;
 	cap_mode = build_capture_mode(node, lock_mode, flags);
-	if (cap_mode == 0)
+	if (cap_mode == 0 ||
+	    (!(cap_mode & TXN_CAPTURE_WTYPES) && node->atom == NULL)) {
+		/* Mark this node as "MISSED".  It helps in further deadlock
+		 * analysis */
+		if (jnode_is_znode(node))
+			JF_SET(node, JNODE_MISSED_IN_CAPTURE);
 		return 0;
-
+	}
 	/* Repeat try_capture as long as -E_REPEAT is returned. */
-#if REISER4_COPY_ON_CAPTURE
-	ret = try_capture_block(txnh, node, cap_mode, &atom_alloc, can_coc
-				&& coc_enabled);
-	coc_enabled = 1;
-#else
-	ret = try_capture_block(txnh, node, cap_mode, &atom_alloc, can_coc);
-#endif
+	ret = try_capture_block(txnh, node, cap_mode, &atom_alloc);
 	/* Regardless of non_blocking:
 
 	   If ret == 0 then jnode is still locked.
@@ -2182,6 +2109,14 @@ try_capture(jnode * node, znode_lock_mod
 	return ret;
 }
 
+static void release_two_atoms(txn_atom *one, txn_atom *two)
+{
+	spin_unlock_atom(one);
+	atom_dec_and_unlock(two);
+	spin_lock_atom(one);
+	atom_dec_and_unlock(one);
+}
+
 /* This function sets up a call to try_capture_block and repeats as long as -E_REPEAT is
    returned by that routine.  The txn_capture request mode is computed here depending on
    the transaction handle's type and the lock request.  This is called from the depths of
@@ -2256,10 +2191,7 @@ static void fuse_not_fused_lock_owners(t
 			spin_lock_atom(atomh);
 		}
 		if (atomh == atomf || !atom_isopen(atomh) || !atom_isopen(atomf)) {
-			spin_unlock_atom(atomf);
-			atom_dec_and_unlock(atomh);
-			spin_lock_atom(atomf);
-			atom_dec_and_unlock(atomf);
+			release_two_atoms(atomf, atomh);
 			goto repeat;
 		}
 		atomic_dec(&atomh->refcount);
@@ -2843,221 +2775,6 @@ void unformatted_make_reloc(jnode * node
 	mark_jnode_queued(fq, node);
 }
 
-static int trylock_wait(txn_atom * atom, txn_handle * txnh, jnode * node)
-{
-	if (unlikely(!spin_trylock_atom(atom))) {
-		atomic_inc(&atom->refcount);
-
-		spin_unlock_jnode(node);
-		spin_unlock_txnh(txnh);
-
-		spin_lock_atom(atom);
-		/* caller should eliminate extra reference by calling
-		 * atom_dec_and_unlock() for this atom. */
-		return 1;
-	} else
-		return 0;
-}
-
-/*
- * in transaction manager jnode spin lock and transaction handle spin lock
- * nest within atom spin lock. During capturing we are in a situation when
- * jnode and transaction handle spin locks are held and we want to manipulate
- * atom's data (capture lists, and txnh list) to add node and/or handle to the
- * atom. Releasing jnode (or txnh) spin lock at this point is unsafe, because
- * concurrent fusion can render assumption made by capture so far (about
- * ->atom pointers in jnode and txnh) invalid. Initial code used try-lock and
- * if atom was busy returned -E_REPEAT to the top level. This can lead to the
- * busy loop if atom is locked for long enough time. Function below tries to
- * throttle this loop.
- *
- */
-/* ZAM-FIXME-HANS: how feasible would it be to use our hi-lo priority locking
-   mechanisms/code for this as well? Does that make any sense? */
-/* ANSWER(Zam): I am not sure that I understand you proposal right, but the idea
-   might be in inventing spin_lock_lopri() which should be a complex loop with
-   "release lock" messages check like we have in the znode locking.  I think we
-   should not substitute spin locks by more complex busy loops.  Once it was
-   done that way in try_capture_block() where spin lock waiting was spread in a
-   busy loop  through several functions.  The proper solution should be in
-   making spin lock contention rare. */
-static int trylock_throttle(txn_atom * atom, txn_handle * txnh, jnode * node)
-{
-	assert("nikita-3224", atom != NULL);
-	assert("nikita-3225", txnh != NULL);
-	assert("nikita-3226", node != NULL);
-
-	assert_spin_locked(&(txnh->hlock));
-	assert_spin_locked(&(node->guard));
-
-	if (unlikely(trylock_wait(atom, txnh, node) != 0)) {
-		atom_dec_and_unlock(atom);
-		return RETERR(-E_REPEAT);
-	} else
-		return 0;
-}
-
-/* This function assigns a block to an atom, but first it must obtain the atom lock.  If
-   the atom lock is busy, it returns -E_REPEAT to avoid deadlock with a fusing atom.  Since
-   the transaction handle is currently open, we know the atom must also be open. */
-static int capture_assign_block(txn_handle * txnh, jnode * node)
-{
-	txn_atom *atom;
-	int result;
-
-	assert("umka-206", txnh != NULL);
-	assert("umka-207", node != NULL);
-
-	atom = txnh->atom;
-
-	assert("umka-297", atom != NULL);
-
-	result = trylock_throttle(atom, txnh, node);
-	if (result != 0) {
-		/* this avoid busy loop, but we return -E_REPEAT anyway to
-		 * simplify things. */
-		return result;
-	} else {
-		assert("jmacd-19", atom_isopen(atom));
-
-		/* Add page to capture list. */
-		capture_assign_block_nolock(atom, node);
-
-		/* Success holds onto jnode & txnh locks.  Unlock atom. */
-		spin_unlock_atom(atom);
-		return 0;
-	}
-}
-
-/* This function assigns a handle to an atom, but first it must obtain the atom lock.  If
-   the atom is busy, it returns -E_REPEAT to avoid deadlock with a fusing atom.  Unlike
-   capture_assign_block, the atom may be closed but we cannot know this until the atom is
-   locked.  If the atom is closed and the request is to read, it is as if the block is
-   unmodified and the request is satisified without actually assigning the transaction
-   handle.  If the atom is closed and the handle requests to write the block, then
-   initiate copy-on-capture.
-*/
-static int
-capture_assign_txnh(jnode * node, txn_handle * txnh, txn_capture mode,
-		    int can_coc)
-{
-	txn_atom *atom;
-
-	assert("umka-208", node != NULL);
-	assert("umka-209", txnh != NULL);
-
-	atom = node->atom;
-
-	assert("umka-298", atom != NULL);
-
-	/*
-	 * optimization: this code went through three evolution stages. Main
-	 * driving force of evolution here is lock ordering:
-	 *
-	 * at the entry to this function following pre-conditions are met:
-	 *
-	 *     1. txnh and node are both spin locked,
-	 *
-	 *     2. node belongs to atom, and
-	 *
-	 *     3. txnh don't.
-	 *
-	 * What we want to do here is to acquire spin lock on node's atom and
-	 * modify it somehow depending on its ->stage. In the simplest case,
-	 * where ->stage is ASTAGE_CAPTURE_FUSE, txnh should be added to
-	 * atom's list. Problem is that atom spin lock nests outside of jnode
-	 * and transaction handle ones. So, we cannot just spin_lock_atom here.
-	 *
-	 * Solutions tried here:
-	 *
-	 *     1. spin_trylock(atom), return -E_REPEAT on failure.
-	 *
-	 *     2. spin_trylock(atom). On failure to acquire lock, increment
-	 *     atom->refcount, release all locks, and spin on atom lock. Then
-	 *     decrement ->refcount, unlock atom and return -E_REPEAT.
-	 *
-	 *     3. like previous one, but before unlocking atom, re-acquire
-	 *     spin locks on node and txnh and re-check whether function
-	 *     pre-condition are still met. Continue boldly if they are.
-	 *
-	 */
-	if (trylock_wait(atom, txnh, node) != 0) {
-		spin_lock_jnode(node);
-		spin_lock_txnh(txnh);
-		/* NOTE-NIKITA is it at all possible that current txnh
-		 * spontaneously changes ->atom from NULL to non-NULL? */
-		if (node->atom == NULL ||
-		    txnh->atom != NULL || atom != node->atom) {
-			/* something changed. Caller have to re-decide */
-			spin_unlock_txnh(txnh);
-			spin_unlock_jnode(node);
-			atom_dec_and_unlock(atom);
-			return RETERR(-E_REPEAT);
-		} else {
-			/* atom still has a jnode on its list (node->atom ==
-			 * atom), it means atom is not fused or finished
-			 * (committed), we can safely decrement its refcount
-			 * because it is not a last reference. */
-			atomic_dec(&atom->refcount);
-			assert("zam-990", atomic_read(&atom->refcount) > 0);
-		}
-	}
-
-	if (atom->stage == ASTAGE_CAPTURE_WAIT &&
-	    (atom->txnh_count != 0 ||
-	     atom_should_commit(atom) || atom_should_commit_asap(atom))) {
-		/* We don't fuse with the atom in ASTAGE_CAPTURE_WAIT only if
-		 * there is open transaction handler.  It makes sense: those
-		 * atoms should not wait ktxnmgrd to flush and commit them.
-		 * And, it solves deadlocks with loop back devices (reiser4 over
-		 * loopback over reiser4), when ktxnmrgd is busy committing one
-		 * atom (above the loop back device) and can't flush an atom
-		 * below the loopback. */
-
-		/* The atom could be blocking requests--this is the first chance we've had
-		   to test it.  Since this txnh is not yet assigned, the fuse_wait logic
-		   is not to avoid deadlock, its just waiting.  Releases all three locks
-		   and returns E_REPEAT. */
-
-		return capture_fuse_wait(node, txnh, atom, NULL, mode);
-
-	} else if (atom->stage > ASTAGE_CAPTURE_WAIT) {
-
-		/* The block is involved with a committing atom. */
-		if (CAPTURE_TYPE(mode) == TXN_CAPTURE_READ_ATOMIC) {
-
-			/* A read request for a committing block can be satisfied w/o
-			   COPY-ON-CAPTURE. */
-
-			/* Success holds onto the jnode & txnh lock.  Continue to unlock
-			   atom below. */
-
-		} else {
-
-			/* Perform COPY-ON-CAPTURE.  Copy and try again.  This function
-			   releases all three locks. */
-			return capture_copy(node, txnh, atom, NULL, mode,
-					    can_coc);
-		}
-
-	} else {
-
-		assert("jmacd-160", atom->stage == ASTAGE_CAPTURE_FUSE ||
-		       (atom->stage == ASTAGE_CAPTURE_WAIT
-			&& atom->txnh_count == 0));
-
-		/* Add txnh to active list. */
-		capture_assign_txnh_nolock(atom, txnh);
-
-		/* Success holds onto the jnode & txnh lock.  Continue to unlock atom
-		   below. */
-	}
-
-	/* Unlock the atom */
-	spin_unlock_atom(atom);
-	return 0;
-}
-
 int capture_super_block(struct super_block *s)
 {
 	int result;
@@ -3142,20 +2859,15 @@ static int wait_for_fusion(txn_atom * at
    Lock ordering in this method: all four locks are held: JNODE_LOCK, TXNH_LOCK,
    BOTH_ATOM_LOCKS.  Result: all four locks are released.
 */
-static int
-capture_fuse_wait(jnode * node, txn_handle * txnh, txn_atom * atomf,
-		  txn_atom * atomh, txn_capture mode)
+static int capture_fuse_wait(txn_handle * txnh, txn_atom * atomf,
+		    txn_atom * atomh, txn_capture mode)
 {
 	int ret;
 	txn_wait_links wlinks;
 
-	assert("umka-212", node != NULL);
 	assert("umka-213", txnh != NULL);
 	assert("umka-214", atomf != NULL);
 
-	/* We do not need the node lock. */
-	spin_unlock_jnode(node);
-
 	if ((mode & TXN_CAPTURE_NONBLOCKING) != 0) {
 		spin_unlock_txnh(txnh);
 		spin_unlock_atom(atomf);
@@ -3204,84 +2916,24 @@ capture_fuse_wait(jnode * node, txn_hand
 		list_del(&wlinks._fwaiting_link);
 		atom_dec_and_unlock(atomh);
 	}
-#if REISER4_DEBUG
-	if (ret)
-		assert_spin_not_locked(&(node->guard));
-#endif
 	return ret;
 }
 
-static inline int
-capture_init_fusion_locked(jnode * node, txn_handle * txnh, txn_capture mode,
-			   int can_coc)
-{
-	txn_atom *atomf;
-	txn_atom *atomh;
-
-	assert("umka-216", txnh != NULL);
-	assert("umka-217", node != NULL);
-
-	atomh = txnh->atom;
-	atomf = node->atom;
-
-	/* The txnh atom must still be open (since the txnh is active)...  the node atom may
-	   be in some later stage (checked next). */
-	assert("jmacd-20", atom_isopen(atomh));
-
-	/* If the node atom is in the FUSE_WAIT state then we should wait, except to
-	   avoid deadlock we still must fuse if the txnh atom is also in FUSE_WAIT. */
-	if (atomf->stage == ASTAGE_CAPTURE_WAIT &&
-	    atomh->stage != ASTAGE_CAPTURE_WAIT &&
-	    (atomf->txnh_count != 0 ||
-	     atom_should_commit(atomf) || atom_should_commit_asap(atomf))) {
-		/* see comment in capture_assign_txnh() about the
-		 * "atomf->txnh_count != 0" condition. */
-		/* This unlocks all four locks and returns E_REPEAT. */
-		return capture_fuse_wait(node, txnh, atomf, atomh, mode);
-
-	} else if (atomf->stage > ASTAGE_CAPTURE_WAIT) {
-
-		/* The block is involved with a comitting atom. */
-		if (CAPTURE_TYPE(mode) == TXN_CAPTURE_READ_ATOMIC) {
-			/* A read request for a committing block can be satisfied w/o
-			   COPY-ON-CAPTURE.  Success holds onto the jnode & txnh
-			   locks. */
-			spin_unlock_atom(atomf);
-			spin_unlock_atom(atomh);
-			return 0;
-		} else {
-			/* Perform COPY-ON-CAPTURE.  Copy and try again.  This function
-			   releases all four locks. */
-			return capture_copy(node, txnh, atomf, atomh, mode,
-					    can_coc);
-		}
-	}
-
-	/* Because atomf's stage <= CAPTURE_WAIT */
-	assert("jmacd-175", atom_isopen(atomf));
-
-	/* If we got here its either because the atomh is in CAPTURE_WAIT or because the
-	   atomf is not in CAPTURE_WAIT. */
-	assert("jmacd-176",
-	       (atomh->stage == ASTAGE_CAPTURE_WAIT
-		|| atomf->stage != ASTAGE_CAPTURE_WAIT)
-	       || atomf->txnh_count == 0);
-
-	/* Now release the txnh lock: only holding the atoms at this point. */
-	spin_unlock_txnh(txnh);
-	spin_unlock_jnode(node);
+static void lock_two_atoms(txn_atom * one, txn_atom * two)
+{
+	assert("zam-1067", one != two);
 
-	/* Decide which should be kept and which should be merged. */
-	if (atom_pointer_count(atomf) < atom_pointer_count(atomh)) {
-		capture_fuse_into(atomf, atomh);
+	/* lock the atom with lesser address first */
+	if (one < two) {
+		spin_lock_atom(one);
+		spin_lock_atom(two);
 	} else {
-		capture_fuse_into(atomh, atomf);
+		spin_lock_atom(two);
+		spin_lock_atom(one);
 	}
-
-	/* Atoms are unlocked in capture_fuse_into.  No locks held. */
-	return RETERR(-E_REPEAT);
 }
 
+
 /* Perform the necessary work to prepare for fusing two atoms, which involves
  * acquiring two atom locks in the proper order.  If one of the node's atom is
  * blocking fusion (i.e., it is in the CAPTURE_WAIT stage) and the handle's
@@ -3294,19 +2946,34 @@ static int
 capture_init_fusion(jnode * node, txn_handle * txnh, txn_capture mode,
 		    int can_coc)
 {
-	/* Have to perform two trylocks here. */
-	if (likely(spin_trylock_atom(node->atom))) {
-		if (likely(spin_trylock_atom(txnh->atom)))
-			return capture_init_fusion_locked(node, txnh, mode,
-							  can_coc);
-		else {
-			spin_unlock_atom(node->atom);
-		}
-	}
+	txn_atom * txnh_atom = txnh->atom;
+	txn_atom * block_atom = node->atom;
+
+	atomic_inc(&txnh_atom->refcount);
+	atomic_inc(&block_atom->refcount);
 
-	spin_unlock_jnode(node);
 	spin_unlock_txnh(txnh);
-	return RETERR(-E_REPEAT);
+	spin_unlock_jnode(node);
+
+	lock_two_atoms(txnh_atom, block_atom);
+
+	if (txnh->atom != txnh_atom || node->atom != block_atom ) {
+		release_two_atoms(txnh_atom, block_atom);
+		return RETERR(-E_REPEAT);
+	}
+
+	atomic_dec(&txnh_atom->refcount);
+	atomic_dec(&block_atom->refcount);
+
+	assert ("zam-1066", atom_isopen(txnh_atom));
+		
+	if (txnh_atom->stage >= block_atom->stage ||
+	    (block_atom->stage == ASTAGE_CAPTURE_WAIT && block_atom->txnh_count == 0)) {
+		capture_fuse_into(txnh_atom, block_atom);
+		return RETERR(-E_REPEAT);
+	}
+	spin_lock_txnh(txnh);
+	return capture_fuse_wait(txnh, block_atom, txnh_atom, mode);
 }
 
 /* This function splices together two jnode lists (small and large) and sets all jnodes in
@@ -4035,57 +3702,6 @@ static int create_copy_and_replace(jnode
 }
 #endif				/* REISER4_COPY_ON_CAPTURE */
 
-/* Perform copy-on-capture of a block. */
-static int
-capture_copy(jnode * node, txn_handle * txnh, txn_atom * atomf,
-	     txn_atom * atomh, txn_capture mode, int can_coc)
-{
-#if REISER4_COPY_ON_CAPTURE
-	reiser4_stat_inc(coc.calls);
-
-	/* do not copy on capture in ent thread to avoid deadlock on coc semaphore */
-	if (can_coc && get_current_context()->entd == 0) {
-		int result;
-
-		ON_TRACE(TRACE_TXN, "capture_copy\n");
-
-		/* The txnh and its (possibly NULL) atom's locks are not needed
-		   at this point. */
-		spin_unlock_txnh(txnh);
-		if (atomh != NULL)
-			spin_unlock_atom(atomh);
-
-		/* create a copy of node, detach node from atom and attach its copy
-		   instead */
-		atomic_inc(&atomf->refcount);
-		result = create_copy_and_replace(node, atomf);
-		assert("nikita-3474", schedulable());
-		preempt_point();
-		spin_lock_atom(atomf);
-		atom_dec_and_unlock(atomf);
-		preempt_point();
-
-		if (result == 0) {
-			if (jnode_is_znode(node)) {
-				znode *z;
-
-				z = JZNODE(node);
-				z->version =
-				    znode_build_version(jnode_get_tree(node));
-			}
-			result = RETERR(-E_REPEAT);
-		}
-		return result;
-	}
-
-	reiser4_stat_inc(coc.forbidden);
-	return capture_fuse_wait(node, txnh, atomf, atomh, mode);
-#else
-	return capture_fuse_wait(node, txnh, atomf, atomh, mode);
-
-#endif
-}
-
 /* Release a block from the atom, reversing the effects of being captured,
    do not release atom's reference to jnode due to holding spin-locks.
    Currently this is only called when the atom commits.

_

--DXX40QE201-=-1R43H1FBZC-CUT-HERE-AQLXT1P5CT-=-W6SU9EORCA--



--------------050704000108040606010708--
