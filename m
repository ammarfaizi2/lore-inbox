Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423079AbWBBGCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423079AbWBBGCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422991AbWBBGCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:02:36 -0500
Received: from cantor.suse.de ([195.135.220.2]:40418 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422969AbWBBGCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:02:20 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 2 Feb 2006 17:02:10 +1100
Message-Id: <1060202060210.15972@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 3] md: Assorted little md fixes:
References: <20060202165638.15890.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- version-1 superblock
  + The default_bitmap_offset is in sectors, not bytes.
  + the 'size' field in the superblock is in sectors, not KB
- raid0_run should return a negative number on error, not '1'
- raid10_read_balance should not return a valid 'disk' number if
     ->rdev turned out to be NULL
- kmem_cache_destroy doesn't like being passed a NULL.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c        |    4 ++--
 ./drivers/md/raid0.c     |    2 +-
 ./drivers/md/raid10.c    |    2 ++
 ./drivers/md/raid5.c     |    3 ++-
 ./drivers/md/raid6main.c |    3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-02-02 16:48:47.000000000 +1100
+++ ./drivers/md/md.c	2006-02-02 16:51:46.000000000 +1100
@@ -1082,7 +1082,7 @@ static int super_1_validate(mddev_t *mdd
 		mddev->size = le64_to_cpu(sb->size)/2;
 		mddev->events = le64_to_cpu(sb->events);
 		mddev->bitmap_offset = 0;
-		mddev->default_bitmap_offset = 1024;
+		mddev->default_bitmap_offset = 1024 >> 9;
 		
 		mddev->recovery_cp = le64_to_cpu(sb->resync_offset);
 		memcpy(mddev->uuid, sb->set_uuid, 16);
@@ -1163,7 +1163,7 @@ static void super_1_sync(mddev_t *mddev,
 	sb->cnt_corrected_read = atomic_read(&rdev->corrected_errors);
 
 	sb->raid_disks = cpu_to_le32(mddev->raid_disks);
-	sb->size = cpu_to_le64(mddev->size);
+	sb->size = cpu_to_le64(mddev->size<<1);
 
 	if (mddev->bitmap && mddev->bitmap_file == NULL) {
 		sb->bitmap_offset = cpu_to_le32((__u32)mddev->bitmap_offset);

diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
--- ./drivers/md/raid0.c~current~	2006-02-02 16:48:19.000000000 +1100
+++ ./drivers/md/raid0.c	2006-02-02 16:51:53.000000000 +1100
@@ -372,7 +372,7 @@ out_free_conf:
 	kfree(conf);
 	mddev->private = NULL;
 out:
-	return 1;
+	return -ENOMEM;
 }
 
 static int raid0_stop (mddev_t *mddev)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-02-02 16:48:19.000000000 +1100
+++ ./drivers/md/raid10.c	2006-02-02 16:51:53.000000000 +1100
@@ -565,6 +565,8 @@ rb_out:
 
 	if (disk >= 0 && (rdev=rcu_dereference(conf->mirrors[disk].rdev))!= NULL)
 		atomic_inc(&conf->mirrors[disk].rdev->nr_pending);
+	else
+		disk = -1;
 	rcu_read_unlock();
 
 	return disk;

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-02-02 16:48:19.000000000 +1100
+++ ./drivers/md/raid5.c	2006-02-02 16:51:53.000000000 +1100
@@ -350,7 +350,8 @@ static void shrink_stripes(raid5_conf_t 
 	while (drop_one_stripe(conf))
 		;
 
-	kmem_cache_destroy(conf->slab_cache);
+	if (conf->slab_cache)
+		kmem_cache_destroy(conf->slab_cache);
 	conf->slab_cache = NULL;
 }
 

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-02-02 16:48:19.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-02-02 16:55:25.000000000 +1100
@@ -366,7 +366,8 @@ static void shrink_stripes(raid6_conf_t 
 	while (drop_one_stripe(conf))
 		;
 
-	kmem_cache_destroy(conf->slab_cache);
+	if (conf->slab_cache)
+		kmem_cache_destroy(conf->slab_cache);
 	conf->slab_cache = NULL;
 }
 
