Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268828AbTBZRAo>; Wed, 26 Feb 2003 12:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268829AbTBZRAn>; Wed, 26 Feb 2003 12:00:43 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:10768 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268828AbTBZRAl>; Wed, 26 Feb 2003 12:00:41 -0500
Date: Wed, 26 Feb 2003 17:10:18 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] dm: deregister the misc device before removing /dev/mapper
Message-ID: <20030226171018.GD8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix problem with devfs when unloading the dm module.

dm-ioctl.c: deregister the misc device, and its associated symlink
*before* removing the /dev/mapper dir.  [Alasdair Kergon]

--- diff/drivers/md/dm-ioctl.c	2003-02-26 16:09:52.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2003-02-26 16:09:57.000000000 +0000
@@ -1123,17 +1123,17 @@
 	return 0;
 
       failed:
+	devfs_remove(DM_DIR "/control");
+	if (misc_deregister(&_dm_misc) < 0)
+		DMERR("misc_deregister failed for control device");
 	dm_hash_exit();
-	misc_deregister(&_dm_misc);
 	return r;
 }
 
 void dm_interface_exit(void)
 {
-	dm_hash_exit();
-
 	devfs_remove(DM_DIR "/control");
-
 	if (misc_deregister(&_dm_misc) < 0)
 		DMERR("misc_deregister failed for control device");
+	dm_hash_exit();
 }
