Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVGFBG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGFBG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGFBG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:06:29 -0400
Received: from ozlabs.org ([203.10.76.45]:39119 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261825AbVGFBG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:06:26 -0400
Date: Wed, 6 Jul 2005 11:04:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
Message-ID: <20050706010450.GO12786@krispykreme>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net> <20050705225908.GL12786@krispykreme> <Pine.LNX.4.62.0507051632100.2289@graphe.net> <20050705235521.GN12786@krispykreme> <Pine.LNX.4.62.0507051700360.5130@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507051700360.5130@graphe.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> That is the issue. It should fall back to kmalloc. One piece of the 
> patchset dropped out between Andrew and Linus.

That helped, but I still had lots of free memory in the request_queue
slab. Giving kmem_cache_alloc_node the same treatment fixed it, although
I wonder if we just shouldnt be passing in -1.

Anton

Index: foobar2/mm/slab.c
===================================================================
--- foobar2.orig/mm/slab.c	2005-07-06 10:47:47.950435997 +1000
+++ foobar2/mm/slab.c	2005-07-06 10:59:59.945684235 +1000
@@ -2372,6 +2372,9 @@
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
+	if (nodeid == -1)
+		return kmem_cache_alloc(cachep, flags);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;
 
@@ -2443,6 +2446,9 @@
 {
 	kmem_cache_t *cachep;
 
+	if (node == -1)
+		return kmalloc(size, flags);
+
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
