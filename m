Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbTBEIjU>; Wed, 5 Feb 2003 03:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267868AbTBEIjU>; Wed, 5 Feb 2003 03:39:20 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:51719 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267867AbTBEIjT>; Wed, 5 Feb 2003 03:39:19 -0500
Date: Wed, 5 Feb 2003 08:48:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LSM changes for 2.5.59
Message-ID: <20030205084852.B16212@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <20030205041538.GA16823@kroah.com> <20030205041611.GB16823@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205041611.GB16823@kroah.com>; from greg@kroah.com on Tue, Feb 04, 2003 at 08:16:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 08:16:11PM -0800, Greg KH wrote:
> diff -Nru a/fs/super.c b/fs/super.c
> --- a/fs/super.c	Wed Feb  5 14:58:37 2003
> +++ b/fs/super.c	Wed Feb  5 14:58:37 2003
> @@ -610,6 +610,7 @@
>  	struct file_system_type *type = get_fs_type(fstype);
>  	struct super_block *sb = ERR_PTR(-ENOMEM);
>  	struct vfsmount *mnt;
> +	int error;
>  
>  	if (!type)
>  		return ERR_PTR(-ENODEV);
> @@ -620,6 +621,13 @@
>  	sb = type->get_sb(type, flags, name, data);
>  	if (IS_ERR(sb))
>  		goto out_mnt;
> + 	error = security_sb_kern_mount(sb);
> + 	if (error) {
> + 		up_write(&sb->s_umount);
> + 		deactivate_super(sb);
> + 		sb = ERR_PTR(error);
> + 		goto out_mnt;
> + 	}

it would be nice if you could follow the syle in this function/file
and put the error handling code out of line.  This is a general
complaint, btw - the LSM hooks seldomly follow the style of the
code around :(

