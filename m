Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVCYWg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVCYWg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCYWgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:36:25 -0500
Received: from alog0005.analogic.com ([208.224.220.20]:29626 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261870AbVCYWfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:35:07 -0500
Date: Fri, 25 Mar 2005 17:34:29 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove redundant NULL pointer checks prior to calling
 kfree() in fs/nfsd/
In-Reply-To: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Jesper Juhl wrote:

> (please keep me on CC)
>
>
> checking for NULL before calling kfree() is redundant and needlessly
> enlarges the kernel image, let's get rid of those checks.
>

Hardly. ORing a value with itself and jumping on condition is
real cheap compared with pushing a value into the stack and
calling a function. This is NOT a good change if you want
performance. You really should reconsider this activity. It
is quite counter-productive.


> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
> --- linux-2.6.12-rc1-mm3-orig/fs/nfsd/export.c	2005-03-21 23:12:41.000000000 +0100
> +++ linux-2.6.12-rc1-mm3/fs/nfsd/export.c	2005-03-25 22:48:11.000000000 +0100
> @@ -189,8 +189,7 @@ static int expkey_parse(struct cache_det
>  out:
> 	if (dom)
> 		auth_domain_put(dom);
> -	if (buf)
> -		kfree(buf);
> +	kfree(buf);
> 	return err;
> }
>
> @@ -426,8 +425,7 @@ static int svc_export_parse(struct cache
> 		path_release(&nd);
> 	if (dom)
> 		auth_domain_put(dom);
> -	if (buf)
> -		kfree(buf);
> +	kfree(buf);
> 	return err;
> }
>
> --- linux-2.6.12-rc1-mm3-orig/fs/nfsd/nfs4xdr.c	2005-03-25 15:28:59.000000000 +0100
> +++ linux-2.6.12-rc1-mm3/fs/nfsd/nfs4xdr.c	2005-03-25 22:49:53.000000000 +0100
> @@ -151,8 +151,7 @@ u32 *read_buf(struct nfsd4_compoundargs
> 	if (nbytes <= sizeof(argp->tmp))
> 		p = argp->tmp;
> 	else {
> -		if (argp->tmpp)
> -			kfree(argp->tmpp);
> +		kfree(argp->tmpp);
> 		p = argp->tmpp = kmalloc(nbytes, GFP_KERNEL);
> 		if (!p)
> 			return NULL;
> @@ -2474,10 +2473,8 @@ void nfsd4_release_compoundargs(struct n
> 		kfree(args->ops);
> 		args->ops = args->iops;
> 	}
> -	if (args->tmpp) {
> -		kfree(args->tmpp);
> -		args->tmpp = NULL;
> -	}
> +	kfree(args->tmpp);
> +	args->tmpp = NULL;
> 	while (args->to_free) {
> 		struct tmpbuf *tb = args->to_free;
> 		args->to_free = tb->next;
> --- linux-2.6.12-rc1-mm3-orig/fs/nfsd/nfscache.c	2005-03-21 23:12:41.000000000 +0100
> +++ linux-2.6.12-rc1-mm3/fs/nfsd/nfscache.c	2005-03-25 22:50:14.000000000 +0100
> @@ -93,8 +93,7 @@ nfsd_cache_shutdown(void)
>
> 	cache_disabled = 1;
>
> -	if (hash_list)
> -		kfree (hash_list);
> +	kfree(hash_list);
> 	hash_list = NULL;
> }
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
