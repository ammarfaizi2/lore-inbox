Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVBCRve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVBCRve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbVBCRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:49:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:11688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263357AbVBCRlV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:21 -0500
Cc: johnrose@austin.ibm.com
Subject: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware dependency
In-Reply-To: <11074524213464@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:40:21 -0800
Message-Id: <1107452421934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2044, 2005/02/03 00:41:04-08:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: remove incorrect rpaphp firmware dependency

The RPA PCI Hotplug module incorrectly uses a certain firmware property when
determining the hotplug capabilities of a slot.  Recent firmware changes have
demonstrated that this property should not be referenced or depended upon by
the OS.  This patch removes the dependency, and implements a correct set of
logic for determining hotplug capabilities.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -puN drivers/pci/hotplug/rpadlpar_core.c~02_rpadebug drivers/pci/hotplug/rpadlpar_core.c


 drivers/pci/hotplug/rpaphp.h      |    7 ------
 drivers/pci/hotplug/rpaphp_core.c |   39 +++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 18 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2005-02-03 09:28:39 -08:00
+++ b/drivers/pci/hotplug/rpaphp.h	2005-02-03 09:28:39 -08:00
@@ -109,13 +109,6 @@
 extern struct list_head rpaphp_slot_head;
 extern int num_slots;
 
-static inline int is_hotplug_capable(struct device_node *dn)
-{
-	unsigned char *ptr = get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL);
-
-	return (int) (ptr != NULL);
-}
-
 /* function prototypes */
 
 /* rpaphp_pci.c */
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	2005-02-03 09:28:39 -08:00
+++ b/drivers/pci/hotplug/rpaphp_core.c	2005-02-03 09:28:39 -08:00
@@ -287,26 +287,43 @@
 	return 1;
 }
 
-static int is_php_dn(struct device_node *dn, int **indexes, int **names, int **types,
-	  int **power_domains)
+static int is_php_type(char *drc_type)
 {
+	unsigned long value;
+	char *endptr;
+
+	/* PCI Hotplug nodes have an integer for drc_type */
+	value = simple_strtoul(drc_type, &endptr, 10);
+	if (endptr == drc_type)
+		return 0;
+
+	return 1;
+}
+
+static int is_php_dn(struct device_node *dn, int **indexes, int **names,
+		int **types, int **power_domains)
+{
+	int *drc_types;
 	int rc;
 
-	if (!is_hotplug_capable(dn))
-		return (0);
-	rc = get_children_props(dn, indexes, names, types, power_domains);
-	if (rc)
-		return (0);
-	return (1);
+	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
+	if (rc) {
+		if (is_php_type((char *) &drc_types[1])) {
+			*types = drc_types;
+			return 1;
+		}
+	}
+
+	return 0;
 }
 
-static int is_dr_dn(struct device_node *dn, int **indexes, int **names, int **types,
-	  int **power_domains, int **my_drc_index)
+static int is_dr_dn(struct device_node *dn, int **indexes, int **names,
+		int **types, int **power_domains, int **my_drc_index)
 {
 	int rc;
 
 	*my_drc_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
-	if(!*my_drc_index) 		
+	if(!*my_drc_index)
 		return (0);
 
 	if (!dn->parent)

