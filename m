Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSKKWrL>; Mon, 11 Nov 2002 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSKKWrL>; Mon, 11 Nov 2002 17:47:11 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24534 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261506AbSKKWrC>; Mon, 11 Nov 2002 17:47:02 -0500
Date: Mon, 11 Nov 2002 23:53:40 +0100
To: dm@uk.sistina.com, linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] make device mapper compile on 2.5.4x
Message-ID: <20021111225340.GA3587@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

device mapper does not compile on my 2.4.x tree, because of an argument
incompatibility in set_device_ro(). Please find attached a patch, which
makes this file compile. I am not sure if it is correct, since I do not
unterstand whats going on here, and have not tested it yet. Please somebody
have a look at it since it it broken for multiple releases, yet.

BTW: I also suggest to remove the www.sistina.com/lvm/ url from the
MAINTAINER file since it does not contain any useful information anymore.

Greetings
Bernd

--- drivers/md/dm-ioctl.c~	2002-11-11 23:27:38.000000000 +0100
+++ drivers/md/dm-ioctl.c	2002-11-11 23:43:41.000000000 +0100
@@ -560,6 +560,7 @@
 	struct dm_table *t;
 	struct mapped_device *md;
 	int minor;
+	struct block_device *bdev;
 
 	r = check_name(param->name);
 	if (r)
@@ -585,7 +586,12 @@
 	}
 	dm_table_put(t);	/* md will have grabbed its own reference */
 
-	set_device_ro(dm_kdev(md), 0/*(param->flags & DM_READONLY_FLAG)*/);
+	bdev = bdget(kdev_t_to_nr(dm_kdev(md)));
+	if (!bdev)
+		return -ENXIO;
+	set_device_ro(bdev, (param->flags & DM_READONLY_FLAG));
+	bdput(bdev);
+
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	dm_put(md);
 
@@ -847,6 +853,7 @@
 	int r;
 	struct mapped_device *md;
 	struct dm_table *t;
+	struct block_device *bdev;
 
 	r = dm_table_create(&t, get_mode(param));
 	if (r)
@@ -871,7 +878,12 @@
 		return r;
 	}
 
-	set_device_ro(dm_kdev(md), (param->flags & DM_READONLY_FLAG));
+	bdev = bdget(kdev_t_to_nr(dm_kdev(md)));
+	if (!bdev)
+		return -ENXIO;
+	set_device_ro(bdev, (param->flags & DM_READONLY_FLAG));
+	bdput(bdev);
+
 	dm_put(md);
 
 	r = info(param, user);


-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
