Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVKGDiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVKGDiB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKGDiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:38:01 -0500
Received: from verein.lst.de ([213.95.11.210]:28638 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932363AbVKGDiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:38:00 -0500
Date: Mon, 7 Nov 2005 04:37:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH 17/25] vfat: move ioctl32 code to fs/fat/dir.c
Message-ID: <20051107033754.GB15864@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162717.628382000@b551138y.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105162717.628382000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_COMPAT
> +/* vfat */
> +#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
> +#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])

these should be moved close to the original VFAT ioctl defintions. And
there's no need to put them under ifdef.

> +static long
> +put_dirent32(struct dirent *d, struct compat_dirent __user * d32)
> +{
> +	if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
> +		return -EFAULT;
> +
> +	__put_user(d->d_ino, &d32->d_ino);
> +	__put_user(d->d_off, &d32->d_off);
> +	__put_user(d->d_reclen, &d32->d_reclen);

missing error checks.

> +static long fat_dir_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct compat_dirent __user *p = compat_ptr(arg);
> +	int ret;
> +	mm_segment_t oldfs = get_fs();
> +	struct dirent d[2];

please use proper compat_alloc_user_space here.

> +	switch (cmd) {
> +	case VFAT_IOCTL_READDIR_BOTH32:
> +		cmd = VFAT_IOCTL_READDIR_BOTH;
> +		break;
> +	case VFAT_IOCTL_READDIR_SHORT32:
> +		cmd = VFAT_IOCTL_READDIR_SHORT;
> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	set_fs(KERNEL_DS);
> +	ret = fat_dir_ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long) &d);
> +	set_fs(oldfs);

In fact there's even a much better way to implement this, let the
ioctls call __fat_readdir directly with a filldir callback that directly
works in compat_dirent structures.

