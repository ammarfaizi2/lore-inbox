Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTAGXVV>; Tue, 7 Jan 2003 18:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTAGXVV>; Tue, 7 Jan 2003 18:21:21 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:3846 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S267595AbTAGXVJ>; Tue, 7 Jan 2003 18:21:09 -0500
Date: Tue, 7 Jan 2003 17:29:49 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDD: fix raw_data file and edd_has_edd30(), misc cleanups
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6801E05CB9@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0301071728280.3361-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.890, 2003-01-07 17:17:04-06:00, Matt_Domsch@dell.com
  EDD: fix raw_data file and edd_has_edd30(), misc cleanups
  
  * Update copyright date
  * s/driverfs/sysfs in comments
  * bump version
  * bug fix: raw_data file was always printing device 0's info.
  * bug fix: edd_has_edd30 was always returning device 0's info.
  * always print the report info at the end of raw_data
  * edd_dev_is_type() should return boolean
  * edd_match_scsidev() should return boolean
  * remove duplicate calls to pci_find_slot, use edd_get_pci_dev().
  * attribute tests should return boolean
  * add edd_release()
  * work if !CONFIG_SCSI=[ym]
  * use new find_bus() and bus_for_each_dev() to match SCSI devices


 edd.c |  252 +++++++++++++++++++++++++++++++-----------------------------------
 1 files changed, 120 insertions, 132 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Tue Jan  7 17:19:37 2003
+++ b/arch/i386/kernel/edd.c	Tue Jan  7 17:19:37 2003
@@ -1,6 +1,6 @@
 /*
  * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell Computer Corporation
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * BIOS Enhanced Disk Drive Services (EDD)
@@ -11,7 +11,7 @@
  * fn41 - Check Extensions Present and
  * fn48 - Get Device Parametes with EDD extensions
  * made in setup.S, copied to safe structures in setup.c,
- * and presents it in driverfs.
+ * and presents it in sysfs.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published by
@@ -30,8 +30,6 @@
  *
  * TODO:
  * - Add IDE and USB disk device support
- * - Get symlink creator helper functions exported from
- *   drivers/base instead of duplicating them here.
  * - move edd.[ch] to better locations if/when one is decided
  */
 
@@ -46,18 +44,18 @@
 #include <linux/limits.h>
 #include <linux/device.h>
 #include <linux/pci.h>
-#include <asm/edd.h>
 #include <linux/device.h>
 #include <linux/blkdev.h>
+#include <asm/edd.h>
 /* FIXME - this really belongs in include/scsi/scsi.h */
 #include <../drivers/scsi/scsi.h>
 #include <../drivers/scsi/hosts.h>
 
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("driverfs interface to BIOS EDD information");
+MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.07 2002-Oct-24"
+#define EDD_VERSION "0.08 2003-Jan-07"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -94,6 +92,7 @@
 {
 	return edev->info;
 }
