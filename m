Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUIUXxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUIUXxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIUXxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 19:53:12 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46241 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267324AbUIUXw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 19:52:27 -0400
Date: Tue, 21 Sep 2004 20:54:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] updated inotify
Message-ID: <20040921235449.GO2482@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
	linux-kernel@vger.kernel.org
References: <1095800893.5090.16.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095800893.5090.16.camel@betsy.boston.ximian.com>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.500000, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 21, 2004 at 05:08:13PM -0400, Robert Love escreveu:
> I have posted so many small patches recently that I wanted to just post
> an updated inotify patch, with all of my changes merged in.
> 
> I also rediffed everything against 2.6.9-rc2.
> 
> And introduced an INOTIFY_FILENAME_MAX for the filename size, since
> there were open coded 255's and 256's in inotify.c.
> 
> Additionally, I cleaned up some of the coding style to match the
> kernel's.  Don't know if you want this, but there it is.

coding style? So nitpicking I go, see below.
 
> Best,
> 
> 	Robert Love
> 

> inotify. the "i" stands for "awesome".
> 
> Signed-Off-By: Robert Love <rml@novell.com>
> 
>  drivers/char/Makefile   |    2 
>  drivers/char/inotify.c  |  988 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/attr.c               |    6 
>  fs/inode.c              |    1 
>  fs/namei.c              |   17 
>  fs/open.c               |    5 
>  fs/read_write.c         |   17 
>  fs/super.c              |    2 
>  include/linux/fs.h      |    4 
>  include/linux/inotify.h |   93 ++++
>  10 files changed, 1127 insertions(+), 8 deletions(-)
> 
> diff -urN linux-2.6.9-rc2/drivers/char/inotify.c linux/drivers/char/inotify.c
> --- linux-2.6.9-rc2/drivers/char/inotify.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux/drivers/char/inotify.c	2004-09-21 16:58:57.529151952 -0400
> @@ -0,0 +1,988 @@
> +/*
> + * Inode based directory notifications for Linux.
> + *
> + * Copyright (C) 2004 John McCutchan
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2, or (at your option) any
> + * later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +/* TODO: 
> + * use rb tree so looking up watcher by watcher descriptor is faster.
> + * dev->watch_count is incremented twice for each watcher
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/poll.h>
> +#include <linux/miscdevice.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/writeback.h>
> +#include <linux/inotify.h>
> +
> +#define MAX_INOTIFY_DEVS		8	/* maximum open devices */
> +#define MAX_INOTIFY_DEV_WATCHERS	8192	/* max watchers per device */
> +#define MAX_INOTIFY_QUEUED_EVENTS	256	/* max events we queue */
> +
> +#define INOTIFY_DEV_TIMER_TIME		(jiffies + (HZ/4))

                                                (jiffies + (HZ / 4))

