Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUIXXw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUIXXw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269060AbUIXXw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:52:57 -0400
Received: from fmr04.intel.com ([143.183.121.6]:29835 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269057AbUIXXsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:48:45 -0400
Date: Fri, 24 Sep 2004 16:48:38 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Len Brown <len.brown@intel.com>
Cc: Len Brown <len.brown@intel.com>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH-ACPI based CPU hotplug[5/6]-ACPI processor driver extension
Message-ID: <20040924164837.E27778@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094352.G14208@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040920094352.G14208@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Mon, Sep 20, 2004 at 09:43:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 09:43:52AM -0700, Keshavamurthy Anil S wrote:
> Changes form previous version
> 1) Added depends on EXPERIMENTAL in kconfig file
Changes from previous version
	Added prink for ACPI_NOTIFY_BUS_CHECK and for ACPI_NOTIFY_DEVICE_CHECK based on
the community feedback. 


---
Name:processor_drv.patch
Status:Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:	
Version: applies on 2.6.9-rc2	
Description:
Extends the processor driver to support ACPI based Physical CPU hotplug.

---

 include/linux/cpu.h                               |    0 
 kernel/cpu.c                                      |    0 
 linux-2.6.9-rc2-askeshav/drivers/acpi/Kconfig     |    8 
 linux-2.6.9-rc2-askeshav/drivers/acpi/processor.c |  485 ++++++++++++++++++----
 4 files changed, 424 insertions(+), 69 deletions(-)

diff -puN drivers/acpi/Kconfig~processor_drv drivers/acpi/Kconfig
--- linux-2.6.9-rc2/drivers/acpi/Kconfig~processor_drv	2004-09-24 15:26:30.480114232 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/Kconfig	2004-09-24 15:26:30.587536106 -0700
@@ -129,6 +129,14 @@ config ACPI_PROCESSOR
 	  ACPI C2 and C3 processor states to save power, on systems that
 	  support it.
 
+config ACPI_HOTPLUG_CPU
+	bool "Processor Hotplug (EXPERIMENTAL)"
+	depends on ACPI_PROCESSOR && HOTPLUG_CPU && EXPERIMENTAL
+	depends on !IA64_SGI_SN
+	default n
+	 ---help---
+	 Select this option if your platform support physical CPU hotplug.
+
 config ACPI_THERMAL
 	tristate "Thermal Zone"
 	depends on ACPI_PROCESSOR
diff -puN include/linux/cpu.h~processor_drv include/linux/cpu.h
diff -puN kernel/cpu.c~processor_drv kernel/cpu.c
diff -puN drivers/acpi/processor.c~processor_drv drivers/acpi/processor.c
--- linux-2.6.9-rc2/drivers/acpi/processor.c~processor_drv	2004-09-24 15:26:30.495739232 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/processor.c	2004-09-24 15:26:30.591442356 -0700
@@ -4,6 +4,8 @@
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
+ *  			- Added processor hotplug support
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -37,11 +39,13 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/cpu.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -69,10 +73,11 @@
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 
-
 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
 
+#define ACPI_STA_PRESENT 0x00000001
+
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME		("acpi_processor")
 
@@ -82,12 +87,16 @@ MODULE_LICENSE("GPL");
 
 
 static int acpi_processor_add (struct acpi_device *device);
+static int acpi_processor_start (struct acpi_device *device);
 static int acpi_processor_remove (struct acpi_device *device, int type);
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_power_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_get_limit_info(struct acpi_processor *pr);
+static void acpi_processor_notify ( acpi_handle	handle, u32 event, void *data);
+static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
+static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 static struct acpi_driver acpi_processor_driver = {
 	.name =		ACPI_PROCESSOR_DRIVER_NAME,
@@ -96,9 +105,12 @@ static struct acpi_driver acpi_processor
 	.ops =		{
 				.add =		acpi_processor_add,
 				.remove =	acpi_processor_remove,
+				.start	= 	acpi_processor_start,
 			},
 };
 
