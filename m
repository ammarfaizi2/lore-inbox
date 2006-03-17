Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752565AbWCQHXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbWCQHXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbWCQHXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:23:06 -0500
Received: from ns1.suse.de ([195.135.220.2]:50312 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752554AbWCQHWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:22:47 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:30 +1100
Message-Id: <1060317072130.28626@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 6] md: Documentation and tidy up for resize_stripes
References: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Explain the stages of resize_stripes so that it is clear what it
happening, why GFP_NOIO is needed, and how -ENOMEM is handled.

Also move the releasing of old stripes and the old kmem_cache
earlier and lose the need for 'oldstripes'.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 18:18:19.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 18:18:32.000000000 +1100
@@ -334,19 +334,31 @@ static int grow_stripes(raid5_conf_t *co
 }
 static int resize_stripes(raid5_conf_t *conf, int newsize)
 {
-	/* make all the stripes able to hold 'newsize' devices.
+	/* Make all the stripes able to hold 'newsize' devices.
 	 * New slots in each stripe get 'page' set to a new page.
-	 * We allocate all the new stripes first, then if that succeeds,
-	 * copy everything across.
-	 * Finally we add new pages.  This could fail, but we leave
-	 * the stripe cache at it's new size, just with some pages empty.
 	 *
-	 * We use GFP_NOIO allocations as IO to the raid5 is blocked
-	 * at some points in this operation.
+	 * This happens in stages:
+	 * 1/ create a new kmem_cache and allocate the required number of
+	 *    stripe_heads.
+	 * 2/ gather all the old stripe_heads and tranfer the pages across
+	 *    to the new stripe_heads.  This will have the side effect of
+	 *    freezing the array as once all stripe_heads have been collected,
+	 *    no IO will be possible.  Old stripe heads are freed once their
+	 *    pages have been transferred over, and the old kmem_cache is
+	 *    freed when all stripes are done.
+	 * 3/ reallocate conf->disks to be suitable bigger.  If this fails,
+	 *    we simple return a failre status - no need to clean anything up.
+	 * 4/ allocate new pages for the new slots in the new stripe_heads.
+	 *    If this fails, we don't bother trying the shrink the
+	 *    stripe_heads down again, we just leave them as they are.
+	 *    As each stripe_head is processed the new one is released into
+	 *    active service.
+	 *
+	 * Once step2 is started, we cannot afford to wait for a write,
+	 * so we use GFP_NOIO allocations.
 	 */
 	struct stripe_head *osh, *nsh;
 	LIST_HEAD(newstripes);
-	LIST_HEAD(oldstripes);
 	struct disk_info *ndisks;
 	int err = 0;
 	kmem_cache_t *sc;
@@ -355,6 +367,7 @@ static int resize_stripes(raid5_conf_t *
 	if (newsize <= conf->pool_size)
 		return 0; /* never bother to shrink */
 
+	/* Step 1 */
 	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
 			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
 			       0, 0, NULL, NULL);
@@ -362,7 +375,7 @@ static int resize_stripes(raid5_conf_t *
 		return -ENOMEM;
 
 	for (i = conf->max_nr_stripes; i; i--) {
-		nsh = kmem_cache_alloc(sc, GFP_NOIO);
+		nsh = kmem_cache_alloc(sc, GFP_KERNEL);
 		if (!nsh)
 			break;
 
@@ -383,7 +396,8 @@ static int resize_stripes(raid5_conf_t *
 		kmem_cache_destroy(sc);
 		return -ENOMEM;
 	}
-	/* OK, we have enough stripes, start collecting inactive
+	/* Step 2 - Must use GFP_NOIO now.
+	 * OK, we have enough stripes, start collecting inactive
 	 * stripes and copying them over
 	 */
 	list_for_each_entry(nsh, &newstripes, lru) {
@@ -400,10 +414,11 @@ static int resize_stripes(raid5_conf_t *
 			nsh->dev[i].page = osh->dev[i].page;
 		for( ; i<newsize; i++)
 			nsh->dev[i].page = NULL;
-		list_add(&osh->lru, &oldstripes);
+		kmem_cache_free(conf->slab_cache, osh);
 	}
-	/* Got them all.
-	 * Return the new ones and free the old ones.
+	kmem_cache_destroy(conf->slab_cache);
+
+	/* Step 3.
 	 * At this point, we are holding all the stripes so the array
 	 * is completely stalled, so now is a good time to resize
 	 * conf->disks.
@@ -416,6 +431,8 @@ static int resize_stripes(raid5_conf_t *
 		conf->disks = ndisks;
 	} else
 		err = -ENOMEM;
+
+	/* Step 4, return new stripes to service */
 	while(!list_empty(&newstripes)) {
 		nsh = list_entry(newstripes.next, struct stripe_head, lru);
 		list_del_init(&nsh->lru);
@@ -428,12 +445,8 @@ static int resize_stripes(raid5_conf_t *
 			}
 		release_stripe(nsh);
 	}
-	while(!list_empty(&oldstripes)) {
-		osh = list_entry(oldstripes.next, struct stripe_head, lru);
-		list_del(&osh->lru);
-		kmem_cache_free(conf->slab_cache, osh);
-	}
-	kmem_cache_destroy(conf->slab_cache);
+	/* critical section pass, GFP_NOIO no longer needed */
+
 	conf->slab_cache = sc;
 	conf->active_name = 1-conf->active_name;
 	conf->pool_size = newsize;
