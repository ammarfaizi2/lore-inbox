Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDGShM>; Sat, 7 Apr 2001 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRDGShD>; Sat, 7 Apr 2001 14:37:03 -0400
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129346AbRDGSgx>;
	Sat, 7 Apr 2001 14:36:53 -0400
Message-ID: <20010405225253.A553@bug.ucw.cz>
Date: Thu, 5 Apr 2001 22:52:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: FYI: ACPI devices put into proc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here it how it looks just now. This is work in progress, but feel free
to apply. [You may want to restructure it somehow, move it into
different place maybe, and call its init from convient place].

Oh, and "ACPI_OK" should be killed. It is too easy to write it instead
of AE_OK.

								Pavel

--- clean/drivers/acpi/namespace/nsxfobj.c	Sun Apr  1 00:23:00 2001
+++ linux/drivers/acpi/namespace/nsxfobj.c	Thu Apr  5 22:49:18 2001
@@ -30,6 +30,9 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
 
 #define _COMPONENT          NAMESPACE
 	 MODULE_NAME         ("nsxfobj")
@@ -694,3 +697,137 @@
 
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
+	printk("acpi_read_device_info: %lx\n", obj_handle);
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
+		return (AE_BAD_PARAMETER);
+	}
+
+	/*
+	 * Run _STA to determine if device is present
+	 */
+
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
+
+	{
+		char proc_name[120];
+
+		status = acpi_cm_execute_HID (node, &device_id);
+
+		if (status == AE_NOT_FOUND) {
+			return (AE_OK);
+		}
+
+		else if (ACPI_FAILURE (status)) {
+			return (status);
+		}
+
+		sprintf(proc_name, "power/device_%s_%lx", device_id.buffer, obj_handle );
+		printk("ACPI: creating %s\n", proc_name);
+		create_proc_read_entry(proc_name, 0, NULL,
+			proc_read_device_info, (void *) obj_handle);
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
+	status = acpi_ns_walk_namespace (ACPI_TYPE_DEVICE,
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

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
