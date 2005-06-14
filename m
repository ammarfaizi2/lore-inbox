Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFNOh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFNOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFNOh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:37:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40684 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261252AbVFNOcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:32:52 -0400
Date: Tue, 14 Jun 2005 20:00:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] files: files struct with RCU
Message-ID: <20050614143019.GE4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614142735.GB4557@in.ibm.com> <20050614142818.GC4557@in.ibm.com> <20050614142928.GD4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614142928.GD4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Patch to eliminate struct files_struct.file_lock spinlock on the reader
side and use rcu refcounting rcuref_xxx api for the f_count refcounter.
The updates to the fdtable are done by allocating a new fdtable
structure and setting files->fdt to point to the new structure.
The fdtable structure is protected by RCU thereby allowing
lock-free lookup. For fd arrays/sets that are vmalloced,
we use keventd to free them since RCU callbacks can't
sleep. A global list of fdtable to be freed is not scalable, 
so we use a per-cpu list. If keventd is already handling
the current cpu's work, we use a timer to defer queueing
of that work.

Since the last publication, this patch has been re-written
to avoid using explicit memory barriers and use
rcu_assign_pointer(), rcu_dereference() premitives instead.
This required that the fd information is kept in
a separate structure (fdtable) and updated atomically.

This patch needs the rcuref api additions as pre-req.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 fs/aio.c                  |    3 
 fs/fcntl.c                |   13 +
 fs/file.c                 |  393 ++++++++++++++++++++++++++++++----------------
 fs/file_table.c           |   40 +++-
 fs/open.c                 |    5 
 include/linux/file.h      |   11 +
 include/linux/fs.h        |    4 
 include/linux/init_task.h |    5 
 kernel/exit.c             |   15 -
 kernel/fork.c             |   23 +-
 10 files changed, 346 insertions(+), 166 deletions(-)

