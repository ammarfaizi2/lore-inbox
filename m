Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTBYBOJ>; Mon, 24 Feb 2003 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTBYBOJ>; Mon, 24 Feb 2003 20:14:09 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51471 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262838AbTBYBNj>;
	Mon, 24 Feb 2003 20:13:39 -0500
Subject: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <20030225011303.GA5182@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:15 -0800
X-mailer: gregkh_patchbomb
Message-id: <10461357531947@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.1, 2003/02/24 16:24:48-08:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: Clean up the error handling logic for a number of functions, and fix a locking mess.


diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Mon Feb 24 17:16:04 2003
+++ b/drivers/hotplug/ibmphp.h	Mon Feb 24 17:16:04 2003
@@ -761,6 +761,7 @@
 
 extern int ibmphp_init_devno (struct slot **);	/* This function is called from EBDA, so we need it not be static */
 extern int ibmphp_disable_slot (struct hotplug_slot *);	/* This function is called from HPC, so we need it to not be static */
+extern int ibmphp_do_disable_slot (struct slot *slot_cur);
 extern int ibmphp_update_slot_info (struct slot *);	/* This function is called from HPC, so we need it to not be be static */
 extern int ibmphp_configure_card (struct pci_func *, u8);
 extern int ibmphp_unconfigure_card (struct slot **, int);
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:16:04 2003
+++ b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:16:04 2003
@@ -1274,7 +1274,6 @@
 	int rc, i, rcpr;
 	struct slot *slot_cur;
 	u8 function;
-	u8 faulted = 0;
 	struct pci_func *tmp_func;
 
 	ibmphp_lock_operations ();
@@ -1284,16 +1283,7 @@
 
 	if ((rc = validate (slot_cur, ENABLE))) {
 		err ("validate function failed \n");
-		attn_off (slot_cur);	/* need to turn off if was blinking b4 */
-		attn_on (slot_cur);
-		rc = slot_update (&slot_cur);
-		if (rc) {
-			ibmphp_unlock_operations();
-			return rc;
-		}
-		ibmphp_update_slot_info (slot_cur);
-                ibmphp_unlock_operations ();
-		return rc;
+		goto error_nopower;
 	}
 
 	attn_LED_blink (slot_cur);
@@ -1301,10 +1291,7 @@
 	rc = set_bus (slot_cur);
 	if (rc) {
 		err ("was not able to set the bus \n");
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-		ibmphp_unlock_operations ();
-		return -ENODEV;
+		goto error_nopower;
 	}
 
 	/*-----------------debugging------------------------------*/
@@ -1314,18 +1301,12 @@
 
 	rc = check_limitations (slot_cur);
 	if (rc) {
-		err ("Adding this card exceeds the limitations of this bus. \n");
-		err ("(i.e., >1 133MHz cards running on same bus, or >2 66 PCI cards running on same bus \n. Try hot-adding into another bus \n");
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-
-		if (slot_update (&slot_cur)) {
-			ibmphp_unlock_operations ();
-			return -ENODEV;
-		}
-		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return -EINVAL;
+		err ("Adding this card exceeds the limitations of this bus.\n");
+		err ("(i.e., >1 133MHz cards running on same bus, or "
+		     ">2 66 PCI cards running on same bus\n.");
+		err ("Try hot-adding into another bus \n");
+		rc = -EINVAL;
+		goto error_nopower;
 	}
 
 	rc = power_on (slot_cur);
@@ -1338,8 +1319,8 @@
 		if (slot_update (&slot_cur)) {
 			attn_off (slot_cur);
 			attn_on (slot_cur);
-			ibmphp_unlock_operations ();
-			return -ENODEV;
+			rc = -ENODEV;
+			goto exit;
 		}
 		/* Check to see the error of why it failed */
 		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PWRGD (slot_cur->status)))
@@ -1352,8 +1333,7 @@
 			print_card_capability (slot_cur);
 		}
 		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return rc;
+		goto exit;
 	}
 	debug ("after power_on\n");
 	/*-----------------------debugging---------------------------*/
