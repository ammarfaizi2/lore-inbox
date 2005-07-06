Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVGGAXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVGGAXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGFUER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:04:17 -0400
Received: from graphe.net ([209.204.138.32]:7815 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261801AbVGFRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:47:09 -0400
Date: Wed, 6 Jul 2005 10:47:07 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Fix broken kmalloc_node in rc1/rc2
Message-ID: <Pine.LNX.4.62.0507061042460.30563@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch used to be in Andrew's tree before the NUMA slab allocator went 
in. Either this patch or the NUMA slab allocator is needed in order for
kmalloc_node to work correctly.

pcibus_to_node may be used to generate the node information passed to 
kmalloc_node. pcibus_to_node returns -1 if it was not able to determine
on which node a pcibus is located. For that case kmalloc_node must
work like kmalloc.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc2/mm/slab.c
===================================================================
--- linux-2.6.13-rc2.orig/mm/slab.c	2005-07-06 03:46:33.000000000 +0000
+++ linux-2.6.13-rc2/mm/slab.c	2005-07-06 17:34:19.000000000 +0000
@@ -2372,6 +2372,9 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
+	if (nodeid == -1)
+		return kmem_cache_alloc(cachep, flags);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;
 
