Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269054AbUIXX3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269054AbUIXX3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUIXX3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:29:02 -0400
Received: from fmr04.intel.com ([143.183.121.6]:53636 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269054AbUIXX2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:28:39 -0400
Date: Fri, 24 Sep 2004 16:28:23 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, Len Brown <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040924162823.B27778@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201333.42857.dtor_core@ameritech.net> <20040920122404.B15677@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409201812.45933.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Sep 20, 2004 at 06:12:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 06:12:45PM -0500, Dmitry Torokhov wrote:
> Hi Anil,
> 
> I obviously failed to deliver my idea :) I meant that I would like add eject
> attribute (along with maybe status, hid and some others) to kobjects in
> /sys/firmware/acpi tree.

Here the modified patch based on the your feedback. Now I am creating eject attribute
to the acpi kobjects in /sys/firmware/acpi.


---
Name:acpi_core_eject.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:acpi_core
Version: applies on 2.6.9-rc2

The kernel when it receives an hardware sci eject request it simply passes this
to user mode agent and the agent in turn will offline all the child devices and
then echo's 1 onto the eject file for that acpi device.

This patch provides the sysfs "eject" interface for the user mode agent
to notify the core acpi so that the core acpi can trim its bus which 
causes .remove function to be called for all child devices.

For example for LSB0 which is an ejectable device, we will see
/sys/firmware/acpi/namespace/ACPI/_SB/LSB/eject.

---

 linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c |  153 +++++++++++++++++++++++++++
 1 files changed, 153 insertions(+)

diff -puN drivers/acpi/scan.c~acpi_core_eject drivers/acpi/scan.c
--- linux-2.6.9-rc2/drivers/acpi/scan.c~acpi_core_eject	2004-09-24 15:26:20.348278419 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c	2004-09-24 15:26:20.441051855 -0700
@@ -2,6 +2,7 @@
  * scan.c - support for transforming the ACPI namespace into individual objects
  */
 
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 
@@ -34,7 +35,49 @@ static void acpi_device_release(struct k
 	kfree(dev);
 }
 
+struct acpi_device_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_device *, char *);
+	ssize_t (*store)(struct acpi_device *, const char *, size_t);
+};
+
+typedef void acpi_device_sysfs_files(struct kobject *,
+				const struct attribute *);
+
+static void setup_sys_fs_device_files(struct acpi_device *dev,
+		acpi_device_sysfs_files *func);
+
+#define create_sysfs_device_files(dev)	\
+	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
+#define remove_sysfs_device_files(dev)	\
+	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)
+
+
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_handle_attr(n) container_of(n, struct acpi_device_attribute, attr);
+
+static ssize_t acpi_device_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device_attribute *attribute = to_handle_attr(attr);
+	return attribute->show ? attribute->show(device, buf) : 0;
+}
+static ssize_t acpi_device_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t len)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device_attribute *attribute = to_handle_attr(attr);
+	return attribute->store ? attribute->store(device, buf, len) : len;
+}
+
+static struct sysfs_ops acpi_device_sysfs_ops = {
+	.show	= acpi_device_attr_show,
+	.store	= acpi_device_attr_store,
+};
+
 static struct kobj_type ktype_acpi_ns = {
+	.sysfs_ops	= &acpi_device_sysfs_ops,
 	.release	= acpi_device_release,
 };
 
@@ -76,6 +119,7 @@ static void acpi_device_register(struct 
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_device_files(device);
 }
 
 static int
@@ -95,6 +139,7 @@ acpi_device_unregister (
 	spin_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
+	remove_sysfs_device_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -291,6 +336,114 @@ end:
 }
 
 /* --------------------------------------------------------------------------
+		ACPI hotplug sysfs device file support
+   -------------------------------------------------------------------------- */
+static ssize_t acpi_eject_store(struct acpi_device *device, 
+		const char *buf, size_t count);
+
+#define ACPI_DEVICE_ATTR(_name,_mode,_show,_store) \
+static struct acpi_device_attribute acpi_device_attr_##_name = \
+		__ATTR(_name, _mode, _show, _store)
+
+ACPI_DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+
+/**
+ * setup_sys_fs_device_files - sets up the device files under device namespace
+ * @@dev:	acpi_device object
+ * @@func:	function pointer to create or destroy the device file
+ */
+static void
+setup_sys_fs_device_files (
+	struct acpi_device *dev,
+	acpi_device_sysfs_files *func)
+{
+	if (dev->flags.ejectable == 1)
+		(*(func))(&dev->kobj,&acpi_device_attr_eject.attr);
+}
+
+static int
+acpi_eject_operation(acpi_handle handle, int lockable)
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
+
+static ssize_t
+acpi_eject_store(struct acpi_device *device, const char *buf, size_t count)
+{
+	int	result;
+	int	ret = count;
+	int	islockable;
+	acpi_status	status;
+	acpi_handle	handle;
+	acpi_object_type	type = 0;
+
+	if ((!count) || (buf[0] != '1')) {
+		return -EINVAL;
+	}
+
+#ifndef FORCE_EJECT
+	if (device->driver == NULL) {
+		ret = -ENODEV;
+		goto err;
+	}
+#endif
+	status = acpi_get_type(device->handle, &type);
+	if (ACPI_FAILURE(status) || (!device->flags.ejectable) ) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	islockable = device->flags.lockable;
+	handle = device->handle;
+
+	if (type == ACPI_TYPE_PROCESSOR)
+		result = acpi_bus_trim(device, 0);
+	else
+		result = acpi_bus_trim(device, 1);
+
+	if (!result)
+		result = acpi_eject_operation(handle, islockable);
+
+	if (result) {
+		ret = -EBUSY;
+	}
+err:
+	return ret;
+}
+
+
+/* --------------------------------------------------------------------------
                               Performance Management
    -------------------------------------------------------------------------- */
 
_

