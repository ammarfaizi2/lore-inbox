Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUHDGGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUHDGGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbUHDGGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:06:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:33694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267283AbUHDGGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:06:18 -0400
Date: Tue, 3 Aug 2004 23:06:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803230614.C1924@build.pdx.osdl.net>
References: <20040804023120.GK2334@holomorphy.com> <Pine.LNX.4.44.0408032254250.32641-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0408032254250.32641-100000@dhcp83-102.boston.redhat.com>; from riel@redhat.com on Tue, Aug 03, 2004 at 10:56:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Tue, 3 Aug 2004, William Lee Irwin III wrote:
> 
> > By any chance could you repost a complete patch and/or series?
> 
> Here you are.  It is fits into the Fedora kernel rpm, but
> I guess it should apply to upstream and -mm too.

Not quite.  The hugetlb_shm_group change is upstream so there's a small
conflict.  I've got a diff.  It begs the question of whether to keep
the hugetlb_shm_group bits at all if this is merged.

> Please check if there are any spots left where this patch
> did something wrong. I'd like to get this merged ASAP, so
> I will fix any actual errors people find.

Few spots below.

> --- linux-2.6.7/ipc/shm.c.mlock	2004-08-03 22:46:29.848674505 -0400
> +++ linux-2.6.7/ipc/shm.c	2004-08-03 22:46:43.399678929 -0400
> @@ -114,7 +114,10 @@ static void shm_destroy (struct shmid_ke
>  	shm_rmid (shp->id);
>  	shm_unlock(shp);
>  	if (!is_file_hugepages(shp->shm_file))
> -		shmem_lock(shp->shm_file, 0);
> +		shmem_lock(shp->shm_file, 0, shp->mlock_user);
> +	else
> +		user_subtract_mlock(shp->shm_file->f_dentry->d_inode->i_size,
> +						shp->mlock_user);
>  	fput (shp->shm_file);
>  	security_shm_free(shp);
>  	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
> @@ -198,9 +201,11 @@ static int newseg (key_t key, int shmflg
>  		return error;
>  	}
>  
> -	if (shmflg & SHM_HUGETLB)
> +	if (shmflg & SHM_HUGETLB) {
> +		/* hugetlb_zero_setup takes care of mlock user accounting */
>  		file = hugetlb_zero_setup(size);
> -	else {
> +		shp->mlock_user = current->user;

This gets overwritten by NULL in the hunk below.  So the accouting will
never be undone.

> +	} else {
>  		sprintf (name, "SYSV%08x", key);
>  		file = shmem_file_setup(name, size, VM_ACCOUNT);
>  	}
> @@ -221,6 +226,7 @@ static int newseg (key_t key, int shmflg
>  	shp->shm_nattch = 0;
>  	shp->id = shm_buildid(id,shp->shm_perm.seq);
>  	shp->shm_file = file;
> +	shp->mlock_user = NULL;
>  	file->f_dentry->d_inode->i_ino = shp->id;
>  	if (shmflg & SHM_HUGETLB)
>  		set_file_hugepages(file);
> @@ -504,14 +510,11 @@ asmlinkage long sys_shmctl (int shmid, i
>  	case SHM_LOCK:
>  	case SHM_UNLOCK:
>  	{
> -/* Allow superuser to lock segment in memory */
> -/* Should the pages be faulted in here or leave it to user? */
> -/* need to determine interaction with current->swappable */
> -		if (!capable(CAP_IPC_LOCK)) {
> +		/* Allow superuser to lock segment in memory */
> +		if (!can_do_mlock()) {

I actually think this is too restrictive.  Why not be able
to unlock is the rlimit has been reset to zero?  It's also
called 2 or 3 times during SHM_LOCK.

>  			err = -EPERM;
>  			goto out;
>  		}
> -
>  		shp = shm_lock(shmid);
>  		if(shp==NULL) {
>  			err = -EINVAL;
> @@ -526,13 +529,19 @@ asmlinkage long sys_shmctl (int shmid, i
>  			goto out_unlock;
>  		
>  		if(cmd==SHM_LOCK) {
> -			if (!is_file_hugepages(shp->shm_file))
> -				shmem_lock(shp->shm_file, 1);
> -			shp->shm_flags |= SHM_LOCKED;
> +			struct user_struct * user = current->user;
> +			if (!is_file_hugepages(shp->shm_file)) {
> +				err = shmem_lock(shp->shm_file, 1, current->user);
> +				if (!err) {
> +					shp->shm_flags |= SHM_LOCKED;

Slight change in behaviour.  Used to set SHM_LOCKED on hugetlb backed
segments as well.  I don't see any purpose for the old behaviour though.

> +					shp->mlock_user = user;
> +				}
> +			}
>  		} else {
>  			if (!is_file_hugepages(shp->shm_file))
> -				shmem_lock(shp->shm_file, 0);
> +				shmem_lock(shp->shm_file, 0, shp->mlock_user);
>  			shp->shm_flags &= ~SHM_LOCKED;

This doesn't match behaviour above.

> +			shp->mlock_user = NULL;

This means that SHM_UNLOCK on SHM_HUGETLB segment will never get unaccounted
during segment destruction (since mlock_user will errnoeously be NULL).  I
think both of these should be under !is_file_hugepages condition.  I don't
see the point of SHM_{UN,}LOCK on SHM_HUGETLB segment.

>  		}
>  		shm_unlock(shp);
>  		goto out;
> --- linux-2.6.7/ipc/util.c.mlock	2004-08-03 22:46:29.851673621 -0400
> +++ linux-2.6.7/ipc/util.c	2004-08-03 22:46:43.402678045 -0400
> @@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
>  		granted_mode >>= 3;
>  	/* is there some bit set in requested_mode but not in granted_mode? */
>  	if ((requested_mode & ~granted_mode & 0007) && 
> -	    !capable(CAP_IPC_OWNER))
> -		return -1;
> +	    !capable(CAP_IPC_OWNER)) {
> +		if (!can_do_mlock())  {
> +			return -1;
> +		}
> +	}	

I still don't see the use for this one.  I believe it duplicates
SHM_HUGETLB check that's already there.

> +int user_can_mlock(size_t size, struct user_struct * user)
> +{
> +	unsigned long lock_limit, locked;
> +	int allowed = 0;
> +
> +	spin_lock(&mlock_user_lock);
> +	locked = size >> PAGE_SHIFT;
> +	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
> +	lock_limit >>= PAGE_SHIFT;
> +	if (locked + user->locked_shm > lock_limit)
> +		goto out;
> +	atomic_inc(&user->__count);

There is a trivial get_uid wrapper.  Although, that's arguable whether
it's useful here.

> +	user->locked_shm += locked;
> +	allowed = 1;
> +out:
> +	spin_unlock(&mlock_user_lock);
> +	return allowed;
> +}
> +
> +void user_subtract_mlock(size_t size, struct user_struct * user)
> +{
> +	if (user) {

Hmm, is !user ever valid?  Perhaps it should start out as BUG_ON?

> +		spin_lock(&mlock_user_lock);
> +		user->locked_shm -= (size >> PAGE_SHIFT);
> +		spin_unlock(&mlock_user_lock);
> +		free_uid(user);
> +	}
> +}
> --- linux-2.6.7/mm/shmem.c.mlock	2004-08-03 22:46:39.416853287 -0400
> +++ linux-2.6.7/mm/shmem.c	2004-08-03 22:46:43.444665665 -0400
> @@ -1151,17 +1151,29 @@ shmem_get_policy(struct vm_area_struct *
>  }
>  #endif
>  
> -void shmem_lock(struct file *file, int lock)
> +int shmem_lock(struct file *file, int lock, struct user_struct * user)
>  {
>  	struct inode *inode = file->f_dentry->d_inode;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	int retval = -ENOMEM;
> +
> +	if (!can_do_mlock())
> +		return -EPERM;

I see no point in checking this when !lock.  In fact, the error will
be silently ignored, and the accounting will never be undone if ulimit
is reset to 0 before removing the segment.  In the case of lock ==
1, user_can_mlock basically duplicates the check.  Maybe it should
just be removed.

>  	spin_lock(&info->lock);
> -	if (lock)
> +	if (lock && !(info->flags & VM_LOCKED)) {
> +		if (!user_can_mlock(inode->i_size, user) && !capable(CAP_IPC_LOCK))
> +			goto out_nomem;
>  		info->flags |= VM_LOCKED;
> -	else
> +	}
> +	if (!lock && (info->flags & VM_LOCKED) && user) {
> +		user_subtract_mlock(inode->i_size, user);
>  		info->flags &= ~VM_LOCKED;
> +	}
> +	retval = 0;
> +out_nomem:
>  	spin_unlock(&info->lock);
> +	return retval;
>  }
>  
>  static int shmem_mmap(struct file *file, struct vm_area_struct *vma)

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
