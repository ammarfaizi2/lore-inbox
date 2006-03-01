Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbWB1XYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWB1XYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWB1XYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:36 -0500
Received: from fmr21.intel.com ([143.183.121.13]:5591 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932721AbWB1XYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:20 -0500
Message-Id: <20060301001723.071101000@araj-sfield>
References: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:16:02 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Len Brown <len.brown@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 5/5] Enable SCI_EMULATE to manually simulate physical hotplug testing.
Content-Disposition: inline; filename=sci_emu.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: Not for mainline inclusion, required only for testing purposes]

Emulate an ACPI SCI interrupt to emulate a hot-plug event. Useful
for testing ACPI based hot-plug on systems that don't have the
necessary firmware support.

Enable CONFIG_ACPI_SCI_EMULATE on kernel compile.

Now you will notice /proc/acpi/sci/notify when new kernel is booted.

echo "\_SB.CPU4 1" > /proc/acpi/sci/notify to trigger a hot-add of CPU4.

You will now notice an entry /sys/firmware/acpi/namespace/ACPI/_SB/CPU4
if the namespace had an entry CPU4 under _SB scope. If the entry had a 
_EJ0 method, you will also notice a file "eject" under the CPU4 directory.

How to test physical cpu hotplug?

0. You need a ACPI based MP platform to perform tne test.

1. Get a dump of DSDT that you will modify to emulate CPU hotplug.
   #acpidump -t DSDT -b -o DSDT

2. Disassemble it, so you can modify the output.

   #iasl -d DSDT

   This will create DSDT.dsl

3. Locate Scope _SB to add your new processor entries as below.

        Processor (CPU4, 0x05, 0x00000, 0x00) {
                Name(_HID,EISAID("INT0000"))
                Name(_UID,5)
                Name (L0st,0)
                Method(_STA,0,NotSerialized) {
                        If ( LEqual(L0st,1) ) {
                                Return (0x0f)
                        } else {
                                Return (0x00)
                        }
                }
                Method(_PXM) {
                        Return(0)
                }
                Method(_PS0,0,NotSerialized) {
                        Store(1,L0st)
                }
                Method(_PS3,0,NotSerialized) {
                        Store(0,L0st)
                }
                Method(_EJ0,1,NotSerialized) {
                        Store(0,L0st)
                }
                Method (_MAT) {
                        Name(MAT,Buffer() {
                        0x00,           //Local APIC
                        0x08,           //Length
                        0x05,           //ACPI Processor ID
                        0xC2,           //Local APIC ID
                        0x01,           //Enabled
                        0x00,
                        0x00,
                        0x00
                        })
                        Return (MAT)
                }

4. Now compile and generate a hex file for inclusion
   #iasl -tc DSDT.dsl

   This will produce a file DSDT.hex which you will include in your kernel 
   kernel.

5. Rename it to some .h file for convenience.

You need to set CONFIG_STANDALONE=y

it will ask you custom dsdt file name, put that file in drivers/acpi
and provide that name when you do a 
#make oldconfig.

6. Compile and boot your new kernel with limit_cpus=xxx

follow steps above to fake the notify for add, and remove cpu.

Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------------
 drivers/acpi/Kconfig          |   10 +++
 drivers/acpi/bus.c            |  138 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/processor_core.c |   21 +++++-
 drivers/acpi/scan.c           |   35 ++++++++++
 4 files changed, 199 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc4-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.16-rc4-mm1.orig/drivers/acpi/Kconfig
+++ linux-2.6.16-rc4-mm1/drivers/acpi/Kconfig
@@ -333,4 +333,14 @@ config ACPI_HOTPLUG_MEMORY
 		$>modprobe acpi_memhotplug 
 endif	# ACPI
 
+config ACPI_SCI_EMULATE
+	bool "ACPI SCI Event Emulation Support"
+	depends on ACPI
+	default n
+	help
+	  This will enable your system to emulate sci hotplug event
+	  notification through proc file system. For example user needs to
+	  echo "XXX 0" > /proc/acpi/sci/notify (where, XXX is a target ACPI
+	  device object name present under \_SB scope).
+
 endmenu
Index: linux-2.6.16-rc4-mm1/drivers/acpi/bus.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/drivers/acpi/bus.c
+++ linux-2.6.16-rc4-mm1/drivers/acpi/bus.c
@@ -37,6 +37,22 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#ifdef CONFIG_ACPI_SCI_EMULATE
+#include <acpi/acpi.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acevents.h>
+#include <acpi/acinterp.h>
+
+static int acpi_init_sci_emulate(void);
+static void acpi_sci_notify_client(char *acpi_name, u32 event);
+static int acpi_sci_notify_write_proc(struct file *file, const char *buffer, \
+	unsigned long count, void *data);
+struct proc_dir_entry 		*acpi_sci_dir;
+
+#else
+#define acpi_init_sci_emulate()
+#endif
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("acpi_bus")
 #ifdef	CONFIG_X86
@@ -725,6 +741,8 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
+	acpi_init_sci_emulate();
+
 	return_VALUE(0);
 
 	/* Mimic structured exception handling */
@@ -770,3 +788,123 @@ static int __init acpi_init(void)
 }
 
 subsys_initcall(acpi_init);
