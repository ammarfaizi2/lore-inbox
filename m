Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCGBVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCGBVC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCGBVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:21:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261437AbVCGBTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:19:43 -0500
Date: Mon, 7 Mar 2005 01:19:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: akpm@osdl.org, John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] inotify for 2.6.11-mm1
Message-ID: <20050307011939.GA7764@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, akpm@osdl.org,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com> <1109963494.10313.32.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109963494.10313.32.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if ((ret + (type == READ)) > 0)
> -		dnotify_parent(file->f_dentry,
> -				(type == READ) ? DN_ACCESS : DN_MODIFY);
> +	if ((ret + (type == READ)) > 0) {
> +		struct dentry *dentry = file->f_dentry;
> +		if (type == READ)
> +			fsnotify_access(dentry, dentry->d_inode,
> +					dentry->d_name.name);
> +		else
> +			fsnotify_modify(dentry, dentry->d_inode,
> +					dentry->d_name.name);
> +	}

Both fsnotify_access and fsnotify_modify always get the second argument
as ->d_inode and third argument as ->d_name.name of the first, please fix
this blatantly stupid API.

> +	fsnotify_close(dentry, inode, file->f_mode, dentry->d_name.name);

dito for thw second and last argument here..  In fact fsnotify_close
should just get a struct file *

>  	might_sleep();

this one seems totally unrelated.

> +/*
> + * struct inotify_device - represents an open instance of an inotify device
> + *
> + * This structure is protected by 'lock'.
> + */
> +struct inotify_device {
> +	wait_queue_head_t 	wq;		/* wait queue for i/o */
> +	struct idr		idr;		/* idr mapping wd -> watch */
> +	struct list_head 	events;		/* list of queued events */
> +	struct list_head	watches;	/* list of watches */
> +	spinlock_t		lock;		/* protects this bad boy */
> +	atomic_t		count;		/* reference count */
> +	struct user_struct	*user;		/* user who opened this dev */
> +	unsigned int		queue_size;	/* size of the queue (bytes) */
> +	unsigned int		event_count;	/* number of pending events */
> +	unsigned int		max_events;	/* maximum number of events */
> +};

