Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDQUCN>; Tue, 17 Apr 2001 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRDQUCK>; Tue, 17 Apr 2001 16:02:10 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:10756 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132570AbRDQUB2>;
	Tue, 17 Apr 2001 16:01:28 -0400
Message-ID: <20010417215459.E341@bug.ucw.cz>
Date: Tue, 17 Apr 2001 21:54:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE847@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE847@orsmsx35.jf.intel.com>; from Grover, Andrew on Tue, Apr 17, 2001 at 09:45:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy!

> > > I would think that it would make sense to keep shutdown 
> > with all the other
> > > power management events. Perhaps it will makes more sense 
> > to handle UPS's
> > > through the power management code.
> > 
> > Yes, that would be another acceptable solution. Situation where half
> > of power managment (UPS) is done with init and half with acpid is not
> > acceptable. [I doubt UPS users will want to switch. Why invent new
> > daemon when init is doing perfect job?]
> 
> I think init is doing a perfect job WRT UPSs because this is a trivial
> application of power management. init wasn't really meant for this.
> According to its man page:
> 
> "init...it's primary role is to create processes from a script in the file
> /etc/inittab...It also controls autonomous processes required by any
> particular system"
> 
> We are going to need some software that handles button events, as well as
> thermal events, battery events, polling the battery, AC adapter status
> changes, sleeping the system, and more.

I do not want to put battery/thermal/AC adapter status through
init. On *many* machines, button is only usefull device from ACPI (for
example all desktop machines). On desktop machine, you probably will
not want to configure/run acpid. Init should be able to do its job.

I agree that for notebooks where you want to handle thermal events
etc., acpid will be neccessary. I just do not want desktop people to
be forced to run acpid.

> We need WAY more flexibility than init provides. I find the argument that
> init is already handling one minor power-related thing an unconvincing
> reason why we should cram all power management through it.

It is doing UPS and c-a-d handling, which is *very* similar to what
you want to do on power button press 99% of time.
								Pavel
PS: About thermal events -- do I need to do something special in order
for temperature to be measured?

I can send _TMP, and get temperature reading, but it does not change
with time -- I get the same value from boot on.

BTW here are hacks I use for easy control of ACPI. That way, I can
just for A in device_*; do echo -n '_TMP' > $A; done and get
temperature reading in syslog ;-).

Do you think some way to reflect acpi structure in proc would be good
idea?

diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/common/cmeval.c linux/drivers/acpi/common/cmeval.c
--- clean/drivers/acpi/common/cmeval.c	Wed Jan 31 16:14:27 2001
+++ linux/drivers/acpi/common/cmeval.c	Fri Apr  6 08:45:21 2001
@@ -262,9 +262,10 @@
  ***************************************************************************/
 
 ACPI_STATUS
-acpi_cm_execute_STA (
+acpi_cm_execute_rint (
 	ACPI_NAMESPACE_NODE     *device_node,
-	u32                     *flags)
+	u32                     *flags,
+	char			*name)
 {
 	ACPI_OPERAND_OBJECT     *obj_desc;
 	ACPI_STATUS             status;
@@ -273,14 +274,12 @@
 	/* Execute the method */
 
 	status = acpi_ns_evaluate_relative (device_node,
-			 METHOD_NAME__STA, NULL, &obj_desc);
-	if (AE_NOT_FOUND == status) {
-		*flags = 0x0F;
-		status = AE_OK;
-	}
-
+			 name, NULL, &obj_desc);
+	if (ACPI_FAILURE (status))
+		return (status);
 
