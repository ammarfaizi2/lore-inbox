Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUITQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUITQiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUITQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:38:16 -0400
Received: from fmr03.intel.com ([143.183.121.5]:29830 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266807AbUITQfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:35:40 -0400
Date: Mon, 20 Sep 2004 09:35:33 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040920093532.D14208@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040920092520.A14208@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Mon, Sep 20, 2004 at 09:25:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---
Name:acpi_core_eject.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:acpi_core
Version: applies on 2.6.9-rc2

This patch support /sys/firmware/acpi/eject interface where in 
the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
/sys/firmware/acpi/eject

The kernel when it receives an hardware sci eject request it simply passes this
to user mode agent and the agent in turn will offline all the child devices and
then echo's the ACPI device name onto /sys/firware/acpi/eject file and then the
kernel will then actually remove the device.

---

 linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c |  141 +++++++++++++++++++++++++++
 1 files changed, 141 insertions(+)

diff -puN drivers/acpi/scan.c~acpi_core_eject drivers/acpi/scan.c
--- linux-2.6.9-rc2/drivers/acpi/scan.c~acpi_core_eject	2004-09-17 17:56:46.027451654 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c	2004-09-17 17:56:46.114365716 -0700
@@ -2,6 +2,7 @@
  * scan.c - support for transforming the ACPI namespace into individual objects
  */
 
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 
@@ -291,6 +292,141 @@ end:
 }
 
 /* --------------------------------------------------------------------------
+                              ACPI hotplug Eject support
+   -------------------------------------------------------------------------- */
+static ssize_t acpi_eject_store(struct subsystem *subsys, const char *buf, size_t count);
+static struct subsys_attribute acpi_eject_attr =
+	__ATTR(eject,0200,NULL,acpi_eject_store);
+
+/*
+ * evaluate _EJ0, detach driver, and remove from ACPI bus
+ */
+static int
+eject_operation(acpi_handle handle, int lockable)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status = AE_OK;
+
+	/*
+	 * TBD: evaluate _PS3?
+	 */
+
+	if (lockable) {
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = 0;
+		acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	/*
+	 * TBD: _EJD support.
+	 */
+
+	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status)) {
+		return(-ENODEV);
+	}
+
+	return(0);
+}
+
+static ssize_t
+acpi_eject_store(struct subsystem *subsys, const char *buf, size_t count)
+{
+	acpi_status status;
+	acpi_handle hlsb;
+	struct acpi_device *device = NULL;
+	int result;
+	int ret = count;
+
+	char *acpi_name;
+	char *p;
+	int islockable;
+	acpi_object_type	type = 0;
+
+	if (!count) {
+		return -EINVAL;
+	}
+
+	acpi_name = kmalloc(count+1, GFP_KERNEL);
+	if (!acpi_name) {
+		return -ENOMEM;
+	}
+
+	acpi_name[count] = '\0';
+	strncpy(acpi_name, buf, count);
+
+	for (p = acpi_name+(count-1); p >= acpi_name; --p) {
+		if (isspace(*p))
+			*p = '\0';
+		else
+			break;
+	}
+
+	status = acpi_get_handle(NULL, acpi_name, &hlsb);
+	if(ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	status = acpi_get_type(hlsb, &type);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	result = acpi_bus_get_device(hlsb, &device);
+	if (result) {
+		ret = -ENODEV;
+		goto err;
+	}
+#ifndef FORCE_EJECT
+	if (device->driver == NULL) {
+		ret = -ENODEV;
+		goto err;
+	}
+#endif
+	if (!device->flags.ejectable) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	islockable = device->flags.lockable;
+
+	/*
+	 * remove from ACPI bus.
+	 */
+	if (type == ACPI_BUS_TYPE_PROCESSOR)
+		acpi_bus_trim(device, 0);
+	else
+		acpi_bus_trim(device, 1);
+		
+
+	result = eject_operation(hlsb, islockable);
+	if (result) {
+		ret = -EBUSY;
+	}
+err:
+	kfree(acpi_name);
+	return ret;
+}
+
+
+static int __init register_acpi_eject(void)
+{
+	subsys_create_file(&acpi_subsys, &acpi_eject_attr);
+	return 0;
+}
+
+
+/* --------------------------------------------------------------------------
                               Performance Management
    -------------------------------------------------------------------------- */
 
@@ -1153,6 +1289,11 @@ static int __init acpi_scan_init(void)
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 
+	/*
+	 * Register hotplug eject interface
+	 */
+	register_acpi_eject();
+
  Done:
 	return_VALUE(result);
 }
_
