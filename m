Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268882AbUHLXIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268882AbUHLXIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUHLXHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:07:40 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:54797 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S268872AbUHLXCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:02:03 -0400
Date: Fri, 13 Aug 2004 01:01:55 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status with pmdisk/swsusp merge ?
Message-ID: <20040812230155.GB40442@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1091679494.5225.186.camel@gaston> <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net> <20040808182234.GA620@elf.ucw.cz> <1092065741.4088.3.camel@localhost.localdomain> <20040812210415.GB17113@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20040812210415.GB17113@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 12, 2004 at 11:04:15PM +0200, Pavel Machek wrote:
> > FWIW I ported the 'old' pmdisk suspend code into swsusp2 and I can
> > suspend, but I can't resume. I haven't got a serial port (its a "modern"
> > laptop.. with parallel, etc but no serial..) so I'm also looking at
> > netconsole, digging around for a line printer, etc..

Can be a problem with a lack of wakeup devices.  You could try this
patch (not by me, and considered ugly by its own author iirc) and
fiddle with echo "PWRB" >/proc/acpi/wakeup_devices and friends.  It
was necessary (with some additional brutality) for the dell latitude
x300.

  OG.

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-wakeup2.diff"

diff -Nur linux-2.6.0-test7/drivers/acpi/power.c linux-2.6.0-test7.new/drivers/acpi/power.c
--- linux-2.6.0-test7/drivers/acpi/power.c	2003-10-09 03:24:06.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/power.c	2003-10-24 23:39:40.000000000 +0800
@@ -176,7 +176,7 @@
 }
 
 
-static int
+int
 acpi_power_on (
 	acpi_handle		handle)
 {
@@ -193,7 +193,7 @@
 
 	resource->references++;
 
-	if ((resource->references > 1) 
+	if ((resource->references > 1)
 		|| (resource->state == ACPI_POWER_RESOURCE_STATE_ON)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already on\n",
 			resource->name));
@@ -223,7 +223,7 @@
 }
 
 
-static int
+int
 acpi_power_off_device (
 	acpi_handle		handle)
 {
diff -Nur linux-2.6.0-test7/drivers/acpi/scan.c linux-2.6.0-test7.new/drivers/acpi/scan.c
--- linux-2.6.0-test7/drivers/acpi/scan.c	2003-10-09 03:24:04.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/scan.c	2003-10-24 23:39:40.000000000 +0800
@@ -23,6 +23,7 @@
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 static LIST_HEAD(acpi_device_list);
+LIST_HEAD(acpi_wakeup_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
 static void acpi_device_release(struct kobject * kobj)
@@ -45,7 +46,6 @@
 	.ktype	= &ktype_acpi_ns,
 };
 
-
 static void acpi_device_register(struct acpi_device * device, struct acpi_device * parent)
 {
 	/*
@@ -115,9 +115,6 @@
 	status = acpi_get_handle(device->handle, "_IRC", &handle);
 	if (ACPI_SUCCESS(status))
 		device->power.flags.inrush_current = 1;
-	status = acpi_get_handle(device->handle, "_PRW", &handle);
-	if (ACPI_SUCCESS(status))
-		device->power.flags.wake_capable = 1;
 
 	/*
 	 * Enumerate supported power management states
@@ -163,7 +160,83 @@
 	return 0;
 }
 
+static acpi_status
+acpi_bus_extract_wakeup_device_power_package (
+	struct acpi_device	*device,
+	union acpi_object	*package)
+{
+	int 	 i = 0;
+	union acpi_object	*element = NULL;
+
+	if (!device || !package || (package->package.count < 2))
+		return AE_BAD_PARAMETER;
+
+	element = &(package->package.elements[0]);
+	if (element->type != ACPI_TYPE_INTEGER) {
+		/* TBD: support this feature*/
+		return AE_BAD_DATA;
+	}
+	device->wakeup_power.gpe = element->integer.value;
+
+	element = &(package->package.elements[1]);
+	if (element->type != ACPI_TYPE_INTEGER) {
+		return AE_BAD_DATA;
+	}
+	device->wakeup_power.sleep_state = element->integer.value;
+
+	if ((package->package.count - 2) > ACPI_MAX_HANDLES) {
+		return AE_NO_MEMORY;
+	}
+	device->wakeup_power.resources.count = package->package.count - 2;
+	for (i=0; i < device->wakeup_power.resources.count; i++) {
+		element = &(package->package.elements[i + 2]);
+		if (element->type != ACPI_TYPE_ANY ) {
+			return AE_BAD_DATA;
+		}
+
+		device->wakeup_power.resources.handles[i] = element->reference.handle;
+	}
+
+	return AE_OK;
+}
+
+static int
+acpi_bus_get_wakeup_device_flags (
+	struct acpi_device	*device)
+{
+	acpi_status	status = 0;
+	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object	*package = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_bus_get_wakeup_flags");
 
+	/* _PRW */
+	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRW\n"));
+		goto end;
+	}
+
+	package = (union acpi_object *) buffer.pointer;
+	status = acpi_bus_extract_wakeup_device_power_package(device, package);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _PRW package\n"));
+		goto end;
+	}
+
+	acpi_os_free(buffer.pointer);
+
+	/*TBD: if exist PSW*/
+
+	/* TBD: lock */
+	INIT_LIST_HEAD(&device->wakeup_list);
+	list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+
+end:
+	if (ACPI_FAILURE(status))
+		device->flags.wake_capable = 0;
+	return 0;
+}
 /* --------------------------------------------------------------------------
                               Performance Management
    -------------------------------------------------------------------------- */