diff -puN fs/aio.c~files-struct-rcu fs/aio.c
--- linux-2.6.12-rc6-fd/fs/aio.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/aio.c	2005-06-14 14:05:05.000000000 +0530
@@ -29,6 +29,7 @@
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/rcuref.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -498,7 +499,7 @@ static int __aio_put_req(struct kioctx *
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
-	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
+	if (unlikely(rcuref_dec_and_test(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
diff -puN fs/fcntl.c~files-struct-rcu fs/fcntl.c
--- linux-2.6.12-rc6-fd/fs/fcntl.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/fcntl.c	2005-06-14 14:05:05.000000000 +0530
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
+#include <linux/rcupdate.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -64,8 +65,8 @@ static int locate_fd(struct files_struct
 	if (orig_start >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
-	fdt = files_fdtable(files);
 repeat:
+	fdt = files_fdtable(files);
 	/*
 	 * Someone might have closed fd's in the range
 	 * orig_start..fdt->next_fd
@@ -95,9 +96,15 @@ repeat:
 	if (error)
 		goto repeat;
 
+	/*
+	 * We reacquired files_lock, so we are safe as long as
+	 * we reacquire the fdtable pointer and use it while holding
+	 * the lock, no one can free it during that time.
+	 */
+	fdt = files_fdtable(files);
 	if (start <= fdt->next_fd)
 		fdt->next_fd = newfd + 1;
-	
+
 	error = newfd;
 	
 out:
@@ -162,7 +169,7 @@ asmlinkage long sys_dup2(unsigned int ol
 	if (!tofree && FD_ISSET(newfd, fdt->open_fds))
 		goto out_fput;
 
-	fdt->fd[newfd] = file;
+	rcu_assign_pointer(fdt->fd[newfd], file);
 	FD_SET(newfd, fdt->open_fds);
 	FD_CLR(newfd, fdt->close_on_exec);
 	spin_unlock(&files->file_lock);
diff -puN fs/file.c~files-struct-rcu fs/file.c
--- linux-2.6.12-rc6-fd/fs/file.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/file.c	2005-06-14 14:05:05.000000000 +0530
@@ -13,7 +13,26 @@
 #include <linux/vmalloc.h>
 #include <linux/file.h>
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+#include <linux/workqueue.h>
+
+struct fdtable_defer {
+	spinlock_t lock;
+	struct work_struct wq;
+	struct timer_list timer;
+	struct fdtable *next;
+};
 
+/*
+ * We use this list to defer free fdtables that have vmalloced
+ * sets/arrays. By keeping a per-cpu list, we avoid having to embed
+ * the work_struct in fdtable itself which avoids a 64 byte (i386) increase in
+ * this per-task structure.
+ */
+static DEFINE_PER_CPU(struct fdtable_defer, fdtable_defer_list);
+	
 
 /*
  * Allocate an fd array, using kmalloc or vmalloc.
@@ -48,85 +67,143 @@ void free_fd_array(struct file **array, 
 		vfree(array);
 }
 
-/*
- * Expand the fd array in the files_struct.  Called with the files
- * spinlock held for write.
- */
+static void __free_fdtable(struct fdtable *fdt)
+{
+	int fdset_size, fdarray_size;
 
-static int expand_fd_array(struct files_struct *files, int nr)
-	__releases(files->file_lock)
-	__acquires(files->file_lock)
+	fdset_size = fdt->max_fdset / 8;
+	fdarray_size = fdt->max_fds * sizeof(struct file *);
+	free_fdset(fdt->open_fds, fdset_size);
+	free_fdset(fdt->close_on_exec, fdset_size);
+	free_fd_array(fdt->fd, fdarray_size);
+	kfree(fdt);
+}
+
+static void fdtable_timer(unsigned long data)
 {
-	struct file **new_fds;
-	int error, nfds;
-	struct fdtable *fdt;
+	struct fdtable_defer *fddef = (struct fdtable_defer *)data;
 
-	
-	error = -EMFILE;
-	fdt = files_fdtable(files);
-	if (fdt->max_fds >= NR_OPEN || nr >= NR_OPEN)
+	spin_lock(&fddef->lock);
+	/*
+	 * If someone already emptied the queue return.
+	 */
+	if (!fddef->next)
 		goto out;
+	if (!schedule_work(&fddef->wq))
+		mod_timer(&fddef->timer, 5);
+out:
+	spin_unlock(&fddef->lock);
+}
 
-	nfds = fdt->max_fds;
-	spin_unlock(&files->file_lock);
+static void free_fdtable_work(struct fdtable_defer *f)
+{
+	struct fdtable *fdt;
 
-	/* 
-	 * Expand to the max in easy steps, and keep expanding it until
-	 * we have enough for the requested fd array size. 
-	 */
+	spin_lock_bh(&f->lock);
+	fdt = f->next;
+	f->next = NULL;
+	spin_unlock_bh(&f->lock);
+	while(fdt) {
+		struct fdtable *next = fdt->next;
+		__free_fdtable(fdt);
+		fdt = next;
+	}
+}
 
-	do {
-#if NR_OPEN_DEFAULT < 256
-		if (nfds < 256)
-			nfds = 256;
-		else 
-#endif
-		if (nfds < (PAGE_SIZE / sizeof(struct file *)))
-			nfds = PAGE_SIZE / sizeof(struct file *);
-		else {
-			nfds = nfds * 2;
-			if (nfds > NR_OPEN)
-				nfds = NR_OPEN;
-		}
-	} while (nfds <= nr);
+static void free_fdtable_rcu(struct rcu_head *rcu)
+{
+	struct fdtable *fdt = container_of(rcu, struct fdtable, rcu);
+	int fdset_size, fdarray_size;
+	struct fdtable_defer *fddef;
+
+	BUG_ON(!fdt);
+	fdset_size = fdt->max_fdset / 8;
+	fdarray_size = fdt->max_fds * sizeof(struct file *);
+
+	if (fdt->free_files) {
+		/*
+		 * The this fdtable was embedded in the files structure
+		 * and the files structure itself was getting destroyed.
+		 * It is now safe to free the files structure.
+		 */
+		kmem_cache_free(files_cachep, fdt->free_files);
+		return;
+	}
+	if (fdt->max_fdset <= __FD_SETSIZE && fdt->max_fds <= NR_OPEN_DEFAULT) {
+		/*
+		 * The fdtable was embedded
+		 */
+		return;
+	}
+	if (fdset_size <= PAGE_SIZE && fdarray_size <= PAGE_SIZE) {
+		kfree(fdt->open_fds);
+		kfree(fdt->close_on_exec);
+		kfree(fdt->fd);
+		kfree(fdt);
+	} else {
+		fddef = &get_cpu_var(fdtable_defer_list);
+		spin_lock(&fddef->lock);
+		fdt->next = fddef->next;
+		fddef->next = fdt;
+		/*
+		 * vmallocs are handled from the workqueue context.
+		 * If the per-cpu workqueue is running, then we
+		 * defer work scheduling through a timer.
+		 */
+		if (!schedule_work(&fddef->wq))
+			mod_timer(&fddef->timer, 5);
+		spin_unlock(&fddef->lock);
+		put_cpu_var(fdtable_defer_list);
+	}
+}
 
-	error = -ENOMEM;
-	new_fds = alloc_fd_array(nfds);
-	spin_lock(&files->file_lock);
-	if (!new_fds)
-		goto out;
+void free_fdtable(struct fdtable *fdt)
+{
+	if (fdt->free_files || fdt->max_fdset > __FD_SETSIZE || 
+					fdt->max_fds > NR_OPEN_DEFAULT)
+		call_rcu(&fdt->rcu, free_fdtable_rcu);
+}
 
-	/* Copy the existing array and install the new pointer */
-	fdt = files_fdtable(files);
+/*
+ * Expand the fdset in the files_struct.  Called with the files spinlock
+ * held for write.
+ */
+static void copy_fdtable(struct fdtable *nfdt, struct fdtable *fdt)
+{
+	int i;
+	int count;
 
-	if (nfds > fdt->max_fds) {
-		struct file **old_fds;
-		int i;
-		
-		old_fds = xchg(&fdt->fd, new_fds);
-		i = xchg(&fdt->max_fds, nfds);
-
-		/* Don't copy/clear the array if we are creating a new
-		   fd array for fork() */
-		if (i) {
-			memcpy(new_fds, old_fds, i * sizeof(struct file *));
-			/* clear the remainder of the array */
-			memset(&new_fds[i], 0,
-			       (nfds-i) * sizeof(struct file *)); 
-
-			spin_unlock(&files->file_lock);
-			free_fd_array(old_fds, i);
-			spin_lock(&files->file_lock);
-		}
-	} else {
-		/* Somebody expanded the array while we slept ... */
-		spin_unlock(&files->file_lock);
-		free_fd_array(new_fds, nfds);
-		spin_lock(&files->file_lock);
+	BUG_ON(nfdt->max_fdset < fdt->max_fdset);
+	BUG_ON(nfdt->max_fds < fdt->max_fds);
+	/* Copy the existing tables and install the new pointers */
+
+	i = fdt->max_fdset / (sizeof(unsigned long) * 8);
+	count = (nfdt->max_fdset - fdt->max_fdset) / 8;
+
+	/* 
+	 * Don't copy the entire array if the current fdset is
+	 * not yet initialised.  
+	 */
+	if (i) {
+		memcpy (nfdt->open_fds, fdt->open_fds, 
+						fdt->max_fdset/8);
+		memcpy (nfdt->close_on_exec, fdt->close_on_exec, 
+						fdt->max_fdset/8);
+		memset (&nfdt->open_fds->fds_bits[i], 0, count);
+		memset (&nfdt->close_on_exec->fds_bits[i], 0, count);
 	}
-	error = 0;
-out:
-	return error;
+
+	/* Don't copy/clear the array if we are creating a new
+	   fd array for fork() */
+	if (fdt->max_fds) {
+		memcpy(nfdt->fd, fdt->fd, 
+			fdt->max_fds * sizeof(struct file *));
+		/* clear the remainder of the array */
+		memset(&nfdt->fd[fdt->max_fds], 0,
+		       (nfdt->max_fds - fdt->max_fds) * 
+					sizeof(struct file *)); 
+	}
+	nfdt->next_fd = fdt->next_fd;
 }
 
 /*
@@ -157,28 +234,21 @@ void free_fdset(fd_set *array, int num)
 		vfree(array);
 }
 
-/*
- * Expand the fdset in the files_struct.  Called with the files spinlock
- * held for write.
- */
-static int expand_fdset(struct files_struct *files, int nr)
-	__releases(file->file_lock)
-	__acquires(file->file_lock)
+static struct fdtable *alloc_fdtable(int nr)
 {
-	fd_set *new_openset = NULL, *new_execset = NULL;
-	int error, nfds = 0;
-	struct fdtable *fdt;
-
-	error = -EMFILE;
-	fdt = files_fdtable(files);
-	if (fdt->max_fdset >= NR_OPEN || nr >= NR_OPEN)
-		goto out;
-
-	nfds = fdt->max_fdset;
-	spin_unlock(&files->file_lock);
-
-	/* Expand to the max in easy steps */
-	do {
+	struct fdtable *fdt = NULL;
+	int nfds = 0;
+  	fd_set *new_openset = NULL, *new_execset = NULL;
+	struct file **new_fds;
+  
+	fdt = kmalloc(sizeof(*fdt), GFP_KERNEL);
+	if (!fdt)
+  		goto out;
+	memset(fdt, 0, sizeof(*fdt));
+  
+	nfds = __FD_SETSIZE;
+  	/* Expand to the max in easy steps */
+  	do {
 		if (nfds < (PAGE_SIZE * 8))
 			nfds = PAGE_SIZE * 8;
 		else {
@@ -188,50 +258,88 @@ static int expand_fdset(struct files_str
 		}
 	} while (nfds <= nr);
 
-	error = -ENOMEM;
-	new_openset = alloc_fdset(nfds);
-	new_execset = alloc_fdset(nfds);
-	spin_lock(&files->file_lock);
-	if (!new_openset || !new_execset)
+  	new_openset = alloc_fdset(nfds);
+  	new_execset = alloc_fdset(nfds);
+  	if (!new_openset || !new_execset)
+  		goto out;
+	fdt->open_fds = new_openset;
+	fdt->close_on_exec = new_execset;
+	fdt->max_fdset = nfds;
+
+	nfds = NR_OPEN_DEFAULT;
+	/* 
+	 * Expand to the max in easy steps, and keep expanding it until
+	 * we have enough for the requested fd array size. 
+	 */
+	do {
+#if NR_OPEN_DEFAULT < 256
+		if (nfds < 256)
+			nfds = 256;
+		else 
+#endif
+		if (nfds < (PAGE_SIZE / sizeof(struct file *)))
+			nfds = PAGE_SIZE / sizeof(struct file *);
+		else {
+			nfds = nfds * 2;
+			if (nfds > NR_OPEN)
+				nfds = NR_OPEN;
+  		}
+	} while (nfds <= nr);
+	new_fds = alloc_fd_array(nfds);
+	if (!new_fds)
 		goto out;
+	fdt->fd = new_fds;
+	fdt->max_fds = nfds;
+	fdt->free_files = NULL;
+	return fdt;
+out:
+  	if (new_openset)
+  		free_fdset(new_openset, nfds);
+  	if (new_execset)
+  		free_fdset(new_execset, nfds);
+	kfree(fdt);
+	return NULL;
+}
 
-	error = 0;
-	
-	/* Copy the existing tables and install the new pointers */
+/*
+ * Expands the file descriptor table - it will allocate a new fdtable and
+ * both fd array and fdset. It is expected to be called with the
+ * files_lock held.
+ */
+static int expand_fdtable(struct files_struct *files, int nr)
+	__releases(files->file_lock)
+	__acquires(files->file_lock)
+{
+	int error = 0;
+	struct fdtable *fdt;
+	struct fdtable *nfdt = NULL;
+
+	spin_unlock(&files->file_lock);
+	nfdt = alloc_fdtable(nr);
+	if (!nfdt) {
+		error = -ENOMEM;
+		spin_lock(&files->file_lock);
+		goto out;
+	}
+
+	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
-	if (nfds > fdt->max_fdset) {
-		int i = fdt->max_fdset / (sizeof(unsigned long) * 8);
-		int count = (nfds - fdt->max_fdset) / 8;
-		
-		/* 
-		 * Don't copy the entire array if the current fdset is
-		 * not yet initialised.  
-		 */
-		if (i) {
-			memcpy (new_openset, fdt->open_fds, fdt->max_fdset/8);
-			memcpy (new_execset, fdt->close_on_exec, fdt->max_fdset/8);
-			memset (&new_openset->fds_bits[i], 0, count);
-			memset (&new_execset->fds_bits[i], 0, count);
-		}
-		
-		nfds = xchg(&fdt->max_fdset, nfds);
-		new_openset = xchg(&fdt->open_fds, new_openset);
-		new_execset = xchg(&fdt->close_on_exec, new_execset);
+	/*
+	 * Check again since another task may have expanded the
+	 * fd table while we dropped the lock
+	 */
+	if (nr >= fdt->max_fds || nr >= fdt->max_fdset) {
+		copy_fdtable(nfdt, fdt);
+	} else {
+		/* Somebody expanded while we dropped file_lock */
 		spin_unlock(&files->file_lock);
-		free_fdset (new_openset, nfds);
-		free_fdset (new_execset, nfds);
+		__free_fdtable(nfdt);
 		spin_lock(&files->file_lock);
-		return 0;
-	} 
-	/* Somebody expanded the array while we slept ... */
-
+		goto out;
+	}
+	rcu_assign_pointer(files->fdt, nfdt);
+	free_fdtable(fdt);
 out:
-	spin_unlock(&files->file_lock);
-	if (new_openset)
-		free_fdset(new_openset, nfds);
-	if (new_execset)
-		free_fdset(new_execset, nfds);
-	spin_lock(&files->file_lock);
 	return error;
 }
 
@@ -246,17 +354,36 @@ int expand_files(struct files_struct *fi
 	struct fdtable *fdt;
 
 	fdt = files_fdtable(files);
-	if (nr >= fdt->max_fdset) {
-		expand = 1;
-		if ((err = expand_fdset(files, nr)))
+	if (nr >= fdt->max_fdset || nr >= fdt->max_fds) {
+		if (fdt->max_fdset >= NR_OPEN || 
+			fdt->max_fds >= NR_OPEN || nr >= NR_OPEN) {
+			err = -EMFILE;
 			goto out;
-	}
-	if (nr >= fdt->max_fds) {
+		}
 		expand = 1;
-		if ((err = expand_fd_array(files, nr)))
+		if ((err = expand_fdtable(files, nr)))
 			goto out;
 	}
 	err = expand;
 out:
 	return err;
 }
+
+static void __devinit fdtable_defer_list_init(int cpu)
+{
+	struct fdtable_defer *fddef = &per_cpu(fdtable_defer_list, cpu);
+	spin_lock_init(&fddef->lock);
+	INIT_WORK(&fddef->wq, (void (*)(void *))free_fdtable_work, fddef);
+	init_timer(&fddef->timer);
+	fddef->timer.data = (unsigned long)fddef;
+	fddef->timer.function = fdtable_timer;
+	fddef->next = NULL;
+}
+
+void __init files_defer_init(void)
+{
+	int i;
+	/* Really early - can't use for_each_cpu */
+	for (i = 0; i < NR_CPUS; i++)
+		fdtable_defer_list_init(i);
+}
diff -puN fs/file_table.c~files-struct-rcu fs/file_table.c
--- linux-2.6.12-rc6-fd/fs/file_table.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/file_table.c	2005-06-14 14:05:05.000000000 +0530
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
+#include <linux/rcupdate.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
 
@@ -52,11 +53,17 @@ void filp_dtor(void * objp, struct kmem_
 	spin_unlock_irqrestore(&filp_count_lock, flags);
 }
 
-static inline void file_free(struct file *f)
+static inline void file_free_rcu(struct rcu_head *head)
 {
+	struct file *f =  container_of(head, struct file, f_rcuhead);
 	kmem_cache_free(filp_cachep, f);
 }
 
+static inline void file_free(struct file *f)
+{
+	call_rcu(&f->f_rcuhead, file_free_rcu);
+}
+
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
@@ -107,7 +114,7 @@ EXPORT_SYMBOL(get_empty_filp);
 
 void fastcall fput(struct file *file)
 {
-	if (atomic_dec_and_test(&file->f_count))
+	if (rcuref_dec_and_test(&file->f_count))
 		__fput(file);
 }
 
@@ -151,11 +158,17 @@ struct file fastcall *fget(unsigned int 
 	struct file *file;
 	struct files_struct *files = current->files;
 
-	spin_lock(&files->file_lock);
+	rcu_read_lock();
 	file = fcheck_files(files, fd);
-	if (file)
-		get_file(file);
-	spin_unlock(&files->file_lock);
+	if (file) {
+		if (!rcuref_inc_lf(&file->f_count)) {
+			/* File object ref couldn't be taken */
+			rcu_read_unlock();
+			return NULL;
+		}
+	}	
+	rcu_read_unlock();
+
 	return file;
 }
 
@@ -177,21 +190,25 @@ struct file fastcall *fget_light(unsigne
 	if (likely((atomic_read(&files->count) == 1))) {
 		file = fcheck_files(files, fd);
 	} else {
-		spin_lock(&files->file_lock);
+		rcu_read_lock();
 		file = fcheck_files(files, fd);
 		if (file) {
-			get_file(file);
-			*fput_needed = 1;
+			if (rcuref_inc_lf(&file->f_count))
+				*fput_needed = 1;
+			else
+				/* Didn't get the reference, someone's freed */
+				file = NULL;
 		}
-		spin_unlock(&files->file_lock);
+		rcu_read_unlock();
 	}
+
 	return file;
 }
 
 
 void put_filp(struct file *file)
 {
-	if (atomic_dec_and_test(&file->f_count)) {
+	if (rcuref_dec_and_test(&file->f_count)) {
 		security_file_free(file);
 		file_kill(file);
 		file_free(file);
@@ -252,4 +269,5 @@ void __init files_init(unsigned long mem
 	files_stat.max_files = n; 
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
+	files_defer_init();
 } 
diff -puN fs/open.c~files-struct-rcu fs/open.c
--- linux-2.6.12-rc6-fd/fs/open.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/fs/open.c	2005-06-14 14:05:05.000000000 +0530
@@ -23,6 +23,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/rcupdate.h>
 
 #include <asm/unistd.h>
 
@@ -929,7 +930,7 @@ void fastcall fd_install(unsigned int fd
 	fdt = files_fdtable(files);
 	if (unlikely(fdt->fd[fd] != NULL))
 		BUG();
-	fdt->fd[fd] = file;
+	rcu_assign_pointer(fdt->fd[fd], file);
 	spin_unlock(&files->file_lock);
 }
 
@@ -1029,7 +1030,7 @@ asmlinkage long sys_close(unsigned int f
 	filp = fdt->fd[fd];
 	if (!filp)
 		goto out_unlock;
-	fdt->fd[fd] = NULL;
+	rcu_assign_pointer(fdt->fd[fd], NULL);
 	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
diff -puN include/linux/file.h~files-struct-rcu include/linux/file.h
--- linux-2.6.12-rc6-fd/include/linux/file.h~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/include/linux/file.h	2005-06-14 14:05:05.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/posix_types.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
@@ -23,6 +24,9 @@ struct fdtable {
 	struct file ** fd;      /* current fd array */
 	fd_set *close_on_exec;
 	fd_set *open_fds;
+	struct rcu_head rcu;
+	struct files_struct *free_files;
+	struct fdtable *next;
 };
 
 /*
@@ -31,13 +35,14 @@ struct fdtable {
 struct files_struct {
         atomic_t count;
         spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
+	struct fdtable *fdt;
 	struct fdtable fdtab;
         fd_set close_on_exec_init;
         fd_set open_fds_init;
         struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
-#define files_fdtable(files) (&(files)->fdtab)
+#define files_fdtable(files) (rcu_dereference((files)->fdt))
 
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
@@ -65,6 +70,8 @@ extern fd_set *alloc_fdset(int);
 extern void free_fdset(fd_set *, int);
 
 extern int expand_files(struct files_struct *, int nr);
+extern void free_fdtable(struct fdtable *fdt);
+extern void __init files_defer_init(void);
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {
@@ -72,7 +79,7 @@ static inline struct file * fcheck_files
 	struct fdtable *fdt = files_fdtable(files);
 
 	if (fd < fdt->max_fds)
-		file = fdt->fd[fd];
+		file = rcu_dereference(fdt->fd[fd]);
 	return file;
 }
 
diff -puN include/linux/fs.h~files-struct-rcu include/linux/fs.h
--- linux-2.6.12-rc6-fd/include/linux/fs.h~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/include/linux/fs.h	2005-06-14 14:05:05.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
+#include <linux/rcuref.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -600,12 +601,13 @@ struct file {
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
+	struct rcu_head 	f_rcuhead;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
 #define file_list_unlock() spin_unlock(&files_lock);
 
-#define get_file(x)	atomic_inc(&(x)->f_count)
+#define get_file(x)	rcuref_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
diff -puN include/linux/init_task.h~files-struct-rcu include/linux/init_task.h
--- linux-2.6.12-rc6-fd/include/linux/init_task.h~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/include/linux/init_task.h	2005-06-14 14:05:05.000000000 +0530
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <linux/rcupdate.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -11,12 +12,16 @@
 	.fd		= &init_files.fd_array[0], 	\
 	.close_on_exec	= &init_files.close_on_exec_init, \
 	.open_fds	= &init_files.open_fds_init, 	\
+	.rcu		= RCU_HEAD_INIT, 		\
+	.free_files	= NULL,		 		\
+	.next		= NULL,		 		\
 }
 
 #define INIT_FILES \
 { 							\
 	.count		= ATOMIC_INIT(1), 		\
 	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+	.fdt		= &init_files.fdtab, 		\
 	.fdtab		= INIT_FDTABLE,			\
 	.close_on_exec_init = { { 0, } }, 		\
 	.open_fds_init	= { { 0, } }, 			\
diff -puN kernel/exit.c~files-struct-rcu kernel/exit.c
--- linux-2.6.12-rc6-fd/kernel/exit.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/kernel/exit.c	2005-06-14 14:05:05.000000000 +0530
@@ -406,15 +406,16 @@ void fastcall put_files_struct(struct fi
 		close_files(files);
 		/*
 		 * Free the fd and fdset arrays if we expanded them.
+		 * If the fdtable was embedded, pass files for freeing
+		 * at the end of the RCU grace period. Otherwise,
+		 * you can free files immediately.
 		 */
 		fdt = files_fdtable(files);
-		if (fdt->fd != &files->fd_array[0])
-			free_fd_array(fdt->fd, fdt->max_fds);
-		if (fdt->max_fdset > __FD_SETSIZE) {
-			free_fdset(fdt->open_fds, fdt->max_fdset);
-			free_fdset(fdt->close_on_exec, fdt->max_fdset);
-		}
-		kmem_cache_free(files_cachep, files);
+		if (fdt == &files->fdtab)
+			fdt->free_files = files;
+		else 
+			kmem_cache_free(files_cachep, files);
+		free_fdtable(fdt);
 	}
 }
 
diff -puN kernel/fork.c~files-struct-rcu kernel/fork.c
--- linux-2.6.12-rc6-fd/kernel/fork.c~files-struct-rcu	2005-06-14 14:05:05.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/kernel/fork.c	2005-06-14 14:05:05.000000000 +0530
@@ -35,6 +35,7 @@
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
 #include <linux/futex.h>
+#include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
@@ -559,13 +560,12 @@ static inline int copy_fs(unsigned long 
 	return 0;
 }
 
-static int count_open_files(struct files_struct *files, int size)
+static int count_open_files(struct fdtable *fdt)
 {
+	int size = fdt->max_fdset;
 	int i;
-	struct fdtable *fdt;
 
 	/* Find the last open fd */
-	fdt = files_fdtable(files);
 	for (i = size/(8*sizeof(long)); i > 0; ) {
 		if (fdt->open_fds->fds_bits[--i])
 			break;
@@ -586,13 +586,17 @@ static struct files_struct *alloc_files(
 	atomic_set(&newf->count, 1);
 
 	spin_lock_init(&newf->file_lock);
-	fdt = files_fdtable(newf);
+	fdt = &newf->fdtab;
 	fdt->next_fd = 0;
 	fdt->max_fds = NR_OPEN_DEFAULT;
 	fdt->max_fdset = __FD_SETSIZE;
 	fdt->close_on_exec = &newf->close_on_exec_init;
 	fdt->open_fds = &newf->open_fds_init;
 	fdt->fd = &newf->fd_array[0];
+	INIT_RCU_HEAD(&fdt->rcu);
+	fdt->free_files = NULL;
+	fdt->next = NULL;
+	rcu_assign_pointer(newf->fdt, fdt);
 out:
 	return newf;
 }
@@ -631,7 +635,7 @@ static int copy_files(unsigned long clon
 	old_fdt = files_fdtable(oldf);
 	new_fdt = files_fdtable(newf);
 	size = old_fdt->max_fdset;
-	open_files = count_open_files(oldf, old_fdt->max_fdset);
+	open_files = count_open_files(old_fdt);
 	expand = 0;
 
 	/*
@@ -655,7 +659,14 @@ static int copy_files(unsigned long clon
 		spin_unlock(&newf->file_lock);
 		if (error < 0)
 			goto out_release;
+		new_fdt = files_fdtable(newf);
+		/*
+		 * Reacquire the oldf lock and a pointer to its fd table
+		 * who knows it may have a new bigger fd table. We need
+		 * the latest pointer.
+		 */
 		spin_lock(&oldf->file_lock);
+		old_fdt = files_fdtable(oldf);
 	}
 
 	old_fds = old_fdt->fd;
@@ -677,7 +688,7 @@ static int copy_files(unsigned long clon
 			 */
 			FD_CLR(open_files - i, new_fdt->open_fds);
 		}
-		*new_fds++ = f;
+		rcu_assign_pointer(*new_fds++, f);
 	}
 	spin_unlock(&oldf->file_lock);
 

_
