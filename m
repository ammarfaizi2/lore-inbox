Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbXADSXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbXADSXy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbXADSXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:23:54 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:62952 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbXADSXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:23:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=J/Jsa4F2GcahJ7bztwYVt5mRGowEEoFt82WQbsR83DNyvKWj3mn++3vlFg5TOe4XQOGCbtwZJESlO81qawygph0LhQDC6JgydCH5C2a/JxizxT9xBy2ebh6JXOUh6hoPrBpXjzLPmU/8+KmMkkBKtGNXnVJd23fSV/Fe4qVZ6Gk=
Message-ID: <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
Date: Thu, 4 Jan 2007 20:23:52 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
Cc: "Andrew Morton" <akpm@osdl.org>, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
X-Google-Sender-Auth: c0a83069bd69e5f1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

[Sorry, no access to kernel tree right now, so can't send a patch.]

On 1/4/07, Hugh Dickins <hugh@veritas.com> wrote:
> @@ -3310,7 +3310,7 @@ retry:
>                                          */
>                                         goto retry;
>                         } else {
> -                               kmem_freepages(cache, obj);
> +                               /* cache_grow already freed obj */
>                                 obj = NULL;

So, how about we rename the current cache_grow() to __cache_grow() and
move the kmem_freepages() to a higher level function like this:

static int cache_grow(struct kmem_cache *cache,
                                gfp_t flags, int nodeid)
{
        void *objp;
        int ret;

        if (flags & __GFP_NO_GROW)
                return 0;

        objp = kmem_getpages(cachep, flags, nodeid);
        if (!objp)
                return 0;

        ret = __cache_grow(cache, flags, nodeid, objp);
        if (!ret)
                kmem_freepages(cachep, objp);

        return ret;
}

And use the non-allocating __cache_grow version() in fallback_alloc() instead?
