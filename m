Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319747AbSIMSaq>; Fri, 13 Sep 2002 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319744AbSIMS3y>; Fri, 13 Sep 2002 14:29:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:3339 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319747AbSIMS3F>;
	Fri, 13 Sep 2002 14:29:05 -0400
Date: Fri, 13 Sep 2002 11:30:19 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020913183019.GF26589@kroah.com>
References: <20020913182846.GA26589@kroah.com> <20020913182903.GB26589@kroah.com> <20020913182930.GC26589@kroah.com> <20020913182945.GD26589@kroah.com> <20020913183003.GE26589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913183003.GE26589@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.664   -> 1.665  
#	drivers/hotplug/ibmphp_hpc.c	1.5     -> 1.6    
#	drivers/hotplug/ibmphp_ebda.c	1.5     -> 1.6    
#	drivers/hotplug/ibmphp.h	1.4     -> 1.5    
#	drivers/hotplug/ibmphp_res.c	1.2     -> 1.3    
#	drivers/hotplug/ibmphp_core.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	greg@kroah.com	1.665
# IBM PCI Hotplug driver: sync up with the 2.5 version (__init and formatting fixes)
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Fri Sep 13 10:57:17 2002
+++ b/drivers/hotplug/ibmphp.h	Fri Sep 13 10:57:17 2002
@@ -764,7 +764,6 @@
 extern int ibmphp_update_slot_info (struct slot *);	/* This function is called from HPC, so we need it to not be be static */
 extern int ibmphp_configure_card (struct pci_func *, u8);
 extern int ibmphp_unconfigure_card (struct slot **, int);
-extern void ibmphp_increase_count (void);
 extern struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
 static inline void long_delay (int delay)
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Fri Sep 13 10:57:17 2002
+++ b/drivers/hotplug/ibmphp_core.c	Fri Sep 13 10:57:17 2002
@@ -108,7 +108,7 @@
 	return rc;
 }
 
-static int get_max_slots (void)
+static int __init get_max_slots (void)
 {
 	struct slot * slot_cur;
 	struct list_head * tmp;
@@ -542,7 +542,7 @@
  * function. It will also power off empty slots that are powered on since BIOS
  * leaves those on, albeit disconnected
  ******************************************************************************/
-static int init_ops (void)
+static int __init init_ops (void)
 {
 	struct slot *slot_cur;
 	struct list_head *tmp;
@@ -914,12 +914,12 @@
 }
 
 static struct pci_visit ibm_unconfigure_functions_phase1 = {
-	post_visit_pci_dev:	ibm_unconfigure_visit_pci_dev_phase1,
+	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase1,
 };
 
 static struct pci_visit ibm_unconfigure_functions_phase2 = {
-	post_visit_pci_bus:	ibm_unconfigure_visit_pci_bus_phase2,
-	post_visit_pci_dev:	ibm_unconfigure_visit_pci_dev_phase2,
+	.post_visit_pci_bus =	ibm_unconfigure_visit_pci_bus_phase2,
+	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase2,
 };
 
 static int ibm_unconfigure_device (struct pci_func *func)
@@ -983,7 +983,7 @@
 }
 
 static struct pci_visit configure_functions = {
-	visit_pci_dev:	configure_visit_pci_dev,
+	.visit_pci_dev =configure_visit_pci_dev,
 };
 
 
@@ -1569,28 +1569,20 @@
 	return rc;
 }
 
-/* This routine is for NVRAM module to increase the count so we can rmmod
- * the ibmphp module
- */
-void ibmphp_increase_count (void)
-{
-	MOD_INC_USE_COUNT;
-}
-
 struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