-	else /* success */ {
+	/* I guess it used to be subtle bug here, on AE_NOT_FOUND, it did cm_remove_reference, anyway */
+	{
 		/* Did we get a return object? */
 
 		if (!obj_desc) {
@@ -306,3 +305,71 @@
 
 	return (status);
 }
+
+
+ACPI_STATUS
+acpi_cm_execute_STA (
+	ACPI_NAMESPACE_NODE     *device_node,
+	u32                     *flags)
+{
+	ACPI_STATUS             status;
+
+	status = acpi_cm_execute_rint(device_node, flags, "_STA");
+	if (status == AE_NOT_FOUND) {
+		*flags = 0x0F;
+		return AE_OK;
+	}
+	return status;
+}
+
+
+ACPI_STATUS
+acpi_cm_execute_any (
+	ACPI_NAMESPACE_NODE     *device_node,
+	char                    *res,
+	char			*name)
+{
+	ACPI_OPERAND_OBJECT     *obj_desc;
+	ACPI_STATUS             status;
+
+
+	/* Execute the method */
+
+	status = acpi_ns_evaluate_relative (device_node,
+			 name, NULL, &obj_desc);
+	sprintf(res, "error");
+	if (ACPI_FAILURE (status))
+		return (status);
+
+	/* I guess it used to be subtle bug here, on AE_NOT_FOUND, it did cm_remove_reference, anyway */
+	{
+		/* Did we get a return object? */
+
+		if (!obj_desc) {
+			sprintf(res, "no return");
+			return (AE_OK);
+		}
+
+		/* Is the return object of the correct type? */
+
+		switch (obj_desc->common.type) {
+		case ACPI_TYPE_INTEGER:
+			sprintf(res, "int: %d", obj_desc->integer.value);
+			break;
+		case ACPI_TYPE_STRING:
+			sprintf(res, "string: %20s", obj_desc->string.pointer);
+			break;
+		deafult:
+			sprintf(res, "unknown", obj_desc->string.pointer);
+			break;
+		}
+
+		/* On exit, we must delete the return object */
+
+		acpi_cm_remove_reference (obj_desc);
+	}
+
+	return (status);
+}
+
+
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/events/evevent.c linux/drivers/acpi/events/evevent.c
--- clean/drivers/acpi/events/evevent.c	Sun Apr  1 00:22:57 2001
+++ linux/drivers/acpi/events/evevent.c	Wed Apr  4 01:08:11 2001
@@ -30,6 +30,8 @@
 #include "acnamesp.h"
 #include "accommon.h"
 
+#include <linux/signal.h>
+
 #define _COMPONENT          EVENT_HANDLING
 	 MODULE_NAME         ("evevent")
 
@@ -49,25 +51,15 @@
  *************************************************************************/
 
 ACPI_STATUS
-acpi_ev_initialize (
-	void)
+acpi_ev_initialize (void)
 {
 	ACPI_STATUS             status;
 
-
-	/* Make sure we have ACPI tables */
-
-	if (!acpi_gbl_DSDT) {
+	if (!acpi_gbl_DSDT)		 	/* Make sure we have ACPI tables */
 		return (AE_NO_ACPI_TABLES);
-	}
-
-
-	/* Make sure the BIOS supports ACPI mode */
 
-	if (SYS_MODE_LEGACY == acpi_hw_get_mode_capabilities()) {
+	if (SYS_MODE_LEGACY == acpi_hw_get_mode_capabilities())	/* Make sure the BIOS supports ACPI mode */
 		return (AE_ERROR);
-	}
-
 
 	acpi_gbl_original_mode = acpi_hw_get_mode();
 
@@ -77,38 +69,18 @@
 	 * before handers are installed.
 	 */
 
-	status = acpi_ev_fixed_event_initialize ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_fixed_event_initialize ()))
 		return (status);
-	}
-
-	status = acpi_ev_gpe_initialize ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_gpe_initialize ()))
 		return (status);
-	}
-
-	/* Install the SCI handler */
-
-	status = acpi_ev_install_sci_handler ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_install_sci_handler ()))
 		return (status);
-	}
-
-
 	/* Install handlers for control method GPE handlers (_Lxx, _Exx) */
-
-	status = acpi_ev_init_gpe_control_methods ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_init_gpe_control_methods ()))
 		return (status);
-	}
-
 	/* Install the handler for the Global Lock */
-
-	status = acpi_ev_init_global_lock_handler ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_init_global_lock_handler ()))
 		return (status);
