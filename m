Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVAVIQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVAVIQC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 03:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVAVIQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 03:16:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:8415 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262681AbVAVIPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 03:15:22 -0500
Date: Sat, 22 Jan 2005 00:09:30 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
Message-ID: <20050122080930.GB6999@kroah.com>
References: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 02:52:29PM -0800, Mitch Williams wrote:
> This patch buffers writes to sysfs files and flushes them to the kobject
> owner when the file is closed.

Why?  This breaks the way things work today, right? 

What is this patch trying to fix?

> 
> Generated from 2.6.11-rc1.
> 
> Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>
> 
> diff -uprN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
> --- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
> +++ linux-2.6.11/fs/sysfs/file.c	2005-01-21 13:09:21.000000000 -0800
> @@ -62,6 +62,7 @@ struct sysfs_buffer {
>  	struct sysfs_ops	* ops;
>  	struct semaphore	sem;
>  	int			read_filled;
> +	int			needs_write_flush;
>  };
> 
> 
> @@ -178,7 +178,8 @@ out:
>   */
> 
>  static int
> -fill_write_buffer(struct sysfs_buffer * buffer, const char __user * buf, size_t count)
> +fill_write_buffer(struct sysfs_buffer *buffer, const char __user * buf,
> +		  size_t count, size_t pos)
>  {
>  	int error;
> 
> @@ -187,10 +189,11 @@ fill_write_buffer(struct sysfs_buffer *
>  	if (!buffer->page)
>  		return -ENOMEM;
> 
> -	if (count >= PAGE_SIZE)
> -		count = PAGE_SIZE - 1;
> +	if (count + pos > PAGE_SIZE)
> +		count = (PAGE_SIZE - 1) - pos;
>  	error = copy_from_user(buffer->page,buf,count);
> -	buffer->needs_read_fill = 1;
> +	buffer->needs_write_flush = 1;
> +        buffer->count = pos + count;
>  	return error ? -EFAULT : count;
>  }
> 
> @@ -206,13 +209,13 @@ fill_write_buffer(struct sysfs_buffer *
>   */
> 
>  static int
> -flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t count)
> +flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
>  {
>  	struct attribute * attr = to_attr(dentry);
>  	struct kobject * kobj = to_kobj(dentry->d_parent);
>  	struct sysfs_ops * ops = buffer->ops;
> 
> -	return ops->store(kobj,attr,buffer->page,count);
> +	return ops->store(kobj,attr, buffer->page, buffer->count);
>  }
> 
> 
> @@ -225,12 +228,9 @@ flush_write_buffer(struct dentry * dentr
>   *
>   *	Similar to sysfs_read_file(), though working in the opposite direction.
>   *	We allocate and fill the data from the user in fill_write_buffer(),
> - *	then push it to the kobject in flush_write_buffer().
> - *	There is no easy way for us to know if userspace is only doing a partial
> - *	write, so we don't support them. We expect the entire buffer to come
> - *	on the first write.
> - *	Hint: if you're writing a value, first read the file, modify only the
> - *	the value you're changing, then write entire buffer back.
> + *	but don't push it to the kobject until the file is closed.
> + *      This allows for buffered writes, but unfortunately also hides error
> + *      codes returned individual store functions until close time.
>   */
> 
>  static ssize_t
> @@ -238,10 +238,10 @@ sysfs_write_file(struct file *file, cons
>  {
>  	struct sysfs_buffer * buffer = file->private_data;
> 
> +	if (*ppos >= PAGE_SIZE)
> +		return -ENOSPC;
>  	down(&buffer->sem);
> -	count = fill_write_buffer(buffer,buf,count);
> -	if (count > 0)
> -		count = flush_write_buffer(file->f_dentry,buffer,count);
> +	count = fill_write_buffer(buffer, buf, count, *ppos);
>  	if (count > 0)
>  		*ppos += count;
>  	up(&buffer->sem);
> @@ -337,6 +337,17 @@ static int sysfs_release(struct inode *
>  	struct attribute * attr = to_attr(filp->f_dentry);
>  	struct module * owner = attr->owner;
>  	struct sysfs_buffer * buffer = filp->private_data;
> +        int ret;

You used spaces instead of a tab here.

> +
> +	/* If data has been written to the file, then flush it
> +	 * back to the kobject's store function here.
> +	 */
> +	if (buffer && kobj) {
> +		down(&buffer->sem);
> +		if (buffer->needs_write_flush)
> +			ret = flush_write_buffer(filp->f_dentry, buffer);
> +		up(&buffer->sem);
> +	}
> 
>  	if (kobj)
>  		kobject_put(kobj);
> @@ -348,7 +352,10 @@ static int sysfs_release(struct inode *
>  			free_page((unsigned long)buffer->page);
>  		kfree(buffer);
>  	}
> -	return 0;
> +	/* If flush_write_buffer returned an error, pass it up.
> +	 * Otherwise, return success.
> +	 */
> +	return (ret < 0 ? ret : 0);

I think this comment is not needed.  Actually, what's wrong with just:
	return ret;

thanks,

greg k-h
