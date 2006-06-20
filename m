Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWFTVUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWFTVUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWFTVUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:20:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49374 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751104AbWFTVUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:20:02 -0400
Date: Tue, 20 Jun 2006 22:20:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
Subject: Re: [RFC][PATCH 03/20] Add vfsmount writer count
Message-ID: <20060620212000.GV27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain> <20060616231215.09D54036@localhost.localdomain> <20060618183320.GZ27946@ftp.linux.org.uk> <1150736536.10515.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150736536.10515.52.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:02:16AM -0700, Dave Hansen wrote:
> Very true.  How about this to fix it?
> 
> --- lxc/fs//open.c~C8.1-fix-faccesat    2006-06-19 09:59:41.000000000 -0700
> +++ lxc-dave/fs//open.c 2006-06-19 10:01:25.000000000 -0700
> @@ -546,8 +546,12 @@ asmlinkage long sys_faccessat(int dfd, c
>            special_file(nd.dentry->d_inode->i_mode))
>                 goto out_path_release;
> 
> -       if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
> -               res = -EROFS;
> +       res = mnt_want_write(nd.mnt);
> +       if (!res) {
> +               mnt_drop_write(nd.mnt);
> +               if(IS_RDONLY(nd.dentry->d_inode))
> +                       res = -EROFS;
> +       }

So access() can make remount r/o fail?  Uh-oh...
