Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWHDNOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWHDNOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWHDNOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:9175 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030323AbWHDNOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:16 -0400
Date: Fri, 4 Aug 2006 07:13:51 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/10] hot-add-mem x86_64: acpi motherboard fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the first of 10 patches.  They were built ontop of Kames 6 patches sent out
within the last few days ([RFC][PATCH] fix ioresouce handling take2 [1/5] was 
the first).  Kames patches fix several real isses and with the 6th patch they
are complete from my point of view. 

I have worked to integrate the feedback I recived on the last round of patches
and welcome more ideas/advice. Thanks to everyone who has provied input on
these patches already. 

This patch set allow SPARSEMEM and RESERVE based hot-add to work.  I have
test both options and they work as expected.  I am adding memory to the 
2nd node of a numa system (x86_64).    

Major changes from last set is the config change and RESERVE enablment. 


From: Keith Mannthey <kmannth@us.ibm.com>

Make ACPI motherboard driver not attach to devices/handles it dosen't expect. 
Fix a bug where the motherboard driver attached to hot-add memory event and 
caused the add memory call to fail. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
motherboard.c |    8 +++++++-
1 files changed, 7 insertions(+), 1 deletion(-)

diff -urN orig/drivers/acpi/motherboard.c work/drivers/acpi/motherboard.c
--- orig/drivers/acpi/motherboard.c	2006-07-28 13:57:35.000000000 -0400
+++ work/drivers/acpi/motherboard.c	2006-07-28 16:39:22.000000000 -0400
@@ -87,6 +87,7 @@
 		}
 	} else {
 		/* Memory mapped IO? */
+		 return -EINVAL;
 	}
 
 	if (requested_res)
@@ -96,11 +97,16 @@
 
 static int acpi_motherboard_add(struct acpi_device *device)
 {
+	acpi_status status;
 	if (!device)
 		return -EINVAL;
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    acpi_reserve_io_ranges, NULL);
 
+	if (ACPI_FAILURE(status)) 
+		return -ENODEV;
+	
 	return 0;
 }
 
