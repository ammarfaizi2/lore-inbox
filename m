Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJRAKz>; Thu, 17 Oct 2002 20:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJRAKz>; Thu, 17 Oct 2002 20:10:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26575 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262295AbSJRAKv>;
	Thu, 17 Oct 2002 20:10:51 -0400
Message-ID: <3DAF5266.3F606821@us.ibm.com>
Date: Thu, 17 Oct 2002 17:14:31 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, akpm@zip.com.au, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org
CC: cmm@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH]IPC locks breaking down with RCU
Content-Type: multipart/mixed;
 boundary="------------A13B452F38F744693213D82B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A13B452F38F744693213D82B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Linus,

This is the latest version of the ipc lock patch.  It breaks down the
three global IPC locks into one lock per IPC ID,  also addresses the
cache line bouncing problem  introduced in the original patch. The
original post could be found at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102980357802682&w=2

The original patch breaks down the global IPC locks, yet added another
layer of locking to protect the IPC ID array in case of resizing. Some
concern was raised that the read/write lock may cause cache line
bouncing.

Since write lock is only used when the array is dynamically resized, 
RCU seems perfectly fit for this situation.  By doing so it could reduce
the possible lock contention in some applications where the IPC
resources are heavily used, without introducing cache line bouncing.

Besides the RCU changes, it also remove the redundant ipc_lockall() and
ipc_unlockall() as suggested by Hugh Dickins.

Patch is against 2.5.43 kernel. It requires Dipankar Sarma's
read_barrier_depends RCU helper patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103479438017486&w=2

We use the ipc lock on OracleApps and it gave us the best number. 
Please include.

Mingming Cao
--------------A13B452F38F744693213D82B
Content-Type: text/plain; charset=us-ascii;
 name="ipclock-rcu-2543.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipclock-rcu-2543.patch"