+#define INSTALL_NOTIFY_HANDLER		1
+#define UNINSTALL_NOTIFY_HANDLER	2
 
 struct acpi_processor_errata {
 	u8			smp;
@@ -2237,23 +2249,30 @@ acpi_processor_get_info (
 
 	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
 
-	if ( !cpu0_initialized && (cpu_index == 0xff)) {
-		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
-		cpu_index = 0;
-	} else if (cpu_index > num_online_cpus()) {
-		/*
-		 *  Extra Processor objects may be enumerated on MP systems with
-		 *  less than the max # of CPUs. They should be ignored.
-		 */
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			"Error getting cpuindex for acpiid 0x%x\n",
-			pr->acpi_id));
-		return_VALUE(-ENODEV);
-	}
-	cpu0_initialized = 1;
-
-	pr->id = cpu_index;
-
+  	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
+  	if ( !cpu0_initialized && (cpu_index == 0xff) &&
+  		       	(num_online_cpus() == 1)) {
+   		cpu_index = 0;
+   	}
+
+   	cpu0_initialized = 1;
+
+   	pr->id = cpu_index;
+
+  	/*
+  	 *  Extra Processor objects may be enumerated on MP systems with
+  	 *  less than the max # of CPUs. They should be ignored _iff
+  	 *  they are physically not present.
+  	 */
+   	if (cpu_index >=  NR_CPUS) {
+   		if (ACPI_FAILURE(acpi_processor_hotadd_init(pr->handle, &pr->id))) {
+   			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+   				"Error getting cpuindex for acpiid 0x%x\n",
+   				pr->acpi_id));
+   			return_VALUE(-ENODEV);
+   		}
+    	}
+ 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id, 
 		pr->acpi_id));
 
@@ -2292,6 +2311,65 @@ acpi_processor_get_info (
 }
 
 
+static int
+acpi_processor_start(
+	struct acpi_device	*device)
+{
+	int			result = 0;
+	acpi_status		status = AE_OK;
+	u32			i = 0;
+	struct acpi_processor	*pr;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_start");
+
+	pr = acpi_driver_data(device);
+
+	result = acpi_processor_get_info(pr);
+	if (result) {
+		/* Processor is physically not present */
+		return_VALUE(0);
+	}
+
+	BUG_ON((pr->id >= NR_CPUS) || (pr->id < 0));
+
+	processors[pr->id] = pr;
+
+	result = acpi_processor_add_fs(device);
+	if (result)
+		goto end;
+
+	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
+		acpi_processor_notify, pr);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error installing device notify handler\n"));
+	}
+
+	/*
+	 * Install the idle handler if processor power management is supported.
+	 * Note that the default idle handler (default_idle) will be used on
+	 * platforms that only support C1.
+	 */
+	if ((pr->id == 0) && (pr->flags.power)) {
+		pm_idle_save = pm_idle;
+		pm_idle = acpi_processor_idle;
+	}
+
+	printk(KERN_INFO PREFIX "%s [%s] (supports",
+		acpi_device_name(device), acpi_device_bid(device));
+	for (i=1; i<ACPI_C_STATE_COUNT; i++)
+		if (pr->power.states[i].valid)
+			printk(" C%d", i);
+	if (pr->flags.throttling)
+		printk(", %d throttling states", pr->throttling.state_count);
+	printk(")\n");
+end:
+
+	return_VALUE(result);
+}
+
+
+
 static void
 acpi_processor_notify (
 	acpi_handle		handle,
@@ -2333,10 +2411,7 @@ static int
 acpi_processor_add (
 	struct acpi_device	*device)
 {
-	int			result = 0;
-	acpi_status		status = AE_OK;
 	struct acpi_processor	*pr = NULL;
-	u32			i = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_add");
 
@@ -2353,51 +2428,7 @@ acpi_processor_add (
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	acpi_driver_data(device) = pr;
 
-	result = acpi_processor_get_info(pr);
-	if (result)
-		goto end;
-
-	result = acpi_processor_add_fs(device);
-	if (result)
-		goto end;
-
-	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY, 
-		acpi_processor_notify, pr);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
-			"Error installing notify handler\n"));
-		result = -ENODEV;
-		goto end;
-	}
-
-	processors[pr->id] = pr;
-
-	/*
-	 * Install the idle handler if processor power management is supported.
-	 * Note that the default idle handler (default_idle) will be used on 
-	 * platforms that only support C1.
-	 */
-	if ((pr->id == 0) && (pr->flags.power)) {
-		pm_idle_save = pm_idle;
-		pm_idle = acpi_processor_idle;
-	}
-	
-	printk(KERN_INFO PREFIX "%s [%s] (supports",
-		acpi_device_name(device), acpi_device_bid(device));
-	for (i=1; i<ACPI_C_STATE_COUNT; i++)
-		if (pr->power.states[i].valid)
-			printk(" C%d", i);
-	if (pr->flags.throttling)
-		printk(", %d throttling states", pr->throttling.state_count);
-	printk(")\n");
-
-end:
-	if (result) {
-		acpi_processor_remove_fs(device);
-		kfree(pr);
-	}
-
-	return_VALUE(result);
+	return_VALUE(0);
 }
 
 
