Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUBDPIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUBDPIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:08:46 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:13516 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262569AbUBDPHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:07:23 -0500
Message-ID: <401FAC70.8070104@xfs.org>
Date: Tue, 03 Feb 2004 08:13:04 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl> <20040204000315.A12127@infradead.org>
In-Reply-To: <20040204000315.A12127@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Okay, what about this little patch?:
> 
> 
> Index: fs/xfs/linux-2.6/xfs_iops.c
> ===================================================================
> RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_iops.c,v
> retrieving revision 1.212
> diff -u -p -r1.212 xfs_iops.c
> --- fs/xfs/linux-2.6/xfs_iops.c	12 Dec 2003 04:17:52 -0000	1.212
> +++ fs/xfs/linux-2.6/xfs_iops.c	3 Feb 2004 23:56:17 -0000
> @@ -80,11 +80,15 @@ validate_fields(
>  	vattr_t		va;
>  	int		error;
>  
> -	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS;
> +	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS|XFS_AT_SIZE;
>  	VOP_GETATTR(vp, &va, ATTR_LAZY, NULL, error);
>  	ip->i_nlink = va.va_nlink;
>  	ip->i_size = va.va_size;
>  	ip->i_blocks = va.va_nblocks;
> +
> +	/* we're under i_sem so i_size can't change under us */
> +	if (i_size_read(ip) != va.va_size)
> +		i_size_write(ip, va.va_size);
>  }
>  
>  /*
> @@ -186,8 +190,7 @@ linvfs_mknod(
>  
>  		if (S_ISCHR(mode) || S_ISBLK(mode))
>  			ip->i_rdev = rdev;
> -		else if (S_ISDIR(mode))
> -			validate_fields(ip);
> +		validate_fields(ip);

There was some reason this was only necessary on directories, but I
cannot remember why just now.

>  		d_instantiate(dentry, ip);
>  		validate_fields(dir);
>  	}
> @@ -536,6 +539,7 @@ linvfs_setattr(
>  	if (error)
>  		return(-error);	/* Positive error up from XFS */
>  	if (ia_valid & ATTR_SIZE) {
> +		i_size_write(inode, vattr.va_size);
>  		error = vmtruncate(inode, attr->ia_size);
>  	}
>  
> Index: fs/xfs/linux-2.6/xfs_vnode.c
> ===================================================================
> RCS file: /cvs/linux-2.6-xfs/fs/xfs/linux-2.6/xfs_vnode.c,v
> retrieving revision 1.120
> diff -u -p -r1.120 xfs_vnode.c
> --- fs/xfs/linux-2.6/xfs_vnode.c	20 Oct 2003 02:08:58 -0000	1.120
> +++ fs/xfs/linux-2.6/xfs_vnode.c	3 Feb 2004 23:56:17 -0000
> @@ -213,7 +213,6 @@ vn_revalidate(
>  		inode->i_mtime	    = va.va_mtime;
>  		inode->i_ctime	    = va.va_ctime;
>  		inode->i_atime	    = va.va_atime;
> -		i_size_write(inode, va.va_size);
>  		if (va.va_xflags & XFS_XFLAG_IMMUTABLE)
>  			inode->i_flags |= S_IMMUTABLE;
>  		else
> 

I think this should work, it just leaves the extending O_DIRECT write
case. Keeping the revalidate call out of the path for creating regular
files would be nice though, why did you deem that necessary?

Steve
