Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKYXGZ>; Mon, 25 Nov 2002 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSKYXGZ>; Mon, 25 Nov 2002 18:06:25 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:57249 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S265815AbSKYXFu>; Mon, 25 Nov 2002 18:05:50 -0500
Date: Mon, 25 Nov 2002 15:12:58 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.49 - semaphore operations with timeouts
Message-ID: <20021125231258.GC19970@nic1-pc.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Oracle Corporation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a system call semtimedop which allows a program to execute a
semaphore operation with a timeout. The function behaves just like semop
except if the calling process has to be suspended. If the process has been
suspended for longer than the timeout (and of course, its semaphore
operation hasn't completed) then the system call returns EAGAIN to the
calling process (via errno). Calling semtimedop with a NULL timeout is
identical to calling semop.

The overall impact to the semaphore code is minor.

Userspace code to use/test this can be found at:
http://www.exothermic.org/linux/semtimedop.tar.gz
	--Mark

diff -urNp linux-2.5.49-orig/arch/i386/kernel/sys_i386.c linux-2.5.49/arch/i386/kernel/sys_i386.c
--- linux-2.5.49-orig/arch/i386/kernel/sys_i386.c	2002-11-22 13:41:11.000000000 -0800
+++ linux-2.5.49/arch/i386/kernel/sys_i386.c	2002-11-22 17:30:28.000000000 -0800
@@ -140,7 +140,11 @@ asmlinkage int sys_ipc (uint call, int f
 
 	switch (call) {
 	case SEMOP:
-		return sys_semop (first, (struct sembuf *)ptr, second);
+		return sys_semtimedop (first, (struct sembuf *)ptr, second, NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop (first, (struct sembuf *)ptr, second,
+							   (const struct timespec *)fifth);
+
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
diff -urNp linux-2.5.49-orig/arch/ia64/ia32/sys_ia32.c linux-2.5.49/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.49-orig/arch/ia64/ia32/sys_ia32.c	2002-11-22 13:40:49.000000000 -0800
+++ linux-2.5.49/arch/ia64/ia32/sys_ia32.c	2002-11-22 17:30:28.000000000 -0800
@@ -2124,6 +2124,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.49-orig/arch/ia64/kernel/entry.S linux-2.5.49/arch/ia64/kernel/entry.S
--- linux-2.5.49-orig/arch/ia64/kernel/entry.S	2002-11-22 13:40:24.000000000 -0800
+++ linux-2.5.49/arch/ia64/kernel/entry.S	2002-11-22 17:30:28.000000000 -0800
@@ -1254,7 +1254,7 @@ sys_call_table:
 	data8 sys_epoll_create
 	data8 sys_epoll_ctl
 	data8 sys_epoll_wait			// 1245
-	data8 ia64_ni_syscall
+	data8 sys_semtimedop
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -urNp linux-2.5.49-orig/include/asm-i386/ipc.h linux-2.5.49/include/asm-i386/ipc.h
--- linux-2.5.49-orig/include/asm-i386/ipc.h	2002-11-22 13:40:58.000000000 -0800
+++ linux-2.5.49/include/asm-i386/ipc.h	2002-11-22 17:28:36.000000000 -0800
@@ -14,6 +14,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.49-orig/include/asm-ia64/unistd.h linux-2.5.49/include/asm-ia64/unistd.h
--- linux-2.5.49-orig/include/asm-ia64/unistd.h	2002-11-22 13:40:19.000000000 -0800
+++ linux-2.5.49/include/asm-ia64/unistd.h	2002-11-22 17:28:36.000000000 -0800
@@ -235,6 +235,7 @@
 #define __NR_epoll_create		1243
 #define __NR_epoll_ctl			1244
 #define __NR_epoll_wait			1245
+#define __NR_semtimedop			1246
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -urNp linux-2.5.49-orig/include/linux/sem.h linux-2.5.49/include/linux/sem.h
--- linux-2.5.49-orig/include/linux/sem.h	2002-11-22 13:40:39.000000000 -0800
+++ linux-2.5.49/include/linux/sem.h	2002-11-22 17:28:36.000000000 -0800
@@ -140,6 +140,8 @@ struct sysv_sem {
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops,
+								unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -urNp linux-2.5.49-orig/ipc/sem.c linux-2.5.49/ipc/sem.c
--- linux-2.5.49-orig/ipc/sem.c	2002-11-22 13:40:29.000000000 -0800
+++ linux-2.5.49/ipc/sem.c	2002-11-22 17:28:36.000000000 -0800
@@ -62,6 +62,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/time.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
@@ -969,6 +970,12 @@ static int alloc_undo(struct sem_array *
 
 asmlinkage long sys_semop (int semid, struct sembuf *tsops, unsigned nsops)
 {
+    return sys_semtimedop(semid, tsops, nsops, NULL);
+}
+
+asmlinkage long sys_semtimedop (int semid, struct sembuf *tsops,
+								unsigned nsops, const struct timespec *timeout)
+{
 	int error = -EINVAL;
 	struct sem_array *sma;
 	struct sembuf fast_sops[SEMOPM_FAST];
@@ -976,6 +983,7 @@ asmlinkage long sys_semop (int semid, st
 	struct sem_undo *un;
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
+	unsigned long offset = MAX_SCHEDULE_TIMEOUT;
 
 
 	if (nsops < 1 || semid < 0)
@@ -991,6 +999,19 @@ asmlinkage long sys_semop (int semid, st
 		error=-EFAULT;
 		goto out_free;
 	}
+ 	if (timeout) {
+	  struct timespec _timeout;
+	  if (copy_from_user(&_timeout, timeout, sizeof(*timeout))) {
+		error = -EFAULT;
+		goto out_free;
+	  }
+	  if (_timeout.tv_sec < 0 || _timeout.tv_nsec < 0 ||
+		  _timeout.tv_nsec >= 1000000000L) {
+		error = -EINVAL;
+		goto out_free;
+	  }
+	  offset = timespec_to_jiffies(&_timeout);
+	}
 	lock_semundo();
 	sma = sem_lock(semid);
 	error=-EINVAL;
@@ -1058,7 +1079,7 @@ asmlinkage long sys_semop (int semid, st
 		sem_unlock(sma);
 		unlock_semundo();
 
-		schedule();
+		offset = schedule_timeout(offset);
 
 		lock_semundo();
 		sma = sem_lock(semid);
@@ -1084,6 +1105,8 @@ asmlinkage long sys_semop (int semid, st
 				break;
 		} else {
 			error = queue.status;
+ 			if (error == -EINTR && offset == 0)
+			    error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
diff -urNp linux-2.5.49-orig/ipc/util.c linux-2.5.49/ipc/util.c
--- linux-2.5.49-orig/ipc/util.c	2002-11-22 13:40:39.000000000 -0800
+++ linux-2.5.49/ipc/util.c	2002-11-22 17:28:36.000000000 -0800
@@ -538,6 +538,13 @@ asmlinkage long sys_semop (int semid, st
 	return -ENOSYS;
 }
 
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops, unsigned nsops,
+								const struct timespec *timeout)
+{
+	return -ENOSYS;
+}
+
+
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg)
 {
 	return -ENOSYS;
diff -urNp linux-2.5.49-orig/ipc/util.c.orig linux-2.5.49/ipc/util.c.orig
--- linux-2.5.49-orig/ipc/util.c.orig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.49/ipc/util.c.orig	2002-11-22 13:40:39.000000000 -0800
@@ -0,0 +1,587 @@
+/*
+ * linux/ipc/util.c
+ * Copyright (C) 1992 Krishna Balasubramanian
+ *
+ * Sep 1997 - Call suser() last after "normal" permission checks so we
+ *            get BSD style process accounting right.
+ *            Occurs in several places in the IPC code.
+ *            Chris Evans, <chris@ferret.lmh.ox.ac.uk>
+ * Nov 1999 - ipc helper functions, unified SMP locking
+ *	      Manfred Spraul <manfreds@colorfullife.com>
+ * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
+ *            Mingming Cao <cmm@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/shm.h>
+#include <linux/init.h>
+#include <linux/msg.h>
+#include <linux/smp_lock.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/highuid.h>
+#include <linux/security.h>
+#include <linux/rcupdate.h>
+#include <linux/workqueue.h>
+
+#if defined(CONFIG_SYSVIPC)
+
+#include "util.h"
+
+/**
+ *	ipc_init	-	initialise IPC subsystem
+ *
+ *	The various system5 IPC resources (semaphores, messages and shared
+ *	memory are initialised
+ */
+ 
+void __init ipc_init (void)
+{
+	sem_init();
+	msg_init();
+	shm_init();
+	return;
+}
+
+/**
+ *	ipc_init_ids		-	initialise IPC identifiers
+ *	@ids: Identifier set
+ *	@size: Number of identifiers
+ *
+ *	Given a size for the ipc identifier range (limited below IPCMNI)
+ *	set up the sequence range to use then allocate and initialise the
+ *	array itself. 
+ */
+ 
+void __init ipc_init_ids(struct ipc_ids* ids, int size)
+{
+	int i;
+	sema_init(&ids->sem,1);
+
+	if(size > IPCMNI)
+		size = IPCMNI;
+	ids->size = size;
+	ids->in_use = 0;
+	ids->max_id = -1;
+	ids->seq = 0;
+	{
+		int seq_limit = INT_MAX/SEQ_MULTIPLIER;
+		if(seq_limit > USHRT_MAX)
+			ids->seq_max = USHRT_MAX;
+		 else
+		 	ids->seq_max = seq_limit;
+	}
+
+	ids->entries = ipc_rcu_alloc(sizeof(struct ipc_id)*size);
+
+	if(ids->entries == NULL) {
+		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
+		ids->size = 0;
+	}
+	for(i=0;i<ids->size;i++)
+		ids->entries[i].p = NULL;
+}
+
+/**
+ *	ipc_findkey	-	find a key in an ipc identifier set	
+ *	@ids: Identifier set
+ *	@key: The key to find
+ *	
+ *	Requires ipc_ids.sem locked.
+ *	Returns the identifier if found or -1 if not.
+ */
+ 
+int ipc_findkey(struct ipc_ids* ids, key_t key)
+{
+	int id;
+	struct kern_ipc_perm* p;
+	int max_id = ids->max_id;
+
+	for (id = 0; id <= max_id; id++) {
+		p = ids->entries[id].p;
+		if(p==NULL)
+			continue;
+		if (key == p->key)
+			return id;
+	}
+	return -1;
+}
+
+/*
+ * Requires ipc_ids.sem locked
+ */
+static int grow_ary(struct ipc_ids* ids, int newsize)
+{
+	struct ipc_id* new;
+	struct ipc_id* old;
+	int i;
+
+	if(newsize > IPCMNI)
+		newsize = IPCMNI;
+	if(newsize <= ids->size)
+		return newsize;
+
+	new = ipc_rcu_alloc(sizeof(struct ipc_id)*newsize);
+	if(new == NULL)
+		return ids->size;
+	memcpy(new, ids->entries, sizeof(struct ipc_id)*ids->size);
+	for(i=ids->size;i<newsize;i++) {
+		new[i].p = NULL;
+	}
+	old = ids->entries;
+	i = ids->size;
+
+	/*
+	 * before setting the ids->entries to the new array, there must be a
+	 * wmb() to make sure that the memcpyed contents of the new array are
+	 * visible before the new array becomes visible.
+	 */
+	wmb();
+	ids->entries = new;
+	wmb();
+	ids->size = newsize;
+
+	ipc_rcu_free(old, sizeof(struct ipc_id)*i);
+	return ids->size;
+}
+
+/**
+ *	ipc_addid 	-	add an IPC identifier
+ *	@ids: IPC identifier set
+ *	@new: new IPC permission set
+ *	@size: new size limit for the id array
+ *
+ *	Add an entry 'new' to the IPC arrays. The permissions object is
+ *	initialised and the first free entry is set up and the id assigned
+ *	is returned. The list is returned in a locked state on success.
+ *	On failure the list is not locked and -1 is returned.
+ */
+ 
+int ipc_addid(struct ipc_ids* ids, struct kern_ipc_perm* new, int size)
+{
+	int id;
+
+	size = grow_ary(ids,size);
+	for (id = 0; id < size; id++) {
+		if(ids->entries[id].p == NULL)
+			goto found;
+	}
+	return -1;
+found:
+	ids->in_use++;
+	if (id > ids->max_id)
+		ids->max_id = id;
+
+	new->cuid = new->uid = current->euid;
+	new->gid = new->cgid = current->egid;
+
+	new->seq = ids->seq++;
+	if(ids->seq > ids->seq_max)
+		ids->seq = 0;
+
+	new->lock = SPIN_LOCK_UNLOCKED;
+	new->deleted = 0;
+	rcu_read_lock();
+	spin_lock(&new->lock);
+	ids->entries[id].p = new;
+	return id;
+}
+
+/**
+ *	ipc_rmid	-	remove an IPC identifier
+ *	@ids: identifier set
+ *	@id: Identifier to remove
+ *
+ *	The identifier must be valid, and in use. The kernel will panic if
+ *	fed an invalid identifier. The entry is removed and internal
+ *	variables recomputed. The object associated with the identifier
+ *	is returned.
+ *	ipc_ids.sem and the spinlock for this ID is hold before this function
+ *	is called, and remain locked on the exit.
+ */
+ 
+struct kern_ipc_perm* ipc_rmid(struct ipc_ids* ids, int id)
+{
+	struct kern_ipc_perm* p;
+	int lid = id % SEQ_MULTIPLIER;
+	if(lid >= ids->size)
+		BUG();
+	
+	p = ids->entries[lid].p;
+	ids->entries[lid].p = NULL;
+	if(p==NULL)
+		BUG();
+	ids->in_use--;
+
+	if (lid == ids->max_id) {
+		do {
+			lid--;
+			if(lid == -1)
+				break;
+		} while (ids->entries[lid].p == NULL);
+		ids->max_id = lid;
+	}
+	p->deleted = 1;
+	return p;
+}
+
+/**
+ *	ipc_alloc	-	allocate ipc space
+ *	@size: size desired
+ *
+ *	Allocate memory from the appropriate pools and return a pointer to it.
+ *	NULL is returned if the allocation fails
+ */
+ 
+void* ipc_alloc(int size)
+{
+	void* out;
+	if(size > PAGE_SIZE)
+		out = vmalloc(size);
+	else
+		out = kmalloc(size, GFP_KERNEL);
+	return out;
+}
+
+/**
+ *	ipc_free        -       free ipc space
+ *	@ptr: pointer returned by ipc_alloc
+ *	@size: size of block
+ *
+ *	Free a block created with ipc_alloc. The caller must know the size
+ *	used in the allocation call.
+ */
+
+void ipc_free(void* ptr, int size)
+{
+	if(size > PAGE_SIZE)
+		vfree(ptr);
+	else
+		kfree(ptr);
+}
+
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
+static inline int rcu_use_vmalloc(int size)
+{
+	/* Too big for a single page? */
+	if (sizeof(struct ipc_rcu_kmalloc) + size > PAGE_SIZE)
+		return 1;
+	return 0;
+}
+
+/**
+ *	ipc_rcu_alloc	-	allocate ipc and rcu space 
+ *	@size: size desired
+ *
+ *	Allocate memory for the rcu header structure +  the object.
+ *	Returns the pointer to the object.
+ *	NULL is returned if the allocation fails. 
+ */
+ 
+void* ipc_rcu_alloc(int size)
+{
+	void* out;
+	/* 
+	 * We prepend the allocation with the rcu struct, and
+	 * workqueue if necessary (for vmalloc). 
+	 */
+	if (rcu_use_vmalloc(size)) {
+		out = vmalloc(sizeof(struct ipc_rcu_vmalloc) + size);
+		if (out) out += sizeof(struct ipc_rcu_vmalloc);
+	} else {
+		out = kmalloc(sizeof(struct ipc_rcu_kmalloc)+size, GFP_KERNEL);
+		if (out) out += sizeof(struct ipc_rcu_kmalloc);
+	}
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
+}
+
+void ipc_rcu_free(void* ptr, int size)
+{
+	if (rcu_use_vmalloc(size)) {
+		struct ipc_rcu_vmalloc *free;
+		free = ptr - sizeof(*free);
+		call_rcu(&free->rcu, ipc_schedule_free, free);
+	} else {
+		struct ipc_rcu_kmalloc *free;
+		free = ptr - sizeof(*free);
+		/* kfree takes a "const void *" so gcc warns.  So we cast. */
+		call_rcu(&free->rcu, (void (*)(void *))kfree, free);
+	}
+
+}
+
+/**
+ *	ipcperms	-	check IPC permissions
+ *	@ipcp: IPC permission set
+ *	@flag: desired permission set.
+ *
+ *	Check user, group, other permissions for access
+ *	to ipc resources. return 0 if allowed
+ */
+ 
+int ipcperms (struct kern_ipc_perm *ipcp, short flag)
+{	/* flag will most probably be 0 or S_...UGO from <linux/stat.h> */
+	int requested_mode, granted_mode;
+
+	requested_mode = (flag >> 6) | (flag >> 3) | flag;
+	granted_mode = ipcp->mode;
+	if (current->euid == ipcp->cuid || current->euid == ipcp->uid)
+		granted_mode >>= 6;
+	else if (in_group_p(ipcp->cgid) || in_group_p(ipcp->gid))
+		granted_mode >>= 3;
+	/* is there some bit set in requested_mode but not in granted_mode? */
+	if ((requested_mode & ~granted_mode & 0007) && 
+	    !capable(CAP_IPC_OWNER))
+		return -1;
+
+	return security_ops->ipc_permission(ipcp, flag);
+}
+
+/*
+ * Functions to convert between the kern_ipc_perm structure and the
+ * old/new ipc_perm structures
+ */
+
+/**
+ *	kernel_to_ipc64_perm	-	convert kernel ipc permissions to user
+ *	@in: kernel permissions
+ *	@out: new style IPC permissions
+ *
+ *	Turn the kernel object 'in' into a set of permissions descriptions
+ *	for returning to userspace (out).
+ */
+ 
+
+void kernel_to_ipc64_perm (struct kern_ipc_perm *in, struct ipc64_perm *out)
+{
+	out->key	= in->key;
+	out->uid	= in->uid;
+	out->gid	= in->gid;
+	out->cuid	= in->cuid;
+	out->cgid	= in->cgid;
+	out->mode	= in->mode;
+	out->seq	= in->seq;
+}
+
+/**
+ *	ipc64_perm_to_ipc_perm	-	convert old ipc permissions to new
+ *	@in: new style IPC permissions
+ *	@out: old style IPC permissions
+ *
+ *	Turn the new style permissions object in into a compatibility
+ *	object and store it into the 'out' pointer.
+ */
+ 
+void ipc64_perm_to_ipc_perm (struct ipc64_perm *in, struct ipc_perm *out)
+{
+	out->key	= in->key;
+	out->uid	= NEW_TO_OLD_UID(in->uid);
+	out->gid	= NEW_TO_OLD_GID(in->gid);
+	out->cuid	= NEW_TO_OLD_UID(in->cuid);
+	out->cgid	= NEW_TO_OLD_GID(in->cgid);
+	out->mode	= in->mode;
+	out->seq	= in->seq;
+}
+
+/*
+ * ipc_get() requires ipc_ids.sem down, otherwise we need a rmb() here
+ * to sync with grow_ary();
+ *
+ * So far only shm_get_stat() uses ipc_get() via shm_get().  So ipc_get()
+ * is called with shm_ids.sem locked.  Thus a rmb() is not needed here,
+ * as grow_ary() also requires shm_ids.sem down(for shm).
+ *
+ * But if ipc_get() is used in the future without ipc_ids.sem down,
+ * we need to add a rmb() before accessing the entries array
+ */
+struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
+{
+	struct kern_ipc_perm* out;
+	int lid = id % SEQ_MULTIPLIER;
+	if(lid >= ids->size)
+		return NULL;
+	rmb();
+	out = ids->entries[lid].p;
+	return out;
+}
+
+struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
+{
+	struct kern_ipc_perm* out;
+	int lid = id % SEQ_MULTIPLIER;
+
+	rcu_read_lock();
+	if(lid >= ids->size) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	/* we need a barrier here to sync with grow_ary() */
+	rmb();
+	out = ids->entries[lid].p;
+	if(out == NULL) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	spin_lock(&out->lock);
+	
+	/* ipc_rmid() may have already freed the ID while ipc_lock
+	 * was spinning: here verify that the structure is still valid
+	 */
+	if (out->deleted) {
+		spin_unlock(&out->lock);
+		rcu_read_unlock();
+		return NULL;
+	}
+	return out;
+}
+
+void ipc_unlock(struct kern_ipc_perm* perm)
+{
+	spin_unlock(&perm->lock);
+	rcu_read_unlock();
+}
+
+int ipc_buildid(struct ipc_ids* ids, int id, int seq)
+{
+	return SEQ_MULTIPLIER*seq + id;
+}
+
+int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
+{
+	if(uid/SEQ_MULTIPLIER != ipcp->seq)
+		return 1;
+	return 0;
+}
+
+#ifndef __ia64__
+
+/**
+ *	ipc_parse_version	-	IPC call version
+ *	@cmd: pointer to command
+ *
+ *	Return IPC_64 for new style IPC and IPC_OLD for old style IPC. 
+ *	The cmd value is turned from an encoding command and version into
+ *	just the command code.
+ */
+ 
+int ipc_parse_version (int *cmd)
+{
+	if (*cmd & IPC_64) {
+		*cmd ^= IPC_64;
+		return IPC_64;
+	} else {
+		return IPC_OLD;
+	}
+}
+
+#endif /* __ia64__ */
+
+#else
+/*
+ * Dummy functions when SYSV IPC isn't configured
+ */
+
+int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+{
+	return 0;
+}
+
+void exit_semundo(struct task_struct *tsk)
+{
+	return;
+}
+
+
+void sem_exit (void)
+{
+    return;
+}
+
+asmlinkage long sys_semget (key_t key, int nsems, int semflg)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_msgget (key_t key, int msgflg)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_msgsnd (int msqid, struct msgbuf *msgp, size_t msgsz, int msgflg)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_msgrcv (int msqid, struct msgbuf *msgp, size_t msgsz, long msgtyp,
+		       int msgflg)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_msgctl (int msqid, int cmd, struct msqid_ds *buf)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_shmget (key_t key, size_t size, int shmflag)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_shmat (int shmid, char *shmaddr, int shmflg, ulong *addr)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_shmdt (char *shmaddr)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds *buf)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_SYSVIPC */
