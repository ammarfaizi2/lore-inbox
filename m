Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUIWQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUIWQoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUIWQmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:42:05 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19691 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268019AbUIWQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:40:40 -0400
Date: Fri, 24 Sep 2004 01:36:42 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: anil.s.keshavamurthy@intel.com
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH][4/4] Add NUMA node handling to the container driver
Message-Id: <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920094719.H14208@unix-os.sc.intel.com>
	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name: container_for_numa.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Add NUMA node handling to the container driver.

Thanks,
Keiichiro Tokunaga
---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/container.c |   11 +++++++++++
 linux-2.6.9-rc2-fix-kei/include/acpi/container.h |   15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/container.c~container_for_numa drivers/acpi/container.c
--- linux-2.6.9-rc2-fix/drivers/acpi/container.c~container_for_numa	2004-09-24 00:45:56.781826629 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/container.c	2004-09-24 01:38:09.774323452 +0900
@@ -104,6 +104,8 @@ acpi_container_add(struct acpi_device *d
 	container = kmalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if(!container)
 		return_VALUE(-ENOMEM);
+
+	container_numa_init(device->handle);
 	
 	memset(container, 0, sizeof(struct acpi_container));
 	container->handle = device->handle;
@@ -123,6 +125,14 @@ acpi_container_remove(struct acpi_device
 {
 	acpi_status		status = AE_OK;
 	struct acpi_container	*pc = NULL;
+	if (type == ACPI_BUS_REMOVAL_EJECT) {
+		if (!device->flags.ejectable)
+			return(-EINVAL);
+
+		container_numa_remove(device->handle);
+	}
+
+	container_numa_detach_data(device->handle);
 	pc = (struct acpi_container*) acpi_driver_data(device);
 
 	if (pc)
@@ -198,6 +208,7 @@ container_device_add(struct acpi_device 
 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
 		return_VALUE(-ENODEV);
 	}
+	container_numa_add((*device)->handle);
 
 	result = acpi_bus_scan(*device);
 
diff -puN include/acpi/container.h~container_for_numa include/acpi/container.h
--- linux-2.6.9-rc2-fix/include/acpi/container.h~container_for_numa	2004-09-24 00:45:56.783779765 +0900
+++ linux-2.6.9-rc2-fix-kei/include/acpi/container.h	2004-09-24 00:45:56.786709469 +0900
@@ -2,12 +2,25 @@
 #define __ACPI_CONTAINER_H
 
 #include <linux/kernel.h>
-
 struct acpi_container {
 	acpi_handle handle;
 	unsigned long sun;
 	int state;
 };
 
+#ifdef CONFIG_ACPI_NUMA
+#include <acpi/numa.h>
+#define container_numa_init(handle)	acpi_numa_node_init(handle)
+#define container_numa_add(handle)	acpi_numa_node_add(handle)
+#define container_numa_remove(handle)	acpi_numa_node_remove(handle)
+#define container_numa_detach_data(handle) acpi_numa_node_data_detach(handle)
+#define is_numa_node(handle) is_numa_node_device(acpi_handle handle)
+#else
+#define container_numa_init(handle)
+#define container_numa_add(handle)
+#define container_numa_remove(handle)
+#define container_numa_detach_data(handle)
+#define is_numa_node(handle) (0)
+#endif
 #endif /* __ACPI_CONTAINER_H */
 

_
