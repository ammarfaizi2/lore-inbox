Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUGCRk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUGCRk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUGCRk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 13:40:28 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:33159 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265161AbUGCRkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 13:40:21 -0400
Message-ID: <40E6EF6F.6040006@colorfullife.com>
Date: Sat, 03 Jul 2004 19:39:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ipc 2/3: remove sem_revalidate
Content-Type: multipart/mixed;
 boundary="------------090500050506020809040506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500050506020809040506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch removes sem_revalidate and replaces it with 
ipc_rcu_getref() calls followed by ipc_lock_by_ptr(). It depends on the 
previous patch that added ipc_rcu_getref(0.

Andrew - what do you think?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------090500050506020809040506
Content-Type: text/plain;
 name="patch-ipc-02-remove_revalidate"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-02-remove_revalidate"

--- 2.6/ipc/sem.c	2004-07-03 19:06:45.216518200 +0200
+++ build-2.6/ipc/sem.c	2004-07-03 19:03:08.732428784 +0200
@@ -241,25 +241,6 @@
 	return err;
 }
 
-/* doesn't acquire the sem_lock on error! */
-static int sem_revalidate(int semid, struct sem_array* sma, int nsems, short flg)
-{
-	struct sem_array* smanew;
-
-	smanew = sem_lock(semid);
-	if(smanew==NULL)
-		return -EIDRM;
-	if(smanew != sma || sem_checkid(sma,semid) || sma->sem_nsems != nsems) {
-		sem_unlock(smanew);
-		return -EIDRM;
-	}
-
-	if (flg && ipcperms(&sma->sem_perm, flg)) {
-		sem_unlock(smanew);
-		return -EACCES;
-	}
-	return 0;
-}
 /* Manage the doubly linked list sma->sem_pending as a FIFO:
  * insert new queue elements at the tail sma->sem_pending_last.
  */
@@ -614,13 +595,24 @@
 		int i;
 
 		if(nsems > SEMMSL_FAST) {
+			ipc_rcu_getref(sma);
 			sem_unlock(sma);			
+
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
-			if(sem_io == NULL)
+			if(sem_io == NULL) {
+				ipc_lock_by_ptr(&sma->sem_perm);
+				ipc_rcu_putref(sma);
+				sem_unlock(sma);
 				return -ENOMEM;
-			err = sem_revalidate(semid, sma, nsems, S_IRUGO);
-			if(err)
+			}
+
+			ipc_lock_by_ptr(&sma->sem_perm);
+			ipc_rcu_putref(sma);
+			if (sma->sem_perm.deleted) {
+				sem_unlock(sma);
+				err = -EIDRM;
 				goto out_free;
+			}
 		}
 
 		for (i = 0; i < sma->sem_nsems; i++)
@@ -636,28 +628,43 @@
 		int i;
 		struct sem_undo *un;
 
+		ipc_rcu_getref(sma);
 		sem_unlock(sma);
 
 		if(nsems > SEMMSL_FAST) {
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
-			if(sem_io == NULL)
+			if(sem_io == NULL) {
+				ipc_lock_by_ptr(&sma->sem_perm);
+				ipc_rcu_putref(sma);
+				sem_unlock(sma);
 				return -ENOMEM;
+			}
 		}
 
 		if (copy_from_user (sem_io, arg.array, nsems*sizeof(ushort))) {
+			ipc_lock_by_ptr(&sma->sem_perm);
+			ipc_rcu_putref(sma);
+			sem_unlock(sma);
 			err = -EFAULT;
 			goto out_free;
 		}
 
 		for (i = 0; i < nsems; i++) {
 			if (sem_io[i] > SEMVMX) {
+				ipc_lock_by_ptr(&sma->sem_perm);
+				ipc_rcu_putref(sma);
+				sem_unlock(sma);
 				err = -ERANGE;
 				goto out_free;
 			}
 		}
-		err = sem_revalidate(semid, sma, nsems, S_IWUGO);
-		if(err)
+		ipc_lock_by_ptr(&sma->sem_perm);
+		ipc_rcu_putref(sma);
+		if (sma->sem_perm.deleted) {
+			sem_unlock(sma);
+			err = -EIDRM;
 			goto out_free;
+		}
 
 		for (i = 0; i < nsems; i++)
 			sma->sem_base[i].semval = sem_io[i];
@@ -977,11 +984,16 @@
 		goto out;
 	}
 	nsems = sma->sem_nsems;
+	ipc_rcu_getref(sma);
 	sem_unlock(sma);
 
 	new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
-	if (!new)
+	if (!new) {
+		ipc_lock_by_ptr(&sma->sem_perm);
+		ipc_rcu_putref(sma);
+		sem_unlock(sma);
 		return ERR_PTR(-ENOMEM);
+	}
 	memset(new, 0, sizeof(struct sem_undo) + sizeof(short)*nsems);
 	new->semadj = (short *) &new[1];
 	new->semid = semid;
@@ -991,13 +1003,18 @@
 	if (un) {
 		unlock_semundo();
 		kfree(new);
+		ipc_lock_by_ptr(&sma->sem_perm);
+		ipc_rcu_putref(sma);
+		sem_unlock(sma);
 		goto out;
 	}
-	error = sem_revalidate(semid, sma, nsems, 0);
-	if (error) {
+	ipc_lock_by_ptr(&sma->sem_perm);
+	ipc_rcu_putref(sma);
+	if (sma->sem_perm.deleted) {
+		sem_unlock(sma);
 		unlock_semundo();
 		kfree(new);
-		un = ERR_PTR(error);
+		un = ERR_PTR(-EIDRM);
 		goto out;
 	}
 	new->proc_next = ulp->proc_list;

--------------090500050506020809040506--
