Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUBIX6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUBIX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:56:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:60348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265422AbUBIXWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:37 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <1076368942698@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:22 -0800
Message-Id: <10763689421189@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.20, 2004/02/06 14:23:33-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Convert error paths in ibmphp to use goto

This patch converts the error paths in several functions in ibmphp to use
goto to the end of the function to kill code duplication.

It also kills some memsets of pointer members of a struct where the struct
itself is freed directly after.

This one has 2 modification from the first version: the if is back as
discussed and one extra long line (>> 150 chars) is wrapped now.


 drivers/pci/hotplug/ibmphp_ebda.c |   96 ++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 54 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	Mon Feb  9 14:58:25 2004
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	Mon Feb  9 14:58:25 2004
@@ -89,36 +89,34 @@
 
 	controller = kmalloc (sizeof (struct controller), GFP_KERNEL);
 	if (!controller)
-		return NULL;
+		goto error;
 	memset (controller, 0, sizeof (*controller));
 
 	slots = kmalloc (sizeof (struct ebda_hpc_slot) * slot_count, GFP_KERNEL);
-	if (!slots) {
-		kfree (controller);
-		return NULL;
-	}
+	if (!slots)
+		goto error_contr;
 	memset (slots, 0, sizeof (*slots) * slot_count);
 	controller->slots = slots;
 
 	buses = kmalloc (sizeof (struct ebda_hpc_bus) * bus_count, GFP_KERNEL);
-	if (!buses) {
-		kfree (controller->slots);
-		kfree (controller);
-		return NULL;
-	}
+	if (!buses)
+		goto error_slots;
 	memset (buses, 0, sizeof (*buses) * bus_count);
 	controller->buses = buses;
 
 	return controller;
+error_slots:
+	kfree(controller->slots);
+error_contr:
+	kfree(controller);
+error:
+	return NULL;
 }
 
 static void free_ebda_hpc (struct controller *controller)
 {
 	kfree (controller->slots);
-	controller->slots = NULL;
 	kfree (controller->buses);
-	controller->buses = NULL;
-	controller->ctrl_dev = NULL;
 	kfree (controller);
 }
 
@@ -286,7 +284,8 @@
 int __init ibmphp_access_ebda (void)
 {
 	u8 format, num_ctlrs, rio_complete, hs_complete;
-	u16 ebda_seg, num_entries, next_offset, offset, blk_id, sub_addr, rc, re, rc_id, re_id, base;
+	u16 ebda_seg, num_entries, next_offset, offset, blk_id, sub_addr, re, rc_id, re_id, base;
+	int rc = 0;
 
 
 	rio_complete = 0;
@@ -324,10 +323,8 @@
 			format = readb (io_mem + offset);
 
 			offset += 1;
-			if (format != 4) {
-				iounmap (io_mem);
-				return -ENODEV;
-			}
+			if (format != 4)
+				goto error_nodev;
 			debug ("hot blk format: %x\n", format);
 			/* hot swap sub blk */
 			base = offset;
@@ -339,18 +336,16 @@
 			rc_id = readw (io_mem + sub_addr); 	/* sub blk id */
 
 			sub_addr += 2;
-			if (rc_id != 0x5243) {
-				iounmap (io_mem);
-				return -ENODEV;
-			}
+			if (rc_id != 0x5243)
+				goto error_nodev;
 			/* rc sub blk signature  */
 			num_ctlrs = readb (io_mem + sub_addr);
 
 			sub_addr += 1;
 			hpc_list_ptr = alloc_ebda_hpc_list ();
 			if (!hpc_list_ptr) {
-				iounmap (io_mem);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out;
 			}
 			hpc_list_ptr->format = format;
 			hpc_list_ptr->num_ctlrs = num_ctlrs;
@@ -361,16 +356,15 @@
 			debug ("offset of hpc data structure enteries: %x\n ", sub_addr);
 
 			sub_addr = base + re;	/* re sub blk */
+			/* FIXME: rc is never used/checked */
 			rc = readw (io_mem + sub_addr);	/* next sub blk */
 
 			sub_addr += 2;
 			re_id = readw (io_mem + sub_addr);	/* sub blk id */
 
 			sub_addr += 2;
-			if (re_id != 0x5245) {
-				iounmap (io_mem);
-				return -ENODEV;
-			}
+			if (re_id != 0x5245)
+				goto error_nodev;
 
 			/* signature of re */
 			num_entries = readw (io_mem + sub_addr);
@@ -378,8 +372,8 @@
 			sub_addr += 2;	/* offset of RSRC_ENTRIES blk */
 			rsrc_list_ptr = alloc_ebda_rsrc_list ();
 			if (!rsrc_list_ptr ) {
-				iounmap (io_mem);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out;
 			}
 			rsrc_list_ptr->format = format;
 			rsrc_list_ptr->num_entries = num_entries;
@@ -391,9 +385,8 @@
 			debug ("offset of rsrc data structure enteries: %x\n ", sub_addr);
 
 			hs_complete = 1;
-		}
-		/* found rio table */
-		else if (blk_id == 0x4752) {
+		} else {
+		/* found rio table, blk_id == 0x4752 */
 			debug ("now enter io table ---\n");
 			debug ("rio blk id: %x\n", blk_id);
 
@@ -406,41 +399,36 @@
 			rio_table_ptr->riodev_count = readb (io_mem + offset + 2);
 			rio_table_ptr->offset = offset +3 ;
 			
-			debug ("info about rio table hdr ---\n");
-			debug ("ver_num: %x\nscal_count: %x\nriodev_count: %x\noffset of rio table: %x\n ", rio_table_ptr->ver_num, rio_table_ptr->scal_count, rio_table_ptr->riodev_count, rio_table_ptr->offset);
+			debug("info about rio table hdr ---\n");
+			debug("ver_num: %x\nscal_count: %x\nriodev_count: %x\noffset of rio table: %x\n ",
+				rio_table_ptr->ver_num, rio_table_ptr->scal_count,
+				rio_table_ptr->riodev_count, rio_table_ptr->offset);
 
 			rio_complete = 1;
 		}
 	}
 
-	if (!hs_complete && !rio_complete) {
-		iounmap (io_mem);
-		return -ENODEV;
-	}
+	if (!hs_complete && !rio_complete)
+		goto error_nodev;
 
 	if (rio_table_ptr) {
-		if (rio_complete == 1 && rio_table_ptr->ver_num == 3) {
+		if (rio_complete && rio_table_ptr->ver_num == 3) {
 			rc = ebda_rio_table ();
-			if (rc) {
-				iounmap (io_mem);
-				return rc;
-			}
+			if (rc)
+				goto out;
 		}
 	}
 	rc = ebda_rsrc_controller ();
-	if (rc) {
-		iounmap (io_mem);
-		return rc;
-	}
+	if (rc)
+		goto out;
 
 	rc = ebda_rsrc_rsrc ();
-	if (rc) {
-		iounmap (io_mem);
-		return rc;
-	}
-
+	goto out;
+error_nodev:
+	rc = -ENODEV;
+out:
 	iounmap (io_mem);
-	return 0;
+	return rc;
 }
 
 /*

