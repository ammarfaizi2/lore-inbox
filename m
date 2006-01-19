Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWASFXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWASFXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWASFXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:23:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161108AbWASFXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:23:22 -0500
Date: Wed, 18 Jan 2006 21:22:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: david singleton <dsingleton@mvista.com>
Cc: drepper@gmail.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [robust-futex-4] futex: robust futex support
Message-Id: <20060118212256.1553b0ec.akpm@osdl.org>
In-Reply-To: <F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com>
References: <43C84D4B.70407@mvista.com>
	<a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
	<746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
	<a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
	<C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
	<a36005b50601170950u307ffb9dl52dc3655a1b90fa6@mail.gmail.com>
	<F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david singleton <dsingleton@mvista.com> wrote:
>
> [-ENOCHANGELOG]
> 

> @@ -383,6 +384,7 @@ struct address_space {
>  	spinlock_t		private_lock;	/* for use by the address_space */
>  	struct list_head	private_list;	/* ditto */
>  	struct address_space	*assoc_mapping;	/* ditto */
> +	struct futex_head	*robust_head;	/* list of robust futexes */
>  } __attribute__((aligned(sizeof(long))));

It's worth putting this field inside CONFIG_ROBUST_FUTEX

> +#else
> +# define futex_free_robust_list(a)      do { } while (0)
> +# define exit_futex(b)                  do { } while (0)
> +#define futex_init_inode(a) 		do { } while (0)
> +#endif

Indenting went wonky.

> +/*
> + * Robust futexes provide a locking mechanism that can be shared between
> + * user mode processes. The major difference between robust futexes and
> + * regular futexes is that when the owner of a robust futex dies, the
> + * next task waiting on the futex will be awakened, will get ownership
> + * of the futex lock, and will receive the error status EOWNERDEAD.
> + *
> + * A robust futex is a 32 bit integer stored in user mode shared memory.
> + * Bit 31 indicates that there are tasks waiting on the futex.
> + * Bit 30 indicates that the task that owned the futex has died.
> + * Bit 29 indicates that the futex is not recoverable and cannot be used.
> + * Bits 0-28 are the pid of the task that owns the futex lock, or zero if
> + * the futex is not locked.
> + */

Nice comment!

