Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTBYBPh>; Mon, 24 Feb 2003 20:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTBYBOT>; Mon, 24 Feb 2003 20:14:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54287 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264646AbTBYBNo>;
	Mon, 24 Feb 2003 20:13:44 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357562562@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135760965@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.3, 2003/02/24 16:25:54-08:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: get rid of unneeded ops structure and surrounding logic.


diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Mon Feb 24 17:15:55 2003
+++ b/drivers/hotplug/ibmphp.h	Mon Feb 24 17:15:55 2003
@@ -683,11 +683,6 @@
 #define ENABLE		1
 #define DISABLE		0
 
-#define ADD		0
-#define REMOVE		1
-#define DETAIL		2
-
-#define MAX_OPS		3
 #define CARD_INFO	0x07
 #define PCIX133		0x07
 #define PCIX66		0x05
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:55 2003
+++ b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:55 2003
@@ -55,7 +55,6 @@
 MODULE_LICENSE ("GPL");
 MODULE_DESCRIPTION (DRIVER_DESC);
 
-static int *ops[MAX_OPS + 1];
 struct pci_bus *ibmphp_pci_bus;
 static int max_slots;
 
@@ -550,20 +549,6 @@
 	struct list_head *tmp;
 	int retval;
 	int rc;
-	int j;
-
-	for (j = 0; j < MAX_OPS; j++) {
-		ops[j] = (int *) kmalloc ((max_slots + 1) * sizeof (int), GFP_KERNEL);
-		memset (ops[j], 0, (max_slots + 1) * sizeof (int));
-		if (!ops[j]) {
-			err ("out of system memory \n");
-			return -ENOMEM;
-		}
-	}
-
-	ops[ADD][0] = 0;
-	ops[REMOVE][0] = 0;
-	ops[DETAIL][0] = 0;
 
 	list_for_each (tmp, &ibmphp_slot_head) {
 		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
@@ -588,24 +573,15 @@
 		if (retval)
 			return retval;
 
-		debug ("status = %x, ext_status = %x\n", slot_cur->status, slot_cur->ext_status);
-		debug ("SLOT_POWER = %x, SLOT_PRESENT = %x, SLOT_LATCH = %x\n", SLOT_POWER (slot_cur->status), SLOT_PRESENT (slot_cur->status), SLOT_LATCH (slot_cur->status));
-
-		if (!(SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
-			/* No power, adapter, and latch closed */
-			ops[ADD][slot_cur->number] = 1;
-		else
-			ops[ADD][slot_cur->number] = 0;
-
-		ops[DETAIL][slot_cur->number] = 1;
-
-		if ((SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
-			/*Power,adapter,latch closed */
-			ops[REMOVE][slot_cur->number] = 1;
-		else
-			ops[REMOVE][slot_cur->number] = 0;
-
-		if ((SLOT_PWRGD (slot_cur->status)) && !(SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status))) {
+		debug ("status = %x\n", slot_cur->status);
+		debug ("ext_status = %x\n", slot_cur->ext_status);
+		debug ("SLOT_POWER = %x\n", SLOT_POWER (slot_cur->status));
+		debug ("SLOT_PRESENT = %x\n", SLOT_PRESENT (slot_cur->status));
+		debug ("SLOT_LATCH = %x\n", SLOT_LATCH (slot_cur->status));
+
+		if ((SLOT_PWRGD (slot_cur->status)) && 
+		    !(SLOT_PRESENT (slot_cur->status)) && 
+		    !(SLOT_LATCH (slot_cur->status))) {
 			debug ("BEFORE POWER OFF COMMAND\n");
 				rc = power_off (slot_cur);
 				if (rc)
@@ -643,35 +619,20 @@
 	if (retval)
 		return retval;
 
-	if (!(SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
-	    && !(SLOT_LATCH (slot_cur->status)))
-		ops[ADD][number] = 1;
-	else
-		ops[ADD][number] = 0;
-
-	ops[DETAIL][number] = 1;
-
-	if ((SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
-	    && !(SLOT_LATCH (slot_cur->status)))
-		ops[REMOVE][number] = 1;
-	else
-		ops[REMOVE][number] = 0;
-
 	switch (opn) {
 		case ENABLE:
-			if (ops[ADD][number])
+			if (!(SLOT_PWRGD (slot_cur->status)) && 
+			     (SLOT_PRESENT (slot_cur->status)) && 
+			     !(SLOT_LATCH (slot_cur->status)))
 				return 0;
 			break;
 		case DISABLE:
-			if (ops[REMOVE][number])
-				return 0;
-			break;
-		case DETAIL:
-			if (ops[DETAIL][number])
+			if ((SLOT_PWRGD (slot_cur->status)) && 
+			    (SLOT_PRESENT (slot_cur->status)) &&
+			    !(SLOT_LATCH (slot_cur->status)))
 				return 0;
 			break;
 		default:
-			return -EINVAL;
 			break;
 	}
 	err ("validate failed....\n");

