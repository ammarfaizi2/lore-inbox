Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVGIGX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVGIGX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 02:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVGIGX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 02:23:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3478 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263152AbVGIGX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 02:23:56 -0400
Date: Sat, 9 Jul 2005 08:25:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix broken kmalloc_node in rc1/rc2
Message-ID: <20050709062528.GC7050@suse.de>
References: <Pine.LNX.4.62.0507061042460.30563@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507061042460.30563@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06 2005, Christoph Lameter wrote:
> This patch used to be in Andrew's tree before the NUMA slab allocator went 
> in. Either this patch or the NUMA slab allocator is needed in order for
> kmalloc_node to work correctly.
> 
> pcibus_to_node may be used to generate the node information passed to 
> kmalloc_node. pcibus_to_node returns -1 if it was not able to determine
> on which node a pcibus is located. For that case kmalloc_node must
> work like kmalloc.
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>
> 
> Index: linux-2.6.13-rc2/mm/slab.c
> ===================================================================
> --- linux-2.6.13-rc2.orig/mm/slab.c	2005-07-06 03:46:33.000000000 +0000
> +++ linux-2.6.13-rc2/mm/slab.c	2005-07-06 17:34:19.000000000 +0000
> @@ -2372,6 +2372,9 @@ void *kmem_cache_alloc_node(kmem_cache_t
>  	struct slab *slabp;
>  	kmem_bufctl_t next;
>  
> +	if (nodeid == -1)
> +		return kmem_cache_alloc(cachep, flags);
> +
>  	for (loop = 0;;loop++) {
>  		struct list_head *q;

imho, things like this are much cleaner coded as:

void *kmem_cache_alloc_node(cachep, flags, node)
{
        if (node != -1)
                return __kmem_cache_alloc_node(cachep, flags, node);

        /* no valid node, fall back to regular slab alloc */
        return kmem_cache_alloc(cachep, flags);

}

-- 
Jens Axboe

