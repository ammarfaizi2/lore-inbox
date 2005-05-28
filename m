Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVE1A0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVE1A0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 20:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVE1A0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 20:26:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:10720 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262626AbVE1AZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 20:25:42 -0400
Date: Sat, 28 May 2005 02:30:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christophe Saout <christophe@saout.de>,
       Clemens Fruhwirth <clemens@endorphin.org>, zyngier@ufr-info-p7.ibp.fr,
       maz@gloups.fdn.fr, Ingo Molnar <mingo@redhat.com>,
       Mika Kuoppala <miku@iki.fi>,
       =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@ostenfeld.dk>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] remove unneeded NULL checks before kfree from drivers/md/*
Message-ID: <Pine.LNX.4.62.0505280222180.2370@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes some unneeded checks of pointers being NULL before 
calling kfree() on them. kfree() handles NULL pointers just fine, checking 
first is pointless.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/md/dm-crypt.c  |    3 +--
 drivers/md/linear.c    |    3 +--
 drivers/md/md.c        |   10 +++-------
 drivers/md/multipath.c |    3 +--
 drivers/md/raid0.c     |   12 +++++-------
 drivers/md/raid1.c     |   12 ++++--------
 drivers/md/raid10.c    |    6 ++----
 7 files changed, 17 insertions(+), 32 deletions(-)

diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/dm-crypt.c linux-2.6.12-rc5-mm1/drivers/md/dm-crypt.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/dm-crypt.c	2005-05-27 23:21:14.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/dm-crypt.c	2005-05-28 02:13:25.000000000 +0200
@@ -704,8 +704,7 @@ static void crypt_dtr(struct dm_target *
 	mempool_destroy(cc->page_pool);
 	mempool_destroy(cc->io_pool);
 
-	if (cc->iv_mode)
-		kfree(cc->iv_mode);
+	kfree(cc->iv_mode);
 	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
 		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/linear.c linux-2.6.12-rc5-mm1/drivers/md/linear.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/linear.c	2005-05-27 23:21:14.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/linear.c	2005-05-28 02:17:14.000000000 +0200
@@ -217,8 +217,7 @@ static int linear_run (mddev_t *mddev)
 	return 0;
 
 out:
-	if (conf)
-		kfree(conf);
+	kfree(conf);
 	return 1;
 }
 
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/md.c linux-2.6.12-rc5-mm1/drivers/md/md.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/md.c	2005-05-27 23:23:35.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/md.c	2005-05-28 02:17:59.000000000 +0200
@@ -195,8 +195,7 @@ static mddev_t * mddev_find(dev_t unit)
 		if (mddev->unit == unit) {
 			mddev_get(mddev);
 			spin_unlock(&all_mddevs_lock);
-			if (new)
-				kfree(new);
+			kfree(new);
 			return mddev;
 		}
 
@@ -458,11 +457,8 @@ static int sb_equal(mdp_super_t *sb1, md
 		ret = 1;
 
 abort:
-	if (tmp1)
-		kfree(tmp1);
-	if (tmp2)
-		kfree(tmp2);
-
+	kfree(tmp1);
+	kfree(tmp2);
 	return ret;
 }
 
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/multipath.c linux-2.6.12-rc5-mm1/drivers/md/multipath.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/multipath.c	2005-05-27 23:21:14.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/multipath.c	2005-05-28 02:18:29.000000000 +0200
@@ -533,8 +533,7 @@ static int multipath_run (mddev_t *mddev
 out_free_conf:
 	if (conf->pool)
 		mempool_destroy(conf->pool);
-	if (conf->multipaths)
-		kfree(conf->multipaths);
+	kfree(conf->multipaths);
 	kfree(conf);
 	mddev->private = NULL;
 out:
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/raid0.c linux-2.6.12-rc5-mm1/drivers/md/raid0.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/raid0.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc5-mm1/drivers/md/raid0.c	2005-05-28 02:19:02.000000000 +0200
@@ -371,10 +371,8 @@ static int raid0_run (mddev_t *mddev)
 	return 0;
 
 out_free_conf:
-	if (conf->strip_zone)
-		kfree(conf->strip_zone);
-	if (conf->devlist)
-		kfree (conf->devlist);
+	kfree(conf->strip_zone);
+	kfree(conf->devlist);
 	kfree(conf);
 	mddev->private = NULL;
 out:
@@ -386,11 +384,11 @@ static int raid0_stop (mddev_t *mddev)
 	raid0_conf_t *conf = mddev_to_conf(mddev);
 
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
-	kfree (conf->hash_table);
+	kfree(conf->hash_table);
 	conf->hash_table = NULL;
-	kfree (conf->strip_zone);
+	kfree(conf->strip_zone);
 	conf->strip_zone = NULL;
-	kfree (conf);
+	kfree(conf);
 	mddev->private = NULL;
 
 	return 0;
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/raid1.c linux-2.6.12-rc5-mm1/drivers/md/raid1.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/raid1.c	2005-05-27 23:23:35.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/raid1.c	2005-05-28 02:19:39.000000000 +0200
@@ -1427,10 +1427,8 @@ out_free_conf:
 	if (conf) {
 		if (conf->r1bio_pool)
 			mempool_destroy(conf->r1bio_pool);
-		if (conf->mirrors)
-			kfree(conf->mirrors);
-		if (conf->poolinfo)
-			kfree(conf->poolinfo);
+		kfree(conf->mirrors);
+		kfree(conf->poolinfo);
 		kfree(conf);
 		mddev->private = NULL;
 	}
@@ -1447,10 +1445,8 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	if (conf->r1bio_pool)
 		mempool_destroy(conf->r1bio_pool);
-	if (conf->mirrors)
-		kfree(conf->mirrors);
-	if (conf->poolinfo)
-		kfree(conf->poolinfo);
+	kfree(conf->mirrors);
+	kfree(conf->poolinfo);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
diff -upr linux-2.6.12-rc5-mm1-orig/drivers/md/raid10.c linux-2.6.12-rc5-mm1/drivers/md/raid10.c
--- linux-2.6.12-rc5-mm1-orig/drivers/md/raid10.c	2005-05-27 23:23:35.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/md/raid10.c	2005-05-28 02:19:58.000000000 +0200
@@ -1737,8 +1737,7 @@ static int run(mddev_t *mddev)
 out_free_conf:
 	if (conf->r10bio_pool)
 		mempool_destroy(conf->r10bio_pool);
-	if (conf->mirrors)
-		kfree(conf->mirrors);
+	kfree(conf->mirrors);
 	kfree(conf);
 	mddev->private = NULL;
 out:
@@ -1754,8 +1753,7 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	if (conf->r10bio_pool)
 		mempool_destroy(conf->r10bio_pool);
-	if (conf->mirrors)
-		kfree(conf->mirrors);
+	kfree(conf->mirrors);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;



