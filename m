Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWGJT01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWGJT01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWGJT01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:26:27 -0400
Received: from xenotime.net ([66.160.160.81]:37830 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422796AbWGJT00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:26:26 -0400
Date: Mon, 10 Jul 2006 12:29:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh <greg@kroah.com>
Subject: [PATCH -mm] sysfs_remove_bin_file: no return value, no check needed
Message-Id: <20060710122910.08c01f46.rdunlap@xenotime.net>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

>   In some cases (eg, sysfs file removal) there's not a lot the caller can do
>   apart from warn, so we should probably change those things to return void
>   and put a diagnostic message into the callee itself.

sysfs_remove_bin_file() cannot tell if there is an error and
cannot return an error, so "fix" around 40 must-check warnings.

Convert sysfs_remove_bin_file() from int to void since it
  cannot return an error.
Remove __must_check from its declaration.
Convert the only function that checked the return value of
  sysfs_remove_bin_file().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    4 +---
 fs/sysfs/bin.c                    |    5 ++---
 include/linux/sysfs.h             |    2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2618-rc1mm1.orig/fs/sysfs/bin.c
+++ linux-2618-rc1mm1/fs/sysfs/bin.c
@@ -194,10 +194,9 @@ int sysfs_create_bin_file(struct kobject
  *
  */
 
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
+void sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->attr.name);
-	return 0;
+	sysfs_hash_and_remove(kobj->dentry, attr->attr.name);
 }
 
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
--- linux-2618-rc1mm1.orig/drivers/pci/hotplug/acpiphp_ibm.c
+++ linux-2618-rc1mm1/drivers/pci/hotplug/acpiphp_ibm.c
@@ -487,9 +487,7 @@ static void __exit ibm_acpiphp_exit(void
 	if (ACPI_FAILURE(status))
 		err("%s: Notification handler removal failed\n", __FUNCTION__);
 	/* remove the /sys entries */
-	if (sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr))
-		err("%s: removal of sysfs file apci_table failed\n",
-				__FUNCTION__);
+	sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr);
 }
 
 module_init(ibm_acpiphp_init);
--- linux-2618-rc1mm1.orig/include/linux/sysfs.h
+++ linux-2618-rc1mm1/include/linux/sysfs.h
@@ -116,7 +116,7 @@ sysfs_remove_link(struct kobject *, cons
 
 int __must_check sysfs_create_bin_file(struct kobject * kobj,
 					struct bin_attribute * attr);
-int __must_check sysfs_remove_bin_file(struct kobject * kobj,
+void sysfs_remove_bin_file(struct kobject * kobj,
 					struct bin_attribute * attr);
 
 int __must_check sysfs_create_group(struct kobject *,


---
