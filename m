Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWAQG4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWAQG4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAQG4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:56:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:20903 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751210AbWAQG4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:56:25 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Jan 2006 17:56:19 +1100
Message-Id: <1060117065619.27843@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH 002 of 5] md: Allow stripes to be expanded in preparation for expanding an array.
References: <20060117174531.27739.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Before a RAID-5 can be expanded, we need to be able to expand the
stripe-cache data structure.  
This requires allocating new stripes in a new kmem_cache.
If this succeeds, we copy cache pages over and release the old
stripes and kmem_cache.
We then allocate new pages.  If that fails, we leave the stripe
cache at it's new size.  It isn't worth the effort to shink 
it back again.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |  116 +++++++++++++++++++++++++++++++++++++++++--
 ./drivers/md/raid6main.c     |    4 -
 ./include/linux/raid/raid5.h |    9 ++-
 3 files changed, 121 insertions(+), 8 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-17 17:33:09.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-17 17:33:23.000000000 +1100
@@ -313,14 +313,16 @@ static int grow_stripes(raid5_conf_t *co
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
@@ -328,6 +330,112 @@ static int grow_stripes(raid5_conf_t *co
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
+		nsh = kmem_cache_alloc(sc, GFP_KERNEL);
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
+	ndisks = kzalloc(newsize * sizeof(struct disk_info), GFP_KERNEL);
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
+				struct page *p = alloc_page(GFP_KERNEL);
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
+
 static int drop_one_stripe(raid5_conf_t *conf)
 {
 	struct stripe_head *sh;
@@ -339,7 +447,7 @@ static int drop_one_stripe(raid5_conf_t 
 		return 0;
 	if (atomic_read(&sh->count))
 		BUG();
-	shrink_buffers(sh, conf->raid_disks);
+	shrink_buffers(sh, conf->pool_size);
 	kmem_cache_free(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
 	return 1;

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-01-17 17:33:09.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-01-17 17:33:23.000000000 +1100
@@ -308,9 +308,9 @@ static int grow_stripes(raid6_conf_t *co
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
--- ./include/linux/raid/raid5.h~current~	2006-01-17 17:33:09.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-01-17 17:33:23.000000000 +1100
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