Binary files linux-2.5.43/arch/i386/boot/compressed/vmlinux.bin.gz and linux-2.5.43-ipc/arch/i386/boot/compressed/vmlinux.bin.gz differ
diff -urN -X dontdiff linux-2.5.43/include/linux/ipc.h linux-2.5.43-ipc/include/linux/ipc.h
--- linux-2.5.43/include/linux/ipc.h	Tue Oct 15 20:26:43 2002
+++ linux-2.5.43-ipc/include/linux/ipc.h	Wed Oct 16 09:48:28 2002
@@ -56,6 +56,7 @@
 /* used by in-kernel data structures */
 struct kern_ipc_perm
 {
+	spinlock_t	lock;
 	key_t		key;
 	uid_t		uid;
 	gid_t		gid;
diff -urN -X dontdiff linux-2.5.43/ipc/shm.c linux-2.5.43-ipc/ipc/shm.c
--- linux-2.5.43/ipc/shm.c	Tue Oct 15 20:28:22 2002
+++ linux-2.5.43-ipc/ipc/shm.c	Wed Oct 16 09:48:28 2002
@@ -38,8 +38,6 @@
 
 #define shm_lock(id)	((struct shmid_kernel*)ipc_lock(&shm_ids,id))
 #define shm_unlock(id)	ipc_unlock(&shm_ids,id)
-#define shm_lockall()	ipc_lockall(&shm_ids)
-#define shm_unlockall()	ipc_unlockall(&shm_ids)
 #define shm_get(id)	((struct shmid_kernel*)ipc_get(&shm_ids,id))
 #define shm_buildid(id, seq) \
 	ipc_buildid(&shm_ids, id, seq)
@@ -409,14 +407,12 @@
 
 		memset(&shm_info,0,sizeof(shm_info));
 		down(&shm_ids.sem);
-		shm_lockall();
 		shm_info.used_ids = shm_ids.in_use;
 		shm_get_stat (&shm_info.shm_rss, &shm_info.shm_swp);
 		shm_info.shm_tot = shm_tot;
 		shm_info.swap_attempts = 0;
 		shm_info.swap_successes = 0;
 		err = shm_ids.max_id;
-		shm_unlockall();
 		up(&shm_ids.sem);
 		if(copy_to_user (buf, &shm_info, sizeof(shm_info)))
 			return -EFAULT;
diff -urN -X dontdiff linux-2.5.43/ipc/util.c linux-2.5.43-ipc/ipc/util.c
--- linux-2.5.43/ipc/util.c	Tue Oct 15 20:27:54 2002
+++ linux-2.5.43-ipc/ipc/util.c	Wed Oct 16 09:48:28 2002
@@ -92,8 +92,10 @@
 {
 	int id;
 	struct kern_ipc_perm* p;
+	int max_id = ids->max_id;
 
-	for (id = 0; id <= ids->max_id; id++) {
+	read_barrier_depends();
+	for (id = 0; id <= max_id; id++) {
 		p = ids->entries[id].p;
 		if(p==NULL)
 			continue;
@@ -106,8 +108,8 @@
 static int grow_ary(struct ipc_ids* ids, int newsize)
 {
 	struct ipc_id* new;
-	struct ipc_id* old;
 	int i;
+	struct rcu_ipc_array *arg = NULL;
 
 	if(newsize > IPCMNI)
 		newsize = IPCMNI;
@@ -121,14 +123,19 @@
 	for(i=ids->size;i<newsize;i++) {
 		new[i].p = NULL;
 	}
+	arg = (struct rcu_ipc_array *) kmalloc(sizeof(*arg), GFP_KERNEL);
+	if(arg == NULL)
+		return ids->size;
+	arg->entries = ids->entries;
+	arg->size = ids->size;
+	
 	spin_lock(&ids->ary);
-
-	old = ids->entries;
 	ids->entries = new;
-	i = ids->size;
+	wmb();
 	ids->size = newsize;
 	spin_unlock(&ids->ary);
-	ipc_free(old, sizeof(struct ipc_id)*i);
+
+	call_rcu(&arg->rh, ipc_free_callback, arg);
 	return ids->size;
 }
 
@@ -166,7 +173,9 @@
 	if(ids->seq > ids->seq_max)
 		ids->seq = 0;
 
-	spin_lock(&ids->ary);
+	new->lock = SPIN_LOCK_UNLOCKED;
+	rcu_read_lock();
+	spin_lock(&new->lock);
 	ids->entries[id].p = new;
 	return id;
 }
@@ -188,6 +197,7 @@
 	int lid = id % SEQ_MULTIPLIER;
 	if(lid >= ids->size)
 		BUG();
+	rmb();
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
 	if(p==NULL)
@@ -239,7 +249,12 @@
 	else
 		kfree(ptr);
 }
-
+static void ipc_free_callback(void * arg)
+{
+	struct rcu_ipc_array *a = (struct rcu_ipc_array *)arg;
+	ipc_free(a->entries, a->size);
+	kfree(arg);
+}
 /**
  *	ipcperms	-	check IPC permissions
  *	@ipcp: IPC permission set
diff -urN -X dontdiff linux-2.5.43/ipc/util.h linux-2.5.43-ipc/ipc/util.h
--- linux-2.5.43/ipc/util.h	Tue Oct 15 20:28:24 2002
+++ linux-2.5.43-ipc/ipc/util.h	Wed Oct 16 09:48:28 2002
@@ -4,6 +4,7 @@
  *
  * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  */
+#include <linux/rcupdate.h>
 
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
@@ -12,6 +13,12 @@
 void msg_init (void);
 void shm_init (void);
 
+struct rcu_ipc_array {
+	struct rcu_head rh;
+	struct ipc_id* entries;
+	int size;
+};
+
 struct ipc_ids {
 	int size;
 	int in_use;
@@ -44,11 +51,7 @@
  */
 void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
-
-extern inline void ipc_lockall(struct ipc_ids* ids)
-{
-	spin_lock(&ids->ary);
-}
+void ipc_free_callback(void* arg);
 
 extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
@@ -56,32 +59,43 @@
 	int lid = id % SEQ_MULTIPLIER;
 	if(lid >= ids->size)
 		return NULL;
-
+	rmb();
 	out = ids->entries[lid].p;
 	return out;
 }
 
-extern inline void ipc_unlockall(struct ipc_ids* ids)
-{
-	spin_unlock(&ids->ary);
-}
 extern inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
-		return NULL;
 
-	spin_lock(&ids->ary);
+	rcu_read_lock();
+	if(lid >= ids->size) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	rmb();
 	out = ids->entries[lid].p;
-	if(out==NULL)
-		spin_unlock(&ids->ary);
+	if(out==NULL) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	spin_lock(&out->lock);
 	return out;
 }
 
 extern inline void ipc_unlock(struct ipc_ids* ids, int id)
 {
-	spin_unlock(&ids->ary);
+	int lid = id % SEQ_MULTIPLIER;
+	struct kern_ipc_perm* out;
+
+        if(lid >= ids->size)
+		return;
+	rmb();	
+	out = ids->entries[lid].p;
+	if (out)
+		spin_unlock(&out->lock);
+	rcu_read_unlock();
 }
 
 extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)

--------------A13B452F38F744693213D82B--

