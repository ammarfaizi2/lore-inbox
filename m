Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbTCSX0N>; Wed, 19 Mar 2003 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbTCSX0M>; Wed, 19 Mar 2003 18:26:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261177AbTCSXZy>;
	Wed, 19 Mar 2003 18:25:54 -0500
Subject: [PATCH 2.5.65] update md driver to new module API
From: Daniel McNeil <daniel@osdl.org>
To: NeilBrown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@redhat.com>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-3/OloTUa/n+X9AYxcuCN"
Organization: 
Message-Id: <1048117006.2637.19.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Mar 2003 15:36:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3/OloTUa/n+X9AYxcuCN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch updates the md driver and personalities to the new
module interfaces.

An owner field has been added to the struct mdk_personality_s.
This is initialized by each personality module.  The md driver
now attempts to take a reference to the personality before calling
the personality's run routine.  A pers_lock was added to protect 
the setting, clearing and reading of pers[] entries. This protects
try_module_get() racing with unregister_md_personality().

I have tested each personality as a module.

-- 
Daniel McNeil <daniel@osdl.org>

--=-3/OloTUa/n+X9AYxcuCN
Content-Disposition: attachment; filename=patch-2.5.65-md
Content-Type: text/x-patch; name=patch-2.5.65-md; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff linux-2.5.65/arch/i386/kernel/i386_ksyms.c linux-2.5.65-md/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.65/arch/i386/kernel/i386_ksyms.c	Mon Mar 17 13:44:50 2003
+++ linux-2.5.65-md/arch/i386/kernel/i386_ksyms.c	Wed Mar 19 11:27:53 2003
@@ -76,6 +76,7 @@ EXPORT_SYMBOL(xquad_portio);
 #ifndef CONFIG_X86_WP_WORKS_OK
 EXPORT_SYMBOL(__verify_write);
 #endif
+EXPORT_SYMBOL(kernel_fpu_begin);
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/linear.c linux-2.5.65-md/drivers/md/linear.c
--- linux-2.5.65/drivers/md/linear.c	Mon Mar 17 13:44:04 2003
+++ linux-2.5.65-md/drivers/md/linear.c	Wed Mar 19 14:43:10 2003
@@ -75,8 +75,6 @@ static int linear_run (mddev_t *mddev)
 	unsigned int curr_offset;
 	struct list_head *tmp;
 
-	MOD_INC_USE_COUNT;
-
 	conf = kmalloc (sizeof (*conf), GFP_KERNEL);
 	if (!conf)
 		goto out;
@@ -163,7 +161,6 @@ static int linear_run (mddev_t *mddev)
 out:
 	if (conf)
 		kfree(conf);
-	MOD_DEC_USE_COUNT;
 	return 1;
 }
 
@@ -174,8 +171,6 @@ static int linear_stop (mddev_t *mddev)
 	kfree(conf->hash_table);
 	kfree(conf);
 
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
@@ -241,6 +236,7 @@ static mdk_personality_t linear_personal
 	.run		= linear_run,
 	.stop		= linear_stop,
 	.status		= linear_status,
+	.owner		= THIS_MODULE
 };
 
 static int __init linear_init (void)
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/md.c linux-2.5.65-md/drivers/md/md.c
--- linux-2.5.65/drivers/md/md.c	Mon Mar 17 13:43:50 2003
+++ linux-2.5.65-md/drivers/md/md.c	Tue Mar 18 17:25:02 2003
@@ -63,6 +63,12 @@
 static void autostart_arrays (void);
 #endif
 
+/*
+ * pers_lock protects the setting, clearing and reading of pers[] entries.
+ * This protects try_module_get() racing with unregister_md_personality().
+ */
+static spinlock_t pers_lock = SPIN_LOCK_UNLOCKED;
+
 static mdk_personality_t *pers[MAX_PERSONALITY];
 
 /*
@@ -182,7 +188,6 @@ static void mddev_put(mddev_t *mddev)
 		list_del(&mddev->all_mddevs);
 		mddev_map[mdidx(mddev)] = NULL;
 		kfree(mddev);
-		MOD_DEC_USE_COUNT;
 	}
 	spin_unlock(&all_mddevs_lock);
 }
@@ -204,7 +209,6 @@ static mddev_t * mddev_find(int unit)
 		mddev_map[unit] = new;
 		list_add(&new->all_mddevs, &all_mddevs);
 		spin_unlock(&all_mddevs_lock);
-		MOD_INC_USE_COUNT;
 		return new;
 	}
 	spin_unlock(&all_mddevs_lock);
@@ -1605,6 +1609,7 @@ static int do_md_run(mddev_t * mddev)
 	struct list_head *tmp;
 	mdk_rdev_t *rdev;
 	struct gendisk *disk;
+	mdk_personality_t *per;
 
 	if (list_empty(&mddev->disks)) {
 		MD_BUG();
@@ -1664,23 +1669,29 @@ static int do_md_run(mddev_t * mddev)
 		return -EINVAL;
 	}
 
-	if (!pers[pnum])
-	{
 #ifdef CONFIG_KMOD
+	if (!pers[pnum]) {
 		char module_name[80];
 		sprintf (module_name, "md-personality-%d", pnum);
 		request_module (module_name);
-		if (!pers[pnum])
+	}
 #endif
-		{
-			printk(KERN_ERR "md: personality %d is not loaded!\n",
-				pnum);
+	/*
+	 * Get a module reference for the personality.
+	 */
+	spin_lock(&pers_lock);
+	per = pers[pnum];
+	if (per == 0 || !try_module_get(per->owner)) {
+		spin_unlock(&pers_lock);
+		printk(KERN_ERR "md: personality %d is not loaded!\n", pnum);
 			return -EINVAL;
-		}
 	}
