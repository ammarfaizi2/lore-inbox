Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWB1KPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWB1KPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWB1KPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:15:55 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:29603 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750807AbWB1KPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:15:54 -0500
To: jdike@addtoit.com
CC: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20060227183759.GA5669@ccure.user-mode-linux.org> (message from
	Jeff Dike on Mon, 27 Feb 2006 13:37:59 -0500)
Subject: Re: [PATCH] Add O_ASYNC support to FUSE
References: <20060227183759.GA5669@ccure.user-mode-linux.org>
Message-Id: <E1FE1sy-0006Bz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Feb 2006 11:15:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This adds asynchronous notification to FUSE - a FUSE server can
> request O_ASYNC on a /dev/fuse file descriptor and receive SIGIO
> when there is input available.
> 
> One subtlety - fuse_dev_fasync, which is called when O_ASYNC is
> requested, does no locking, unlike the other methods.  I think it's
> unnecessary, as the fuse_conn.fasync list is manipulated only by
> fasync_helper and kill_fasync, which provide their own locking.

Yes, but you need to use fuse_get_conn() and check the result (see
fuse_dev_poll()).

> It would also be wrong to use fuse_lock, as it's a spin lock and
> fasync_helper can sleep.  My one concern with this is the fuse_conn
> going away underneath fuse_dev_fasync - sys_fcntl takes a reference
> on the file struct, so this seems not to be a problem.

Yes, file holds a reference to fuse_conn.

> One possible bug - there is a wakeup in inode.c:fuse_put_super, but
> sticking a kill_fasync there causes BUGs because the /dev/fuse
> file struct seems to have gone away.

I don't see how that could happen.  fuse_dev_release() removes the
file from fc->fasync, and fasync_helper() and kill_fasync() are
protected with fasync_lock against racing with each other.

Although it may be possible that kill_fasync() races with the final
fput(), but as I see kill_fasync() only uses the file->f_owner field
which should still be valid before and during file->release().

Which BUG is triggered?

> So, this may be lacking when a FUSE mount is unmounted from
> underneath the server (is that possible, or must the server be
> killed in order to do the umount?).

Yes it's possible, it is how a normal unmount happens:

  - umount() called on the filesystem, filesystem unmounted
  - read on /dev/fuse returns -ENODEV
  - userspace filesystem exits gracefuly

> @@ -894,6 +895,7 @@ void fuse_abort_conn(struct fuse_conn *f
>  		end_requests(fc, &fc->pending);
>  		end_requests(fc, &fc->processing);
>  		wake_up_all(&fc->waitq);
> +		kill_fasync(&fc->fasync, SIGIO, POLLIN);

This should be POLL_IN too, no?

> +static int fuse_dev_fasync(int fd, struct file *file, int on)
> +{
> +	struct fuse_conn *fc;
> +
> +	/* No locking - fasync_helper does its own locking */
> +	fc = file->private_data;
> +	return(fasync_helper(fd, file, on, &fc->fasync));

I like this style better:

	return fasync_helper(fd, file, on, &fc->fasync);

Thanks,
Miklos
