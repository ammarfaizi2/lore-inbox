Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSFJKed>; Mon, 10 Jun 2002 06:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSFJKec>; Mon, 10 Jun 2002 06:34:32 -0400
Received: from surf.viawest.net ([216.87.64.26]:64975 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S316842AbSFJKeb>;
	Mon, 10 Jun 2002 06:34:31 -0400
Date: Mon, 10 Jun 2002 03:34:15 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: dalecki@evision-ventures.com
Cc: devfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Make IDE and DevFS get along
Message-ID: <20020610103415.GA303@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.21 (i686)
X-uptime: 3:23am  up 1 min,  3 users,  load average: 0.10, 0.05, 0.01
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Martin,

        A feature/patch from one of the generic IDE patchsets was introduced 
into kernels >= 2.5.19 that, when DevFS is used, creates a directory called 
/dev/ata, and a symlink to /dev/ata, called /dev/ide. This setup breaks DevFS' 
use, as it does not follow the symlink when the IDE driver is initialised. 
DevFS uses /dev/ide, which is the published interface, to create the 
symlinks to /dev/hd*, which are created after reading /etc/fstab to get the 
partitions. When /dev/ata is used, DevFS doesn't know what it is, can't find 
/dev/ide/* for the /dev/hd* symlinks to be created, and drops into single user 
mode to fix. This will always happen for anyone with their root partition on 
an IDE drive, with DevFS used. The following patch fixes this problem.

                                                        BL.

        P.S. The only other way around this, would be to rewrite /etc/fstab to 
find the full patch to the /dev/ata/host*.../part1 partition for / . That 
really shouldn't have to be done.

-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF


--- linux/drivers/ide/main.c.ata	Mon Jun 10 02:47:50 2002
+++ linux/drivers/ide/main.c	Mon Jun 10 02:49:03 2002
@@ -1290,8 +1290,7 @@
 {
 	printk(KERN_INFO "ATA/ATAPI device driver v" VERSION "\n");
 
-	ide_devfs_handle = devfs_mk_dir(NULL, "ata", NULL);
-	devfs_mk_symlink(NULL, "ide", DEVFS_FL_DEFAULT, "ata", NULL, NULL);
+	ide_devfs_handle = devfs_mk_dir(NULL, "ide", NULL);
 
 	/*
 	 * Because most of the ATA adapters represent the timings in unit of