> +/*
> + * kernel_event - create a new kernel event with the given parameters
> + */
> +static struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
> +						  const char *name)
> +{
> +	struct inotify_kernel_event *kevent;
> +
> +	/* XXX: optimally, we should use GFP_KERNEL */
> +	kevent = kmem_cache_alloc(event_cachep, GFP_ATOMIC);

indeed.  having a new atomic memory allocation in every filesystem operation
sounds like a really bad idea.

> +		/* XXX: optimally, we should use GFP_KERNEL */
> +		kevent->name = kmalloc(len, GFP_ATOMIC);

and two is even worse.  A notification that fails under slight load
isn't that helpfull.

> +static inline int inotify_dev_has_events(struct inotify_device *dev)
> +{
> +	return !list_empty(&dev->events);
> +}

just remove this bit of obsfucation.

> +	if (kevent->name)
> +		kfree(kevent->name);

kfree(NULL) is just fine.

> +
> +repeat:
> +	if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
> +		return -ENOSPC;
> +	spin_lock(&dev->lock);
> +	ret = idr_get_new(&dev->idr, watch, &watch->wd);
> +	spin_unlock(&dev->lock);
> +	if (ret == -EAGAIN) /* more memory is required, try again */
> +		goto repeat;

what's the problem with a proper do { } while loop here?

> +	watch->inode = inode;	
> +	spin_lock(&inode_lock);
> +	__iget(inode);
> +	spin_unlock(&inode_lock);

do you ever calls this when igrab() would fail?  Don't think so,
and in that case I'd prefer you to use igrab instead of using these
lowlevel functions.

> +void inotify_dentry_parent_queue_event(struct dentry *dentry, u32 mask,
> +				       u32 cookie, const char *name)
> +{
> +	struct dentry *parent;
> +	struct inode *inode;
> +
> +	spin_lock(&dentry->d_lock);
> +	parent = dentry->d_parent;
> +	inode = parent->d_inode;
> +	if (!list_empty(&inode->inotify_watches)) {

So what's protecting ->inotify_watches?  There can be multiple dentries
so d_lock is not sufficient.

> +
> +/**
> + * inotify_super_block_umount - process watches on an unmounted fs
> + * @sb: the super_block of the filesystem in question
> + */
> +void inotify_super_block_umount(struct super_block *sb)
> +{
> +	struct inode *inode;
> +
> +	/* Walk the list of inodes and find those on this superblock */
> +	spin_lock(&inode_lock);
> +	list_for_each_entry(inode, &inode_in_use, i_list) {
> +		struct inotify_watch *watch, *next;
> +		struct list_head *watches;
> +
> +		if (inode->i_sb != sb)
> +			continue;
> +
> +		/* for each watch, send IN_UNMOUNT and then remove it */
> +		spin_lock(&inode->inotify_lock);
> +		watches = &inode->inotify_watches;
> +		list_for_each_entry_safe(watch, next, watches, i_list) {
> +			struct inotify_device *dev = watch->dev;
> +			spin_lock(&dev->lock);
> +			inotify_dev_queue_event(dev, watch, IN_UNMOUNT,0,NULL);
> +			remove_watch(watch, dev);
> +			spin_unlock(&dev->lock);
> +		}
> +		spin_unlock(&inode->inotify_lock);
> +	}
> +	spin_unlock(&inode_lock);
> +}
> +EXPORT_SYMBOL_GPL(inotify_super_block_umount);

-mm has a list of inodes per superblock, which Andrew said he'd send
along to lines, you should probably use that one.  In fact I wonder
whether you'd be better of just calling a per-inode removal hook from
invalidate_inodes.

> +static unsigned int inotify_poll(struct file *file, poll_table *wait)
> +{
> +        struct inotify_device *dev;
> +	int ret = 0;
> +
> +        dev = file->private_data;
> +	get_inotify_dev(dev);

tabs vs spaces messups.

> +static int inotify_add_watch(struct inotify_device *dev,
> +			     struct inotify_watch_request *request)
> +{
> +	struct inode *inode;
> +	struct inotify_watch *watch, *old;
> +	struct nameidata nd;
> +	int ret;
> +
> +	ret = __user_walk(request->name, LOOKUP_FOLLOW, &nd);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	/* you can only watch an inode if you have read permissions on it */
> +	ret = permission(nd.dentry->d_inode, MAY_READ, NULL);

permission takes a nameidata as last parameter, so please do so aswell.

> +
> +	switch (cmd) {
> +	case INOTIFY_WATCH:
> +		if (unlikely(copy_from_user(&request, p, sizeof (request)))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		ret = inotify_add_watch(dev, &request);
> +		break;
> +	case INOTIFY_IGNORE:
> +		if (unlikely(copy_from_user(&wd, p, sizeof (wd)))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		ret = inotify_ignore(dev, wd);
> +		break;
> +	case FIONREAD:
> +		ret = put_user(dev->queue_size, (int __user *) p);
> +		break;
> +	}
> +
> +	put_inotify_dev(dev);
> +
> +	return ret;

Both INOTIFY_WATCH and INOTIFY_IGNORE could easily be implemented as
writes to /dev/inotify, echo "wath /path/to/foo 42", echo "ignore 23".

> +static struct miscdevice inotify_device = {
> +	.minor  = MISC_DYNAMIC_MINOR,
> +	.name	= "inotify",
> +	.fops	= &inotify_fops,
> +};

Should probably use the /dev/mem major.

> +	default y

please don't default a new and experimental facility to y.  In fact
default is totally overused.

> +	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
> +		fsnotify_unlink(dentry->d_inode, dir, dentry);

first argument can be deduced from the last.

> +			fsnotify_open(dentry, dentry->d_inode,
> +				      dentry->d_name.name);

second and third argument can be taken from the first

> +#ifdef CONFIG_INOTIFY
> +     struct list_head        inotify_watches;  /* watches on this inode */
> +     spinlock_t              inotify_lock;  /* protects the watches list */
> +#endif

do you really need a spinlock of your own in every inode?  Inode memory
usage is a quite big problem.

> +static inline void fsnotify_rmdir(struct dentry *dentry, struct inode *inode,
> +				  struct inode *dir)
> +{
> +	inode_dir_notify(dir, DN_DELETE);
> +	inotify_inode_queue_event(dir, IN_DELETE_SUBDIR,0,dentry->d_name.name);
> +	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
> +
> +	inotify_inode_is_dead(inode);
> +	d_delete(dentry);

why is the d_delete in here?

> +/*
> + * fsnotify_change - notify_change event.  file was modified and/or metadata
> + * was changed.
> + */
> +static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)

this one is far too large to be inlined.

> +/*
> + * struct inotify_event - structure read from the inotify device for each event
> + *
> + * When you are watching a directory, you will receive the filename for events
> + * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, ..., relative to the wd.
> + */
> +struct inotify_event {
> +	__s32		wd;		/* watch descriptor */
> +	__u32		mask;		/* watch mask */
> +	__u32		cookie;		/* cookie to synchronize two events */
> +	size_t		len;		/* length (including nulls) of name */

please don't use size_t in a user ABI.  Just use __u32

> diff -urN linux-2.6.11-mm1/include/linux/sched.h linux/include/linux/sched.h
> --- linux-2.6.11-mm1/include/linux/sched.h	2005-03-04 14:06:21.766292400 -0500
> +++ linux/include/linux/sched.h	2005-03-04 13:27:05.586486176 -0500
> @@ -411,6 +411,8 @@
>  	atomic_t processes;	/* How many processes does this user have? */
>  	atomic_t files;		/* How many open files does this user have? */
>  	atomic_t sigpending;	/* How many pending signals does this user have? */
> +	atomic_t inotify_watches;	/* How many inotify watches does this user have? */
> +	atomic_t inotify_devs;	/* How many inotify devs does this user have opened? */

Why are these unconditional, unlike the inode ones?