+	spin_unlock(&pers_lock);
 
-	if (device_size_calculation(mddev))
+	if (device_size_calculation(mddev)) {
+		module_put(per->owner);		/* drop ref on personality */
 		return -EINVAL;
+	}
 
 	/*
 	 * Drop all container device buffers, from now on
@@ -1709,9 +1720,11 @@ static int do_md_run(mddev_t * mddev)
 
 	md_probe(mdidx(mddev), NULL, NULL);
 	disk = disks[mdidx(mddev)];
-	if (!disk)
+	if (!disk) {
+		module_put(per->owner);		/* drop ref on personality */
 		return -ENOMEM;
-	mddev->pers = pers[pnum];
+	}
+	mddev->pers = per;
 
 	blk_queue_make_request(&mddev->queue, mddev->pers->make_request);
 	printk("%s: setting max_sectors to %d, segment boundary to %d\n",
@@ -1724,6 +1737,7 @@ static int do_md_run(mddev_t * mddev)
 
 	err = mddev->pers->run(mddev);
 	if (err) {
+		module_put(per->owner);		/* drop ref on personality */
 		printk(KERN_ERR "md: pers->run() failed ...\n");
 		mddev->pers = NULL;
 		return -EINVAL;
@@ -1826,6 +1840,10 @@ static int do_md_stop(mddev_t * mddev, i
 					set_disk_ro(disk, 1);
 				goto out;
 			}
+			/*
+			 * Drop module reference to personality.
+			 */
+			module_put(mddev->pers->owner);
 			mddev->pers = NULL;
 			if (mddev->ro)
 				mddev->ro = 0;
@@ -3040,10 +3058,12 @@ static int md_seq_show(struct seq_file *
 
 	if (v == (void*)1) {
 		seq_printf(seq, "Personalities : ");
+		spin_lock(&pers_lock);
 		for (i = 0; i < MAX_PERSONALITY; i++)
 			if (pers[i])
 				seq_printf(seq, "[%s] ", pers[i]->name);
 
+		spin_unlock(&pers_lock);
 		seq_printf(seq, "\n");
 		return 0;
 	}
@@ -3127,12 +3147,15 @@ int register_md_personality(int pnum, md
 		return -EINVAL;
 	}
 
+	spin_lock(&pers_lock);
 	if (pers[pnum]) {
+		spin_unlock(&pers_lock);
 		MD_BUG();
 		return -EBUSY;
 	}
 
 	pers[pnum] = p;
+	spin_unlock(&pers_lock);
 	printk(KERN_INFO "md: %s personality registered as nr %d\n", p->name, pnum);
 	return 0;
 }
@@ -3145,7 +3168,9 @@ int unregister_md_personality(int pnum)
 	}
 
 	printk(KERN_INFO "md: %s personality unregistered\n", pers[pnum]->name);
+	spin_lock(&pers_lock);
 	pers[pnum] = NULL;
+	spin_unlock(&pers_lock);
 	return 0;
 }
 
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/multipath.c linux-2.5.65-md/drivers/md/multipath.c
--- linux-2.5.65/drivers/md/multipath.c	Mon Mar 17 13:44:05 2003
+++ linux-2.5.65-md/drivers/md/multipath.c	Tue Mar 18 17:27:28 2003
@@ -416,8 +416,6 @@ static int multipath_run (mddev_t *mddev
 	mdk_rdev_t *rdev;
 	struct list_head *tmp;
 
-	MOD_INC_USE_COUNT;
-
 	if (mddev->level != LEVEL_MULTIPATH) {
 		printk(INVALID_LEVEL, mdidx(mddev), mddev->level);
 		goto out;
@@ -491,7 +489,6 @@ out_free_conf:
 	kfree(conf);
 	mddev->private = NULL;
 out:
-	MOD_DEC_USE_COUNT;
 	return -EIO;
 }
 
@@ -515,7 +512,6 @@ static int multipath_stop (mddev_t *mdde
 	mempool_destroy(conf->pool);
 	kfree(conf);
 	mddev->private = NULL;
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -529,6 +525,7 @@ static mdk_personality_t multipath_perso
 	.error_handler	= multipath_error,
 	.hot_add_disk	= multipath_add_disk,
 	.hot_remove_disk= multipath_remove_disk,
+	.owner		= THIS_MODULE
 };
 
 static int __init multipath_init (void)
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/raid0.c linux-2.5.65-md/drivers/md/raid0.c
--- linux-2.5.65/drivers/md/raid0.c	Mon Mar 17 13:44:07 2003
+++ linux-2.5.65-md/drivers/md/raid0.c	Tue Mar 18 17:28:22 2003
@@ -191,8 +191,6 @@ static int raid0_run (mddev_t *mddev)
 	s64 size;
 	raid0_conf_t *conf;
 
-	MOD_INC_USE_COUNT;
-
 	conf = vmalloc(sizeof (raid0_conf_t));
 	if (!conf)
 		goto out;
@@ -267,7 +265,6 @@ out_free_conf:
 	vfree(conf);
 	mddev->private = NULL;
 out:
-	MOD_DEC_USE_COUNT;
 	return 1;
 }
 
