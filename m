Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSJ2AGE>; Mon, 28 Oct 2002 19:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSJ2AGB>; Mon, 28 Oct 2002 19:06:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:905 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261440AbSJ2AFn>;
	Mon, 28 Oct 2002 19:05:43 -0500
Message-ID: <3DBDD069.776BE08A@us.ibm.com>
Date: Mon, 28 Oct 2002 16:03:53 -0800
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>
CC: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: [RFC][PATCH]ipc rcu alloc/free patch - mm6
References: <20021028222738.201E02C4D6@lists.samba.org>
Content-Type: multipart/mixed;
 boundary="------------CF76F211AC54DF1C5466C17A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CF76F211AC54DF1C5466C17A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew, Rusty,

Here is the patch which addresses RCU alloc problem araised by Rusty. 
It replaced the mempool  with Rusty's "RCU allocating RCU structure with
the object-to-be-freed together" solution.  Patch is for 2.5.44-mm6,
compiled and tested.

Please review and apply if you like.

Mingming
--------------------------------------------------------------------------------
msg.c  |    2 -
sem.c  |    6 +--
shm.c  |    2 -
util.c |  104
++++++++++++++++++++++++++++++++++-------------------------------
util.h |   23 ++++++++++----
5 files changed, 77 insertions(+), 60 deletions(-)
--------------CF76F211AC54DF1C5466C17A
Content-Type: text/plain; charset=us-ascii;
 name="mm6-ipc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm6-ipc.patch"

diff -urN 2544-mm6/ipc/msg.c 2544-mm6-ipc/ipc/msg.c
--- 2544-mm6/ipc/msg.c	Mon Oct 28 09:51:20 2002
+++ 2544-mm6-ipc/ipc/msg.c	Mon Oct 28 09:31:41 2002
@@ -93,7 +93,7 @@
 	int retval;
 	struct msg_queue *msq;
 
-	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
+	msq  = (struct msg_queue *) ipc_rcu_alloc (sizeof (*msq));
 	if (!msq) 
 		return -ENOMEM;
 
diff -urN 2544-mm6/ipc/sem.c 2544-mm6-ipc/ipc/sem.c
--- 2544-mm6/ipc/sem.c	Mon Oct 28 09:51:20 2002
+++ 2544-mm6-ipc/ipc/sem.c	Mon Oct 28 09:31:41 2002
@@ -126,7 +126,7 @@
 		return -ENOSPC;
 
 	size = sizeof (*sma) + nsems * sizeof (struct sem);
-	sma = (struct sem_array *) ipc_alloc(size);
+	sma = (struct sem_array *) ipc_rcu_alloc(size);
 	if (!sma) {
 		return -ENOMEM;
 	}
@@ -138,14 +138,14 @@
 	sma->sem_perm.security = NULL;
 	retval = security_ops->sem_alloc_security(sma);
 	if (retval) {
-		ipc_free(sma, size);
+		ipc_rcu_free(sma, size);
 		return retval;
 	}
 
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
 		security_ops->sem_free_security(sma);
-		ipc_free(sma, size);
+		ipc_rcu_free(sma, size);
 		return -ENOSPC;
 	}
 	used_sems += nsems;
diff -urN 2544-mm6/ipc/shm.c 2544-mm6-ipc/ipc/shm.c
--- 2544-mm6/ipc/shm.c	Mon Oct 28 09:51:20 2002
+++ 2544-mm6-ipc/ipc/shm.c	Mon Oct 28 09:31:41 2002
@@ -180,7 +180,7 @@
 	if (shm_tot + numpages >= shm_ctlall)
 		return -ENOSPC;
 
-	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp), GFP_USER);
+	shp = (struct shmid_kernel *) ipc_rcu_alloc (sizeof (*shp));
 	if (!shp)
 		return -ENOMEM;
 
diff -urN 2544-mm6/ipc/util.c 2544-mm6-ipc/ipc/util.c
--- 2544-mm6/ipc/util.c	Mon Oct 28 09:51:20 2002
+++ 2544-mm6-ipc/ipc/util.c	Mon Oct 28 09:38:52 2002
@@ -22,26 +22,11 @@
 #include <linux/slab.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
-#include <linux/mempool.h>
 
 #if defined(CONFIG_SYSVIPC)
 
 #include "util.h"
 
-static mempool_t* rcu_backup_pool;
-
-/* alloc and free function for rcu backup mempool */
-
-static void *alloc_ipc_rcu(int gfp_mask, void *pool_data)
-{
-	return kmalloc(sizeof(struct rcu_ipc_free), gfp_mask);
-}
-
-static void free_ipc_rcu(void* arg, void *pool_data)
-{
-	kfree(arg);
-}
-
 /**
  *	ipc_init	-	initialise IPC subsystem
  *
@@ -86,7 +71,7 @@
 		 	ids->seq_max = seq_limit;
 	}
 
-	ids->entries = ipc_alloc(sizeof(struct ipc_id)*size);
+	ids->entries = ipc_rcu_alloc(sizeof(struct ipc_id)*size);
 
 	if(ids->entries == NULL) {
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
@@ -94,13 +79,6 @@
 	}
 	for(i=0;i<ids->size;i++)
 		ids->entries[i].p = NULL;
-
-	/* create a mempool in case normal kmalloc failed */
-	rcu_backup_pool = mempool_create(MAX_RCU_BACKUPS, 
-					alloc_ipc_rcu, free_ipc_rcu, NULL);
-	
-	if (rcu_backup_pool == NULL)
-		panic("ipc_init_ids() failed\n");
 }
 
 /**
@@ -128,6 +106,14 @@
 	return -1;
 }
 
+static inline int use_vmalloc(int size)
+{
+	/* Too big for a single page? */
+	if (sizeof(struct ipc_rcu_kmalloc) + size > PAGE_SIZE)
+		return 1;
+	return 0;
+}
+
 /*
  * Requires ipc_ids.sem locked
  */
