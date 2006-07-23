Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWGWAaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWGWAaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWGWAaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:30:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31241 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWGWAaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:30:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=L0P7Uet1Un6uW2ssWarPk2/IiPYHEEGQ18gu1egV0auWYjRLfCiamxHbyNob/Krk1rrqJJb1naFNKrAxqJZBb9o3wZQ7il2zFjZkWQbqcZyZPbh0UXS+SIKGAH8lJMpf4aQp35CBHesiI8TRET4zCYmsWGVYfTuGs0yKqKdd5vY=
Date: Sun, 23 Jul 2006 02:29:07 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/acpi/battery.c cleanups
Message-ID: <20060723002907.GA8886@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Removed assignment casts, substituted kmalloc+memset with kzalloc, made
functions void if they never return a value. Style adjustments.

Signed-off-by: Johannes Weiner <hnazfoo@gmail.com>

---

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi_battery_cleanups.patch"

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6e52217..85f6a23 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -147,7 +147,7 @@ acpi_battery_get_info(struct acpi_batter
 		return -ENODEV;
 	}
 
-	package = (union acpi_object *)buffer.pointer;
+	package = buffer.pointer;
 
 	/* Extract Package Data */
 
@@ -158,12 +158,11 @@ acpi_battery_get_info(struct acpi_batter
 		goto end;
 	}
 
-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
@@ -173,11 +172,11 @@ acpi_battery_get_info(struct acpi_batter
 		goto end;
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	if (!result)
-		(*bif) = (struct acpi_battery_info *)data.pointer;
+		(*bif) = data.pointer;
 
 	return result;
 }
@@ -207,7 +206,7 @@ acpi_battery_get_status(struct acpi_batt
 		return -ENODEV;
 	}
 
-	package = (union acpi_object *)buffer.pointer;
+	package = buffer.pointer;
 
 	/* Extract Package Data */
 
@@ -218,12 +217,11 @@ acpi_battery_get_status(struct acpi_batt
 		goto end;
 	}
 
-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
@@ -233,11 +231,11 @@ acpi_battery_get_status(struct acpi_batt
 		goto end;
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	if (!result)
-		(*bst) = (struct acpi_battery_status *)data.pointer;
+		(*bst) = data.pointer;
 
 	return result;
 }
