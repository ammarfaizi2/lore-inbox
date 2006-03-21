Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWCUXMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWCUXMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWCUXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:12:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17382 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751837AbWCUXMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:12:45 -0500
Date: Tue, 21 Mar 2006 15:12:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: slab: Bypass free lists for __drain_alien_cache()
In-Reply-To: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603211511110.14245@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__drain_alien_cache() currently drains objects by freeing them to the 
(remote) freelists of the original node. However, each node also has a 
shared list containing objects to be used on any processor of that node. 
We can avoid a number of remote node accesses by copying the pointers to 
the free objects directly into the remote shared array.

Depends on the earlier patch that introduces the transfer_objects() function.

And while we are at it: Skip alien draining if the alien cache spinlock is
already taken.

Kiran reported that this is a performance benefit.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-21 14:53:40.000000000 -0800
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 14:55:09.000000000 -0800
@@ -974,6 +974,13 @@ static void __drain_alien_cache(struct k
 
 	if (ac->avail) {
 		spin_lock(&rl3->list_lock);
+		/*
+		 * Stuff objects into the remote nodes shared array first.
+		 * That way we could avoid the overhead of putting the objects
+		 * into the free lists and getting them back later.
+		 */
+		transfer_objects(rl3->shared, ac, ac->limit);
+
 		free_block(cachep, ac->entry, ac->avail, node);
 		ac->avail = 0;
 		spin_unlock(&rl3->list_lock);
@@ -989,8 +996,8 @@ static void reap_alien(struct kmem_cache
 
 	if (l3->alien) {
 		struct array_cache *ac = l3->alien[node];
-		if (ac && ac->avail) {
-			spin_lock_irq(&ac->lock);
+
+		if (ac && ac->avail && spin_trylock_irq(&ac->lock)) {
 			__drain_alien_cache(cachep, ac, node);
 			spin_unlock_irq(&ac->lock);
 		}

