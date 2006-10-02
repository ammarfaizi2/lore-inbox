Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWJBKBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWJBKBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWJBKBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:01:31 -0400
Received: from ns.suse.de ([195.135.220.2]:27841 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWJBKB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:01:27 -0400
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
References: <200610011414.30443.vlobanov@speakeasy.net>
From: Andi Kleen <ak@suse.de>
Date: 02 Oct 2006 12:01:23 +0200
In-Reply-To: <200610011414.30443.vlobanov@speakeasy.net>
Message-ID: <p73y7rzghos.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> writes:
> 
> The allocation algorithm sizes the fdarray in such a way that its memory usage
> increases in easy page-sized chunks. Additionally, it tries to account for the
> optimal usage of the allocators involved: kmalloc() for sizes less than a
> page, and vmalloc() with page granularity for sizes greater than a page.

Best would be to avoid vmalloc() completely because it can be quite
costly

-Andi

> Namely, the following sizes for the fdarray are considered, and the smallest
> that accommodates the requested fd count is chosen:
>     pagesize / 4
>     pagesize / 2
>     pagesize      <- memory allocator switch point
>     pagesize * 2
>     pagesize * 3
>     pagesize * 4
>     ...etc...
> Unlike the current implementation, this allocation scheme does not require a
> loop to compute the optimal fdarray size, and can be done in straightline 
> code.
> 
> Furthermore, since the fdarray overflows the pagesize boundary long before any
> of the fdsets do, it makes sense to optimize run-time by allocating both 
> fdsets
> in a single swoop. Even together, they will still be, by far, smaller than the
> fdarray.
> 
> As long as we're replacing the guts of fs/file.c, it makes sense to tidy up
> the code. This work includes:
>     simplification via refactoring,
>     elimination of unnecessary code, and
>     extensive commenting throughout the entire file.
> This is the last patch in the series. All the code should now be sparkly
> clean.
> 
> Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
> 
> diff -Npru old/fs/file.c new/fs/file.c
> --- old/fs/file.c	2006-09-28 20:13:13.000000000 -0700
> +++ new/fs/file.c	2006-09-28 20:22:48.000000000 -0700
> @@ -1,21 +1,18 @@
>  /*
>   *  linux/fs/file.c
>   *
> + *  Manage the dynamic fd arrays in the process files_struct.
>   *  Copyright (C) 1998-1999, Stephen Tweedie and Bill Hawes
>   *
> - *  Manage the dynamic fd arrays in the process files_struct.
> + *  Pagesize-based fdarray/fdset allocation algorithm; major cleanups.
> + *  Copyright (C) 2006, Vadim Lobanov
>   */
>  
>  #include <linux/fs.h>
> -#include <linux/mm.h>
> -#include <linux/time.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/file.h>
> -#include <linux/bitops.h>
>  #include <linux/interrupt.h>
> -#include <linux/spinlock.h>
> -#include <linux/rcupdate.h>
>  #include <linux/workqueue.h>
>  
>  struct fdtable_defer {
> @@ -26,120 +23,153 @@ struct fdtable_defer {
>  };
>  
>  /*
> - * We use this list to defer free fdtables that have vmalloced
> - * sets/arrays. By keeping a per-cpu list, we avoid having to embed
> - * the work_struct in fdtable itself which avoids a 64 byte (i386) increase 
> in
> - * this per-task structure.
> + * We use this list to defer free fdtables that have vmalloced sets/arrays. 
> By
> + * keeping a per-cpu list, we avoid having to embed the work_struct in the
> + * fdtable itself.
>   */
>  static DEFINE_PER_CPU(struct fdtable_defer, fdtable_defer_list);
>  
> -
> -/*
> - * Allocate an fd array, using kmalloc or vmalloc.
> - * Note: the array isn't cleared at allocation time.
> +/**
> + * alloc_fdmem - Allocate space for fdtable dynamic data.
> + * @size: Amount of memory, in bytes, required to hold the data.
>   */
> -struct file ** alloc_fd_array(int num)
> +static inline void * alloc_fdmem(unsigned int size)
>  {
> -	struct file **new_fds;
> -	int size = num * sizeof(struct file *);
> -
>  	if (size <= PAGE_SIZE)
> -		new_fds = (struct file **) kmalloc(size, GFP_KERNEL);
> -	else 
> -		new_fds = (struct file **) vmalloc(size);
> -	return new_fds;
> +		return kmalloc(size, GFP_KERNEL);
> +	else
> +		return vmalloc(size);
>  }
>  
> -void free_fd_array(struct file **array, int num)
> +/**
> + * free_fdarr - Free the fdarray within the fdtable.
> + * @fdt: The containing fdtable.
> + */
> +static inline void free_fdarr(struct fdtable *fdt)
>  {
> -	int size = num * sizeof(struct file *);
> -
> -	if (!array) {
> -		printk (KERN_ERR "free_fd_array: array = 0 (num = %d)\n", num);
> -		return;
> -	}
> -
> -	if (num <= NR_OPEN_DEFAULT) /* Don't free the embedded fd array! */
> -		return;
> -	else if (size <= PAGE_SIZE)
> -		kfree(array);
> +	if (fdt->max_fds <= (PAGE_SIZE / sizeof(struct file *)))
> +		kfree(fdt->fd);
>  	else
> -		vfree(array);
> +		vfree(fdt->fd);
>  }
>  
> -static void __free_fdtable(struct fdtable *fdt)
> +/**
> + * free_fdset - Free the fdsets within the fdtable.
> + * @fdt: The containing fdtable.
> + */
> +static inline void free_fdset(struct fdtable *fdt)
>  {
> -	free_fdset(fdt->open_fds, fdt->max_fds);
> -	free_fdset(fdt->close_on_exec, fdt->max_fds);
> -	free_fd_array(fdt->fd, fdt->max_fds);
> -	kfree(fdt);
> +	if (fdt->max_fds <= (PAGE_SIZE * BITS_PER_BYTE / 2))
> +		kfree(fdt->open_fds);
> +	else
> +		vfree(fdt->open_fds);
>  }
>  
> +/**
> + * fdtable_timer - Reschedule deferred fdtable deletion work.
> + * @data: Typecast pointer to the relevant fdtable_defer structure.
> + */
>  static void fdtable_timer(unsigned long data)
>  {
> -	struct fdtable_defer *fddef = (struct fdtable_defer *)data;
> +	struct fdtable_defer *fddef;
>  
> +	fddef = (struct fdtable_defer *)data;
>  	spin_lock(&fddef->lock);
>  	/*
> -	 * If someone already emptied the queue return.
> +	 * If there are any fdtables scheduled for deletion, then try to
> +	 * schedule this work. If we could not schedule, then run this function
> +	 * again in a little while.
>  	 */
> -	if (!fddef->next)
> -		goto out;
> -	if (!schedule_work(&fddef->wq))
> -		mod_timer(&fddef->timer, 5);
> -out:
> +	if (fddef->next)
> +		if (!schedule_work(&fddef->wq))
> +			mod_timer(&fddef->timer, 5);
>  	spin_unlock(&fddef->lock);
>  }
>  
> -static void free_fdtable_work(struct fdtable_defer *f)
> +/**
> + * free_fdtable_work - Free deferred fdtables.
> + * @fddef: Per-cpu area containing a list of deferred fdtables.
> + *
> + * Fdtable structures which contain member data obtained using vmalloc are 
> not
> + * freed immediately, but are instead deferred for the workqueue context. The
> + * workqueue uses this function to handle the deferred fdtables.
> + */
> +static void free_fdtable_work(struct fdtable_defer *fddef)
>  {
>  	struct fdtable *fdt;
>  
> -	spin_lock_bh(&f->lock);
> -	fdt = f->next;
> -	f->next = NULL;
> -	spin_unlock_bh(&f->lock);
> -	while(fdt) {
> -		struct fdtable *next = fdt->next;
> -		__free_fdtable(fdt);
> +	/*
> +	 * Grab a linked list of the deferred fdtables. We'll free those, so
> +	 * set the list as empty before continuing with the real work.
> +	 */
> +	spin_lock_bh(&fddef->lock);
> +	fdt = fddef->next;
> +	fddef->next = NULL;
> +	spin_unlock_bh(&fddef->lock);
> +
> +	while (fdt) {
> +		struct fdtable *next;
> +
> +		next = fdt->next;
> +		/*
> +		 * Since this fdtable was deferred, we know for a fact that the
> +		 * fdarray was obtained with vmalloc. The fdset is smaller,
> +		 * however, so we must check its size to know how to release
> +		 * it.
> +		 */
> +		vfree(fdt->fd);
> +		free_fdset(fdt);
> +		kfree(fdt);
>  		fdt = next;
>  	}
>  }
>  
> +/**
> + * free_fdtable_rcu - Free an fdtable or its wrapper files_struct.
> + * @rcu: The RCU head structure embedded within the to-be-freed fdtable.
> + *
> + * In order to correctly free an fdtable that was in use by the system, this
> + * function should be invoked as an RCU callback on the target fdtable. It 
> must
> + * be used on non-embedded fdtables or embedded fdtables once the wrapper
> + * files_struct is to be discarded; it must not be used on embedded fdtables
> + * where the wrapper files_struct must persist.
> + */
>  void free_fdtable_rcu(struct rcu_head *rcu)
>  {
> -	struct fdtable *fdt = container_of(rcu, struct fdtable, rcu);
> -	int fdset_size, fdarray_size;
> -	struct fdtable_defer *fddef;
> -
> -	BUG_ON(!fdt);
> -	fdset_size = fdt->max_fds / 8;
> -	fdarray_size = fdt->max_fds * sizeof(struct file *);
> +	struct fdtable *fdt;
>  
> +	fdt = container_of(rcu, struct fdtable, rcu);
>  	if (fdt->max_fds <= NR_OPEN_DEFAULT) {
>  		/*
> -		 * This fdtable is embedded in the files structure and that
> -		 * structure itself is getting destroyed.
> +		 * This fdtable is embedded within a wrapper files_struct, and
> +		 * both are now expired. Free the container.
>  		 */
>  		kmem_cache_free(files_cachep,
>  				container_of(fdt, struct files_struct, fdtab));
>  		return;
>  	}
> -	if (fdset_size <= PAGE_SIZE && fdarray_size <= PAGE_SIZE) {
> -		kfree(fdt->open_fds);
> -		kfree(fdt->close_on_exec);
> +	if (fdt->max_fds <= (PAGE_SIZE / sizeof(struct file *))) {
> +		/*
> +		 * The fdarray was obtained with kmalloc, and since the fdset
> +		 * will always be smaller we know it was also obtained with
> +		 * kmalloc. Thus, we can dispose of the fdtable right now.
> +		 */
>  		kfree(fdt->fd);
> +		kfree(fdt->open_fds);
>  		kfree(fdt);
>  	} else {
> +		struct fdtable_defer *fddef;
> +
> +		/*
> +		 * The fdset has at least one component obtained with vmalloc.
> +		 * Hence, we will handle deallocation from the workqueue
> +		 * context. If we are unable to schedule the work, then we set
> +		 * a timer to fire and reattempt to schedule later.
> +		 */
>  		fddef = &get_cpu_var(fdtable_defer_list);
>  		spin_lock(&fddef->lock);
>  		fdt->next = fddef->next;
>  		fddef->next = fdt;
> -		/*
> -		 * vmallocs are handled from the workqueue context.
> -		 * If the per-cpu workqueue is running, then we
> -		 * defer work scheduling through a timer.
> -		 */
>  		if (!schedule_work(&fddef->wq))
>  			mod_timer(&fddef->timer, 5);
>  		spin_unlock(&fddef->lock);
> @@ -147,197 +177,179 @@ void free_fdtable_rcu(struct rcu_head *r
>  	}
>  }
>  
> -/*
> - * Expand the fdset in the files_struct.  Called with the files spinlock
> - * held for write.
> +/**
> + * copy_fdtable - Copy fdtable data.
> + * @nfdt: New fdtable to copy data to.
> + * @ofdt: Old fdtable to copy data from.
> + *
> + * Copy fdarray and fdset data from the old fdtable to the new fdtable. If 
> the
> + * new fdtable supports more file entries, then the extra high-order data 
> will
> + * be zeroed. The file_lock related to ofdt must be held for write.
>   */
> -static void copy_fdtable(struct fdtable *nfdt, struct fdtable *fdt)
> +static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
>  {
> -	int i;
> -	int count;
> -
> -	BUG_ON(nfdt->max_fds < fdt->max_fds);
> -	/* Copy the existing tables and install the new pointers */
> -
> -	i = fdt->max_fds / (sizeof(unsigned long) * 8);
> -	count = (nfdt->max_fds - fdt->max_fds) / 8;
> +	unsigned int cpy, set;
>  
> +	BUG_ON(nfdt->max_fds < ofdt->max_fds);
>  	/*
> -	 * Don't copy the entire array if the current fdset is
> -	 * not yet initialised.
> +	 * Don't copy or clear the data if we are creating a new fdtable for
> +	 * fork().
>  	 */
> -	if (i) {
> -		memcpy (nfdt->open_fds, fdt->open_fds,
> -						fdt->max_fds/8);
> -		memcpy (nfdt->close_on_exec, fdt->close_on_exec,
> -						fdt->max_fds/8);
> -		memset (&nfdt->open_fds->fds_bits[i], 0, count);
> -		memset (&nfdt->close_on_exec->fds_bits[i], 0, count);
> -	}
> -
> -	/* Don't copy/clear the array if we are creating a new
> -	   fd array for fork() */
> -	if (fdt->max_fds) {
> -		memcpy(nfdt->fd, fdt->fd,
> -			fdt->max_fds * sizeof(struct file *));
> -		/* clear the remainder of the array */
> -		memset(&nfdt->fd[fdt->max_fds], 0,
> -		       (nfdt->max_fds - fdt->max_fds) *
> -					sizeof(struct file *));
> -	}
> -}
> -
> -/*
> - * Allocate an fdset array, using kmalloc or vmalloc.
> - * Note: the array isn't cleared at allocation time.
> - */
> -fd_set * alloc_fdset(int num)
> -{
> -	fd_set *new_fdset;
> -	int size = num / 8;
> -
> -	if (size <= PAGE_SIZE)
> -		new_fdset = (fd_set *) kmalloc(size, GFP_KERNEL);
> -	else
> -		new_fdset = (fd_set *) vmalloc(size);
> -	return new_fdset;
> -}
> -
> -void free_fdset(fd_set *array, int num)
> -{
> -	if (num <= NR_OPEN_DEFAULT) /* Don't free an embedded fdset */
> +	if (ofdt->max_fds == 0)
>  		return;
> -	else if (num <= 8 * PAGE_SIZE)
> -		kfree(array);
> -	else
> -		vfree(array);
> -}
>  
> -static struct fdtable *alloc_fdtable(int nr)
> +	/* Initialize the new fdarray. */
> +	cpy = ofdt->max_fds * sizeof(struct file *);
> +	set = (nfdt->max_fds - ofdt->max_fds) * sizeof(struct file *);
> +	memcpy(nfdt->fd, ofdt->fd, cpy);
> +	memset((char *)(nfdt->fd) + cpy, 0, set);
> +
> +	/* Initialize the new fdsets. */
> +	cpy = ofdt->max_fds / BITS_PER_BYTE;
> +	set = (nfdt->max_fds - ofdt->max_fds) / BITS_PER_BYTE;
> +	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
> +	memset((char *)(nfdt->open_fds) + cpy, 0, set);
> +	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
> +	memset((char *)(nfdt->close_on_exec) + cpy, 0, set);
> +}
> +
> +/**
> + * alloc_fdtable - Allocate an appropriately-sized fdtable.
> + * @nr: Requested fd index to be supported.
> + *
> + * Allocate and initialize a new fdtable. The fdtable must be able to support
> + * the requested file descriptor nr within its internal data structures.
> + *
> + * On success, the newly-created fdtable is returned. On allocation failure,
> + * NULL is returned.
> + */
> +static struct fdtable * alloc_fdtable(unsigned int nr)
>  {
> -	struct fdtable *fdt = NULL;
> -	int nfds = 0;
> -  	fd_set *new_openset = NULL, *new_execset = NULL;
> -	struct file **new_fds;
> -
> -	fdt = kzalloc(sizeof(*fdt), GFP_KERNEL);
> -	if (!fdt)
> -  		goto out;
> +	struct fdtable *fdt;
> +	char *data;
>  
> -	nfds = NR_OPEN_DEFAULT;
>  	/*
> -	 * Expand to the max in easy steps, and keep expanding it until
> -	 * we have enough for the requested fd array size.
> +	 * Figure out how many fds we actually want to support in this fdtable.
> +	 * Allocation steps are keyed to the size of the fdarray, since it
> +	 * grows far faster than any of the other dynamic data. We try to fit
> +	 * the fdarray into page-sized chunks: starting at a quarter of a page;
> +	 * growing exponentially at first and linearly once the page boundary
> +	 * is surpassed.
>  	 */
> -	do {
> -#if NR_OPEN_DEFAULT < 256
> -		if (nfds < 256)
> -			nfds = 256;
> -		else
> -#endif
> -		if (nfds < (PAGE_SIZE / sizeof(struct file *)))
> -			nfds = PAGE_SIZE / sizeof(struct file *);
> -		else {
> -			nfds = nfds * 2;
> -			if (nfds > NR_OPEN)
> -				nfds = NR_OPEN;
> -  		}
> -	} while (nfds <= nr);
> -
> -  	new_openset = alloc_fdset(nfds);
> -  	new_execset = alloc_fdset(nfds);
> -  	if (!new_openset || !new_execset)
> -  		goto out;
> -	fdt->open_fds = new_openset;
> -	fdt->close_on_exec = new_execset;
> +	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
> +	if (nr > 1)
> +		nr |= 3;
> +	nr++;
> +	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
>  
> -	new_fds = alloc_fd_array(nfds);
> -	if (!new_fds)
> +	/* Create the fdtable itself. */
> +	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL);
> +	if (!fdt)
>  		goto out;
> -	fdt->fd = new_fds;
> -	fdt->max_fds = nfds;
> +	fdt->max_fds = nr;
> +	/* Allocate space for the fdarray. */
> +	data = alloc_fdmem(nr * sizeof(struct file *));
> +	if (!data)
> +		goto out_fdt;
> +	fdt->fd = (struct file **)data;
> +	/* Allocate space for both fdsets together - open_fds is the base. */
> +	data = alloc_fdmem(2 * nr / BITS_PER_BYTE);
> +	if (!data)
> +		goto out_arr;
> +	fdt->open_fds = (fd_set *)data;
> +	data += nr / BITS_PER_BYTE;
> +	fdt->close_on_exec = (fd_set *)data;
> +	/* Initialize the rest of the fdtable. */
> +	INIT_RCU_HEAD(&fdt->rcu);
> +	fdt->next = NULL;
> +
>  	return fdt;
> -out:
> -	free_fdset(new_openset, nfds);
> -	free_fdset(new_execset, nfds);
> +
> +out_arr:
> +	free_fdarr(fdt);
> +out_fdt:
>  	kfree(fdt);
> +out:
>  	return NULL;
>  }
>  
> -/*
> - * Expand the file descriptor table.
> - * This function will allocate a new fdtable and both fd array and fdset, of
> - * the given size.
> - * Return <0 error code on error; 1 on successful completion.
> - * The files->file_lock should be held on entry, and will be held on exit.
> +/**
> + * expand_files - Accommodate an fd index inside a files structure.
> + * @files: The files structure that must be sized.
> + * @nr: Requested fd index to be supported.
> + *
> + * Make sure that the given files structure can accommodate the provided fd
> + * index within its associated fdtable. If the requested index exceeds the
> + * current capacity and there is room for expansion, a larger fdtable will be
> + * created and installed. The files->file_lock should be held on entry, and
> + * will be held on exit.
> + *
> + * If the current fdtable is sufficient, 0 is returned. If the fdtable was
> + * expanded and execution may have blocked, 1 is returned. On an error
> + * condition, a negative error code is returned.
>   */
> -static int expand_fdtable(struct files_struct *files, int nr)
> +int expand_files(struct files_struct *files, int nr)
>  	__releases(files->file_lock)
>  	__acquires(files->file_lock)
>  {
> -	struct fdtable *new_fdt, *cur_fdt;
> +	struct fdtable *cur_fdt, *new_fdt;
> +
> +	cur_fdt = files_fdtable(files);
> +	/* Do we need to expand? */
> +	if (nr < cur_fdt->max_fds)
> +		return 0;
> +	/* Are we allowed to expand? */
> +	if (nr >= NR_OPEN)
> +		return -EMFILE;
>  
> +	/* Allocate a larger fdtable outside the lock. */
>  	spin_unlock(&files->file_lock);
>  	new_fdt = alloc_fdtable(nr);
>  	spin_lock(&files->file_lock);
>  	if (!new_fdt)
>  		return -ENOMEM;
> +	cur_fdt = files_fdtable(files);
>  	/*
> -	 * Check again since another task may have expanded the fd table while
> -	 * we dropped the lock
> +	 * Check the sizes again since another task may have expanded the
> +	 * fdtable while we dropped the lock.
>  	 */
> -	cur_fdt = files_fdtable(files);
> -	if (nr >= cur_fdt->max_fds) {
> -		/* Continue as planned */
> +	if (nr < cur_fdt->max_fds) {
> +		/* Somebody else expanded, so undo our allocation attempt. */
> +		free_fdarr(new_fdt);
> +		free_fdset(new_fdt);
> +		kfree(new_fdt);
> +	} else {
> +		/* All good. Install the new fdtable and retire the old one. */
>  		copy_fdtable(new_fdt, cur_fdt);
>  		rcu_assign_pointer(files->fdt, new_fdt);
>  		if (cur_fdt->max_fds > NR_OPEN_DEFAULT)
>  			call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
> -	} else {
> -		/* Somebody else expanded, so undo our attempt */
> -		__free_fdtable(new_fdt);
>  	}
>  	return 1;
>  }
>  
> -/*
> - * Expand files.
> - * This function will expand the file structures, if the requested size 
> exceeds
> - * the current capacity and there is room for expansion.
> - * Return <0 error code on error; 0 when nothing done; 1 when files were
> - * expanded and execution may have blocked.
> - * The files->file_lock should be held on entry, and will be held on exit.
> +/**
> + * fdtable_defer_list_init - Initialize the per-cpu fdtable defer list.
> + * @cpu: The cpu for which the defer list should be initialized.
>   */
> -int expand_files(struct files_struct *files, int nr)
> -{
> -	struct fdtable *fdt;
> -
> -	fdt = files_fdtable(files);
> -	/* Do we need to expand? */
> -	if (nr < fdt->max_fds)
> -		return 0;
> -	/* Can we expand? */
> -	if (nr >= NR_OPEN)
> -		return -EMFILE;
> -
> -	/* All good, so we try */
> -	return expand_fdtable(files, nr);
> -}
> -
>  static void __devinit fdtable_defer_list_init(int cpu)
>  {
> -	struct fdtable_defer *fddef = &per_cpu(fdtable_defer_list, cpu);
> +	struct fdtable_defer *fddef;
> +
> +	fddef = &per_cpu(fdtable_defer_list, cpu);
>  	spin_lock_init(&fddef->lock);
>  	INIT_WORK(&fddef->wq, (void (*)(void *))free_fdtable_work, fddef);
> -	init_timer(&fddef->timer);
> -	fddef->timer.data = (unsigned long)fddef;
> -	fddef->timer.function = fdtable_timer;
> +	setup_timer(&fddef->timer, fdtable_timer, (unsigned long)fddef);
>  	fddef->next = NULL;
>  }
>  
> +/**
> + * files_defer_init - Initialize the fdtable defer lists.
> + */
>  void __init files_defer_init(void)
>  {
>  	int i;
> +
>  	for_each_possible_cpu(i)
>  		fdtable_defer_list_init(i);
>  }
> diff -Npru old/include/linux/file.h new/include/linux/file.h
> --- old/include/linux/file.h	2006-09-28 20:13:13.000000000 -0700
> +++ new/include/linux/file.h	2006-09-28 20:22:05.000000000 -0700
> @@ -29,8 +29,8 @@ struct embedded_fd_set {
>  struct fdtable {
>  	unsigned int max_fds;
>  	struct file ** fd;      /* current fd array */
> -	fd_set *close_on_exec;
>  	fd_set *open_fds;
> +	fd_set *close_on_exec;
>  	struct rcu_head rcu;
>  	struct fdtable *next;
>  };
> @@ -74,12 +74,6 @@ extern int get_unused_fd(void);
>  extern void FASTCALL(put_unused_fd(unsigned int fd));
>  struct kmem_cache;
>  
> -extern struct file ** alloc_fd_array(int);
