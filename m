Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVIHFf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVIHFf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVIHFf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:35:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932506AbVIHFfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:35:55 -0400
Date: Thu, 8 Sep 2005 13:41:28 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050908054128.GD12220@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125574523.5025.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> +static inline void glock_put(struct gfs2_glock *gl)
> +{
> +	if (atomic_read(&gl->gl_count) == 1)
> +		gfs2_glock_schedule_for_reclaim(gl);
> +	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);
> +	atomic_dec(&gl->gl_count);
> +}
> 
> this code has a race

The first two lines of the function with the race are non-essential and
could be removed.  In the common case where there's no race, they just add
efficiency by moving the glock to the reclaim list immediately.
Otherwise, the scand thread would do it later when actively trying to
reclaim glocks.

> +static inline int queue_empty(struct gfs2_glock *gl, struct list_head *head)
> +{
> +	int empty;
> +	spin_lock(&gl->gl_spin);
> +	empty = list_empty(head);
> +	spin_unlock(&gl->gl_spin);
> +	return empty;
> +}
> 
> that looks like a racey interface to me... if so.. why bother locking at
> all?

The spinlock protects the list but is not the primary method of
synchronizing processes that are working with a glock.

When the list is in fact empty, there will be no race, and the locking
wouldn't be necessary.  In this case, the "glmutex" in the code fragment
below is preventing any change in the list, so we can safely release the
spinlock immediately.

When the list is not empty, then a process could be adding another entry
to the list without "glmutex" locked [1], making the spinlock necessary.
In this case we quit after queue_empty() returns and don't do anything
else, so releasing the spinlock immediately was still safe.

[1] A process that already holds a glock (i.e. has a "holder" struct on
the gl_holders list) is allowed to hold it again by adding another holder
struct to the same list.  It adds the second hold without locking glmutex.

        if (gfs2_glmutex_trylock(gl)) {
                if (gl->gl_ops == &gfs2_inode_glops) {
                        struct gfs2_inode *ip = get_gl2ip(gl);
                        if (ip && !atomic_read(&ip->i_count))
                                gfs2_inode_destroy(ip);
                }
                if (queue_empty(gl, &gl->gl_holders) &&
                    gl->gl_state != LM_ST_UNLOCKED)
                        handle_callback(gl, LM_ST_UNLOCKED);

                gfs2_glmutex_unlock(gl);
        }

There is a second way that queue_empty() is used, and that's within
assertions that the list is empty.  If the assertion is correct, locking
isn't necessary; locking is only needed if there's already another bug
causing the list to not be empty and the assertion to fail.

> static int gi_skeleton(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
> +		       gi_filler_t filler)
> +{
> +	unsigned int size = gfs2_tune_get(ip->i_sbd, gt_lockdump_size);
> +	char *buf;
> +	unsigned int count = 0;
> +	int error;
> +
> +	if (size > gi->gi_size)
> +		size = gi->gi_size;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	error = filler(ip, gi, buf, size, &count);
> +	if (error)
> +		goto out;
> +
> +	if (copy_to_user(gi->gi_data, buf, count + 1))
> +		error = -EFAULT;
> 
> where does count get a sensible value?

from filler()

We'll add comments in the code to document the things above.
Thanks,
Dave

