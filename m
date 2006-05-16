Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWEPL5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWEPL5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWEPL5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:57:11 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:35342 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750781AbWEPL5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:57:11 -0400
Message-ID: <4469BE0E.9080205@voltaire.com>
Date: Tue, 16 May 2006 14:57:02 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "akpm@osdl.org Linux Kernel Mailing List" 
	<linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] slab: Fix kmem_cache_destroy() on NUMA
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <Pine.LNX.4.44.0605141306240.29880-100000@zuben> <adaves7rv0j.fsf_-_@cisco.com>
In-Reply-To: <adaves7rv0j.fsf_-_@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2006 11:57:09.0248 (UTC) FILETIME=[DC1BB000:01C678DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> With CONFIG_NUMA set, kmem_cache_destroy() may fail and say "Can't
> free all objects."  The problem is caused by sequences such as the
> following (suppose we are on a NUMA machine with two nodes, 0 and 1):
> 
>  * Allocate an object from cache on node 0.
>  * Free the object on node 1.  The object is put into node 1's alien
>    array_cache for node 0.
>  * Call kmem_cache_destroy(), which ultimately ends up in __cache_shrink().
>  * __cache_shrink() does drain_cpu_caches(), which loops through all nodes.
>    For each node it drains the shared array_cache and then handles the
>    alien array_cache for the other node.
> 
> However this means that node 0's shared array_cache will be drained,
> and then node 1 will move the contents of its alien[0] array_cache
> into that same shared array_cache.  node 0's shared array_cache is
> never looked at again, so the objects left there will appear to be in
> use when __cache_shrink() calls __node_shrink() for node 0.  So
> __node_shrink() will return 1 and kmem_cache_destroy() will fail.
> 
> This patch fixes this by having drain_cpu_caches() do
> drain_alien_cache() on every node before it does drain_array() on the
> nodes' shared array_caches.
> 
> The problem was originally reported by Or Gerlitz <ogerlitz@voltaire.com>.
> 
> Cc: Christoph Lameter <clameter@sgi.com>
> Cc: Pekka Enberg <penberg@cs.helsinki.fi>

OK, Indeed i have CONFIG_NUMA and yes, the patch fixes my problem, 
thanks a lot for working on that!

Or.

