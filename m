Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUG3Bwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUG3Bwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUG3Bwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 21:52:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:39078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264917AbUG3Bw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 21:52:26 -0400
Date: Thu, 29 Jul 2004 18:52:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, akpm@osdl.org,
       andrea@suse.de
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040729185215.Q1973@build.pdx.osdl.net>
References: <20040729100307.GA23571@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040729100307.GA23571@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, Jul 29, 2004 at 12:03:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> Compared to the previous revision of this patch; shm accounting has been
> changed to be per user struct, while keeping track of which user struct
> allocated the shm segment in the first place. This is done in order to avoid
> the security bug where one process/user could mlock and another munlock
> which would screw up the accounting.

I think this one still needs a bit of work.  Unless I'm mistaken, I see three
problems:

1) hugetlb accounting is not done. so it's only simple change to checking
permission, but the acutal usage is not tracked (gets back to problem
andrea pointed out).  with this patch, wouldn't !capable(CAP_IPC_LOCK)
&& rlim[RLIMIT_MEMLOCK].rlim_cur == 1 be enough to get all the hugepages
a user would want (i.e. security hole)?

2) mlock_user isn't ever set, so SHM_LOCK accounting looks broken
(trivial to fix).

3) now the RLIMIT_MEMLOCK value represents at best half of what a user
can acutally lock.  because half of the accounting (mlock) is done against
locked_vm, and the other half against locked_shm.  and as i mentioned
above, seems that hugetlb is unaccounted for.

I do agree, however, that storing in user struct allows for quota like
accounting that matches the shm_lock and hugetlb use cases.

