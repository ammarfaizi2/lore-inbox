Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUH1PQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUH1PQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUH1PQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:16:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62169 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266880AbUH1PPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:15:50 -0400
Date: Sat, 28 Aug 2004 17:15:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-ID: <20040828151544.GB12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828151137.GA12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does BUG -> BUG_ON conversions in ipc/ .

diffstat output:
 ipc/msg.c  |    3 +--
 ipc/sem.c  |    6 ++----
 ipc/shm.c  |   12 ++++--------
 ipc/util.c |    6 ++----
 4 files changed, 9 insertions(+), 18 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full-3.4/ipc/msg.c.old	2004-08-28 15:55:28.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/ipc/msg.c	2004-08-28 16:01:42.000000000 +0200
@@ -215,8 +215,7 @@
 		ret = -EEXIST;
 	} else {
 		msq = msg_lock(id);
-		if(msq==NULL)
-			BUG();
+		BUG_ON(msq == NULL);
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
 		else {
--- linux-2.6.9-rc1-mm1-full-3.4/ipc/sem.c.old	2004-08-28 15:55:28.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/ipc/sem.c	2004-08-28 16:02:09.000000000 +0200
@@ -222,8 +222,7 @@
 		err = -EEXIST;
 	} else {
 		sma = sem_lock(id);
-		if(sma==NULL)
-			BUG();
+		BUG_ON(sma == NULL);
 		if (nsems > sma->sem_nsems)
 			err = -EINVAL;
 		else if (ipcperms(&sma->sem_perm, semflg))
@@ -1160,8 +1159,7 @@
 
 	sma = sem_lock(semid);
 	if(sma==NULL) {
-		if(queue.prev != NULL)
-			BUG();
+		BUG_ON(queue.prev != NULL);
 		error = -EIDRM;
 		goto out_free;
 	}
--- linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c.old	2004-08-28 15:55:28.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c	2004-08-28 16:02:56.000000000 +0200
@@ -86,8 +86,7 @@
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
-	if(!(shp = shm_lock(id)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(id)));
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = current->tgid;
 	shp->shm_nattch++;
@@ -137,8 +136,7 @@
 
 	down (&shm_ids.sem);
 	/* remove from the list of attaches of the shm segment */
-	if(!(shp = shm_lock(id)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(id)));
 	shp->shm_lprid = current->tgid;
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
@@ -261,8 +259,7 @@
 		err = -EEXIST;
 	} else {
 		shp = shm_lock(id);
-		if(shp==NULL)
-			BUG();
+		BUG_ON(shp == NULL);
 		if (shp->shm_segsz < size)
 			err = -EINVAL;
 		else if (ipcperms(&shp->shm_perm, shmflg))
@@ -744,8 +741,7 @@
 	up_write(&current->mm->mmap_sem);
 
 	down (&shm_ids.sem);
-	if(!(shp = shm_lock(shmid)))
-		BUG();
+	BUG_ON(!(shp = shm_lock(shmid)));
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_flags & SHM_DEST)
--- linux-2.6.9-rc1-mm1-full-3.4/ipc/util.c.old	2004-08-28 15:55:28.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full-3.4/ipc/util.c	2004-08-28 16:03:24.000000000 +0200
@@ -216,8 +216,7 @@
 {
 	struct kern_ipc_perm* p;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
-		BUG();
+	BUG_ON(lid >= ids->size);
 
 	/* 
 	 * do not need a rcu_dereference()() here to force ordering
@@ -225,8 +224,7 @@
 	 */	
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
-	if(p==NULL)
-		BUG();
+	BUG_ON(p == NULL);
 	ids->in_use--;
 
 	if (lid == ids->max_id) {
