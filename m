Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270529AbUJUDet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270529AbUJUDet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270565AbUJUDbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:31:19 -0400
Received: from fmr05.intel.com ([134.134.136.6]:25066 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270434AbUJUDUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:20:03 -0400
Subject: [PATCH 3/5]add .match method for ACPI
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-LV/L9tsIeDZuDVRM917v"
Message-Id: <1098327565.6132.224.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:59:57 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LV/L9tsIeDZuDVRM917v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
The idea of the patch is from Bruno Ducrot <ducrot@poupinou.org>'s ACPI
video extension patch. Since the video extension patch hasn't been
merged and the ACPI PNP driver requires it, I attached it here.

Thanks,
Shaohua

--- 2.6/drivers/acpi/scan.c.stg4	2004-10-18 16:49:57.926042680 +0800
+++ 2.6/drivers/acpi/scan.c	2004-10-18 16:57:30.572230000 +0800
@@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
 	return 0;
 }
 
-static int
+int
 acpi_match_ids (
 	struct acpi_device	*device,
 	char			*ids)
@@ -314,6 +314,8 @@ acpi_bus_match (
 	struct acpi_device	*device,
 	struct acpi_driver	*driver)
 {
+	if (driver && driver->ops.match)
+		return driver->ops.match(device, driver);
 	return acpi_match_ids(device, driver->ids);
 }
 
@@ -495,9 +497,6 @@ acpi_bus_find_driver (
 
 	ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
 
-	if (!device->flags.hardware_id && !device->flags.compatible_ids)
-		goto Done;
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node,next,&acpi_bus_drivers) {
 		struct acpi_driver * driver = container_of(node,struct
acpi_driver,node);
--- 2.6/include/acpi/acpi_bus.h.stg4	2004-10-18 16:50:31.522935176 +0800
+++ 2.6/include/acpi/acpi_bus.h	2004-10-18 16:55:11.474376088 +0800
@@ -104,6 +104,8 @@ typedef int (*acpi_op_suspend)	(struct a
 typedef int (*acpi_op_resume)	(struct acpi_device *device, int state);
 typedef int (*acpi_op_scan)	(struct acpi_device *device);
 typedef int (*acpi_op_bind)	(struct acpi_device *device);
+typedef int (*acpi_op_match)	(struct acpi_device *device,
+	struct acpi_driver *driver);
 
 struct acpi_device_ops {
 	acpi_op_add		add;
@@ -115,6 +117,7 @@ struct acpi_device_ops {
 	acpi_op_resume		resume;
 	acpi_op_scan		scan;
 	acpi_op_bind		bind;
+	acpi_op_match		match;
 };
 
 struct acpi_driver {
@@ -322,6 +325,7 @@ int acpi_bus_receive_event (struct acpi_
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 
+int acpi_match_ids (struct acpi_device	*device, char	*ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 


--=-LV/L9tsIeDZuDVRM917v
Content-Disposition: attachment; filename=acpi_match.patch
Content-Type: text/x-patch; name=acpi_match.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6/drivers/acpi/scan.c.stg4	2004-10-18 16:49:57.926042680 +0800
+++ 2.6/drivers/acpi/scan.c	2004-10-18 16:57:30.572230000 +0800
@@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
 	return 0;
 }
 
-static int
+int
 acpi_match_ids (
 	struct acpi_device	*device,
 	char			*ids)
@@ -314,6 +314,8 @@ acpi_bus_match (
 	struct acpi_device	*device,
 	struct acpi_driver	*driver)
 {
+	if (driver && driver->ops.match)
+		return driver->ops.match(device, driver);
 	return acpi_match_ids(device, driver->ids);
 }
 
@@ -495,9 +497,6 @@ acpi_bus_find_driver (
 
 	ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
 
-	if (!device->flags.hardware_id && !device->flags.compatible_ids)
-		goto Done;
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node,next,&acpi_bus_drivers) {
 		struct acpi_driver * driver = container_of(node,struct acpi_driver,node);
--- 2.6/include/acpi/acpi_bus.h.stg4	2004-10-18 16:50:31.522935176 +0800
+++ 2.6/include/acpi/acpi_bus.h	2004-10-18 16:55:11.474376088 +0800
@@ -104,6 +104,8 @@ typedef int (*acpi_op_suspend)	(struct a
 typedef int (*acpi_op_resume)	(struct acpi_device *device, int state);
 typedef int (*acpi_op_scan)	(struct acpi_device *device);
 typedef int (*acpi_op_bind)	(struct acpi_device *device);
+typedef int (*acpi_op_match)	(struct acpi_device *device,
+	struct acpi_driver *driver);
 
 struct acpi_device_ops {
 	acpi_op_add		add;
@@ -115,6 +117,7 @@ struct acpi_device_ops {
 	acpi_op_resume		resume;
 	acpi_op_scan		scan;
 	acpi_op_bind		bind;
+	acpi_op_match		match;
 };
 
 struct acpi_driver {
@@ -322,6 +325,7 @@ int acpi_bus_receive_event (struct acpi_
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 
+int acpi_match_ids (struct acpi_device	*device, char	*ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 

--=-LV/L9tsIeDZuDVRM917v--

