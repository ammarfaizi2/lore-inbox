Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWBHNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWBHNDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWBHNDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:03:39 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:41111 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030412AbWBHNDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:03:38 -0500
Date: Wed, 8 Feb 2006 13:03:34 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] [2/3] ACPI support for generic in-kernel AC status
Message-ID: <20060208130334.GA25659@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208125753.GA25562@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The included patch adds support for the generic in-kernel AC status 
code. Each AC adapter device is added to a list - when queried, if at 
least one claims to be online then we assume that the system is on AC.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 61f95ce..aa2d9b9 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/pm.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -67,8 +68,11 @@ static struct acpi_driver acpi_ac_driver
 struct acpi_ac {
 	acpi_handle handle;
 	unsigned long state;
+	struct list_head entry;
 };
 
+static struct list_head ac_adapter_list;
+
 static struct file_operations acpi_ac_fops = {
 	.open = acpi_ac_open_fs,
 	.read = seq_read,
@@ -255,6 +259,8 @@ static int acpi_ac_add(struct acpi_devic
 		goto end;
 	}
 
+	list_add(&ac->entry, &ac_adapter_list);
+
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       ac->state ? "on-line" : "off-line");
@@ -288,17 +294,34 @@ static int acpi_ac_remove(struct acpi_de
 
 	acpi_ac_remove_fs(device);
 
+	list_del(&ac->entry);
+
 	kfree(ac);
 
 	return_VALUE(0);
 }
 
+static int acpi_ac_online_status(void)
+{
+	struct acpi_ac *adapter;
+	
+	list_for_each_entry(adapter, &ac_adapter_list, entry) {
+		acpi_ac_get_state(adapter);
+		if (adapter->state)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int __init acpi_ac_init(void)
 {
 	int result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ac_init");
 
+	INIT_LIST_HEAD(&ac_adapter_list);
+
 	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
 	if (!acpi_ac_dir)
 		return_VALUE(-ENODEV);
@@ -310,6 +333,8 @@ static int __init acpi_ac_init(void)
 		return_VALUE(-ENODEV);
 	}
 
+	pm_set_ac_status(acpi_ac_online_status);
+
 	return_VALUE(0);
 }
 
@@ -317,6 +342,8 @@ static void __exit acpi_ac_exit(void)
 {
 	ACPI_FUNCTION_TRACE("acpi_ac_exit");
 
+	pm_set_ac_status(NULL);
+
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
 	remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
