Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWFNOF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWFNOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWFNOF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:05:26 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:10890 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S964949AbWFNOFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:05:23 -0400
Date: Wed, 14 Jun 2006 16:05:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch 18/24] s390: add PAV support to the dasd driver.
Message-ID: <20060614140521.GS9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] add PAV support to the dasd driver.

Add support for parallel-access-volumes to the dasd driver. This
allows concurrent access to dasd devices with multiple channel
programs.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c        |   51 ++++++--------
 drivers/s390/block/dasd_devmap.c |   81 ++++++++++++++++++++--
 drivers/s390/block/dasd_eckd.c   |  140 ++++++++++++++++++++++++++++++---------
 drivers/s390/block/dasd_eckd.h   |   16 +++-
 drivers/s390/block/dasd_fba.c    |   20 -----
 drivers/s390/block/dasd_int.h    |    2 
 include/asm-s390/dasd.h          |    8 +-
 7 files changed, 228 insertions(+), 90 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-06-14 14:29:56.000000000 +0200
@@ -1855,15 +1855,34 @@ dasd_generic_probe (struct ccw_device *c
 {
 	int ret;
 
+	ret = ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	if (ret) {
+		printk(KERN_WARNING
+		       "dasd_generic_probe: could not set ccw-device options "
+		       "for %s\n", cdev->dev.bus_id);
+		return ret;
+	}
 	ret = dasd_add_sysfs_files(cdev);
 	if (ret) {
 		printk(KERN_WARNING
 		       "dasd_generic_probe: could not add sysfs entries "
 		       "for %s\n", cdev->dev.bus_id);
-	} else {
-		cdev->handler = &dasd_int_handler;
+		return ret;
 	}
+	cdev->handler = &dasd_int_handler;
 
+	/*
+	 * Automatically online either all dasd devices (dasd_autodetect)
+	 * or all devices specified with dasd= parameters during
+	 * initial probe.
+	 */
+	if ((dasd_get_feature(cdev, DASD_FEATURE_INITIAL_ONLINE) > 0 ) ||
+	    (dasd_autodetect && dasd_busid_known(cdev->dev.bus_id) != 0))
+		ret = ccw_device_set_online(cdev);
+	if (ret)
+		printk(KERN_WARNING
+		       "dasd_generic_probe: could not initially online "
+		       "ccw-device %s\n", cdev->dev.bus_id);
 	return ret;
 }
 
@@ -1911,6 +1930,8 @@ dasd_generic_set_online (struct ccw_devi
 	struct dasd_device *device;
 	int rc;
 
+	/* first online clears initial online feature flag */
+	dasd_set_feature(cdev, DASD_FEATURE_INITIAL_ONLINE, 0);
 	device = dasd_create_device(cdev);
 	if (IS_ERR(device))
 		return PTR_ERR(device);
@@ -2065,31 +2086,6 @@ dasd_generic_notify(struct ccw_device *c
 	return ret;
 }
 
-/*
- * Automatically online either all dasd devices (dasd_autodetect) or
- * all devices specified with dasd= parameters.
- */
-static int
-__dasd_auto_online(struct device *dev, void *data)
-{
-	struct ccw_device *cdev;
-
-	cdev = to_ccwdev(dev);
-	if (dasd_autodetect || dasd_busid_known(cdev->dev.bus_id) == 0)
-		ccw_device_set_online(cdev);
-	return 0;
-}
-
-void
-dasd_generic_auto_online (struct ccw_driver *dasd_discipline_driver)
-{
-	struct device_driver *drv;
-
-	drv = get_driver(&dasd_discipline_driver->driver);
-	driver_for_each_device(drv, NULL, NULL, __dasd_auto_online);
-	put_driver(drv);
-}
-
 
 static int __init
 dasd_init(void)
@@ -2170,5 +2166,4 @@ EXPORT_SYMBOL_GPL(dasd_generic_remove);
 EXPORT_SYMBOL_GPL(dasd_generic_notify);
 EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
-EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
 
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-06-14 14:29:56.000000000 +0200
@@ -27,7 +27,7 @@
 #include "dasd_int.h"
 
 kmem_cache_t *dasd_page_cache;
-EXPORT_SYMBOL(dasd_page_cache);
+EXPORT_SYMBOL_GPL(dasd_page_cache);
 
 /*
  * dasd_devmap_t is used to store the features and the relation
@@ -49,6 +49,20 @@ struct dasd_devmap {
 };
 
 /*
+ * dasd_servermap is used to store the server_id of all storage servers
+ * accessed by DASD device driver.
+ */
+struct dasd_servermap {
+	struct list_head list;
+	struct server_id {
+		char vendor[4];
+		char serial[15];
+	} sid;
+};
+
+static struct list_head dasd_serverlist;
+
+/*
  * Parameter parsing functions for dasd= parameter. The syntax is:
  *   <devno>		: (0x)?[0-9a-fA-F]+
  *   <busid>		: [0-0a-f]\.[0-9a-f]\.(0x)?[0-9a-fA-F]+
@@ -64,6 +78,8 @@ struct dasd_devmap {
 
 int dasd_probeonly =  0;	/* is true, when probeonly mode is active */
 int dasd_autodetect = 0;	/* is true, when autodetection is active */
+int dasd_nopav = 0;		/* is true, when PAV is disabled */
+EXPORT_SYMBOL_GPL(dasd_nopav);
 
 /*
  * char *dasd[] is intended to hold the ranges supplied by the dasd= statement
@@ -228,19 +244,24 @@ dasd_parse_keyword( char *parsestring ) 
 		length = strlen(parsestring);
 		residual_str = parsestring + length;
         }
-	if (strncmp ("autodetect", parsestring, length) == 0) {
+	if (strncmp("autodetect", parsestring, length) == 0) {
 		dasd_autodetect = 1;
 		MESSAGE (KERN_INFO, "%s",
 			 "turning to autodetection mode");
                 return residual_str;
         }
-        if (strncmp ("probeonly", parsestring, length) == 0) {
+	if (strncmp("probeonly", parsestring, length) == 0) {
 		dasd_probeonly = 1;
 		MESSAGE(KERN_INFO, "%s",
 			"turning to probeonly mode");
                 return residual_str;
         }
-        if (strncmp ("fixedbuffers", parsestring, length) == 0) {
+	if (strncmp("nopav", parsestring, length) == 0) {
+		dasd_nopav = 1;
+		MESSAGE(KERN_INFO, "%s", "disable PAV mode");
+		return residual_str;
+	}
+	if (strncmp("fixedbuffers", parsestring, length) == 0) {
 		if (dasd_page_cache)
 			return residual_str;
 		dasd_page_cache =
@@ -294,6 +315,8 @@ dasd_parse_range( char *parsestring ) {
 	features = dasd_feature_list(str, &str);
 	if (features < 0)
 		return ERR_PTR(-EINVAL);
+	/* each device in dasd= parameter should be set initially online */
+	features |= DASD_FEATURE_INITIAL_ONLINE;
 	while (from <= to) {
 		sprintf(bus_id, "%01x.%01x.%04x",
 			from_id0, from_id1, from++);
@@ -836,6 +859,38 @@ static struct attribute_group dasd_attr_
 	.attrs = dasd_attrs,
 };
 
+/*
+ * Check if the related storage server is already contained in the
+ * dasd_serverlist. If server is not contained, create new entry.
+ * Return 0 if server was already in serverlist,
+ *	  1 if the server was added successfully
+ *	 <0 in case of error.
+ */
+static int
+dasd_add_server(struct dasd_uid *uid)
+{
+	struct dasd_servermap *new, *tmp;
+
+	/* check if server is already contained */
+	list_for_each_entry(tmp, &dasd_serverlist, list)
+	  // normale cmp?
+		if (strncmp(tmp->sid.vendor, uid->vendor,
+			    sizeof(tmp->sid.vendor)) == 0
+		    && strncmp(tmp->sid.serial, uid->serial,
+			       sizeof(tmp->sid.serial)) == 0)
+			return 0;
+
+	new = (struct dasd_servermap *)
+		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	strncpy(new->sid.vendor, uid->vendor, sizeof(new->sid.vendor));
+	strncpy(new->sid.serial, uid->serial, sizeof(new->sid.serial));
+	list_add(&new->list, &dasd_serverlist);
+	return 1;
+}
+
 
 /*
  * Return copy of the device unique identifier.
@@ -853,24 +908,30 @@ dasd_get_uid(struct ccw_device *cdev, st
 	spin_unlock(&dasd_devmap_lock);
 	return 0;
 }
+EXPORT_SYMBOL(dasd_set_uid);
 
 /*
  * Register the given device unique identifier into devmap struct.
+ * Return 0 if server was already in serverlist,
+ *	  1 if the server was added successful
+ *	 <0 in case of error.
  */
 int
 dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
 {
 	struct dasd_devmap *devmap;
+	int rc;
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
+	rc = dasd_add_server(uid);
 	spin_unlock(&dasd_devmap_lock);
-	return 0;
+	return rc;
 }
-EXPORT_SYMBOL(dasd_set_uid);
+EXPORT_SYMBOL_GPL(dasd_set_uid);
 
 /*
  * Return value of the specified feature.
@@ -882,7 +943,7 @@ dasd_get_feature(struct ccw_device *cdev
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
-		return (int) PTR_ERR(devmap);
+		return PTR_ERR(devmap);
 
 	return ((devmap->features & feature) != 0);
 }
@@ -898,7 +959,7 @@ dasd_set_feature(struct ccw_device *cdev
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
-		return (int) PTR_ERR(devmap);
+		return PTR_ERR(devmap);
 
 	spin_lock(&dasd_devmap_lock);
 	if (flag)
@@ -934,8 +995,10 @@ dasd_devmap_init(void)
 	dasd_max_devindex = 0;
 	for (i = 0; i < 256; i++)
 		INIT_LIST_HEAD(&dasd_hashlists[i]);
-	return 0;
 
+	/* Initialize servermap structure. */
+	INIT_LIST_HEAD(&dasd_serverlist);
+	return 0;
 }
 
 void
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:56.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/todclk.h>
 #include <asm/uaccess.h>
+#include <asm/cio.h>
 #include <asm/ccwdev.h>
 
 #include "dasd_int.h"
@@ -89,17 +90,22 @@ dasd_eckd_probe (struct ccw_device *cdev
 {
 	int ret;
 
-	ret = dasd_generic_probe (cdev, &dasd_eckd_discipline);
-	if (ret)
+	/* set ECKD specific ccw-device options */
+	ret = ccw_device_set_options(cdev, CCWDEV_ALLOW_FORCE);
+	if (ret) {
+		printk(KERN_WARNING
+		       "dasd_eckd_probe: could not set ccw-device options "
+		       "for %s\n", cdev->dev.bus_id);
 		return ret;
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP | CCWDEV_ALLOW_FORCE);
-	return 0;
+	}
+	ret = dasd_generic_probe(cdev, &dasd_eckd_discipline);
+	return ret;
 }
 
 static int
 dasd_eckd_set_online(struct ccw_device *cdev)
 {
-	return dasd_generic_set_online (cdev, &dasd_eckd_discipline);
+	return dasd_generic_set_online(cdev, &dasd_eckd_discipline);
 }
 
 static struct ccw_driver dasd_eckd_driver = {
@@ -541,6 +547,86 @@ dasd_eckd_read_conf(struct dasd_device *
 }
 
 /*
+ * Build CP for Perform Subsystem Function - SSC.
+ */
+struct dasd_ccw_req *
+dasd_eckd_build_psf_ssc(struct dasd_device *device)
+{
+       struct dasd_ccw_req *cqr;
+       struct dasd_psf_ssc_data *psf_ssc_data;
+       struct ccw1 *ccw;
+
+       cqr = dasd_smalloc_request("ECKD", 1 /* PSF */ ,
+				  sizeof(struct dasd_psf_ssc_data),
+				  device);
+
+       if (IS_ERR(cqr)) {
+	       DEV_MESSAGE(KERN_WARNING, device, "%s",
+			   "Could not allocate PSF-SSC request");
+	       return cqr;
+       }
+       psf_ssc_data = (struct dasd_psf_ssc_data *)cqr->data;
+       psf_ssc_data->order = PSF_ORDER_SSC;
+       psf_ssc_data->suborder = 0x08;
+
+       ccw = cqr->cpaddr;
+       ccw->cmd_code = DASD_ECKD_CCW_PSF;
+       ccw->cda = (__u32)(addr_t)psf_ssc_data;
+       ccw->count = 66;
+
+       cqr->device = device;
+       cqr->expires = 10*HZ;
+       cqr->buildclk = get_clock();
+       cqr->status = DASD_CQR_FILLED;
+       return cqr;
+}
+
+/*
+ * Perform Subsystem Function.
+ * It is necessary to trigger CIO for channel revalidation since this
+ * call might change behaviour of DASD devices.
+ */
+static int
+dasd_eckd_psf_ssc(struct dasd_device *device)
+{
+       struct dasd_ccw_req *cqr;
+       int rc;
+
+       cqr = dasd_eckd_build_psf_ssc(device);
+       if (IS_ERR(cqr))
+	       return PTR_ERR(cqr);
+
+       rc = dasd_sleep_on(cqr);
+       if (!rc)
+	       /* trigger CIO to reprobe devices */
+	       css_schedule_reprobe();
+       dasd_sfree_request(cqr, cqr->device);
+       return rc;
+}
+
+/*
+ * Valide storage server of current device.
+ */
+static int
+dasd_eckd_validate_server(struct dasd_device *device)
+{
+	int rc;
+
+	/* Currently PAV is the only reason to 'validate' server on LPAR */
+	if (dasd_nopav || MACHINE_IS_VM)
+		return 0;
+
+	rc = dasd_eckd_psf_ssc(device);
+	if (rc)
+		/* may be requested feature is not available on server,
+		 * therefore just report error and go ahead */
+		DEV_MESSAGE(KERN_INFO, device,
+			    "Perform Subsystem Function returned rc=%d", rc);
+	/* RE-Read Configuration Data */
+	return dasd_eckd_read_conf(device);
+}
+
+/*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
  */
@@ -570,16 +656,29 @@ dasd_eckd_check_characteristics(struct d
 	private->attrib.operation = DASD_NORMAL_CACHE;
 	private->attrib.nr_cyl = 0;
 
+	/* Read Configuration Data */
+	rc = dasd_eckd_read_conf(device);
+	if (rc)
+		return rc;
+
+	/* Generate device unique id and register in devmap */
+	rc = dasd_eckd_generate_uid(device, &uid);
+	if (rc)
+		return rc;
+	rc = dasd_set_uid(device->cdev, &uid);
+	if (rc == 1)	/* new server found */
+		rc = dasd_eckd_validate_server(device);
+	if (rc)
+		return rc;
+
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	memset(rdc_data, 0, sizeof(rdc_data));
 	rc = read_dev_chars(device->cdev, &rdc_data, 64);
-	if (rc) {
+	if (rc)
 		DEV_MESSAGE(KERN_WARNING, device,
-			    "Read device characteristics returned error %d",
-			    rc);
-		return rc;
-	}
+			    "Read device characteristics returned "
+			    "rc=%d", rc);
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "%04X/%02X(CU:%04X/%02X) Cyl:%d Head:%d Sec:%d",
@@ -590,19 +689,6 @@ dasd_eckd_check_characteristics(struct d
 		    private->rdc_data.no_cyl,
 		    private->rdc_data.trk_per_cyl,
 		    private->rdc_data.sec_per_trk);
-
-	/* Read Configuration Data */
-	rc = dasd_eckd_read_conf (device);
-	if (rc)
-		return rc;
-
-	/* Generate device unique id and register in devmap */
-	rc = dasd_eckd_generate_uid(device, &uid);
-	if (rc)
-		return rc;
-
-	rc = dasd_set_uid(device->cdev, &uid);
-
 	return rc;
 }
 
@@ -1687,14 +1773,8 @@ static struct dasd_discipline dasd_eckd_
 static int __init
 dasd_eckd_init(void)
 {
-	int ret;
-
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
-
-	ret = ccw_driver_register(&dasd_eckd_driver);
-	if (!ret)
-		dasd_generic_auto_online(&dasd_eckd_driver);
-	return ret;
+	return ccw_driver_register(&dasd_eckd_driver);
 }
 
 static void __exit
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2006-06-14 14:29:56.000000000 +0200
@@ -41,9 +41,10 @@
 #define DASD_ECKD_CCW_RESERVE		 0xB4
 
 /*
- *Perform Subsystem Function / Sub-Orders
+ * Perform Subsystem Function / Sub-Orders
  */
-#define PSF_ORDER_PRSSD			 0x18
+#define PSF_ORDER_PRSSD 0x18
+#define PSF_ORDER_SSC	0x1D
 
 /*****************************************************************************
  * SECTION: Type Definitions
@@ -353,4 +354,15 @@ struct dasd_psf_prssd_data {
 	unsigned char varies[9];
 } __attribute__ ((packed));
 
+/*
+ * Perform Subsystem Function - Set Subsystem Characteristics
+ */
+struct dasd_psf_ssc_data {
+	unsigned char order;
+	unsigned char flags;
+	unsigned char cu_type[4];
+	unsigned char suborder;
+	unsigned char reserved[59];
+} __attribute__((packed));
+
 #endif				/* DASD_ECKD_H */
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2006-06-14 14:29:56.000000000 +0200
@@ -56,19 +56,13 @@ static struct ccw_driver dasd_fba_driver
 static int
 dasd_fba_probe(struct ccw_device *cdev)
 {
-	int ret;
-
-	ret = dasd_generic_probe (cdev, &dasd_fba_discipline);
-	if (ret)
-		return ret;
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
-	return 0;
+	return dasd_generic_probe(cdev, &dasd_fba_discipline);
 }
 
 static int
 dasd_fba_set_online(struct ccw_device *cdev)
 {
-	return dasd_generic_set_online (cdev, &dasd_fba_discipline);
+	return dasd_generic_set_online(cdev, &dasd_fba_discipline);
 }
 
 static struct ccw_driver dasd_fba_driver = {
@@ -569,16 +563,8 @@ static struct dasd_discipline dasd_fba_d
 static int __init
 dasd_fba_init(void)
 {
-	int ret;
-
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
-
-	ret = ccw_driver_register(&dasd_fba_driver);
-	if (ret)
-		return ret;
-
-	dasd_generic_auto_online(&dasd_fba_driver);
-	return 0;
+	return ccw_driver_register(&dasd_fba_driver);
 }
 
 static void __exit
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-06-14 14:29:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-06-14 14:29:56.000000000 +0200
@@ -513,12 +513,12 @@ void dasd_generic_remove (struct ccw_dev
 int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
-void dasd_generic_auto_online (struct ccw_driver *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
 extern int dasd_autodetect;
+extern int dasd_nopav;
 
 int dasd_devmap_init(void);
 void dasd_devmap_exit(void);
diff -urpN linux-2.6/include/asm-s390/dasd.h linux-2.6-patched/include/asm-s390/dasd.h
--- linux-2.6/include/asm-s390/dasd.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/dasd.h	2006-06-14 14:29:56.000000000 +0200
@@ -68,10 +68,12 @@ typedef struct dasd_information2_t {
  * 0x00: default features
  * 0x01: readonly (ro)
  * 0x02: use diag discipline (diag)
+ * 0x04: set the device initially online (internal use only)
  */
-#define DASD_FEATURE_DEFAULT  0
-#define DASD_FEATURE_READONLY 1
-#define DASD_FEATURE_USEDIAG  2
+#define DASD_FEATURE_DEFAULT	     0x00
+#define DASD_FEATURE_READONLY	     0x01
+#define DASD_FEATURE_USEDIAG	     0x02
+#define DASD_FEATURE_INITIAL_ONLINE  0x04
 
 #define DASD_PARTN_BITS 2
 
