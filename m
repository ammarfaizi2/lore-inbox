Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVERStI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVERStI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVERStI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:49:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37560 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262209AbVERSsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:48:24 -0400
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DYRnw-0001J6-00@dorka.pomaz.szeredi.hu>
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>
	 <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
	 <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com>
	 <7230.1116413175@redhat.com> <8247.1116413990@redhat.com>
	 <9498.1116417099@redhat.com> <E1DYNLt-0000nu-00@dorka.pomaz.szeredi! .hu>
	 <E1DYNjR-0000po-00@dorka.pomaz.szeredi.hu>
	 <E1DYRnw-0001J6-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116442073.24560.142.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 May 2005 11:47:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 09:53, Miklos Szeredi wrote:
> > E.g. having a separate task count, which is incremented/decremented
> > only by clone/exit.  If the task count goes to zero, umount_tree is
> > called on root, but namespace is not freed.
> > 
> > And each mnt_namespace holds a proper reference to the namespace, so
> > it's safe to dereference it anytime.  When truly no more references
> > remain, the namespace can go away.
> > 
> > Hmm?

First of all the reason this race exists implies Al Viro may have had
assertion in his mind that "All tasks that have access to a namespace
has a refcount on that namespace".  If that was what he was thinking,
than the I would stick with that assertion being true. The overall idea
I am thinking off is:

1) have the automounter hold a refcount on any new namespace created
    the mounts in which the automounter has interest in.
2) have a refcount on the namespace when a new task gains access to
   a namespace through the file descriptor or any other 
   similar mechanisms and remove the reference
   once the fd gets closed. (bit tricky to implement)

Do you agree with the overall idea? 
If so I will try to come up with a patch. 

RP

