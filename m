Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbTAHTiQ>; Wed, 8 Jan 2003 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267851AbTAHTiQ>; Wed, 8 Jan 2003 14:38:16 -0500
Received: from fmr05.intel.com ([134.134.136.6]:36347 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267850AbTAHTiP>; Wed, 8 Jan 2003 14:38:15 -0500
Date: Wed, 8 Jan 2003 11:46:54 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200301081946.h08Jksh06332@linux.intel.com>
To: greg@kroah.com, harold.yang@intel.com, scottm@somanetworks.com
Subject: Re:[BUG] cpci patch for kernel 2.4.19 bug
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yang, Harold" <harold.yang@intel.com>
> 
> Hi, Scott & Greg:
> 
> I have applied the cpci patch for kernel 2.4.19, and test it
> thoroughly on ZT5084 platform. Two bugs are found:
> 
> 1. In my ZT5084, the driver can't correctly detect the cPCI
>    Hot Swap bridge device. Two DEC21154 exist on ZT5084,
>    however, only one is the right bridge. The driver can't 
>    distinguish them correctly.

I just got a couple of ZT5541 peripheral master boards
and can finally see what happens when an enumerable board
is plugged into a ZT5084 chassis using a ZT5550 system master 
board.

As of yet I have only tried a 2.5.54 kernel, but I see the 
same problems along with some other wacky behavior that I 
am trying to isolate.

Now about the multiple DEC21154 devices ==>  on my ZT5550 that
is in system master mode, the first DEC21154 device is a bridge
for the slots to the left of the system slots, and the second
DEC21154 is a bridge for the right of the system slots.

So if I boot the system master (I'll talk about problems with 
hotswaping in another email) with a peripheral board plugged
into one of the slots on the right of the master using the
current 2.5.54 kernel then I run into problems the first time 
cpci_hotplug_core.c::check_slots() runs because it only looks
at the first bus when trying to find the card that caused the
#ENUM.

The following patch will register each of the cpci busses instead
of just the first one detected.

NOTE: I'm a little worried that the right way to do this is to
      properly initialize the RSS bits, or at least see how the
      chassis is configured via the RSS bits to determine which 
      cpci bus to register.  The ZT5084 doesn't have near as many
      configurations as newer designs like the ZT5088.

===== cpcihp_zt5550.c 1.1 vs edited =====
--- 1.1/drivers/hotplug/cpcihp_zt5550.c	Fri Nov  1 11:48:05 2002
+++ edited/cpcihp_zt5550.c	Wed Jan  8 11:17:32 2003
@@ -191,6 +191,7 @@
 					 const struct pci_device_id *ent)
 {
 	int status;
+	struct pci_dev *tmp = 0;
 
 	status = zt5550_hc_config(pdev);
 	if(status != 0) {
@@ -220,20 +221,16 @@
 	}
 	dbg("registered controller");
 
-	/* Look for first device matching cPCI bus's bridge vendor and device IDs */
-	if(!(bus0_dev = pci_find_device(PCI_VENDOR_ID_DEC,
-					 PCI_DEVICE_ID_DEC_21154, NULL))) {
-		status = -ENODEV;
-		goto init_register_error;
-	}
-	bus0 = bus0_dev->subordinate;
+	while(tmp = pci_find_device(PCI_VENDOR_ID_DEC,
+				    PCI_DEVICE_ID_DEC_21154, tmp)) {
+		if(cpci_hp_register_bus(tmp->subordinate, 0x0a, 0x0f)) {
+			err("could not register cPCI hotplug bus #%i", 
+			    tmp->subordinate);
+			continue;
+		}
 
-	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
-	if(status != 0) {
-		err("could not register cPCI hotplug bus");
-		goto init_register_error;
+		dbg("registered bus #%i", tmp->subordinate);
 	}
-	dbg("registered bus");
 
 	status = cpci_hp_start();
 	if(status != 0) {
