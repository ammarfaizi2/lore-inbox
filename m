Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319743AbSIMSas>; Fri, 13 Sep 2002 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319741AbSIMS3b>; Fri, 13 Sep 2002 14:29:31 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:1291 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319743AbSIMS2b>;
	Fri, 13 Sep 2002 14:28:31 -0400
Date: Fri, 13 Sep 2002 11:29:46 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020913182945.GD26589@kroah.com>
References: <20020913182846.GA26589@kroah.com> <20020913182903.GB26589@kroah.com> <20020913182930.GC26589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913182930.GC26589@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.662   -> 1.663  
#	drivers/hotplug/ibmphp_hpc.c	1.4     -> 1.5    
#	drivers/hotplug/ibmphp_ebda.c	1.4     -> 1.5    
#	drivers/hotplug/ibmphp.h	1.3     -> 1.4    
#	drivers/hotplug/ibmphp_core.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	zubarev@us.ibm.com	1.663
# [PATCH] IBM PCI Hotplug driver update for PCI based controllers
# 
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Fri Sep 13 10:57:21 2002
+++ b/drivers/hotplug/ibmphp.h	Fri Sep 13 10:57:21 2002
@@ -737,6 +737,7 @@
 struct controller {
 	struct ebda_hpc_slot *slots;
 	struct ebda_hpc_bus *buses;
+	struct pci_dev *ctrl_dev; /* in case where controller is PCI */
 	u8 starting_slot_num;	/* starting and ending slot #'s this ctrl controls*/
 	u8 ending_slot_num;
 	u8 revision;
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Fri Sep 13 10:57:21 2002
+++ b/drivers/hotplug/ibmphp_core.c	Fri Sep 13 10:57:21 2002
@@ -1644,6 +1644,11 @@
 
 	max_slots = get_max_slots ();
 	
+	if ((rc = ibmphp_register_pci ())) {
+		ibmphp_unload ();
+		return rc;
+	}
+
 	if (init_ops ()) {
 		ibmphp_unload ();
 		return -ENODEV;
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:21 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:21 2002
@@ -130,6 +130,7 @@
 	controller->slots = NULL;
 	kfree (controller->buses);
 	controller->buses = NULL;
+	controller->ctrl_dev = NULL;
 	kfree (controller);
 }
 
@@ -797,6 +798,8 @@
 	return NULL;
 }
 
+static struct pci_driver ibmphp_driver;
+
 /*
  * map info (ctlr-id, slot count, slot#.. bus count, bus#, ctlr type...) of
  * each hpc from physical address to a list of hot plug controllers based on
@@ -928,6 +931,7 @@
 				hpc_ptr->u.pci_ctlr.dev_fun = readb (io_mem + addr + 1);
 				hpc_ptr->irq = readb (io_mem + addr + 2);
 				addr += 3;
+				debug ("ctrl bus = %x, ctlr devfun = %x, irq = %x\n", hpc_ptr->u.pci_ctlr.bus, hpc_ptr->u.pci_ctlr.dev_fun, hpc_ptr->irq);
 				break;
 
 			case 0:
@@ -953,12 +957,6 @@
 				return -ENODEV;
 		}
 
-		/* following 3 line: Now our driver only supports I2c/ISA ctlrType */
-		if ((hpc_ptr->ctlr_type != 2) && (hpc_ptr->ctlr_type != 4) && (hpc_ptr->ctlr_type != 0)) {
-			err ("Please run this driver on IBM xSeries440 or xSeries 235\n ");
-			return -ENODEV;
-		}
-
 		//reorganize chassis' linked list
 		combine_wpg_for_chassis ();
 		combine_wpg_for_expansion ();
@@ -1212,11 +1210,16 @@
 	struct controller *controller = NULL;
 	struct list_head *list;
 	struct list_head *next;