@@ -464,6 +537,11 @@
 	if (ACPI_SUCCESS(status))
 		device->flags.power_manageable = 1;
 
+	/* Presence of _PRW indicates wake capable */
+	status = acpi_get_handle(device->handle, "_PRW", &temp);
+	if (ACPI_SUCCESS(status))
+		device->flags.wake_capable = 1;
+
 	/* TBD: Peformance management */
 
 	return_VALUE(0);
@@ -736,6 +814,16 @@
 	}
 
 	/*
+	*Wakeup device management
+	*-----------------------
+	*/
+	if (device->flags.wake_capable) {
+		result = acpi_bus_get_wakeup_device_flags(device);
+		if (result)
+			goto end;
+	}
+
+	/*
 	 * Performance Management
 	 * ----------------------
 	 */
diff -Nur linux-2.6.0-test7/drivers/acpi/sleep/main.c linux-2.6.0-test7.new/drivers/acpi/sleep/main.c
--- linux-2.6.0-test7/drivers/acpi/sleep/main.c	2003-10-09 03:24:00.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/sleep/main.c	2003-10-24 23:39:40.000000000 +0800
@@ -56,6 +56,9 @@
 			(acpi_physical_address) acpi_wakeup_address);
 	}
 	ACPI_FLUSH_CPU_CACHE();
