Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUBIXbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUBIX2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:28:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:1725 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265444AbUBIXWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:45 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689403898@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:20 -0800
Message-Id: <10763689403720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.15, 2004/02/03 16:49:40-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: kill hpcrc from several functions in ibmphp_core.c

This patch kills the variable hpcrc from many places. It is used as a
temporary storage for the return code before this is copied to rc which
contains the "real" return code. There are some checks if to copy or not
but at the end they will always have the same value, so we can directly
put the return code in rc and kill hpcrc.


 drivers/pci/hotplug/ibmphp_core.c |   93 +++++++++++---------------------------
 1 files changed, 27 insertions(+), 66 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:58:47 2004
+++ b/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:58:47 2004
@@ -104,7 +104,7 @@
 	if (rc) 
 		return rc;
 	if (!init_flag)
-		return get_cur_bus_info (sl);
+		rc = get_cur_bus_info(sl);
 	return rc;
 }
 
@@ -208,7 +208,7 @@
 		err ("command not completed successfully in power_off\n");
 		retval = -EIO;
 	}
-	return 0;
+	return retval;
 }
 
 static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 value)
@@ -216,7 +216,6 @@
 	int rc = 0;
 	struct slot *pslot;
 	u8 cmd;
-	int hpcrc = 0;
 
 	debug ("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n", (ulong) hotplug_slot, value);
 	ibmphp_lock_operations ();
@@ -241,16 +240,13 @@
 		if (rc == 0) {
 			pslot = (struct slot *) hotplug_slot->private;
 			if (pslot)
-				hpcrc = ibmphp_hpc_writeslot (pslot, cmd);
+				rc = ibmphp_hpc_writeslot(pslot, cmd);
 			else
 				rc = -ENODEV;
 		}
 	} else	
 		rc = -ENODEV;
 
-	if (hpcrc)
-		rc = hpcrc;
-
 	ibmphp_unlock_operations ();
 
 	debug ("set_attention_status - Exit rc[%d]\n", rc);
@@ -261,7 +257,6 @@
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	int hpcrc = 0;
 	struct slot myslot;
 
 	debug ("get_attention_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
@@ -271,22 +266,16 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
-			if (!hpcrc)
-				hpcrc = ibmphp_hpc_readslot (pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
-			if (!hpcrc) {
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			if (!rc)
+				rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
+			if (!rc)
 				*value = SLOT_ATTN (myslot.status, myslot.ext_status);
-				rc = 0;
-			}
 		}
-	} else
-		rc = -ENODEV;
-
-	if (hpcrc)
-		rc = hpcrc;
+	}
 
 	ibmphp_unlock_operations ();
-	debug ("get_attention_status - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug("get_attention_status - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
@@ -294,7 +283,6 @@
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	int hpcrc = 0;
 	struct slot myslot;
 
 	debug ("get_latch_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
@@ -303,20 +291,14 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
-			if (!hpcrc) {
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			if (!rc)
 				*value = SLOT_LATCH (myslot.status);
-				rc = 0;
-			}
 		}
-	} else
-		rc = -ENODEV;
-
-	if (hpcrc)
-		rc = hpcrc;
+	}
 
 	ibmphp_unlock_operations ();
-	debug ("get_latch_status - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug("get_latch_status - Exit rc[%d] rc[%x] value[%x]\n", rc, rc, *value);
 	return rc;
 }
 
@@ -325,7 +307,6 @@
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	int hpcrc = 0;
 	struct slot myslot;
 
 	debug ("get_power_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
@@ -334,20 +315,14 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
-			if (!hpcrc) {
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			if (!rc)
 				*value = SLOT_PWRGD (myslot.status);
-				rc = 0;
-			}
 		}
-	} else
-		rc = -ENODEV;
-
-	if (hpcrc)
-		rc = hpcrc;
+	}
 
 	ibmphp_unlock_operations ();
-	debug ("get_power_status - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug("get_power_status - Exit rc[%d] rc[%x] value[%x]\n", rc, rc, *value);
 	return rc;
 }
 
@@ -356,7 +331,6 @@
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 present;
-	int hpcrc = 0;
 	struct slot myslot;
 
 	debug ("get_adapter_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
@@ -365,23 +339,19 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
-			if (!hpcrc) {
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			if (!rc) {
 				present = SLOT_PRESENT (myslot.status);
 				if (present == HPC_SLOT_EMPTY)
 					*value = 0;
 				else
 					*value = 1;
-				rc = 0;
 			}
 		}
-	} else
-		rc = -ENODEV;
-	if (hpcrc)
-		rc = hpcrc;
+	}
 
 	ibmphp_unlock_operations ();
-	debug ("get_adapter_present - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug("get_adapter_present - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
@@ -475,7 +445,6 @@
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	int hpcrc = 0;
 	struct slot myslot;
 
 	debug ("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
@@ -487,29 +456,21 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
 
 			if (!(SLOT_LATCH (myslot.status)) && (SLOT_PRESENT (myslot.status))) {
-				hpcrc = ibmphp_hpc_readslot (pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
-				if (!hpcrc) {
+				rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
+				if (!rc)
 					*value = SLOT_SPEED (myslot.ext_status);
-					rc = 0;
-				}
-			} else {
+			} else
 				*value = MAX_ADAPTER_NONE;
-				rc = 0;
-			}
                 }
-        } else
-		rc = -ENODEV;
-
-	if (hpcrc)
-		rc = hpcrc;
+	}
 
 	if (flag)
 		ibmphp_unlock_operations ();
 
-	debug ("get_max_adapter_speed_1 - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 

