Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTEWMHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTEWMHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:07:05 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:44689 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264029AbTEWMHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:07:04 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 23 May 2003 13:49:59 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
Message-ID: <20030523114959.GA7081@bytesex.org>
References: <3ECDEBC5.5030608@convergence.de> <20030523104722.B15725@infradead.org> <3ECDF3B1.8090902@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECDF3B1.8090902@convergence.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+generic_usercopy(struct inode *inode, struct file *file,

> >The name is a bit mislead.  maybe ioctl_usercopy?  ioctl_uaccess?
> 
> These are both fine IMHO.

I'd pick ioctl_usercopy() because the name is much like
the well-known copy_(from|to)_user functions.

> >Also file/inode should go away from the prototype (and the callback).
> >Only file is needed because inode == file->f_dentry->d_inode, and even
> >that one should be just some void *data instead.
> 
> I only copied the function from videodev.c and renamed it, so please 
> don't blame me for the way stuff is done there. 8-)

I've just pass through what the fops->ioctl() function is called with.
Sure file* is enougth?  If so, why the fops->ioctl() function is called
with both file and inode?

I think my v4l drivers just need file->priv_data (havn't looked at the
code through), so some void *data would work equally well for them.

> >>+	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
> >That's crap.  Please move this workaround to v4l not into generic code.
> 
> Is it possible to fix the definitons of the v4l ioctls instead without 
> breaking binary compatiblity?

Not trivial.  You'll have to support both old and new (fixed) ioctl
numbers, otherwise you'll break existing binaries.  Using the new ones
internally and mapping the old to the new ones somehow might work.

> >>+	case _IOC_WRITE:
> >>+	case (_IOC_WRITE | _IOC_READ):
> >>+		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
> >>+			parg = sbuf;
> >>+		} else {
> >>+			/* too big to allocate from stack */
> >>+			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
> >>+			if (NULL == mbuf)
> >>+				return -ENOMEM;
> >>+			parg = mbuf;
> >
> >
> >I wonder whether you should just kmalloc always. 

Point of implementing it this way is that (a) the kmalloc()/kfree()
isn't for free and (b) we shouldn't use plenty of stack memory.  So
using kmalloc for big chunks and allocate from stack for the small ones
looks like a good compromise to me.

> Since this function is always used in user context and the memory is 
> always freed afterwards, it should be possible to use vmalloc() or a 
> static buffer (what's the maximum size?) instead.

static buffer?  You are kidding, are you?

  Gerd

-- 
sigfault