+
 static inline void
 edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
 {
@@ -265,8 +264,8 @@
 edd_show_raw_data(struct edd_device *edev, char *buf, size_t count, loff_t off)
 {
 	struct edd_info *info = edd_dev_get_info(edev);
-	int i, rc, warn_padding = 0, email = 0, nonzero_path = 0,
-		len = sizeof (*edd) - 4, found_pci=0;
+	int i, warn_padding = 0, nonzero_path = 0,
+		len = sizeof (*info) - 4, found_pci=0;
 	uint8_t checksum = 0, c = 0;
 	char *p = buf;
 	struct pci_dev *pci_dev=NULL;
@@ -279,7 +278,7 @@
 		len = info->params.length;
 
 	p += snprintf(p, left, "int13 fn48 returned data:\n\n");
-	p += edd_dump_raw_data(p, left, ((char *) edd) + 4, len);
+	p += edd_dump_raw_data(p, left, ((char *) info) + 4, len);
 
 	/* Spec violation.  Adaptec AIC7899 returns 0xDDBE
 	   here, when it should be 0xBEDD.
@@ -288,7 +287,6 @@
 	if (info->params.key == 0xDDBE) {
 		p += snprintf(p, left,
 			     "Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE\n");
-		email++;
 	}
 
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
@@ -296,7 +294,7 @@
 	}
 
 	for (i = 30; i <= 73; i++) {
-		c = *(((uint8_t *) edd) + i + 4);
+		c = *(((uint8_t *) info) + i + 4);
 		if (c)
 			nonzero_path++;
 		checksum += c;
@@ -305,12 +303,10 @@
 	if (checksum) {
 		p += snprintf(p, left,
 			     "Warning: Spec violation.  Device Path checksum invalid.\n");
-		email++;
 	}
 
 	if (!nonzero_path) {
 		p += snprintf(p, left, "Error: Spec violation.  Empty device path.\n");
-		email++;
 		goto out;
 	}
 
@@ -328,45 +324,35 @@
 	if (warn_padding) {
 		p += snprintf(p, left,
 			     "Warning: Spec violation.  Padding should be 0x20.\n");
-		email++;
 	}
 
-	rc = edd_dev_is_type(edev, "PCI");
-	if (!rc) {
-		pci_dev = pci_find_slot(info->params.interface_path.pci.bus,
-					PCI_DEVFN(info->params.interface_path.
-						  pci.slot,
-						  info->params.interface_path.
-						  pci.function));
+	if (edd_dev_is_type(edev, "PCI")) {
+		pci_dev = edd_get_pci_dev(edev);
 		if (!pci_dev) {
 			p += snprintf(p, left, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
 			p += snprintf(p, left, "  about a PCI device at %02x:%02x.%d\n",
 				     info->params.interface_path.pci.bus,
 				     info->params.interface_path.pci.slot,
 				     info->params.interface_path.pci.function);
-			email++;
 		}
 		else {
 			found_pci++;
 		}
 	}
 
-	if (found_pci && !edd_dev_is_type(edev, "SCSI")) {
+	if (found_pci && edd_dev_is_type(edev, "SCSI")) {
 		sd = edd_find_matching_scsi_device(edev);
 		if (!sd) {
 			p += snprintf(p, left, "Error: BIOS says this is a SCSI device, but\n");
 			p += snprintf(p, left, "  the OS doesn't know about this SCSI device.\n");
 			p += snprintf(p, left, "  Do you have it's driver module loaded?\n");
-			email++;
 		}
 	}
 
 out:
-	if (email) {
-		p += snprintf(p, left, "\nPlease check %s\n", REPORT_URL);
-		p += snprintf(p, left, "to see if this has been reported.  If not,\n");
-		p += snprintf(p, left, "please send the information requested there.\n");
-	}
+	p += snprintf(p, left, "\nPlease check %s\n", REPORT_URL);
+	p += snprintf(p, left, "to see if this device has been reported.  If not,\n");
+	p += snprintf(p, left, "please send the information requested there.\n");
 
 	return (p - buf);
 }
@@ -509,8 +495,8 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 1;
-	return !info->params.num_default_cylinders;
+		return 0;
+	return info->params.num_default_cylinders > 0;
 }
 
 static int
@@ -518,8 +504,8 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 1;
-	return !info->params.num_default_heads;
+		return 0;
+	return info->params.num_default_heads > 0;
 }
 
 static int
@@ -527,8 +513,8 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 1;
-	return !info->params.sectors_per_track;
+		return 0;
+	return info->params.sectors_per_track > 0;
 }
 
 static int
@@ -539,24 +525,24 @@
 	char c;
 
 	if (!edev || !info)
-		return 1;
+		return 0;
 
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
-		return 1;
+		return 0;
 	}
 
 	for (i = 30; i <= 73; i++) {
-		c = *(((uint8_t *) edd) + i + 4);
+		c = *(((uint8_t *) info) + i + 4);
 		if (c) {
 			nonzero_path++;
 			break;
 		}
 	}
 	if (!nonzero_path) {
-		return 1;
+		return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
@@ -597,7 +583,23 @@
 	NULL,
 };
 
+/**
+ *	edd_release - free edd structure
+ *	@kobj:	kobject of edd structure
+ *
+ *	This is called when the refcount of the edd structure
+ *	reaches 0. This should happen right after we unregister,
+ *	but just in case, we use the release callback anyway.
+ */
+
+static void edd_release(struct kobject * kobj)
+{
+	struct edd_device * dev = to_edd_device(kobj);
+	kfree(dev);
+}
+
 static struct kobj_type ktype_edd = {
+	.release	= edd_release,
 	.sysfs_ops	= &edd_attr_ops,
 	.default_attrs	= def_attrs,
 };
@@ -605,27 +607,24 @@
 static decl_subsys(edd,&ktype_edd);
 
 
-
 /**
  * edd_dev_is_type() - is this EDD device a 'type' device?
  * @edev
  * @type - a host bus or interface identifier string per the EDD spec
  *
- * Returns 0 if it is a 'type' device, nonzero otherwise.
+ * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
  */
 static int
 edd_dev_is_type(struct edd_device *edev, const char *type)
 {
-	int rc;
 	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
-		return 1;
-
-	rc = strncmp(info->params.host_bus_type, type, strlen(type));
-	if (!rc)
-		return 0;
 
-	return strncmp(info->params.interface_type, type, strlen(type));
+	if (edev && type && info) {
+		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
+		    !strncmp(info->params.interface_type, type, strlen(type)))
+			return 1;
+	}
+	return 0;
 }
 
 /**
@@ -638,16 +637,14 @@
 edd_get_pci_dev(struct edd_device *edev)
 {
 	struct edd_info *info = edd_dev_get_info(edev);
-	int rc;
 
-	rc = edd_dev_is_type(edev, "PCI");
-	if (rc)
-		return NULL;
-
-	return pci_find_slot(info->params.interface_path.pci.bus,
-			     PCI_DEVFN(info->params.interface_path.pci.slot,
-				       info->params.interface_path.pci.
-				       function));
+	if (edd_dev_is_type(edev, "PCI")) {
+		return pci_find_slot(info->params.interface_path.pci.bus,
+				     PCI_DEVFN(info->params.interface_path.pci.slot,
+					       info->params.interface_path.pci.
+					       function));
+	}
+	return NULL;
 }
 
 static int
@@ -660,105 +657,98 @@
 	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
 }
 
+#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
+
+struct edd_match_data {
+	struct edd_device	* edev;
+	struct scsi_device	* sd;
+};
+
 /**
  * edd_match_scsidev()
  * @edev - EDD device is a known SCSI device
  * @sd - scsi_device with host who's parent is a PCI controller
  * 
- * returns 0 on success, 1 on failure
+ * returns 1 if a match is found, 0 if not.
  */
-static int
-edd_match_scsidev(struct edd_device *edev, struct scsi_device *sd)
+static int edd_match_scsidev(struct device * dev, void * d)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-
-	if (!edev || !sd || !info)
-		return 1;
-
-	if ((sd->channel == info->params.interface_path.pci.channel) &&
-	    (sd->id == info->params.device_path.scsi.id) &&
-	    (sd->lun == info->params.device_path.scsi.lun)) {
-		return 0;
+	struct edd_match_data * data = (struct edd_match_data *)d;
+	struct edd_info *info = edd_dev_get_info(data->edev);
+	struct scsi_device * sd = to_scsi_device(dev);
+
+	if (info) {
+		if ((sd->channel == info->params.interface_path.pci.channel) &&
+		    (sd->id == info->params.device_path.scsi.id) &&
+		    (sd->lun == info->params.device_path.scsi.lun)) {
+			data->sd = sd;
+			return 1;
+		}
 	}
-
-	return 1;
+	return 0;
 }
 
 /**
  * edd_find_matching_device()
  * @edev - edd_device to match
  *
- * Returns struct scsi_device * on success,
- * or NULL on failure.
- * This assumes that all children of the PCI controller
- * are scsi_hosts, and that all children of scsi_hosts
- * are scsi_devices.
- * The reference counting probably isn't the best it could be.
+ * Search the SCSI devices for a drive that matches the EDD 
+ * device descriptor we have. If we find a match, return it,
+ * otherwise, return NULL.
  */
 
-#define children_to_dev(n) container_of(n,struct device,node)
 static struct scsi_device *
 edd_find_matching_scsi_device(struct edd_device *edev)
 {
-	struct list_head *sdev_node;
-	int rc = 1;
-	struct scsi_device *sd = NULL;
-	struct pci_dev *pci_dev;
+	struct edd_match_data data;
+	struct bus_type * scsi_bus = find_bus("scsi");
 
-	rc = edd_dev_is_type(edev, "SCSI");
-	if (rc)
-		return NULL;
-
-	pci_dev = edd_get_pci_dev(edev);
-	if (!pci_dev)
+	if (!scsi_bus) {
 		return NULL;
+	}
 
-	get_device(&pci_dev->dev);
+	data.edev = edev;
 
-	list_for_each(sdev_node, &pci_dev->dev.children) {
-		struct device *sdev_dev = children_to_dev(sdev_node);
-		get_device(sdev_dev);
-		sd = to_scsi_device(sdev_dev);
-		rc = edd_match_scsidev(edev, sd);
-		put_device(sdev_dev);
-		if (!rc)
-			break;
+	if (edd_dev_is_type(edev, "SCSI")) {
+		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
+			return data.sd;
 	}
-
-	put_device(&pci_dev->dev);
-	return rc ? NULL : sd;
+	return NULL;
 }
 
 static int
 edd_create_symlink_to_scsidev(struct edd_device *edev)
 {
-
-	struct scsi_device *sdev;
 	struct pci_dev *pci_dev;
-	struct edd_info *info = edd_dev_get_info(edev);
-	int rc;
-
-	rc = edd_dev_is_type(edev, "PCI");
-	if (rc)
-		return rc;
+	int rc = -EINVAL;
 
-	pci_dev = pci_find_slot(info->params.interface_path.pci.bus,
-				PCI_DEVFN(info->params.interface_path.pci.slot,
-					  info->params.interface_path.pci.
-					  function));
-	if (!pci_dev)
-		return 1;
-
-	sdev = edd_find_matching_scsi_device(edev);
-	if (!sdev)
-		return 1;
+	pci_dev = edd_get_pci_dev(edev);
+	if (pci_dev) {
+		struct scsi_device * sdev = edd_find_matching_scsi_device(edev);
+		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
+			rc = sysfs_create_link(&edev->kobj,
+					       &sdev->sdev_driverfs_dev.kobj,
+					       "disc");
+			put_device(&sdev->sdev_driverfs_dev);
+		}
+	}
+	return rc;
+}
 
-	get_device(&sdev->sdev_driverfs_dev);
-	rc = sysfs_create_link(&edev->kobj,&sdev->sdev_driverfs_dev.kobj, "disc");
-	put_device(&sdev->sdev_driverfs_dev);
 
-	return rc;
+#else
+static struct scsi_device *
+edd_find_matching_scsi_device(struct edd_device *edev)
+{
+	return NULL;
+}
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+	return -ENOSYS;
 }
