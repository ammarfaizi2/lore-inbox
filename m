Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWC2NPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWC2NPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWC2NPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:15:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49622 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750889AbWC2NPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:15:50 -0500
Message-ID: <442A8883.9060909@garzik.org>
Date: Wed, 29 Mar 2006 08:15:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de>
In-Reply-To: <20060329122841.GC8186@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> index 509ccec..23e2c7c 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -53,6 +53,8 @@ const struct file_operations ext2_file_o
>  	.readv		= generic_file_readv,
>  	.writev		= generic_file_writev,
>  	.sendfile	= generic_file_sendfile,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= generic_file_splice_write,
>  };
>  
>  #ifdef CONFIG_EXT2_FS_XIP
> diff --git a/fs/ext3/file.c b/fs/ext3/file.c
> index 783a796..1efefb6 100644
> --- a/fs/ext3/file.c
> +++ b/fs/ext3/file.c
> @@ -119,6 +119,8 @@ const struct file_operations ext3_file_o
>  	.release	= ext3_release_file,
>  	.fsync		= ext3_sync_file,
>  	.sendfile	= generic_file_sendfile,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= generic_file_splice_write,

> +static long do_splice_from(struct inode *pipe, struct file *out, size_t len,
> +			   unsigned long flags)
> +{
> +	if (out->f_op && out->f_op->splice_write)
> +		return out->f_op->splice_write(pipe, out, len, flags);

1) What are the consequences of doing

	if (f_op->splice_write)
		f_op->splice_write(...);
	else
		generic_file_splice_write(...);

to cause sys_splice() to default to supported?

2) Do you really have to test f_op itself for NULL?  Is that a stealth 
closed-file check or something?  I would be surprised if f_op was ever 
really NULL.

	Jeff


