Return-Path: <linux-kernel-owner+w=401wt.eu-S932792AbWLSLl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbWLSLl2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWLSLl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:41:28 -0500
Received: from verein.lst.de ([213.95.11.210]:59266 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932792AbWLSLl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:41:27 -0500
Date: Tue, 19 Dec 2006 12:41:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: airlied@linux.ie, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: mmap abuses in drm
Message-ID: <20061219114108.GA3189@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, could someone explain what the heck is going on here:

static int i830_map_buffer(drm_buf_t * buf, struct file *filp)
{
	drm_file_t *priv = filp->private_data;
	drm_device_t *dev = priv->head->dev;
	drm_i830_buf_priv_t *buf_priv = buf->dev_private;
	drm_i830_private_t *dev_priv = dev->dev_private;
	const struct file_operations *old_fops;
	unsigned long virtual;
	int retcode = 0;

	if (buf_priv->currently_mapped == I830_BUF_MAPPED)
		return -EINVAL;

	down_write(&current->mm->mmap_sem);
	old_fops = filp->f_op;
	filp->f_op = &i830_buffer_fops;
	dev_priv->mmap_buffer = buf;
	virtual = do_mmap(filp, 0, buf->total, PROT_READ | PROT_WRITE,
			  MAP_SHARED, buf->bus_address);
	dev_priv->mmap_buffer = NULL;
	filp->f_op = old_fops;
	if (IS_ERR((void *)virtual)) {	/* ugh */
		/* Real error */
		DRM_ERROR("mmap error\n");
		retcode = PTR_ERR((void *)virtual);
		buf_priv->virtual = NULL;
	} else {
		buf_priv->virtual = (void __user *)virtual;
	}
	up_write(&current->mm->mmap_sem);

	return retcode;
}

(and same crap in i810_dma.c aswell)

Overriding the file operations just for mmap is for one thing racy
as hell and for another very fragile as the mmap and nopage routines
have to agree closely on what to do.

Even further why in hell do you call do_mmap from a driver?  Mapping
memory into userspace from anything but syscall dedicated to it is
surely a desaster waiting to happen.

Is there any chance we can get rid of this crap (and similar stuff in
drm_bufs.c) as part of the memory manager overhaul?  Long-term I'd
like to get rid of the do_mmap(_pgoff) export to avoid that people
introduce similar braindamage again.
