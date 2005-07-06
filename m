Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVGFB2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVGFB2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVGFB2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:28:14 -0400
Received: from graphe.net ([209.204.138.32]:16826 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261991AbVGFB1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:27:15 -0400
Date: Tue, 5 Jul 2005 18:27:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
In-Reply-To: <20050706010450.GO12786@krispykreme>
Message-ID: <Pine.LNX.4.62.0507051822390.6516@graphe.net>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net>
 <20050705225908.GL12786@krispykreme> <Pine.LNX.4.62.0507051632100.2289@graphe.net>
 <20050705235521.GN12786@krispykreme> <Pine.LNX.4.62.0507051700360.5130@graphe.net>
 <20050706010450.GO12786@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Anton Blanchard wrote:

>  
> > That is the issue. It should fall back to kmalloc. One piece of the 
> > patchset dropped out between Andrew and Linus.
> 
> That helped, but I still had lots of free memory in the request_queue
> slab. Giving kmem_cache_alloc_node the same treatment fixed it, although
> I wonder if we just shouldnt be passing in -1.

No. No. -1 is the sign for undetermined that is also used in other pieces 
of slab.c. Meaning do not do node specific allocs. The fix  
should only modify kmem_cache_alloc_node. But we wont need that if the 
new slab allocator would get in. Andrew?

Also if powerpc wants to use node specific allocations for block devices 
then the powerpc arch needs to supply a pcibus_to_node function that does 
return the correct node for the pcibus.

Index: linux-2.6.git/mm/slab.c
===================================================================
--- linux-2.6.git.orig/mm/slab.c	2005-07-05 17:03:30.000000000 -0700
+++ linux-2.6.git/mm/slab.c	2005-07-05 18:25:20.000000000 -0700
@@ -2372,6 +2372,9 @@
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
+	if (nodeid == -1)
+		return kmem_cache_alloc_node(cachep, flags);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;
 
