Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWEPDHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWEPDHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 23:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWEPDHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 23:07:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50599 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751092AbWEPDHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 23:07:36 -0400
From: Neil Brown <neilb@suse.de>
To: Florin Malita <fmalita@gmail.com>
Date: Tue, 16 May 2006 13:07:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17513.16869.758211.133985@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: sign conversion obscuring errors in nfsd_set_posix_acl()
In-Reply-To: message from Florin Malita on Monday May 15
References: <4469411E.7060406@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 15, fmalita@gmail.com wrote:
> Assigning the result of posix_acl_to_xattr() to an unsigned data type
> (size/size_t) obscures possible errors.
> 
> Coverity CID: 1206.

Acked-by: NeilBrown <neilb@suse.de>

Thanks.
This is non-critical as posix_acl_to_xattr won't actually return an
error here (with current code anyway), but it is certainly worth
fixing.

The fact that posix_acl_to_xattr takes a 'size_t' for size and returns a
int is a bit bothersome... oh well.

NeilBrown

> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6aa92d0..1d65f13 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1922,11 +1922,10 @@ nfsd_set_posix_acl(struct svc_fh *fhp, i
>  		value = kmalloc(size, GFP_KERNEL);
>  		if (!value)
>  			return -ENOMEM;
> -		size = posix_acl_to_xattr(acl, value, size);
> -		if (size < 0) {
> -			error = size;
> +		error = posix_acl_to_xattr(acl, value, size);
> +		if (error < 0)
>  			goto getout;
> -		}
> +		size = error;
>  	} else
>  		size = 0;
>  
> 
