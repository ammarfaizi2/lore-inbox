Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTEBSpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTEBSow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:44:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45227 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263091AbTEBSoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:44:18 -0400
Date: Fri, 2 May 2003 11:57:34 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug fixes for 2.4.21-rc1
Message-ID: <20030502185733.GC14728@kroah.com>
References: <20030502185406.GA14728@kroah.com> <20030502185701.GB14728@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502185701.GB14728@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143, 2003/05/02 11:35:34-07:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: fix up a lot of memory allocations and leaks just to figure out a slot name.


 drivers/hotplug/ibmphp_ebda.c |   84 +++---------------------------------------
 1 files changed, 6 insertions(+), 78 deletions(-)


diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Fri May  2 11:39:04 2003
+++ b/drivers/hotplug/ibmphp_ebda.c	Fri May  2 11:39:04 2003
@@ -65,8 +65,6 @@
 static LIST_HEAD (opt_lo_head);
 static void *io_mem;
 
-char *chassis_str, *rxe_str, *str;
-
 /* Local functions */
 static int ebda_rsrc_controller (void);
 static int ebda_rsrc_rsrc (void);
@@ -591,39 +589,6 @@
 	return 0;	
 }
 	
-static char *convert_2digits_to_char (int var)
-{
-	int bit;	
-	char *str1;
-
-	str = (char *) kmalloc (3, GFP_KERNEL);
-	if (!str)
-		return NULL;
-	memset (str, 0, 3);
-	bit = (int)(var / 10);
-	switch (bit) {
-	case 0:
-		//one digit number
-		*str = (char)(var + 48);
-		return str;
-	default: 	
-		//2 digits number
-		str1 = (char *) kmalloc (2, GFP_KERNEL);
-		if (!str1) {
-			break;
-		}
-		memset (str, 0, 3);
-		*str1 = (char)(bit + 48);
-		strncpy (str, str1, 1);
-		memset (str1, 0, 3);
-		*str1 = (char)((var % 10) + 48);
-		strcat (str, str1);
-		kfree(str1);
-		return str;
-	}
-	kfree(str);
-	return NULL;	
-}
 
 /* Since we don't know the max slot number per each chassis, hence go
  * through the list of all chassis to find out the range
@@ -708,7 +673,7 @@
 {
 	struct opt_rio *opt_vg_ptr = NULL;
 	struct opt_rio_lo *opt_lo_ptr = NULL;
-	char *ptr_chassis_num, *ptr_rxe_num, *ptr_slot_num;
+	static char str[30];
 	int which = 0; /* rxe = 1, chassis = 0 */
 	u8 number = 1; /* either chassis or rxe # */
 	u8 first_slot = 1;
@@ -722,19 +687,7 @@
 	
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
@@ -779,31 +732,10 @@
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
@@ -1079,10 +1011,6 @@
 		slot_cur = list_entry (list, struct slot, ibm_slot_list);
 
 		snprintf (slot_cur->hotplug_slot->name, 30, "%s", create_file_name (slot_cur));
-		if (chassis_str) 
-			kfree (chassis_str);
-		if (rxe_str)
-			kfree (rxe_str);
 		pci_hp_register (slot_cur->hotplug_slot);
 	}
 
