Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162269AbWLAXca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162269AbWLAXca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162260AbWLAXcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162238AbWLAXXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:43 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/36] ACPI: Change ACPI to use dev_archdata instead of firmware_data
Date: Fri,  1 Dec 2006 15:21:56 -0800
Message-Id: <11650154123942-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154071138-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Change ACPI to use dev_archdata instead of firmware_data

This patch changes ACPI to use the new dev_archdata on i386, x86_64
and ia64 (is there any other arch using ACPI ?) to store it's
acpi_handle.

It also removes the firmware_data field from struct device as this
was the only user.

Only build-tested on x86

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/glue.c         |   20 +++++++++++---------
 include/acpi/acpi_bus.h     |    2 +-
 include/asm-i386/device.h   |   10 +++++++++-
 include/asm-ia64/device.h   |   10 +++++++++-
 include/asm-x86_64/device.h |   10 +++++++++-
 include/linux/device.h      |    2 --
 6 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 10f160d..a2f46d5 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -267,9 +267,9 @@ static int acpi_bind_one(struct device *
 {
 	acpi_status status;
 
-	if (dev->firmware_data) {
+	if (dev->archdata.acpi_handle) {
 		printk(KERN_WARNING PREFIX
-		       "Drivers changed 'firmware_data' for %s\n", dev->bus_id);
+		       "Drivers changed 'acpi_handle' for %s\n", dev->bus_id);
 		return -EINVAL;
 	}
 	get_device(dev);
@@ -278,25 +278,26 @@ static int acpi_bind_one(struct device *
 		put_device(dev);
 		return -EINVAL;
 	}
-	dev->firmware_data = handle;
+	dev->archdata.acpi_handle = handle;
 
 	return 0;
 }
 
 static int acpi_unbind_one(struct device *dev)
 {
-	if (!dev->firmware_data)
+	if (!dev->archdata.acpi_handle)
 		return 0;
-	if (dev == acpi_get_physical_device(dev->firmware_data)) {
+	if (dev == acpi_get_physical_device(dev->archdata.acpi_handle)) {
 		/* acpi_get_physical_device increase refcnt by one */
 		put_device(dev);
-		acpi_detach_data(dev->firmware_data, acpi_glue_data_handler);
-		dev->firmware_data = NULL;
+		acpi_detach_data(dev->archdata.acpi_handle,
+				 acpi_glue_data_handler);
+		dev->archdata.acpi_handle = NULL;
 		/* acpi_bind_one increase refcnt by one */
 		put_device(dev);
 	} else {
 		printk(KERN_ERR PREFIX
-		       "Oops, 'firmware_data' corrupt for %s\n", dev->bus_id);
+		       "Oops, 'acpi_handle' corrupt for %s\n", dev->bus_id);
 	}
 	return 0;
 }
@@ -328,7 +329,8 @@ static int acpi_platform_notify(struct d
 	if (!ret) {
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-		acpi_get_name(dev->firmware_data, ACPI_FULL_PATHNAME, &buffer);
+		acpi_get_name(dev->archdata.acpi_handle,
+			      ACPI_FULL_PATHNAME, &buffer);
 		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
 		kfree(buffer.pointer);
 	} else
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f338e40..fdd1095 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -357,7 +357,7 @@ struct device *acpi_get_physical_device(
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
-#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->firmware_data))
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
 #endif /* CONFIG_ACPI */
 
diff --git a/include/asm-i386/device.h b/include/asm-i386/device.h
index d8f9872..849604c 100644
--- a/include/asm-i386/device.h
+++ b/include/asm-i386/device.h
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_I386_DEVICE_H
+#define _ASM_I386_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_I386_DEVICE_H */
diff --git a/include/asm-ia64/device.h b/include/asm-ia64/device.h
index d8f9872..3db6daf 100644
--- a/include/asm-ia64/device.h
+++ b/include/asm-ia64/device.h
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_IA64_DEVICE_H
+#define _ASM_IA64_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_IA64_DEVICE_H */
diff --git a/include/asm-x86_64/device.h b/include/asm-x86_64/device.h
index d8f9872..3afa03f 100644
--- a/include/asm-x86_64/device.h
+++ b/include/asm-x86_64/device.h
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_X86_64_DEVICE_H
+#define _ASM_X86_64_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_X86_64_DEVICE_H */
diff --git a/include/linux/device.h b/include/linux/device.h
index 5b54d75..2d9dc35 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -369,8 +369,6 @@ struct device {
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
-	void		*firmware_data; /* Firmware specific data (e.g. ACPI,
-					   BIOS data),reserved for device core*/
 	struct dev_pm_info	power;
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
-- 
1.4.4.1

