Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUI0U5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUI0U5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUI0U4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:56:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6824 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267380AbUI0UyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:54:11 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <20040926211758.5566d48a.akpm@osdl.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 16:52:49 -0400
Message-Id: <1096318369.30503.136.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 21:17 -0700, Andrew Morton wrote:

> Please raise patches against current kernels from
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots.  This kernel is six
> weeks old.

I have patches against newer kernels at

	http://www.kernel.org/pub/linux/kernel/people/rml/inotify

Anyhow, the tidal flood of commentary is appreciated.  I have addressed
all of your issues ...

> > +#define INOTIFY_VERSION "0.10.0"
> 
> You should plan to remove this - it becomes meainingless once the code
> is merged up, and nobody ever updates it as they patch things.

Agreed.  Patch sent.

> +#define INOTIFY_DEV_TIMER_TIME	  (jiffies + (HZ/4))
> 
> ick.  Don't hide the logic in a #define.
> 
> static inline arm_dev_timer(struct inotify_device *dev)
> {
> 	mod_timer(&dev->timer, jiffies + HZ/4);
> }
> 
> is nicer.

It is used in more than one place, but OK.  Patch sent.

> > +/* For debugging */
> > +static int event_object_count;
> > +static int watcher_object_count;
> > +static int inode_ref_count;
> 
> OK.  These are accessed racily.  Either make them atomic_t's or remove them.

They are just statistics.  I'd prefer to remove them entirely (I don't
personally think that the debugging code, statistics, etc. should go
into the mainline kernel).

> > +static int find_inode(const char __user *dirname, struct inode **inode)
> 
> This can just return an inode*, or an IS_ERR() errno, I think?

Yes, it can.  Done, patch sent.