-	}
-
 
 	return (status);
 }
@@ -131,6 +103,7 @@
 {
 	int                     i = 0;
 
+	printk("acpi: Initializing fixed events\n");
 	/* Initialize the structure that keeps track of fixed event handlers */
 
 	for (i = 0; i < NUM_FIXED_EVENTS; i++) {
@@ -181,6 +154,7 @@
 	if ((status_register & ACPI_STATUS_PMTIMER) &&
 		(enable_register & ACPI_ENABLE_PMTIMER))
 	{
+		printk ("acpi: PM timer!\n");
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_PMTIMER);
 	}
 
@@ -189,22 +163,27 @@
 	if ((status_register & ACPI_STATUS_GLOBAL) &&
 		(enable_register & ACPI_ENABLE_GLOBAL))
 	{
+		printk ("acpi: BIOS wants to play!\n");
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_GLOBAL);
 	}
 
 	/* power button event */
 
 	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
-		(enable_register & ACPI_ENABLE_POWER_BUTTON))
+	    (enable_register & ACPI_ENABLE_POWER_BUTTON))
 	{
+		printk ("acpi: Power button pressed!\n");
+		kill_proc (1, SIGTERM, 1);
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_POWER_BUTTON);
 	}
 
+
 	/* sleep button event */
 
 	if ((status_register & ACPI_STATUS_SLEEP_BUTTON) &&
 		(enable_register & ACPI_ENABLE_SLEEP_BUTTON))
 	{
+		printk("acpi: Sleep button pressed!\n");
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_SLEEP_BUTTON);
 	}
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/hardware/hwsleep.c linux/drivers/acpi/hardware/hwsleep.c
--- clean/drivers/acpi/hardware/hwsleep.c	Sun Apr  1 00:22:57 2001
+++ linux/drivers/acpi/hardware/hwsleep.c	Wed Apr  4 00:11:19 2001
@@ -27,6 +27,7 @@
 #include "acpi.h"
 #include "acnamesp.h"
 #include "achware.h"
+#include <linux/delay.h>
 
 #define _COMPONENT          HARDWARE
 	 MODULE_NAME         ("hwsleep")
@@ -50,7 +51,6 @@
 	ACPI_PHYSICAL_ADDRESS physical_address)
 {
 
-
 	/* Make sure that we have an FACS */
 
 	if (!acpi_gbl_FACS) {
@@ -59,6 +59,8 @@
 
 	/* Set the vector */
 
+	printk("Setting waking_vector to %lx\n", physical_address);
+
 	if (acpi_gbl_FACS->vector_width == 32) {
 		* (u32 *) acpi_gbl_FACS->firmware_waking_vector = (u32) physical_address;
 	}
@@ -112,6 +114,12 @@
 	return (AE_OK);
 }
 
+void
+while1(void)
+{
+	while(1);
+}
+
 /******************************************************************************
  *
  * FUNCTION:    Acpi_enter_sleep_state
@@ -136,6 +144,13 @@
 	u16 PM1_acontrol;
 	u16 PM1_bcontrol;
 
+/*
+	acpi_set_firmware_waking_vector(0xffff0);
+*/
+	acpi_set_firmware_waking_vector(&while1 - 0xc0000000);
+
+	printk("Entering power state %d\n", sleep_state);
+
 	/*
 	 * _PSW methods could be run here to enable wake-on keyboard, LAN, etc.
 	 */
@@ -175,14 +190,23 @@
 	PM1_acontrol |= (type_a << acpi_hw_get_bit_shift (SLP_TYPE_X_MASK));
 	PM1_bcontrol |= (type_b << acpi_hw_get_bit_shift (SLP_TYPE_X_MASK));
 
-	disable();
+	/*disable();*/
 
+	printk("hwsleep: Writing registers\n");
 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
+	printk("hwsleep: enabling sleep!\n");
 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,
 		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));
+	printk("hwsleep: before enable\n");
 
