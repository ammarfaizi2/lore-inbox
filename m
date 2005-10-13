Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVJMJ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVJMJ61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJMJ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 05:58:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbVJMJ60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 05:58:26 -0400
Date: Thu, 13 Oct 2005 02:58:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Janak Desai <janak@us.ibm.com>
Cc: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
Message-ID: <20051013095819.GM5856@shell0.pdx.osdl.net>
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Janak Desai (janak@us.ibm.com) wrote:
> diff -Naurp 2.6.14-rc2-mm2/fs/namespace.c 2.6.14-rc2-mm2+unshare/fs/namespace.c
> --- 2.6.14-rc2-mm2/fs/namespace.c	2005-10-12 02:56:08.000000000 +0000
> +++ 2.6.14-rc2-mm2+unshare/fs/namespace.c	2005-10-12 11:46:52.000000000 +0000
> @@ -1069,9 +1069,6 @@ int copy_namespace(int flags, struct tas
>  {
>  	struct namespace *namespace = tsk->namespace;
>  	struct namespace *new_ns;
> -	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
> -	struct fs_struct *fs = tsk->fs;
> -	struct vfsmount *p, *q;
>  
>  	if (!namespace)
>  		return 0;
> @@ -1086,6 +1083,28 @@ int copy_namespace(int flags, struct tas
>  		return -EPERM;
>  	}
>  
> +	new_ns = dup_namespace_struct(tsk);

How about just dup_namespace()?

> +	if (!new_ns)
> +		goto out;
> +
> +	tsk->namespace = new_ns;
> +
> +	put_namespace(namespace);
> +	return 0;
> +
> +out:
> +	put_namespace(namespace);
> +	return -ENOMEM;

If you 'return err', then you could use single return there.

> +}
> +
> +struct namespace *dup_namespace_struct(struct task_struct *tsk)
> +{
> +	struct namespace *namespace = tsk->namespace;
> +	struct namespace *new_ns;
> +	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
> +	struct fs_struct *fs = tsk->fs;
> +	struct vfsmount *p, *q;
> +
>  	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
>  	if (!new_ns)
>  		goto out;
> @@ -1134,8 +1153,6 @@ int copy_namespace(int flags, struct tas
>  	}
>  	up_write(&tsk->namespace->sem);
>  
> -	tsk->namespace = new_ns;
> -
>  	if (rootmnt)
>  		mntput(rootmnt);
>  	if (pwdmnt)
> @@ -1143,12 +1160,10 @@ int copy_namespace(int flags, struct tas
>  	if (altrootmnt)
>  		mntput(altrootmnt);
>  
> -	put_namespace(namespace);
> -	return 0;
> +	return new_ns;
>  
>  out:
> -	put_namespace(namespace);
> -	return -ENOMEM;
> +	return NULL;

Same here, just return new_ns.

>  }
>  
>  asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
> diff -Naurp 2.6.14-rc2-mm2/include/linux/namespace.h 2.6.14-rc2-mm2+unshare/include/linux/namespace.h
> --- 2.6.14-rc2-mm2/include/linux/namespace.h	2005-10-12 02:56:35.000000000 +0000
> +++ 2.6.14-rc2-mm2+unshare/include/linux/namespace.h	2005-10-12 11:45:46.000000000 +0000
> @@ -14,6 +14,7 @@ struct namespace {
>  
>  extern int copy_namespace(int, struct task_struct *);
>  extern void __put_namespace(struct namespace *namespace);
> +extern struct namespace *dup_namespace_struct(struct task_struct *);
>  
>  static inline void put_namespace(struct namespace *namespace)
>  {
> diff -Naurp 2.6.14-rc2-mm2/kernel/fork.c 2.6.14-rc2-mm2+unshare/kernel/fork.c
> --- 2.6.14-rc2-mm2/kernel/fork.c	2005-10-12 02:56:39.000000000 +0000
> +++ 2.6.14-rc2-mm2+unshare/kernel/fork.c	2005-10-12 13:26:05.000000000 +0000
> @@ -448,6 +448,55 @@ void mm_release(struct task_struct *tsk,
>  	}
>  }
>  
> +/*
> + * Allocate a new mm structure and copy contents from the
> + * mm structure of the passed in task structure.
> + */
> +static struct mm_struct *dup_mm_struct(struct task_struct *tsk)

How about dup_mm()?

> +{
> +	struct mm_struct *mm, *oldmm = current->mm;
> +	int err;
> +
> +	if (!oldmm)
> +		return NULL;
> +
> +	mm = allocate_mm();
> +	if (!mm)
> +		goto fail_nomem;
> +
> +	memcpy(mm, oldmm, sizeof(*mm));
> +
> +	if (!mm_init(mm))
> +		goto fail_nomem;
> +
> +	if (init_new_context(tsk, mm))
> +		goto fail_nocontext;
> +
> +	err = dup_mmap(mm, oldmm);
> +	if (err)
> +		goto free_pt;
> +
> +	mm->hiwater_rss = get_mm_rss(mm);
> +	mm->hiwater_vm = mm->total_vm;
> +
> +	return mm;
> +
> +free_pt:
> +	mmput(mm);
> +
> +fail_nomem:
> +	return NULL;
> +
> +fail_nocontext:
> +	/*
> +	 * If init_new_context() failed, we cannot use mmput() to free the mm
> +	 * because it calls destroy_context()
> +	 */
> +	mm_free_pgd(mm);
> +	free_mm(mm);
> +	return NULL;
> +}
> +
>  static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
>  {
>  	struct mm_struct * mm, *oldmm;
> @@ -482,43 +531,17 @@ static int copy_mm(unsigned long clone_f
>  	}
>  
>  	retval = -ENOMEM;
> -	mm = allocate_mm();
> +	mm = dup_mm_struct(tsk);
>  	if (!mm)
>  		goto fail_nomem;
>  
> -	/* Copy the current MM stuff.. */
> -	memcpy(mm, oldmm, sizeof(*mm));
> -	if (!mm_init(mm))
> -		goto fail_nomem;
> -
> -	if (init_new_context(tsk,mm))
> -		goto fail_nocontext;
> -
> -	retval = dup_mmap(mm, oldmm);
> -	if (retval)
> -		goto free_pt;
> -
> -	mm->hiwater_rss = get_mm_rss(mm);
> -	mm->hiwater_vm = mm->total_vm;
> -
>  good_mm:
>  	tsk->mm = mm;
>  	tsk->active_mm = mm;
>  	return 0;
>  
> -free_pt:
> -	mmput(mm);
>  fail_nomem:
>  	return retval;
> -
> -fail_nocontext:
> -	/*
> -	 * If init_new_context() failed, we cannot use mmput() to free the mm
> -	 * because it calls destroy_context()
> -	 */
> -	mm_free_pgd(mm);
> -	free_mm(mm);
> -	return retval;
>  }
>  
>  static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
> @@ -753,6 +776,23 @@ int unshare_files(void)
>  
>  EXPORT_SYMBOL(unshare_files);
>  
> +/*
> + * Allocate a new sighand structure and copy contents from the
> + * sighand of the passed in task structure
> + */
> +static struct sighand_struct *dup_sh_struct(struct task_struct *tsk)

dup_sighand is more expressive name.

> +{
> +	struct sighand_struct *sh;
> +
> +	sh = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
> +	if (!sh)
> +		return NULL;
> +	spin_lock_init(&sh->siglock);
> +	atomic_set(&sh->count, 1);
> +	memcpy(sh->action, current->sighand->action, sizeof(sh->action));
> +	return sh;
> +}
> +
>  static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
>  {
>  	struct sighand_struct *sig;
> @@ -761,13 +801,10 @@ static inline int copy_sighand(unsigned 
>  		atomic_inc(&current->sighand->count);
>  		return 0;
>  	}
> -	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
> +	sig = dup_sh_struct(tsk);
>  	tsk->sighand = sig;
>  	if (!sig)
>  		return -ENOMEM;
> -	spin_lock_init(&sig->siglock);
> -	atomic_set(&sig->count, 1);
> -	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
>  	return 0;
>  }
>  
> @@ -1321,3 +1358,164 @@ void __init proc_caches_init(void)
>  			sizeof(struct mm_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>  }
> +
> +/*
> + * Performs sanity checks on the flags passed to the unshare system
> + * call.
> + */
> +static inline int check_unshare_flags(unsigned long unshare_flags)
> +{
> +	int err = -EINVAL;
> +
> +	if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM | CLONE_SIGHAND))
> +		goto errout;
> +
> +	/*
> +	 * Shared signal handlers imply shared VM, so if CLONE_SIGHAND is
> +	 * set, CLONE_VM must also be set in the system call argument.
> +	 */
> +	if ((unshare_flags & CLONE_SIGHAND) && !(unshare_flags & CLONE_VM))
> +		goto errout;

Oops, this test is backwards.

> +	/*
> +	 * Cannot unshare namespace if the fs structure is being shared
> +	 * through a previous call to clone()
> +	 */
> +	if ((unshare_flags & CLONE_NEWNS) &&
> +	    (atomic_read(&current->fs->count) > 1))
> +		goto errout;
> +
> +	if (unshare_flags & CLONE_VM) {
> +		/*
> +	 	 * Cannot unshare vm if the signal structure is being shared
> +	 	 * through a previous call to clone() with CLONE_THREAD.
> +	 	 */
> +	    	if (atomic_read(&current->signal->count) > 1)
> +			goto errout;
> +
> +		/*
> +		 * Cannot unshare vm only if the sighand structure is being
> +		 * shared through a previous call to clone()
> +		 */
> +		if (!(unshare_flags & CLONE_SIGHAND) &&
> +		     (atomic_read(&current->sighand->count) > 1))

And it's really just this case that's the issue.

> +			goto errout;
> +
> +		/*
> +		 * If the task is performing async io, unsharing of vm will
> +		 * only allow the parent task, with which the vm was being
> +		 * shared, to continue async io operations. The async io
> +		 * context is not copied to the new, unshared, copy of vm.
> +		 * So don't allow unsharing of vm if the process is setup
> +		 * to perform async io.
> +		 */
> +		if (current->mm->ioctx_list)
> +			goto errout;

This is likely overkill.  The scenario I was woried about was a single
task that manages to unshare itself (easy with concurrent read of /proc
entry).  I was concerned it had possibility to cause some trouble
when mmdrop happened while ctx_id was still valid mapping in new mm.
But the dup will zero the ioctx_list, exit_aio will have been called,
so I think it's no different than setting up aio and then calling exit(2).
Not very useful, but looks harmless.

> +	}
> +	return 0;
> +
> +errout:
> +	return err;
> +
> +}
> +
> +/*
> + * unshare allows a process to 'unshare' part of the process
> + * context which was originally shared using clone.  copy_*
> + * functions used by do_fork() cannot be used here directly
> + * because they modify an inactive task_struct that is being
> + * constructed. Here we are modifying the current, active,
> + * task_struct.
> + */
> +asmlinkage long sys_unshare(unsigned long unshare_flags)
> +{
> +	int err = 0, unshare_ns = 0, unshare_mm = 0, unshare_sh = 0;
> +	struct namespace *new_ns = NULL, *ns = current->namespace;
> +	struct mm_struct *new_mm = NULL, *active_mm = NULL, *mm = current->mm;
> +	struct sighand_struct *new_sh = NULL, *sh = current->sighand;

Aren't these flags unnecessary?

!unshare_ns == !new_ns, !unshare_mm == !new_mm, !unshare_sh == !new_sh

> +
> +	err = check_unshare_flags(unshare_flags);
> +	if (err)
> +		goto unshare_out;
> +
> +	if (unshare_flags & CLONE_NEWNS) {
> +		if (ns && atomic_read(&ns->count) > 1) {
> +			err = -EPERM;
> +			if (!capable(CAP_SYS_ADMIN))
> +				goto unshare_out;
> +
> +			err = -ENOMEM;
> +			new_ns = dup_namespace_struct(current);
> +			if (!new_ns)
> +				goto unshare_out;
> +			else
> +				unshare_ns = 1;

drop else

> +		}
> +	}
> +
> +	if (unshare_flags & CLONE_VM) {
> +		if (atomic_read(&mm->mm_users) > 1) {

Save some tabs...

	if ((unshare_flags & CLONE_VM) && atomic_read(&mm->mm_users) > 1)

> +			err = -ENOMEM;
> +			new_mm = dup_mm_struct(current);
> +			if (!new_mm)
> +				goto unshare_cleanup_ns;
> +			else {

drop else

> +				unshare_mm = 1;
> +				if (unshare_flags & CLONE_SIGHAND) {
> +					if (atomic_read(&sh->count) > 1) {

Save some more tabs.  Another compound conditional.  Actually you can't
do unshare VM w/out unsharing sighand, so only checking for sighand->count
matters.

> +						new_sh = dup_sh_struct(current);
> +						if (!new_sh)
> +							goto unshare_cleanup_mm;
> +						else
> +							unshare_sh = 1;

drop else

> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	if (unshare_ns) {
> +		task_lock(current);
> +		current->namespace = new_ns;
> +		task_unlock(current);
> +		put_namespace(ns);
> +	}

Typically it makes locking simpler to take and release lock once.
Something like:

  task_lock(current);
  if (new_ns)
	current->namspace = new_ns;
  if (new_mm) {
	current->mm = new_mm;
	...
  }
  task_unlock(current);

But the put_namespace and mmput make it ugly either way.

> +
> +	if (unshare_mm) {
> +		task_lock(current);
> +		current->min_flt = current->maj_flt = 0;
> +		current->nvcsw = current->nivcsw = 0;

I don't think we need to reset these statistics, it's not a new task.

> +		active_mm = current->active_mm;
> +		current->mm = new_mm;
> +		current->active_mm = new_mm;
> +		activate_mm(active_mm, new_mm);
> +		task_unlock(current);
> +		mmput(mm);
> +	}
> +
> +	if (unshare_sh) {
> +		write_lock_irq(&tasklist_lock);
> +		spin_lock(&sh->siglock);
> +		spin_lock(&new_sh->siglock);
> +		current->sighand = new_sh;
> +		spin_unlock(&new_sh->siglock);
> +		spin_unlock(&sh->siglock);
> +		write_unlock_irq(&tasklist_lock);
> +
> +		if (atomic_dec_and_test(&sh->count))
> +			kmem_cache_free(sighand_cachep, sh);

Should have a helper.  Also, this looks like trouble.  I believe this
could cause an oops because sighand count is used more like thread count
than refcount.

> +	}
> +
> +	return 0;
> +
> +unshare_cleanup_mm:
> +	if (unshare_mm)
> +		mmput(new_mm);
> +
> +unshare_cleanup_ns:
> +	if (unshare_ns)
> +		put_namespace(new_ns);
> +
> +unshare_out:
> +	return err;
> +}
