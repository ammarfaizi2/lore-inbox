Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTF0CnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTF0CnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:17 -0400
Received: from granite.he.net ([216.218.226.66]:38159 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263365AbTF0Cm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:42:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751051325@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <10566751043125@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:45 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1502, 2003/06/26 16:05:27-07:00, greg@kroah.com

[PATCH] PCI Hotplug: ibmphp: add release() callback and other minor cleanups


 drivers/pci/hotplug/ibmphp.h      |    3 -
 drivers/pci/hotplug/ibmphp_core.c |   25 +-----------
 drivers/pci/hotplug/ibmphp_ebda.c |   79 +++++++++++++++++++++++++++++++++-----
 drivers/pci/hotplug/ibmphp_hpc.c  |   68 --------------------------------
 4 files changed, 74 insertions(+), 101 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
--- a/drivers/pci/hotplug/ibmphp.h	Thu Jun 26 17:39:02 2003
+++ b/drivers/pci/hotplug/ibmphp.h	Thu Jun 26 17:39:02 2003
@@ -7,7 +7,7 @@
  * Written By: Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
  * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (c) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
@@ -398,7 +398,6 @@
 extern int ibmphp_hpc_writeslot (struct slot *, u8);
 extern void ibmphp_lock_operations (void);
 extern void ibmphp_unlock_operations (void);
-extern int ibmphp_hpc_fillhpslotinfo (struct hotplug_slot *);
 extern int ibmphp_hpc_start_poll_thread (void);
 extern void ibmphp_hpc_stop_poll_thread (void);
 
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Thu Jun 26 17:39:02 2003
+++ b/drivers/pci/hotplug/ibmphp_core.c	Thu Jun 26 17:39:02 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Chuck Cole, Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
@@ -739,26 +739,8 @@
 	debug ("%s -- enter\n", __FUNCTION__);
 
 	list_for_each_safe (tmp, next, &ibmphp_slot_head) {
-	
 		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
-
 		pci_hp_deregister (slot_cur->hotplug_slot);
-
-		if (slot_cur->hotplug_slot) {
-			kfree (slot_cur->hotplug_slot);
-			slot_cur->hotplug_slot = NULL;
-		}
-
-		if (slot_cur->ctrl) 
-			slot_cur->ctrl = NULL;
-		
-		if (slot_cur->bus_on) 
-			slot_cur->bus_on = NULL;
-
-		ibmphp_unconfigure_card (&slot_cur, -1);  /* we don't want to actually remove the resources, since free_resources will do just that */
-
-		kfree (slot_cur);
-		slot_cur = NULL;
 	}
 	debug ("%s -- exit\n", __FUNCTION__);
 }
@@ -1221,7 +1203,6 @@
 {
 	int rc;
 	u8 flag;
-	int parm = 0;
 
 	debug ("DISABLING SLOT... \n"); 
 		
@@ -1270,7 +1251,7 @@
 		return 0;
 	}
 
-	rc = ibmphp_unconfigure_card (&slot_cur, parm);
+	rc = ibmphp_unconfigure_card (&slot_cur, 0);
 	slot_cur->func = NULL;
 	debug ("in disable_slot. after unconfigure_card\n");
 	if (rc) {
diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	Thu Jun 26 17:39:02 2003
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	Thu Jun 26 17:39:02 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Tong Yu, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
@@ -727,6 +727,64 @@
 	return str;
 }
 
