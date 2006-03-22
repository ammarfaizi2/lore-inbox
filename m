Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWCVBK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWCVBK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCVBK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:10:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7661 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751914AbWCVBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:10:57 -0500
Date: Tue, 21 Mar 2006 17:10:51 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try
 #3)
In-Reply-To: <200603220154.16266.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0603211706560.14503@schroedinger.engr.sgi.com>
References: <200603182137.08521.jesper.juhl@gmail.com>
 <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
 <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
 <200603220154.16266.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Jesper Juhl wrote:

> --- linux-2.6.16-rc6-mm2-orig/mm/slab.c	2006-03-18 16:55:55.000000000 +0100
> +++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 22:33:45.000000000 +0100
> @@ -3399,12 +3399,17 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
>  static int alloc_kmemlist(struct kmem_cache *cachep)
>  {
>  	int node;
> +	int count = -1;

Count? One could simply go backwards on the node and undo all 
allocations for present nodes. That may be much simpler.

while (node >= 0 && node_isset(node, node_online_map) {

....

	node--;
}

>  	struct kmem_list3 *l3;
> -	int err = 0;

Ok. err is removed sinc we never set it to a nonzero value.

> +	struct array_cache *new;
> +	struct array_cache **new_alien;

Ok. Also not checked.
