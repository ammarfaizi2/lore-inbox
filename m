Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTBFEC6>; Wed, 5 Feb 2003 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBFEC6>; Wed, 5 Feb 2003 23:02:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44048 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265351AbTBFECv>;
	Wed, 5 Feb 2003 23:02:51 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <1044504483994@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044842980@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.2, 2003/02/05 17:15:55+11:00, greg@kroah.com

[PATCH] IBM PCI Hotplug driver: Clean up the slot filename generation logic a lot.


diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Thu Feb  6 14:52:23 2003
+++ b/drivers/hotplug/ibmphp_ebda.c	Thu Feb  6 14:52:23 2003
@@ -65,8 +65,6 @@
 static LIST_HEAD (opt_lo_head);
 static void *io_mem;
 
-char *chassis_str, *rxe_str, *str;
-
 /* Local functions */
 static int ebda_rsrc_controller (void);
 static int ebda_rsrc_rsrc (void);
@@ -591,32 +589,6 @@
 	return 0;	
 }
 	
-static char *convert_2digits_to_char (int var)
-{
-	int bit;	
-	char *str1;
-
-	str = (char *) kmalloc (3, GFP_KERNEL);
-	memset (str, 0, 3);
-	str1 = (char *) kmalloc (2, GFP_KERNEL);
-	memset (str, 0, 3);
-	bit = (int)(var / 10);
-	switch (bit) {
-	case 0:
-		//one digit number
-		*str = (char)(var + 48);
-		return str;
-	default: 	
-		//2 digits number
-		*str1 = (char)(bit + 48);
-		strncpy (str, str1, 1);
-		memset (str1, 0, 3);
-		*str1 = (char)((var % 10) + 48);
-		strcat (str, str1);
-		return str;
-	}	
-	return NULL;	
-}
 
 /* Since we don't know the max slot number per each chassis, hence go
  * through the list of all chassis to find out the range
@@ -701,7 +673,7 @@
 {
 	struct opt_rio *opt_vg_ptr = NULL;
 	struct opt_rio_lo *opt_lo_ptr = NULL;
-	char *ptr_chassis_num, *ptr_rxe_num, *ptr_slot_num;
+	static char str[30];
 	int which = 0; /* rxe = 1, chassis = 0 */
 	u8 number = 1; /* either chassis or rxe # */
 	u8 first_slot = 1;
@@ -715,19 +687,7 @@
 	
 	slot_num = slot_cur->number;
 
-	chassis_str = (char *) kmalloc (30, GFP_KERNEL);
-	memset (chassis_str, 0, 30);
-	rxe_str = (char *) kmalloc (30, GFP_KERNEL);
-	memset (rxe_str, 0, 30);
-	ptr_chassis_num = (char *) kmalloc (3, GFP_KERNEL);
-	memset (ptr_chassis_num, 0, 3);
-	ptr_rxe_num = (char *) kmalloc (3, GFP_KERNEL);
-	memset (ptr_rxe_num, 0, 3);
-	ptr_slot_num = (char *) kmalloc (3, GFP_KERNEL);
-	memset (ptr_slot_num, 0, 3);
-	
-	strcpy (chassis_str, "chassis");
-	strcpy (rxe_str, "rxe");
+	memset (str, 0, sizeof(str));
 	
 	if (rio_table_ptr) {
 		if (rio_table_ptr->ver_num == 3) {
@@ -772,31 +732,10 @@
 		}
 	}
 
-	switch (which) {
-	case 0:
-		/* Chassis */
-		*ptr_chassis_num = (char)(number + 48);
-		strcat (chassis_str, ptr_chassis_num);
-		kfree (ptr_chassis_num);
-		strcat (chassis_str, "slot");
-		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
-		strcat (chassis_str, ptr_slot_num);
-		kfree (ptr_slot_num);
-		return chassis_str;
-		break;
-	case 1:
-		/* RXE */
-		*ptr_rxe_num = (char)(number + 48);
-		strcat (rxe_str, ptr_rxe_num);
-		kfree (ptr_rxe_num);
-		strcat (rxe_str, "slot");
-		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
-		strcat (rxe_str, ptr_slot_num);
-		kfree (ptr_slot_num);
-		return rxe_str;
-		break;
-	}	
-	return NULL;
+	sprintf(str, "%s%dslot%d",
+		which == 0 ? "chassis" : "rxe",
+		number, slot_num - first_slot + 1);
+	return str;
 }
 
 static struct pci_driver ibmphp_driver;
@@ -1060,10 +999,6 @@
 		slot_cur = list_entry (list, struct slot, ibm_slot_list);
 
 		snprintf (slot_cur->hotplug_slot->name, 30, "%s", create_file_name (slot_cur));
-		if (chassis_str) 
-			kfree (chassis_str);
-		if (rxe_str)
-			kfree (rxe_str);
 		pci_hp_register (slot_cur->hotplug_slot);
 	}
 

