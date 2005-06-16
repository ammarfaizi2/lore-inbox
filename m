Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVFPRwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVFPRwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVFPRwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:52:24 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:15803 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261780AbVFPRwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:52:10 -0400
Message-ID: <42B1BC4B.3010804@zabbo.net>
Date: Thu, 16 Jun 2005 10:52:11 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
References: <1118855899.3949.21.camel@betsy>
In-Reply-To: <1118855899.3949.21.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Below find an updated inotify, with a doubt the world's great inotify
> release, against 2.6.12-rc6.

some quick comments, nothing earth shattering..

> @@ -0,0 +1,123 @@

diff -p, please.

> + * struct inotify_kernel_event - An intofiy event, originating from a watch and

intofiy!

> +/*
> + * inotify_dev_is_watching_inode - is this device watching this inode?
> + *
> + * Callers must hold dev->sem.
> + */
> +static inline int inotify_dev_is_watching_inode(struct inotify_device *dev,
> +						struct inode *inode)
> +{
> +	struct inotify_watch *watch;
> +
> +	list_for_each_entry(watch, &dev->watches, d_list) {
> +		if (watch->inode == inode)
> +			return 1;
> +	}
> +
> +	return 0;
> +}

Am I missing where this is used?

> +       if (likely(!atomic_read(&inode->inotify_watch_count)))
> +               return;

Are there still platforms that implement atomic_read() with locks?  I
wonder if there isn't a cheaper way for inodes to find out that they're
not involved in inotify.. maybe an inode function pointer that is only
set to queue_event when watchers are around?

> +	down(&inode->inotify_sem);
> +	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
> +		u32 watch_mask = watch->mask;
> +		if (watch_mask & mask) {
> +			struct inotify_device *dev = watch->dev;
> +			get_inotify_watch(watch);
> +			down(&dev->sem);
> +			inotify_dev_queue_event(dev, watch, mask, cookie, name);

I wonder if its worth walking the watches as they're added and removed
to calculate a total mask of what is being watched so that uninteresting
events can be immediately ignored without walking the watches.

I also wonder about adding references to an event from each device that
is watching the inode rather than queueing events on all the devices.
If it only ever copies the full event to user space anyway, you'd just
need a series of pointers on the dev that hold references to a
refcounted event.  It looks like events are only ever dequeued from the
device as they're walked from the head of the list so it doesn't seem
like the ability to remove an event from the middle would be missed.

Too aggressive for a situation that rarely happens anyway?

> +	while (1) {
> +		int events;
> +
> +		prepare_to_wait(&dev->wq, &wait, TASK_INTERRUPTIBLE);
> +
> +		down(&dev->sem);
> +		events = !list_empty(&dev->events);
> +		up(&dev->sem);
> +		if (events) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (file->f_flags & O_NONBLOCK) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret = -EINTR;
> +			break;
> +		}
> +
> +		schedule();
> +	}
> +
> +	finish_wait(&dev->wq, &wait);

It'd be nice to get some wait_event_interruptible() love to replace the
hand-rolled _wait()s and schedule().  It could probably be folded into
the second loop, I imagine.  I suspect that the signal_pending() case
wants to return ERESTARTSYS like w_e_i() does.

> +	nonseekable_open(inode, file);

While it doesn't return errors today, it might be nice to test anyway.

> +/*
> + * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
> + */
> +static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
> +				 const char *old_name, const char *new_name,
> +				 int isdir)
> +{
> +	u32 cookie = inotify_get_cookie();

How about deferring this atomic_inc() until it's known if the event is
going to be queued or not so that renames that have nothing to do with
inotify don't bounce the cache line around?  If it's *only* used to
assciate two different events with a single rename maybe it'd be better
to roll some compound rename event.

I hope this helps.  I, for one, would be thrilled to see dnotify deprecated.

- z
