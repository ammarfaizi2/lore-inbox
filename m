Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWEVT3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWEVT3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEVT3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:29:03 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:29117 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751136AbWEVT3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:29:01 -0400
From: David Brownell <david-b@pacbell.net>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: races in drivers/usb/gadget/inode.c, leak fix in the same file
Date: Mon, 22 May 2006 12:28:56 -0700
User-Agent: KMail/1.7.1
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <20060426062048.GG27946@ftp.linux.org.uk>
In-Reply-To: <20060426062048.GG27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221228.58582.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 11:20 pm, Al Viro wrote:

Thanks for the review/feedback.  The AIO interfaces have evidently
had some incompatible changes since that code was first written
(as turned up by Alan Stern's recent investigations), and it's
always had a few glitchey (but uncommon) corner cases.


> activate_ep_files() allocates a bunch of ep_data, creates inodes and
> dentries for them and sticks them into a cyclic list.  inode->u.generic_ip
> is set to created ep_data, refcount is 1.
> 
> destroy_ep_files() goes through that cyclic list, gets dentry from each
> ep_data on it and drops ep_data.  Then it kills dentry and inode by
>                 /* break link to dcache */
>                 mutex_lock (&parent->i_mutex);
>                 d_delete (dentry);
>                 dput (dentry);
>                 mutex_unlock (&parent->i_mutex);
> Tries to kill, anyway.  The thing is, ep_open() (->open() on that sucker)
> does

Hmm ... 


> static int
> ep_open (struct inode *inode, struct file *fd)
> {
>         struct ep_data          *data = inode->u.generic_ip;
>         int                     value = -EBUSY;
> 
>         if (down_interruptible (&data->lock) != 0)
>                 return -EINTR;
> followed eventually by pinning data (i.e. ep_data for that inode) down.
> 
> It's way too late - by the time we enter ep_open(), inode->u.generic_ip
> might be already pointing to freed memory.
> 
> AFAICS, the cheapest way to deal with that would be to set ->u.generic_ip
> to NULL before dropping ep_data in ep_destroy_files(), have that done
> under global spinlock and have ep_open() et.al. start with checking if
> the pointer is NULL under the same spinlock and grabbing a reference if
> it isn't.

Sounds right.  I'll look at it some more, and test.


> There's another question: opened files are opened; what protects them
> from gadgetfs_unbind() freeing ep->req while ep is still pinned down
> by an opened file?  We do not hold dev->lock or ep->lock there...

Controller drivers should have canceled all pending requests before
they call the unbind() method ... and must have completed them all by
the time ep_disable() returnes.  Two key invariants:  the controller
driver holds no more usb_request objects, and it won't accept any more
until after the unbind() completes and some new driver is bound.

Now, there are two I/O paths.  The AIO path dynamically allocates
the usb_request objects, one per kiocb, and deallocates them as soon
as the request completes.  So, no issue there.  And for synchronous
I/O paths, there's a task in ep_io() which holds the ep->lock ... and
the return paths there don't reference ep->req.


> One more: what protects dev->state?  I don't see any lock that would
> be held over all places that modify it.

It should be the spinlock.  You're right, there are a few dodgy
references there.  Those should get fixed ... fortunately changing
that is reasonably infrequent.


> Oh, and a trivial leak fix, while we are at it:
> 
> Subject: [PATCH] fix leak in activate_ep_files()

I'd prefer the slightly more comprehensive one from Alan Stern.
Even if they _are_ rare we might as well handle all of them!  :)

- Dave

