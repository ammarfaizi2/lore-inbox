Return-Path: <linux-kernel-owner+w=401wt.eu-S932249AbXADTCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbXADTCP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXADTCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:02:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:51944 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbXADTCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:02:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TfkR53gp4Quhyng3530FoIQ58U/mJW1yBuMSiy+Yo4VstLwW+WkZVWtt90IgKn+V4G8/VDKLSoNsYeZhg3w7kdrdtH4Ky8o0B6NVX4YZBBnnZ3KyujFTqbBIsJZzKMXv+CZ5OQM72BpUmFF5xtD1i4y+MjMp5kKG9vtqbjP1KyI=
Date: Thu, 4 Jan 2007 19:00:15 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 5/8] user ns: prepare copy_tree, copy_mnt, and their callers to handle errs
Message-ID: <20070104190014.GA17863@slug>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181215.GF11377@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104181215.GF11377@sergelap.austin.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 12:12:15PM -0600, Serge E. Hallyn wrote:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5da87e2..a4039a3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -708,8 +708,9 @@ struct vfsmount *copy_tree(struct vfsmou
>  		return NULL;
>  
>  	res = q = clone_mnt(mnt, dentry, flag);
> -	if (!q)
> -		goto Enomem;
> +	if (!q || IS_ERR(q)) {
> +		return q;
> +	}
>  	q->mnt_mountpoint = mnt->mnt_mountpoint;
>  
>  	p = mnt;
> @@ -730,8 +731,9 @@ struct vfsmount *copy_tree(struct vfsmou
>  			nd.mnt = q;
>  			nd.dentry = p->mnt_mountpoint;
>  			q = clone_mnt(p, p->mnt_root, flag);
> -			if (!q)
> -				goto Enomem;
> +			if (!q || IS_ERR(q)) {
> +				goto Error;
> +			}
>  			spin_lock(&vfsmount_lock);
>  			list_add_tail(&q->mnt_list, &res->mnt_list);
>  			attach_mnt(q, &nd);
> @@ -739,7 +741,7 @@ struct vfsmount *copy_tree(struct vfsmou
>  		}
>  	}
>  	return res;
> -Enomem:
> +Error:
>  	if (res) {
        ^^^^^^^^^^
I think that this check can be safely skiped, as res is always non-NULL
when Error: is now reached, isn't it?

Regards,
Frederik
