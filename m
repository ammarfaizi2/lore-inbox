Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUGBQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUGBQYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGBQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:24:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4234 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264701AbUGBQW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:22:58 -0400
Date: Fri, 2 Jul 2004 11:21:54 -0500
From: linas@austin.ibm.com
To: Greg KH <greg@kroah.com>
Cc: inuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] 2.6 RPAPHP structure size/performance
Message-ID: <20040702112154.O21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Greg,

Please review and apply the following patch if you find it agreeable.

This patch does not make any functional changes, but does improve
both performance and memory usage by rearranging structure elements.

The need for these changes became appearent during a code review of
the disassembly involving this structure. The memory footprint of this
structure is made smaller by grouping the byte fields next to each other.
The access of the list_head can be simplified by making it the first element
of the structure, thus avoiding a needless add-immediate without negatively
impacting any of the other accesses.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas 

--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rpaphp.h.patch"

--- drivers/pci/hotplug/rpaphp.h.orig	2004-06-18 16:10:47.000000000 -0500
+++ drivers/pci/hotplug/rpaphp.h	2004-06-23 13:28:20.000000000 -0500
@@ -85,6 +85,7 @@ struct rpaphp_pci_func {
  * struct slot - slot information for each *physical* slot
  */
 struct slot {
+	struct list_head rpaphp_slot_list;
 	int state;
 	u32 index;
 	u32 type;
@@ -92,6 +93,7 @@ struct slot {
 	char *name;
 	char *location;
 	u8 removable;
+	u8 dev_type;		/* VIO or PCI */
 	struct device_node *dn;	/* slot's device_node in OFDT */
 				/* dn has phb info */
 	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
@@ -99,9 +101,7 @@ struct slot {
 		struct list_head pci_funcs; /* pci_devs in PCI slot */ 
 		struct vio_dev *vio_dev; /* vio_dev in VIO slot */
 	} dev;
-	u8 dev_type;		/* VIO or PCI */
 	struct hotplug_slot *hotplug_slot;
-	struct list_head rpaphp_slot_list;
 };
 
 extern struct hotplug_slot_ops rpaphp_hotplug_slot_ops;

--sdJFN6SSISdF2ksn--