> > +struct inotify_kernel_event *kernel_event(int wd, int mask,
> > +					  const char *filename)
> > +{
> > +	struct inotify_kernel_event *kevent;
> > +
> > +	kevent = kmem_cache_alloc(kevent_cache, GFP_ATOMIC);
> 
> Try to rearrange things so the allocation mode here can become GFP_KERNEL.

Hrmph.

> Are there ever enough of these objects in flight to justify a standalone
> slab cache?

Yes.  There are up to 256*8 possible events and (more importantly than
the net number, I think) they come and go constantly.

> > +	watcher = kmem_cache_alloc(watcher_cache, GFP_KERNEL);

Yes.  There can be a lot of watches... one of the intended uses of this
is automatic indexing of a user's homedir (think Apple Spotlight).  Alan
Cox has also mentioned virus checking, etc.

There are structures are _not_ used as much, and we do not slab cache
them.

> i_lock is documented as an "innermost" lock.
>
> But here, dev->lock is nesting inside it.  Not necessarily a bug per-se,
> but it changes and complicates kernel locking rules, and invalidates
> commentary elsewhere.
> 
> If possible, please try to avoid using i_lock.  Use i_sem instead.
>
> A bug, I think.  What happens if another CPU comes in and tries to take these
> two locks in the opposite order?
> 
> The same problem applies if you switch to i_sem.  The standard fix is to
> take the lowest-addressed lock first.  See d_move() for an example.

I'll work on the locking.

> I'll be merging invalidate_inodes-speedup.patch once the 2.6.10 stream
> opens.  That will make the above code simpler, faster and quite different.

Sweet.

> > +	add_wait_queue(&dev->wait, &wait);
> > +repeat:
> > +	if (signal_pending(current)) {
> > +		spin_unlock(&dev->lock);
> > +		out = -ERESTARTSYS;
> > +		set_current_state(TASK_RUNNING);
> > +		remove_wait_queue(&dev->wait, &wait);
> > +		goto out;
> > +	}
> > +	set_current_state(TASK_INTERRUPTIBLE);
> > +	if (!inotify_dev_has_events(dev)) {
> > +		spin_unlock(&dev->lock);
> > +		schedule();
> > +		spin_lock(&dev->lock);
> > +		goto repeat;
> > +	}
> > +
> > +	set_current_state(TASK_RUNNING);
> > +	remove_wait_queue(&dev->wait, &wait);
> 
> The above seems a bit clumsy.

John is reworking inotify_read(), which should take care of the various
issues you raised here.

> > +static int inotify_open(struct inode *inode, struct file *file)
> > +{
> > +	struct inotify_device *dev;
> > +
> > +	if (atomic_read(&watcher_count) == MAX_INOTIFY_DEVS)
> > +		return -ENODEV;
> > +
> > +	atomic_inc(&watcher_count);
> > +
> > +	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	memset(dev->bitmask, 0,
> > +	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);
> 
> What purpose does this bitmask serve, anyway??

Bitmask of allocated/unallocated watcher descriptors.

Patch sent to add a comment.  Also sent a patch to use the bitmap.h
functions instead of this open-coded memset().

> > +static void inotify_release_all_watchers(struct inotify_device *dev)
> > +{
> > +	struct inotify_watcher *watcher,*next;
> > +
> > +	list_for_each_entry_safe(watcher, next, &dev->watchers, d_list)
> > +		ignore_helper(watcher, 0);
> > +}
> 
> Locking?
> 
> > +
> > +static int inotify_release(struct inode *inode, struct file *file)
> > +{
> > +	if (file->private_data) {
> 
> Why test ->private_data here?

I'm not sure why.  I don't think we ought to - release functions are
only called once, when the last ref on the file dies.  I asked John and
sent a patch to remove it.

> If it indeed needs testing here, shouldn't it be zeroed out as well, with
> appropriate locking?
> 
> > +		struct inotify_device *dev;
> > +
> > +		dev = (struct inotify_device *) file->private_data;
> 
> Please don't typecast when assigning to and from void*'s

Nod.  Patch sent.

> > +		del_timer_sync(&dev->timer);
> > +		inotify_release_all_watchers(dev);
> > +		inotify_release_all_events(dev);
> > +		kfree(dev);
> > +	}
> > +
> > +	printk(KERN_ALERT "inotify device released\n");
> > +
> > +	atomic_dec(&watcher_count);
> 
> If file->private_data was zero, we shouldn't have decremented this?

I don't think we should test file->private_data at all, so after fixing
that, this is fixed.

> +static int inotify_watch(struct inotify_device *dev,
> +			 struct inotify_watch_request *request)
> > +{
> > ...
> > +	spin_lock(&dev->lock);
> > +	spin_lock(&inode->i_lock);
> 
> Lock ranking.
> 
> > +static int inotify_ioctl(struct inode *ip, struct file *fp,
> > +			 unsigned int cmd, unsigned long arg) {
> 
> An errant brace!

Patch sent.

> > +
> > +	if (_IOC_DIR(cmd) & _IOC_READ)
> > +		err = !access_ok(VERIFY_READ, (void *) arg, _IOC_SIZE(cmd));
> > +
> > +	if (err)
> > +		err = -EFAULT;
> > +		goto out;
> > +
> 
> eh?  The above is missing braces, and cannot possibly have worked.

That is my fault, just introduced in the latest revision.

> > +	if (_IOC_DIR(cmd) & _IOC_WRITE)
> > +		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
> > +
> > +	if (err) {
> > +		err = -EFAULT;
> > +		goto out;
> > +	}
> 
> Why are these access_ok() checks here?   I think they can (should) go away.

They should.  We should just use copy_{to,from}_user.  Will fix.

> We often do:
> 
> 	switch (cmd) {
> 	case INOTIFY_WATCH:
> 
> to save a tabstop.

Yah.  I thought I included that in my coding style cleanup.  Patch sent.

> > +struct miscdevice inotify_device = {
> > +	.minor  = MISC_DYNAMIC_MINOR,
> > +	.name	= "inotify",
> > +	.fops	= &inotify_fops,
> > +};
> 
> Please update devices.txt

Documentation/devices.txt doesn't really have provisions for dynamically
allocated devices, which this is.

We _could_ take a fixed minor...

> > +struct inotify_event {
> > +	int wd;
> > +	int mask;
> > +	int cookie;
> > +	char filename[INOTIFY_FILENAME_MAX];
> > +};
> 
> yeah, that's not very nice.  Better to kmalloc the pathname.

That is the structure that we communicate with to user-space.

We could kmalloc() filename, but it makes the user-space use a bit more
complicated (and right now it is trivial and wonderfully simple).

We've been debating the pros and cons.

> Please add CONFIG_INOTIFY and make all this:
>
> [...]
>
> go away if the user doesn't want inotify.  And remember to test with
> CONFIG_INOTIFY=n!

Done.  Patch sent.

> > +		INIT_LIST_HEAD (&inode->watchers);
> 
> Please review the entire patch and ensure that all macros and function
> calls have no space between the identifier and the opening parenthesis.

I thought I caught them all - guess not, patch sent.

Thanks for the feedback.

	Robert Love


