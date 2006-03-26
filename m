Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWCZWYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWCZWYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWCZWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:24:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:31890 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbWCZWYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:24:04 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 27 Mar 2006 09:22:26 +1100
Message-Id: <1060326222226.15751@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: Convert reconfig_sem to reconfig_mutex
References: <20060327092201.15732.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


... being careful that mutex_trylock is inverted wrt down_trylock

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   14 +++++++-------
 ./include/linux/raid/md_k.h |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-27 09:21:08.000000000 +1100
+++ ./drivers/md/md.c	2006-03-27 09:21:19.000000000 +1100
@@ -254,7 +254,7 @@ static mddev_t * mddev_find(dev_t unit)
 	else
 		new->md_minor = MINOR(unit) >> MdpMinorShift;
 
-	init_MUTEX(&new->reconfig_sem);
+	mutex_init(&new->reconfig_mutex);
 	INIT_LIST_HEAD(&new->disks);
 	INIT_LIST_HEAD(&new->all_mddevs);
 	init_timer(&new->safemode_timer);
@@ -276,22 +276,22 @@ static mddev_t * mddev_find(dev_t unit)
 
 static inline int mddev_lock(mddev_t * mddev)
 {
-	return down_interruptible(&mddev->reconfig_sem);
+	return mutex_lock_interruptible(&mddev->reconfig_mutex);
 }
 
 static inline void mddev_lock_uninterruptible(mddev_t * mddev)
 {
-	down(&mddev->reconfig_sem);
+	mutex_lock(&mddev->reconfig_mutex);
 }
 
 static inline int mddev_trylock(mddev_t * mddev)
 {
-	return down_trylock(&mddev->reconfig_sem);
+	return mutex_trylock(&mddev->reconfig_mutex);
 }
 
 static inline void mddev_unlock(mddev_t * mddev)
 {
-	up(&mddev->reconfig_sem);
+	mutex_unlock(&mddev->reconfig_mutex);
 
 	md_wakeup_thread(mddev->thread);
 }
@@ -4892,7 +4892,7 @@ void md_check_recovery(mddev_t *mddev)
 		))
 		return;
 
-	if (mddev_trylock(mddev)==0) {
+	if (mddev_trylock(mddev)) {
 		int spares =0;
 
 		spin_lock_irq(&mddev->write_lock);
@@ -5028,7 +5028,7 @@ static int md_notify_reboot(struct notif
 		printk(KERN_INFO "md: stopping all md devices.\n");
 
 		ITERATE_MDDEV(mddev,tmp)
-			if (mddev_trylock(mddev)==0)
+			if (mddev_trylock(mddev))
 				do_md_stop (mddev, 1);
 		/*
 		 * certain more exotic SCSI devices are known to be

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-03-27 09:21:09.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-03-27 09:21:19.000000000 +1100
@@ -185,7 +185,7 @@ struct mddev_s
 	unsigned long			recovery;
 
 	int				in_sync;	/* know to not need resync */
-	struct semaphore		reconfig_sem;
+	struct mutex			reconfig_mutex;
 	atomic_t			active;
 
 	int				changed;	/* true if we might need to reread partition info */
