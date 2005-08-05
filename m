Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbVHEVfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVHEVfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVHEVde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:33:34 -0400
Received: from fmr18.intel.com ([134.134.136.17]:37764 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263109AbVHEVdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:33:15 -0400
Subject: Re: [PATCH] use bus_slot number for name
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
In-Reply-To: <20050805195123.GN2241@redhat.com>
References: <1123269366.8917.39.camel@whizzy>
	 <20050805195123.GN2241@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 14:31:07 -0700
Message-Id: <1123277467.8917.58.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 21:32:50.0369 (UTC) FILETIME=[3AE77B10:01C59A05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 15:51 -0400, Dave Jones wrote:
> On Fri, Aug 05, 2005 at 12:16:06PM -0700, Kristen Accardi wrote:
>  > For systems with multiple hotplug controllers, you need to use more than
>  > just the slot number to uniquely name the slot.  Without a unique slot
>  > name, the pci_hp_register() will fail.  This patch adds the bus number
>  > to the name.
>  > 
>  > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>  > 
>  > diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h
>  > --- linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h	2005-07-28 15:44:44.000000000 -0700
>  > +++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h	2005-08-04 17:57:18.000000000 -0700
>  > @@ -302,7 +302,7 @@ static inline void return_resource(struc
>  >  
>  >  static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
>  >  {
>  > -	snprintf(buffer, buffer_size, "%d", slot->number);
>  > +	snprintf(buffer, buffer_size, "%04d_%04d", slot->bus, slot->number);
>  >  }
> 
> Won't using..
> 
> 	snprintf(buffer, buffer_size, "%s", pci_name(slot));
> 
> work equally as well, and also future-proof this ?
>  
> 		Dave

What do you think of this patch - it is basically what you asked for
except that I moved the functionality up to pci_hotplug.h so that all
drivers can use the same nameing convention if they feel like it.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pciehp_core.c linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp_core.c
--- linux-2.6.13-rc4/drivers/pci/hotplug/pciehp_core.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp_core.c	2005-08-05 14:15:09.000000000 -0700
@@ -140,7 +140,7 @@ static int init_slots(struct controller 
 			goto error_hpslot;
 		memset(new_slot->hotplug_slot->info, 0,
 					sizeof(struct hotplug_slot_info));
-		new_slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE,
+		new_slot->hotplug_slot->name = kmalloc(HPSLOT_NAME_SIZE,
 						GFP_KERNEL);
 		if (!new_slot->hotplug_slot->name)
 			goto error_info;
@@ -156,7 +156,7 @@ static int init_slots(struct controller 
 		/* register this slot with the hotplug pci core */
 		new_slot->hotplug_slot->private = new_slot;
 		new_slot->hotplug_slot->release = &release_slot;
-		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
+		pci_hp_make_slot_name(new_slot->hotplug_slot, ctrl->pci_dev); 
 		new_slot->hotplug_slot->ops = &pciehp_hotplug_slot_ops;
 
 		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h
--- linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h	2005-08-05 14:14:54.000000000 -0700
@@ -298,12 +298,6 @@ static inline void return_resource(struc
 	*head = node;
 }
 
-#define SLOT_NAME_SIZE 10
-
-static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
-{
-	snprintf(buffer, buffer_size, "%d", slot->number);
-}
 
 enum php_ctlr_type {
 	PCI,
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pci_hotplug.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pci_hotplug.h
--- linux-2.6.13-rc4/drivers/pci/hotplug/pci_hotplug.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pci_hotplug.h	2005-08-05 14:21:45.000000000 -0700
@@ -170,6 +170,12 @@ struct hotplug_slot {
 };
 #define to_hotplug_slot(n) container_of(n, struct hotplug_slot, kobj)
 
+#define HPSLOT_NAME_SIZE BUS_ID_SIZE 
+static inline void pci_hp_make_slot_name(struct hotplug_slot *hpslot, struct pci_dev *pdev)
+{
+	snprintf(hpslot->name, HPSLOT_NAME_SIZE, "%s", pci_name(pdev));
+}
+
 extern int pci_hp_register		(struct hotplug_slot *slot);
 extern int pci_hp_deregister		(struct hotplug_slot *slot);
 extern int pci_hp_change_slot_info	(struct hotplug_slot *slot,
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/shpchp_core.c linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp_core.c
--- linux-2.6.13-rc4/drivers/pci/hotplug/shpchp_core.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp_core.c	2005-08-05 14:15:18.000000000 -0700
@@ -134,7 +134,7 @@ static int init_slots(struct controller 
 		if (!new_slot->hotplug_slot->info)
 			goto error_hpslot;
 		memset(new_slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
-		new_slot->hotplug_slot->name = kmalloc (SLOT_NAME_SIZE, GFP_KERNEL);
+		new_slot->hotplug_slot->name = kmalloc (HPSLOT_NAME_SIZE, GFP_KERNEL);
 		if (!new_slot->hotplug_slot->name)
 			goto error_info;
 
@@ -154,7 +154,7 @@ static int init_slots(struct controller 
 		/* register this slot with the hotplug pci core */
 		new_slot->hotplug_slot->private = new_slot;
 		new_slot->hotplug_slot->release = &release_slot;
-		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
+		pci_hp_make_slot_name(new_slot->hotplug_slot, ctrl->pci_dev);
 		new_slot->hotplug_slot->ops = &shpchp_hotplug_slot_ops;
 
 		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/shpchp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp.h
--- linux-2.6.13-rc4/drivers/pci/hotplug/shpchp.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp.h	2005-08-05 14:14:43.000000000 -0700
@@ -46,7 +46,7 @@ extern int shpchp_poll_mode;
 extern int shpchp_poll_time;
 extern int shpchp_debug;
 
-/*#define dbg(format, arg...) do { if (shpchp_debug) printk(KERN_DEBUG "%s: " format, MY_NAME , ## arg); } while (0)*/
+/* #define dbg(format, arg...) do { if (shpchp_debug) printk(KERN_DEBUG "%s: " format, MY_NAME , ## arg); } while (0) */
 #define dbg(format, arg...) do { if (shpchp_debug) printk("%s: " format, MY_NAME , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
@@ -407,12 +407,6 @@ static inline void return_resource(struc
 	*head = node;
 }
 
-#define SLOT_NAME_SIZE 10
-
-static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
-{
-	snprintf(buffer, buffer_size, "%d", slot->number);
-}
 
 enum php_ctlr_type {
 	PCI,