@@ -329,22 +327,22 @@ static int acpi_battery_check(struct acp
    -------------------------------------------------------------------------- */
 
 static struct proc_dir_entry *acpi_battery_dir;
-static int acpi_battery_read_info(struct seq_file *seq, void *offset)
+static void acpi_battery_read_info(struct seq_file *seq, void *offset)
 {
 	int result = 0;
-	struct acpi_battery *battery = (struct acpi_battery *)seq->private;
+	struct acpi_battery *battery = seq->private;
 	struct acpi_battery_info *bif = NULL;
 	char *units = "?";
 
 
 	if (!battery)
-		goto end;
+		return;
 
 	if (battery->flags.present)
 		seq_printf(seq, "present:                 yes\n");
 	else {
 		seq_printf(seq, "present:                 no\n");
-		goto end;
+		return;
 	}
 
 	/* Battery Info (_BIF) */
@@ -402,10 +400,8 @@ static int acpi_battery_read_info(struct
 	seq_printf(seq, "battery type:            %s\n", bif->battery_type);
 	seq_printf(seq, "OEM info:                %s\n", bif->oem_info);
 
-      end:
+end:
 	kfree(bif);
-
-	return 0;
 }
 
 static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
@@ -413,22 +409,22 @@ static int acpi_battery_info_open_fs(str
 	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
 }
 
-static int acpi_battery_read_state(struct seq_file *seq, void *offset)
+static void acpi_battery_read_state(struct seq_file *seq, void *offset)
 {
 	int result = 0;
-	struct acpi_battery *battery = (struct acpi_battery *)seq->private;
+	struct acpi_battery *battery = seq->private;
 	struct acpi_battery_status *bst = NULL;
 	char *units = "?";
 
 
 	if (!battery)
-		goto end;
+		return;
 
 	if (battery->flags.present)
 		seq_printf(seq, "present:                 yes\n");
 	else {
 		seq_printf(seq, "present:                 no\n");
-		goto end;
+		return;
 	}
 
 	/* Battery Units */
@@ -450,16 +446,15 @@ static int acpi_battery_read_state(struc
 	else
 		seq_printf(seq, "capacity state:          critical\n");
 
-	if ((bst->state & 0x01) && (bst->state & 0x02)) {
+	if ((bst->state & 0x01) && (bst->state & 0x02))
 		seq_printf(seq,
 			   "charging state:          charging/discharging\n");
-	} else if (bst->state & 0x01)
+	else if (bst->state & 0x01)
 		seq_printf(seq, "charging state:          discharging\n");
 	else if (bst->state & 0x02)
 		seq_printf(seq, "charging state:          charging\n");
-	else {
+	else
 		seq_printf(seq, "charging state:          charged\n");
-	}
 
 	if (bst->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
@@ -479,10 +474,8 @@ static int acpi_battery_read_state(struc
 		seq_printf(seq, "present voltage:         %d mV\n",
 			   (u32) bst->present_voltage);
 
-      end:
+end:
 	kfree(bst);
-
-	return 0;
 }
 
 static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
@@ -490,18 +483,18 @@ static int acpi_battery_state_open_fs(st
 	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
 }
 
-static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
+static void acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 {
-	struct acpi_battery *battery = (struct acpi_battery *)seq->private;
+	struct acpi_battery *battery = seq->private;
 	char *units = "?";
 
 
 	if (!battery)
-		goto end;
+		return;
 
 	if (!battery->flags.present) {
 		seq_printf(seq, "present:                 no\n");
-		goto end;
+		return;
 	}
 
 	/* Battery Units */
@@ -517,9 +510,6 @@ static int acpi_battery_read_alarm(struc
 		seq_printf(seq, "unsupported\n");
 	else
 		seq_printf(seq, "%d %sh\n", (u32) battery->alarm, units);
-
-      end:
-	return 0;
 }
 
 static ssize_t
@@ -529,8 +519,8 @@ acpi_battery_write_alarm(struct file *fi
 {
 	int result = 0;
 	char alarm_string[12] = { '\0' };
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	struct acpi_battery *battery = (struct acpi_battery *)m->private;
+	struct seq_file *m = file->private_data;
+	struct acpi_battery *battery = m->private;
 
 
 	if (!battery || (count > sizeof(alarm_string) - 1))
@@ -632,22 +622,20 @@ static int acpi_battery_add_fs(struct ac
 	return 0;
 }
 
-static int acpi_battery_remove_fs(struct acpi_device *device)
+static void acpi_battery_remove_fs(struct acpi_device *device)
 {
+	if (!acpi_device_dir(device))
+		return;
 
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BATTERY_FILE_STATUS,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_BATTERY_FILE_INFO,
-				  acpi_device_dir(device));
-
-		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
-		acpi_device_dir(device) = NULL;
-	}
+	remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
+			  acpi_device_dir(device));
+	remove_proc_entry(ACPI_BATTERY_FILE_STATUS,
+			  acpi_device_dir(device));
+	remove_proc_entry(ACPI_BATTERY_FILE_INFO,
+			  acpi_device_dir(device));
 
-	return 0;
+	remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
+	acpi_device_dir(device) = NULL;
 }
 
 /* --------------------------------------------------------------------------
@@ -656,7 +644,7 @@ static int acpi_battery_remove_fs(struct
 
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_battery *battery = (struct acpi_battery *)data;
+	struct acpi_battery *battery = data;
 	struct acpi_device *device = NULL;
 
 
@@ -678,8 +666,6 @@ static void acpi_battery_notify(acpi_han
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
-
-	return;
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -692,10 +678,9 @@ static int acpi_battery_add(struct acpi_
 	if (!device)
 		return -EINVAL;
 
-	battery = kmalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = kzalloc(sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
-	memset(battery, 0, sizeof(struct acpi_battery));
 
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
@@ -722,7 +707,7 @@ static int acpi_battery_add(struct acpi_
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 	       device->status.battery_present ? "present" : "absent");
 
-      end:
+end:
 	if (result) {
 		acpi_battery_remove_fs(device);
 		kfree(battery);
@@ -740,7 +725,7 @@ static int acpi_battery_remove(struct ac
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	battery = (struct acpi_battery *)acpi_driver_data(device);
+	battery = acpi_driver_data(device);
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
@@ -772,12 +757,8 @@ static int __init acpi_battery_init(void
 
 static void __exit acpi_battery_exit(void)
 {
-
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-
 	acpi_unlock_battery_dir(acpi_battery_dir);
-
-	return;
 }
 
 module_init(acpi_battery_init);

--/04w6evG8XlLl3ft--
