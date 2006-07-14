Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWGNKXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWGNKXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNKXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:23:09 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:31749 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964812AbWGNKXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:23:08 -0400
In-Reply-To: <1152812344.30096.6.camel@dyn9047017100.beaverton.ibm.com>
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF17C7C39C.459BFD4F-ON422571AB.0038C83E-422571AB.00390C95@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 14 Jul 2006 12:23:07 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF268 | April 6, 2006) at
 14/07/2006 12:26:02
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

Badari Pulavarty <pbadari@us.ibm.com> wrote on 07/13/2006 07:39:04 PM:
> Well, if you say so.. I have no idea what hypfs provides,
> if you think that some one can do vector and/or async
> operations on these files, its worth adding the complexity.
>
> I was inclined towards just dealing with only single entry
> in the vector and fail if some one called with multiple vectors.
> But, its your call. Here is the complete code - completely untested :(
> Could you please compile and test it  ?
>
> Thanks,
> Badari
>

I tested your patch. It works fine! You can test hypfs only
on zSeries machines in LPAR mode. It provides acounting
information for the zSeries Hypervisor LPAR environment.

Thanks!

Michael


> Vectorize aio interfaces to hypfs to fit new vfs ops interfaces.
>
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
>
> Index: linux-2.6.18-rc1/arch/s390/hypfs/inode.c
> ===================================================================
> --- linux-2.6.18-rc1.orig/arch/s390/hypfs/inode.c   2006-07-11 21:
> 28:07.000000000 -0700
> +++ linux-2.6.18-rc1/arch/s390/hypfs/inode.c   2006-07-13 10:47:07.
> 000000000 -0700
> @@ -134,36 +134,50 @@ static int hypfs_open(struct inode *inod
>     return 0;
>  }
>
> -static ssize_t hypfs_aio_read(struct kiocb *iocb, __user char *buf,
> -               size_t count, loff_t offset)
> +static ssize_t hypfs_aio_read(struct kiocb *iocb, const struct iovec
*iov,
> +               unsigned long nr_segs, loff_t offset)
>  {
>     char *data;
>     size_t len;
>     struct file *filp = iocb->ki_filp;
> +   int i, ret = 0;
>
>     data = filp->private_data;
>     len = strlen(data);
> -   if (offset > len) {
> -      count = 0;
> -      goto out;
> -   }
> -   if (count > len - offset)
> -      count = len - offset;
> -   if (copy_to_user(buf, data + offset, count)) {
> -      count = -EFAULT;
> +   if (offset < len)
> +      len -= offset;
> +   else
>        goto out;
> +
> +   for (i=0; i < nr_segs; i++) {
> +      char __user *buf = iov[i].iov_base;
> +      size_t count = iov[i].iov_len;
> +
> +      if (count > len)
> +         count = len;
> +      if (copy_to_user(buf, data + offset, count)) {
> +         if (!ret)
> +            ret = -EFAULT;
> +         break;
> +      }
> +      offset += count;
> +      len -= count;
> +      ret += count;
> +      if (len == 0)
> +         break;
>     }
> -   iocb->ki_pos += count;
> +   iocb->ki_pos = offset;
>     file_accessed(filp);
>  out:
> -   return count;
> +   return ret;
>  }
> -static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user
*buf,
> -                size_t count, loff_t pos)
> +static ssize_t hypfs_aio_write(struct kiocb *iocb, const struct iovec
*iov,
> +               unsigned long nr_segs, loff_t offset)
>  {
>     int rc;
>     struct super_block *sb;
>     struct hypfs_sb_info *fs_info;
> +   size_t count = iov_length(iov, nr_segs);
>
>     sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
>     fs_info = sb->s_fs_info;
>
>
>