@@ -282,7 +279,6 @@ static int raid0_stop (mddev_t *mddev)
 	vfree (conf);
 	mddev->private = NULL;
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -415,6 +411,7 @@ static mdk_personality_t raid0_personali
 	.run		= raid0_run,
 	.stop		= raid0_stop,
 	.status		= raid0_status,
+	.owner		= THIS_MODULE
 };
 
 static int __init raid0_init (void)
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/raid1.c linux-2.5.65-md/drivers/md/raid1.c
--- linux-2.5.65/drivers/md/raid1.c	Mon Mar 17 13:44:07 2003
+++ linux-2.5.65-md/drivers/md/raid1.c	Tue Mar 18 17:29:10 2003
@@ -1109,8 +1109,6 @@ static int run(mddev_t *mddev)
 	mdk_rdev_t *rdev;
 	struct list_head *tmp;
 
-	MOD_INC_USE_COUNT;
-
 	if (mddev->level != 1) {
 		printk(INVALID_LEVEL, mdidx(mddev), mddev->level);
 		goto out;
@@ -1206,7 +1204,6 @@ out_free_conf:
 	kfree(conf);
 	mddev->private = NULL;
 out:
-	MOD_DEC_USE_COUNT;
 	return -EIO;
 }
 
@@ -1220,7 +1217,6 @@ static int stop(mddev_t *mddev)
 		mempool_destroy(conf->r1bio_pool);
 	kfree(conf);
 	mddev->private = NULL;
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1236,6 +1232,7 @@ static mdk_personality_t raid1_personali
 	.hot_remove_disk= raid1_remove_disk,
 	.spare_active	= raid1_spare_active,
 	.sync_request	= sync_request,
+	.owner		= THIS_MODULE
 };
 
 static int __init raid_init(void)
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/drivers/md/raid5.c linux-2.5.65-md/drivers/md/raid5.c
--- linux-2.5.65/drivers/md/raid5.c	Mon Mar 17 13:43:45 2003
+++ linux-2.5.65-md/drivers/md/raid5.c	Tue Mar 18 17:29:45 2003
@@ -1410,11 +1410,8 @@ static int run (mddev_t *mddev)
 	struct disk_info *disk;
 	struct list_head *tmp;
 
-	MOD_INC_USE_COUNT;
-
 	if (mddev->level != 5 && mddev->level != 4) {
 		printk("raid5: md%d: raid level not set to 4/5 (%d)\n", mdidx(mddev), mddev->level);
-		MOD_DEC_USE_COUNT;
 		return -EIO;
 	}
 
@@ -1524,7 +1521,6 @@ abort:
 	}
 	mddev->private = NULL;
 	printk(KERN_ALERT "raid5: failed to run raid set md%d\n", mdidx(mddev));
-	MOD_DEC_USE_COUNT;
 	return -EIO;
 }
 
@@ -1540,7 +1536,6 @@ static int stop (mddev_t *mddev)
 	free_pages((unsigned long) conf->stripe_hashtbl, HASH_PAGES_ORDER);
 	kfree(conf);
 	mddev->private = NULL;
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1702,6 +1697,7 @@ static mdk_personality_t raid5_personali
 	.hot_remove_disk= raid5_remove_disk,
 	.spare_active	= raid5_spare_active,
 	.sync_request	= sync_request,
+	.owner		= THIS_MODULE
 };
 
 static int __init raid5_init (void)
diff -rupN -X /home/daniel/dontdiff linux-2.5.65/include/linux/raid/md_k.h linux-2.5.65-md/include/linux/raid/md_k.h
--- linux-2.5.65/include/linux/raid/md_k.h	Mon Mar 17 13:43:39 2003
+++ linux-2.5.65-md/include/linux/raid/md_k.h	Tue Mar 18 17:04:30 2003
@@ -266,6 +266,7 @@ struct mdk_personality_s
 	int (*hot_remove_disk) (mddev_t *mddev, int number);
 	int (*spare_active) (mddev_t *mddev);
 	int (*sync_request)(mddev_t *mddev, sector_t sector_nr, int go_faster);
+	struct module *owner;
 };
 
 

--=-3/OloTUa/n+X9AYxcuCN--

