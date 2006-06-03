Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWFCWKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWFCWKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFCWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 18:10:50 -0400
Received: from mx2.netapp.com ([216.240.18.37]:61580 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751300AbWFCWKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 18:10:49 -0400
X-IronPort-AV: i="4.05,206,1146466800"; 
   d="scan'208"; a="384603582:sNHT19662080"
Subject: Re: lock_kernel called under spinlock in NFS
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Andrew Morton <akpm@osdl.org>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       stable@kernel.org
In-Reply-To: <20060603223003.5665a426.vsu@altlinux.ru>
References: <20060601195535.GA28188@tsunami.ccur.com>
	 <1149192820.3549.43.camel@lade.trondhjem.org>
	 <20060602202436.GA4783@tsunami.ccur.com>
	 <1149280078.5621.63.camel@lade.trondhjem.org>
	 <20060602134346.73019624.akpm@osdl.org>
	 <20060603223003.5665a426.vsu@altlinux.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sat, 03 Jun 2006 18:10:42 -0400
Message-Id: <1149372643.17419.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 03 Jun 2006 22:10:44.0064 (UTC) FILETIME=[8EE24E00:01C6875A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 22:30 +0400, Sergey Vlasov wrote:

> 2) The patch above is broken - it needs the fix below (or the fix should
> be folded into the patch directly):

Duh... You're quite right. Sorry about missing that.

Cheers,
  Trond

> --------------------------------------------------------------------
> 
> Fix do_path_lookup() failure path after locking changes
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> ---
>  fs/namei.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index a2f79d2..d6e2ee2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1104,17 +1104,17 @@ static int fastcall do_path_lookup(int d
>  		file = fget_light(dfd, &fput_needed);
>  		retval = -EBADF;
>  		if (!file)
> -			goto unlock_fail;
> +			goto out_fail;
>  
>  		dentry = file->f_dentry;
>  
>  		retval = -ENOTDIR;
>  		if (!S_ISDIR(dentry->d_inode->i_mode))
> -			goto fput_unlock_fail;
> +			goto fput_fail;
>  
>  		retval = file_permission(file, MAY_EXEC);
>  		if (retval)
> -			goto fput_unlock_fail;
> +			goto fput_fail;
>  
>  		nd->mnt = mntget(file->f_vfsmnt);
>  		nd->dentry = dget(dentry);
> @@ -1129,13 +1129,12 @@ out:
>  				nd->dentry->d_inode))
>  		audit_inode(name, nd->dentry->d_inode, flags);
>  	}
> +out_fail:
>  	return retval;
>  
> -fput_unlock_fail:
> +fput_fail:
>  	fput_light(file, fput_needed);
> -unlock_fail:
> -	read_unlock(&current->fs->lock);
> -	return retval;
> +	goto out_fail;
>  }
>  
>  int fastcall path_lookup(const char *name, unsigned int flags,
