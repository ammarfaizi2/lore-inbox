Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbTGDWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbTGDWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:53:54 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:28176 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266205AbTGDWxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:53:47 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [2/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:05:18 +0200
Message-ID: <wrp8yrdvqoh.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update.

              M.

diff -ruN linux-latest/Documentation/eisa.txt linux-eisa/Documentation/eisa.txt
--- linux-latest/Documentation/eisa.txt	2003-07-04 09:42:45.000000000 +0200
+++ linux-eisa/Documentation/eisa.txt	2003-07-04 09:44:46.000000000 +0200
@@ -46,12 +46,14 @@
 to this device, as well as some parameters for probing purposes.
 
 struct eisa_root_device {
-        struct list_head node;
-        struct device   *dev;    /* Pointer to bridge device */
-        struct resource *res;
-        unsigned long    bus_base_addr;
-        int              slots;  /* Max slot number */
-        int              bus_nr; /* Set by eisa_root_register */
+	struct device   *dev;	 /* Pointer to bridge device */
+	struct resource *res;
+	unsigned long    bus_base_addr;
+	int		 slots;  /* Max slot number */
+	int		 force_probe; /* Probe even when no slot 0 */
+	u64		 dma_mask; /* from bridge device */
+	int              bus_nr; /* Set by eisa_root_register */
+	struct resource  eisa_root_res;	/* ditto */
 };
 
 node          : used for eisa_root_register internal purpose
@@ -59,6 +61,8 @@
 res           : root device I/O resource
 bus_base_addr : slot 0 address on this bus
 slots	      : max slot number to probe
+force_probe   : Probe even when slot 0 is empty (no EISA mainboard)
+dma_mask      : Default DMA mask. Usualy the bridge device dma_mask.
 bus_nr	      : unique bus id, set by eisa_root_register
 
 ** Driver :
@@ -87,7 +91,7 @@
 		  Documentation/driver-model/driver.txt. Only .name,
 		  .probe and .remove members are mandatory.
 
-An example is the 3c509 driver :
+An example is the 3c59x driver :
 
 static struct eisa_device_id vortex_eisa_ids[] = {
 	{ "TCM5920", EISA_3C592_OFFSET },
@@ -116,15 +120,20 @@
 struct eisa_device {
         struct eisa_device_id id;
         int                   slot;
-        unsigned long         base_addr;
-        struct resource       res;
+	int                   state;
+	unsigned long         base_addr;
+	struct resource       res[EISA_MAX_RESOURCES];
+	u64                   dma_mask;
         struct device         dev; /* generic device */
 };
 
 id	: EISA id, as read from device. id.driver_data is set from the
 	  matching driver EISA id.
 slot	: slot number which the device was detected on
-res	: I/O resource allocated to this device
+state   : set of flags indicating the state of the device. Current
+	  flags are EISA_CONFIG_ENABLED and EISA_CONFIG_FORCED.
+res	: set of four 256 bytes I/O regions allocated to this device
+dma_mask: DMA mask set from the parent device.
 dev	: generic device (see Documentation/driver-model/device.txt)
 
 You can get the 'struct eisa_device' from 'struct device' using the
@@ -140,6 +149,32 @@
 
 Gets the pointer previously stored into the device's driver_data area.
 
+int eisa_get_region_index (void *addr);
+
+Returns the region number (0 <= x < EISA_MAX_RESOURCES) of a given
+address.
+
+** Kernel parameters :
+
+eisa_bus.enable_dev :
+
+A comma-separated list of slots to be enabled, even if the firmware
+set the card as disabled. The driver must be able to properly
+initialize the device in such conditions.
+
+eisa_bus.disable_dev :
+
+A comma-separated list of slots to be enabled, even if the firmware
+set the card as enabled. The driver won't be called to handle this
+device.
+
+virtual_root.force_probe :
+
+Force the probing code to probe EISA slots even when it cannot find an
+EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
+(don't force), and set to 1 (force probing) when either
+CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
+
 ** Random notes :
 
 Converting an EISA driver to the new API mostly involves *deleting*
@@ -156,10 +191,13 @@
 expect to have explored the whole machine when they exit their probe
 routine.
 
+For example, switching your favorite EISA SCSI card to the "hotplug"
+model is "the right thing"(tm).
+
 ** Thanks :
 
 I'd like to thank the following people for their help :
 - Xavier Benigni for lending me a wonderful Alpha Jensen,
 - James Bottomley, Jeff Garzik for getting this stuff into the kernel,
 - Andries Brouwer for contributing numerous EISA ids,
-- Catrin Jones for coping with too many machines at home
+- Catrin Jones for coping with far too many machines at home.

-- 
Places change, faces change. Life is so very strange.
