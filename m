Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263307AbTC0RII>; Thu, 27 Mar 2003 12:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTC0RHR>; Thu, 27 Mar 2003 12:07:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55685
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263307AbTC0RGY>; Thu, 27 Mar 2003 12:06:24 -0500
Date: Thu, 27 Mar 2003 18:23:53 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271823.h2RINrCZ019696@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quota should not reference user addresses directly
(Stanford Checker, Chris Wright)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/fs/quota.c linux-2.5.66-ac1/fs/quota.c
--- linux-2.5.66-bk3/fs/quota.c	2003-03-27 17:13:35.000000000 +0000
+++ linux-2.5.66-ac1/fs/quota.c	2003-03-22 20:36:49.000000000 +0000
@@ -221,12 +221,17 @@
 	uint cmds, type;
 	struct super_block *sb = NULL;
 	struct block_device *bdev;
+	char *tmp;
 	int ret = -ENODEV;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
-	bdev = lookup_bdev(special);
+	tmp = getname(special);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	bdev = lookup_bdev(tmp);
+	putname(tmp);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 	sb = get_super(bdev);
