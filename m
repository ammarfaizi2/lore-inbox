Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVFUAe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVFUAe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVFUAcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:32:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:47332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261772AbVFTW74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert drivers/ieee1394/* to use the new class api instead of class_simple
In-Reply-To: <11193083621030@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <1119308362895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert drivers/ieee1394/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7e25ab9155aef04e83da69545742cf65c9b801ce
tree 0bed979a54852dda1459d60ba680a02a912955c4
parent ca8eca6884861c1ce294b05aacfdf9045bba9aff
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:53:36 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:08 -0700

 drivers/ieee1394/dv1394.c        |    6 +++---
 drivers/ieee1394/ieee1394_core.c |    8 ++++----
 drivers/ieee1394/ieee1394_core.h |    3 ++-
 drivers/ieee1394/raw1394.c       |   10 +++++-----
 drivers/ieee1394/video1394.c     |    4 ++--
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2343,8 +2343,8 @@ static void dv1394_remove_host (struct h
 			dv1394_un_init(video);
 	} while (video != NULL);
 
-	class_simple_device_remove(MKDEV(
-		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)));
+	class_device_destroy(hpsb_protocol_class,
+		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)));
 	devfs_remove("ieee1394/dv/host%d/NTSC", id);
 	devfs_remove("ieee1394/dv/host%d/PAL", id);
 	devfs_remove("ieee1394/dv/host%d", id);
@@ -2361,7 +2361,7 @@ static void dv1394_add_host (struct hpsb
 
 	ohci = (struct ti_ohci *)host->hostdata;
 
-	class_simple_device_add(hpsb_protocol_class, MKDEV(
+	class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)), 
 		NULL, "dv1394-%d", id);
 	devfs_mk_dir("ieee1394/dv/host%d", id);
diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -67,7 +67,7 @@ MODULE_LICENSE("GPL");
 
 /* Some globals used */
 const char *hpsb_speedto_str[] = { "S100", "S200", "S400", "S800", "S1600", "S3200" };
-struct class_simple *hpsb_protocol_class;
+struct class *hpsb_protocol_class;
 
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 static void dump_packet(const char *text, quadlet_t *data, int size)
@@ -1121,7 +1121,7 @@ static int __init ieee1394_init(void)
 	if (ret < 0)
 		goto release_all_bus;
 
-	hpsb_protocol_class = class_simple_create(THIS_MODULE, "ieee1394_protocol");
+	hpsb_protocol_class = class_create(THIS_MODULE, "ieee1394_protocol");
 	if (IS_ERR(hpsb_protocol_class)) {
 		ret = PTR_ERR(hpsb_protocol_class);
 		goto release_class_host;
@@ -1159,7 +1159,7 @@ static int __init ieee1394_init(void)
 cleanup_csr:
 	cleanup_csr();
 release_class_protocol:
-	class_simple_destroy(hpsb_protocol_class);
+	class_destroy(hpsb_protocol_class);
 release_class_host:
 	class_unregister(&hpsb_host_class);
 release_all_bus:
@@ -1189,7 +1189,7 @@ static void __exit ieee1394_cleanup(void
 
 	cleanup_csr();
 
-	class_simple_destroy(hpsb_protocol_class);
+	class_destroy(hpsb_protocol_class);
 	class_unregister(&hpsb_host_class);
 	for (i = 0; fw_bus_attrs[i]; i++)
 		bus_remove_file(&ieee1394_bus_type, fw_bus_attrs[i]);
diff --git a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
--- a/drivers/ieee1394/ieee1394_core.h
+++ b/drivers/ieee1394/ieee1394_core.h
@@ -223,6 +223,7 @@ extern int hpsb_disable_irm;
 /* Our sysfs bus entry */
 extern struct bus_type ieee1394_bus_type;
 extern struct class hpsb_host_class;
-extern struct class_simple *hpsb_protocol_class;
+extern struct class *hpsb_protocol_class;
 
 #endif /* _IEEE1394_CORE_H */
+
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -2901,7 +2901,7 @@ static int __init init_raw1394(void)
 
 	hpsb_register_highlevel(&raw1394_highlevel);
 
-	if (IS_ERR(class_simple_device_add(hpsb_protocol_class, MKDEV(
+	if (IS_ERR(class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_RAW1394 * 16), 
 		NULL, RAW1394_DEVICE_NAME))) {
 		ret = -EFAULT;
@@ -2934,8 +2934,8 @@ static int __init init_raw1394(void)
 
 out_dev:
 	devfs_remove(RAW1394_DEVICE_NAME);
-	class_simple_device_remove(MKDEV(
-		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
+	class_device_destroy(hpsb_protocol_class,
+		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
 out_unreg:
 	hpsb_unregister_highlevel(&raw1394_highlevel);
 out:
@@ -2944,8 +2944,8 @@ out:
 
 static void __exit cleanup_raw1394(void)
 {
-	class_simple_device_remove(MKDEV(
-		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
+	class_device_destroy(hpsb_protocol_class,
+		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
 	cdev_del(&raw1394_cdev);
 	devfs_remove(RAW1394_DEVICE_NAME);
 	hpsb_unregister_highlevel(&raw1394_highlevel);
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -1370,7 +1370,7 @@ static void video1394_add_host (struct h
 	hpsb_set_hostinfo_key(&video1394_highlevel, host, ohci->host->id);
 
 	minor = IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id;
-	class_simple_device_add(hpsb_protocol_class, MKDEV(
+	class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	minor), 
 		NULL, "%s-%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
 	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
@@ -1384,7 +1384,7 @@ static void video1394_remove_host (struc
 	struct ti_ohci *ohci = hpsb_get_hostinfo(&video1394_highlevel, host);
 
 	if (ohci) {
-		class_simple_device_remove(MKDEV(IEEE1394_MAJOR, 
+		class_device_destroy(hpsb_protocol_class, MKDEV(IEEE1394_MAJOR,
 			IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id));
 		devfs_remove("%s/%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
 	}

