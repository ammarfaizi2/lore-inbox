Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWJMTxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWJMTxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWJMTxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:53:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30649 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751824AbWJMTxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:53:54 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 13 Oct 2006 14:53:46 -0500
Message-Id: <1160769226.11239.22.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-13-10 at 12:05 -0700, Christoph Lameter wrote:
> On Fri, 13 Oct 2006, Will Schmidt wrote:
> 
> >     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> > tree.  It's fairly early during boot, so I've included the whole log
> > below.   This partition has 8 procs, (shared, including threads), and
> > 512M RAM.  
> 
> This looks like slab bootstrap. You are bootstrapping while having 
> zonelists build with zones that are only going to be populated later? 
> This will lead to incorrect NUMA placement of lots of slab structures on 
> bootup.

I dont think so..   but it's not an area I'm very familiar with.   one
of the other PPC folks might chime in with something here.  

> 
> Check if the patch below may cure the oops. Your memory is likely 
> still placed on the wrong numa nodes since we have to fallback from 
> the intended node.

Nope, no change with this patch.

> 
> Index: linux-2.6/mm/slab.c
> ===================================================================
> --- linux-2.6.orig/mm/slab.c	2006-10-13 11:59:55.000000000 -0700
> +++ linux-2.6/mm/slab.c	2006-10-13 12:03:15.000000000 -0700
> @@ -3154,7 +3154,8 @@ void *fallback_alloc(struct kmem_cache *
> 
>  	for (z = zonelist->zones; *z && !obj; z++)
>  		if (zone_idx(*z) <= ZONE_NORMAL &&
> -				cpuset_zone_allowed(*z, flags))
> +				cpuset_zone_allowed(*z, flags) &&
> +				(*z)->free_pages)
>  			obj = __cache_alloc_node(cache,
>  					flags | __GFP_THISNODE,
>  					zone_to_nid(*z));