> +
> +static atomic_t watcher_count;		/* < MAX_INOTIFY_DEVS */
> +
> +static kmem_cache_t *watcher_cache;
> +static kmem_cache_t *kevent_cache;
> +
> +/* For debugging */
> +static int event_object_count;
> +static int watcher_object_count;
> +static int inode_ref_count;
> +static int inotify_debug_flags;
> +#define iprintk(f, str...) if (inotify_debug_flags & f) printk (KERN_ALERT str)
> +
> +/*
> + * For each inotify device we need to keep a list of events queued on it,
> + * a list of inodes that we are watching and other stuff.
> + */
> +struct inotify_device {
> +	struct list_head 	events;
> +	atomic_t		event_count;
> +	struct list_head 	watchers;
> +	int			watcher_count;
> +	wait_queue_head_t 	wait;
> +	struct timer_list	timer;
> +	char			read_state;
> +	spinlock_t		lock;
> +	unsigned long	bitmask[MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG];
> +};
> +
> +struct inotify_watcher {
> +	int 			wd;	/* watcher descriptor */
> +	unsigned long		mask;
> +	struct inode *		inode;
                                *inode;
> +	struct inotify_device *	dev;


> +	struct list_head	d_list;	/* device list */
> +	struct list_head	i_list;	/* inode list */
> +	struct list_head	u_list;	/* unmount list */
> +};
> +
> +/*
> + * A list of these is attached to each instance of the driver
> + * when the drivers read() gets called, this list is walked and
> + * all events that can fit in the buffer get delivered
> + */
> +struct inotify_kernel_event {
> +        struct list_head        list;
> +	struct inotify_event	event;
> +};
> +#define list_to_inotify_kernel_event(pos) list_entry((pos), struct inotify_kernel_event, list)
> +
> +static int find_inode (const char __user *dirname, struct inode **inode)
> +{
> +	struct nameidata nd;
> +	int error;
> +
> +	error = __user_walk (dirname, LOOKUP_FOLLOW, &nd);

                __user_walk(

spaces before ( only on if, while, for, etc.

> +	if (error) {
> +		iprintk(INOTIFY_DEBUG_INODE, "could not find inode\n");
> +		goto out;
> +	}
> +
> +	*inode = nd.dentry->d_inode;
> +	__iget (*inode);

ditto

> +	iprintk(INOTIFY_DEBUG_INODE, "ref'd inode\n");
> +	inode_ref_count++;
> +	path_release(&nd);
> +
> +out:
> +	return error;
> +}
> +
> +static void unref_inode (struct inode *inode)

ditto, stop here

> +{
> +	inode_ref_count--;
> +	iprintk(INOTIFY_DEBUG_INODE, "unref'd inode\n");
> +	iput (inode);
> +}
> +
> +struct inotify_kernel_event *kernel_event (int wd, int mask,
> +					   const char *filename)
> +{
> +	struct inotify_kernel_event *kevent;
> +
> +	kevent = kmem_cache_alloc (kevent_cache, GFP_ATOMIC);
> +
> +
> +	if (!kevent) {

kevent == NULL (I like !pointer, but hey, Linus says NULL is cute, so...)

> +		iprintk(INOTIFY_DEBUG_ALLOC,
> +			"failed to alloc kevent (%d,%d)\n", wd, mask);
> +		goto out;
> +	}
> +
> +	iprintk(INOTIFY_DEBUG_ALLOC,
> +		"alloced kevent %p (%d,%d)\n", kevent, wd, mask);
> +
> +	kevent->event.wd = wd;
> +	kevent->event.mask = mask;
> +	INIT_LIST_HEAD(&kevent->list);
> +
> +	if (filename) {
> +		iprintk(INOTIFY_DEBUG_FILEN,
> +			"filename for event was %p %s\n", filename, filename);
> +		strncpy (kevent->event.filename, filename,
> +			 INOTIFY_FILENAME_MAX);
> +		kevent->event.filename[INOTIFY_FILENAME_MAX-1] = '\0';
> +		iprintk(INOTIFY_DEBUG_FILEN,
> +			"filename after copying %s\n", kevent->event.filename);
> +	} else {
> +		iprintk(INOTIFY_DEBUG_FILEN, "no filename for event\n");
> +		kevent->event.filename[0] = '\0';
> +	}
> +
> +	event_object_count++;
> +
> +out:
> +	return kevent;
> +}
> +
> +void delete_kernel_event (struct inotify_kernel_event *kevent)
> +{
> +	if (!kevent)
> +		return;
> +
> +	event_object_count--;
> +
> +	INIT_LIST_HEAD(&kevent->list);
> +	kevent->event.wd = -1;
> +	kevent->event.mask = 0;
> +
> +	iprintk(INOTIFY_DEBUG_ALLOC, "free'd kevent %p\n", kevent);
> +	kmem_cache_free (kevent_cache, kevent);
> +}
> +
> +#define inotify_dev_has_events(dev) (!list_empty(&dev->events))
> +#define inotify_dev_get_event(dev) (list_to_inotify_kernel_event(dev->events.next))
> +/* Does this events mask get sent to the watcher ? */
> +#define event_and(event_mask,watchers_mask) 	((event_mask == IN_UNMOUNT) || \
> +						(event_mask == IN_IGNORED) || \
> +						(event_mask & watchers_mask))
> +
> +/* dev->lock == locked before calling */
> +static void inotify_dev_queue_event (struct inotify_device *dev,
> +				     struct inotify_watcher *watcher,
> +				     int mask, const char *filename)
> +{
> +	struct inotify_kernel_event *kevent;
> +
> +	if (atomic_read(&dev->event_count) == MAX_INOTIFY_QUEUED_EVENTS) {
> +		iprintk(INOTIFY_DEBUG_EVENTS,
> +			"event queue for %p overflowed\n", dev);
> +		return;
> +	}
> +
> +	if (!event_and(mask, watcher->inode->watchers_mask) ||
> +			!event_and(mask, watcher->mask))
> +		return;
> +
> +	atomic_inc(&dev->event_count);
> +
> +	kevent = kernel_event (watcher->wd, mask, filename);
> +
> +	if (!kevent)
> +		iprintk(INOTIFY_DEBUG_EVENTS,
> +			"failed to queue event %x for %p\n", mask, dev);
> +
> +	list_add_tail(&kevent->list, &dev->events);
> +
> +	iprintk(INOTIFY_DEBUG_EVENTS, "queued event %x for %p\n", mask, dev);
> +}
> +
> +static void inotify_dev_event_dequeue (struct inotify_device *dev)
> +{
> +	struct inotify_kernel_event *kevent;
> +
> +	if (!inotify_dev_has_events (dev))
> +		return;
> +
> +	kevent = inotify_dev_get_event(dev);
> +
> +	list_del(&kevent->list);
> +	atomic_dec(&dev->event_count);
> +
> +	delete_kernel_event (kevent);
> +
> +	iprintk(INOTIFY_DEBUG_EVENTS, "dequeued event on %p\n", dev);
> +}
> +
> +static int inotify_dev_get_wd (struct inotify_device *dev)
> +{
> +	int wd;

        int wd = -1;
	and remove line below, 80x25 rules :P
> +
> +	wd = -1;
> +
> +	if (!dev)
> +		return -1;
> +
> +	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS)
> +		return -1;
> +
> +	dev->watcher_count++;
> +
> +	wd = find_first_zero_bit (dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
> +
> +	set_bit (wd, dev->bitmask);
> +
> +	return wd;
> +}
> +
> +static int inotify_dev_put_wd (struct inotify_device *dev, int wd)
> +{
> +	if (!dev || wd < 0)
> +		return -1;
> +
> +	dev->watcher_count--;
> +
> +	clear_bit (wd, dev->bitmask);
> +
> +	return 0;
> +}
> +
> +
> +static struct inotify_watcher *create_watcher (struct inotify_device *dev,
> +					       int mask, struct inode *inode)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	watcher = kmem_cache_alloc (watcher_cache, GFP_KERNEL);
> +
> +	if (!watcher) {
> +		iprintk(INOTIFY_DEBUG_ALLOC,
> +			"failed to allocate watcher (%p,%d)\n", inode, mask);
> +		return NULL;
> +	}
> +
> +	watcher->wd = -1;
> +	watcher->mask = mask;
> +	watcher->inode = inode;
> +	watcher->dev = dev;

kernel _networking_ style encourages aligning the assignments:

        watcher->wd	= -1;
	watcher->mask	= mask;
	watcher->inode	= inode;

	and so on...

> +	INIT_LIST_HEAD(&watcher->d_list);
> +	INIT_LIST_HEAD(&watcher->i_list);
> +	INIT_LIST_HEAD(&watcher->u_list);
> +
> +	spin_lock(&dev->lock);
> +	watcher->wd = inotify_dev_get_wd (dev);
> +	spin_unlock(&dev->lock);
> +
> +	if (watcher->wd < 0) {
> +		iprintk(INOTIFY_DEBUG_ERRORS,
> +			"Could not get wd for watcher %p\n", watcher);
> +		iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
> +		kmem_cache_free (watcher_cache, watcher);
> +		watcher = NULL;
> +		return watcher;

		return NULL;
		and remove the watcher = NULL; ...

> +	}
> +
> +	watcher_object_count++;

or:

out:
	and goto out; in the previous return?

> +	return watcher;
> +}
> +
> +/* Must be called with dev->lock held */
> +static void delete_watcher (struct inotify_device *dev,
> +			    struct inotify_watcher *watcher)
> +{
> +	inotify_dev_put_wd (dev, watcher->wd);
> +
> +	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
> +
> +	kmem_cache_free (watcher_cache, watcher);
> +
> +	watcher_object_count--;
> +}
> +
> +static struct inotify_watcher *inode_find_dev (struct inode *inode,
> +					       struct inotify_device *dev)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	list_for_each_entry (watcher, &inode->watchers, i_list) {
> +		if (watcher->dev == dev)
> +			return watcher;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct inotify_watcher *dev_find_wd (struct inotify_device *dev, int wd)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	list_for_each_entry (watcher, &dev->watchers, d_list) {
> +		if (watcher->wd == wd)
> +			return watcher;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int inotify_dev_is_watching_inode (struct inotify_device *dev,
> +					  struct inode *inode)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	list_for_each_entry (watcher, &dev->watchers, d_list)
> +		if (watcher->inode == inode) {
> +			return 1;
> +	}
> +	
> +	return 0;
> +}
> +
> +static int inotify_dev_add_watcher (struct inotify_device *dev,
> +				    struct inotify_watcher *watcher)
> +{
> +	int error;
> +
> +	error = 0;
> +
> +	if (!dev || !watcher) {
> +		error = -EINVAL;
> +		goto out;
> +	}
> +	if (dev_find_wd(dev, watcher->wd)) {
> +		error = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (dev->watcher_count == MAX_INOTIFY_DEV_WATCHERS) {
> +		error = -ENOSPC;
> +		goto out;
> +	}
> +	list_add(&watcher->d_list, &dev->watchers);
> +
> +out:
> +	return error;

See? goto aren't harmful in all cases after all :P

> +}
> +
> +static int inotify_dev_rm_watcher (struct inotify_device *dev,
> +				   struct inotify_watcher *watcher)
> +{
> +	int error;
> +
> +	error = -EINVAL;
> +	if (watcher) {
> +		inotify_dev_queue_event (dev, watcher, IN_IGNORED, NULL);
> +		list_del(&watcher->d_list);
> +		error = 0;
> +	} 
> +
> +	return error;
> +}
> +
> +void inode_update_watchers_mask (struct inode *inode)
> +{
> +	struct inotify_watcher *watcher;
> +	unsigned long new_mask;
> +
> +	new_mask = 0;
> +	list_for_each_entry(watcher, &inode->watchers, i_list)
> +		new_mask |= watcher->mask;
> +
> +	inode->watchers_mask = new_mask;
> +}
> +
> +static int inode_add_watcher (struct inode *inode,
> +			      struct inotify_watcher *watcher)
> +{
> +	if (!inode || !watcher || inode_find_dev(inode, watcher->dev))
> +		return -EINVAL;
> +
> +	list_add(&watcher->i_list, &inode->watchers);
> +	inode->watcher_count++;
> +
> +	inode_update_watchers_mask (inode);
> +
> +	return 0;
> +}
> +
> +static int inode_rm_watcher (struct inode *inode,
> +			     struct inotify_watcher *watcher)
> +{
> +	if (!inode || !watcher)
> +		return -EINVAL;
> +
> +	list_del(&watcher->i_list);
> +	inode->watcher_count--;
> +
> +	inode_update_watchers_mask (inode);
> +
> +	return 0;
> +}
> +
> +/* Kernel API */
> +
> +void inotify_inode_queue_event (struct inode *inode, unsigned long mask,
> +				const char *filename)
> +{
> +	struct inotify_watcher *watcher;
> +
> +	spin_lock(&inode->i_lock);
> +
> +	list_for_each_entry (watcher, &inode->watchers, i_list) {
> +			spin_lock(&watcher->dev->lock);
> +			inotify_dev_queue_event (watcher->dev, watcher,
> +						 mask, filename);
> +			spin_unlock(&watcher->dev->lock);
> +	}
> +
> +	spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL_GPL(inotify_inode_queue_event);

Cool, EXPORT_SYMBOL{_GPL} just after the function, way to go!

> +
> +void inotify_dentry_parent_queue_event(struct dentry *dentry,
> +				       unsigned long mask, const char *filename)
> +{
> +	struct dentry *parent;
> +
> +	spin_lock(&dentry->d_lock);
> +	dget (dentry->d_parent);
> +	parent = dentry->d_parent;
> +	inotify_inode_queue_event(parent->d_inode, mask, filename);
> +	dput (parent);
> +	spin_unlock(&dentry->d_lock);
> +}
> +EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
> +
> +static void ignore_helper (struct inotify_watcher *watcher, int event)
> +{
> +	struct inotify_device *dev;
> +	struct inode *inode;
> +
> +	spin_lock(&watcher->dev->lock);
> +	spin_lock(&watcher->inode->i_lock);
> +
> +	inode = watcher->inode;
> +	dev = watcher->dev;
> +
> +	if (event)
> +		inotify_dev_queue_event (dev, watcher, event, NULL);
> +
> +	inode_rm_watcher (inode, watcher);
> +	inotify_dev_rm_watcher (watcher->dev, watcher);
> +	list_del(&watcher->u_list);
> +
> +	spin_unlock(&inode->i_lock);
> +
> +	delete_watcher(dev, watcher);
> +
> +	spin_unlock(&dev->lock);
> +
> +	unref_inode (inode);
> +}
> +
> +static void process_umount_list (struct list_head *umount)
> +{
> +	struct inotify_watcher *watcher, *next;
> +
> +	list_for_each_entry_safe (watcher, next, umount, u_list)
> +		ignore_helper (watcher, IN_UNMOUNT);

For consistency, in the previous list_for_entry{_whatever} braces were
being being used, but not here, remove the braces in the other cases where
just one statement is the loop body? :)

> +}
> +
> +static void build_umount_list (struct list_head *head, struct super_block *sb,
> +			       struct list_head *umount)
> +{
> +	struct inode *	inode;

what for the spaces after the *? :)

> +
> +	list_for_each_entry (inode, head, i_list) {
> +		struct inotify_watcher *watcher;
> +
> +		if (inode->i_sb != sb)
> +			continue;
> +		spin_lock(&inode->i_lock);
> +		list_for_each_entry (watcher, &inode->watchers, i_list)
> +			list_add (&watcher->u_list, umount);
> +		spin_unlock(&inode->i_lock);
> +	}
> +}
> +
> +void inotify_super_block_umount (struct super_block *sb)
> +{
> +	struct list_head umount;
> +
> +	INIT_LIST_HEAD(&umount);
> +
> +	spin_lock(&inode_lock);
> +	build_umount_list (&inode_in_use, sb, &umount);
> +	spin_unlock(&inode_lock);
> +
> +	process_umount_list (&umount);
> +}
> +EXPORT_SYMBOL_GPL(inotify_super_block_umount);
> +
> +/* The driver interface is implemented below */
> +
> +static unsigned int inotify_poll(struct file *file, poll_table *wait) {
> +        struct inotify_device *dev;
> +
> +        dev = file->private_data;

	   struct inotify_device *dev = file->private_data; here please

> +
> +
> +        poll_wait(file, &dev->wait, wait);
> +
> +        if (inotify_dev_has_events(dev))
> +                return POLLIN | POLLRDNORM;
> +
> +        return 0;
> +}
> +
> +#define MAX_EVENTS_AT_ONCE 20
> +static ssize_t inotify_read(struct file *file, __user char *buf,
> +			    size_t count, loff_t *pos)
> +{
> +	size_t out;

	out = -ENOMEM;  and remove the assignment below? declare it closer
	to the kmalloc even

> +	struct inotify_event *eventbuf;
> +	struct inotify_kernel_event *kevent;
> +	struct inotify_device *dev;
> +	char *obuf;
> +	int err;
> +	int events;
> +	int event_count;
> +
> +	DECLARE_WAITQUEUE(wait, current);	
> +
> +	out = -ENOMEM;
> +	eventbuf = kmalloc(sizeof(struct inotify_event) * MAX_EVENTS_AT_ONCE, 
> +			GFP_KERNEL);
> +	if (!eventbuf)
> +		goto out;
> +	events = 0;
> +	event_count = 0;
> +	out = 0;
> +	err = 0;
> +
> +	obuf = buf;
> +
> +	dev = file->private_data;
> +
> +	/* We only hand out full inotify events */
> +	if (count < sizeof(struct inotify_event)) {
> +		out = -EINVAL;
> +		goto out;
> +	}
> +
> +	events = count / sizeof(struct inotify_event);
> +
> +	if (events > MAX_EVENTS_AT_ONCE)
> +		events = MAX_EVENTS_AT_ONCE;
> +
> +	if (!inotify_dev_has_events(dev)) {
> +		if (file->f_flags & O_NONBLOCK) {
> +			out = -EAGAIN;
> +			goto out;
> +		}
> +	}
> +
> +	spin_lock_irq(&dev->lock);
> +
> +	add_wait_queue(&dev->wait, &wait);
> +repeat:
> +	if (signal_pending(current)) {
> +		spin_unlock_irq (&dev->lock);
> +		out = -ERESTARTSYS;
> +		set_current_state (TASK_RUNNING);
> +		remove_wait_queue(&dev->wait, &wait);
> +		goto out;
> +	}
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	if (!inotify_dev_has_events (dev)) {
> +		spin_unlock_irq (&dev->lock);
> +		schedule ();
> +		spin_lock_irq (&dev->lock);
> +		goto repeat;
> +	}
> +
> +	set_current_state(TASK_RUNNING);
> +	remove_wait_queue(&dev->wait, &wait);
> +
> +	err = !access_ok(VERIFY_WRITE, (void *)buf,
> +			 sizeof(struct inotify_event));
> +
> +	if (err) {
> +		out = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* Copy all the events we can to the event buffer */
> +	for (event_count = 0; event_count < events; event_count++) {
> +		kevent = inotify_dev_get_event(dev);
> +		eventbuf[event_count] = kevent->event;
> +		inotify_dev_event_dequeue(dev);
> +	}
> +
> +	spin_unlock_irq(&dev->lock);
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
> +
> +static void inotify_dev_timer (unsigned long data)
> +{
> +	struct inotify_device *dev;
> +
> +	dev = (struct inotify_device *) data;

ditto

> +
> +	if (!dev)
> +		return;
> +
> +	/* reset the timer */
> +	mod_timer(&dev->timer, INOTIFY_DEV_TIMER_TIME);
> +
> +	/* wake up anything waiting on poll */
> +	if (inotify_dev_has_events (dev))
> +		wake_up_interruptible(&dev->wait);
> +}
> +
> +static int inotify_open(struct inode *inode, struct file *file) {
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
> +	memset(dev->bitmask, 0, MAX_INOTIFY_DEV_WATCHERS);
> +
> +	INIT_LIST_HEAD(&dev->events);
> +	INIT_LIST_HEAD(&dev->watchers);
> +	init_timer(&dev->timer);
> +	init_waitqueue_head(&dev->wait);
> +
> +	atomic_set(&dev->event_count, 0);
> +	dev->watcher_count = 0;
> +	dev->lock = SPIN_LOCK_UNLOCKED;
> +	dev->read_state = 0;
> +
> +	file->private_data = dev;
> +
> +	dev->timer.data = (unsigned long) dev;
> +	dev->timer.function = inotify_dev_timer;
> +	dev->timer.expires = INOTIFY_DEV_TIMER_TIME;
> +
> +	add_timer(&dev->timer);
> +
> +	printk(KERN_ALERT "inotify device opened\n");
> +
> +	return 0;
> +}
> +
> +static void inotify_release_all_watchers (struct inotify_device *dev)
> +{
> +	struct inotify_watcher *watcher,*next;
> +
> +	list_for_each_entry_safe(watcher, next, &dev->watchers, d_list)
> +		ignore_helper(watcher, 0);
> +}
> +
> +static void inotify_release_all_events (struct inotify_device *dev)
> +{
> +	spin_lock(&dev->lock);
> +	while (inotify_dev_has_events(dev))
> +		inotify_dev_event_dequeue(dev);
> +	spin_unlock(&dev->lock);
> +}
> +
> +
> +static int inotify_release(struct inode *inode, struct file *file)
> +{
> +	if (file->private_data) {
> +		struct inotify_device *dev;
> +
> +		dev = (struct inotify_device *) file->private_data;
> +		del_timer_sync(&dev->timer);
> +		inotify_release_all_watchers(dev);
> +		inotify_release_all_events(dev);
> +		kfree (dev);
> +	}
> +
> +	printk(KERN_ALERT "inotify device released\n");
> +
> +	atomic_dec(&watcher_count);
> +	return 0;
> +}
> +
> +static int inotify_watch (struct inotify_device *dev,
> +			  struct inotify_watch_request *request)
> +{
> +	int err;
> +	struct inode *inode;
> +	struct inotify_watcher *watcher;
> +	err = 0;
> +
> +	err = find_inode (request->dirname, &inode);

why assing 0 just to overwrite it?

	int err = find_inode (request->dirname, &inode);


Ok, </nitpick> :-)
