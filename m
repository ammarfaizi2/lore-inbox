Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263486AbTCNUET>; Fri, 14 Mar 2003 15:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263487AbTCNUET>; Fri, 14 Mar 2003 15:04:19 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:8361 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263486AbTCNUEP>;
	Fri, 14 Mar 2003 15:04:15 -0500
Date: Fri, 14 Mar 2003 23:14:04 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Greg KH <greg@kroah.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, zubarev@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Message-ID: <20030314201404.GE22018@linuxhacker.ru>
References: <20030313204556.GA3475@linuxhacker.ru> <20030314003143.GA1787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314003143.GA1787@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 13, 2003 at 04:31:44PM -0800, Greg KH wrote:
> >    There seem to be memleak convert_2digits_to_char() function that is triggered
> >    during normal operations.
> >    Also I think there are some memleaks on error exit paths
> >    ebda_rsrc_controller()
> >    All of this is addressed by below patch.
> >    2.5 seems to have totally different version of this code (and no
> >    convert_2digits_to_char() function at all for example).
> Yes, the 2.5 version should be backported to 2.4.  There have been a
> number of error patch fixes in the 2.5 version, care to make up a patch?

Ok, see below.
Note there is no credit for me. Your 2 patches from 2.5 applied to 2.4
just fine even without offsets, and stuff compiled (I have no hardware to test
how it works, but I presume it will work ok). 
Comments for patches were:
C IBM PCI Hotplug driver: Clean up the slot filename generation logic a lot.
C IBM PCI Hotplug: fix a load of memory leak errors found by the checker project
.

Bye,
    Oleg
===== drivers/hotplug/ibmphp_ebda.c 1.7 vs 1.8 =====
--- 1.7/drivers/hotplug/ibmphp_ebda.c	Sat Nov 23 05:00:44 2002
+++ 1.8/drivers/hotplug/ibmphp_ebda.c	Wed Feb  5 19:56:25 2003
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
 
