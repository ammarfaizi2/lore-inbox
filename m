Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135846AbRDYM0a>; Wed, 25 Apr 2001 08:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135849AbRDYM0P>; Wed, 25 Apr 2001 08:26:15 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5124 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135846AbRDYMYj>;
	Wed, 25 Apr 2001 08:24:39 -0400
Message-ID: <20010423104509.A2198@bug.ucw.cz>
Date: Mon, 23 Apr 2001 10:45:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: acpi@phobos.fachschaften.tu-muenchen.de, andrew.grover@intel.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Lid support for ACPI
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's lid support for ACPI, please apply.

								Pavel
--- clean/drivers/acpi/power.c	Wed Jan 31 16:14:33 2001
+++ linux/drivers/acpi/power.c	Sun Apr 22 23:02:25 2001
@@ -30,11 +30,11 @@
 int acpi_cmbatt_init(void);
 int acpi_cmbatt_terminate(void);
 
-/* ACPI-specific defines */
-#define ACPI_AC_ADAPTER_HID	"ACPI0003"
-
 static int ac_count = 0;
+static int lid_count = 0;
 static ACPI_HANDLE ac_handle = 0;
+static ACPI_HANDLE lid_handle = 0;
+
 
 /*
  * We found a device with the correct HID
@@ -60,11 +60,28 @@
 	}
 
 	printk(KERN_INFO "AC Adapter: found\n");
-
 	ac_handle = handle;
-
 	ac_count++;
+	return AE_OK;
+}
 
+static ACPI_STATUS
+acpi_found_lid(ACPI_HANDLE handle, u32 level, void *ctx, void **value)
+{
+	ACPI_DEVICE_INFO	info;
+
+	if (lid_count > 0) {
+		printk(KERN_ERR "Lid: more than one!\n");
+		return (AE_OK);
+	}
+
+	if (!(info.valid & ACPI_VALID_STA)) {
+		printk(KERN_ERR "Lid: _STA invalid\n");
+	}
+
+	printk(KERN_INFO "Lid: found\n");
+	lid_handle = handle;
+	lid_count++;
 	return AE_OK;
 }
 
@@ -101,23 +118,54 @@
 	return len;
 }
 
+static int
+proc_read_lid_status(char *page, char **start, off_t off,
+		     int count, int *eof, void *data)
+{
+	ACPI_OBJECT obj;
+	ACPI_BUFFER buf;
+
+	char *p = page;
+	int len;
+
+	buf.length = sizeof(obj);
+	buf.pointer = &obj;
+	if (!ACPI_SUCCESS(acpi_evaluate_object(lid_handle, "_LID", NULL, &buf))
+		|| obj.type != ACPI_TYPE_INTEGER) {
+		p += sprintf(p, "Could not read lid status\n");
+		goto end;
+	}
+
+	if (obj.integer.value)
+		p += sprintf(p, "open\n");
+	else
+		p += sprintf(p, "closed\n");
+
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
 int
 acpi_power_init(void)
 {
-	acpi_get_devices(ACPI_AC_ADAPTER_HID, 
-			acpi_found_ac_adapter,
-			NULL,
-			NULL);
+	acpi_get_devices("ACPI0003", acpi_found_ac_adapter, NULL, NULL);
+	acpi_get_devices("PNP0C0D", acpi_found_lid, NULL, NULL);
 
 	if (!proc_mkdir("power", NULL))
-		return 0;
+		return -EBUSY;
 
-	if (ac_handle) {
-		create_proc_read_entry("power/ac", 0, NULL,
-			proc_read_ac_adapter_status, NULL);
-	}
+	if (ac_handle)
+		create_proc_read_entry("power/ac", 0, NULL, proc_read_ac_adapter_status, NULL);
+	if (lid_handle)
+		create_proc_read_entry("power/lid", 0, NULL, proc_read_lid_status, NULL);
 
 	acpi_cmbatt_init();
 
 	return 0;
 }
@@ -127,9 +176,8 @@
 {
 	acpi_cmbatt_terminate();
 
-	if (ac_handle) {
-		remove_proc_entry("power/ac", NULL);
-	}
+	if (ac_handle) remove_proc_entry("power/ac", NULL);
+	if (lid_handle) remove_proc_entry("power/lid", NULL);
 
 	remove_proc_entry("power", NULL);
 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