> 
> Here's a patch (compile and boot tested). 
> 
> Now there are two solutions to one problem, the previous one is ugly,
> this one is buggy.  Which should it be?
> 
> Thanks,
> Miklos
> 
> Index: linux/include/linux/namespace.h
> ===================================================================
> --- linux.orig/include/linux/namespace.h	2005-05-18 18:02:24.000000000 +0200
> +++ linux/include/linux/namespace.h	2005-05-18 18:28:48.000000000 +0200
> @@ -7,18 +7,26 @@
>  
>  struct namespace {
>  	atomic_t		count;
> +	atomic_t		task_count; /* how many tasks use this */
>  	struct vfsmount *	root;
>  	struct list_head	list;
>  	struct rw_semaphore	sem;
>  };
>  
>  extern int copy_namespace(int, struct task_struct *);
> -extern void __put_namespace(struct namespace *namespace);
> +extern void __exit_namespace(struct namespace *namespace);
>  
>  static inline void put_namespace(struct namespace *namespace)
>  {
> -	if (atomic_dec_and_test(&namespace->count))
> -		__put_namespace(namespace);
> +	if (namespace && atomic_dec_and_test(&namespace->count))
> +		kfree(namespace);
> +}
> +
> +static inline struct namespace *get_namespace(struct namespace *namespace)
> +{
> +	if (namespace)
> +		atomic_inc(&namespace->count);
> +	return namespace;
>  }
>  
>  static inline void exit_namespace(struct task_struct *p)
> @@ -28,14 +36,10 @@ static inline void exit_namespace(struct
>  		task_lock(p);
>  		p->namespace = NULL;
>  		task_unlock(p);
> -		put_namespace(namespace);
> +		if (atomic_dec_and_test(&p->namespace->task_count))
> +			__exit_namespace(p->namespace);
>  	}
>  }
>  
> -static inline void get_namespace(struct namespace *namespace)
> -{
> -	atomic_inc(&namespace->count);
> -}
> -
>  #endif
>  #endif
> Index: linux/fs/namespace.c
> ===================================================================
> --- linux.orig/fs/namespace.c	2005-05-18 17:42:46.000000000 +0200
> +++ linux/fs/namespace.c	2005-05-18 18:32:29.000000000 +0200
> @@ -160,7 +160,7 @@ clone_mnt(struct vfsmount *old, struct d
>  		mnt->mnt_root = dget(root);
>  		mnt->mnt_mountpoint = mnt->mnt_root;
>  		mnt->mnt_parent = mnt;
> -		mnt->mnt_namespace = current->namespace;
> +		mnt->mnt_namespace = get_namespace(current->namespace);
>  
>  		/* stick the duplicate mount on the same expiry list
>  		 * as the original if that was on one */
> @@ -345,13 +345,15 @@ static void umount_tree(struct vfsmount 
>  	for (p = mnt; p; p = next_mnt(p, mnt)) {
>  		list_del(&p->mnt_list);
>  		list_add(&p->mnt_list, &kill);
> -		p->mnt_namespace = NULL;
>  	}
>  
>  	while (!list_empty(&kill)) {
> +		struct namespace *n;
>  		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
>  		list_del_init(&mnt->mnt_list);
>  		list_del_init(&mnt->mnt_fslink);
> +		n = mnt->mnt_namespace;
> +		mnt->mnt_namespace = NULL;
>  		if (mnt->mnt_parent == mnt) {
>  			spin_unlock(&vfsmount_lock);
>  		} else {
> @@ -361,6 +363,7 @@ static void umount_tree(struct vfsmount 
>  			path_release(&old_nd);
>  		}
>  		mntput(mnt);
> +		put_namespace(n);
>  		spin_lock(&vfsmount_lock);
>  	}
>  }
> @@ -866,12 +869,9 @@ void mark_mounts_for_expiry(struct list_
>  		mnt = list_entry(graveyard.next, struct vfsmount, mnt_fslink);
>  		list_del_init(&mnt->mnt_fslink);
>  
> -		/* don't do anything if the namespace is dead - all the
> -		 * vfsmounts from it are going away anyway */
> -		namespace = mnt->mnt_namespace;
> -		if (!namespace || atomic_read(&namespace->count) <= 0)
> +		namespace = get_namespace(mnt->mnt_namespace);
> +		if (!namespace)
>  			continue;
> -		get_namespace(namespace);
>  
>  		spin_unlock(&vfsmount_lock);
>  		down_write(&namespace->sem);
> @@ -1073,8 +1073,10 @@ int copy_namespace(int flags, struct tas
>  
>  	get_namespace(namespace);
>  
> -	if (!(flags & CLONE_NEWNS))
> +	if (!(flags & CLONE_NEWNS)) {
> +		atomic_inc(&namespace->task_count);
>  		return 0;
> +	}
>  
>  	if (!capable(CAP_SYS_ADMIN)) {
>  		put_namespace(namespace);
> @@ -1086,6 +1088,7 @@ int copy_namespace(int flags, struct tas
>  		goto out;
>  
>  	atomic_set(&new_ns->count, 1);
> +	atomic_set(&new_ns->task_count, 1);
>  	init_rwsem(&new_ns->sem);
>  	INIT_LIST_HEAD(&new_ns->list);
>  
> @@ -1109,7 +1112,9 @@ int copy_namespace(int flags, struct tas
>  	p = namespace->root;
>  	q = new_ns->root;
>  	while (p) {
> -		q->mnt_namespace = new_ns;
> +		struct namespace *oldns = q->mnt_namespace;
> +		q->mnt_namespace = get_namespace(new_ns);
> +		put_namespace(oldns);
>  		if (fs) {
>  			if (p == fs->rootmnt) {
>  				rootmnt = p;
> @@ -1381,16 +1386,17 @@ static void __init init_mount_tree(void)
>  	if (!namespace)
>  		panic("Can't allocate initial namespace");
>  	atomic_set(&namespace->count, 1);
> +	atomic_set(&namespace->task_count, 0);
>  	INIT_LIST_HEAD(&namespace->list);
>  	init_rwsem(&namespace->sem);
>  	list_add(&mnt->mnt_list, &namespace->list);
>  	namespace->root = mnt;
> -	mnt->mnt_namespace = namespace;
> +	mnt->mnt_namespace = get_namespace(namespace);
>  
>  	init_task.namespace = namespace;
>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
> -		get_namespace(namespace);
> +		atomic_inc(&namespace->task_count);
>  		p->namespace = namespace;
>  	} while_each_thread(g, p);
>  	read_unlock(&tasklist_lock);
> @@ -1448,12 +1454,13 @@ void __init mnt_init(unsigned long mempa
>  	init_mount_tree();
>  }
>  
> -void __put_namespace(struct namespace *namespace)
> +void __exit_namespace(struct namespace *namespace)
>  {
>  	down_write(&namespace->sem);
>  	spin_lock(&vfsmount_lock);
>  	umount_tree(namespace->root);
> +	namespace->root = NULL;
>  	spin_unlock(&vfsmount_lock);
>  	up_write(&namespace->sem);
> -	kfree(namespace);
> +	put_namespace(namespace);
>  }
> Index: linux/fs/super.c
> ===================================================================
> --- linux.orig/fs/super.c	2005-05-17 13:46:56.000000000 +0200
> +++ linux/fs/super.c	2005-05-18 18:44:18.000000000 +0200
> @@ -37,6 +37,7 @@
>  #include <linux/writeback.h>		/* for the emergency remount stuff */
>  #include <linux/idr.h>
>  #include <linux/kobject.h>
> +#include <linux/namespace.h>
>  #include <asm/uaccess.h>
>  
> 
> @@ -842,7 +843,7 @@ do_kern_mount(const char *fstype, int fl
>  	mnt->mnt_root = dget(sb->s_root);
>  	mnt->mnt_mountpoint = sb->s_root;
>  	mnt->mnt_parent = mnt;
> -	mnt->mnt_namespace = current->namespace;
> +	mnt->mnt_namespace = get_namespace(current->namespace);
>  	up_write(&sb->s_umount);
>  	put_filesystem(type);
>  	return mnt;

