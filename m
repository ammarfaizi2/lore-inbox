Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVGFAFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVGFAFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVGFAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:05:20 -0400
Received: from graphe.net ([209.204.138.32]:39309 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262007AbVGFAFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:05:10 -0400
Date: Tue, 5 Jul 2005 17:05:02 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
In-Reply-To: <20050705235521.GN12786@krispykreme>
Message-ID: <Pine.LNX.4.62.0507051700360.5130@graphe.net>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net>
 <20050705225908.GL12786@krispykreme> <Pine.LNX.4.62.0507051632100.2289@graphe.net>
 <20050705235521.GN12786@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Anton Blanchard wrote:

> Its using the default. Looking at include/asm-generic/topology.h:
> 
> #ifndef pcibus_to_node
> #define pcibus_to_node(node)    (-1)
> #endif
> 
> I wonder what kmalloc_node does when you pass it -1.

That is the issue. It should fall back to kmalloc. One piece of the 
patchset dropped out between Andrew and Linus.

Index: linux-2.6.git/mm/slab.c
===================================================================
--- linux-2.6.git.orig/mm/slab.c	2005-07-05 17:03:30.000000000 -0700
+++ linux-2.6.git/mm/slab.c	2005-07-05 17:04:09.000000000 -0700
@@ -2443,6 +2443,9 @@
 {
 	kmem_cache_t *cachep;
 
+	if (node == -1)
+		return kmalloc(size, flags);
+
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
