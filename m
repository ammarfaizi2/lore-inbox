Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWAHTNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWAHTNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWAHTNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:13:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29883 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161060AbWAHTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:13:48 -0500
Date: Sun, 8 Jan 2006 20:11:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       pcihpd-discuss@lists.sourceforge.net
Subject: Thinkpad docking station: pci hotplug questions
Message-ID: <20060108191159.GA1880@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to get PCI hotplug to work on thinkpad x32 -- it is
apparently neccessary for proper docking station support. What needs
to be done to get it running?

I noticed some strangenesses:

pcihpfs is mentioned in Kconfig, but I can't find it anywhere in
kernel

CONFIG_HOTPLUG_PCI_PCIE exists in Makefile but not in Kconfig.

And here are some coding style fixes:

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -302,7 +302,7 @@ static int ibm_get_table_from_acpi(char 
 	}
 
 	package = (union acpi_object *) buffer.pointer;
-	if(!(package) ||
+	if (!(package) ||
 			(package->type != ACPI_TYPE_PACKAGE) ||
 			!(package->package.elements)) {
 		err("%s:  Invalid APCI object\n", __FUNCTION__);
@@ -405,7 +405,7 @@ static acpi_status __init ibm_find_acpi_
 	}
 	info.hardware_id.value[sizeof(info.hardware_id.value) - 1] = '\0';
 
-	if(info.current_status && (info.valid & ACPI_VALID_HID) &&
+	if (info.current_status && (info.valid & ACPI_VALID_HID) &&
 			(!strcmp(info.hardware_id.value, IBM_HARDWARE_ID1) ||
 			!strcmp(info.hardware_id.value, IBM_HARDWARE_ID2))) {
 		dbg("found hardware: %s, handle: %p\n", info.hardware_id.value,
@@ -449,13 +449,11 @@ static int __init ibm_acpiphp_init(void)
 	}
 
 	ibm_note.device = device;
-	status = acpi_install_notify_handler(
-			ibm_acpi_handle,
-			ACPI_DEVICE_NOTIFY,
-			ibm_handle_events,
+	status = acpi_install_notify_handler(ibm_acpi_handle,
+			ACPI_DEVICE_NOTIFY, ibm_handle_events,
 			&ibm_note);
 	if (ACPI_FAILURE(status)) {
-		err("%s:  Failed to register notification handler\n",
+		err("%s: Failed to register notification handler\n",
 				__FUNCTION__);
 		retval = -EBUSY;
 		goto init_cleanup;
@@ -482,14 +480,13 @@ static void __exit ibm_acpiphp_exit(void
 	if (acpiphp_unregister_attention(&ibm_attention_info))
 		err("%s: attention info deregistration failed", __FUNCTION__);
 
-	   status = acpi_remove_notify_handler(
+	status = acpi_remove_notify_handler(
 			   ibm_acpi_handle,
 			   ACPI_DEVICE_NOTIFY,
 			   ibm_handle_events);
-	   if (ACPI_FAILURE(status))
-		   err("%s:  Notification handler removal failed\n",
-				   __FUNCTION__);
-	// remove the /sys entries
+	if (ACPI_FAILURE(status))
+		err("%s: Notification handler removal failed\n", __FUNCTION__);
+	/* remove the /sys entries */
 	if (sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr))
 		err("%s: removal of sysfs file apci_table failed\n",
 				__FUNCTION__);
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -235,12 +235,12 @@ static int set_attention_status(struct h
 {
 	int rc = 0;
 	struct slot *pslot;
-	u8 cmd;
+	u8 cmd = 0x00;     /* avoid compiler warning */
 
 	debug("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n",
 			(ulong) hotplug_slot, value);
 	ibmphp_lock_operations();
-	cmd = 0x00;     // avoid compiler warning
+
 
 	if (hotplug_slot) {
 		switch (value) {




-- 
Thanks, Sharp!
