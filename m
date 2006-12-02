Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162349AbWLBLNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162349AbWLBLNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162944AbWLBLNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:13:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:42728 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162349AbWLBLNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:13:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=siQ8jv7LEiuW34E4UbyUhUzPxpqkTgRqvyTbJplY7XnWepSjfDCj7vWIRUD6OmgP1sCasB9hfX0+7+7zH2ZUncv/lOmujLpJ0IMkcxggHlYiBlSZ/So95Ty0aBYHM+SIsDMnSsuCsqLEdT/Kp1G3PD/I0rn3vh31J1I/P1zi6e8=
Subject: [PATCH 2.6.19] nfsd: replace kmalloc+memset with kcalloc +
	simplify NULL check
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:08:26 +0200
Message-Id: <1165057706.4523.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kcalloc and simplify

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rup linux-2.6.19-rc6_orig/fs/nfsd/nfscache.c linux-2.6.19-rc6/fs/nfsd/nfscache.c
--- linux-2.6.19-rc6_orig/fs/nfsd/nfscache.c	2006-11-22 20:29:19.000000000 +0200
+++ linux-2.6.19-rc6/fs/nfsd/nfscache.c	2006-11-24 13:38:47.000000000 +0200
@@ -66,14 +66,13 @@ nfsd_cache_init(void)
 		printk (KERN_ERR "nfsd: cannot allocate all %d cache entries, only got %d\n",
 			CACHESIZE, CACHESIZE-i);
 
-	hash_list = kmalloc (HASHSIZE * sizeof(struct hlist_head), GFP_KERNEL);
+	hash_list = kcalloc (HASHSIZE, sizeof(struct hlist_head), GFP_KERNEL);
 	if (!hash_list) {
 		nfsd_cache_shutdown();
 		printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for hash list\n",
 			HASHSIZE * sizeof(struct hlist_head));
 		return;
 	}
-	memset(hash_list, 0, HASHSIZE * sizeof(struct hlist_head));
 
 	cache_disabled = 0;
 }
diff -rup linux-2.6.19-rc6_orig/fs/nfsd/vfs.c linux-2.6.19-rc6/fs/nfsd/vfs.c
--- linux-2.6.19-rc6_orig/fs/nfsd/vfs.c	2006-11-22 20:29:19.000000000 +0200
+++ linux-2.6.19-rc6/fs/nfsd/vfs.c	2006-11-24 13:48:31.000000000 +0200
@@ -1885,28 +1885,27 @@ nfsd_racache_init(int cache_size)
 		return 0;
 	if (cache_size < 2*RAPARM_HASH_SIZE)
 		cache_size = 2*RAPARM_HASH_SIZE;
-	raparml = kmalloc(sizeof(struct raparms) * cache_size, GFP_KERNEL);
+	raparml = kcalloc(cache_size, sizeof(struct raparms), GFP_KERNEL);
 
-	if (raparml != NULL) {
-		dprintk("nfsd: allocating %d readahead buffers.\n",
-			cache_size);
-		for (i = 0 ; i < RAPARM_HASH_SIZE ; i++) {
-			raparm_hash[i].pb_head = NULL;
-			spin_lock_init(&raparm_hash[i].pb_lock);
-		}
-		nperbucket = cache_size >> RAPARM_HASH_BITS;
-		memset(raparml, 0, sizeof(struct raparms) * cache_size);
-		for (i = 0; i < cache_size - 1; i++) {
-			if (i % nperbucket == 0)
-				raparm_hash[j++].pb_head = raparml + i;
-			if (i % nperbucket < nperbucket-1)
-				raparml[i].p_next = raparml + i + 1;
-		}
-	} else {
+	if (!raparml) {
 		printk(KERN_WARNING
-		       "nfsd: Could not allocate memory read-ahead cache.\n");
+			"nfsd: Could not allocate memory read-ahead cache.\n");
 		return -ENOMEM;
 	}
+
+	dprintk("nfsd: allocating %d readahead buffers.\n", cache_size);
+	for (i = 0 ; i < RAPARM_HASH_SIZE ; i++) {
+		raparm_hash[i].pb_head = NULL;
+		spin_lock_init(&raparm_hash[i].pb_lock);
+	}
+	nperbucket = cache_size >> RAPARM_HASH_BITS;
+	for (i = 0; i < cache_size - 1; i++) {
+		if (i % nperbucket == 0)
+			raparm_hash[j++].pb_head = raparml + i;
+		if (i % nperbucket < nperbucket-1)
+			raparml[i].p_next = raparml + i + 1;
+	}
+
 	nfsdstats.ra_size = cache_size;
 	return 0;
 }


