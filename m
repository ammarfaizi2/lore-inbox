Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTIXXCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbTIXXCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:02:11 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:1129 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261648AbTIXXCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:02:08 -0400
Subject: [PATCH} fix defect with kobject memory leaks during del_gendisk
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: linux-kernel@vger.kernel.org, mochel@osdl.org
Content-Type: multipart/mixed; boundary="=-fdwTP49u8g34iAyN1SMj"
Organization: MontaVista Software, Inc.
Message-Id: <1064444526.13033.355.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 24 Sep 2003 16:02:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fdwTP49u8g34iAyN1SMj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Folks,

Attached is a patch which fixes a few memory leaks in 2.6.0-test5. 
Comments are welcome as to whether or not this patch is the right
solution.

I added the ability to linux MD to generate add and remove hotplug calls
on RAID START and STOPs.  To achieve this, I use the del_gendisk call
which deletes the gendisk, delete the children kobjects, and delete the
parent (in this case, mdX) kobject.

Unfortunately it appears that del_gendisk uses kobject_del to delete the
kobject.  If the kobject has a ktype release function, it is not called
in the kobject_del call path, but only in kobject_unregister.

This patch changes the functionality so the release function (in this
case the block device release function in drivers/block/genhd.c) is
called by changing the kobject_del to kobject_unregister.

Without this patch, at least 3 memory leaks occur on removal of a block
device using the del_gendisk function.

Thanks
-steve

--=-fdwTP49u8g34iAyN1SMj
Content-Disposition: attachment; filename=fix_del_gendisk_kobj.patch
Content-Type: text/plain; name=fix_del_gendisk_kobj.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test5/fs/partitions/check.c	2003-09-08 12:50:28.000000000 -0700
+++ linux-fixmd/fs/partitions/check.c	2003-09-24 15:28:57.000000000 -0700
@@ -458,5 +458,5 @@
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
-	kobject_del(&disk->kobj);
+	kobject_unregister(&disk->kobj);
 }

--=-fdwTP49u8g34iAyN1SMj--

