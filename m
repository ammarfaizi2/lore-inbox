Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSJ1BAz>; Sun, 27 Oct 2002 20:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJ1BAz>; Sun, 27 Oct 2002 20:00:55 -0500
Received: from dp.samba.org ([66.70.73.150]:41905 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262799AbSJ1BAw>;
	Sun, 27 Oct 2002 20:00:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Sun, 27 Oct 2002 08:43:07 -0000."
             <Pine.LNX.4.44.0210270748560.1704-100000@localhost.localdomain> 
Date: Mon, 28 Oct 2002 12:06:34 +1100
Message-Id: <20021028010711.E659A2C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210270748560.1704-100000@localhost.localdomain> you 
write:
> On Sun, 27 Oct 2002, Rusty Russell wrote:
> > 
> > You can't do that.  It's the price you pay.  It's nonsensical to fail
> > to destroy an shm or sem.
> 
> Ironic, but not nonsensical.

Yes, nonsensical.  Firstly, it's in violation of the standard to fail
IPC_RMID under random circumstances.  Secondly, failing to clean up is
an unhandlable error, since you're quite possible in the failure path
of the code already.  This is a well known issue.

> > Using a mempool is putting your head in the sand, because it's use is
> > not bounded.  Might as well just ignore kmalloc failures and leak
> > memory, which is *really* dumb, because if we get killed by the
> > oom-killer because we're out of memory, and that results in IPC trying
> > to free.
> 
> Bounded in what sense?  The mempool is dedicated to ipc freeing, it's
> not being drawn on by other kinds of use.  In the OOM-kill case of
> actually getting down to using the reserved pool, each reserved item
> will be returned when RCU (and, in the vfree case, the additional
> scheduled work) has done with it.  Unbounded in that we cannot say
> how many milliseconds that will take, but so what?

Two oom kills.  Three oom kills.  Four oom kills.  Where's the bound
here?

Our allocator behavior for GFP_KERNEL has changed several times.  Are
you sure that it won't *ever* fail under other circomstances?

> Okay (I expect, didn't review it) for just the ids arrays, but too much
> memory waste if we have to allocate for each msq, sema, shm: if there's
> a better solution available.  mempool looks better to us.

It's a hacky, fragile and incorrect solution.  It's completely
tasteless.

There are *three* things this patch does, and it's not clear which
ones helped the dbt1 benchmark (and I can't find the source).  But
let's assume they're all good optimizations (*cough*).

In order to save 12 bytes, you've added dozens of lines of subtle,
fragile, incorrect code.  You honestly think this is a worthwhile
tradeoff?

> > Hope that helps,
> 
> Not yet.  You seem to have had a bad experience with something like
> this (the mempools or the RCU or the combination), and you're warning
> us away without actually telling us what you found.

I *wrote* the RCU interface (though the implementation in 2.5 isn't
mine).  I thought it was pretty clear how it was supposed to be used.
Obviously, I was wrong.

> I suspect that whatever it was that you found, is not relevant to
> this IPC case.

Clear code vs. bad code?  Definitely relevent here.

Patch below is against Mingming's mm4 release.  Compiles, untested.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Commentry: There are several cases where ipc_alloc is *always*
followed by ipc_free, so the extra allocation is gratuitous, but these
are temporary allocations and the extra size is not critical.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm4-ipc-rcu/include/linux/msg.h working-2.5.44-mm4-ipc-rcu-fix/include/linux/msg.h
--- working-2.5.44-mm4-ipc-rcu/include/linux/msg.h	2002-07-21 17:43:10.000000000 +1000
+++ working-2.5.44-mm4-ipc-rcu-fix/include/linux/msg.h	2002-10-28 11:12:54.000000000 +1100
@@ -2,6 +2,7 @@
 #define _LINUX_MSG_H
 
 #include <linux/ipc.h>
+#include <linux/rcupdate.h>
 
 /* ipcs ctl commands */
 #define MSG_STAT 11
@@ -90,6 +91,8 @@ struct msg_queue {
 	struct list_head q_messages;
 	struct list_head q_receivers;
 	struct list_head q_senders;
+
+	struct rcu_head q_free;		/* Used to free this via rcu */
 };
 
 asmlinkage long sys_msgget (key_t key, int msgflg);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.44-mm4-ipc-rcu/include/linux/sem.h working-2.5.44-mm4-ipc-rcu-fix/include/linux/sem.h
--- working-2.5.44-mm4-ipc-rcu/include/linux/sem.h	2002-06-06 21:38:40.000000000 +1000
+++ working-2.5.44-mm4-ipc-rcu-fix/include/linux/sem.h	2002-10-28 11:24:39.000000000 +1100
@@ -2,6 +2,7 @@
 #define _LINUX_SEM_H
 
 #include <linux/ipc.h>
+#include <linux/rcupdate.h>
 
 /* semop flags */
 #define SEM_UNDO        0x1000  /* undo the operation on exit */
@@ -94,6 +95,7 @@ struct sem_array {
 	struct sem_queue	**sem_pending_last; /* last pending operation */
 	struct sem_undo		*undo;		/* undo requests on this array */
 	unsigned long		sem_nsems;	/* no. of semaphores in array */
+	struct rcu_head		sem_free;	/* used to rcu free array. */
 };
 
 /* One queue for each sleeping process in the system. */
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