@@ -1362,61 +1342,32 @@
 	/*----------------------------------------------------------*/
 
 	rc = slot_update (&slot_cur);
-	if (rc) {
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-		rcpr = power_off (slot_cur);
-		if (rcpr) {
-			ibmphp_unlock_operations ();
-			return rcpr;
-		}
-		ibmphp_unlock_operations ();
-		return rc;
-	}
+	if (rc)
+		goto error_power;
 	
+	rc = -EINVAL;
 	if (SLOT_POWER (slot_cur->status) && !(SLOT_PWRGD (slot_cur->status))) {
-		faulted = 1;
 		err ("power fault occured trying to power up... \n");
-	} else if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
-		faulted = 1;
+		goto error_power;
+	}
+	if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
 		err ("bus speed mismatch occured.  please check current bus speed and card capability \n");
 		print_card_capability (slot_cur);
+		goto error_power;
 	} 
 	/* Don't think this case will happen after above checks... but just in case, for paranoia sake */
-	else if (!(SLOT_POWER (slot_cur->status))) {
+	if (!(SLOT_POWER (slot_cur->status))) {
 		err ("power on failed... \n");
-		faulted = 1;
-	}
-	if (faulted) {
-		attn_off (slot_cur);	/* need to turn off b4 on */
-		attn_on (slot_cur);
-		rcpr = power_off (slot_cur);
-		if (rcpr) {
-			ibmphp_unlock_operations ();
-			return rcpr;
-		}
-			
-		if (slot_update (&slot_cur)) {                      
-			ibmphp_unlock_operations ();	
-			return -ENODEV;
-		}
-		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return -EINVAL;
+		goto error_power;
 	}
 
 	slot_cur->func = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
-	if (!slot_cur->func) { /* We cannot do update_slot_info here, since no memory for kmalloc n.e.ways, and update_slot_info allocates some */
+	if (!slot_cur->func) {
+		/* We cannot do update_slot_info here, since no memory for
+		 * kmalloc n.e.ways, and update_slot_info allocates some */
 		err ("out of system memory \n");
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-		rcpr = power_off (slot_cur);
-		if (rcpr) {
-			ibmphp_unlock_operations ();
-			return rcpr;
-		}
-		ibmphp_unlock_operations ();
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto error_power;
 	}
 	memset (slot_cur->func, 0, sizeof (struct pci_func));
 	slot_cur->func->busno = slot_cur->bus;
@@ -1431,21 +1382,10 @@
 		ibmphp_unconfigure_card (&slot_cur, 1); /* true because don't need to actually deallocate resources, just remove references */
 		debug ("after unconfigure_card\n");
 		slot_cur->func = NULL;
-		attn_off (slot_cur);	/* need to turn off in case was blinking */
-		attn_on (slot_cur);
-		rcpr = power_off (slot_cur);
-		if (rcpr) {
-			ibmphp_unlock_operations ();
-			return rcpr;
-		}
-		if (slot_update (&slot_cur)) {
-			ibmphp_unlock_operations();
-			return -ENODEV;
-		}
-		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto error_power;
 	}
+
 	function = 0x00;
 	do {
 		tmp_func = ibm_slot_find (slot_cur->bus, slot_cur->func->device, function++);
@@ -1455,13 +1395,36 @@
 
 	attn_off (slot_cur);
 	if (slot_update (&slot_cur)) {
-		ibmphp_unlock_operations ();
-		return -EFAULT;
+		rc = -EFAULT;
+		goto exit;
 	}
 	ibmphp_print_test ();
 	rc = ibmphp_update_slot_info (slot_cur);
+exit:
 	ibmphp_unlock_operations(); 
 	return rc;
+
+error_nopower:
+	attn_off (slot_cur);	/* need to turn off if was blinking b4 */
+	attn_on (slot_cur);
+error_cont:
+	rcpr = slot_update (&slot_cur);
+	if (rcpr) {
+		rc = rcpr;
+		goto exit;
+	}
+	ibmphp_update_slot_info (slot_cur);
+	goto exit;
+
+error_power:
+	attn_off (slot_cur);	/* need to turn off if was blinking b4 */
+	attn_on (slot_cur);
+	rcpr = power_off (slot_cur);
+	if (rcpr) {
+		rc = rcpr;
+		goto exit;
+	}
+	goto error_cont;
 }
 
 /**************************************************************
@@ -1472,45 +1435,34 @@
 **************************************************************/
 int ibmphp_disable_slot (struct hotplug_slot *hotplug_slot)
 {
+	struct slot *slot = hotplug_slot->private;
+	int rc;
+	
+	ibmphp_lock_operations();
+	rc = ibmphp_do_disable_slot(slot);
+	ibmphp_unlock_operations();
+	return rc;
+}
+
+int ibmphp_do_disable_slot (struct slot *slot_cur)
+{
 	int rc;
-	struct slot *slot_cur = (struct slot *) hotplug_slot->private;
 	u8 flag;
 	int parm = 0;
 
 	debug ("DISABLING SLOT... \n"); 
 		
-	if (slot_cur == NULL) {
-		ibmphp_unlock_operations (); 
-		return -ENODEV;
-	}
-	
-	if (slot_cur->ctrl == NULL) {
-		ibmphp_unlock_operations ();
+	if ((slot_cur == NULL) || (slot_cur->ctrl == NULL)) {
 		return -ENODEV;
 	}
 	
-	flag = slot_cur->flag;	/* to see if got here from polling */
-	
-	if (flag)
-		ibmphp_lock_operations ();
-	
+	flag = slot_cur->flag;
 	slot_cur->flag = TRUE;
 
 	if (flag == TRUE) {
 		rc = validate (slot_cur, DISABLE);	/* checking if powered off already & valid slot # */
-		if (rc) {
-			/*  Need to turn off if was blinking b4 */
-			attn_off (slot_cur);
-			attn_on (slot_cur);
-			if (slot_update (&slot_cur)) {
-				ibmphp_unlock_operations ();
-				return -EFAULT;
-			}
-		
-			ibmphp_update_slot_info (slot_cur);
-			ibmphp_unlock_operations ();
-			return rc;
-		}
+		if (rc)
+			goto error;
 	}
 	attn_LED_blink (slot_cur);
 
@@ -1519,10 +1471,8 @@
 		slot_cur->func = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 		if (!slot_cur->func) {
 			err ("out of system memory \n");
-			attn_off (slot_cur);
-			attn_on (slot_cur);
-			ibmphp_unlock_operations ();
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto error;
 		}
 		memset (slot_cur->func, 0, sizeof (struct pci_func));
 		slot_cur->func->busno = slot_cur->bus;
@@ -1531,11 +1481,9 @@
 
 	if ((rc = ibm_unconfigure_device (slot_cur->func))) {
 		err ("removing from kernel failed... \n");
-		err ("Please check to see if it was statically linked or is in use otherwise. (perhaps the driver is not 'hot-removable')\n");
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-		ibmphp_unlock_operations ();
-		return rc;
+		err ("Please check to see if it was statically linked or is "
+		     "in use otherwise. (perhaps the driver is not 'hot-removable')\n");
+		goto error;
 	}
         
 	/* If we got here from latch suddenly opening on operating card or 
@@ -1554,43 +1502,34 @@
 	debug ("in disable_slot. after unconfigure_card\n");
 	if (rc) {
 		err ("could not unconfigure card.\n");
-		attn_off (slot_cur);	/* need to turn off if was blinking b4 */
-		attn_on (slot_cur);
-
-		if (slot_update (&slot_cur)) {
-			ibmphp_unlock_operations ();
-			return -EFAULT;
-		}
-
-		if (flag)
-			ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return -EFAULT;
+		goto error;
 	}
 
-	rc = ibmphp_hpc_writeslot (hotplug_slot->private, HPC_SLOT_OFF);
-	if (rc) {
-		attn_off (slot_cur);
-		attn_on (slot_cur);
-		if (slot_update (&slot_cur)) {
-			ibmphp_unlock_operations ();
-			return -EFAULT;
-		}
-
-		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations ();
-		return rc;
-	}
+	rc = ibmphp_hpc_writeslot (slot_cur, HPC_SLOT_OFF);
+	if (rc)
+		goto error;
 
 	attn_off (slot_cur);
-	if (slot_update (&slot_cur)) {
-		ibmphp_unlock_operations ();
-		return -EFAULT;
-	}
+	rc = slot_update (&slot_cur);
+	if (rc)
+		goto exit;
+
 	rc = ibmphp_update_slot_info (slot_cur);
 	ibmphp_print_test ();
-	ibmphp_unlock_operations();
+exit:
 	return rc;
+
+error:
+	/*  Need to turn off if was blinking b4 */
+	attn_off (slot_cur);
+	attn_on (slot_cur);
+	if (slot_update (&slot_cur)) {
+		rc = -EFAULT;
+		goto exit;
+	}
+	if (flag)		
+		ibmphp_update_slot_info (slot_cur);
+	goto exit;
 }
 
 struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
@@ -1622,6 +1561,7 @@
 	debug ("after ebda hpc \n");
 	ibmphp_free_ebda_pci_rsrc_queue ();
 	debug ("after ebda pci rsrc \n");
+	kfree (ibmphp_pci_bus);
 }
 
 static int __init ibmphp_init (void)
