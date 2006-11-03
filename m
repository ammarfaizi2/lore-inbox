Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753269AbWKCPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbWKCPew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbWKCPev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:34:51 -0500
Received: from mx27.mail.ru ([194.67.23.64]:65083 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1753269AbWKCPeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:34:50 -0500
X-Nat-Received: from [10.10.231.1]:2380 [ident-empty]
	by rt-cwn.z-net.ru with TPROXY id 1162568092.17157
	abuse-to abuse@ss-lan.ru
Date: Fri, 3 Nov 2006 19:36:59 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ide-cs hang after device removal 2
Message-ID: <20061103163659.GA16034@localhost>
Reply-To: cbou@mail.ru
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi!

Andrew, can you please replace
fix-ide-cs-hang-after-device-removal.patch by attached one?

They are exactly same, but -2.patch do not touches SCSI's sd.c.
Todd Blumer found that SCSI do get_device() and must put it back,
thus my assumption that SCSI also affected was wrong.

Thanks,

-- Anton (irc: bd2)

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="fix-ide-cs-hang-after-device-removal-2.patch"

From: Anton Vorontsov <cbou@mail.ru>

I've caught deadlock inside IDE layer using IDE-CS: after accessing to IDE
disk placed in PCMCIA (CF card really), it will never probe again after
pulling it from PCMCIA/CF.

The kernel is stuck at
drivers/ide/ide.c:ide_unregister():604:

        602                 spin_unlock_irq(&ide_lock);
        603                 device_unregister(&drive->gendev);
        604                 wait_for_completion(&drive->gendev_rel_comp);
        605                 spin_lock_irq(&ide_lock);

ide_unregister() assumes that device_unregister() will call
ide-probe.c:drive_release_dev():

        1282 static void drive_release_dev (struct device *dev)
        1283 {
        ....         [...]
        1302         complete(&drive->gendev_rel_comp);
        1303 }

        1311 static void init_gendisk (ide_hwif_t *hwif)
        1312 {
        ....
        1323                 drive->gendev.release = drive_release_dev;
        ....
        1333 }

But release() function will not called because drive->gendev is still
referenced inside genhd layer.


No need to get_device(driverfs_dev), because it's already gotten by
add_disk().  And no function will call put_device() second time.  This is
the source of deadlock[1] in IDE layer.

[1] deadlock in ide_unregister()

at wait_for_completion(&drive->gendev_rel_comp) after
device_unregister(&drive->gendev).  That happens by reason of
ide-probe.c:drive_release_dev() not called because of driverfs_dev (which
is drive->gendev) still referenced by add_disk().

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Anton Vorontsov <cbou@mail.ru>
---

 fs/partitions/check.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 6fb4b61..8371adf 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -378,7 +378,7 @@ static char *make_block_name(struct gend
 
 static int disk_sysfs_symlinks(struct gendisk *disk)
 {
-	struct device *target = get_device(disk->driverfs_dev);
+	struct device *target = disk->driverfs_dev;
 	int err;
 	char *disk_name = NULL;
 
@@ -414,9 +414,8 @@ err_out_dev_link:
 		sysfs_remove_link(&disk->kobj, "device");
 err_out_disk_name:
 		kfree(disk_name);
-err_out:
-		put_device(target);
 	}
+err_out:
 	return err;
 }
 
_

--FL5UXtIhxfXey3p5--
