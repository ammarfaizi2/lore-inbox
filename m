Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264194AbUD0Qpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUD0Qpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUD0Qpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:45:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:11461 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264194AbUD0Qpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:45:50 -0400
Date: Tue, 27 Apr 2004 18:42:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       jra@samba.org
Subject: Re: [PATCH COW] sys_copyfile
Message-ID: <20040427164220.GB2176@wohnheim.fh-wedel.de>
References: <1083081505.12804.65.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1083081505.12804.65.camel@stevef95.austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 10:58:25 -0500, Steve French wrote:
> 
> > With warm cache, copyfile() is about 10% faster
> 
> Over the network it would be a lot more than that.

True, if network traffic is saved as well.

> in do_copyfile all I would need would be an op that looks a bit like 
> rename (the cifs vfs part of the changes, to fs/cifs/cifssmb.c mostly,
> would be trivial) e.g.:
> 
>  int do_copyfile(struct nameidata *old_nd, struct nameidata *new_nd,
>                  struct dentry *new_dentry, umode_t mode)
> {
> -	int ret;
> +       int ret = 0;
> 
>         if (!old_nd->dentry->d_inode)
>                 return -ENOENT;
>         if (!S_ISREG(old_nd->dentry->d_inode->i_mode))
>                 return -EINVAL;
>         /* FIXME: replace with proper permission check */
>         if (new_dentry->d_inode)
>                 return -EEXIST;
> 
> +	if(old_nd->dentry->d_inode->i_op->copy) {
> +		ret = old_dir->i_op->copy(old_nd->dentry, 
> +			mode, new_dentry);
> +	}

Shouldn't it be rather

	if (old_nd->dentry->d_inode->i_op->copy)
		return old_nd->dentry->d_inode->i_op->copy(old_nd->dentry,
				mode, new_dentry);

or something similar?  The copy() effectively replaces the complete
create/sendfile/possibly-unlink series.

> 
> 	if(!ret)
> 		return ret;
> 	else
> 		ret = vfs_create(new_nd->dentry->d_inode,
> 			 new_dentry, mode, new_nd);
> 	if (ret)
>                 return ret;
> 
> 	ret = copy_data(old_nd->dentry, old_nd->mnt, new_dentry,
> 		new_nd->mnt);
> 
>         if (ret) {
>                 int error = vfs_unlink(new_nd->dentry->d_inode,
> 			new_dentry);
>                 BUG_ON(error);
>                /* FIXME: not sure if there are return value we 
> 			should not BUG()
> 	               * on */
>         }
>         return ret;
> }
> 	

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
