Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWAXD6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWAXD6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWAXD6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:58:53 -0500
Received: from ns2.suse.de ([195.135.220.15]:18102 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964992AbWAXD6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:58:43 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Jan 2006 14:58:37 +1100
Message-Id: <1060124035837.28848@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 5] md: Add sysfs access to raid6 stripe cache size
References: <20060124145516.28734.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


.. just as we already have for raid5.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid6main.c |  149 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 34 deletions(-)

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-01-24 14:53:49.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-01-24 14:53:49.000000000 +1100
@@ -115,7 +115,7 @@ static void __release_stripe(raid6_conf_
 			list_add_tail(&sh->lru, &conf->inactive_list);
 			atomic_dec(&conf->active_stripes);
 			if (!conf->inactive_blocked ||
-			    atomic_read(&conf->active_stripes) < (NR_STRIPES*3/4))
+			    atomic_read(&conf->active_stripes) < (conf->max_nr_stripes*3/4))
 				wake_up(&conf->wait_for_stripe);
 		}
 	}
@@ -273,7 +273,8 @@ static struct stripe_head *get_active_st
 				conf->inactive_blocked = 1;
 				wait_event_lock_irq(conf->wait_for_stripe,
 						    !list_empty(&conf->inactive_list) &&
-						    (atomic_read(&conf->active_stripes) < (NR_STRIPES *3/4)
+						    (atomic_read(&conf->active_stripes)
+						     < (conf->max_nr_stripes *3/4)
 						     || !conf->inactive_blocked),
 						    conf->device_lock,
 						    unplug_slaves(conf->mddev);
@@ -302,9 +303,31 @@ static struct stripe_head *get_active_st
 	return sh;
 }
 
-static int grow_stripes(raid6_conf_t *conf, int num)
+static int grow_one_stripe(raid6_conf_t *conf)
 {
 	struct stripe_head *sh;
+	sh = kmem_cache_alloc(conf->slab_cache, GFP_KERNEL);
+	if (!sh)
+		return 0;
+	memset(sh, 0, sizeof(*sh) + (conf->raid_disks-1)*sizeof(struct r5dev));
+	sh->raid_conf = conf;
+	spin_lock_init(&sh->lock);
+
+	if (grow_buffers(sh, conf->raid_disks)) {
+		shrink_buffers(sh, conf->raid_disks);
+		kmem_cache_free(conf->slab_cache, sh);
+		return 0;
+	}
+	/* we just created an active stripe so... */
+	atomic_set(&sh->count, 1);
+	atomic_inc(&conf->active_stripes);
+	INIT_LIST_HEAD(&sh->lru);
+	release_stripe(sh);
+	return 1;
+}
+
+static int grow_stripes(raid6_conf_t *conf, int num)
+{
 	kmem_cache_t *sc;
 	int devs = conf->raid_disks;
 
@@ -316,44 +339,33 @@ static int grow_stripes(raid6_conf_t *co
 	if (!sc)
 		return 1;
 	conf->slab_cache = sc;
-	while (num--) {
-		sh = kmem_cache_alloc(sc, GFP_KERNEL);
-		if (!sh)
+	while (num--)
+		if (!grow_one_stripe(conf))
 			return 1;
-		memset(sh, 0, sizeof(*sh) + (devs-1)*sizeof(struct r5dev));
-		sh->raid_conf = conf;
-		spin_lock_init(&sh->lock);
-
-		if (grow_buffers(sh, conf->raid_disks)) {
-			shrink_buffers(sh, conf->raid_disks);
-			kmem_cache_free(sc, sh);
-			return 1;
-		}
-		/* we just created an active stripe so... */
-		atomic_set(&sh->count, 1);
-		atomic_inc(&conf->active_stripes);
-		INIT_LIST_HEAD(&sh->lru);
-		release_stripe(sh);
-	}
 	return 0;
 }
 
-static void shrink_stripes(raid6_conf_t *conf)
+static int drop_one_stripe(raid6_conf_t *conf)
 {
 	struct stripe_head *sh;
+	spin_lock_irq(&conf->device_lock);
+	sh = get_free_stripe(conf);
+	spin_unlock_irq(&conf->device_lock);
+	if (!sh)
+		return 0;
+	if (atomic_read(&sh->count))
+		BUG();
+	shrink_buffers(sh, conf->raid_disks);
+	kmem_cache_free(conf->slab_cache, sh);
+	atomic_dec(&conf->active_stripes);
+	return 1;
+}
+
+static void shrink_stripes(raid6_conf_t *conf)
+{
+	while (drop_one_stripe(conf))
+		;
 
-	while (1) {
-		spin_lock_irq(&conf->device_lock);
-		sh = get_free_stripe(conf);
-		spin_unlock_irq(&conf->device_lock);
-		if (!sh)
-			break;
-		if (atomic_read(&sh->count))
-			BUG();
-		shrink_buffers(sh, conf->raid_disks);
-		kmem_cache_free(conf->slab_cache, sh);
-		atomic_dec(&conf->active_stripes);
-	}
 	kmem_cache_destroy(conf->slab_cache);
 	conf->slab_cache = NULL;
 }
@@ -1912,6 +1924,74 @@ static void raid6d (mddev_t *mddev)
 	PRINTK("--- raid6d inactive\n");
 }
 
+static ssize_t
+raid6_show_stripe_cache_size(mddev_t *mddev, char *page)
+{
+	raid6_conf_t *conf = mddev_to_conf(mddev);
+	if (conf)
+		return sprintf(page, "%d\n", conf->max_nr_stripes);
+	else
+		return 0;
+}
+
+static ssize_t
+raid6_store_stripe_cache_size(mddev_t *mddev, const char *page, size_t len)
+{
+	raid6_conf_t *conf = mddev_to_conf(mddev);
+	char *end;
+	int new;
+	if (len >= PAGE_SIZE)
+		return -EINVAL;
+	if (!conf)
+		return -ENODEV;
+
+	new = simple_strtoul(page, &end, 10);
+	if (!*page || (*end && *end != '\n') )
+		return -EINVAL;
+	if (new <= 16 || new > 32768)
+		return -EINVAL;
+	while (new < conf->max_nr_stripes) {
+		if (drop_one_stripe(conf))
+			conf->max_nr_stripes--;
+		else
+			break;
+	}
+	while (new > conf->max_nr_stripes) {
+		if (grow_one_stripe(conf))
+			conf->max_nr_stripes++;
+		else break;
+	}
+	return len;
+}
+
+static struct md_sysfs_entry
+raid6_stripecache_size = __ATTR(stripe_cache_size, S_IRUGO | S_IWUSR,
+				raid6_show_stripe_cache_size,
+				raid6_store_stripe_cache_size);
+
+static ssize_t
+stripe_cache_active_show(mddev_t *mddev, char *page)
+{
+	raid6_conf_t *conf = mddev_to_conf(mddev);
+	if (conf)
+		return sprintf(page, "%d\n", atomic_read(&conf->active_stripes));
+	else
+		return 0;
+}
+
+static struct md_sysfs_entry
+raid6_stripecache_active = __ATTR_RO(stripe_cache_active);
+
+static struct attribute *raid6_attrs[] =  {
+	&raid6_stripecache_size.attr,
+	&raid6_stripecache_active.attr,
+	NULL,
+};
+static struct attribute_group raid6_attrs_group = {
+	.name = NULL,
+	.attrs = raid6_attrs,
+};
+
 static int run(mddev_t *mddev)
 {
 	raid6_conf_t *conf;
@@ -2095,6 +2175,7 @@ static int stop (mddev_t *mddev)
 	shrink_stripes(conf);
 	kfree(conf->stripe_hashtbl);
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
+	sysfs_remove_group(&mddev->kobj, &raid6_attrs_group);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