+	
+	/* change a position for the function? */
+	acpi_enable_wakeup_device_prep(acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
@@ -87,6 +90,9 @@
 
 
 	local_irq_save(flags);
+	/* change a position for the function? */
+	acpi_enable_wakeup_device(acpi_state);
+
 	switch (state)
 	{
 	case PM_SUSPEND_STANDBY:
@@ -133,7 +139,10 @@
 
 static int acpi_pm_finish(u32 state)
 {
-	acpi_leave_sleep_state(state);
+	u32 acpi_state = acpi_suspend_states[state];
+
+	acpi_leave_sleep_state(acpi_state);
+	acpi_disable_wakeup_device_power(acpi_state);
 
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
diff -Nur linux-2.6.0-test7/drivers/acpi/sleep/Makefile linux-2.6.0-test7.new/drivers/acpi/sleep/Makefile
--- linux-2.6.0-test7/drivers/acpi/sleep/Makefile	2003-10-09 03:24:27.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/sleep/Makefile	2003-10-24 23:39:40.000000000 +0800
@@ -1,5 +1,5 @@
 obj-y					:= poweroff.o
-obj-$(CONFIG_ACPI_SLEEP)		+= main.o
+obj-$(CONFIG_ACPI_SLEEP)		+= main.o wakeup.o
 obj-$(CONFIG_ACPI_SLEEP_PROC_FS)	+= proc.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff -Nur linux-2.6.0-test7/drivers/acpi/sleep/proc.c linux-2.6.0-test7.new/drivers/acpi/sleep/proc.c
--- linux-2.6.0-test7/drivers/acpi/sleep/proc.c	2003-10-09 03:24:17.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/sleep/proc.c	2003-10-24 23:39:40.000000000 +0800
@@ -15,6 +15,7 @@
 
 #define ACPI_SYSTEM_FILE_SLEEP		"sleep"
 #define ACPI_SYSTEM_FILE_ALARM		"alarm"
+#define ACPI_SYSTEM_FILE_WAKEUP_DEVICE	"wakeup_devices"
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("sleep")
@@ -352,6 +353,65 @@
 	return_VALUE(result ? result : count);
 }
 
+extern struct list_head	acpi_wakeup_device_list;
+static int
+acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
+{
+	struct list_head * node, * next;
+
+	seq_printf(seq, "Device	Speep state	Status\n");
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		seq_printf(seq, "%4s	%4d		%8s\n",
+			dev->pnp.bus_id, (u32) dev->wakeup_power.sleep_state,
+			dev->wakeup_power.state ? "enabled" : "disabled");
+	}
+	return 0;
+}
+
+static int
+acpi_system_write_wakeup_device (
+	struct file		*file,
+	const char		*buffer,
+	size_t			count,
+	loff_t			*ppos)
+{
+	struct list_head * node, * next;
+	char		strbuf[5];
+	char		str[5] = "";
+	int 		len = count;
+
+	if (len > 4) len = 4;
+
+	if (copy_from_user(strbuf, buffer, len))
+		return -EFAULT;
+	strbuf[len] = '\0';
+	sscanf(strbuf, "%s", str);
+
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		if (!strncmp(dev->pnp.bus_id, str, 4)) {
+			dev->wakeup_power.state = dev->wakeup_power.state ? 0 : 1;
+		}
+	}
+	return count;
+}
+
+static int
+acpi_system_wakeup_device_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_system_wakeup_device_seq_show, PDE(inode)->data);
+}
+
+static struct file_operations acpi_system_wakeup_device_fops = {
+	.open		= acpi_system_wakeup_device_open_fs,
+	.read		= seq_read,
+	.write		= acpi_system_write_wakeup_device,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 static struct file_operations acpi_system_sleep_fops = {
 	.open		= acpi_system_sleep_open_fs,
@@ -385,6 +445,13 @@
 		S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
+
+	/* 'wakeup device' [R/W]*/
+	entry = create_proc_entry(ACPI_SYSTEM_FILE_WAKEUP_DEVICE,
+				  S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	if (entry)
+		entry->proc_fops = &acpi_system_wakeup_device_fops;
+
 	return 0;
 }
 
diff -Nur linux-2.6.0-test7/drivers/acpi/sleep/sleep.h linux-2.6.0-test7.new/drivers/acpi/sleep/sleep.h
--- linux-2.6.0-test7/drivers/acpi/sleep/sleep.h	2003-10-09 03:24:26.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/sleep/sleep.h	2003-10-24 23:39:40.000000000 +0800
@@ -1,4 +1,7 @@
 
 extern u8 sleep_states[];
 extern int acpi_suspend (u32 state);
+void acpi_enable_wakeup_device_prep(u8 sleep_state);
+void acpi_enable_wakeup_device(u8 sleep_state);
+void acpi_disable_wakeup_device_power (u8 sleep_state);
 
diff -Nur linux-2.6.0-test7/drivers/acpi/sleep/wakeup.c linux-2.6.0-test7.new/drivers/acpi/sleep/wakeup.c
--- linux-2.6.0-test7/drivers/acpi/sleep/wakeup.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.0-test7.new/drivers/acpi/sleep/wakeup.c	2003-10-28 14:38:18.316108568 +0800
@@ -0,0 +1,157 @@
+/*
+* wakeup.c - support wakeup devices
+*/
+
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <acpi/acevents.h>
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME		("wakeup_devices")
+
+/*
+* acpi_enable_wakeup_device_prep
+*/
+extern struct list_head	acpi_wakeup_device_list;
+extern int acpi_power_on (acpi_handle	handle);
+extern int acpi_power_off_device (acpi_handle	handle);
+
+void
+acpi_enable_wakeup_device_prep(
+	u8		sleep_state)
+{
+	struct list_head * node, * next;
+	union acpi_object 		arg = {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	arg_list = {1, &arg};
+	acpi_status			status = AE_OK;
+	int					i;
+	int 					ret = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
+	arg.integer.value = 1;
+
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		if (dev->wakeup_power.state && (sleep_state >= (u32) dev->wakeup_power.sleep_state)) {
+			/* Open power resource */
+			for (i = 0; i < dev->wakeup_power.resources.count; i++) {
+				ret = acpi_power_on(dev->wakeup_power.resources.handles[i]);
+				if (ret) {
+					/* TBD: reverse changes */
+					ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error transition power state\n"));
+					dev->wakeup_power.state = 0;
+					continue;
+				}
+			}
+
+			/* Execute PSW */
+			status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
+			if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+				/* TBD; reverse changes */
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluate _PSW\n"));
+				dev->wakeup_power.state = 0;
+				continue;
+			}
+		}
+	}
+}
+
+/*
+* acpi_enable_wakeup_device
+*/
+void
+acpi_enable_wakeup_device(
+	u8		sleep_state)
+{
+	struct list_head * node, * next;
+	struct acpi_gpe_event_info * gpe_info = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		if (dev->wakeup_power.state && (sleep_state >= (u32) dev->wakeup_power.sleep_state)) {
+			/* TBD: support GPE block device */
+			gpe_info = acpi_ev_get_gpe_event_info(NULL, (u32) dev->wakeup_power.gpe);
+			if (!gpe_info) {
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error GPE info\n"));
+				continue;
+			}
+			acpi_hw_enable_gpe_for_wakeup(gpe_info);
+			acpi_hw_clear_gpe(gpe_info);
+			acpi_hw_enable_gpe(gpe_info);
+		}
+	}
+}
+
+/*
+* acpi_disable_wakeup_device_power
+*/
+void
+acpi_disable_wakeup_device_power (
+	u8		sleep_state)
+{
+	struct list_head * node, * next;
+	struct acpi_gpe_event_info * gpe_info = NULL;
+	union acpi_object 		arg = {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	arg_list = {1, &arg};
+	acpi_status			status = AE_OK;
+	int					i;
+	int 					ret = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device_power");
+	arg.integer.value = 0;
+
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		if (dev->wakeup_power.state && (sleep_state >= (u32) dev->wakeup_power.sleep_state)) {
+			/* Open power resource */
+			for (i = 0; i < dev->wakeup_power.resources.count; i++) {
+				ret = acpi_power_off_device(dev->wakeup_power.resources.handles[i]);
+				if (ret) {
+					/* TBD: reverse changes */
+					ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error transition power state\n"));
+					dev->wakeup_power.state = 0;
+					continue;
+				}
+			}
+
+			/* Execute PSW */
+			status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
+			if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+				/* TBD; reverse changes */
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluate _PSW\n"));
+				dev->wakeup_power.state = 0;
+				continue;
+			}
+			/* TBD: support GPE block device */
+			gpe_info = acpi_ev_get_gpe_event_info(NULL, (u32) dev->wakeup_power.gpe);
+			if (!gpe_info) {
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error GPE info\n"));
+				continue;
+			}
+			acpi_hw_disable_gpe_for_wakeup(gpe_info);
+		}
+	}
+
+}
+
+static int __init acpi_wakeup_device_init()
+{
+	struct list_head * node, * next;
+
+	printk("Wake capable device:");
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+
+		printk(" %4s", dev->pnp.bus_id);
+	}
+	printk("\n");
+
+	return 0;
+}
+
+late_initcall(acpi_wakeup_device_init);
diff -Nur linux-2.6.0-test7/include/acpi/acpi_bus.h linux-2.6.0-test7.new/include/acpi/acpi_bus.h
--- linux-2.6.0-test7/include/acpi/acpi_bus.h	2003-10-09 03:24:04.000000000 +0800
+++ linux-2.6.0-test7.new/include/acpi/acpi_bus.h	2003-10-24 23:39:40.000000000 +0800
@@ -159,7 +159,8 @@
 	u32			suprise_removal_ok:1;
 	u32			power_manageable:1;
 	u32			performance_manageable:1;