+	int pci_flag = 0;
 
 	list_for_each_safe (list, next, &ebda_hpc_head) {
 		controller = list_entry (list, struct controller, ebda_hpc_list);
 		if (controller->ctlr_type == 0)
 			release_region (controller->u.isa_ctlr.io_start, (controller->u.isa_ctlr.io_end - controller->u.isa_ctlr.io_start + 1));
+		else if ((controller->ctlr_type == 1) && (!pci_flag)) {
+			++pci_flag;
+			pci_unregister_driver (&ibmphp_driver);
+		}
 		free_ebda_hpc (controller);
 	}
 }
@@ -1233,3 +1236,59 @@
 		resource = NULL;
 	}
 }
+
+static struct pci_device_id id_table[] __devinitdata = {
+	{
+		vendor:		PCI_VENDOR_ID_IBM,
+		device:		HPC_DEVICE_ID,
+		subvendor:	PCI_VENDOR_ID_IBM,
+		subdevice:	HPC_SUBSYSTEM_ID,
+		class:		((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
+	}, {}
+};		
+
+MODULE_DEVICE_TABLE(pci, id_table);
+
+static int ibmphp_probe (struct pci_dev *, const struct pci_device_id *);
+static struct pci_driver ibmphp_driver = {
+	name:		"ibmphp",
+	id_table:	id_table,
+	probe:		ibmphp_probe,
+};
+
+int ibmphp_register_pci (void)
+{
+	struct controller *ctrl;
+	struct list_head *tmp;
+	int rc = 0;
+
+	list_for_each (tmp, &ebda_hpc_head) {
+		ctrl = list_entry (tmp, struct controller, ebda_hpc_list);
+		if (ctrl->ctlr_type == 1) {
+			rc = pci_module_init (&ibmphp_driver);
+			break;
+		}
+	}
+	return rc;
+}
+static int ibmphp_probe (struct pci_dev * dev, const struct pci_device_id *ids)
+{
+	struct controller *ctrl;
+	struct list_head *tmp;
+
+	debug ("inside ibmphp_probe \n");
+	
+	list_for_each (tmp, &ebda_hpc_head) {
+		ctrl = list_entry (tmp, struct controller, ebda_hpc_list);
+		if (ctrl->ctlr_type == 1) {
+			if ((dev->devfn == ctrl->u.pci_ctlr.dev_fun) && (dev->bus->number == ctrl->u.pci_ctlr.bus)) {
+				ctrl->ctrl_dev = dev;
+				debug ("found device!!! \n");
+				debug ("dev->device = %x, dev->subsystem_device = %x\n", dev->device, dev->subsystem_device);
+				return 0;
+			}
+		}
+	}
+	return -ENODEV;
+}
+
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:21 2002
+++ b/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:21 2002
@@ -378,6 +378,26 @@
 	outb (data, port_address);
 }
 
+static u8 pci_ctrl_read (struct controller *ctrl, u8 offset)
+{
+	u8 data = 0x00;
+	debug ("inside pci_ctrl_read\n");
+	if (ctrl->ctrl_dev)
+		pci_read_config_byte (ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, &data);
+	return data;
+}
+
+static u8 pci_ctrl_write (struct controller *ctrl, u8 offset, u8 data)
+{
+	u8 rc = -ENODEV;
+	debug ("inside pci_ctrl_write\n");
+	if (ctrl->ctrl_dev) {
+		pci_write_config_byte (ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, data);
+		rc = 0;
+	}
+	return rc;
+}
+
 static u8 ctrl_read (struct controller *ctlr, void *base, u8 offset)
 {
 	u8 rc;
@@ -385,6 +405,9 @@
 	case 0:
 		rc = isa_ctrl_read (ctlr, offset);
 		break;
+	case 1:
+		rc = pci_ctrl_read (ctlr, offset);
+		break;
 	case 2:
 	case 4:
 		rc = i2c_ctrl_read (ctlr, base, offset);
@@ -401,6 +424,9 @@
 	switch (ctlr->ctlr_type) {
 	case 0:
 		isa_ctrl_write(ctlr, offset, data);
+		break;
+	case 1:
+		rc = pci_ctrl_write (ctlr, offset, data);
 		break;
 	case 2:
 	case 4:
