Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUIVEVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUIVEVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 00:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUIVEVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 00:21:53 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28108 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267850AbUIVEVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 00:21:40 -0400
Date: Wed, 22 Sep 2004 13:17:57 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface
 support
In-reply-to: <20040920093532.D14208@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040922131757.509ba88d.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920093532.D14208@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 09:35:33 -0700 Keshavamurthy Anil S wrote:
> ---
> Name:acpi_core_eject.patch
> Status: Tested on 2.6.9-rc2
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Depends:acpi_core
> Version: applies on 2.6.9-rc2
> 
> This patch support /sys/firmware/acpi/eject interface where in 
> the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
> /sys/firmware/acpi/eject
> 
> The kernel when it receives an hardware sci eject request it simply passes this
> to user mode agent and the agent in turn will offline all the child devices and
> then echo's the ACPI device name onto /sys/firware/acpi/eject file and then the
> kernel will then actually remove the device.

In acpi_eject_store(), eject_operation() is called regardless of the
result of acpi_bus_trim().  I think that eject_operation() should be
called only when acpi_bus_trim() returns success.  Otherwise, a
device stil being online will be ejected forcibly.

Two steps might be needed to do this.

    1. Modify acpi_bus_trim() to return success only when all the
        acpi_bus_remove() are done successfully.
    2. Modify acpi_eject_store() to see the result and call eject_operation()
        only when the result is success.

Here is a patch just to show what I have in mind.  It is still based on
the recursion, so please fix it as appropriate ;)

Thanks,
Keiichiro Tokunaga


Name: acpi_core_eject_fix.patch
Status: Tested on 2.6.9-rc2
---

 linux-2.6.9-rc2-fix-kei/drivers/acpi/scan.c     |   26 +++++++++++++++---------
 linux-2.6.9-rc2-fix-kei/include/acpi/acpi_bus.h |    2 -
 2 files changed, 18 insertions(+), 10 deletions(-)

diff -puN drivers/acpi/scan.c~acpi_core_eject_fix drivers/acpi/scan.c
--- linux-2.6.9-rc2-fix/drivers/acpi/scan.c~acpi_core_eject_fix	2004-09-22 08:42:49.402689136 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/acpi/scan.c	2004-09-22 09:29:51.056265232 +0900
@@ -404,11 +404,14 @@ acpi_eject_store(struct subsystem *subsy
 	 * remove from ACPI bus.
 	 */
 	if (type == ACPI_BUS_TYPE_PROCESSOR)
-		acpi_bus_trim(device, 0);
+		result = acpi_bus_trim(device, 0);
 	else
-		acpi_bus_trim(device, 1);
+		result = acpi_bus_trim(device, 1);
 		
-
+	if (result) {
+		ret = -EBUSY;
+		goto err;
+	}
 	result = eject_operation(hlsb, islockable);
 	if (result) {
 		ret = -EBUSY;
@@ -1203,7 +1206,7 @@ int acpi_bus_scan (struct acpi_device	*s
 	return_VALUE(0);
 }
 
-void
+int
 acpi_bus_trim(struct acpi_device	*start,
 		int rmdevice)
 {
@@ -1212,25 +1215,30 @@ acpi_bus_trim(struct acpi_device	*start,
 	struct acpi_device	*child = NULL;
 	acpi_handle		phandle = 0;
 	acpi_handle		chandle = 0;
-
+	int err = 0;
 	parent  = start;
 	phandle = start->handle;
 
 	/*
 	 * NOTE: must be freed in a depth-first manner.
 	 */
-	while (1)	{
+	while (1) {
 		status = acpi_get_next_object(ACPI_TYPE_ANY, phandle,
 			chandle, &chandle);
-		if (ACPI_SUCCESS(status) && chandle != NULL)	{
+		if (ACPI_SUCCESS(status) && chandle != NULL) {
 			if (acpi_bus_get_device(chandle, &child) == 0)
-				acpi_bus_trim(child, 1);
+				if (acpi_bus_trim(child, 1))
+					err = 1;
 		} else {
 			/* this is a leaf */
-			acpi_bus_remove(parent, rmdevice);
+			if (!err)  {
+				if (acpi_bus_remove(parent, rmdevice))
+					err = 1;
+			}
 			break;
 		}
 	}
+	return err;
 }
 
 static int
diff -puN include/acpi/acpi_bus.h~acpi_core_eject_fix include/acpi/acpi_bus.h
--- linux-2.6.9-rc2-fix/include/acpi/acpi_bus.h~acpi_core_eject_fix	2004-09-22 08:42:49.404642274 +0900
+++ linux-2.6.9-rc2-fix-kei/include/acpi/acpi_bus.h	2004-09-22 08:42:49.408548551 +0900
@@ -325,7 +325,7 @@ int acpi_bus_receive_event (struct acpi_
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 int acpi_bus_scan (struct acpi_device *start);
-void acpi_bus_trim(struct acpi_device *start, int rmdevice);
+int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent, acpi_handle handle, int type);
 
 

_
