Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTEBSpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTEBSpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:45:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23289 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263103AbTEBSoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:44:20 -0400
Date: Fri, 2 May 2003 11:58:13 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug fixes for 2.4.21-rc1
Message-ID: <20030502185813.GD14728@kroah.com>
References: <20030502185406.GA14728@kroah.com> <20030502185701.GB14728@kroah.com> <20030502185733.GC14728@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502185733.GC14728@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1144, 2003/05/02 11:35:50-07:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: fix up a number of memory leaks on the error path


 drivers/hotplug/ibmphp_ebda.c |  144 ++++++++++++++++++------------------------
 1 files changed, 65 insertions(+), 79 deletions(-)


diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Fri May  2 11:39:00 2003
+++ b/drivers/hotplug/ibmphp_ebda.c	Fri May  2 11:39:00 2003
@@ -70,17 +70,6 @@
 static int ebda_rsrc_rsrc (void);
 static int ebda_rio_table (void);
 
-static struct slot *alloc_ibm_slot (void)
-{
-	struct slot *slot;
-
-	slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
-	if (!slot)
-		return NULL;
-	memset (slot, 0, sizeof (*slot));
-	return slot;
-}
-
 static struct ebda_hpc_list * __init alloc_ebda_hpc_list (void)
 {
 	struct ebda_hpc_list *list;
@@ -757,8 +746,7 @@
 	struct ebda_hpc_slot *slot_ptr;
 	struct bus_info *bus_info_ptr1, *bus_info_ptr2;
 	int rc;
-	int retval;
-	struct slot *slot_cur;
+	struct slot *tmp_slot;
 	struct list_head *list;
 
 	addr = hpc_list_ptr->phys_addr;
@@ -783,8 +771,8 @@
 		/* init hpc structure */
 		hpc_ptr = alloc_ebda_hpc (slot_num, bus_num);
 		if (!hpc_ptr ) {
-			iounmap (io_mem);
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto error_no_hpc;
 		}
 		hpc_ptr->ctlr_id = ctlr_id;
 		hpc_ptr->ctlr_relative_id = ctlr;
@@ -810,8 +798,8 @@
 			if (!bus_info_ptr2) {
 				bus_info_ptr1 = (struct bus_info *) kmalloc (sizeof (struct bus_info), GFP_KERNEL);
 				if (!bus_info_ptr1) {
-					iounmap (io_mem);
-					return -ENOMEM;
+					rc = -ENOMEM;
+					goto error_no_hp_slot;
 				}
 				memset (bus_info_ptr1, 0, sizeof (struct bus_info));
 				bus_info_ptr1->slot_min = slot_ptr->slot_num;
@@ -871,16 +859,20 @@
 				hpc_ptr->u.pci_ctlr.dev_fun = readb (io_mem + addr + 1);
 				hpc_ptr->irq = readb (io_mem + addr + 2);
 				addr += 3;
-				debug ("ctrl bus = %x, ctlr devfun = %x, irq = %x\n", hpc_ptr->u.pci_ctlr.bus, hpc_ptr->u.pci_ctlr.dev_fun, hpc_ptr->irq);
+				debug ("ctrl bus = %x, ctlr devfun = %x, irq = %x\n", 
+					hpc_ptr->u.pci_ctlr.bus,
+					hpc_ptr->u.pci_ctlr.dev_fun, hpc_ptr->irq);
 				break;
 
 			case 0:
 				hpc_ptr->u.isa_ctlr.io_start = readw (io_mem + addr);
 				hpc_ptr->u.isa_ctlr.io_end = readw (io_mem + addr + 2);
-				retval = check_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1));
-				if (retval)
-					return -ENODEV;
-				request_region (hpc_ptr->u.isa_ctlr.io_start, (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1), "ibmphp");
+				if (!request_region (hpc_ptr->u.isa_ctlr.io_start,
+						     (hpc_ptr->u.isa_ctlr.io_end - hpc_ptr->u.isa_ctlr.io_start + 1),
+						     "ibmphp")) {
+					rc = -ENODEV;
+					goto error_no_hp_slot;
+				}
 				hpc_ptr->irq = readb (io_mem + addr + 4);
 				addr += 5;
 				break;
@@ -893,8 +885,8 @@
 				addr += 6;
 				break;
 			default:
-				iounmap (io_mem);
-				return -ENODEV;
+				rc = -ENODEV;
+				goto error_no_hp_slot;
 		}
 
 		//reorganize chassis' linked list
@@ -910,91 +902,71 @@
 
 			hp_slot_ptr = (struct hotplug_slot *) kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
 			if (!hp_slot_ptr) {
-				iounmap (io_mem);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto error_no_hp_slot;
 			}
 			memset (hp_slot_ptr, 0, sizeof (struct hotplug_slot));
 
 			hp_slot_ptr->info = (struct hotplug_slot_info *) kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
 			if (!hp_slot_ptr->info) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto error_no_hp_info;
 			}
 			memset (hp_slot_ptr->info, 0, sizeof (struct hotplug_slot_info));
 
 			hp_slot_ptr->name = (char *) kmalloc (30, GFP_KERNEL);
 			if (!hp_slot_ptr->name) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr->info);
-				kfree (hp_slot_ptr);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto error_no_hp_name;
 			}
 
