Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992528AbWJTRsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992528AbWJTRsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992530AbWJTRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:48:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:15775 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S2992528AbWJTRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:48:00 -0400
Date: Fri, 20 Oct 2006 10:46:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andy Whitcroft <apw@shadowen.org>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>, will_schmidt@vnet.ibm.com,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <20061020100904.ed1fa0af.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610201044570.16161@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
 <20061019163044.GB5819@krispykreme> <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
 <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
 <17720.30804.180390.197567@cargo.ozlabs.ibm.com> <4538DACC.5050605@shadowen.org>
 <4538F2A2.5040305@shadowen.org> <20061020100904.ed1fa0af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch:

Slab: Do not fallback to nodes that have not been bootstrapped yet

The zonelist may contain zones of nodes that have not been bootstrapped 
and we will oops if we try to allocate from those zones. So check if the 
node information for the slab and the node have been setup before 
attempting an allocation. If it has not been setup then skip that zone.

Usually we will not encounter this situation since the slab bootstrap
code avoids falling back before we have setup the respective nodes but we 
seem to have a special needs for pppc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-20 12:39:02.000000000 -0500
+++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-20 12:41:04.137684581 -0500
@@ -3160,12 +3160,15 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 
-	for (z = zonelist->zones; *z && !obj; z++)
+	for (z = zonelist->zones; *z && !obj; z++) {
+		int nid = zone_to_nid(*z);
+
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				cache->nodelists[nid])
 			obj = __cache_alloc_node(cache,
-					flags | __GFP_THISNODE,
-					zone_to_nid(*z));
+					flags | __GFP_THISNODE, nid);
+	}
 	return obj;
 }
 

