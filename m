Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVG3A6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVG3A6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVG3AzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:55:19 -0400
Received: from graphe.net ([209.204.138.32]:4755 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262851AbVG3Axk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:53:40 -0400
Date: Fri, 29 Jul 2005 17:53:34 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050729152049.4b172d78.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0507291746000.8663@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Paul Jackson wrote:

> My first suspicion on reading it is that it might partially duplicate
> some string conversion code and syntax that is already present in
> the kernel for other purposes.  For example the nodelists might
> replicate the lists of numbers supported by bitmap_scnlistprintf
> and bitmap_parselist.

Ahh. Yes these allow to simplify things somewhat and allow more 
flexiblity when specifying nodelists for interleave. Wish there was 
something similar for zonelists. Thanks.

> micro-micro-language for describing memory policies, it is difficult to
> know what the syntax is, without reverse engineering it from the code.

Umm.. that is what we do all day but maybe you could have a look at my 
initial patch which actually included a description of the syntax which 
is a straighforward representation of the possible variations on a memory 
policy.

Diff to use bitmap_scnlistprintf and bitmap_parselist.

Index: linux-2.6.13-rc3-mm3/mm/mempolicy.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/mm/mempolicy.c	2005-07-29 17:49:41.000000000 -0700
+++ linux-2.6.13-rc3-mm3/mm/mempolicy.c	2005-07-29 17:52:13.000000000 -0700
@@ -1181,7 +1181,6 @@
 	char *p = buffer;
 	char *e = buffer + maxlen;
 	int first = 1;
-	int node;
 	struct zone **z;
 
 	if (!pol || pol->policy == MPOL_DEFAULT) {
@@ -1223,18 +1222,7 @@
 			return -ENOSPC;
 
 		p += sprintf(p, "interleave={");
-
-		for_each_node(node)
-			if (test_bit(node, pol->v.nodes)) {
-				if (!first)
-					*p++ = ',';
-				else
-					first = 0;
-				if (e < p + 2 /* min bytes that follow */ + 4 /* node number */)
-					return -ENOSPC;
-				p += sprintf(p, "%d", node);
-			}
-
+		p += bitmap_scnprintf(p, e-p-2, pol->v.nodes, MAX_NUMNODES);
 		*p++ = '}';
 		*p++ = 0;
 		return p-buffer;
@@ -1279,20 +1267,8 @@
 	} else if (strnicmp(buffer, "interleave={", 12) == 0) {
 
 		pol->policy = MPOL_INTERLEAVE;
-		p = buffer + 12;
-		bitmap_zero(pol->v.nodes, MAX_NUMNODES);
-
-		do {
-			node = simple_strtoul(p, &p, 10);
-
-			/* Check here for cpuset restrictions on nodes */
-			if (node >= MAX_NUMNODES || !node_online(node))
-				goto out;
-			set_bit(node, pol->v.nodes);
-
-		} while (*p++ == ',');
-
-		if (p[-1] != '}' || bitmap_empty(pol->v.nodes, MAX_NUMNODES))
+		if (bitmap_parselist(buffer + 12, pol->v.nodes, MAX_NUMNODES) ||
+		    bitmap_empty(pol->v.nodes, MAX_NUMNODES))
 			goto out;
 
 	} else if (strnicmp(buffer, "bind={", 6) == 0) {
