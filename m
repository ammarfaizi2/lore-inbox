Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUIKDot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUIKDot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 23:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUIKDos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 23:44:48 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:25321 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267415AbUIKDoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 23:44:37 -0400
Date: Fri, 10 Sep 2004 20:40:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: cmm@us.ibm.com, dipankar@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in grow_ary()
Message-ID: <20040911034025.GA8676@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040907230936.GA13387@us.ibm.com> <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain> <20040908220753.GD1240@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908220753.GD1240@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 03:07:53PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 08, 2004 at 04:39:43PM +0100, Hugh Dickins wrote:
> > Wouldn't it be a little nicer to start ipc_ids off pointing to a
> > const ipc_id_ary of size 0, to avoid the various entries == NULL
> > tests you had to add?
> 
> I like this one!!!  Will put a patch together.  Manfred's recent
> patch applied a refcount, which negates the const part, but should
> be no problem to put a size-zero structure in the struct ipc_ids.
> (Having a separately allocated structure puts me back to checking
> NULL pointers due to possibility of allocation failure.)

And here, finally, is the updated patch.  Still untested.

Thoughts?

						Thanx, Paul

Signed-off-by: paulmck@us.ibm.com

diff -urpN -X ../dontdiff linux-2.5-rap/ipc/msg.c linux-2.5-iloi/ipc/msg.c
--- linux-2.5-rap/ipc/msg.c	Tue Sep  7 10:04:36 2004
+++ linux-2.5-iloi/ipc/msg.c	Fri Sep 10 16:43:10 2004
@@ -380,7 +380,7 @@ asmlinkage long sys_msgctl (int msqid, i
 		int success_return;
 		if (!buf)
 			return -EFAULT;
-		if(cmd == MSG_STAT && msqid >= msg_ids.size)
+		if(cmd == MSG_STAT && msqid >= msg_ids.entries->size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
diff -urpN -X ../dontdiff linux-2.5-rap/ipc/sem.c linux-2.5-iloi/ipc/sem.c
--- linux-2.5-rap/ipc/sem.c	Tue Sep  7 10:04:36 2004
+++ linux-2.5-iloi/ipc/sem.c	Fri Sep 10 16:43:33 2004
@@ -523,7 +523,7 @@ static int semctl_nolock(int semid, int 
 		struct semid64_ds tbuf;
 		int id;
 
-		if(semid >= sem_ids.size)
+		if(semid >= sem_ids.entries->size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
diff -urpN -X ../dontdiff linux-2.5-rap/ipc/util.c linux-2.5-iloi/ipc/util.c
--- linux-2.5-rap/ipc/util.c	Tue Sep  7 10:04:36 2004
+++ linux-2.5-iloi/ipc/util.c	Fri Sep 10 16:36:23 2004
@@ -62,7 +62,6 @@ void __init ipc_init_ids(struct ipc_ids*
 
 	if(size > IPCMNI)
 		size = IPCMNI;
-	ids->size = size;
 	ids->in_use = 0;
 	ids->max_id = -1;
 	ids->seq = 0;
@@ -74,14 +73,17 @@ void __init ipc_init_ids(struct ipc_ids*
 		 	ids->seq_max = seq_limit;
 	}
 
-	ids->entries = ipc_rcu_alloc(sizeof(struct ipc_id)*size);
+	ids->entries = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*size +
+				     sizeof(struct ipc_id_ary));
 
 	if(ids->entries == NULL) {
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
-		ids->size = 0;
+		size = 0;
+		ids->entries = &ids->nullentry;
 	}
-	for(i=0;i<ids->size;i++)
-		ids->entries[i].p = NULL;
+	ids->entries->size = size;
+	for(i=0;i<size;i++)
+		ids->entries->p[i] = NULL;
 }
 
 /**
@@ -104,7 +106,7 @@ int ipc_findkey(struct ipc_ids* ids, key
 	 * since ipc_ids.sem is held
 	 */
 	for (id = 0; id <= max_id; id++) {
-		p = ids->entries[id].p;
+		p = ids->entries->p[id];
 		if(p==NULL)
 			continue;
 		if (key == p->key)
@@ -118,36 +120,36 @@ int ipc_findkey(struct ipc_ids* ids, key
  */
 static int grow_ary(struct ipc_ids* ids, int newsize)
 {
-	struct ipc_id* new;
-	struct ipc_id* old;
+	struct ipc_id_ary* new;
+	struct ipc_id_ary* old;
 	int i;
+	int size = ids->entries->size;
 
 	if(newsize > IPCMNI)
 		newsize = IPCMNI;
-	if(newsize <= ids->size)
+	if(newsize <= size)
 		return newsize;
 
-	new = ipc_rcu_alloc(sizeof(struct ipc_id)*newsize);
+	new = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*newsize +
+			    sizeof(struct ipc_id_ary));
 	if(new == NULL)
-		return ids->size;
-	memcpy(new, ids->entries, sizeof(struct ipc_id)*ids->size);
-	for(i=ids->size;i<newsize;i++) {
-		new[i].p = NULL;
+		return size;
+	new->size = newsize;
+	memcpy(new->p, ids->entries->p, sizeof(struct kern_ipc_perm *)*size +
+					sizeof(struct ipc_id_ary));
+	for(i=size;i<newsize;i++) {
+		new->p[i] = NULL;
 	}
 	old = ids->entries;
 
 	/*
-	 * before setting the ids->entries to the new array, there must be a
-	 * smp_wmb() to make sure the memcpyed contents of the new array are
-	 * visible before the new array becomes visible.
+	 * Use rcu_assign_pointer() to make sure the memcpyed contents
+	 * of the new array are visible before the new array becomes visible.
 	 */
-	smp_wmb();	/* prevent seeing new array uninitialized. */
-	ids->entries = new;
-	smp_wmb();	/* prevent indexing into old array based on new size. */
-	ids->size = newsize;
+	rcu_assign_pointer(ids->entries, new);
 
 	ipc_rcu_putref(old);
-	return ids->size;
+	return newsize;
 }
 
 /**
@@ -175,7 +177,7 @@ int ipc_addid(struct ipc_ids* ids, struc
 	 * ipc_ids.sem is held
 	 */
 	for (id = 0; id < size; id++) {
-		if(ids->entries[id].p == NULL)
+		if(ids->entries->p[id] == NULL)
 			goto found;
 	}
 	return -1;
@@ -195,7 +197,7 @@ found:
 	new->deleted = 0;
 	rcu_read_lock();
 	spin_lock(&new->lock);
-	ids->entries[id].p = new;
+	ids->entries->p[id] = new;
 	return id;
 }
 
@@ -216,15 +218,15 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 {
 	struct kern_ipc_perm* p;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
+	if(lid >= ids->entries->size)
 		BUG();
 
 	/* 
 	 * do not need a rcu_dereference()() here to force ordering
 	 * on Alpha, since the ipc_ids.sem is held.
 	 */	
-	p = ids->entries[lid].p;
-	ids->entries[lid].p = NULL;
+	p = ids->entries->p[lid];
+	ids->entries->p[lid] = NULL;
 	if(p==NULL)
 		BUG();
 	ids->in_use--;
@@ -234,7 +236,7 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 			lid--;
 			if(lid == -1)
 				break;
-		} while (ids->entries[lid].p == NULL);
+		} while (ids->entries->p[lid] == NULL);
 		ids->max_id = lid;
 	}
 	p->deleted = 1;
@@ -493,9 +495,9 @@ struct kern_ipc_perm* ipc_get(struct ipc
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
+	if(lid >= ids->entries->size)
 		return NULL;
-	out = ids->entries[lid].p;
+	out = ids->entries->p[lid];
 	return out;
 }
 
@@ -503,25 +505,15 @@ struct kern_ipc_perm* ipc_lock(struct ip
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	struct ipc_id* entries;
+	struct ipc_id_ary* entries;
 
 	rcu_read_lock();
-	if(lid >= ids->size) {
+	entries = rcu_dereference(ids->entries);
+	if(lid >= entries->size) {
 		rcu_read_unlock();
 		return NULL;
 	}
-
-	/* 
-	 * Note: The following two read barriers are corresponding
-	 * to the two write barriers in grow_ary(). They guarantee 
-	 * the writes are seen in the same order on the read side. 
-	 * smp_rmb() has effect on all CPUs.  rcu_dereference()
-	 * is used if there are data dependency between two reads, and 
-	 * has effect only on Alpha.
-	 */
-	smp_rmb(); /* prevent indexing old array with new size */
-	entries = rcu_dereference(ids->entries);
-	out = entries[lid].p;
+	out = entries->p[lid];
 	if(out == NULL) {
 		rcu_read_unlock();
 		return NULL;
diff -urpN -X ../dontdiff linux-2.5-rap/ipc/util.h linux-2.5-iloi/ipc/util.h
--- linux-2.5-rap/ipc/util.h	Tue Sep  7 10:04:36 2004
+++ linux-2.5-iloi/ipc/util.h	Fri Sep 10 17:52:17 2004
@@ -15,18 +15,19 @@ void sem_init (void);
 void msg_init (void);
 void shm_init (void);
 
-struct ipc_ids {
+struct ipc_id_ary {
 	int size;
+	struct kern_ipc_perm *p[0];
+};
+
+struct ipc_ids {
 	int in_use;
 	int max_id;
 	unsigned short seq;
 	unsigned short seq_max;
 	struct semaphore sem;	
-	struct ipc_id* entries;
-};
-
-struct ipc_id {
-	struct kern_ipc_perm* p;
+	struct ipc_id_ary nullentry;
+	struct ipc_id_ary* entries;
 };
 
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
