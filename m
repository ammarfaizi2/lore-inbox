Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWGYRUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWGYRUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWGYRUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:20:24 -0400
Received: from pat.uio.no ([129.240.10.4]:28591 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750711AbWGYRUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:20:23 -0400
Subject: Re: [PATCH] [nfs] Release dentry_lock in an error path of nfs_path
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1153783800.31581.21.camel@josh-work.beaverton.ibm.com>
References: <1153783800.31581.21.camel@josh-work.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 13:20:15 -0400
Message-Id: <1153848015.5639.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.803, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 16:30 -0700, Josh Triplett wrote:
> In one of the error paths of nfs_path, it may return with dentry_lock still
> held; fix this by adding and using a new error path Elong_unlock which unlocks
> dentry_lock.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

Applied to the NFS git tree... Thanks!

  Trond

> ---
>  fs/nfs/namespace.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 19b98ca..86b3169 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -51,7 +51,7 @@ char *nfs_path(const char *base, const s
>  		namelen = dentry->d_name.len;
>  		buflen -= namelen + 1;
>  		if (buflen < 0)
> -			goto Elong;
> +			goto Elong_unlock;
>  		end -= namelen;
>  		memcpy(end, dentry->d_name.name, namelen);
>  		*--end = '/';
> @@ -68,6 +68,8 @@ char *nfs_path(const char *base, const s
>  	end -= namelen;
>  	memcpy(end, base, namelen);
>  	return end;
> +Elong_unlock:
> +	spin_unlock(&dcache_lock);
>  Elong:
>  	return ERR_PTR(-ENAMETOOLONG);
>  }
> 
> 

