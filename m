Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUIPSuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUIPSuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPS2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:28:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64227 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268097AbUIPSXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:23:50 -0400
Subject: [PATCH] acpiphp extension fixes for 2.6.9-rc2
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: pcihpd <pcihpd-discuss@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <gregkh@us.ibm.com>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>
In-Reply-To: <20040708232827.GA20755@kroah.com>
References: <1087934028.2068.57.camel@bluerat>
	 <200407071147.57604@bilbo.math.uni-mannheim.de>
	 <1089216410.24908.5.camel@bluerat>
	 <200407081209.42927@bilbo.math.uni-mannheim.de>
	 <1089328415.2089.194.camel@bluerat>  <20040708232827.GA20755@kroah.com>
Content-Type: text/plain
Message-Id: <1095358993.13519.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 11:23:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an off by one error that one of the IBM machines that
uses the acpiphp_ibm driver.  The slots were numbered starting at 0 in
BIOS instead of starting at 1 like the pci hotplug subsystem names
them.  So this patch provides a lookup to translate the Linux slot
numbers to the internal ACPI numbers.

 acpiphp_ibm.c |   96 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 59 insertions(+), 37 deletions(-)

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

=====================================================================
diff -Nuar -X dontdiff linux-2.6.9-rc2.orig/drivers/pci/hotplug/acpiphp_ibm.c linux-2.6.9-rc2-avatar/drivers/pci/hotplug/acpiphp_ibm.c
--- linux-2.6.9-rc2.orig/drivers/pci/hotplug/acpiphp_ibm.c	2004-09-15 21:03:53.694926544 -0700
+++ linux-2.6.9-rc2-avatar/drivers/pci/hotplug/acpiphp_ibm.c	2004-09-16 17:56:22.551563832 -0700
@@ -64,6 +64,8 @@
 #define IBM_HARDWARE_ID1 "IBM37D0"
 #define IBM_HARDWARE_ID2 "IBM37D4"
 
+#define hpslot_to_sun(A) (((struct slot *)((A)->private))->acpi_slot->sun)
+
 /* union apci_descriptor - allows access to the
  * various device descriptors that are embedded in the
  * aPCI table
@@ -128,6 +130,42 @@
 	.owner = THIS_MODULE,
 };
 
+/**
+ * ibm_slot_from_id - workaround for bad ibm hardware
+ * @id: the slot number that linux refers to the slot by
+ *
+ * Description: this method returns the aCPI slot descriptor
+ * corresponding to the Linux slot number.  This descriptor
+ * has info about the aPCI slot id and attention status.
+ * This descriptor must be freed using kfree when done.
+ **/
+static union apci_descriptor *ibm_slot_from_id(int id)
+{
+	int ind = 0, size;
+	union apci_descriptor *ret = NULL, *des;
+	char *table;
+
+	size = ibm_get_table_from_acpi(&table);
+	des = (union apci_descriptor *)table;
+	if (memcmp(des->header.sig, "aPCI", 4) != 0)
+		goto ibm_slot_done;
+
+	des = (union apci_descriptor *)&table[ind += des->header.len];
+	while (ind < size && (des->generic.type != 0x82 ||
+			des->slot.slot_num != id))
+		des = (union apci_descriptor *)&table[ind += des->generic.len];
+
+	if (ind < size && des->slot.slot_num == id)
+		ret = des;
+
+ibm_slot_done:
+	kfree(table);
+	if (ret) {
+		ret = kmalloc(sizeof(union apci_descriptor), GFP_KERNEL);
+		memcpy(ret, des, sizeof(union apci_descriptor));
+	}
+	return ret;
+}
 
 /**
  * ibm_set_attention_status - callback method to set the attention LED
@@ -139,32 +177,34 @@
  **/
 static int ibm_set_attention_status(struct hotplug_slot *slot, u8 status)
 {
-	int retval = 0;
 	union acpi_object args[2]; 
 	struct acpi_object_list params = { .pointer = args, .count = 2 };
 	acpi_status stat; 
-	unsigned long rc = 0;
-	struct acpiphp_slot *acpi_slot;
+	unsigned long rc;
+	union apci_descriptor *ibm_slot;
 
-	acpi_slot = ((struct slot *)(slot->private))->acpi_slot;
+	ibm_slot = ibm_slot_from_id(hpslot_to_sun(slot));
 
-	dbg("%s: set slot %d attention status to %d\n", __FUNCTION__,
-			acpi_slot->sun, (status ? 1 : 0));
+	dbg("%s: set slot %d (%d) attention status to %d\n", __FUNCTION__,
+			ibm_slot->slot.slot_num, ibm_slot->slot.slot_id,
+			(status ? 1 : 0));
 
 	args[0].type = ACPI_TYPE_INTEGER;
-	args[0].integer.value = acpi_slot->sun;
+	args[0].integer.value = ibm_slot->slot.slot_id;
 	args[1].type = ACPI_TYPE_INTEGER;
 	args[1].integer.value = (status) ? 1 : 0;
 
+	kfree(ibm_slot);
+
 	stat = acpi_evaluate_integer(ibm_acpi_handle, "APLS", &params, &rc);
 	if (ACPI_FAILURE(stat)) {
-		retval = -ENODEV;
 		err("APLS evaluation failed:  0x%08x\n", stat);
+		return -ENODEV;
 	} else if (!rc) {
-		retval = -ERANGE;
 		err("APLS method failed:  0x%08lx\n", rc);
+		return -ERANGE;
 	}
-	return retval;
+	return 0;
 }
 
 /**
@@ -181,38 +221,20 @@
  **/
 static int ibm_get_attention_status(struct hotplug_slot *slot, u8 *status)
 {
-	int retval = -EINVAL, ind = 0, size;
-	char *table = NULL;
-	struct acpiphp_slot *acpi_slot;
 	union apci_descriptor *des;
 
-	acpi_slot = ((struct slot *)(slot->private))->acpi_slot;
+	des = ibm_slot_from_id(hpslot_to_sun(slot));
 
-	size = ibm_get_table_from_acpi(&table);
-	if (size <= 0 || !table)
-		goto get_attn_done;
-	// read the header
-	des = (union apci_descriptor *)&table[ind];
-	if (memcmp(des->header.sig, "aPCI", 4) != 0)
-		goto get_attn_done;
-	des = (union apci_descriptor *)&table[ind += des->header.len];
-	while (ind < size && (des->generic.type != 0x82 ||
-			des->slot.slot_id != acpi_slot->sun))
-		des = (union apci_descriptor *)&table[ind += des->generic.len];
-	if (ind < size && des->slot.slot_id == acpi_slot->sun) {
-		retval = 0;
-		if (des->slot.attn & 0xa0 || des->slot.status[1] & 0x08)
-			*status = 1;
-		else
-			*status = 0;
-	}
+	if (des->slot.attn & 0xa0 || des->slot.status[1] & 0x08)
+		*status = 1;
+	else
+		*status = 0;
 
-	dbg("%s: get slot %d attention status is %d retval=%x\n",
-			__FUNCTION__, acpi_slot->sun, *status, retval);
+	dbg("%s: get slot %d (%d) attention status is %d\n", __FUNCTION__,
+			des->slot.slot_num, des->slot.slot_id, *status);
 
-get_attn_done:
-	kfree(table);
-	return retval;
+	kfree(des);
+	return 0;
 }
 
 /**


