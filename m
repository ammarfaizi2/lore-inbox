Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVIWV14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVIWV14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVIWV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:27:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbVIWV1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:27:55 -0400
Date: Fri, 23 Sep 2005 14:27:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse: check O_DIRECT
Message-Id: <20050923142758.641189f2.akpm@osdl.org>
In-Reply-To: <E1EIoQZ-0006Rz-00@dorka.pomaz.szeredi.hu>
References: <E1EIoQZ-0006Rz-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Check O_DIRECT and return -EINVAL error in open.  dentry_open() also
> checks this but only after the open method is called.  This patch
> optimizes away the unnecessary upcalls in this case.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> 
> Index: linux/fs/fuse/file.c
> ===================================================================
> --- linux.orig/fs/fuse/file.c	2005-09-21 11:55:45.000000000 +0200
> +++ linux/fs/fuse/file.c	2005-09-23 15:24:23.000000000 +0200
> @@ -23,6 +23,10 @@ int fuse_open_common(struct inode *inode
>  	struct fuse_file *ff;
>  	int err;
>  
> +	/* VFS checks this, but only _after_ ->open() */
> +	if (file->f_flags & O_DIRECT)
> +		return -EINVAL;
> +
>  	err = generic_file_open(inode, file);
>  	if (err)
>  		return err;

This hardly seems worth optimising for?