-			hp_slot_ptr->private = alloc_ibm_slot ();
-			if (!hp_slot_ptr->private) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr->name);
-				kfree (hp_slot_ptr->info);
-				kfree (hp_slot_ptr);
-				return -ENOMEM;
+			tmp_slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
+			if (!tmp_slot) {
+				rc = -ENOMEM;
+				goto error_no_slot;
 			}
+			memset (tmp_slot, 0, sizeof (*tmp_slot));
 
-			((struct slot *)hp_slot_ptr->private)->flag = TRUE;
+			tmp_slot->flag = TRUE;
 
-			((struct slot *) hp_slot_ptr->private)->capabilities = hpc_ptr->slots[index].slot_cap;
+			tmp_slot->capabilities = hpc_ptr->slots[index].slot_cap;
 			if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_133_MAX) == EBDA_SLOT_133_MAX)
-				((struct slot *) hp_slot_ptr->private)->supported_speed =  3;
+				tmp_slot->supported_speed =  3;
 			else if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_100_MAX) == EBDA_SLOT_100_MAX)
-				((struct slot *) hp_slot_ptr->private)->supported_speed =  2;
+				tmp_slot->supported_speed =  2;
 			else if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_66_MAX) == EBDA_SLOT_66_MAX)
-				((struct slot *) hp_slot_ptr->private)->supported_speed =  1;
+				tmp_slot->supported_speed =  1;
 				
 			if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_PCIX_CAP) == EBDA_SLOT_PCIX_CAP)
-				((struct slot *) hp_slot_ptr->private)->supported_bus_mode = 1;
+				tmp_slot->supported_bus_mode = 1;
 			else
-				((struct slot *) hp_slot_ptr->private)->supported_bus_mode = 0;
+				tmp_slot->supported_bus_mode = 0;
 
 
-			((struct slot *) hp_slot_ptr->private)->bus = hpc_ptr->slots[index].slot_bus_num;
+			tmp_slot->bus = hpc_ptr->slots[index].slot_bus_num;
 
 			bus_info_ptr1 = ibmphp_find_same_bus_num (hpc_ptr->slots[index].slot_bus_num);
 			if (!bus_info_ptr1) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr->name);
-				kfree (hp_slot_ptr->info);
-				kfree (hp_slot_ptr->private);
-				kfree (hp_slot_ptr);
-				return -ENODEV;
+				rc = -ENODEV;
+				goto error;
 			}
-			((struct slot *) hp_slot_ptr->private)->bus_on = bus_info_ptr1;
+			tmp_slot->bus_on = bus_info_ptr1;
 			bus_info_ptr1 = NULL;
-			((struct slot *) hp_slot_ptr->private)->ctrl = hpc_ptr;
+			tmp_slot->ctrl = hpc_ptr;
 
+			tmp_slot->ctlr_index = hpc_ptr->slots[index].ctl_index;
+			tmp_slot->number = hpc_ptr->slots[index].slot_num;
+			tmp_slot->hotplug_slot = hp_slot_ptr;
+
+			hp_slot_ptr->private = tmp_slot;
 
-			((struct slot *) hp_slot_ptr->private)->ctlr_index = hpc_ptr->slots[index].ctl_index;
-			((struct slot *) hp_slot_ptr->private)->number = hpc_ptr->slots[index].slot_num;
-			
-			((struct slot *) hp_slot_ptr->private)->hotplug_slot = hp_slot_ptr;
 			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
-			if (rc) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr->name);
-				kfree (hp_slot_ptr->info);
-				kfree (hp_slot_ptr->private);
-				kfree (hp_slot_ptr);
-				return rc;
-			}
+			if (rc)
+				goto error;
 
 			rc = ibmphp_init_devno ((struct slot **) &hp_slot_ptr->private);
-			if (rc) {
-				iounmap (io_mem);
-				kfree (hp_slot_ptr->name);
-				kfree (hp_slot_ptr->info);
-				kfree (hp_slot_ptr->private);
-				kfree (hp_slot_ptr);
-				return rc;
-			}
+			if (rc)
+				goto error;
 			hp_slot_ptr->ops = &ibmphp_hotplug_slot_ops;
 
 			// end of registering ibm slot with hotplug core
@@ -1008,15 +980,29 @@
 	}			/* each hpc  */
 
 	list_for_each (list, &ibmphp_slot_head) {
-		slot_cur = list_entry (list, struct slot, ibm_slot_list);
+		tmp_slot = list_entry (list, struct slot, ibm_slot_list);
 
-		snprintf (slot_cur->hotplug_slot->name, 30, "%s", create_file_name (slot_cur));
-		pci_hp_register (slot_cur->hotplug_slot);
+		snprintf (tmp_slot->hotplug_slot->name, 30, "%s", create_file_name (tmp_slot));
+		pci_hp_register (tmp_slot->hotplug_slot);
 	}
 
 	print_ebda_hpc ();
 	print_ibm_slot ();
 	return 0;
+
+error:
+	kfree (hp_slot_ptr->private);
+error_no_slot:
+	kfree (hp_slot_ptr->name);
+error_no_hp_name:
+	kfree (hp_slot_ptr->info);
+error_no_hp_info:
+	kfree (hp_slot_ptr);
+error_no_hp_slot:
+	free_ebda_hpc (hpc_ptr);
+error_no_hpc:
+	iounmap (io_mem);
+	return rc;
 }
 
 /* 
