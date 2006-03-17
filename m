Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752467AbWCQEtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbWCQEtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbWCQEtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:49:08 -0500
Received: from ns1.suse.de ([195.135.220.2]:45545 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751419AbWCQEtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:49:02 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:45 +1100
Message-Id: <1060317044745.16072@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 13] md: Allow stripes to be expanded in preparation for expanding an array.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Before a RAID-5 can be expanded, we need to be able to expand the
stripe-cache data structure.  
This requires allocating new stripes in a new kmem_cache.
If this succeeds, we copy cache pages over and release the old
stripes and kmem_cache.
We then allocate new pages.  If that fails, we leave the stripe
cache at it's new size.  It isn't worth the effort to shrink 
it back again.

Unfortuanately this means we need two kmem_cache names as we, for a
short period of time, we have two kmem_caches.  So they are
raid5/%s and raid5/%s-alt


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |  118 +++++++++++++++++++++++++++++++++++++++++--
 ./drivers/md/raid6main.c     |    4 -
 ./include/linux/raid/raid5.h |    9 ++-
 3 files changed, 123 insertions(+), 8 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 11:48:55.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 11:48:56.000000000 +1100
@@ -313,20 +313,130 @@ static int grow_stripes(raid5_conf_t *co
 	kmem_cache_t *sc;
 	int devs = conf->raid_disks;
 
-	sprintf(conf->cache_name, "raid5/%s", mdname(conf->mddev));
-
-	sc = kmem_cache_create(conf->cache_name, 
+	sprintf(conf->cache_name[0], "raid5/%s", mdname(conf->mddev));
+	sprintf(conf->cache_name[1], "raid5/%s-alt", mdname(conf->mddev));
+	conf->active_name = 0;
+	sc = kmem_cache_create(conf->cache_name[conf->active_name],
 			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
 			       0, 0, NULL, NULL);
 	if (!sc)
 		return 1;
 	conf->slab_cache = sc;
+	conf->pool_size = devs;
 	while (num--) {
 		if (!grow_one_stripe(conf))
 			return 1;
 	}
 	return 0;
 }
+static int resize_stripes(raid5_conf_t *conf, int newsize)
+{
+	/* make all the stripes able to hold 'newsize' devices.
+	 * New slots in each stripe get 'page' set to a new page.
+	 * We allocate all the new stripes first, then if that succeeds,
+	 * copy everything across.
+	 * Finally we add new pages.  This could fail, but we leave
+	 * the stripe cache at it's new size, just with some pages empty.
+	 *
+	 * We use GFP_NOIO allocations as IO to the raid5 is blocked
+	 * at some points in this operation.
+	 */
+	struct stripe_head *osh, *nsh;
+	struct list_head newstripes, oldstripes;
+	struct disk_info *ndisks;
+	int err = 0;
+	kmem_cache_t *sc;
+	int i;
+
+	if (newsize <= conf->pool_size)
+		return 0; /* never bother to shrink */
+
+	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
+			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
+			       0, 0, NULL, NULL);
+	if (!sc)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&newstripes);
+	for (i = conf->max_nr_stripes; i; i--) {
+		nsh = kmem_cache_alloc(sc, GFP_NOIO);
+		if (!nsh)
+			break;
+
+		memset(nsh, 0, sizeof(*nsh) + (newsize-1)*sizeof(struct r5dev));
+
+		nsh->raid_conf = conf;
+		spin_lock_init(&nsh->lock);
+
+		list_add(&nsh->lru, &newstripes);
+	}
+	if (i) {
+		/* didn't get enough, give up */
+		while (!list_empty(&newstripes)) {
+			nsh = list_entry(newstripes.next, struct stripe_head, lru);
+			list_del(&nsh->lru);
+			kmem_cache_free(sc, nsh);
+		}
+		kmem_cache_destroy(sc);
+		return -ENOMEM;
+	}
+	/* OK, we have enough stripes, start collecting inactive
+	 * stripes and copying them over
+	 */
+	INIT_LIST_HEAD(&oldstripes);
+	list_for_each_entry(nsh, &newstripes, lru) {
+		spin_lock_irq(&conf->device_lock);
+		wait_event_lock_irq(conf->wait_for_stripe,
+				    !list_empty(&conf->inactive_list),
+				    conf->device_lock,
+				    unplug_slaves(conf->mddev);
+			);
+		osh = get_free_stripe(conf);
+		spin_unlock_irq(&conf->device_lock);
+		atomic_set(&nsh->count, 1);
+		for(i=0; i<conf->pool_size; i++)
+			nsh->dev[i].page = osh->dev[i].page;
+		for( ; i<newsize; i++)
+			nsh->dev[i].page = NULL;
+		list_add(&osh->lru, &oldstripes);
+	}
+	/* Got them all.
+	 * Return the new ones and free the old ones.
+	 * At this point, we are holding all the stripes so the array
+	 * is completely stalled, so now is a good time to resize
+	 * conf->disks.
+	 */
+	ndisks = kzalloc(newsize * sizeof(struct disk_info), GFP_NOIO);
+	if (ndisks) {
+		for (i=0; i<conf->raid_disks; i++)
+			ndisks[i] = conf->disks[i];
+		kfree(conf->disks);
+		conf->disks = ndisks;
+	} else
+		err = -ENOMEM;
+	while(!list_empty(&newstripes)) {
+		nsh = list_entry(newstripes.next, struct stripe_head, lru);
+		list_del_init(&nsh->lru);
+		for (i=conf->raid_disks; i < newsize; i++)
+			if (nsh->dev[i].page == NULL) {
+				struct page *p = alloc_page(GFP_NOIO);
+				nsh->dev[i].page = p;
+				if (!p)
+					err = -ENOMEM;
+			}
+		release_stripe(nsh);
+	}
+	while(!list_empty(&oldstripes)) {
+		osh = list_entry(oldstripes.next, struct stripe_head, lru);
+		list_del(&osh->lru);
+		kmem_cache_free(conf->slab_cache, osh);
+	}
+	kmem_cache_destroy(conf->slab_cache);
+	conf->slab_cache = sc;
+	conf->active_name = 1-conf->active_name;
+	conf->pool_size = newsize;
+	return err;
+}
+
 
 static int drop_one_stripe(raid5_conf_t *conf)
 {
@@ -339,7 +449,7 @@ static int drop_one_stripe(raid5_conf_t 
 		return 0;
 	if (atomic_read(&sh->count))
 		BUG();
-	shrink_buffers(sh, conf->raid_disks);
+	shrink_buffers(sh, conf->pool_size);
 	kmem_cache_free(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
 	return 1;

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-03-17 11:48:55.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-03-17 11:48:56.000000000 +1100
@@ -331,9 +331,9 @@ static int grow_stripes(raid6_conf_t *co
 	kmem_cache_t *sc;
 	int devs = conf->raid_disks;
 
-	sprintf(conf->cache_name, "raid6/%s", mdname(conf->mddev));
+	sprintf(conf->cache_name[0], "raid6/%s", mdname(conf->mddev));
 
-	sc = kmem_cache_create(conf->cache_name,
+	sc = kmem_cache_create(conf->cache_name[0],
 			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
 			       0, 0, NULL, NULL);
 	if (!sc)

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-03-17 11:48:55.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-03-17 11:48:56.000000000 +1100
@@ -216,7 +216,11 @@ struct raid5_private_data {
 	struct list_head	bitmap_list; /* stripes delaying awaiting bitmap update */
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
-	char			cache_name[20];
+	/* unfortunately we need two cache names as we temporarily have
+	 * two caches.
+	 */
+	int			active_name;
+	char			cache_name[2][20];
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
 
 	int			seq_flush, seq_write;
@@ -238,7 +242,8 @@ struct raid5_private_data {
 	wait_queue_head_t	wait_for_overlap;
 	int			inactive_blocked;	/* release of inactive stripes blocked,
 							 * waiting for 25% to be free
-							 */        
+							 */
+	int			pool_size; /* number of disks in stripeheads in pool */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
 };
