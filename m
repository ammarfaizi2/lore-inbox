Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWCLWnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWCLWnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCLWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:43:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbWCLWnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:43:50 -0500
Date: Sun, 12 Mar 2006 14:41:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jesper.juhl@gmail.com,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
Message-Id: <20060312144129.0b5c227d.akpm@osdl.org>
In-Reply-To: <200603121428.08226.jesper.juhl@gmail.com>
References: <200603121428.08226.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> 
> The Coverity checker found that we may leak memory in 
> mm/slab.c::alloc_kmemlist()
> This should fix the leak and coverity bug #589
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  mm/slab.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.16-rc6-orig/mm/slab.c	2006-03-12 14:19:17.000000000 +0100
> +++ linux-2.6.16-rc6/mm/slab.c	2006-03-12 14:22:40.000000000 +0100
> @@ -3366,8 +3366,10 @@ static int alloc_kmemlist(struct kmem_ca
>  			continue;
>  		}
>  		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
> -					GFP_KERNEL, node)))
> +					GFP_KERNEL, node))) {
> +			kfree(new);
>  			goto fail;
> +		}
>  
>  		kmem_list3_init(l3);
>  		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +

It's more complicated than that.  We can also leak new_alien.  And if any
allocation in that for_each_online_node() loop fails I guess we need to
back out all the allocations we've done thus far, which means another loop.
ug.

Patches against rc6-mm1 would be preferred please, that code's changed
quite a bit.