-	owner:				THIS_MODULE,
-	set_attention_status:		set_attention_status,
-	enable_slot:			enable_slot,
-	disable_slot:			ibmphp_disable_slot,
-	hardware_test:			NULL,
-	get_power_status:		get_power_status,
-	get_attention_status:		get_attention_status,
-	get_latch_status:		get_latch_status,
-	get_adapter_status:		get_adapter_present,
-/*	get_max_bus_speed_status:	get_max_bus_speed,
-	get_max_adapter_speed_status:	get_max_adapter_speed,
-	get_cur_bus_speed_status:	get_cur_bus_speed,
-	get_bus_name_status:		get_bus_name,
+	.owner =			THIS_MODULE,
+	.set_attention_status =		set_attention_status,
+	.enable_slot =			enable_slot,
+	.disable_slot =			ibmphp_disable_slot,
+	.hardware_test =		NULL,
+	.get_power_status =		get_power_status,
+	.get_attention_status =		get_attention_status,
+	.get_latch_status =		get_latch_status,
+	.get_adapter_status =		get_adapter_present,
+/*	.get_max_bus_speed_status =	get_max_bus_speed,
+	.get_max_adapter_speed_status =	get_max_adapter_speed,
+	.get_cur_bus_speed_status =	get_cur_bus_speed,
+	.get_bus_name_status =		get_bus_name,
 */
 };
 
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:17 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 10:57:17 2002
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/list.h>
+#include <linux/init.h>
 #include "ibmphp.h"
 
 /*
@@ -82,7 +83,7 @@
 	return slot;
 }
 
-static struct ebda_hpc_list *alloc_ebda_hpc_list (void)
+static struct ebda_hpc_list * __init alloc_ebda_hpc_list (void)
 {
 	struct ebda_hpc_list *list;
 
@@ -134,7 +135,7 @@
 	kfree (controller);
 }
 
-static struct ebda_rsrc_list *alloc_ebda_rsrc_list (void)
+static struct ebda_rsrc_list * __init alloc_ebda_rsrc_list (void)
 {
 	struct ebda_rsrc_list *list;
 
@@ -156,7 +157,7 @@
 	return resource;
 }
 
-static void print_bus_info (void)
+static void __init print_bus_info (void)
 {
 	struct bus_info *ptr;
 	struct list_head *ptr1;
@@ -200,7 +201,7 @@
 {
 	struct rio_detail *ptr;
 	struct list_head *ptr1;
-	debug ("print_vg_info --- \n");	
+	debug ("%s --- \n", __FUNCTION__);
 	list_for_each (ptr1, &rio_vg_head) {
 		ptr = list_entry (ptr1, struct rio_detail, rio_detail_list);
 		debug ("%s - rio_node_id = %x\n", __FUNCTION__, ptr->rio_node_id);
@@ -213,7 +214,7 @@
 	}
 }
 
-static void print_ebda_pci_rsrc (void)
+static void __init print_ebda_pci_rsrc (void)
 {
 	struct ebda_pci_rsrc *ptr;
 	struct list_head *ptr1;
@@ -225,7 +226,7 @@
 	}
 }
 
-static void print_ibm_slot (void)
+static void __init print_ibm_slot (void)
 {
 	struct slot *ptr;
 	struct list_head *ptr1;
@@ -236,11 +237,11 @@
 	}
 }
 
-static void print_opt_vg (void)
+static void __init print_opt_vg (void)
 {
 	struct opt_rio *ptr;
 	struct list_head *ptr1;
-	debug ("print_opt_vg --- \n");
+	debug ("%s --- \n", __FUNCTION__);
 	list_for_each (ptr1, &opt_vg_head) {
 		ptr = list_entry (ptr1, struct opt_rio, opt_rio_list);
 		debug ("%s - rio_type %x \n", __FUNCTION__, ptr->rio_type); 
@@ -250,7 +251,7 @@
 	}
 }
 
-static void print_ebda_hpc (void)
+static void __init print_ebda_hpc (void)
 {
 	struct controller *hpc_ptr;
 	struct list_head *ptr1;
@@ -295,7 +296,7 @@
 	}
 }
 
-int ibmphp_access_ebda (void)
+int __init ibmphp_access_ebda (void)
 {
 	u8 format, num_ctlrs, rio_complete, hs_complete;
 	u16 ebda_seg, num_entries, next_offset, offset, blk_id, sub_addr, rc, re, rc_id, re_id, base;
@@ -458,7 +459,7 @@
 /*
  * map info of scalability details and rio details from physical address
  */
-static int ebda_rio_table (void)
+static int __init ebda_rio_table (void)
 {
 	u16 offset;
 	u8 i;
@@ -517,7 +518,7 @@
 	return NULL;
 }
 
