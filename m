Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUAYSKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAYSKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:10:10 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:20885 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264974AbUAYSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:09:58 -0500
Message-ID: <401406CA.5000107@quark.didntduck.org>
Date: Sun, 25 Jan 2004 13:11:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: WHarms@bfs.de
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: mm/slab.c: linux 2.6.1 fix 2 unguarded kmalloc and a PAGE_SHIFT
References: <S264257AbUAYOAm/20040125140042Z+37462@vger.kernel.org>
In-Reply-To: <S264257AbUAYOAm/20040125140042Z+37462@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  (Walter Harms) wrote:
> Hi list,
> this fixes catches 2 unguarded kmallocs() and changes a statement so that PAGE_SHIFT >20 causes a warning. 
> At least sparc64 is prepared for a  PAGE_SHIFT >20.
> 
> hope that helps,
> walter
> 
> 
> --- mm/slab.c.org       2004-01-25 08:18:25.243165360 +0100
> +++ mm/slab.c   2004-01-25 08:33:05.135401408 +0100
> @@ -666,7 +666,7 @@
>          * Fragmentation resistance on low memory - only use bigger
>          * page orders on machines with more than 32MB of memory.
>          */
> -       if (num_physpages > (32 << 20) >> PAGE_SHIFT)
> +       if (num_physpages > (32 << (20-PAGE_SHIFT) )
>                 slab_break_gfp_order = BREAK_GFP_ORDER_HI;
>  
>  
> @@ -737,6 +737,10 @@
>                 void * ptr;
>  
>                 ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> +
> +               if (!ptr)
> +                 BUG();
> +
>                 local_irq_disable();
>                 BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
>                 memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init
> ));
> @@ -744,6 +748,10 @@
>                 local_irq_enable();
>  
>                 ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> +
> +               if (!ptr)
> +                 BUG();
> +
>                 local_irq_disable();
>                 BUG_ON(ac_data(malloc_sizes[0].cs_cachep) != &initarray_generic.
> cache);
>                 memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

BUG_ON(!ptr) would be better.

--
				Brian Gerst
