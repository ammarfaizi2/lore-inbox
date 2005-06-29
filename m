Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVF2Ar4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVF2Ar4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVF2ArF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:47:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9359 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262342AbVF2AAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:00:21 -0400
Date: Tue, 28 Jun 2005 19:00:15 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 12/13]: PCI Err: RPA-PHP clarification
Message-ID: <20050629000015.GA6481@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-12-rpaphp-symmetry.patch

Restructure handling of bus remove and bus add to make the pairs 
of calls more symmetrical.  Doesn't change function, but does 
make the code easier to understand.

Signed-off-by: Linas Vepstas <linas@linas.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-12-rpaphp-symmetry.patch"

--- linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_pci.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_pci.c	2005-06-22 15:28:29.000000000 -0500
@@ -63,6 +63,7 @@ int rpaphp_claim_resource(struct pci_dev
 		    root ? "Address space collision on" :
 		    "No parent found for",
 		    resource, dtype, pci_name(dev), res->start, res->end);
+		dump_stack();
 	}
 	return err;
 }
@@ -188,6 +189,19 @@ rpaphp_fixup_new_pci_devices(struct pci_
 
 static int rpaphp_pci_config_bridge(struct pci_dev *dev);
 
+static void rpaphp_eeh_add_bus_device(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_add_device_late(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (bus)
+				rpaphp_eeh_add_bus_device (subbus);
+		}
+	}
+}
+
 /*****************************************************************************
  rpaphp_pci_config_slot() will  configure all devices under the 
  given slot->dn and return the the first pci_dev.
@@ -215,6 +229,8 @@ rpaphp_pci_config_slot(struct device_nod
 		}
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) 
 			rpaphp_pci_config_bridge(dev);
+
+		rpaphp_eeh_add_bus_device(bus);
 	}
 	return dev;
 }
@@ -223,7 +239,6 @@ static int rpaphp_pci_config_bridge(stru
 {
 	u8 sec_busno;
 	struct pci_bus *child_bus;
-	struct pci_dev *child_dev;
 
 	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
 
@@ -240,11 +255,7 @@ static int rpaphp_pci_config_bridge(stru
 	/* do pci_scan_child_bus */
 	pci_scan_child_bus(child_bus);
 
-	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
-		eeh_add_device_late(child_dev);
-	}
-
-	 /* fixup new pci devices without touching bus struct */
+	/* Fixup new pci devices without touching bus struct */
 	rpaphp_fixup_new_pci_devices(child_bus, 0);
 
 	/* Make the discovered devices available */
@@ -320,7 +331,6 @@ static void rpaphp_eeh_remove_bus_device
 			if (pdev)
 				rpaphp_eeh_remove_bus_device(pdev);
 		}
-
 	}
 	return;
 }

--17pEHd4RhPHOinZp--
