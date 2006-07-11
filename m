Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWGKGRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWGKGRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWGKGRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:17:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:49088 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965151AbWGKGRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:17:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CA0CUsPPOIocCheL/y8Isq/Fs6KoqPwlFa5hlhc9K/SW8p2ppnOEE5GlWGex6ShiOK3VzVDncBuFATupUJU+Cmmwmbz2LXcfYWbSDTOwrvObBdoM4uX6A0g1it98BF0bGXjAH5l02Whjr+u3qbxRuTFdYc0uTQLu/rAtKOlGqHo=
Message-ID: <84144f020607102317r60d797eakdf20107e158ec251@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:17:38 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 03/10] Add the memory allocation/freeing hooks for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060710220957.5191.54019.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <20060710220957.5191.54019.stgit@localhost.localdomain>
X-Google-Sender-Auth: ae2a5565d9b785c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin

On 7/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> diff --git a/mm/slab.c b/mm/slab.c
> index 85c2e03..2752272 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2967,6 +2967,7 @@ #endif
>                 STATS_INC_ALLOCMISS(cachep);
>                 objp = cache_alloc_refill(cachep, flags);
>         }
> +       memleak_erase(&ac->entry[ac->avail]);
>         return objp;
>  }

Can't we tell the GC not to scan any of the array cache structs? You
could put that in alloc_arraycache(), I think.

> @@ -3209,7 +3211,11 @@ static void __cache_free(struct kmem_cac
>   */
>  void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
>  {
> -       return __cache_alloc(cachep, flags, __builtin_return_address(0));
> +       void *ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
> +
> +       memleak_alloc(ptr, obj_size(cachep), 1);

Can you move memleak_alloc() call to __cache_alloc() instead to avoid
duplication?
