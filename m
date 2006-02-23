Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWBWVxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBWVxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWBWVxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:53:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43441 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751775AbWBWVxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:53:41 -0500
Date: Thu, 23 Feb 2006 13:53:21 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: alokk@calsoftinc.com, manfred@colorfullife.com,
       Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org,
       Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
In-Reply-To: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0602231352430.14987@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two issues in the patch as suggested by Kiran:

1. next_node() cannot return a node number >MAX_NUMNODES. So use ==

2. Node online map should not be empty during bootup so we can
   skip the code that I added to deal with that situation.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc4/mm/slab.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/slab.c	2006-02-23 10:20:16.000000000 -0800
+++ linux-2.6.16-rc4/mm/slab.c	2006-02-23 13:28:34.000000000 -0800
@@ -803,7 +803,7 @@ static void init_reap_node(int cpu)
 	int node;
 
 	node = next_node(cpu_to_node(cpu), node_online_map);
-	if (node >= MAX_NUMNODES)
+	if (node == MAX_NUMNODES)
 		node = 0;
 
 	__get_cpu_var(reap_node) = node;
@@ -820,15 +820,8 @@ static void next_reap_node(void)
 		drain_node_pages(node);
 
 	node = next_node(node, node_online_map);
-	if (unlikely(node >= MAX_NUMNODES)) {
+	if (unlikely(node >= MAX_NUMNODES))
 		node = first_node(node_online_map);
-		/*
-		 * If the node_online_map is empty (early boot) then
-		 * only use node zero.
-		*/
-		if (node >= MAX_NUMNODES)
-			node = 0;
-	}
 	__get_cpu_var(reap_node) = node;
 }
 