+#endif
+
 
 static inline void
 edd_device_unregister(struct edd_device *edev)
@@ -766,7 +756,7 @@
 	kobject_unregister(&edev->kobj);
 }
 
-static void populate_dir(struct edd_device * edev)
+static void edd_populate_dir(struct edd_device * edev)
 {
 	struct edd_attribute * attr;
 	int error = 0;
@@ -774,7 +764,7 @@
 
 	for (i = 0; (attr = edd_attrs[i]) && !error; i++) {
 		if (!attr->test || 
-		    (attr->test && !attr->test(edev)))
+		    (attr->test && attr->test(edev)))
 			error = sysfs_create_file(&edev->kobj,&attr->attr);
 	}
 	
@@ -798,12 +788,12 @@
 	kobj_set_kset_s(edev,edd_subsys);
 	error = kobject_register(&edev->kobj);
 	if (!error)
-		populate_dir(edev);
+		edd_populate_dir(edev);
 	return error;
 }
 
 /**
- * edd_init() - creates driverfs tree of EDD data
+ * edd_init() - creates sysfs tree of EDD data
  *
  * This assumes that eddnr and edd were
  * assigned in setup.c already.
@@ -852,10 +842,8 @@
 	struct edd_device *edev;
 
 	for (i = 0; i < eddnr && i < EDDMAXNR; i++) {
-		if ((edev = edd_devices[i])) {
+		if ((edev = edd_devices[i]))
 			edd_device_unregister(edev);
-			kfree(edev);
-		}
 	}
 	firmware_unregister(&edd_subsys);
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.890
## Wrapped with gzip_uu ##


begin 664 bkpatch3268
M'XL(`(E@&SX``^U9;7/;-A+^+/Z*K3V72*Y>P'?)/GG2FFY/=ZGML>/,W#0=
M#DV"%FN)5`G*KGO*?[_=!?7FU^2FGV[J:`@*6"RPBV>?72B[<*EDN=_X*:JJ
M,"BF*AX;N_"/0E7[C41.)MVXF&+'>5%@1V]<3&5OFK!8[^JF)Y.D-\GR^>\=
MJ^MV\)N!LF=1%8_A5I9JOV%V[55/=3^3^XWSXQ\OWW]W;AC#(1R-H_Q:7L@*
MAD.C*LK;:)*H=U$UGA1YMRJC7$UE%=$6%BO1A26$A?]<T[>%ZRU,3SC^(C83
MTXP<4R;"<OJ>L]9&6WY)ERU,X9L#VW;=A8-*A1&`V>T/!`B[)\R>\,'T]_$C
MG([P]H6`#5>]6[H(OC6A(XSOX<^UXLB(X3@(]B'-?H<RN@N3J(KPRT1"E">`
M#@_'D0JQM46SU89IIF*()S+*YS.%<_&S!Y<SG"4A+F;W978]KH"^\HCJ)66&
M!Y6JGKI7J8(L1['I5.:58H&K^73&)YD5>=UQ37O9?["9NTA!-+F+[A7,RBRO
MLOP:$GF;Q1+$6U*;%MWM^5M;WYQ?RFI>YL\JV%P%JK%$^5E15BP!D>Z2Z)HB
M76V1Y]%ZJ##,5$@X;+9`C8OY)*G7@ZNB(+>M9*<$V5#%*L-9+TJ7<EK<2DCF
MLTD6LZ.CR40A$&`69V&:Y4FH)D75AKF2K/I:5B$-L>+:JJHJLZLY3JZDJM0+
MJT6)/O928I=".[CWKBAO($OAFZ/3DQ]&/X871Q>CX<_WTU]XE!;.Y1WP7J[F
M"LTA].!;F!9E*".T5%N)FV;#@134!Z",?X'C>J8PSM8!:W2^\L\P1"2,PR>#
M9Q&52">9W?=Z-[+,Y81XI1MSC)A"#"QAVJZS,%W+=Q8#SQOX:>I?18F=^E'\
MM1HYWBW;=!Q[(1Q'^,Q$3\L3+?WI&S:F13R6DW>%2B;=HKQ^9:^>Z;N^$`O+
ML7R?N<DTMZG)V7?LEZG)$M`Q;>LO>OJ+GOX_Z8G"^!0ZY1U_D&W.GHGH_X&W
M`AM,8T0/W"L<K6#:/&H!A4F;GC8$&&XX.IVAFTI\*?'<HXJ`&9@.:>`GN0AM
MFY52$8HA(V@`H[N+*]E@&8$S(''7Q.=NEL>3>2+A[Y&:L@7C0R-P?1:@YT^G
MP>7[XS`XOC@Z'YU]&)V>-'>6L8+[2"-$*'KM^]'I!44JX["<\KYV6@=&X`E2
MQ<_=1.()2!(+/QZ?7Z`NV!%=T6?[.O^,\H[P=XS1P$/A3T9@>3ABC"QO@$V#
M\)ZU,5+*/)PA"BA"AB#:D!?Y'[(LL+,:<X_1:$QDCJ\J^T-B'#3W:%,MZ(#3
MAK28(P@0?D.!N[/Z%FU/-XT9?#O4@8)A'R[#ISEKPT2F".!F,QY')>RU0"O\
MEA3B4F2G-2!W8L.^U4VC@00/>\UF<XZ[[X?5YM2,IM-,&QV`,VW3YL8V=>.`
MCZ!P!-N.1CP,8(E?VK!S=C3::;7@/[A8'5,P?!1E),M+.3XK=QDONF'E*Z_`
MFS>/J*)>B4)"+Q78?)[8N."B'CP@N_:>RIF9TK73=C[E9QRJ@$DIOH&_J4_Y
M3AO.C\].SS^$E^?O<6//SD5D*2DILJMQII:,B+P)5Q*/6'.?3+H`HQ2!4+4_
M,>J>U3?3.U'$D,24&VA%9;_-D7PDCY2RJU4%KFD1"EV30J?1J"D)P;-\)1V=
MPUE41E/5S>=3]%T:S2=5&-_CS27!Y`&')!^XELF:+.MK-8UEE*RTV(*UV.:7
M:%$RQHRLPIDL0TS%Z/]:B\/`U\VF%AQQ]8C[>$3SAO/EV'9=CZ=PLZW,U<JX
M60Z8!]A#H>,:O;T]Y++&!M5C_*:EY!0"JBKG,4Z1)//NIKCZ=;]!3[26,M]#
M$9+Z0`#"#V4G/..[,>)'Y\\T1O3S/$Z>#]67E!^D`M$%UE'GIG$TFQ$$F:JC
ME#CY3L(\+^5UAB@JVS074QK\.E?,P3':T&89M$6O7,<%[NB*CB;*[S&Y=W%B
M#_E/58C+&&Z+;#OCZ<W!TMP]?FL9R`#U2!V_%"E[H`FA*L)U;Y,G(&!NR)]-
MS0V?<46D:8KK1K=>JC'<7+A-9,Y4Y>E\XRT3SCF?G@(3FA_.+X];%*^4=["F
M@;=$(6_KR&V#@(*BZRY3LDN*!JP/`\.CIL]JL?&6G(>[1T8B'=1J?!'7T>@W
M:&\>3V?-+<2/"U51DF?N:H-^HB3R=).^((,M%J@!\.]I#:O$]KR*%BK8`&WC
ML[&);<]A#O<<&_IHCRN0RK^0PVLM6Y73<[NCA-=%R2Y:2TE/VP2H#=/UQQ].
M7IW'91E/U#,!7INQ)9S.\YB8L]7:\L#)Y?OW&,>>9Z'9NVBV3OM)<Z,VHS-X
MJC_4Y4:+X;\"LZY%N=I^"N4-JECE[<%JB*K6]9A*$-T'5%!XG@88-URY+G&+
MNXSJR@]1R]F0L)IQ4B&@^DRZGD\'6P<F%22/*^5Z"YOQU]8QC.\MTF3#`#7U
M49.Y9<R&E7O`S1":SXRWDH.MN5S]<YE39W]"&54`U-6D.9W#N@AXPDET$THT
M2VSTUL3P24-W._2:*ND<8C&48]V+=]A7<5.+MC"(Z]!C#>B5AY/UVGHF;::;
M)0]G3>;YZ]-0J`ZIAC:?+20L;$<N`C?P^C:?;M_9R$4<R`,BII&'%:E-@+F0
M5/0S>6]>$!`P)>*'[Y(XB+<P/BL<($FJB@V-!/)U(E5<9C/,RI0+QM&M[%+Q
M@N\4\$L8MI=WGZRB1+)FS=4`A1DADRO-P,<+@F.,?.%15?`T:NBQ/O\E1=+A
MTZ'C=W30ZHJT0YU<`/F"^'CD<WU:$V\]@1R,`^PV]*-O<K;7#;N]*Y<%*<4G
M"O2)$7W+I8+Q!49<UYH:;X^N:LL=M,D-[3>T5OM1,&[1-&^'SC_P+1^7QUUL
MEAZ:M0+?=NF&Y-O:9D?;C)%>4KG3.1Z=?/R.Y:@\$BA!-31Z_-7:F\VH^[1=
MS\3A2@D?!=N#5YVMP%RJ9)VJSI&T9CW^AOH(\>C8Y0\<O&X=$&P+7^+"&*N;
M2H98J-XTWTB>1M7!=E9X3E_WL>A.DJF82W"\C\Q?WY&.P(WL4<94BP2^2R$7
M^/KZR(TP=N5$R27]/N4^XV6_/5$?L2NI=MJ"P><-CF>=M9O4_90\%=9$N<'W
M+^GL')^<7OS[XH#LH*)]%V\?64H)R?<&VKS!.JVLZKU9,9M/:-4D*Y]:!O0Z
M@>_S;5TW-4W2[RF=0_HMA:"Q_J:A@W$1]`6ELI%N&HU'"RZOC'WA:3E/YTR=
M;;*J2?=I[1:EL0055>=811/A\>].0=_ENX1NZLPAUPBOZ?/G[!?>D>NC<U;_
8F<.W136?#JW43:27I,9_`72U)VY*&@``
`
end

