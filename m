Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbTCMUgJ>; Thu, 13 Mar 2003 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbTCMUgI>; Thu, 13 Mar 2003 15:36:08 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:8869 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262531AbTCMUgH>;
	Thu, 13 Mar 2003 15:36:07 -0500
Date: Thu, 13 Mar 2003 23:45:56 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, zubarev@us.ibm.com
Subject: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Message-ID: <20030313204556.GA3475@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There seem to be memleak convert_2digits_to_char() function that is triggered
   during normal operations.
   Also I think there are some memleaks on error exit paths
   ebda_rsrc_controller()
   All of this is addressed by below patch.
   2.5 seems to have totally different version of this code (and no
   convert_2digits_to_char() function at all for example).
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/hotplug/ibmphp_ebda.c 1.6 vs edited =====
--- 1.6/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 21:56:25 2002
+++ edited/drivers/hotplug/ibmphp_ebda.c	Thu Mar 13 23:40:29 2003
@@ -597,8 +597,8 @@
 	char *str1;
 
 	str = (char *) kmalloc (3, GFP_KERNEL);
-	memset (str, 0, 3);
-	str1 = (char *) kmalloc (2, GFP_KERNEL);
+	if (!str)
+		return NULL;
 	memset (str, 0, 3);
 	bit = (int)(var / 10);
 	switch (bit) {
@@ -608,13 +608,20 @@
 		return str;
 	default: 	
 		//2 digits number
+		str1 = (char *) kmalloc (2, GFP_KERNEL);
+		if (!str1) {
+			break;
+		}
+		memset (str, 0, 3);
 		*str1 = (char)(bit + 48);
 		strncpy (str, str1, 1);
 		memset (str1, 0, 3);
 		*str1 = (char)((var % 10) + 48);
 		strcat (str, str1);
+		kfree(str1);
 		return str;
-	}	
+	}
+	kfree(str);
 	return NULL;	
 }
 
@@ -1022,6 +1029,10 @@
 			bus_info_ptr1 = ibmphp_find_same_bus_num (hpc_ptr->slots[index].slot_bus_num);
 			if (!bus_info_ptr1) {
 				iounmap (io_mem);
+				kfree (hp_slot_ptr->name);
+				kfree (hp_slot_ptr->info);
+				kfree (hp_slot_ptr->private);
+				kfree (hp_slot_ptr);
 				return -ENODEV;
 			}
 			((struct slot *) hp_slot_ptr->private)->bus_on = bus_info_ptr1;
@@ -1036,12 +1047,20 @@
 			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
 			if (rc) {
 				iounmap (io_mem);
+				kfree (hp_slot_ptr->name);
+				kfree (hp_slot_ptr->info);
+				kfree (hp_slot_ptr->private);
+				kfree (hp_slot_ptr);
 				return rc;
 			}
 
 			rc = ibmphp_init_devno ((struct slot **) &hp_slot_ptr->private);
 			if (rc) {
 				iounmap (io_mem);
+				kfree (hp_slot_ptr->name);
+				kfree (hp_slot_ptr->info);
+				kfree (hp_slot_ptr->private);
+				kfree (hp_slot_ptr);
 				return rc;
 			}
 			hp_slot_ptr->ops = &ibmphp_hotplug_slot_ops;