+static int fillslotinfo(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot;
+	int rc = 0;
+
+	if (!hotplug_slot || !hotplug_slot->private)
+		return -EINVAL;
+
+	slot = hotplug_slot->private;
+	rc = ibmphp_hpc_readslot(slot, READ_ALLSTAT, NULL);
+	if (rc)
+		return rc;
+
+	// power - enabled:1  not:0
+	hotplug_slot->info->power_status = SLOT_POWER(slot->status);
+
+	// attention - off:0, on:1, blinking:2
+	hotplug_slot->info->attention_status = SLOT_ATTN(slot->status, slot->ext_status);
+
+	// latch - open:1 closed:0
+	hotplug_slot->info->latch_status = SLOT_LATCH(slot->status);
+
+	// pci board - present:1 not:0
+	if (SLOT_PRESENT (slot->status))
+		hotplug_slot->info->adapter_status = 1;
+	else
+		hotplug_slot->info->adapter_status = 0;
+/*
+	if (slot->bus_on->supported_bus_mode
+		&& (slot->bus_on->supported_speed == BUS_SPEED_66))
+		hotplug_slot->info->max_bus_speed_status = BUS_SPEED_66PCIX;
+	else
+		hotplug_slot->info->max_bus_speed_status = slot->bus_on->supported_speed;
+*/
+
+	return rc;
+}
+
+static void release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot;
+
+	if (!hotplug_slot || !hotplug_slot->private)
+		return;
+
+	slot = hotplug_slot->private;
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	slot->ctrl = NULL;
+	slot->bus_on = NULL;
+
+	/* we don't want to actually remove the resources, since free_resources will do just that */
+	ibmphp_unconfigure_card(&slot, -1);
+
+	kfree (slot);
+}
+
 static struct pci_driver ibmphp_driver;
 
 /*
@@ -900,32 +958,32 @@
 		// register slots with hpc core as well as create linked list of ibm slot
 		for (index = 0; index < hpc_ptr->slot_count; index++) {
 
-			hp_slot_ptr = (struct hotplug_slot *) kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
+			hp_slot_ptr = kmalloc(sizeof(*hp_slot_ptr), GFP_KERNEL);
 			if (!hp_slot_ptr) {
 				rc = -ENOMEM;
 				goto error_no_hp_slot;
 			}
-			memset (hp_slot_ptr, 0, sizeof (struct hotplug_slot));
+			memset(hp_slot_ptr, 0, sizeof(*hp_slot_ptr));
 
-			hp_slot_ptr->info = (struct hotplug_slot_info *) kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
+			hp_slot_ptr->info = kmalloc (sizeof(struct hotplug_slot_info), GFP_KERNEL);
 			if (!hp_slot_ptr->info) {
 				rc = -ENOMEM;
 				goto error_no_hp_info;
 			}
-			memset (hp_slot_ptr->info, 0, sizeof (struct hotplug_slot_info));
+			memset(hp_slot_ptr->info, 0, sizeof(struct hotplug_slot_info));
 
-			hp_slot_ptr->name = (char *) kmalloc (30, GFP_KERNEL);
+			hp_slot_ptr->name = kmalloc(30, GFP_KERNEL);
 			if (!hp_slot_ptr->name) {
 				rc = -ENOMEM;
 				goto error_no_hp_name;
 			}
 
-			tmp_slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
+			tmp_slot = kmalloc(sizeof(*tmp_slot), GFP_KERNEL);
 			if (!tmp_slot) {
 				rc = -ENOMEM;
 				goto error_no_slot;
 			}
-			memset (tmp_slot, 0, sizeof (*tmp_slot));
+			memset(tmp_slot, 0, sizeof(*tmp_slot));
 
 			tmp_slot->flag = TRUE;
 
@@ -959,8 +1017,9 @@
 			tmp_slot->hotplug_slot = hp_slot_ptr;
 
 			hp_slot_ptr->private = tmp_slot;
+			hp_slot_ptr->release = release_slot;
 
-			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
+			rc = fillslotinfo(hp_slot_ptr);
 			if (rc)
 				goto error;
 
diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	Thu Jun 26 17:39:02 2003
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	Thu Jun 26 17:39:02 2003
@@ -3,7 +3,7 @@
  *
  * Written By: Jyoti Shah, IBM Corporation
  *
- * Copyright (c) 2001-2002 IBM Corp.
+ * Copyright (c) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
@@ -114,7 +114,6 @@
 static void get_hpc_access (void);
 static void free_hpc_access (void);
 static void poll_hpc (void);
-static int update_slot (struct slot *, u8);
 static int process_changeinstatus (struct slot *, struct slot *);
 static int process_changeinlatch (u8, u8, struct controller *);
 static int hpc_poll_thread (void *);
@@ -916,71 +915,6 @@
 	debug ("%s - Exit\n", __FUNCTION__);
 }
 
-
-/* ----------------------------------------------------------------------
- *  Name:    ibmphp_hpc_fillhpslotinfo(hotplug_slot * phpslot)
- *
- *  Action:  fill out the hotplug_slot info
- *
- *  Input:   pointer to hotplug_slot
- *
- *  Return
- *  Value:   0 or error codes
- *-----------------------------------------------------------------------*/
-int ibmphp_hpc_fillhpslotinfo (struct hotplug_slot *phpslot)
-{
-	int rc = 0;
-	struct slot *pslot;
-
-	if (phpslot && phpslot->private) {
-		pslot = (struct slot *) phpslot->private;
-		rc = update_slot (pslot, (u8) TRUE);
-		if (!rc) {
-
-			// power - enabled:1  not:0
-			phpslot->info->power_status = SLOT_POWER (pslot->status);
-
-			// attention - off:0, on:1, blinking:2
-			phpslot->info->attention_status = SLOT_ATTN (pslot->status, pslot->ext_status);
-
-			// latch - open:1 closed:0
-			phpslot->info->latch_status = SLOT_LATCH (pslot->status);
-
-			// pci board - present:1 not:0
-			if (SLOT_PRESENT (pslot->status))
-				phpslot->info->adapter_status = 1;
-			else
-				phpslot->info->adapter_status = 0;
-/*
-			if (pslot->bus_on->supported_bus_mode
-				&& (pslot->bus_on->supported_speed == BUS_SPEED_66))
-				phpslot->info->max_bus_speed_status = BUS_SPEED_66PCIX;
-			else
-				phpslot->info->max_bus_speed_status = pslot->bus_on->supported_speed;
-*/		} else
-			rc = -EINVAL;
-	} else
-		rc = -EINVAL;
-
-	return rc;
-}
-
-/*----------------------------------------------------------------------
-* Name:    update_slot
-*
-* Action:  fill out slot status and extended status, controller status
-*
-* Input:   pointer to slot struct
-*---------------------------------------------------------------------*/
-static int update_slot (struct slot *pslot, u8 update)
-{
-	int rc = 0;
-
-	debug ("%s - Entry pslot[%p]\n", __FUNCTION__, pslot);
-	rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
-	debug ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
-	return rc;
-}
 
 /*----------------------------------------------------------------------
 * Name:    process_changeinstatus

