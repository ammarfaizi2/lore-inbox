Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWJMTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWJMTFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWJMTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:05:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20433 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751813AbWJMTFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:05:23 -0400
Date: Fri, 13 Oct 2006 12:05:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at  linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1160764895.11239.14.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Will Schmidt wrote:

>     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> tree.  It's fairly early during boot, so I've included the whole log
> below.   This partition has 8 procs, (shared, including threads), and
> 512M RAM.  

This looks like slab bootstrap. You are bootstrapping while having 
zonelists build with zones that are only going to be populated later? 
This will lead to incorrect NUMA placement of lots of slab structures on 
bootup.

Check if the patch below may cure the oops. Your memory is likely 
still placed on the wrong numa nodes since we have to fallback from 
the intended node.

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-10-13 11:59:55.000000000 -0700
+++ linux-2.6/mm/slab.c	2006-10-13 12:03:15.000000000 -0700
@@ -3154,7 +3154,8 @@ void *fallback_alloc(struct kmem_cache *
 
 	for (z = zonelist->zones; *z && !obj; z++)
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				(*z)->free_pages)
 			obj = __cache_alloc_node(cache,
 					flags | __GFP_THISNODE,
 					zone_to_nid(*z));
