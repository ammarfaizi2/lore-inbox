Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUGHFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUGHFVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGHFVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:21:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23757 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265787AbUGHFUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:20:52 -0400
Date: Wed, 7 Jul 2004 16:47:39 -0500
From: linas@austin.ibm.com
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040707164739.I21634@forte.austin.ibm.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <20040707211656.GA4105@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Vhqu5qQ3bjg0ZI9i"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040707211656.GA4105@kroah.com>; from greg@kroah.com on Wed, Jul 07, 2004 at 02:16:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Vhqu5qQ3bjg0ZI9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2004 at 02:16:57PM -0700, Greg KH wrote:
> On Wed, Jul 07, 2004 at 03:59:07PM -0500, linas@austin.ibm.com wrote:
> > +void __exit exit_eeh_handler (void)
> 
> Um, I don't think you want your exit_* function to look identical to
> your init_* function :)

Ooops .... it helps to hit 'save' every now and then efter editing 
a file.  Attached below is the corrected patch, and a repeat copy of 
the original mail...


---------
Greg,
                                                                                
This patch implements the catching of EEH events by the hotplug subsystem.
Its preliminary in that it doesn't do much with these events; right now,
my goal is to stub-in the required interfaces so that development can occur
on both the arch/ppc64 tree and the drivers/pci/hotplug tree without
excessive co-dependency of patches.   I'm hoping to have these routines
do a whole lot more once some firmware issues get resolved.
                                                                                
Signed-off-by: Linas Vepstas <linas@linas.org>
                                                                                
--linas




--Vhqu5qQ3bjg0ZI9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-notifier-rpaphp.patch"

===== drivers/pci/hotplug/rpaphp.h 1.9 vs edited =====
--- 1.9/drivers/pci/hotplug/rpaphp.h	Fri Jul  2 11:14:11 2004
+++ edited/drivers/pci/hotplug/rpaphp.h	Wed Jul  7 15:44:35 2004
@@ -124,7 +124,8 @@
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
-extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
+extern void init_eeh_handler (void);
+extern void exit_eeh_handler (void);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
===== drivers/pci/hotplug/rpaphp_core.c 1.14 vs edited =====
--- 1.14/drivers/pci/hotplug/rpaphp_core.c	Tue Jun  8 17:53:59 2004
+++ edited/drivers/pci/hotplug/rpaphp_core.c	Wed Jul  7 13:50:20 2004
@@ -54,8 +54,6 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-void eeh_register_disable_func(int (*)(struct pci_dev *));
-
 module_param(debug, bool, 0644);
 
 static int enable_slot(struct hotplug_slot *slot);
@@ -65,7 +63,6 @@
 static int get_attention_status(struct hotplug_slot *slot, u8 * value);
 static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
 static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
-static int rpaphp_disable_slot(struct pci_dev *dev);
 
 struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
 	.owner = THIS_MODULE,
@@ -407,8 +404,8 @@
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	/* let EEH know they can use hotplug */
-	eeh_register_disable_func(&rpaphp_disable_slot);
+	/* Get set to handle EEH events */
+	init_eeh_handler();
 
 	/* read all the PRA info from the system */
 	return init_rpa();
@@ -416,8 +413,8 @@
 
 static void __exit rpaphp_exit(void)
 {
-	/* let EEH know we are going away */
-	eeh_register_disable_func(NULL);
+	/* Stop handling EEH events */
+	exit_eeh_handler();
 
 	cleanup_slots();
 }
@@ -448,11 +445,6 @@
 exit:
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
-}
-
-static int rpaphp_disable_slot(struct pci_dev *dev)
-{
-	return disable_slot(rpaphp_find_hotplug_slot(dev));
 }
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
===== drivers/pci/hotplug/rpaphp_pci.c 1.9 vs edited =====
--- 1.9/drivers/pci/hotplug/rpaphp_pci.c	Thu Jul  1 18:31:49 2004
+++ edited/drivers/pci/hotplug/rpaphp_pci.c	Wed Jul  7 16:39:03 2004
@@ -22,7 +22,9 @@
  * Send feedback to <lxie@us.ibm.com>
  *
  */
+#include <linux/notifier.h>
 #include <linux/pci.h>
+#include <asm/eeh.h>
 #include <asm/pci-bridge.h>
 #include "../pci.h"		/* for pci_add_new_bus */
 
@@ -227,7 +229,7 @@
 	}
 	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
 	/* do pci_scan_child_bus */
-	pci_scan_child_bus(child_bus);
+	// pci_scan_child_bus(child_bus);
 
 	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
 		eeh_add_device_late(child_dev);
@@ -503,7 +505,7 @@
 	return retval;
 }
 
-struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev)
+static struct slot *rpaphp_find_slot(struct pci_dev *dev)
 {
 	struct list_head	*tmp, *n;
 	struct slot		*slot;
@@ -528,11 +530,33 @@
 		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
                                 struct pci_dev *pdev = pci_dev_b(ln);
 				if (pdev == dev)
-					return slot->hotplug_slot;
+					return slot;
 		}
 	}
 
 	return NULL;
 }
 
-EXPORT_SYMBOL_GPL(rpaphp_find_hotplug_slot);
+int handle_eeh_events (struct notifier_block *self, 
+                       unsigned long reason, void *ev)
+{
+	struct eeh_event *event = ev;
+
+	/* Just turn it off for now */
+	rpaphp_unconfig_pci_adapter (rpaphp_find_slot(event->dev));
+	return 0;
+}
+
+static struct notifier_block eeh_block;
+
+void __init init_eeh_handler (void)
+{
+	eeh_block.notifier_call = handle_eeh_events;
+	eeh_register_notifier (&eeh_block);
+}
+
+void __exit exit_eeh_handler (void)
+{
+	eeh_unregister_notifier (&eeh_block);
+}
+

--Vhqu5qQ3bjg0ZI9i--
