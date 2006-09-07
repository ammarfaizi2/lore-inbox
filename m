Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWIGXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWIGXNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWIGXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:13:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:50598 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1422696AbWIGXNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:13:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,227,1154934000"; 
   d="scan'208"; a="122912849:sNHT37782073"
Date: Thu, 7 Sep 2006 16:13:13 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: [patch 1/2] acpi: check if parent is on dock
Message-Id: <20060907161313.a0c0d135.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When determining if a device is on a dock station, we should
check the parent of the device as well.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -586,20 +586,28 @@ static acpi_status
 find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	acpi_handle tmp;
+	acpi_handle tmp, parent;
 	struct dock_station *ds = (struct dock_station *)context;
 	struct dock_dependent_device *dd;
 
 	status = acpi_bus_get_ejd(handle, &tmp);
-	if (ACPI_FAILURE(status))
-		return AE_OK;
+	if (ACPI_FAILURE(status)) {
+		/* try the parent device as well */
+		status = acpi_get_parent(handle, &parent);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+		/* see if parent is dependent on dock */
+		status = acpi_bus_get_ejd(parent, &tmp);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+	}
 
 	if (tmp == ds->handle) {
 		dd = alloc_dock_dependent_device(handle);
 		if (dd)
 			add_dock_dependent_device(ds, dd);
 	}
-
+fdd_out:
 	return AE_OK;
 }
 
