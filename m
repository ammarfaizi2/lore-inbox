Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVKGKj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVKGKj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVKGKj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:39:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:9937 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750881AbVKGKj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:39:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH 17/25] vfat: move ioctl32 code to fs/fat/dir.c
Date: Mon, 7 Nov 2005 11:41:33 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162717.628382000@b551138y.boeblingen.de.ibm.com> <87pspernfe.fsf@devron.myhome.or.jp>
In-Reply-To: <87pspernfe.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071141.34147.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 06 November 2005 13:05, OGAWA Hirofumi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > +#ifdef CONFIG_COMPAT
> > +/* vfat */
> > +#define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
> > +#define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
>           ^^^^^^
> 
> Please use a SPACE after #define, and kill a useless "/* vfat */".

ok.

> > +static long
> > +put_dirent32(struct dirent *d, struct compat_dirent __user * d32)
> > +{
> > +	if (!access_ok(VERIFY_WRITE, d32, sizeof(struct compat_dirent)))
> > +		return -EFAULT;
> > +
> > +	__put_user(d->d_ino, &d32->d_ino);
> > +	__put_user(d->d_off, &d32->d_off);
> > +	__put_user(d->d_reclen, &d32->d_reclen);
> > +	if (__copy_to_user(d32->d_name, d->d_name, d->d_reclen))
> > +		return -EFAULT;
> 
> Why don't we need to check the return value of __put_user()?

This is a bug in the code that I copied over, and it needs to be fixed,
thanks.

> > +	set_fs(KERNEL_DS);
> > +	ret = fat_dir_ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long) &d);
> > +	set_fs(oldfs);
> > +	if (ret >= 0) {
> > +		ret |= put_dirent32(&d[0], p);
> > +		ret |= put_dirent32(&d[1], p + 1);
> 
> If "ret" is not 0, we can't use "|=" here?
> 
> This patch seems to have bugs, although original one too.

Right. In my patches I tried to change as little as possible to avoid
introducing new bugs, but this one is already so broken, that it's better
to do a clean implementation from scratch.

	Arnd <><
