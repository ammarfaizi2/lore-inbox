Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUI0EUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUI0EUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUI0EUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 00:20:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:44687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265887AbUI0EUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 00:20:08 -0400
Date: Sun, 26 Sep 2004 21:17:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040926211758.5566d48a.akpm@osdl.org>
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> Announcing the release of inotify 0.10.0. 

I can't say I'm thrilled by the locking.

>  Attached is a patch to 2.6.8.1.

Please raise patches against current kernels from
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots.  This kernel is six
weeks old.


> +#define INOTIFY_VERSION "0.10.0"

You should plan to remove this - it becomes meainingless once the code
is merged up, and nobody ever updates it as they patch things.

> +#define MAX_INOTIFY_DEVS	  8	/* max open inotify devices */
> +#define MAX_INOTIFY_DEV_WATCHERS  8192	/* max total watches */
> +#define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev*/

hmm.

+#define INOTIFY_DEV_TIMER_TIME	  (jiffies + (HZ/4))

ick.  Don't hide the logic in a #define.

static inline arm_dev_timer(struct inotify_device *dev)
{
	mod_timer(&dev->timer, jiffies + HZ/4);
}

is nicer.

> +/* For debugging */
> +static int event_object_count;
> +static int watcher_object_count;
> +static int inode_ref_count;

OK.  These are accessed racily.  Either make them atomic_t's or remove them.

> +struct inotify_device {
> +	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
> +	struct timer_list	timer;
> +	wait_queue_head_t 	wait;
> +	struct list_head 	events;
> +	struct list_head 	watchers;
> +	spinlock_t		lock;
> +	unsigned int		event_count;
> +	int			nr_watches;
> +};
> +
> +struct inotify_watcher {
> +	int 			wd; // watcher descriptor
> +	unsigned long		mask;
> +	struct inode *		inode;
> +	struct inotify_device *	dev;
> +	struct list_head	d_list; // device list
> +	struct list_head	i_list; // inode list
> +	struct list_head	u_list; // unmount list 
> +};
> ...
> +struct inotify_kernel_event {
> +        struct list_head        list;
> +	struct inotify_event	event;
> +};

Would be nice to add commentary documenting what lock protects the various
fields.

> +static int find_inode(const char __user *dirname, struct inode **inode)

This can just return an inode*, or an IS_ERR() errno, I think?

