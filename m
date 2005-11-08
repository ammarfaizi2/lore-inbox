Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVKHKgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVKHKgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 05:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVKHKgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 05:36:51 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:26982 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751236AbVKHKgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 05:36:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TNe7TaNJFMzZYZWXrwGUjW1ygh9TlKHqREQteNzSTOH6PoVJj6ZrQWiFV7ofVF1SSxIXRBNHmeqgNhDk6V+j8vqEEkiuVNL4CnC4s/VUTWB9lbme2IADycdoXwR5ZhQMRasC6V6jSF6jz3GkiCQtqvGpIrz+LXXgfP1wSCKbcCk=
Date: Tue, 8 Nov 2005 13:50:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 6/8] Cleanup slabinfo_write()
Message-ID: <20051108105013.GA7678@mipter.zuzino.mipt.ru>
References: <436FF51D.8080509@us.ibm.com> <436FF7F7.1060907@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436FF7F7.1060907@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 04:57:27PM -0800, Matthew Dobson wrote:
> * Set 'res' at declaration instead of later in the function.

I hate to initialize a varible two miles away from the place where it's
used.

> --- linux-2.6.14+slab_cleanup.orig/mm/slab.c
> +++ linux-2.6.14+slab_cleanup/mm/slab.c
> @@ -3533,7 +3533,7 @@ ssize_t slabinfo_write(struct file *file
>  		       size_t count, loff_t *ppos)
>  {

> -	int limit, batchcount, shared, res;
> +	int limit, batchcount, shared, res = -EINVAL;

>  	/* Find the cache in the chain of caches. */
>  	down(&cache_chain_sem);
> -	res = -EINVAL;
>  	list_for_each(p,&cache_chain) {
>  		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
> +		if (strcmp(cachep->name, kbuf))
> +			continue;
>
> -		if (!strcmp(cachep->name, kbuf)) {
> -			if (limit < 1 || batchcount < 1 ||
> -			    batchcount > limit || shared < 0) {
> -				res = 0;
> -			} else {
> -				res = do_tune_cpucache(cachep, limit,
> -							batchcount, shared);
> -			}
> -			break;
> -		}
> +		res = do_tune_cpucache(cachep, limit, batchcount, shared);
> +		if (res >= 0)
> +			res = count;
> +		break;
>  	}
>  	up(&cache_chain_sem);
> -	if (res >= 0)
> -		res = count;
>  	return res;
>  }

