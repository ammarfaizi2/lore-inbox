Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965306AbWHWXWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbWHWXWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbWHWXWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:22:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965306AbWHWXWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:22:43 -0400
Date: Wed, 23 Aug 2006 16:12:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 11/18] 2.6.17.9 perfmon2 patch for review: file related
 operations support
Message-Id: <20060823161248.592422da.akpm@osdl.org>
In-Reply-To: <200608230806.k7N862CD000468@frankl.hpl.hp.com>
References: <200608230806.k7N862CD000468@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:06:02 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This patch contains the new generic file related functions.
> 
> A perfmon2 context is identified by a file descriptor and
> we leverage certain kernel mechanisms related to files.
> In particular we use:
> 	- read
> 	- select, poll
> 	- fcntl
> 	- close
> 	- mmap
> 
> Support for those operations is implemented in perfmon_file.c.
> 
> 
> pfm_read():
> 	- implements the callback for the read() operation. It is used to extract
> 	  overflow notification messages. Only one message can be extracted per call.
> 	  This can be a blocking call is the file is setup that way.
> 
> pfm_poll():
> 	- support for poll() and select()
> 	
> pfm_fasync():
> 	- support for FASYNC for fcntl(). Is used to received asynchronous notifications via SIGIO
> 
> pfm_mmap():
> 	- handle remapping read-only of the kernel sampling buffer to userland
> 
>
> ...
>
> +
> +static struct page *pfm_buf_map_pagefault(struct vm_area_struct *vma,
> +					  unsigned long address, int *type)
> +{
> +	void *kaddr;
> +	struct pfm_context *ctx;
> +	struct page *page;
> +	size_t size;
> +
> +	ctx = vma->vm_private_data;
> +	if (ctx == NULL) {
> +		PFM_DBG("no ctx");
> +		return NOPAGE_SIGBUS;
> +	}
> +	size = ctx->smpl_size;
> +
> +	if ( (address < (unsigned long) vma->vm_start) ||
> +	     (address > (unsigned long) (vma->vm_start + size)) )

>= ?

> +ssize_t __pfmk_read(struct pfm_context *ctx, union pfm_msg *msg_buf, int noblock)
> +{
> +	union pfm_msg *msg;
> +	ssize_t ret = 0;
> +	unsigned long flags;
> +
> +	/*
> +	 * we must masks interrupts to avoid a race condition
> +	 * with the PMU interrupt handler.
> +	 */
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	if(PFM_CTXQ_EMPTY(ctx) == 0)
> +		goto fast_path;
> +
> +	ret = -EAGAIN;
> +	if (noblock)
> +		goto empty;
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	ret = wait_for_completion_interruptible(ctx->msgq_comp);

We do an interruptible wait, but no action is taken if the wait was
actually interrupted?

> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	if(PFM_CTXQ_EMPTY(ctx))
> +		goto empty;
> +
> +fast_path:
> +
> +	/*
> +	 * extract message from queue
> +	 *
> +	 * it is possible that the message was stolen by another thread
> +	 * before we could protect the context after schedule()
> +	 */
> +	msg = pfm_get_next_msg(ctx);
> +	if (unlikely(msg == NULL))
> +		goto empty;
> +
> +	ret = sizeof(*msg);
> +
> +	/*
> +	 * we must make a local copy before we unlock
> +	 * to ensure that the message queue cannot fill
> +	 * (overwriting our message) up before
> +	 * we do copy_to_user() which cannot be done
> +	 * with interrupts masked.
> +	 */
> +	*msg_buf = *msg;
> +
> +	PFM_DBG("type=%d ret=%zd", msg->type, ret);
> +
> +empty:
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(__pfmk_read);

Can all the perfmon exports be EXPORT_SYMBOL_GPL()?

> +ssize_t __pfm_read(struct pfm_context *ctx, union pfm_msg *msg_buf, int non_block)
> +{
> +	union pfm_msg *msg;
> +	ssize_t ret = 0;
> +	unsigned long flags;
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	/*
> +	 * we must masks interrupts to avoid a race condition
> +	 * with the PMU interrupt handler.
> +	 */
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	if(PFM_CTXQ_EMPTY(ctx) == 0)
> +		goto fast_path;
> +retry:
> +	/*
> +	 * check non-blocking read. we include it
> +	 * in the loop in case another thread modifies
> +	 * the propoerty of the file while the current thread
> +	 * is looping here
> +	 */
> +
> +      	ret = -EAGAIN;

whitepsace broke.

> +	if(non_block)
> +		goto abort_locked;
> +
> +	/*
> +	 * put ourself on the wait queue
> +	 */
> +	add_wait_queue(&ctx->msgq_wait, &wait);
> +
> +	for (;;) {
> +		/*
> +		 * check wait queue
> +		 */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		PFM_DBG("head=%d tail=%d",
> +			ctx->msgq_head,
> +			ctx->msgq_tail);
> +
> +		spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +		/*
> +		 * wait for message
> +		 */
> +		schedule();
> +
> +		spin_lock_irqsave(&ctx->lock, flags);
> +
> +		/*
> +		 * check pending signals
> +		 */
> +		ret = -ERESTARTSYS;
> +		if(signal_pending(current))
> +			break;
> +
> +		ret = 0;
> +		if(PFM_CTXQ_EMPTY(ctx) == 0)
> +			break;
> +	}
> +
> +	set_current_state(TASK_RUNNING);
> +
> +	remove_wait_queue(&ctx->msgq_wait, &wait);
> +
> +	PFM_DBG("back to running ret=%zd", ret);
> +
> +	if (ret < 0)
> +		goto abort_locked;
> +
> +fast_path:

The above code is all a bit unidiomatic.  Normally we'd do something like:

	spin_lock_irqsave(&ctx->lock, flags);
	while (PFM_CTXQ_EMPTY(ctx) != 0) {
		prepare_to_wait(...);
		spin_unlock_irqrestore(&ctx->lock, flags);
		schedule();
		finish_wait(...);
		spin_lock_irqsave(&ctx->lock, flags);
	}


> +	/*
> +	 * extract message from queue
> +	 *
> +	 * it is possible that the message was stolen by another thread
> +	 * before we could protect the context after schedule()
> +	 */
> +	msg = pfm_get_next_msg(ctx);
> +	if (unlikely(msg == NULL))
> +		goto retry;
> +
> +	/*
> +	 * we must make a local copy before we unlock
> +	 * to ensure that the message queue cannot fill
> +	 * (overwriting our message) up before
> +	 * we do copy_to_user() which cannot be done
> +	 * with interrupts masked.
> +	 */
> +	*msg_buf = *msg;
> +
> +	ret = sizeof(*msg);
> +
> +	PFM_DBG("type=%d size=%zu", msg->type, ret);
> +
> +abort_locked:
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	/*
> +	 * ret = EAGAIN when non-blocking and nothing is
> +	 * in thequeue.
> +	 *
> +	 * ret = ERESTARTSYS when signal pending
> +	 *
> +	 * otherwise ret = size of message
> +	 */
> +	return ret;
> +}
> +
> +static ssize_t pfm_read(struct file *filp, char __user *buf, size_t size,
> +			loff_t *ppos)
> +{
> +	struct pfm_context *ctx;
> +	union pfm_msg msg_buf;
> +	int non_block, ret;
> +
> +	ctx = filp->private_data;
> +	if (ctx == NULL) {
> +		PFM_ERR("no ctx for pfm_read");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * cannot extract partial messages.
> +	 * check even when there is no message
> +	 *
> +	 * cannot extract more than one message per call. Bytes
> +	 * above sizeof(msg) are ignored.
> +	 */
> +	if (size < sizeof(msg_buf)) {
> +		PFM_DBG("message is too small size=%zu must be >=%zu)",
> +			size,
> +			sizeof(msg_buf));
> +		return -EINVAL;
> +	}
> +
> +	non_block = filp->f_flags & O_NONBLOCK;
> +
> +	ret =  __pfm_read(ctx, &msg_buf, non_block);
> +	if (ret > 0) {
> +  		if(copy_to_user(buf, &msg_buf, sizeof(msg_buf)))
> +			ret = -EFAULT;
> +	}
> +	return ret;
> +}
> +
> +static ssize_t pfm_write(struct file *file, const char __user *ubuf,
> +			  size_t size, loff_t *ppos)
> +{
> +	PFM_DBG("pfm_write called");
> +	return -EINVAL;
> +}
> +
> +static unsigned int pfm_poll(struct file *filp, poll_table * wait)
> +{
> +	struct pfm_context *ctx;
> +	unsigned long flags;
> +	unsigned int mask = 0;
> +
> +	if (!pfm_is_fd(filp)) {

This wasn't checked in the ->read() implementation.  It should be impossible?

> +		PFM_ERR("pfm_poll bad magic");
> +		return 0;
> +	}
> +
> +	ctx = filp->private_data;
> +	if (ctx == NULL) {
> +		PFM_ERR("pfm_poll no ctx");
> +		return 0;
> +	}
> +
> +
> +	PFM_DBG("before poll_wait");
> +
> +	poll_wait(filp, &ctx->msgq_wait, wait);
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	if (PFM_CTXQ_EMPTY(ctx) == 0)
> +		mask =  POLLIN | POLLRDNORM;
> +
> +	spin_unlock_irqrestore(&ctx->lock, flags);

Was this locking actually needed?

> +	PFM_DBG("after poll_wait mask=0x%x", mask);
> +
> +	return mask;
> +}
> +
>
> ...
>
> +
> +/*
> + * pfmfs should _never_ be mounted by userland - too much of security hassle,
> + * no real gain from having the whole whorehouse mounted. So we don't need
> + * any operations on the root directory. However, we need a non-trivial
> + * d_name - pfm: will go nicely and kill the special-casing in procfs.
> + */

hm, interesting.

> +static struct vfsmount *pfmfs_mnt;
> +
> +int __init init_pfm_fs(void)
> +{
> +	int err = register_filesystem(&pfm_fs_type);
> +	if (!err) {
> +		pfmfs_mnt = kern_mount(&pfm_fs_type);
> +		err = PTR_ERR(pfmfs_mnt);
> +		if (IS_ERR(pfmfs_mnt))
> +			unregister_filesystem(&pfm_fs_type);
> +		else
> +			err = 0;
> +	}
> +	return err;
> +}
> +
> +static void __exit exit_pfm_fs(void)
> +{
> +	unregister_filesystem(&pfm_fs_type);
> +	mntput(pfmfs_mnt);
> +}

<wonders whether securityfs_exit is missing a mntput>


