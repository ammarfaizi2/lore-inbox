Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUHDNdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUHDNdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUHDNdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:33:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265429AbUHDNcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:32:15 -0400
Date: Wed, 4 Aug 2004 09:31:54 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040803230614.C1924@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0408040825180.7628-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Chris Wright wrote:

> This gets overwritten by NULL in the hunk below.  So the accouting will
> never be undone.

Fixed in the incremental below.

> > @@ -504,14 +510,11 @@ asmlinkage long sys_shmctl (int shmid, i
> >  	case SHM_LOCK:
> >  	case SHM_UNLOCK:
> >  	{
> > -/* Allow superuser to lock segment in memory */
> > -/* Should the pages be faulted in here or leave it to user? */
> > -/* need to determine interaction with current->swappable */
> > -		if (!capable(CAP_IPC_LOCK)) {
> > +		/* Allow superuser to lock segment in memory */
> > +		if (!can_do_mlock()) {
> 
> I actually think this is too restrictive.  Why not be able
> to unlock is the rlimit has been reset to zero?  It's also
> called 2 or 3 times during SHM_LOCK.

Good point.   I've made unlock an unprivileged operation
in the incremental patch below.  Let me know if this is
what you wanted ;)

> > @@ -526,13 +529,19 @@ asmlinkage long sys_shmctl (int shmid, i
> >  			goto out_unlock;
> >  		
> >  		if(cmd==SHM_LOCK) {
> > -			if (!is_file_hugepages(shp->shm_file))
> > -				shmem_lock(shp->shm_file, 1);
> > -			shp->shm_flags |= SHM_LOCKED;
> > +			struct user_struct * user = current->user;
> > +			if (!is_file_hugepages(shp->shm_file)) {
> > +				err = shmem_lock(shp->shm_file, 1, current->user);
> > +				if (!err) {
> > +					shp->shm_flags |= SHM_LOCKED;
> 
> Slight change in behaviour.  Used to set SHM_LOCKED on hugetlb backed
> segments as well.  I don't see any purpose for the old behaviour though.

It's a needed change though, since shmem_lock could fail due
to the user not having enough quota left.

> >  		} else {
> >  			if (!is_file_hugepages(shp->shm_file))
> > -				shmem_lock(shp->shm_file, 0);
> > +				shmem_lock(shp->shm_file, 0, shp->mlock_user);
> >  			shp->shm_flags &= ~SHM_LOCKED;
> 
> This doesn't match behaviour above.

> > +			shp->mlock_user = NULL;
> 
> This means that SHM_UNLOCK on SHM_HUGETLB segment will never get
> unaccounted during segment destruction (since mlock_user will
> errnoeously be NULL).  I think both of these should be under
> !is_file_hugepages condition.  I don't see the point of SHM_{UN,}LOCK on
> SHM_HUGETLB segment.

Fixed in the incremental, I guess...

And yeah, I'm not quite sure why we go through the motions with
SHM_HUGETLB segments myself ...

I'm pondering a:

	if (is_file_hugepages(shp->shm_file)
		return -EINVAL;

earlier on in the function. That would get rid of these issues
and clean up the code somewhat ;)

> > --- linux-2.6.7/ipc/util.c.mlock	2004-08-03 22:46:29.851673621 -0400
> > +++ linux-2.6.7/ipc/util.c	2004-08-03 22:46:43.402678045 -0400
> > @@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
> >  		granted_mode >>= 3;
> >  	/* is there some bit set in requested_mode but not in granted_mode? */
> >  	if ((requested_mode & ~granted_mode & 0007) && 
> > -	    !capable(CAP_IPC_OWNER))
> > -		return -1;
> > +	    !capable(CAP_IPC_OWNER)) {
> > +		if (!can_do_mlock())  {
> > +			return -1;
> > +		}
> > +	}	
> 
> I still don't see the use for this one.  I believe it duplicates
> SHM_HUGETLB check that's already there.

I'm not sure about your comments here.  However, I'm also not
quite sure about this piece of code.  Arjan ? ;)

> > +int user_can_mlock(size_t size, struct user_struct * user)
> > +{
> > +	unsigned long lock_limit, locked;
> > +	int allowed = 0;
> > +
> > +	spin_lock(&mlock_user_lock);
> > +	locked = size >> PAGE_SHIFT;
> > +	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
> > +	lock_limit >>= PAGE_SHIFT;
> > +	if (locked + user->locked_shm > lock_limit)
> > +		goto out;
> > +	atomic_inc(&user->__count);
> 
> There is a trivial get_uid wrapper.  Although, that's arguable whether
> it's useful here.

It's certainly more beautiful.  Fixed in the incremental ...

> > +void user_subtract_mlock(size_t size, struct user_struct * user)
> > +{
> > +	if (user) {
> 
> Hmm, is !user ever valid?  Perhaps it should start out as BUG_ON?

Hmmm, I guess you're right.  Hugetlb segments always should have
an shp->mlock_user and while shmem_lock gets called blindly from
shm_destroy, it should only call user_subtract_mlock when the shm
segment really was locked in memory...

I just verified the 3 callers and they appear correct wrt this.

> > +int shmem_lock(struct file *file, int lock, struct user_struct * user)
> >  {
> >  	struct inode *inode = file->f_dentry->d_inode;
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> > +	int retval = -ENOMEM;
> > +
> > +	if (!can_do_mlock())
> > +		return -EPERM;
> 
> I see no point in checking this when !lock.

Agreed, fixed in the incremental.

Please let me know if you find any more issues.

--- linux-2.6.7/ipc/shm.c.incremental	2004-08-04 08:24:41.000000000 -0400
+++ linux-2.6.7/ipc/shm.c	2004-08-04 08:32:39.000000000 -0400
@@ -193,6 +193,7 @@ static int newseg (key_t key, int shmflg
 
 	shp->shm_perm.key = key;
 	shp->shm_flags = (shmflg & S_IRWXUGO);
+	shp->mlock_user = NULL;
 
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(shp);
@@ -226,7 +227,6 @@ static int newseg (key_t key, int shmflg
 	shp->shm_nattch = 0;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
-	shp->mlock_user = NULL;
 	file->f_dentry->d_inode->i_ino = shp->id;
 	if (shmflg & SHM_HUGETLB)
 		set_file_hugepages(file);
@@ -511,7 +511,7 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_UNLOCK:
 	{
 		/* Allow superuser to lock segment in memory */
-		if (!can_do_mlock()) {
+		if (!can_do_mlock() && cmd == SHM_LOCK) {
 			err = -EPERM;
 			goto out;
 		}
@@ -537,9 +537,8 @@ asmlinkage long sys_shmctl (int shmid, i
 					shp->mlock_user = user;
 				}
 			}
-		} else {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 0, shp->mlock_user);
+		} else if (!is_file_hugepages(shp->shm_file)) {
+			shmem_lock(shp->shm_file, 0, shp->mlock_user);
 			shp->shm_flags &= ~SHM_LOCKED;
 			shp->mlock_user = NULL;
 		}
--- linux-2.6.7/mm/mlock.c.incremental	2004-08-04 09:22:11.594669582 -0400
+++ linux-2.6.7/mm/mlock.c	2004-08-04 09:28:14.417102357 -0400
@@ -211,7 +211,7 @@ int user_can_mlock(size_t size, struct u
 	lock_limit >>= PAGE_SHIFT;
 	if (locked + user->locked_shm > lock_limit)
 		goto out;
-	atomic_inc(&user->__count);
+	get_uid(user);
 	user->locked_shm += locked;
 	allowed = 1;
 out:
@@ -221,10 +221,8 @@ out:
 
 void user_subtract_mlock(size_t size, struct user_struct * user)
 {
-	if (user) {
-		spin_lock(&mlock_user_lock);
-		user->locked_shm -= (size >> PAGE_SHIFT);
-		spin_unlock(&mlock_user_lock);
-		free_uid(user);
-	}
+	spin_lock(&mlock_user_lock);
+	user->locked_shm -= (size >> PAGE_SHIFT);
+	spin_unlock(&mlock_user_lock);
+	free_uid(user);
 }
--- linux-2.6.7/mm/shmem.c.incremental	2004-08-04 09:29:10.606445758 -0400
+++ linux-2.6.7/mm/shmem.c	2004-08-04 09:29:47.337557579 -0400
@@ -1157,7 +1157,7 @@ int shmem_lock(struct file *file, int lo
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int retval = -ENOMEM;
 
-	if (!can_do_mlock())
+	if (lock && !can_do_mlock())
 		return -EPERM;
 
 	spin_lock(&info->lock);

