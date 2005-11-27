Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVK0Fz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVK0Fz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 00:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVK0Fz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 00:55:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750849AbVK0Fz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 00:55:28 -0500
Date: Sat, 26 Nov 2005 21:55:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
Message-Id: <20051126215509.073cb957.akpm@osdl.org>
In-Reply-To: <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu>
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu>
	<E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu>
	<E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Remaining mount flags are becoming scarce (just 11 bits)
> and shared mount code uses 4 though one would suffice.
> 
> I think this should go into 2.6.15, fixing it later would be breaking
> userspace ABI.

These seem sane objectives.

> -static int do_change_type(struct nameidata *nd, int flag)
> +static int do_change_type(struct nameidata *nd, int recurse, char *name)
>  {
>  	struct vfsmount *m, *mnt = nd->mnt;
> -	int recurse = flag & MS_REC;
> -	int type = flag & ~MS_REC;
> +	enum propagation_type type;
>  
>  	if (nd->dentry != nd->mnt->mnt_root)
>  		return -EINVAL;
>  
> +	if (!name)
> +		return -EINVAL;
> +
> +	if (strcmp(name, "unbindable") == 0)
> +		type = PT_UNBINDABLE;
> +	else if (strcmp(name, "private") == 0)
> +		type = PT_PRIVATE;
> +	else if (strcmp(name, "slave") == 0)
> +		type = PT_SLAVE;
> +	else if (strcmp(name, "shared") == 0)
> +		type = PT_SHARED;
> +	else
> +		return -EINVAL;
> +
>  	down_write(&namespace_sem);
>  	spin_lock(&vfsmount_lock);
>  	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
> @@ -1302,8 +1315,8 @@ long do_mount(char *dev_name, char *dir_
>  				    data_page);
>  	else if (flags & MS_BIND)
>  		retval = do_loopback(&nd, dev_name, flags & MS_REC);
> -	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
> -		retval = do_change_type(&nd, flags);
> +	else if (flags & MS_PROPAGATION)
> +		retval = do_change_type(&nd, flags & MS_REC, data_page);
>  	else if (flags & MS_MOVE)
>  		retval = do_move_mount(&nd, dev_name);
>  	else

But I don't know how much trauma this would cause.  Hasn't util-linux
already been patched with the new mount flags?

If it has, and if it uses the same names for these options, the patched
mount(8) just won't work.

The proposed new mount options should be documented somewhere.

Anyway, I'll let Ram&Al decide on this proposal.