> +struct inotify_kernel_event *kernel_event(int wd, int mask,
> +					  const char *filename)
> +{
> +	struct inotify_kernel_event *kevent;
> +
> +	kevent = kmem_cache_alloc(kevent_cache, GFP_ATOMIC);

Try to rearrange things so the allocation mode here can become GFP_KERNEL.

Are there ever enough of these objects in flight to justify a standalone
slab cache?

> +	watcher = kmem_cache_alloc(watcher_cache, GFP_KERNEL);

Ditto.

> +void inotify_inode_queue_event(struct inode *inode, unsigned long mask,
> +			       const char *filename)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	spin_lock(&inode->i_lock);

i_lock is documented as an "innermost" lock.

> +	list_for_each_entry(watcher, &inode->watchers, i_list) {
> +		spin_lock(&watcher->dev->lock);

But here, dev->lock is nesting inside it.  Not necessarily a bug per-se,
but it changes and complicates kernel locking rules, and invalidates
commentary elsewhere.

If possible, please try to avoid using i_lock.  Use i_sem instead.

> +void inotify_inode_queue_event_pair(struct inode *inode1, unsigned long mask1,
> +				    const char *filename1,
> +				    struct inode *inode2, unsigned long mask2,
> +				    const char *filename2)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	spin_lock(&inode1->i_lock);
> +	spin_lock(&inode2->i_lock);

A bug, I think.  What happens if another CPU comes in and tries to take these
two locks in the opposite order?

The same problem applies if you switch to i_sem.  The standard fix is to
take the lowest-addressed lock first.  See d_move() for an example.

> +
> +void inotify_dentry_parent_queue_event(struct dentry *dentry,
> +				       unsigned long mask,
> +				       const char *filename)
> +{
> +	struct dentry *parent;
> +
> +	spin_lock(&dentry->d_lock);
> +	dget(dentry->d_parent);
> +	parent = dentry->d_parent;
> +	inotify_inode_queue_event(parent->d_inode, mask, filename);
> +	dput(parent);
> +	spin_unlock(&dentry->d_lock);
> +}

Does d_lock need to be held across the inotify_inode_queue_event() call?

If (hopefully) not, simply use dget_parent() in here.

> +EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
> +
> +static void ignore_helper(struct inotify_watcher *watcher, int event)
> +{
> +	struct inotify_device *dev;
> +	struct inode *inode;
> +
> +	spin_lock(&watcher->dev->lock);
> +	spin_lock(&watcher->inode->i_lock);

Bug.  Elsewhere, i_lock nests outside dev->lock.

> +static void build_umount_list(struct list_head *head, struct super_block *sb,
> +			       struct list_head *umount)
> +{
> +	struct inode *	inode;
> +
> +	list_for_each_entry(inode, head, i_list) {
> +		struct inotify_watcher *watcher;
> +
> +		if (inode->i_sb != sb)
> +			continue;
> +
> +		spin_lock(&inode->i_lock);
> +
> +		list_for_each_entry(watcher, &inode->watchers, i_list)
> +			list_add(&watcher->u_list, umount);
> +
> +		spin_unlock(&inode->i_lock);
> +	}
> +}

I'll be merging invalidate_inodes-speedup.patch once the 2.6.10 stream
opens.  That will make the above code simpler, faster and quite different.

> +void inotify_inode_is_dead(struct inode *inode)
> +{
> +	struct inotify_watcher *watcher, *next;
> +
> +	list_for_each_entry_safe(watcher, next, &inode->watchers, i_list) {
> +		ignore_helper(watcher, 0);
> +}
> +EXPORT_SYMBOL_GPL(inotify_inode_is_dead);

This needs locking, I think.  Or a comment explaining why it does not.

> +	add_wait_queue(&dev->wait, &wait);
> +repeat:
> +	if (signal_pending(current)) {
> +		spin_unlock(&dev->lock);
> +		out = -ERESTARTSYS;
> +		set_current_state(TASK_RUNNING);
> +		remove_wait_queue(&dev->wait, &wait);
> +		goto out;
> +	}
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	if (!inotify_dev_has_events(dev)) {
> +		spin_unlock(&dev->lock);
> +		schedule();
> +		spin_lock(&dev->lock);
> +		goto repeat;
> +	}
> +
> +	set_current_state(TASK_RUNNING);
> +	remove_wait_queue(&dev->wait, &wait);

The above seems a bit clumsy.

> +	err = !access_ok(VERIFY_WRITE, (void *)buf,
> +			 sizeof(struct inotify_event));
> +
> +	if (err) {
> +		out = -EFAULT;
> +		goto out;
> +	}
> +

The above is unneeded.  copy_to_user() will check.

> +	/* Copy all the events we can to the event buffer */
> +	for (event_count = 0; event_count < events; event_count++) {
> +		kevent = inotify_dev_get_event(dev);
> +		eventbuf[event_count] = kevent->event;
> +		inotify_dev_event_dequeue(dev);
> +	}
> +
> +	spin_unlock(&dev->lock);
> +
> +	/* Send the event buffer to user space */
> +	err = copy_to_user(buf, eventbuf,
> +			   events * sizeof(struct inotify_event));
> +
> +	buf += sizeof(struct inotify_event) * events;
> +
> +	out = buf - obuf;
> +
> +out:
> +	kfree(eventbuf);
> +	return out;
> +}

Except the copy_to_user() return value is being ignored!

I don't think you need event_buf at all.  Just copy one event at a time to
userspace.  copy_to_user() is efficient.  Using an intermediate buffer like
this consumes extra CPU dcache and may even be slower.

Probably slower, given that the temp buffer is kmalloced.

> +static int inotify_open(struct inode *inode, struct file *file)
> +{
> +	struct inotify_device *dev;
> +
> +	if (atomic_read(&watcher_count) == MAX_INOTIFY_DEVS)
> +		return -ENODEV;
> +
> +	atomic_inc(&watcher_count);
> +
> +	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	memset(dev->bitmask, 0,
> +	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);

What purpose does this bitmask serve, anyway??

> +	add_timer(&dev->timer);

And what does the timer do?  (You surely explained the feature earlier,
but I was asleep, sorry).

> +static void inotify_release_all_watchers(struct inotify_device *dev)
> +{
> +	struct inotify_watcher *watcher,*next;
> +
> +	list_for_each_entry_safe(watcher, next, &dev->watchers, d_list)
> +		ignore_helper(watcher, 0);
> +}

Locking?

> +
> +static int inotify_release(struct inode *inode, struct file *file)
> +{
> +	if (file->private_data) {

Why test ->private_data here?

If it indeed needs testing here, shouldn't it be zeroed out as well, with
appropriate locking?

> +		struct inotify_device *dev;
> +
> +		dev = (struct inotify_device *) file->private_data;

Please don't typecast when assigning to and from void*'s

> +		del_timer_sync(&dev->timer);
> +		inotify_release_all_watchers(dev);
> +		inotify_release_all_events(dev);
> +		kfree(dev);
> +	}
> +
> +	printk(KERN_ALERT "inotify device released\n");
> +
> +	atomic_dec(&watcher_count);

If file->private_data was zero, we shouldn't have decremented this?

+static int inotify_watch(struct inotify_device *dev,
+			 struct inotify_watch_request *request)
> +{
> ...
> +	spin_lock(&dev->lock);
> +	spin_lock(&inode->i_lock);

Lock ranking.

> +static int inotify_ioctl(struct inode *ip, struct file *fp,
> +			 unsigned int cmd, unsigned long arg) {

An errant brace!

> +
> +	if (_IOC_DIR(cmd) & _IOC_READ)
> +		err = !access_ok(VERIFY_READ, (void *) arg, _IOC_SIZE(cmd));
> +
> +	if (err)
> +		err = -EFAULT;
> +		goto out;
> +

eh?  The above is missing braces, and cannot possibly have worked.

> +	if (_IOC_DIR(cmd) & _IOC_WRITE)
> +		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
> +
> +	if (err) {
> +		err = -EFAULT;
> +		goto out;
> +	}

Why are these access_ok() checks here?   I think they can (should) go away.

> +	err = -EINVAL;
> +
> +	switch (cmd) {
> +		case INOTIFY_WATCH:

We often do:

	switch (cmd) {
	case INOTIFY_WATCH:

to save a tabstop.

> +struct miscdevice inotify_device = {
> +	.minor  = MISC_DYNAMIC_MINOR,
> +	.name	= "inotify",
> +	.fops	= &inotify_fops,
> +};

Please update devices.txt

> +/* this size could limit things, since technically we could need PATH_MAX */
> +#define INOTIFY_FILENAME_MAX	256
> +
> +/*
> + * struct inotify_event - structure read from the inotify device for each event
> + *
> + * When you are watching a directory, you will receive the filename for events
> + * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, ...
> + *
> + * Note: When reading from the device you must provide a buffer that is a
> + * multiple of sizeof(struct inotify_event)
> + */
> +struct inotify_event {
> +	int wd;
> +	int mask;
> +	int cookie;
> +	char filename[INOTIFY_FILENAME_MAX];
> +};

yeah, that's not very nice.  Better to kmalloc the pathname.

> +/* Adds event to all watchers on inode that are interested in mask */
> +void inotify_inode_queue_event (struct inode *inode, unsigned long mask,
> +		const char *filename);
> +
> +/* Same as above but uses dentry's inode */
> +void inotify_dentry_parent_queue_event (struct dentry *dentry,
> +		unsigned long mask, const char *filename);
> +
> +/* This will remove all watchers from all inodes on the superblock */
> +void inotify_super_block_umount (struct super_block *sb);
> +
> +/* Call this when an inode is dead, and inotify should ignore it */
> +void inotify_inode_is_dead (struct inode *inode);
> +

Please add CONFIG_INOTIFY and make all this:

> --- clean/linux/include/linux/fs.h	2004-08-14 06:55:09.000000000 -0400
> +++ linux/include/linux/fs.h	2004-09-18 02:24:33.000000000 -0400
> @@ -458,6 +458,10 @@
>  	unsigned long		i_dnotify_mask; /* Directory notify events */
>  	struct dnotify_struct	*i_dnotify; /* for directory notifications */
>  
> +	struct list_head	watchers;
> +	unsigned long		watchers_mask;
> +	int			watcher_count;
> +
>  	unsigned long		i_state;
>  	unsigned long		dirtied_when;	/* jiffies of first dirtying */
>  

and this:

> @@ -216,8 +217,11 @@
>  				ret = file->f_op->read(file, buf, count, pos);
>  			else
>  				ret = do_sync_read(file, buf, count, pos);
> -			if (ret > 0)
> +			if (ret > 0) {
>  				dnotify_parent(file->f_dentry, DN_ACCESS);
> +				inotify_dentry_parent_queue_event(file->f_dentry, IN_ACCESS, file->f_dentry->d_name.name);
> +				inotify_inode_queue_event (file->f_dentry->d_inode, IN_ACCESS, NULL);
> +			}
>  		}

go away if the user doesn't want inotify.  And remember to test with
CONFIG_INOTIFY=n!

> +		INIT_LIST_HEAD (&inode->watchers);

Please review the entire patch and ensure that all macros and function
calls have no space between the identifier and the opening parenthesis.


Can't say that I'm thrilled that it uses an ioctl.

What are the security policies?

Am I allowed to monitor an inode for which I do not have read permission? 
If so, can I use that to pin files which root wants to delete, thus causing
the disk to fill up?
