Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWIAXBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWIAXBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIAXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 19:01:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38361 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750946AbWIAXBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 19:01:18 -0400
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 
	0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	 <200608310248.29861.len.brown@intel.com>
	 <1157042913.7859.31.camel@keithlap>
	 <200608311707.00817.bjorn.helgaas@hp.com>
	 <1157073592.5649.29.camel@keithlap>
	 <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Fri, 01 Sep 2006 16:01:14 -0700
Message-Id: <1157151674.5656.21.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 21:15 -0600, Bjorn Helgaas wrote:
> > On Thu, 2006-08-31 at 17:06 -0600, Bjorn Helgaas wrote:
> >> Problem 1: acpi_reserve_io_ranges() needs to return an acpi_status
> >> like AE_OK or AE_CTRL_TERMINATE, not a -EINVAL.
> >
> > Sure great sounds.  I understand AE_OK is a 0 return so I can change it
> > to AE_CTRL_TERMINATE.  I don't want  acpi_reserve_io_ranges to return a
> > happy state when if finds a resource type is doesn't know.
> 
> Except that when the motherboard driver claims a device, it really
> should claim all the resources used by the device.  It currently only
> claims I/O port resources, but I think it should also claim MMIO
> resources.  Otherwise, the system resource accounting is screwed up,
> and resources consumed by the motherboard device could be mistakenly
> allocated to another device.
> 
> > Kame (who helped me greatly in tracking down the source my troubles)
> > thinks that the root cause is that the device (my memory_device) has
> > both a _HID and _CID. The driver for _HID is different for _CID and the
> > driver for _CID is found before _HID and I pass the wrong device up the
> > chain.
> 
> Ok, this is starting to make sense.  It sounds like your memory
> device has _HID of PNP0C80 and _CID of PNP0C01 (or PNP0C02).
> 
> The current ACPI driver binding algorithm in acpi_bus_find_driver()
> looks at each driver, checking whether it can match either the _HID
> or the _CID of a device.  Since we try the motherboard driver first,
> it matches the memory device _CID.

Ok I reverted the motherboard driver patch and cooked up the following
patch that works for my issue.  

  It creates the idea that acpi_match_ids has a type of request to check
against for _HID, _CID or both.  See acpi_bus_match_req. I then fix up
all the needed callers to change the API to acpi_match_ids and
acpi_bus_match and have callers can say what they want to match
against. 
  
  Then in acpi_bus_find_driver I have it do 2 passes to search for _HID
first then the _CID.  

Does this look like it is in the right ballpark or should we be doing
something else?  Built/tested against 2.6.18-rc4-mm3. 

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>


diff -urN linux-2.6.17-orig/drivers/acpi/scan.c linux-2.6.17/drivers/acpi/scan.c
--- linux-2.6.17-orig/drivers/acpi/scan.c	2006-09-01 17:11:37.000000000 -0400
+++ linux-2.6.17/drivers/acpi/scan.c	2006-09-01 18:13:53.000000000 -0400
@@ -235,13 +235,13 @@
 	return 0;
 }
 
-int acpi_match_ids(struct acpi_device *device, char *ids)
+int acpi_match_ids(struct acpi_device *device, char *ids, int type)
 {
-	if (device->flags.hardware_id)
+	if ((device->flags.hardware_id) && (type != ACPI_BUS_MATCH_CID))
 		if (strstr(ids, device->pnp.hardware_id))
 			return 0;
 
-	if (device->flags.compatible_ids) {
+	if ((device->flags.compatible_ids) && (type != ACPI_BUS_MATCH_HID)) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
 		int i;
 
@@ -329,7 +329,8 @@
 
 	device->wakeup.flags.valid = 1;
 	/* Power button, Lid switch always enable wakeup */
-	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
+	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E", 
+							ACPI_BUS_MATCH_ALL))
 		device->wakeup.flags.run_wake = 1;
 
       end:
@@ -471,11 +472,11 @@
  * matches the specified driver's criteria.
  */
 static int
-acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver)
+acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver, int type)
 {
 	if (driver && driver->ops.match)
 		return driver->ops.match(device, driver);
-	return acpi_match_ids(device, driver->ids);
+	return acpi_match_ids(device, driver->ids, type);
 }
 
 /**
@@ -549,7 +550,7 @@
 			continue;
 		spin_unlock(&acpi_device_lock);
 
-		if (!acpi_bus_match(dev, drv)) {
+		if (!acpi_bus_match(dev, drv, ACPI_BUS_MATCH_ALL)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
 				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
@@ -651,7 +652,22 @@
 
 		atomic_inc(&driver->references);
 		spin_unlock(&acpi_device_lock);
-		if (!acpi_bus_match(device, driver)) {
+		if (!acpi_bus_match(device, driver, ACPI_BUS_MATCH_HID)) {
+			result = acpi_bus_driver_init(device, driver);
+			if (!result)
+				goto Done;
+		}
+		atomic_dec(&driver->references);
+		spin_lock(&acpi_device_lock);
+	}
+
+	list_for_each_safe(node, next, &acpi_bus_drivers) {
+		struct acpi_driver *driver =
+		    container_of(node, struct acpi_driver, node);
+
+		atomic_inc(&driver->references);
+		spin_unlock(&acpi_device_lock);
+		if (!acpi_bus_match(device, driver, ACPI_BUS_MATCH_ALL)) {
 			result = acpi_bus_driver_init(device, driver);
 			if (!result)
 				goto Done;
diff -urN linux-2.6.17-orig/drivers/pnp/pnpacpi/core.c linux-2.6.17/drivers/pnp/pnpacpi/core.c
--- linux-2.6.17-orig/drivers/pnp/pnpacpi/core.c	2006-09-01 17:11:37.000000000 -0400
+++ linux-2.6.17/drivers/pnp/pnpacpi/core.c	2006-09-01 18:03:26.000000000 -0400
@@ -41,7 +41,7 @@
 	;
 static inline int is_exclusive_device(struct acpi_device *dev)
 {
-	return (!acpi_match_ids(dev, excluded_id_list));
+	return (!acpi_match_ids(dev, excluded_id_list, ACPI_BUS_MATCH_ALL));
 }
 
 /*
diff -urN linux-2.6.17-orig/include/acpi/acpi_bus.h linux-2.6.17/include/acpi/acpi_bus.h
--- linux-2.6.17-orig/include/acpi/acpi_bus.h	2006-09-01 17:11:38.000000000 -0400
+++ linux-2.6.17/include/acpi/acpi_bus.h	2006-09-01 18:00:27.000000000 -0400
@@ -79,6 +79,12 @@
 	ACPI_BUS_DEVICE_TYPE_COUNT
 };
 
+enum acpi_bus_match_req {
+	ACPI_BUS_MATCH_HID = 0,
+	ACPI_BUS_MATCH_CID,
+	ACPI_BUS_MATCH_ALL
+};
+
 struct acpi_driver;
 struct acpi_device;
 
@@ -335,7 +341,7 @@
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_start(struct acpi_device *device);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd);
-int acpi_match_ids(struct acpi_device *device, char *ids);
+int acpi_match_ids(struct acpi_device *device, char *ids, int type);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 



-- 
VGER BF report: H 0.238464
