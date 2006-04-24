Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWDXPGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWDXPGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDXPGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:06:45 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:48207 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750886AbWDXPGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:06:17 -0400
Date: Mon, 24 Apr 2006 17:06:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, horst.hummel@de.ibm.com
Subject: [patch 13/13] s390: dasd device identifiers.
Message-ID: <20060424150620.GN15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 13/13] s390: dasd device identifiers.

Generate new sysfs-attribute 'uid' that contains an device specific
unique identifier. This can be used to identity multiple ALIASES of
the same physical device (PAV). In addition the sysfs-attributes
'vendor' (containing the manufacturer of the device) and 'alias'
(identify alias or base device) is added.
This is first part of PAV support in LPAR (also valid on zVM).

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |  101 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   |   51 ++++++++++++++++++-
 drivers/s390/block/dasd_eckd.h   |   46 ++++++++++-------
 drivers/s390/block/dasd_int.h    |   12 ++++
 4 files changed, 190 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-04-24 16:47:31.000000000 +0200
@@ -45,6 +45,7 @@ struct dasd_devmap {
         unsigned int devindex;
         unsigned short features;
 	struct dasd_device *device;
+	struct dasd_uid uid;
 };
 
 /*
@@ -716,6 +717,68 @@ dasd_discipline_show(struct device *dev,
 
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
 
+static ssize_t
+dasd_alias_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_devmap *devmap;
+	int alias;
+
+	devmap = dasd_find_busid(dev->bus_id);
+	spin_lock(&dasd_devmap_lock);
+	if (!IS_ERR(devmap))
+		alias = devmap->uid.alias;
+	else
+		alias = 0;
+	spin_unlock(&dasd_devmap_lock);
+
+	return sprintf(buf, alias ? "1\n" : "0\n");
+}
+
+static DEVICE_ATTR(alias, 0444, dasd_alias_show, NULL);
+
+static ssize_t
+dasd_vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_devmap *devmap;
+	char *vendor;
+
+	devmap = dasd_find_busid(dev->bus_id);
+	spin_lock(&dasd_devmap_lock);
+	if (!IS_ERR(devmap) && strlen(devmap->uid.vendor) > 0)
+		vendor = devmap->uid.vendor;
+	else
+		vendor = "";
+	spin_unlock(&dasd_devmap_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
+}
+
+static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
+
+#define UID_STRLEN ( /* vendor */ 3 + 1 + /* serial    */ 14 + 1 +\
+		     /* SSID   */ 4 + 1 + /* unit addr */ 2 + 1)
+
+static ssize_t
+dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_devmap *devmap;
+	char uid[UID_STRLEN];
+
+	devmap = dasd_find_busid(dev->bus_id);
+	spin_lock(&dasd_devmap_lock);
+	if (!IS_ERR(devmap) && strlen(devmap->uid.vendor) > 0)
+		snprintf(uid, sizeof(uid), "%s.%s.%04x.%02x",
+			 devmap->uid.vendor, devmap->uid.serial,
+			 devmap->uid.ssid, devmap->uid.unit_addr);
+	else
+		uid[0] = 0;
+	spin_unlock(&dasd_devmap_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", uid);
+}
+
+static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
+
 /*
  * extended error-reporting
  */
@@ -759,6 +822,9 @@ static DEVICE_ATTR(eer_enabled, 0644, da
 static struct attribute * dasd_attrs[] = {
 	&dev_attr_readonly.attr,
 	&dev_attr_discipline.attr,
+	&dev_attr_alias.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_uid.attr,
 	&dev_attr_use_diag.attr,
 	&dev_attr_eer_enabled.attr,
 	NULL,
@@ -768,6 +834,41 @@ static struct attribute_group dasd_attr_
 	.attrs = dasd_attrs,
 };
 
+
+/*
+ * Return copy of the device unique identifier.
+ */
+int
+dasd_get_uid(struct ccw_device *cdev, struct dasd_uid *uid)
+{
+	struct dasd_devmap *devmap;
+
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+	spin_lock(&dasd_devmap_lock);
+	*uid = devmap->uid;
+	spin_unlock(&dasd_devmap_lock);
+	return 0;
+}
+
+/*
+ * Register the given device unique identifier into devmap struct.
+ */
+int
+dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
+{
+	struct dasd_devmap *devmap;
+
+	devmap = dasd_find_busid(cdev->dev.bus_id);
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+	spin_lock(&dasd_devmap_lock);
+	devmap->uid = *uid;
+	spin_unlock(&dasd_devmap_lock);
+	return 0;
+}
+
 /*
  * Return value of the specified feature.
  */
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-04-24 16:47:31.000000000 +0200
@@ -446,6 +446,39 @@ dasd_eckd_cdl_reclen(int recid)
 	return LABEL_SIZE;
 }
 
