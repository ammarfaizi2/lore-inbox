Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDRV1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDRV1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDRV1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:27:50 -0400
Received: from mga03.intel.com ([143.182.124.21]:21859 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750714AbWDRV1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:27:50 -0400
X-IronPort-AV: i="4.04,131,1144047600"; 
   d="scan'208"; a="24673823:sNHT45389463"
Subject: [patch] pci hotplug: don't use acpi_os_free
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 14:36:43 -0700
Message-Id: <1145396204.10783.81.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Apr 2006 21:27:48.0366 (UTC) FILETIME=[F0A57AE0:01C6632E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_os_free should not be used by drivers outside
of acpi/*/*.c.  Replace with kfree().

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/hotplug/acpi_pcihp.c   |   16 ++++++++--------
 drivers/pci/hotplug/acpiphp_glue.c |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c   |    4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

--- 2.6-git-pcie.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ 2.6-git-pcie/drivers/pci/hotplug/acpi_pcihp.c
@@ -58,7 +58,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (!ret_buf.pointer) {
 			printk(KERN_ERR "%s:%s alloc for _HPP fail\n",
 				__FUNCTION__, (char *)string.pointer);
-			acpi_os_free(string.pointer);
+			kfree(string.pointer);
 			return AE_NO_MEMORY;
 		}
 		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
@@ -69,7 +69,7 @@ acpi_run_hpp(acpi_handle handle, struct 
 		if (ACPI_FAILURE(status)) {
 			pr_debug("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
 				(char *)string.pointer, status);
-			acpi_os_free(string.pointer);
+			kfree(string.pointer);
 			return status;
 		}
 	}
@@ -109,8 +109,8 @@ acpi_run_hpp(acpi_handle handle, struct 
 	pr_debug("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
 
 free_and_return:
-	acpi_os_free(string.pointer);
-	acpi_os_free(ret_buf.pointer);
+	kfree(string.pointer);
+	kfree(ret_buf.pointer);
 	return status;
 }
 
@@ -136,7 +136,7 @@ acpi_status acpi_run_oshp(acpi_handle ha
 		pr_debug("%s:%s OSHP passes\n", __FUNCTION__,
 			(char *)string.pointer);
 
-	acpi_os_free(string.pointer);
+	kfree(string.pointer);
 	return status;
 }
 EXPORT_SYMBOL_GPL(acpi_run_oshp);
@@ -192,19 +192,19 @@ int acpi_root_bridge(acpi_handle handle)
 		if ((info->valid & ACPI_VALID_HID) &&
 			!strcmp(PCI_ROOT_HID_STRING,
 					info->hardware_id.value)) {
-			acpi_os_free(buffer.pointer);
+			kfree(buffer.pointer);
 			return 1;
 		}
 		if (info->valid & ACPI_VALID_CID) {
 			for (i=0; i < info->compatibility_id.count; i++) {
 				if (!strcmp(PCI_ROOT_HID_STRING,
 					info->compatibility_id.id[i].value)) {
-					acpi_os_free(buffer.pointer);
+					kfree(buffer.pointer);
 					return 1;
 				}
 			}
 		}
-		acpi_os_free(buffer.pointer);
+		kfree(buffer.pointer);
 	}
 	return 0;
 }
--- 2.6-git-pcie.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ 2.6-git-pcie/drivers/pci/hotplug/acpiphp_glue.c
@@ -634,7 +634,7 @@ static int get_gsi_base(acpi_handle hand
 		break;
 	}
  out:
-	acpi_os_free(buffer.pointer);
+	kfree(buffer.pointer);
 	return result;
 }
 
--- 2.6-git-pcie.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ 2.6-git-pcie/drivers/pci/hotplug/pciehp_hpc.c
@@ -1288,7 +1288,7 @@ int pciehp_acpi_get_hp_hw_control_from_f
 		if (ACPI_SUCCESS(status)) {
 			dbg("Gained control for hotplug HW for pci %s (%s)\n",
 				pci_name(dev), (char *)string.pointer);
-			acpi_os_free(string.pointer);
+			kfree(string.pointer);
 			return 0;
 		}
 		if (acpi_root_bridge(handle))
@@ -1302,7 +1302,7 @@ int pciehp_acpi_get_hp_hw_control_from_f
 	err("Cannot get control of hotplug hardware for pci %s\n",
 			pci_name(dev));
 
-	acpi_os_free(string.pointer);
+	kfree(string.pointer);
 	return -1;
 }
 #endif
