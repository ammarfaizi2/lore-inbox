Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCRUh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCRUh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWCRUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:37:57 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:52044 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750954AbWCRUh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:37:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nh0o5wHGn495D1c3wvju1kKQj/S2E6eny/mhCLXPE1bpS1CC6yzapApIPnZg7NHcm1UNiU6ICNzidW0+f26zT4wLiQSjMd3TLDqwvupPNqTCVcf5f6wDHvzqp2mbb3D6i6LZvsv8ZB9PeKpkC0+YDzHTfWKFBVl2j7oiyzkiWWM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try #2)
Date: Sat, 18 Mar 2006 21:37:08 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182137.08521.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found that we may leak memory in
mm/slab.c::alloc_kmemlist()
This should fix the leak and coverity bug #589

Currently the only caller of alloc_kmemlist() will BUG() if alloc_kmemlist()
fails, but that doesn't mean we shouldn't clean up properly IMHO. Also, the 
caller (do_tune_cpucache()) could maybe be changed in the future to do 
something more clever than just BUG() and in that case we really shouldn't
be leaking memory when we return -ENOMEM.

The patch introduces one more loop to the function in the failure path :-(
But, since we are very unlikely to ever hit the failure path this shouldn't
be too painfull.

The patch has been compile and boot tested on x86, but since I'm not very
intimate with the slab code I'd appreciate it if someone would take a close
look on the changes before merging them.
IMO this patch should not go into 2.6.16, but instead spend some time in -mm
with the intention to merge it for 2.6.17 - although it does fix a real leak 
it's not a regression compared to 2.6.15.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 mm/slab.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc6-mm2-orig/mm/slab.c	2006-03-18 16:55:55.000000000 +0100
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-18 21:10:56.000000000 +0100
@@ -3399,12 +3399,17 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
 static int alloc_kmemlist(struct kmem_cache *cachep)
 {
 	int node;
+	int count = -1;
 	struct kmem_list3 *l3;
-	int err = 0;
+	struct array_cache *new;
+	struct array_cache **new_alien;
 
 	for_each_online_node(node) {
-		struct array_cache *nc = NULL, *new;
-		struct array_cache **new_alien = NULL;
+		struct array_cache *nc = NULL;
+
+		new = NULL;
+		new_alien = NULL;
+		count++;
 #ifdef CONFIG_NUMA
 		new_alien = alloc_alien_cache(node, cachep->limit);
 		if (!new_alien)
@@ -3447,10 +3452,28 @@ static int alloc_kmemlist(struct kmem_ca
 					cachep->batchcount + cachep->num;
 		cachep->nodelists[node] = l3;
 	}
-	return err;
+	return 0;
+/*
+   If one or more allocations fail we need to undo all allocations done up to
+   this point.
+   Unfortunately this means yet another loop, but since this only happens on
+   failure and frees up memory in a memory-tight situation, it's not too bad.
+ */
 fail:
-	err = -ENOMEM;
-	return err;
+	kfree(new);
+	free_alien_cache(new_alien);
+	for_each_online_node(node) {
+		if (count <= 0)
+			break;
+		if (cachep->nodelists[node]) {
+			kfree(cachep->nodelists[node]->shared);
+			free_alien_cache(cachep->nodelists[node]->alien);
+			kfree(cachep->nodelists[node]);
+			cachep->nodelists[node] = NULL;
+		}
+		count--;
+	}
+	return -ENOMEM;
 }
 
 struct ccupdate_struct {



