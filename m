Return-Path: <linux-kernel-owner+w=401wt.eu-S933040AbWLSW7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbWLSW7I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWLSW7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:59:08 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:49809 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbWLSW7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:59:07 -0500
Date: Tue, 19 Dec 2006 22:59:04 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Christoph Hellwig <hch@lst.de>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: mmap abuses in drm
In-Reply-To: <20061219114108.GA3189@lst.de>
Message-ID: <Pine.LNX.4.64.0612192242430.19116@skynet.skynet.ie>
References: <20061219114108.GA3189@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> static int i830_map_buffer(drm_buf_t * buf, struct file *filp)
> {
> 	drm_file_t *priv = filp->private_data;
> 	drm_device_t *dev = priv->head->dev;
> 	drm_i830_buf_priv_t *buf_priv = buf->dev_private;
> 	drm_i830_private_t *dev_priv = dev->dev_private;
> 	const struct file_operations *old_fops;
> 	unsigned long virtual;
> 	int retcode = 0;
>
> 	if (buf_priv->currently_mapped == I830_BUF_MAPPED)
> 		return -EINVAL;
>
> 	down_write(&current->mm->mmap_sem);
> 	old_fops = filp->f_op;
> 	filp->f_op = &i830_buffer_fops;
> 	dev_priv->mmap_buffer = buf;
> 	virtual = do_mmap(filp, 0, buf->total, PROT_READ | PROT_WRITE,
> 			  MAP_SHARED, buf->bus_address);
> 	dev_priv->mmap_buffer = NULL;
> 	filp->f_op = old_fops;
> 	if (IS_ERR((void *)virtual)) {	/* ugh */
> 		/* Real error */
> 		DRM_ERROR("mmap error\n");
> 		retcode = PTR_ERR((void *)virtual);
> 		buf_priv->virtual = NULL;
> 	} else {
> 		buf_priv->virtual = (void __user *)virtual;
> 	}
> 	up_write(&current->mm->mmap_sem);
>
> 	return retcode;
> }
>
> (and same crap in i810_dma.c aswell)
>
> Overriding the file operations just for mmap is for one thing racy
> as hell and for another very fragile as the mmap and nopage routines
> have to agree closely on what to do.
>
> Even further why in hell do you call do_mmap from a driver?  Mapping
> memory into userspace from anything but syscall dedicated to it is
> surely a desaster waiting to happen.
>
> Is there any chance we can get rid of this crap (and similar stuff in
> drm_bufs.c) as part of the memory manager overhaul?  Long-term I'd
> like to get rid of the do_mmap(_pgoff) export to avoid that people
> introduce similar braindamage again.
>

We can't change it without breaking userspace apps, so although the code 
is ugly it has been working for years is only used on i810 systems, most 
i830 use i915 driver now, and I don't think you can implement it any 
other way that will remain compatible with userspace... the drm doesn't 
use syscalls it uses ioctls, and the ioctl in this case is dedicated to 
mapping buffers into userspace...

The code is mainly concerned with mapping userspace-generic buffers 
whether they are in AGP/SG/framebuffer space to the userspace driver via 
a single ioctl call, the userspace doesn't need to know what type of 
buffers they are in theory, if you look at drm_mmap in drm_vm.c you'll see 
the other half of this great fun,

I'm not sure reimplementing this stuff is worth it, to just avoid 
do_mmap_pgoff export, and if it can be implemented without busting 
userspace all over the place..

The new memory manager system can't fix old systems, it isn't a fix old 
brain damage, it is a whole new interface, it just provides the new 
interfaces and the drivers have to be ported to it, but the old interfaces 
have to remain as far as I can see for ever.. the old memory manager 
interfaces are driver specific in a lot of cases and it would be quite 
impossible to overhaul and remain userspace compatible..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

