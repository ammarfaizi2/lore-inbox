Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUGCRga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUGCRga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUGCRga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 13:36:30 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:30087 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265161AbUGCRgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 13:36:08 -0400
Message-ID: <40E6EE71.9050402@colorfullife.com>
Date: Sat, 03 Jul 2004 19:35:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ipc 1/3: Add refcount to ipc_rcu_alloc
Content-Type: multipart/mixed;
 boundary="------------020907050100030008010003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907050100030008010003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the lifetime of the ipc objects (sem array, msg queue, shm mapping) is 
controlled by kern_ipc_perms->lock - a spinlock. There is no simple way 
to reacquire this spinlock after it was dropped to 
schedule()/kmalloc/copy_{to,from}_user/whatever.

The attached patch adds a reference count as a preparation to get rid of 
sem_revalidate().

Andrew, could you add it to -mm?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>


--------------020907050100030008010003
Content-Type: text/plain;
 name="patch-ipc-01-rcu_refcount"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-01-rcu_refcount"

diff -u 2.6/ipc/msg.c build-2.6/ipc/msg.c
--- 2.6/ipc/msg.c	2004-07-03 19:08:47.273962648 +0200
+++ build-2.6/ipc/msg.c	2004-07-03 19:16:03.445654472 +0200
@@ -100,14 +100,14 @@
 	msq->q_perm.security = NULL;
 	retval = security_msg_queue_alloc(msq);
 	if (retval) {
-		ipc_rcu_free(msq, sizeof(*msq));
+		ipc_rcu_putref(msq);
 		return retval;
 	}
 
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
 		security_msg_queue_free(msq);
-		ipc_rcu_free(msq, sizeof(*msq));
+		ipc_rcu_putref(msq);
 		return -ENOSPC;
 	}
 
@@ -193,7 +193,7 @@
 	}
 	atomic_sub(msq->q_cbytes, &msg_bytes);
 	security_msg_queue_free(msq);
-	ipc_rcu_free(msq, sizeof(struct msg_queue));
+	ipc_rcu_putref(msq);
 }
 
 asmlinkage long sys_msgget (key_t key, int msgflg)
diff -u 2.6/ipc/sem.c build-2.6/ipc/sem.c
--- 2.6/ipc/sem.c	2004-07-03 19:08:47.274962496 +0200
+++ build-2.6/ipc/sem.c	2004-07-03 19:16:08.845833520 +0200
@@ -179,14 +179,14 @@
 	sma->sem_perm.security = NULL;
 	retval = security_sem_alloc(sma);
 	if (retval) {
-		ipc_rcu_free(sma, size);
+		ipc_rcu_putref(sma);
 		return retval;
 	}
 
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
 		security_sem_free(sma);
-		ipc_rcu_free(sma, size);
+		ipc_rcu_putref(sma);
 		return -ENOSPC;
 	}
 	used_sems += nsems;
@@ -473,7 +473,7 @@
 	used_sems -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
 	security_sem_free(sma);
-	ipc_rcu_free(sma, size);
+	ipc_rcu_putref(sma);
 }
 
 static unsigned long copy_semid_to_user(void __user *buf, struct semid64_ds *in, int version)
diff -u 2.6/ipc/shm.c build-2.6/ipc/shm.c
--- 2.6/ipc/shm.c	2004-07-03 19:08:47.281961432 +0200
+++ build-2.6/ipc/shm.c	2004-07-03 19:09:16.646497344 +0200
@@ -117,7 +117,7 @@
 		shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	security_shm_free(shp);
-	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
+	ipc_rcu_putref(shp);
 }
 
 /*
@@ -194,7 +194,7 @@
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(shp);
 	if (error) {
-		ipc_rcu_free(shp, sizeof(*shp));
+		ipc_rcu_putref(shp);
 		return error;
 	}
 
@@ -234,7 +234,7 @@
 	fput(file);
 no_file:
 	security_shm_free(shp);
-	ipc_rcu_free(shp, sizeof(*shp));
+	ipc_rcu_putref(shp);
 	return error;
 }
 
diff -u 2.6/ipc/util.c build-2.6/ipc/util.c
--- 2.6/ipc/util.c	2004-07-03 19:08:47.286960672 +0200
+++ build-2.6/ipc/util.c	2004-07-03 19:20:00.162668016 +0200
@@ -135,7 +135,6 @@
 		new[i].p = NULL;
 	}
 	old = ids->entries;
-	i = ids->size;
 
 	/*
 	 * before setting the ids->entries to the new array, there must be a
@@ -147,7 +146,7 @@
 	smp_wmb();	/* prevent indexing into old array based on new size. */
 	ids->size = newsize;
 
-	ipc_rcu_free(old, sizeof(struct ipc_id)*i);
+	ipc_rcu_putref(old);
 	return ids->size;
 }
 