+/*
+ * Generate device unique id that specifies the physical device.
+ */
+static int
+dasd_eckd_generate_uid(struct dasd_device *device, struct dasd_uid *uid)
+{
+	struct dasd_eckd_private *private;
+	struct dasd_eckd_confdata *confdata;
+
+	private = (struct dasd_eckd_private *) device->private;
+	if (!private)
+		return -ENODEV;
+	confdata = &private->conf_data;
+	if (!confdata)
+		return -ENODEV;
+
+	memset(uid, 0, sizeof(struct dasd_uid));
+	strncpy(uid->vendor, confdata->ned1.HDA_manufacturer,
+		sizeof(uid->vendor) - 1);
+	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
+	strncpy(uid->serial, confdata->ned1.HDA_location,
+		sizeof(uid->serial) - 1);
+	EBCASC(uid->serial, sizeof(uid->serial) - 1);
+	uid->ssid = confdata->neq.subsystemID;
+	if (confdata->ned2.sneq.flags == 0x40) {
+		uid->alias = 1;
+		uid->unit_addr = confdata->ned2.sneq.base_unit_addr;
+	} else
+		uid->unit_addr = confdata->ned1.unit_addr;
+
+	return 0;
+}
+
 static int
 dasd_eckd_read_conf(struct dasd_device *device)
 {
@@ -507,11 +540,15 @@ dasd_eckd_read_conf(struct dasd_device *
 	return 0;
 }
 
-
+/*
+ * Check device characteristics.
+ * If the device is accessible using ECKD discipline, the device is enabled.
+ */
 static int
 dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private;
+	struct dasd_uid uid;
 	void *rdc_data;
 	int rc;
 
@@ -536,6 +573,7 @@ dasd_eckd_check_characteristics(struct d
 
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
+	memset(rdc_data, 0, sizeof(rdc_data));
 	rc = read_dev_chars(device->cdev, &rdc_data, 64);
 	if (rc) {
 		DEV_MESSAGE(KERN_WARNING, device,
@@ -556,8 +594,17 @@ dasd_eckd_check_characteristics(struct d
 
 	/* Read Configuration Data */
 	rc = dasd_eckd_read_conf (device);
-	return rc;
+	if (rc)
+		return rc;
+
+	/* Generate device unique id and register in devmap */
+	rc = dasd_eckd_generate_uid(device, &uid);
+	if (rc)
+		return rc;
 
+	rc = dasd_set_uid(device->cdev, &uid);
+
+	return rc;
 }
 
 static struct dasd_ccw_req *
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2006-04-24 16:47:31.000000000 +0200
@@ -228,26 +228,36 @@ struct dasd_eckd_confdata {
 		unsigned char HDA_manufacturer[3];
 		unsigned char HDA_location[2];
 		unsigned char HDA_seqno[12];
-		__u16 ID;
+		__u8 ID;
+		__u8 unit_addr;
 	} __attribute__ ((packed)) ned1;
-	struct {
+	union {
 		struct {
-			unsigned char identifier:2;
-			unsigned char token_id:1;
-			unsigned char sno_valid:1;
-			unsigned char subst_sno:1;
-			unsigned char recNED:1;
-			unsigned char emuNED:1;
-			unsigned char reserved:1;
-		} __attribute__ ((packed)) flags;
-		__u8 descriptor;
-		__u8 reserved[2];
-		unsigned char dev_type[6];
-		unsigned char dev_model[3];
-		unsigned char DASD_manufacturer[3];
-		unsigned char DASD_location[2];
-		unsigned char DASD_seqno[12];
-		__u16 ID;
+			struct {
+				unsigned char identifier:2;
+				unsigned char token_id:1;
+				unsigned char sno_valid:1;
+				unsigned char subst_sno:1;
+				unsigned char recNED:1;
+				unsigned char emuNED:1;
+				unsigned char reserved:1;
+			} __attribute__ ((packed)) flags;
+			__u8 descriptor;
+			__u8 reserved[2];
+			unsigned char dev_type[6];
+			unsigned char dev_model[3];
+			unsigned char DASD_manufacturer[3];
+			unsigned char DASD_location[2];
+			unsigned char DASD_seqno[12];
+			__u16 ID;
+		} __attribute__ ((packed)) ned;
+		struct {
+			unsigned char flags;            /* byte  0    */
+			unsigned char res2[7];          /* byte  1- 7 */
+			unsigned char sua_flags;	/* byte  8    */
+			__u8 base_unit_addr;            /* byte  9    */
+			unsigned char res3[22];	        /* byte 10-31 */
+		} __attribute__ ((packed)) sneq;
 	} __attribute__ ((packed)) ned2;
 	struct {
 		struct {
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-04-24 16:47:31.000000000 +0200
@@ -268,6 +268,16 @@ struct dasd_discipline {
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
 
+/*
+ * Unique identifier for dasd device.
+ */
+struct dasd_uid {
+	__u8 alias;
+	char vendor[4];
+	char serial[15];
+	__u16 ssid;
+	__u8 unit_addr;
+};
 
 /*
  * Notification numbers for extended error reporting notifications:
@@ -516,6 +526,8 @@ void dasd_devmap_exit(void);
 struct dasd_device *dasd_create_device(struct ccw_device *);
 void dasd_delete_device(struct dasd_device *);
 
+int dasd_get_uid(struct ccw_device *, struct dasd_uid *);
+int dasd_set_uid(struct ccw_device *, struct dasd_uid *);
 int dasd_get_feature(struct ccw_device *, int);
 int dasd_set_feature(struct ccw_device *, int, int);
 