-static int combine_wpg_for_chassis (void)
+static int __init combine_wpg_for_chassis (void)
 {
 	struct opt_rio *opt_rio_ptr = NULL;
 	struct rio_detail *rio_detail_ptr = NULL;
@@ -805,7 +806,7 @@
  * each hpc from physical address to a list of hot plug controllers based on
  * hpc descriptors.
  */
-static int ebda_rsrc_controller (void)
+static int __init ebda_rsrc_controller (void)
 {
 	u16 addr, addr_slot, addr_bus;
 	u8 ctlr_id, temp, bus_index;
@@ -1075,7 +1076,7 @@
  * map info (bus, devfun, start addr, end addr..) of i/o, memory,
  * pfm from the physical addr to a list of resource.
  */
-static int ebda_rsrc_rsrc (void)
+static int __init ebda_rsrc_rsrc (void)
 {
 	u16 addr;
 	short rsrc;
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:17 2002
+++ b/drivers/hotplug/ibmphp_hpc.c	Fri Sep 13 10:57:17 2002
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 #include "ibmphp.h"
 
 static int to_debug = FALSE;
@@ -126,7 +127,7 @@
 *
 * Action:  initialize semaphores and variables
 *---------------------------------------------------------------------*/
-void ibmphp_hpc_initvars (void)
+void __init ibmphp_hpc_initvars (void)
 {
 	debug ("%s - Entry\n", __FUNCTION__);
 
@@ -1146,19 +1147,19 @@
 *
 * Action:  start polling thread
 *---------------------------------------------------------------------*/
-int ibmphp_hpc_start_poll_thread (void)
+int __init ibmphp_hpc_start_poll_thread (void)
 {
 	int rc = 0;
 
-	debug ("ibmphp_hpc_start_poll_thread - Entry\n");
+	debug ("%s - Entry\n", __FUNCTION__);
 
 	tid_poll = kernel_thread (hpc_poll_thread, 0, 0);
 	if (tid_poll < 0) {
-		err ("ibmphp_hpc_start_poll_thread - Error, thread not started\n");
+		err ("%s - Error, thread not started\n", __FUNCTION__);
 		rc = -1;
 	}
 
-	debug ("ibmphp_hpc_start_poll_thread - Exit tid_poll[%d] rc[%d]\n", tid_poll, rc);
+	debug ("%s - Exit tid_poll[%d] rc[%d]\n", __FUNCTION__, tid_poll, rc);
 	return rc;
 }
 
@@ -1167,9 +1168,9 @@
 *
 * Action:  stop polling thread and cleanup
 *---------------------------------------------------------------------*/
-void ibmphp_hpc_stop_poll_thread (void)
+void __exit ibmphp_hpc_stop_poll_thread (void)
 {
-	debug ("ibmphp_hpc_stop_poll_thread - Entry\n");
+	debug ("%s - Entry\n", __FUNCTION__);
 
 	ibmphp_shutdown = TRUE;
 	debug ("before locking operations \n");
@@ -1190,7 +1191,7 @@
 	up (&sem_exit);
 	debug ("after sem exit up\n");
 
-	debug ("ibmphp_hpc_stop_poll_thread - Exit\n");
+	debug ("%s - Exit\n", __FUNCTION__);
 }
 
 /*----------------------------------------------------------------------
diff -Nru a/drivers/hotplug/ibmphp_res.c b/drivers/hotplug/ibmphp_res.c
--- a/drivers/hotplug/ibmphp_res.c	Fri Sep 13 10:57:17 2002
+++ b/drivers/hotplug/ibmphp_res.c	Fri Sep 13 10:57:17 2002
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/list.h>
+#include <linux/init.h>
 #include "ibmphp.h"
 
 static int flags = 0;		/* for testing */
@@ -45,7 +46,8 @@
 
 static LIST_HEAD(gbuses);
 LIST_HEAD(ibmphp_res_head);
-static struct bus_node * alloc_error_bus (struct ebda_pci_rsrc * curr, u8 busno, int flag)
+
+static struct bus_node * __init alloc_error_bus (struct ebda_pci_rsrc * curr, u8 busno, int flag)
 {
 	struct bus_node * newbus;
 
@@ -69,7 +71,7 @@
 	return newbus;
 }
 
-static struct resource_node * alloc_resources (struct ebda_pci_rsrc * curr)
+static struct resource_node * __init alloc_resources (struct ebda_pci_rsrc * curr)
 {
 	struct resource_node *rs;
 	
@@ -92,7 +94,7 @@
 	return rs;
 }
 
-static int alloc_bus_range (struct bus_node **new_bus, struct range_node **new_range, struct ebda_pci_rsrc *curr, int flag, u8 first_bus)
+static int __init alloc_bus_range (struct bus_node **new_bus, struct range_node **new_range, struct ebda_pci_rsrc *curr, int flag, u8 first_bus)
 {
 	struct bus_node * newbus;
 	struct range_node *newrange;
@@ -199,7 +201,7 @@
  * Input: ptr to the head of the resource list from EBDA
  * Output: 0, -1 or error codes
  ***************************************************************************/
-int ibmphp_rsrc_init (void)
+int __init ibmphp_rsrc_init (void)
 {
 	struct ebda_pci_rsrc *curr;
 	struct range_node *newrange = NULL;
@@ -1675,7 +1677,7 @@
  * a new Mem node
  * This routine is called right after initialization
  *******************************************************************************/
-static int once_over (void)
+static int __init once_over (void)
 {
 	struct resource_node *pfmem_cur;
 	struct resource_node *pfmem_prev;
@@ -1928,7 +1930,7 @@
  *	 behind them All these are TO DO.
  *	 Also need to add more error checkings... (from fnc returns etc)
  */
-static int update_bridge_ranges (struct bus_node **bus)
+static int __init update_bridge_ranges (struct bus_node **bus)
 {
 	u8 sec_busno, device, function, busno, hdr_type, start_io_address, end_io_address;
 	u16 vendor_id, upper_io_start, upper_io_end, start_mem_address, end_mem_address;
@@ -1944,7 +1946,7 @@
 		return -ENODEV;
 	busno = bus_cur->busno;
 
-	debug ("inside update_bridge_ranges \n");
+	debug ("inside %s \n", __FUNCTION__);
 	debug ("bus_cur->busno = %x\n", bus_cur->busno);
 
 	for (device = 0; device < 32; device++) {