@@ -1637,13 +1577,15 @@
 	ibmphp_pci_bus = kmalloc (sizeof (*ibmphp_pci_bus), GFP_KERNEL);
 	if (!ibmphp_pci_bus) {
 		err ("out of memory\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto exit;
 	}
 
 	bus = ibmphp_find_bus (0);
 	if (!bus) {
 		err ("Can't find the root pci bus, can not continue\n");
-		return -ENODEV;
+		rc -ENODEV;
+		goto error;
 	}
 	memcpy (ibmphp_pci_bus, bus, sizeof (*ibmphp_pci_bus));
 
@@ -1654,39 +1596,39 @@
 	for (i = 0; i < 16; i++)
 		irqs[i] = 0;
 
-	if ((rc = ibmphp_access_ebda ())) {
-		ibmphp_unload ();
-		return rc;
-	}
+	if ((rc = ibmphp_access_ebda ()))
+		goto error;
 	debug ("after ibmphp_access_ebda ()\n");
 
-	if ((rc = ibmphp_rsrc_init ())) {
-		ibmphp_unload ();
-		return rc;
-	}
+	if ((rc = ibmphp_rsrc_init ()))
+		goto error;
 	debug ("AFTER Resource & EBDA INITIALIZATIONS\n");
 
 	max_slots = get_max_slots ();
 	
-	if ((rc = ibmphp_register_pci ())) {
-		ibmphp_unload ();
-		return rc;
-	}
+	if ((rc = ibmphp_register_pci ()))
+		goto error;
 
 	if (init_ops ()) {
-		ibmphp_unload ();
-		return -ENODEV;
+		rc = -ENODEV;
+		goto error;
 	}
+
 	ibmphp_print_test ();
 	if ((rc = ibmphp_hpc_start_poll_thread ())) {
-		ibmphp_unload ();
-		return -ENODEV;
+		goto error;
 	}
 
-	/* if no NVRAM module selected, lock ourselves into memory with a 
-	 * module count of -1 so that no one can unload us. */
+	/* lock ourselves into memory with a module 
+	 * count of -1 so that no one can unload us. */
 	MOD_DEC_USE_COUNT;
-	return 0;
+
+exit:
+	return rc;
+
+error:
+	ibmphp_unload ();
+	goto exit;
 }
 
 static void __exit ibmphp_exit (void)
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Mon Feb 24 17:16:04 2003
+++ b/drivers/hotplug/ibmphp_hpc.c	Mon Feb 24 17:16:04 2003
@@ -1063,7 +1063,7 @@
 	if (disable) {
 		debug ("process_changeinstatus - disable slot\n");
 		pslot->flag = FALSE;
-		rc = ibmphp_disable_slot (pslot->hotplug_slot);
+		rc = ibmphp_do_disable_slot (pslot);
 	}
 
 	if (update || disable) {

