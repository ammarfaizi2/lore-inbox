Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVAVIPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVAVIPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 03:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVAVIPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 03:15:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:7647 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262680AbVAVIPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 03:15:21 -0500
Date: Sat, 22 Jan 2005 00:05:56 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] disallow seeks and appends on sysfs files
Message-ID: <20050122080556.GA6999@kroah.com>
References: <Pine.CYG.4.58.0501211441430.3364@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501211441430.3364@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 02:49:39PM -0800, Mitch Williams wrote:
> This patch causes sysfs to return errors if the caller attempts to append
> to or seek on a sysfs file.

And what happens to it today if you do either of these?

Also, isn't this two different things?

> 
> Generated from 2.6.11-rc1.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> 
> diff -uprN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
> --- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
> +++ linux-2.6.11/fs/sysfs/file.c	2005-01-21 13:09:21.000000000 -0800
> @@ -281,6 +281,11 @@ static int check_perm(struct inode * ino
>  	if (!ops)
>  		goto Eaccess;
> 
> +	/* Is the file is open for append?  Sorry, we don't do that. */
> +	if (file->f_flags & O_APPEND) {
> +		goto Einval;
> +	}

Please, no {} for one line if statements.  Like the one above it :)



> +
>  	/* File needs write support.
>  	 * The inode's perms must say it's ok,
>  	 * and we must have a store method.
> @@ -312,6 +302,10 @@ static int check_perm(struct inode * ino
>  		file->private_data = buffer;
>  	} else
>  		error = -ENOMEM;
> +
> +	/*  Set mode bits to disallow seeking.  */
> +	file->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
> +
>  	goto Done;
> 
>   Einval:
> @@ -368,7 +343,7 @@ static int sysfs_release(struct inode *
>  struct file_operations sysfs_file_operations = {
>  	.read		= sysfs_read_file,
>  	.write		= sysfs_write_file,
> -	.llseek		= generic_file_llseek,
> +	.llseek		= no_llseek,
>  	.open		= sysfs_open_file,
>  	.release	= sysfs_release,
>  };

-- 
