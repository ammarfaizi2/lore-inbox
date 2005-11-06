Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVKFMGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVKFMGb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 07:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKFMGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 07:06:31 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:6673 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750774AbVKFMGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 07:06:30 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/25] vfat: move ioctl32 code to fs/fat/dir.c
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	<20051105162717.628382000@b551138y.boeblingen.de.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Nov 2005 21:05:57 +0900
In-Reply-To: <20051105162717.628382000@b551138y.boeblingen.de.ibm.com> (Arnd Bergmann's message of "Sat, 05 Nov 2005 17:27:07 +0100")
Message-ID: <87pspernfe.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> +#ifdef CONFIG_COMPAT
> +/* vfat */
> +#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
> +#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
          ^^^^^^

Please use a SPACE after #define, and kill a useless "/* vfat */".

> +static long
> +put_dirent32(struct dirent *d, struct compat_dirent __user * d32)
> +{
> +	if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
> +		return -EFAULT;
> +
> +	__put_user(d->d_ino, &d32->d_ino);
> +	__put_user(d->d_off, &d32->d_off);
> +	__put_user(d->d_reclen, &d32->d_reclen);
> +	if (__copy_to_user(d32->d_name, d->d_name, d->d_reclen))
> +		return -EFAULT;

Why don't we need to check the return value of __put_user()?

> +	set_fs(KERNEL_DS);
> +	ret = fat_dir_ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long) &d);
> +	set_fs(oldfs);
> +	if (ret >= 0) {
> +		ret |= put_dirent32(&d[0], p);
> +		ret |= put_dirent32(&d[1], p + 1);

If "ret" is not 0, we can't use "|=" here?

This patch seems to have bugs, although original one too.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