> +/**
> + * futex_free_robust_list - release the list of registered futexes.
> + * @inode: inode that may be a memory mapped file
> + *
> + * Called from dput() when a dentry reference count reaches zero.
> + * If the dentry is associated with a memory mapped file, then
> + * release the list of registered robust futexes that are contained
> + * in that mapping.
> + */
> +void futex_free_robust_list(struct inode *inode)
> +{
> +	struct address_space *mapping;
> +	struct list_head *head;
> + 	struct futex_robust *this, *next;
> +	struct futex_head *futex_head = NULL;
> +
> +	if (inode == NULL)
> +		return;

Is this test needed?

This function is called when a dentry's refcount falls to zero.  But there
could be other refs to this inode which might get upset at having their
robust futexes thrown away.  Shouldn't this be based on inode destruction
rather than dentry?

> +	mapping = inode->i_mapping;
> +	if (mapping == NULL)
> +		return;

inodes never have a null ->i_mapping

> +	if (mapping->robust_head == NULL)
> +		return;
> +
> +	if (list_empty(&mapping->robust_head->robust_list))
> +		return;
> +
> +	mutex_lock(&mapping->robust_head->robust_mutex);
> +
> +	head = &mapping->robust_head->robust_list;
> +	futex_head = mapping->robust_head;
> +
> +	list_for_each_entry_safe(this, next, head, list) {
> +		list_del(&this->list);
> +		kmem_cache_free(robust_futex_cachep, this);
> +	}

If we're throwing away the entire contents of the list, there's no need to
detach items as we go.

> +/**
> + * get_shared_uaddr - convert a shared futex_key to a user addr.
> + * @key: a futex_key that identifies a futex.
> + * @vma: a vma that may contain the futex
> + *
> + * Shared futex_keys identify a futex that is contained in a vma,
> + * and so may be shared.
> + * Returns zero if futex is not contained in @vma
> + */
> +static unsigned long get_shared_uaddr(union futex_key *key,
> +				      struct vm_area_struct *vma)
> +{
> +	unsigned long uaddr = 0;
> +	unsigned long tmpaddr;
> +	struct address_space *mapping;
> +
> +	mapping = vma->vm_file->f_mapping;
> +	if (key->shared.inode == mapping->host) {
> +		tmpaddr = ((key->shared.pgoff - vma->vm_pgoff) << PAGE_SHIFT)
> +				+ (key->shared.offset & ~0x1)
> +				+ vma->vm_start;
> +		if (tmpaddr >= vma->vm_start && tmpaddr < vma->vm_end)
> +			uaddr = tmpaddr;
> +	}
> +
> +	return uaddr;
> +}

What locking guarantees that vma->vm_file->f_mapping continues to exist? 
Bear in mind that another thread which shares this thread's files can close
fds, unlink files, munmap files, etc.

> +/**
> + * find_owned_futex - find futexes owned by the current task
> + * @tsk: task that is exiting
> + * @vma: vma containing robust futexes
> + * @head: list head for list of robust futexes
> + * @mutex: mutex that protects the list
> + *
> + * Walk the list of registered robust futexes for this @vma,
> + * setting the %FUTEX_OWNER_DIED flag on those futexes owned
> + * by the current, exiting task.
> + */
> +static void
> +find_owned_futex(struct task_struct *tsk, struct vm_area_struct *vma,
> +		 struct list_head *head, struct mutex *mutex)
> +{
> +	struct futex_robust *this, *next;
> + 	unsigned long uaddr;
> +	int value;
> +
> +	mutex_lock(mutex);
> +
> +	list_for_each_entry_safe(this, next, head, list) {
> +
> +		uaddr = get_futex_uaddr(&this->key, vma);
> +		if (uaddr == 0)
> +			continue;
> +
> +		mutex_unlock(mutex);
> +		up_read(&tsk->mm->mmap_sem);
> +		get_user(value, (int __user *)uaddr);
> +		if ((value & FUTEX_PID) == tsk->pid) {
> +			value |= FUTEX_OWNER_DIED;
> +			futex_wake(uaddr, 1);
> +			put_user(value, (int *__user)uaddr);

That's a bit unconventional - normally we'd perform the other-task-visible
write and _then_ wake up the other task.  What prevents the woken task from
waking then seeing the not-yet-written-to value?

> +void exit_futex(struct task_struct *tsk)
> +{
> +	struct mm_struct *mm;
> +	struct list_head *robust;
> +	struct vm_area_struct *vma;
> +	struct mutex *mutex;
> +
> +	mm = current->mm;
> +	if (mm==NULL)
> +		return;
> +
> +	down_read(&mm->mmap_sem);
> +
> +	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
> +		if (vma->vm_file == NULL)
> +			continue;
> +
> +		if (vma->vm_file->f_mapping == NULL)
> +			continue;
> +
> +		if (vma->vm_file->f_mapping->robust_head == NULL)
> +			continue;
> +
> +		robust = &vma->vm_file->f_mapping->robust_head->robust_list;
> +
> +		if (list_empty(robust))
> +			continue;
> +
> +		mutex = &vma->vm_file->f_mapping->robust_head->robust_mutex;
> +
> +		find_owned_futex(tsk, vma, robust, mutex);

The name "find_owned_mutex" is a bit misleading - it implies that it is
some lookup function which has no side-effects.  But find_owned_futex()
actually makes significant state changes.

> +
> +	if (vma->vm_file && vma->vm_file->f_mapping) {
> +		if (vma->vm_file->f_mapping->robust_head == NULL)
> +			init_robust_list(vma->vm_file->f_mapping, file_futex);
> +		else
> +			kmem_cache_free(file_futex_cachep, file_futex);
> +		head = &vma->vm_file->f_mapping->robust_head->robust_list;
> +		mutex = &vma->vm_file->f_mapping->robust_head->robust_mutex;

The patch in general does an awful lot of these lengthy pointer chases. 
It's more readable to create temporaries to avoid this.  Sometimes it
generates better code, too.

The kmem_cache_free above is a bit sad.  It means that in the common case
we'll allocate a file_futex and then free it again.  It's legal to do
GFP_KERNEL allocations within mmap_sem, so I suggest you switch this to
allocate-only-if-needed.

> +	} else {
> +		ret = -EADDRNOTAVAIL;
> +		kmem_cache_free(robust_futex_cachep, robust);
> +		kmem_cache_free(file_futex_cachep, file_futex);
> +		goto out_unlock;
> +	}

Again, we could have checked whether we needed to allocate these before
allocating them.

> +	if (vma->vm_file && vma->vm_file->f_mapping &&
> +	    vma->vm_file->f_mapping->robust_head) {
> +		mutex = &vma->vm_file->f_mapping->robust_head->robust_mutex;
> +		head = &vma->vm_file->f_mapping->robust_head->robust_list;

Pointer chasing, again...

> +
> +	list_for_each_entry_safe(this, next, head, list) {
> +		if (match_futex (&this->key, &key)) {
                               ^
                                A stray space got in there.

>  
> +#ifdef CONFIG_ROBUST_FUTEX
> +	robust_futex_cachep = kmem_cache_create("robust_futex", sizeof(struct futex_robust), 0, 0, NULL, NULL);
> +	file_futex_cachep = kmem_cache_create("file_futex", sizeof(struct futex_head), 0, 0, NULL, NULL);
> +#endif

A bit of 80-column wrapping needed there please.

Are futex_heads likely to be allocated in sufficient volume to justify
their own slab cache, rather than using kmalloc()?  The speed is the same -
if anything, kmalloc() will be faster because its text and data are more
likely to be in CPU cache.