+
+#ifdef CONFIG_ACPI_SCI_EMULATE
+/******  Code to emulate SCI interrupt for Hotplug node insertion/removal ******/
+
+static int acpi_sci_notify_write_proc(struct file *file, const char *buffer,
+				      unsigned long count, void *data)
+{
+	u32 event;
+	char *name1 = NULL;
+	char *name2 = NULL;
+	char *end_name = NULL;
+	const char *delim = " ";
+	char *temp_buf = NULL;
+	char *temp_buf_addr = NULL;
+
+	temp_buf = kmalloc(count+1, GFP_ATOMIC);
+	if (!temp_buf) {
+		printk(KERN_WARNING PREFIX "acpi_sci_notify_wire_proc: Memory allocation failed\n");
+		return count;
+	}
+	temp_buf[count] = '\0';
+	temp_buf_addr = temp_buf;
+	memcpy(temp_buf, buffer, count);
+	name1 = strsep(&temp_buf, delim);
+	name2 = strsep(&temp_buf, delim);
+
+	if(name1 && name2)
+		event = simple_strtoul(name2, &end_name, 10);
+	else {
+		printk(KERN_WARNING PREFIX "unknown device\n");
+		kfree(temp_buf_addr);
+		return count;
+	}
+
+	printk(KERN_INFO PREFIX "ACPI device name is <%s>, event code is <%d>\n",\
+	       name1, event);
+
+	acpi_sci_notify_client(name1, event);
+
+	kfree(temp_buf_addr);
+
+	return count;
+}
+
+static void acpi_sci_notify_client(char *acpi_name, u32 event)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status, status1;
+	acpi_handle hlsb, hsb;
+	union acpi_operand_object *obj_desc;
+
+	status = acpi_get_handle(NULL, "\\_SB", &hsb);
+	status1 = acpi_get_handle(hsb, acpi_name, &hlsb);
+	if(ACPI_FAILURE(status) || ACPI_FAILURE(status1)){
+		printk(KERN_ERR PREFIX  "acpi getting handle to <\\_SB.%s> failed inside notify_client\n", \
+			acpi_name);
+		return;
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if(ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Acquiring acpi namespace mutext failed\n");
+		return;
+	}
+
+	node = acpi_ns_map_handle_to_node(hlsb);
+	if(!node) {
+		(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
+		printk(KERN_ERR PREFIX "Mapping handle to node failed\n");
+		return;
+	}
+
+	/* Check for internal object and make sure there is a handler registered for this object */
+
+	obj_desc = acpi_ns_get_attached_object (node);
+	if(obj_desc) {
+		if(obj_desc->common_notify.system_notify){
+			/* Release the lock and queue the item for later exectuion */
+			(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
+			status = acpi_ev_queue_notify_request(node, event);
+			if(ACPI_FAILURE(status)){
+				printk(KERN_ERR PREFIX "acpi_ev_queue_notify_request failed\n");
+			}else {
+				printk(KERN_INFO PREFIX "Notify event is queued\n");
+			}
+			return;
+		}
+	}else {
+		printk(KERN_INFO PREFIX "Notify handler not registered for this device\n");
+	}
+
+
+	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
+	return;
+}
+
+
+static int acpi_init_sci_emulate(void)
+{
+	struct proc_dir_entry   *notify_entry = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_init_sci_emulate");
+
+	acpi_sci_dir = proc_mkdir("sci", acpi_root_dir);
+	if (!acpi_sci_dir)
+		return_VALUE(-ENODEV);
+
+	notify_entry = create_proc_entry("notify", \
+		S_IWUGO|S_IRUGO, acpi_sci_dir);
+	if (!notify_entry) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create '%s' fs entry\n", "notify"));
+	} else {
+		notify_entry->write_proc = acpi_sci_notify_write_proc;
+		notify_entry->data = NULL;
+	}
+
+	return_VALUE(0);
+}
+#endif
Index: linux-2.6.16-rc4-mm1/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16-rc4-mm1/drivers/acpi/processor_core.c
@@ -549,12 +549,14 @@ static int acpi_processor_start(struct a
 	 * ACPI id of processors can be reported wrongly by the BIOS.
 	 * Don't trust it blindly
 	 */
+#ifndef CONFIG_ACPI_SCI_EMULATE
 	if (processor_device_array[pr->id] != NULL &&
 	    processor_device_array[pr->id] != (void *)device) {
 		ACPI_WARNING((AE_INFO, "BIOS reporting wrong ACPI id"
 			    "for the processor"));
 		return_VALUE(-ENODEV);
 	}
+#endif
 	processor_device_array[pr->id] = (void *)device;
 
 	processors[pr->id] = pr;
@@ -678,9 +680,6 @@ static int acpi_processor_remove(struct 
 /****************************************************************************
  * 	Acpi processor hotplug support 				       	    *
  ****************************************************************************/
-
-static int is_processor_present(acpi_handle handle);
-
 static int is_processor_present(acpi_handle handle)
 {
 	acpi_status status;
@@ -734,7 +733,10 @@ acpi_processor_hotplug_notify(acpi_handl
 {
 	struct acpi_processor *pr;
 	struct acpi_device *device = NULL;
-	int result;
+	int result = 0;
+#ifdef CONFIG_ACPI_SCI_EMULATE
+	extern int is_PSX_present(acpi_handle handle, int number);
+#endif
 
 	ACPI_FUNCTION_TRACE("acpi_processor_hotplug_notify");
 
@@ -745,6 +747,16 @@ acpi_processor_hotplug_notify(acpi_handl
 		       (event == ACPI_NOTIFY_BUS_CHECK) ?
 		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
 
+#ifdef CONFIG_ACPI_SCI_EMULATE
+		/*
+		 * Evaluate _PS0 to make _STA return Present Status
+		 */
+		if (is_PSX_present(handle, 0))
+			result = acpi_evaluate_object(handle, "_PS0", NULL, NULL);
+		if (ACPI_SUCCESS(result)) {
+			printk ("Called method _PS0, _STA should return Present\n");
+		}
+#endif
 		if (!is_processor_present(handle))
 			break;
 
@@ -865,6 +877,7 @@ static int acpi_processor_handle_eject(s
 	acpi_unmap_lsapic(pr->id);
 	return (0);
 }
+
 #else
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
 {
Index: linux-2.6.16-rc4-mm1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/drivers/acpi/scan.c
+++ linux-2.6.16-rc4-mm1/drivers/acpi/scan.c
@@ -371,15 +371,48 @@ setup_sys_fs_device_files(struct acpi_de
 		(*(func)) (&dev->kobj, &acpi_device_attr_eject.attr);
 }
 
+#ifdef CONFIG_ACPI_SCI_EMULATE
+int is_PSX_present(acpi_handle handle, int number)
+{
+	acpi_status status = AE_OK;
+	acpi_handle temp = NULL;
+
+	ACPI_FUNCTION_TRACE("is_PSX_present");
+
+	switch (number) {
+	case 0:
+		status = acpi_get_handle(handle, "_PS0", &temp);
+		break;
+	case 3:
+		status = acpi_get_handle(handle, "_PS3", &temp);
+		break;
+	}
+
+	if (ACPI_SUCCESS(status)) {
+		printk ("Found _PS%d in Processor Scope\n", number);
+		return_VALUE(1);
+	}
+	else
+		return_VALUE(0);
+}
+#endif
+
 static int acpi_eject_operation(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
 
+#ifdef CONFIG_ACPI_SCI_EMULATE
 	/*
-	 * TBD: evaluate _PS3?
+	 * evaluate _PS3 to make _STA return Not-Present.
 	 */
+	if (is_PSX_present(handle, 3))
+		status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
+	if (ACPI_SUCCESS(status)) {
+		printk ("Called method _PS3, _STA should return Not-Present\n");
+	}
+#endif
 
 	if (lockable) {
 		arg_list.count = 1;

--