> diff -purN linux-2.6.7/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
> --- linux-2.6.7/fs/hugetlbfs/inode.c	2004-07-29 11:36:55.744448953 +0200
> +++ linux/fs/hugetlbfs/inode.c	2004-07-29 11:38:04.292595263 +0200
> @@ -722,7 +722,7 @@ struct file *hugetlb_zero_setup(size_t s
>  	struct qstr quick_string;
>  	char buf[16];
>  
> -	if (!capable(CAP_IPC_LOCK))
> +	if (!can_do_mlock())
>  		return ERR_PTR(-EPERM);

Hrm, this looks stale, does it actually apply?

> +++ linux/include/linux/shm.h	2004-07-29 11:38:04.313592835 +0200
> @@ -84,6 +84,7 @@ struct shmid_kernel /* private to the ke
>  	time_t			shm_ctim;
>  	pid_t			shm_cprid;
>  	pid_t			shm_lprid;
> +	struct user_struct *	mlock_user;

This is never set to anything other than NULL.

> diff -purN linux-2.6.7/ipc/shm.c linux/ipc/shm.c
> --- linux-2.6.7/ipc/shm.c	2004-07-29 11:36:55.137517777 +0200
> +++ linux/ipc/shm.c	2004-07-29 11:38:04.313592835 +0200
> @@ -114,7 +114,7 @@ static void shm_destroy (struct shmid_ke
>  	shm_rmid (shp->id);
>  	shm_unlock(shp);
>  	if (!is_file_hugepages(shp->shm_file))
> -		shmem_lock(shp->shm_file, 0);
> +		shmem_lock(shp->shm_file, 0, shp->mlock_user);

So this is NULL.

>  	fput (shp->shm_file);
>  	security_shm_free(shp);
>  	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
> @@ -221,6 +221,7 @@ static int newseg (key_t key, int shmflg
>  	shp->shm_nattch = 0;
>  	shp->id = shm_buildid(id,shp->shm_perm.seq);
>  	shp->shm_file = file;
> +	shp->mlock_user = NULL;
>  	file->f_dentry->d_inode->i_ino = shp->id;
>  	if (shmflg & SHM_HUGETLB)
>  		set_file_hugepages(file);
> @@ -504,14 +505,11 @@ asmlinkage long sys_shmctl (int shmid, i
>  	case SHM_LOCK:
>  	case SHM_UNLOCK:
>  	{
> -/* Allow superuser to lock segment in memory */
> -/* Should the pages be faulted in here or leave it to user? */
> -/* need to determine interaction with current->swappable */
> -		if (!capable(CAP_IPC_LOCK)) {
> +		/* Allow superuser to lock segment in memory */
> +		if (!can_do_mlock()) {
>  			err = -EPERM;
>  			goto out;
>  		}
> -
>  		shp = shm_lock(shmid);
>  		if(shp==NULL) {
>  			err = -EINVAL;
> @@ -526,12 +524,14 @@ asmlinkage long sys_shmctl (int shmid, i
>  			goto out_unlock;
>  		
>  		if(cmd==SHM_LOCK) {
> -			if (!is_file_hugepages(shp->shm_file))
> -				shmem_lock(shp->shm_file, 1);
> -			shp->shm_flags |= SHM_LOCKED;
> +			if (!is_file_hugepages(shp->shm_file)) {
> +				err = shmem_lock(shp->shm_file, 1, current->user);
> +				if (!err)
> +					shp->shm_flags |= SHM_LOCKED;
> +			}
>  		} else {
>  			if (!is_file_hugepages(shp->shm_file))
> -				shmem_lock(shp->shm_file, 0);
> +				shmem_lock(shp->shm_file, 0, shp->mlock_user);

And this would be NULL.

>  			shp->shm_flags &= ~SHM_LOCKED;
>  		}
>  		shm_unlock(shp);
> diff -purN linux-2.6.7/ipc/util.c linux/ipc/util.c
> --- linux-2.6.7/ipc/util.c	2004-07-29 11:36:55.137517777 +0200
> +++ linux/ipc/util.c	2004-07-29 11:38:04.306593644 +0200
> @@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
>  		granted_mode >>= 3;
>  	/* is there some bit set in requested_mode but not in granted_mode? */
>  	if ((requested_mode & ~granted_mode & 0007) && 
> -	    !capable(CAP_IPC_OWNER))
> -		return -1;
> +	    !capable(CAP_IPC_OWNER)) {
> +		if (!can_do_mlock())  {

I don't quite see the need for this check for every ipc type.  Isn't the
SHM_LOCK case sufficient?

> +			return -1;
> +		}
> +	}	
>  
>  	return security_ipc_permission(ipcp, flag);
>  }

> diff -purN linux-2.6.7/mm/shmem.c linux/mm/shmem.c
> --- linux-2.6.7/mm/shmem.c	2004-07-29 11:36:55.640460745 +0200
> +++ linux/mm/shmem.c	2004-07-29 11:38:04.315592604 +0200
> @@ -1151,17 +1151,43 @@ shmem_get_policy(struct vm_area_struct *
>  }
>  #endif
>  
> -void shmem_lock(struct file *file, int lock)
> +/* Protects current->user->locked_shm from concurrent access */
> +static spinlock_t shmem_lock_user = SPIN_LOCK_UNLOCKED;
> +
> +int shmem_lock(struct file *file, int lock, struct user_struct * user)
>  {
>  	struct inode *inode = file->f_dentry->d_inode;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	unsigned long lock_limit, locked;
> +	int retval = -ENOMEM;
>  
>  	spin_lock(&info->lock);
> +	spin_lock(&shmem_lock_user);
> +	if (lock && !(info->flags & VM_LOCKED)) {
> +		locked = inode->i_size >> PAGE_SHIFT;
> +		locked += user->locked_shm;
> +		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
> +		lock_limit >>= PAGE_SHIFT;
> +		if ((locked > lock_limit) && !capable(CAP_IPC_LOCK))
> +			goto out_nomem;
> +		/* for this branch user == current->user so it won't go away under us */
> +		atomic_inc(&user->__count);
> +		user->locked_shm = locked;
> +	}
> +	if (!lock && (info->flags & VM_LOCKED) && user) {

So, I think this branch is never excercised because user will be NULL.

> +		locked = inode->i_size >> PAGE_SHIFT;
> +		user->locked_shm -= locked;
> +		free_uid(user);
> +	}
>  	if (lock)
>  		info->flags |= VM_LOCKED;
>  	else
>  		info->flags &= ~VM_LOCKED;
> +	retval = 0;
> +out_nomem:
> +	spin_unlock(&shmem_lock_user);
>  	spin_unlock(&info->lock);
> +	return retval;
>  }
>  
>  static int shmem_mmap(struct file *file, struct vm_area_struct *vma)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
