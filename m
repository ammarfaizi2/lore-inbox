Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSILLoT>; Thu, 12 Sep 2002 07:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSILLoS>; Thu, 12 Sep 2002 07:44:18 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:48776 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315413AbSILLoO>; Thu, 12 Sep 2002 07:44:14 -0400
Date: Thu, 12 Sep 2002 04:48:51 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.34/drivers/ide/ide.c was building list of drives in reverse order
Message-ID: <20020912044851.A382@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	ata_attach in linux-2.5.34/drivers/ide/ide.c builds a list of
IDE drives that do not yet have a device driver bound to them, in case
ide-disk, ide-scsi, or whatever driver you want to use is not loaded
yet.

	The problem was that ata_attach was adding to the head of
the list, so the list was being built in reverse order.  So, if
you had two IDE disks, and ide-disk was a loadable module, the
devfs entries for the disks would be numbered in reverse (the
first disk would be /dev/discs/disc1, and the second would be
/dev/discs/disc0).

	The follow patch fixes the problem by changing the relevant
list_add to list_add_tail.  Incidentally, the generic code
in drivers/base/ already does it this way.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide.diff"

--- linux-2.5.34/drivers/ide/ide.c	2002-09-09 10:35:06.000000000 -0700
+++ linux/drivers/ide/ide.c	2002-09-12 04:30:20.000000000 -0700
@@ -2478,11 +2478,11 @@
 		if (driver->owner)
 			__MOD_DEC_USE_COUNT(driver->owner);
 	}
 	spin_unlock(&drivers_lock);
 	spin_lock(&drives_lock);
-	list_add(&drive->list, &ata_unused);
+	list_add_tail(&drive->list, &ata_unused);
 	spin_unlock(&drives_lock);
 	return 1;
 }
 
 static int ide_ioctl (struct inode *inode, struct file *file,

--IS0zKkzwUGydFO0o--
