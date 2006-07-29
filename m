Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161408AbWG2Cxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbWG2Cxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWG2Cxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:53:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7917 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161408AbWG2CxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:53:03 -0400
Subject: [Patch] 5/5 in support of hot-add memory x86_64 fix acpi
	motherboard.c
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>,
       Patrick Mochel <mochel@linux.intel.com>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, andrew <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-EL4KP72q0a2jQ2ieyVv8"
Organization: Linux Technology Center IBM
Date: Fri, 28 Jul 2006 19:53:00 -0700
Message-Id: <1154141580.5874.149.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EL4KP72q0a2jQ2ieyVv8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,
  This patch fixes an issue I encountered while doing hot-add memroy on
my platform (IBM Summit).     

  My system loads to acpi memory hot plug driver just fine during boot.
It installs and registers acpi_memory_device_driver and it's handler.
When the hot add memory event occurs the handler is called. this is the
relevant call path

acpi_memory_get_device
acpi_bus_add
acpi_add_single_object
acpi_bus_find_driver
acpi_bus_driver_init
driver->ops.add

  The algorithm it try to match devices from acpi_bus_drivers.  It looks
for drivers that are on the right bus and calls acpi_bus_driver_init.
If it gets a good return value for acpi_bus_driver_init it thinks it
found the device and returns.  The problem is the motherboard driver
driver->ops.add is getting called and it ALWAYS returns AE_OK. 

  The device that is passed back up the call chain is the wrong one (the
motherboard device) and whole things break down. 

  My solution is the make the motherboard value fail to return a AE_OK
for devices it does not expect (like my hot-add memory event).  

Without this patch I cannot do real hot-add memory with my hardware.  

Thanks to KAMEZAWA Hiroyuki for helping to debug the issue and Patrick
Mochel for providing input.   

This was built against 2.6.18-rc2.

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-EL4KP72q0a2jQ2ieyVv8
Content-Disposition: attachment; filename=patch-2.6.18-rc2-motherboard
Content-Type: text/x-patch; name=patch-2.6.18-rc2-motherboard; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
 

--=-EL4KP72q0a2jQ2ieyVv8--