@@ -292,10 +291,21 @@
 	void *data[0];
 };
 
+struct ipc_rcu_hdr
+{
+	int refcount;
+	int is_vmalloc;
+};
+
+#define HDRLEN_KMALLOC		(sizeof(struct ipc_rcu_kmalloc) > sizeof(struct ipc_rcu_hdr) ? \
+					sizeof(struct ipc_rcu_kmalloc) : sizeof(struct ipc_rcu_hdr))
+#define HDRLEN_VMALLOC		(sizeof(struct ipc_rcu_vmalloc) > sizeof(struct ipc_rcu_hdr) ? \
+					sizeof(struct ipc_rcu_vmalloc) : sizeof(struct ipc_rcu_hdr))
+
 static inline int rcu_use_vmalloc(int size)
 {
 	/* Too big for a single page? */
-	if (sizeof(struct ipc_rcu_kmalloc) + size > PAGE_SIZE)
+	if (HDRLEN_KMALLOC + size > PAGE_SIZE)
 		return 1;
 	return 0;
 }
@@ -317,16 +327,29 @@
 	 * workqueue if necessary (for vmalloc). 
 	 */
 	if (rcu_use_vmalloc(size)) {
-		out = vmalloc(sizeof(struct ipc_rcu_vmalloc) + size);
-		if (out) out += sizeof(struct ipc_rcu_vmalloc);
+		out = vmalloc(HDRLEN_VMALLOC + size);
+		if (out) {
+			out += HDRLEN_VMALLOC;
+			((struct ipc_rcu_hdr *)out)[-1].is_vmalloc = 1;
+			((struct ipc_rcu_hdr *)out)[-1].refcount = 1;
+		}
 	} else {
-		out = kmalloc(sizeof(struct ipc_rcu_kmalloc)+size, GFP_KERNEL);
-		if (out) out += sizeof(struct ipc_rcu_kmalloc);
+		out = kmalloc(HDRLEN_KMALLOC + size, GFP_KERNEL);
+		if (out) {
+			out += HDRLEN_KMALLOC;
+			((struct ipc_rcu_hdr *)out)[-1].is_vmalloc = 0;
+			((struct ipc_rcu_hdr *)out)[-1].refcount = 1;
+		}
 	}
 
 	return out;
 }
 
+void ipc_rcu_getref(void *ptr)
+{
+	((struct ipc_rcu_hdr *)ptr)[-1].refcount++;
+}
+
 /**
  *	ipc_schedule_free	- free ipc + rcu space
  * 
@@ -355,11 +378,12 @@
 	kfree(free);
 }
 
-
-
-void ipc_rcu_free(void* ptr, int size)
+void ipc_rcu_putref(void *ptr)
 {
-	if (rcu_use_vmalloc(size)) {
+	if (--((struct ipc_rcu_hdr *)ptr)[-1].refcount > 0)
+		return;
+
+	if (((struct ipc_rcu_hdr *)ptr)[-1].is_vmalloc) {
 		struct ipc_rcu_vmalloc *free;
 		free = ptr - sizeof(*free);
 		call_rcu(&free->rcu, ipc_schedule_free);
@@ -368,7 +392,6 @@
 		free = ptr - sizeof(*free);
 		call_rcu(&free->rcu, ipc_immediate_free);
 	}
-
 }
 
 /**
@@ -506,6 +529,12 @@
 	return out;
 }
 
+void ipc_lock_by_ptr(struct kern_ipc_perm *perm)
+{
+	rcu_read_lock();
+	spin_lock(&perm->lock);
+}
+
 void ipc_unlock(struct kern_ipc_perm* perm)
 {
 	spin_unlock(&perm->lock);
diff -u 2.6/ipc/util.h build-2.6/ipc/util.h
--- 2.6/ipc/util.h	2004-07-03 19:08:47.287960520 +0200
+++ build-2.6/ipc/util.h	2004-07-03 19:09:16.647497192 +0200
@@ -45,14 +45,20 @@
  */
 void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
-/* for allocation that need to be freed by RCU
- * both function can sleep
+
+/* 
+ * For allocation that need to be freed by RCU.
+ * Objects are reference counted, they start with reference count 1.
+ * getref increases the refcount, the putref call that reduces the recount
+ * to 0 schedules the rcu destruction. Caller must guarantee locking.
  */
 void* ipc_rcu_alloc(int size);
-void ipc_rcu_free(void* arg, int size);
+void ipc_rcu_getref(void *ptr);
+void ipc_rcu_putref(void *ptr);
 
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id);
 struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id);
+void ipc_lock_by_ptr(struct kern_ipc_perm *ipcp);
 void ipc_unlock(struct kern_ipc_perm* perm);
 int ipc_buildid(struct ipc_ids* ids, int id, int seq);
 int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid);

--------------020907050100030008010003--
