Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSJ1BLC>; Sun, 27 Oct 2002 20:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSJ1BLC>; Sun, 27 Oct 2002 20:11:02 -0500
Received: from dp.samba.org ([66.70.73.150]:16821 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262800AbSJ1BLA>;
	Sun, 27 Oct 2002 20:11:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Mon, 28 Oct 2002 12:06:34 +1100."
Date: Mon, 28 Oct 2002 12:15:28 +1100
Message-Id: <20021028011720.7662B2C099@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm4-ipc-rcu/include/linux/msg.h working-2.5.44-mm4-ipc-rcu-fix/include/linux/msg.h
> --- working-2.5.44-mm4-ipc-rcu/include/linux/msg.h	2002-07-21 17:43:10.000000000 +1000
> +++ working-2.5.44-mm4-ipc-rcu-fix/include/linux/msg.h	2002-10-28 11:12:54.000000000 +1100

Oops.  That patch had some fluff in msg.h and sem.h.  Delete those, or
just use this instead (still against Mingming's mm4 "ignore kmalloc
failure" patch):

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm4-ipc-rcu/ipc/util.c working-2.5.44-mm4-ipc-rcu-fix/ipc/util.c
--- working-2.5.44-mm4-ipc-rcu/ipc/util.c	2002-10-28 11:08:35.000000000 +1100
+++ working-2.5.44-mm4-ipc-rcu-fix/ipc/util.c	2002-10-28 12:01:09.000000000 +1100
@@ -213,21 +213,49 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 	return p;
 }
 
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
+};
+
+static inline int use_vmalloc(int size)
+{
+	/* Too big for a single page? */
+	if (sizeof(struct ipc_rcu_kmalloc) + size > PAGE_SIZE)
+		return 1;
+	return 0;
+}
+
 /**
  *	ipc_alloc	-	allocate ipc space
  *	@size: size desired
  *
  *	Allocate memory from the appropriate pools and return a pointer to it.
- *	NULL is returned if the allocation fails
+ *	NULL is returned if the allocation fails.  This can be freed with
+ *	ipc_free (to free immediately) or ipc_rcu_free (to free once safe).
  */
- 
 void* ipc_alloc(int size)
 {
 	void* out;
-	if(size > PAGE_SIZE)
-		out = vmalloc(size);
-	else
-		out = kmalloc(size, GFP_KERNEL);
+	/* We prepend the allocation with the rcu struct, and
+           workqueue if necessary (for vmalloc). */
+	if (use_vmalloc(size)) {
+		out = vmalloc(sizeof(struct ipc_rcu_vmalloc) + size);
+		if (out) out += sizeof(struct ipc_rcu_vmalloc);
+	} else {
+		out = kmalloc(sizeof(struct ipc_rcu_kmalloc)+size, GFP_KERNEL);
+		if (out) out += sizeof(struct ipc_rcu_kmalloc);
+	}
 	return out;
 }
 
@@ -242,48 +270,36 @@ void* ipc_alloc(int size)
  
 void ipc_free(void* ptr, int size)
 {
-	if(size > PAGE_SIZE)
-		vfree(ptr);
+	if (use_vmalloc(size))
+		vfree(ptr - sizeof(struct ipc_rcu_vmalloc));
 	else
-		kfree(ptr);
+		kfree(ptr - sizeof(struct ipc_rcu_kmalloc));
 }
 
 /* 
  * Since RCU callback function is called in bh,
  * we need to defer the vfree to schedule_work
  */
-static void ipc_free_scheduled(void* arg)
+static void ipc_schedule_free(void *arg)
 {
-	struct rcu_ipc_free *a = (struct rcu_ipc_free *)arg;
-	vfree(a->ptr);
-	kfree(a);
-}
+	struct ipc_rcu_vmalloc *free = arg;
 
-static void ipc_free_callback(void* arg)
-{
-	struct rcu_ipc_free *a = (struct rcu_ipc_free *)arg;
-	/* 
-	 * if data is vmalloced, then we need to delay the free
-	 */
-	if (a->size > PAGE_SIZE) {
-		INIT_WORK(&a->work, ipc_free_scheduled, arg);
-		schedule_work(&a->work);
-	} else {
-		kfree(a->ptr);
-		kfree(a);
-	}
+	INIT_WORK(&free->work, vfree, free);
+	schedule_work(&free->work);
 }
 
 void ipc_rcu_free(void* ptr, int size)
 {
-	struct rcu_ipc_free* arg;
-
-	arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
-	if (arg == NULL)
-		return;
-	arg->ptr = ptr;
-	arg->size = size;
-	call_rcu(&arg->rcu_head, ipc_free_callback, arg);
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
 }
 
 /**

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
