Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUCSXho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbUCSXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:36:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:37839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263151AbUCSXca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:30 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <1079739131391@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:11 -0800
Message-Id: <1079739131226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.2, 2004/03/10 14:22:59-08:00, t-kochi@bq.jp.nec.com

[PATCH] PCI Hotlug: fix acpiphp unable to power off slots

Attached patch includes the I/O space fix and applies to 2.6.3.
This should also solve the problem Maeda-san reported in January
(sorry for replying so late!)

Here are changes in the patch:

 - fix the acpiphp driver not powering down a PCI card (from Gary Hade)
 - fix I/O space size calculation and ISA aliasing (from Gary Hade)
 - fix some debug messages
 - only execute ACPI methods on the first existing function


 drivers/pci/hotplug/acpiphp.h      |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c |   27 +++++++++++----------------
 drivers/pci/hotplug/acpiphp_pci.c  |   19 ++++++++-----------
 drivers/pci/hotplug/acpiphp_res.c  |    2 +-
 4 files changed, 21 insertions(+), 29 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
--- a/drivers/pci/hotplug/acpiphp.h	Fri Mar 19 15:21:31 2004
+++ b/drivers/pci/hotplug/acpiphp.h	Fri Mar 19 15:21:31 2004
@@ -235,7 +235,7 @@
 extern struct pci_dev *acpiphp_allocate_pcidev (struct pci_bus *pbus, int dev, int fn);
 extern int acpiphp_configure_slot (struct acpiphp_slot *slot);
 extern int acpiphp_configure_function (struct acpiphp_func *func);
-extern int acpiphp_unconfigure_function (struct acpiphp_func *func);
+extern void acpiphp_unconfigure_function (struct acpiphp_func *func);
 extern int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge);
 extern int acpiphp_init_func_resource (struct acpiphp_func *func);
 
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Fri Mar 19 15:21:31 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Fri Mar 19 15:21:31 2004
@@ -694,14 +694,14 @@
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_PS0) {
-			dbg("%s: executing _PS0 on %s\n", __FUNCTION__,
-			    pci_name(func->pci_dev));
+			dbg("%s: executing _PS0\n", __FUNCTION__);
 			status = acpi_evaluate_object(func->handle, "_PS0", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
 				warn("%s: _PS0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
-			}
+			} else
+				break;
 		}
 	}
 
@@ -737,7 +737,8 @@
 				warn("%s: _PS3 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
-			}
+			} else
+				break;
 		}
 	}
 
@@ -757,7 +758,8 @@
 				warn("%s: _EJ0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
-			}
+			} else
+				break;
 		}
 	}
 
@@ -865,15 +867,8 @@
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
-		if (func->pci_dev) {
-			if (acpiphp_unconfigure_function(func) == 0) {
-				func->pci_dev = NULL;
-			} else {
-				err("failed to unconfigure device\n");
-				retval = -1;
-				goto err_exit;
-			}
-		}
+		if (func->pci_dev)
+			acpiphp_unconfigure_function(func);
 	}
 
 	slot->flags &= (~SLOT_ENABLED);
@@ -1269,7 +1264,7 @@
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
-				enabled++;
+				disabled++;
 			}
 		} else {
 			/* if disabled but present, enable */
@@ -1280,7 +1275,7 @@
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
-				disabled++;
+				enabled++;
 			}
 		}
 	}
diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Fri Mar 19 15:21:31 2004
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Fri Mar 19 15:21:31 2004
@@ -83,8 +83,8 @@
 		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
 
-			len = bar & 0xFFFFFFFC;
-			len = ~len + 1;
+			len = bar & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
+			len = len & ~(len - 1);
 
 			dbg("len in IO %x, BAR %d\n", len, count);
 
@@ -226,8 +226,8 @@
 		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
 			base = bar & 0xFFFFFFFC;
-			len &= 0xFFFFFFFC;
-			len = ~len + 1;
+			len = len & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
+			len = len & ~(len - 1);
 
 			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
@@ -351,8 +351,8 @@
 		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
 			base = bar & 0xFFFFFFFC;
-			len &= 0xFFFFFFFC;
-			len = ~len + 1;
+			len = len & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
+			len = len & ~(len - 1);
 
 			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
@@ -485,14 +485,14 @@
  * @func: function to be unconfigured
  *
  */
-int acpiphp_unconfigure_function (struct acpiphp_func *func)
+void acpiphp_unconfigure_function (struct acpiphp_func *func)
 {
 	struct acpiphp_bridge *bridge;
 	int retval = 0;
 
 	/* if pci_dev is NULL, ignore it */
 	if (!func->pci_dev)
-		goto err_exit;
+		return;
 
 	pci_remove_bus_device(func->pci_dev);
 
@@ -505,7 +505,4 @@
 	acpiphp_move_resource(&func->p_mem_head, &bridge->p_mem_head);
 	acpiphp_move_resource(&func->bus_head, &bridge->bus_head);
 	spin_unlock(&bridge->res_lock);
-
- err_exit:
-	return retval;
 }
diff -Nru a/drivers/pci/hotplug/acpiphp_res.c b/drivers/pci/hotplug/acpiphp_res.c
--- a/drivers/pci/hotplug/acpiphp_res.c	Fri Mar 19 15:21:31 2004
+++ b/drivers/pci/hotplug/acpiphp_res.c	Fri Mar 19 15:21:31 2004
@@ -224,7 +224,7 @@
 		}  /* End of too big on top end */
 
 		/* For IO make sure it's not in the ISA aliasing space */
-		if (node->base & 0x300L)
+		if ((node->base & 0x300L) && !(node->base & 0xfffff000))
 			continue;
 
 		/* If we got here, then it is the right size