-	u32			reserved:21;
+	u32			wake_capable:1;	
+	u32			reserved:20;
 };
 
 
@@ -205,10 +206,8 @@
 	u32			explicit_get:1;		     /* _PSC present? */
 	u32			power_resources:1;	   /* Power resources */
 	u32			inrush_current:1;	  /* Serialize Dx->D0 */
-	u32			wake_capable:1;		 /* Wakeup supported? */
-	u32			wake_enabled:1;		/* Enabled for wakeup */
 	u32			power_removed:1;	   /* Optimize Dx->D0 */
-	u32			reserved:26;
+	u32			reserved:28;
 };
 
 struct acpi_device_power_state {
@@ -228,6 +227,14 @@
 	struct acpi_device_power_state states[4];     /* Power states (D0-D3) */
 };
 
+/* Wakeup Management */
+
+struct acpi_wakeup_power {
+	acpi_integer		gpe;
+	int			state;
+	acpi_integer		sleep_state;
+	struct acpi_handle_list	resources;
+};
 
 /* Performance Management */
 
@@ -261,10 +268,12 @@
 	struct list_head	children;
 	struct list_head	node;
 	struct list_head	g_list;
+	struct list_head	wakeup_list;
 	struct acpi_device_status status;
 	struct acpi_device_flags flags;
 	struct acpi_device_pnp	pnp;
 	struct acpi_device_power power;
+	struct acpi_wakeup_power wakeup_power;
 	struct acpi_device_perf	performance;
 	struct acpi_device_dir	dir;
 	struct acpi_device_ops	ops;

--cmJC7u66zC7hs+87--
