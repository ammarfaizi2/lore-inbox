Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTLSTDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTLSTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:03:06 -0500
Received: from linux.us.dell.com ([143.166.224.162]:23712 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263015AbTLSTCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:02:00 -0500
Date: Fri, 19 Dec 2003 13:01:56 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-ID: <20031219130156.C6530@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 19, 2003 at 12:57:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1532.1.3, 2003-12-18 17:43:51-06:00, Matt_Domsch@dell.com
  EDD: add sysfs symlinks for IDE devices
  
  Devices reporting as type "ATA" to the EDD 3.0 BIOS calls
  now get symlinks pointing from the int13_dev8x device
  to the IDE disk device in sysfs.
  
  EDD 3.0 maps all IDE devices on a single PCI device with a single
  device value; there's no concept of multiple channels,
  primary/secondary devices on a channel.  This may not be equivalent,
  but edd.c currently matches only based on ide_drive_t.lun ==
  EDD device value.  This should perhaps be taken up with
  the T13 committee, as their spec seems incomplete in this regard.


 edd.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions, 1 deletion


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Dec 19 12:53:46 2003
+++ b/arch/i386/kernel/edd.c	Fri Dec 19 12:53:46 2003
@@ -55,12 +55,13 @@
 /* FIXME - this really belongs in include/scsi/scsi.h */
 #include <../drivers/scsi/scsi.h>
 #include <../drivers/scsi/hosts.h>
+#include <linux/ide.h>
 
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.12 2003-Dec-18"
+#define EDD_VERSION "0.13 2003-Dec-18"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -647,6 +648,90 @@
 }
 #endif
 
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+
+struct edd_ide_match_data {
+	struct edd_device	* edev;
+	ide_drive_t	        * ide_drive;
+};
+
+/**
+ * edd_match_idedev()
+ * @edev - EDD device is a known IDE device
+ * @sd - ide_device with host who's parent is a PCI controller
+ *
+ * returns 1 if a match is found, 0 if not.
+ */
+static int edd_match_idedev(struct device * dev, void * d)
+{
+	struct edd_ide_match_data * data = (struct edd_ide_match_data *)d;
+	struct edd_info *info = edd_dev_get_info(data->edev);
+	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
+
+	if (info && drive) {
+		if (drive->lun == info->params.device_path.ata.device) {
+			data->ide_drive = drive;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * edd_find_matching_ide_device()
+ * @edev - edd_device to match
+ *
+ * Search the IDE devices for a drive that matches the EDD
+ * device descriptor we have. If we find a match, return it,
+ * otherwise, return NULL.
+ */
+
+static ide_drive_t *
+edd_find_matching_ide_device(struct edd_device *edev)
+{
+	struct edd_ide_match_data data;
+	struct bus_type * ide_bus = find_bus("ide");
+
+	if (!ide_bus) {
+		return NULL;
+	}
+
+	data.edev = edev;
+
+	if (edd_dev_is_type(edev, "ATA")) {
+		if (bus_for_each_dev(ide_bus,NULL,&data,edd_match_idedev))
+			return data.ide_drive;
+	}
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_idedev(struct edd_device *edev)
+{
+	struct pci_dev *pci_dev;
+	int rc = -EINVAL;
+
+	pci_dev = edd_get_pci_dev(edev);
+	if (pci_dev) {
+		ide_drive_t * ide_drive = edd_find_matching_ide_device(edev);
+		if (ide_drive && get_device(&ide_drive->gendev)) {
+			rc = sysfs_create_link(&edev->kobj,
+					       &ide_drive->gendev.kobj,
+					       "disc");
+			put_device(&ide_drive->gendev);
+		}
+	}
+	return rc;
+}
+
+#else
+static int
+edd_create_symlink_to_idedev(struct edd_device *edev)
+{
+	return -ENOSYS;
+}
+#endif
+
 
 static inline void
 edd_device_unregister(struct edd_device *edev)
@@ -669,6 +754,7 @@
 	if (!error) {
 		edd_create_symlink_to_pcidev(edev);
 		edd_create_symlink_to_scsidev(edev);
+		edd_create_symlink_to_idedev(edev);
 	}
 }
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1532.1.3
## Wrapped with gzip_uu ##


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
3OA@S;]CO]?M#ZQ\^.P-/90X     
 