-	enable();
+	/*enable();*/
+	printk("hwsleep: after enable\n");
 
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	acpi_evaluate_object(NULL, "\\_WAK", &arg_list, NULL);
+	printk("hwsleep: Waked up?\n");
+	mdelay(1000);
 	return (AE_OK);
 }
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/namespace/nsxfobj.c linux/drivers/acpi/namespace/nsxfobj.c
--- clean/drivers/acpi/namespace/nsxfobj.c	Sun Apr  1 00:23:00 2001
+++ linux/drivers/acpi/namespace/nsxfobj.c	Tue Apr 10 00:19:01 2001
@@ -30,6 +30,10 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 
 #define _COMPONENT          NAMESPACE
 	 MODULE_NAME         ("nsxfobj")
@@ -592,7 +596,7 @@
 
 	status = acpi_cm_execute_STA (node, &flags);
 	if (ACPI_FAILURE (status)) {
-		return (status);
+		return AE_OK;
 	}
 
 	if (!(flags & 0x01)) {
@@ -694,3 +698,203 @@
 
 	return (status);
 }
+
+static int
+proc_read_device_info(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	ACPI_HANDLE             obj_handle = (u32) data;
+	ACPI_NAMESPACE_NODE     *node;
+	ACPI_STATUS		status;
+	char *p = page;
+	int len;
+	u32 flags;
+	DEVICE_ID               device_id;
+
+	/* don't get info more than once for a single proc read */
+	if (off != 0)
+		goto end;
+
+	acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);
+
+	node = acpi_ns_convert_handle_to_entry (obj_handle);
+
+	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
+	status = acpi_cm_execute_STA (node, &flags);
+	if (ACPI_FAILURE (status))
+		p += sprintf(p, "Present:	No (%lx)\n", status);
+	else	p += sprintf(p, "Present:	Yes (flags %lx)\n", flags);
+
+	status = acpi_cm_execute_HID (node, &device_id);
+	if (!ACPI_FAILURE (status))
+		p += sprintf(p, "HID ident:	%s\n", &device_id.buffer );
+
+	status = acpi_cm_execute_UID (node, &device_id);
+	if (!ACPI_FAILURE (status))
+		p += sprintf(p, "UID ident:	%s\n", &device_id.buffer );
+
+	flags = 0xdeadbeef;
+	status = acpi_cm_execute_rint (node, &flags, "_PSC");
+	if (!ACPI_FAILURE (status))
+		p += sprintf(p, "Power status:	%d\n", flags);
+
+	p += sprintf(p, "This is some random information\n");
+end:
+	len = (p - page);
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+int
+proc_write_device_info(struct file *file, const char *buffer,
+		       unsigned long count, void *data)
+{
+	ACPI_HANDLE             obj_handle = (u32) data;
+	ACPI_NAMESPACE_NODE     *node;
+	ACPI_STATUS		status;
+	int len;
+	u32 flags;
+	char buf[256], buf2[256];
+	DEVICE_ID               device_id;
+
+	acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);
+
+	node = acpi_ns_convert_handle_to_entry (obj_handle);
+
+	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
+	if (count > 250)
+		return -EPERM;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+	buf[count] = 0;
+	printk("acpi_write_device_info: %s...", buf);
+	flags = 0xdeadbeef;
+	status = acpi_cm_execute_any (node, buf2, buf);
+	if (ACPI_FAILURE (status))
+		printk("error: %lx (%s)\n", status, buf2);
+	else 
+		printk("okay: %lx (%s)\n", status, buf2);
+
+	return -EL3RST;
+}
+
+
+static ACPI_STATUS
+acpi_ns_add_proc_callback (
+	ACPI_HANDLE             obj_handle,
+	u32                     nesting_level,
+	void                    *context,
+	void                    **return_value)
+{
+	ACPI_STATUS             status;
+	ACPI_NAMESPACE_NODE     *node;
+	u32                     flags;
+	DEVICE_ID               device_id;
+	ACPI_GET_DEVICES_INFO   *info;
+
+
+	info = context;
+
+	acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);
+
+	printk("acpi_add_proc_callback: %lx\n", obj_handle);
+	node = acpi_ns_convert_handle_to_entry (obj_handle);
+
+	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
+	if (!node) {
+		printk("No node?!\n");
+		return (AE_BAD_PARAMETER);
+	}
+
+	/*
+	 * Run _STA to determine if device is present
+	 */
+
+#if 0
+	status = acpi_cm_execute_STA (node, &flags);
+	if (ACPI_FAILURE (status)) {
+		return (AE_OK);
+	}
+
+	if (!(flags & 0x01)) {
+		/* don't return at the device or children of the device if not there */
+
+		return (AE_CTRL_DEPTH);
+	}
+#endif
+
+	{
+		char proc_name[120];
+		struct proc_dir_entry *proc;
+
+		status = acpi_cm_execute_HID (node, &device_id);
+
+		if ((status == AE_NOT_FOUND) || (ACPI_FAILURE (status)))
+			sprintf(proc_name, "power/device_unknown_%lx", obj_handle);
+		else	sprintf(proc_name, "power/device_%s", device_id.buffer );
+		printk("ACPI: creating %s\n", proc_name);
+		proc = create_proc_read_entry(proc_name, 0, NULL,
+			proc_read_device_info, (void *) obj_handle);
+		if (!proc) printk(KERN_ERR "ACPI: Error creating %s\n", proc_name);
+		else {
+			proc->write_proc = proc_write_device_info;
+		}
+	}
+
+	return (AE_OK);
+}
+
+
+void
+acpi_namespace_init(
+	void)
+{
+	ACPI_STATUS             status;
+	void ** return_value;
+
+	printk("ACPI: initializing namespace\n");
+
+	acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);
+	status = acpi_ns_walk_namespace (ACPI_TYPE_ANY,
+			   ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+			   NS_WALK_UNLOCK,
+			   acpi_ns_add_proc_callback, NULL,
+			   return_value);
+
+	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
+	return (status);
+}
+
+/*
+   _PSW -> lid does something interesting (unknown status).
+   _PSC -> PNP0303  (type error)
+   _LID -> lid does get lid status.
+   _ADR -> succeeds on many things
+   _CRS -> sometimes okay
+   _DIS -> 3 times okay
+   _EJ0 -> 1 time okay
+   _HID -> mostly returns integers
+   _PCL -> 2 times okay
+   _PRS -> 2 times okay
+   _PR[W0] -> 4 times okay
+   _PR1 -> okay once
+   _PSC -> 8 times okay
+   _PS3 -> 8 times okay, and seems to work
+   _PS2 -> okay once
+   _PS0 -> 8 times okay
+   _STA -> many times okay
+   _SRS -> error 3008
+   _UID -> many times okay.
+   _BST -> PNP0C0A battery status
+   _STM -> error 3008, sometimes (IDE set transfer timings)
+
+   
+*/
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/power.c linux/drivers/acpi/power.c
--- clean/drivers/acpi/power.c	Wed Jan 31 16:14:33 2001
+++ linux/drivers/acpi/power.c	Thu Apr  5 00:51:28 2001
@@ -118,6 +118,7 @@
 	}
 
 	acpi_cmbatt_init();
+	acpi_namespace_init();
 
 	return 0;
 }
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/sys.c linux/drivers/acpi/sys.c
--- clean/drivers/acpi/sys.c	Wed Jan 31 16:14:33 2001
+++ linux/drivers/acpi/sys.c	Thu Apr  5 00:51:17 2001
@@ -79,11 +79,12 @@
 /*
  * Enter soft-off (S5)
  */
-static void
+void
 acpi_power_off(void)
 {
 	struct acpi_enter_sx_ctx ctx;
 	
+	printk("Entering power off\n");
 	init_waitqueue_head(&ctx.wait);
 	ctx.state = ACPI_STATE_S5;
 	acpi_enter_sx_async(&ctx);

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