@@ -2416,17 +2447,27 @@ acpi_processor_remove (
 
 	pr = (struct acpi_processor *) acpi_driver_data(device);
 
+	if (pr->id >= NR_CPUS) {
+		kfree(pr);
+		return_VALUE(0);
+	}
+
+	if (type == ACPI_BUS_REMOVAL_EJECT) {
+		if (acpi_processor_handle_eject(pr))
+			return_VALUE(-EINVAL);
+	}
+
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
 		synchronize_kernel();
 	}
 
-	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY, 
+	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 		acpi_processor_notify);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
-			"Error removing notify handler\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error removing device notify handler\n"));
 	}
 
 	acpi_processor_remove_fs(device);
@@ -2439,6 +2480,308 @@ acpi_processor_remove (
 }
 
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/****************************************************************************
+ * 	Acpi processor hotplug support 				       	    *
+ ****************************************************************************/
+
+static int is_processor_present(acpi_handle handle);
+
+static int
+processor_run_sbin_hotplug(struct acpi_device *device,
+	       int cpu, char *action)
+{
+	char *argv[3], *envp[7], action_str[32], cpu_str[15];
+	int i, ret;
+	int len;
+	char pathname[ACPI_PATHNAME_MAX] = {0};
+	acpi_status status;
+	char *processor_str;
+	struct acpi_buffer buffer = {ACPI_PATHNAME_MAX, pathname};
+
+	ACPI_FUNCTION_TRACE("processor_run_sbin_hotplug");
+
+
+	status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		return(-ENODEV);
+	}
+
+	len = strlen("PROCESSOR=") + strlen(pathname) + 1;
+	processor_str = kmalloc(len, GFP_KERNEL);
+	if (!processor_str)
+		return(-ENOMEM);
+
+	sprintf(processor_str, "PROCESSOR=%s",pathname);
+	sprintf(action_str, "ACTION=%s", action);
+	sprintf(cpu_str, "CPU=%d", cpu);
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "cpu";
+	argv[i] = NULL;
+
+	i = 0;
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
+	envp[i++] = action_str;
+	envp[i++] = processor_str;
+	envp[i++] = cpu_str;
+	envp[i++] = "PLATFORM=ACPI";
+	envp[i] = NULL;
+
+	ret = call_usermodehelper(argv[0], argv, envp, 0);
+
+	kfree(processor_str);
+	return_VALUE(ret);
+}
+
+
+static int
+is_processor_present(
+	acpi_handle handle)
+{
+	acpi_status 		status;
+	unsigned long		sta = 0;
+
+	ACPI_FUNCTION_TRACE("is_processor_present");
+
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Processor Device is not present\n"));
+		return_VALUE(0);
+	}
+	return_VALUE(1);
+}
+
+
+static
+int acpi_processor_device_add(
+	acpi_handle	handle,
+	struct acpi_device **device)
+{
+	acpi_handle		phandle;
+	struct acpi_device 	*pdev;
+	struct acpi_processor	*pr;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_device_add");
+
+	if (acpi_get_parent(handle, &phandle)) {
+		return_VALUE(-ENODEV);
+	}
+
+	if (acpi_bus_get_device(phandle, &pdev)) {
+		return_VALUE(-ENODEV);
+	}
+
+	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_PROCESSOR)) {
+		return_VALUE(-ENODEV);
+	}
+
+	acpi_bus_scan(*device);
+
+	pr = acpi_driver_data(*device);
+	if (!pr)
+		return_VALUE(-ENODEV);
+
+	if ((pr->id >=0) && (pr->id < NR_CPUS)) {
+		processor_run_sbin_hotplug(*device, pr->id, "add");
+	}
+	return_VALUE(0);
+}
+
+
+static void
+acpi_processor_hotplug_notify (
+	acpi_handle		handle,
+	u32			event,
+	void			*data)
+{
+	struct acpi_processor	*pr;
+	struct acpi_device	*device = NULL;
+	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_hotplug_notify");
+
+	switch (event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		printk("Processor driver received %s event\n",
+			(event==ACPI_NOTIFY_BUS_CHECK)?
+			"ACPI_NOTIFY_BUS_CHECK":"ACPI_NOTIFY_DEVICE_CHECK");
+
+		if (!is_processor_present(handle))
+			break;
+
+		if (acpi_bus_get_device(handle, &device)) {
+			result = acpi_processor_device_add(handle, &device);
+			if (result)
+				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					"Unable to add the device\n"));
+			break;
+		}
+
+		pr = acpi_driver_data(device);
+		if (!pr) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Driver data is NULL\n"));
+			break;
+		}
+		
+		if (pr->id >= 0 && (pr->id < NR_CPUS)) {
+			processor_run_sbin_hotplug(device, pr->id, "remove");
+			break;
+		}
+
+		result = acpi_processor_start(device);
+		if ((!result) && ((pr->id >=0) && (pr->id < NR_CPUS))) {
+			processor_run_sbin_hotplug(device, pr->id, "add");
+		} else {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Device [%s] failed to start\n",
+				acpi_device_bid(device)));
+		}
+	break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"received ACPI_NOTIFY_EJECT_REQUEST\n"));
+
+		if (acpi_bus_get_device(handle, &device)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"Device don't exist, dropping EJECT\n"));
+			break;
+		}
+		pr = acpi_driver_data(device);
+		if (!pr) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"Driver data is NULL, dropping EJECT\n"));
+			return_VOID;
+		}
+
+		if ((pr->id < NR_CPUS) && (cpu_present(pr->id)))
+			processor_run_sbin_hotplug(device, pr->id, "remove");
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	return_VOID;
+}
+
+static acpi_status
+processor_walk_namespace_cb(acpi_handle handle,
+	u32 lvl,
+	void *context,
+	void **rv)
+{
+	acpi_status 			status;
+	int *action = context;
+	acpi_object_type	type = 0;
+
+	status = acpi_get_type(handle, &type);
+	if (ACPI_FAILURE(status))
+		return(AE_OK);
+
+	if (type != ACPI_TYPE_PROCESSOR)
+		return(AE_OK);
+
+	switch(*action) {
+	case INSTALL_NOTIFY_HANDLER:
+		acpi_install_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY,
+			acpi_processor_hotplug_notify,
+			NULL);
+		break;
+	case UNINSTALL_NOTIFY_HANDLER:
+		acpi_remove_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY,
+			acpi_processor_hotplug_notify);
+		break;
+	default:
+		break;
+	}
+
+	return(AE_OK);
+}
+
+
+static acpi_status
+acpi_processor_hotadd_init(
+	acpi_handle		handle,
+	int			*p_cpu)
+{
+	ACPI_FUNCTION_TRACE("acpi_processor_hotadd_init");
+	
+	if (!is_processor_present(handle)) {
+		return_VALUE(AE_ERROR);
+	}
+
+	if (acpi_map_lsapic(handle, p_cpu))
+		return_VALUE(AE_ERROR);
+
+	if (arch_register_cpu(*p_cpu)) {
+		acpi_unmap_lsapic(*p_cpu);
+		return_VALUE(AE_ERROR);
+	}
+
+	return_VALUE(AE_OK);
+}
+
+
+static int
+acpi_processor_handle_eject(struct acpi_processor *pr)
+{
+	if (cpu_online(pr->id)) {
+		return(-EINVAL);
+	}
+	arch_unregister_cpu(pr->id);
+	acpi_unmap_lsapic(pr->id);
+	return(0);
+}
+#else
+static acpi_status
+acpi_processor_hotadd_init(
+	acpi_handle		handle,
+	int			*p_cpu)
+{
+	return AE_ERROR;
+}
+static int
+acpi_processor_handle_eject(struct acpi_processor *pr)
+{
+	return(-EINVAL);
+}
+#endif
+
+
+static
+void acpi_processor_install_hotplug_notify(void)
+{
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+	int action = INSTALL_NOTIFY_HANDLER;
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+				     ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     processor_walk_namespace_cb,
+				     &action, NULL);
+#endif
+}
+
+
+static
+void acpi_processor_uninstall_hotplug_notify(void)
+{
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+	int action = UNINSTALL_NOTIFY_HANDLER;
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+				     ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     processor_walk_namespace_cb,
+				     &action, NULL);
+#endif
+}
+
+
 static int __init
 acpi_processor_init (void)
 {
@@ -2460,6 +2803,8 @@ acpi_processor_init (void)
 		return_VALUE(-ENODEV);
 	}
 
+	acpi_processor_install_hotplug_notify();
+
 	acpi_thermal_cpufreq_init();
 
 	acpi_processor_ppc_init();
@@ -2477,6 +2822,8 @@ acpi_processor_exit (void)
 
 	acpi_thermal_cpufreq_exit();
 
+	acpi_processor_uninstall_hotplug_notify();
+
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
_

