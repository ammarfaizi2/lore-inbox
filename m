Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWH1Pjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWH1Pjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWH1Pjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:39:32 -0400
Received: from xenotime.net ([66.160.160.81]:58851 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751136AbWH1Pjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:39:31 -0400
Date: Mon, 28 Aug 2006 08:42:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Message-Id: <20060828084247.38107d15.rdunlap@xenotime.net>
In-Reply-To: <44F2EF90.9050603@gmail.com>
References: <44F2EF90.9050603@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 21:28:48 +0800 Yi Yang wrote:

> In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
> and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
> does know them, I think the correct errno should be -EOPNOTSUPP which
> means they aren't be implemented or supported.
> 
> >From the kernel source code, we can see they can be supported without
> any code modification if a specific filesystem implements aio_fsync.
> 
> Another obvious problem is the function aio_fsync is as same as the
> function aio_fdsync, so they are duplicate, only one is enough.
> 
> Here this patch is.
> 
gmail ate all of the tabs, maybe other whitespace problems.

> 
> --- a/fs/aio.c.orig 2006-08-28 15:15:18.000000000 +0800
> +++ b/fs/aio.c 2006-08-28 15:33:59.000000000 +0800
> @@ -1363,20 +1363,10 @@ static ssize_t aio_pwrite(struct kiocb *
> return ret;
> }
> 
> -static ssize_t aio_fdsync(struct kiocb *iocb)
> -{
> - struct file *file = iocb->ki_filp;
> - ssize_t ret = -EINVAL;
> -
> - if (file->f_op->aio_fsync)
> - ret = file->f_op->aio_fsync(iocb, 1);
> - return ret;
> -}
> -
> static ssize_t aio_fsync(struct kiocb *iocb)
> {
> struct file *file = iocb->ki_filp;
> - ssize_t ret = -EINVAL;
> + ssize_t ret = -EOPNOTSUPP;
> 
> if (file->f_op->aio_fsync)
> ret = file->f_op->aio_fsync(iocb, 0);
> @@ -1425,12 +1415,12 @@ static ssize_t aio_setup_iocb(struct kio
> kiocb->ki_retry = aio_pwrite;
> break;
> case IOCB_CMD_FDSYNC:
> - ret = -EINVAL;
> + ret = -EOPNOTSUPP;
> if (file->f_op->aio_fsync)
> - kiocb->ki_retry = aio_fdsync;
> + kiocb->ki_retry = aio_fsync;
> break;
> case IOCB_CMD_FSYNC:
> - ret = -EINVAL;
> + ret = -EOPNOTSUPP;
> if (file->f_op->aio_fsync)
> kiocb->ki_retry = aio_fsync;
> break;
> -

---
~Randy