@@ -142,7 +128,7 @@
 	if(newsize <= ids->size)
 		return newsize;
 
-	new = ipc_alloc(sizeof(struct ipc_id)*newsize);
+	new = ipc_rcu_alloc(sizeof(struct ipc_id)*newsize);
 	if(new == NULL)
 		return ids->size;
 	memcpy(new, ids->entries, sizeof(struct ipc_id)*ids->size);
@@ -257,16 +243,15 @@
 		out = kmalloc(size, GFP_KERNEL);
 	return out;
 }
-
 /**
- *	ipc_free	-	free ipc space
+ *	ipc_free        -       free ipc space
  *	@ptr: pointer returned by ipc_alloc
  *	@size: size of block
  *
  *	Free a block created with ipc_alloc. The caller must know the size
  *	used in the allocation call.
  */
- 
+
 void ipc_free(void* ptr, int size)
 {
 	if(size > PAGE_SIZE)
@@ -275,39 +260,60 @@
 		kfree(ptr);
 }
 
-/* 
- * Since RCU callback function is called in bh,
- * we need to defer the vfree to schedule_work
+/**
+ *	ipc_rcu_alloc	-	allocate ipc and rcu space 
+ *	@size: size desired
+ *
+ *	Allocate memory for the rcu header structure +  the object.
+ *	Returns the pointer to the object.
+ *	NULL is returned if the allocation fails. 
  */
-static void ipc_free_scheduled(void* arg)
-{
-	struct rcu_ipc_free *a = arg;
-	vfree(a->ptr);
-	mempool_free(a, rcu_backup_pool);
-}
-
-static void ipc_free_callback(void* arg)
+ 
+void* ipc_rcu_alloc(int size)
 {
-	struct rcu_ipc_free *a = arg;
+	void* out;
 	/* 
-	 * if data is vmalloced, then we need to delay the free
+	 * We prepend the allocation with the rcu struct, and
+	 * workqueue if necessary (for vmalloc). 
 	 */
-	if (a->size > PAGE_SIZE) {
-		INIT_WORK(&a->work, ipc_free_scheduled, arg);
-		schedule_work(&a->work);
+	if (use_vmalloc(size)) {
+		out = vmalloc(sizeof(struct ipc_rcu_vmalloc) + size);
+		if (out) out += sizeof(struct ipc_rcu_vmalloc);
 	} else {
-		kfree(a->ptr);
-		mempool_free(a, rcu_backup_pool);
+		out = kmalloc(sizeof(struct ipc_rcu_kmalloc)+size, GFP_KERNEL);
+		if (out) out += sizeof(struct ipc_rcu_kmalloc);
 	}
+
+	return out;
+}
+
+/**
+ *	ipc_schedule_free	- free ipc + rcu space
+ * 
+ * Since RCU callback function is called in bh,
+ * we need to defer the vfree to schedule_work
+ */
+static void ipc_schedule_free(void* arg)
+{
+	struct ipc_rcu_vmalloc *free = arg;
+
+	INIT_WORK(&free->work, vfree, free);
+	schedule_work(&free->work);
 }
 
 void ipc_rcu_free(void* ptr, int size)
 {
-	struct rcu_ipc_free* arg = mempool_alloc(rcu_backup_pool, GFP_KERNEL);
+	if (use_vmalloc(size)) {
+		struct ipc_rcu_vmalloc *free;
+		free = ptr - sizeof(*free);
+		call_rcu(&free->rcu, ipc_schedule_free, free);
+	} else {
+		struct ipc_rcu_kmalloc *free;
+		free = ptr - sizeof(*free);
+		/* kfree takes a "const void *" so gcc warns.  So we cast. */
+		call_rcu(&free->rcu, (void (*)(void *))kfree, free);
+	}
 
-	arg->ptr = ptr;
-	arg->size = size;
-	call_rcu(&arg->rcu_head, ipc_free_callback, arg);
 }
 
 /**
diff -urN 2544-mm6/ipc/util.h 2544-mm6-ipc/ipc/util.h
--- 2544-mm6/ipc/util.h	Mon Oct 28 09:51:20 2002
+++ 2544-mm6-ipc/ipc/util.h	Mon Oct 28 09:37:43 2002
@@ -9,17 +9,24 @@
 
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
-#define MAX_RCU_BACKUPS	4	/*max # of elements in rcu_backup_pool*/
 
 void sem_init (void);
 void msg_init (void);
 void shm_init (void);
 
-struct rcu_ipc_free {
-	struct rcu_head		rcu_head;
-	void 			*ptr;
-	int 			size;
-	struct work_struct	work;
+struct ipc_rcu_kmalloc
+{
+	struct rcu_head rcu;
+	/* "void *" makes sure alignment of following data is sane. */
+	void *data[0];
+};
+
+struct ipc_rcu_vmalloc
+{
+	struct rcu_head rcu;
+	struct work_struct work;
+	/* "void *" makes sure alignment of following data is sane. */
+	void *data[0];
 };
 
 struct ipc_ids {
@@ -52,6 +59,10 @@
  */
 void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
+/* for allocation that need to be freed by RCU
+ * both function can sleep
+ */
+void* ipc_rcu_alloc(int size);
 void ipc_rcu_free(void* arg, int size);
 
 struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id);

--------------CF76F211AC54DF1C5466C17A--

