Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263495AbSIVGic>; Sun, 22 Sep 2002 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbSIVGib>; Sun, 22 Sep 2002 02:38:31 -0400
Received: from m088067.ap.plala.or.jp ([219.164.88.67]:47232 "HELO
	mana.fennel.org") by vger.kernel.org with SMTP id <S263495AbSIVGib>;
	Sun, 22 Sep 2002 02:38:31 -0400
Date: Sun, 22 Sep 2002 15:43:31 +0900 (JST)
Message-Id: <20020922.154331.51732591.sian@big.or.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: make bzImage fails on 2.5.38
From: Hiroshi Takekawa <sian@big.or.jp>
In-Reply-To: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
References: <1999.202.54.87.179.1032675381.squirrel@mail.nls.ac.in>
	<Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
X-Mailer: Mew version 3.0.64 on Emacs 21.3 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIvU0FLQUtJKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's diff for this.
No sooner than had I made this diff than I read your mail...
But just replacing devfs_handle with cdroms causes weird
cdroms/cdroms/cdrom0 symlink.
Please review.

> > First post to the list, I've followed the format given in REPORTING-BUGS
> > 
> > 1. make bzImage fails on 2.5.38

> Arrgh.

> ed fs/partitions/check.c <<EOF
> 365s/devfs_handle/cdroms/
> w
> q
> EOF

diff -Naur linux-2.5.38.vanilla/fs/partitions/check.c linux-2.5.38/fs/partitions/check.c
--- linux-2.5.38.vanilla/fs/partitions/check.c	Sun Sep 22 15:27:26 2002
+++ linux-2.5.38/fs/partitions/check.c	Sun Sep 22 15:17:10 2002
@@ -338,17 +338,13 @@
 static void devfs_create_cdrom(struct gendisk *dev)
 {
 #ifdef CONFIG_DEVFS_FS
-	int pos = 0;
-	devfs_handle_t dir, slave;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
-	char dirname[64], symlink[16];
 	char vname[23];
 
 	if (!cdroms)
 		cdroms = devfs_mk_dir (NULL, "cdroms", NULL);
 
 	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
-	sprintf(vname, "cdroms/cdrom%d", dev->number);
+	sprintf(vname, "cdrom%d", dev->number);
 	if (dev->de) {
 		int pos;
 		devfs_handle_t slave;
@@ -362,13 +358,13 @@
 		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
 		if (pos >= 0) {
 			strncpy(rname + pos, "../", 3);
-			devfs_mk_symlink(devfs_handle, vname,
+			devfs_mk_symlink(cdroms, vname,
 					 DEVFS_FL_DEFAULT,
 					 rname + pos, &slave, NULL);
 			devfs_auto_unregister(dev->de, slave);
 		}
 	} else {
-		dev->disk_de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
+		dev->disk_de = devfs_register (cdroms, vname, DEVFS_FL_DEFAULT,
 				    dev->major, dev->first_minor,
 				    S_IFBLK | S_IRUGO | S_IWUGO,
 				    dev->fops, NULL);
