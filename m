Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263993AbUD0LEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUD0LEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUD0LEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:04:07 -0400
Received: from mail1.drkw.com ([62.129.121.35]:34263 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S263993AbUD0LD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:03:56 -0400
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davej@redhat.com, oschoett@t-online.de,
       volker.hemmann@heim9.tu-clausthal.de
Subject: Re: [PATCH] SIS AGP vs 2.6.6-rc2
In-Reply-To: <1082971956.24569.2.camel@pandora>
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> 
    <1082971956.24569.2.camel@pandora>
Content-Type: text/plain
Message-Id: <1083063853.24569.88.camel@pandora>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 12:04:13 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here it is yet again this time diffed against 2.6.6-rc2 plus latest
cset (patches cleanly onto "vanilla" 2.6.6.-rc2 too). I've included the
description again:


* renamed sis_648_enable to sis_delayed_enable and removed chipset
  references

* All chipsets that require the sis delay-hack are listed in
 sis_broken_chipsets (and no other place).

* There are two new module options to force agp3-spec compliant
initialisation and/or the delay hack. As I only have a 648FX chipset to
test on, I figured this might be useful to experiment with on other
chipsets (i.e.746[FX]).

Basically, if you have an  SiS chipset and your machine freezes when you
start X, try the -agp_sis_force_delay=1 option. If this fixes your
problem add your PCI ID to sis_broken_chipsets in sis-agp.c
Note to 746[FX] people: I'm still not sure what the differences between
the two 746 versions and the 648 series are. If this patch does not work
for you try playing with the agp_sis_agp_spec module option. Any
feedback is greatly appreciated.

Oliver

--- linux-2.6.6-rc2.latest/drivers/char/agp/sis-agp.c.orig	2004-04-27 11:22:45.000000000 +0100
+++ linux-2.6.6-rc2.latest/drivers/char/agp/sis-agp.c	2004-04-27 11:35:17.000000000 +0100
@@ -13,6 +13,8 @@
 #define SIS_TLBCNTRL	0x97
 #define SIS_TLBFLUSH	0x98
 
+static int __devinitdata agp_sis_force_delay = 0;
+static int __devinitdata agp_sis_agp_spec = -1;
 
 static int sis_fetch_size(void)
 {
@@ -67,7 +69,7 @@ static void sis_cleanup(void)
 			      (previous_size->size_value & ~(0x03)));
 }
 
-static void sis_648_enable(u32 mode)
+static void sis_delayed_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
 	u32 command;
@@ -94,13 +96,12 @@ static void sis_648_enable(u32 mode)
 		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
 
 		/*
-		 * Weird: on 648(fx) and 746(fx) chipsets any rate change in the target
+		 * Weird: on some sis chipsets any rate change in the target
 		 * command register triggers a 5ms screwup during which the master
 		 * cannot be configured		 
 		 */
-		if (device->device == PCI_DEVICE_ID_SI_648 ||
-		    device->device == PCI_DEVICE_ID_SI_746) {
-			printk(KERN_INFO PFX "SiS chipset with AGP problems detected. Giving bridge time to recover.\n");
+		if (device->device == agp_bridge->dev->device) {
+			printk(KERN_INFO PFX "SiS delay workaround: giving bridge time to recover.\n");
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout (1+(HZ*10)/1000);
 		}
@@ -223,28 +224,35 @@ static struct agp_device_ids sis_agp_dev
 };
 

+// chipsets that require the 'delay hack'
+static int sis_broken_chipsets[] __devinitdata = {
+	PCI_DEVICE_ID_SI_648,
+	PCI_DEVICE_ID_SI_746,
+	0 // terminator
+};
+
 static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
 {
-	if (bridge->dev->device == PCI_DEVICE_ID_SI_648) { 
-		sis_driver.agp_enable=sis_648_enable;
-		if (agp_bridge->major_version == 3) {
-			sis_driver.aperture_sizes = agp3_generic_sizes;
-			sis_driver.size_type = U16_APER_SIZE;
-			sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
-			sis_driver.configure = agp3_generic_configure;
-			sis_driver.fetch_size = agp3_generic_fetch_size;
-			sis_driver.cleanup = agp3_generic_cleanup;
-			sis_driver.tlb_flush = agp3_generic_tlbflush;
-		}
-	}
+	int i;
 
-	if (bridge->dev->device == PCI_DEVICE_ID_SI_746) {
-		/*
-		 * We don't know enough about the 746 to enable it properly.
-		 * Though we do know that it needs the 'delay' hack to settle
-		 * after changing modes.
-		 */
-		sis_driver.agp_enable=sis_648_enable;
+	for(i=0; sis_broken_chipsets[i]!=0; ++i)
+		if(bridge->dev->device==sis_broken_chipsets[i])
+			break;
+	
+	if(sis_broken_chipsets[i] || agp_sis_force_delay)
+		sis_driver.agp_enable=sis_delayed_enable;
+
+	// sis chipsets that indicate less than agp3.5
+	// are not actually fully agp3 compliant
+	if ((agp_bridge->major_version == 3 && agp_bridge->minor_version >= 5
+	     && agp_sis_agp_spec!=0) || agp_sis_agp_spec==1) {
+		sis_driver.aperture_sizes = agp3_generic_sizes;
+		sis_driver.size_type = U16_APER_SIZE;
+		sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
+		sis_driver.configure = agp3_generic_configure;
+		sis_driver.fetch_size = agp3_generic_fetch_size;
+		sis_driver.cleanup = agp3_generic_cleanup;
+		sis_driver.tlb_flush = agp3_generic_tlbflush;
 	}
 }
 
@@ -335,4 +343,8 @@ static void __exit agp_sis_cleanup(void)
 module_init(agp_sis_init);
 module_exit(agp_sis_cleanup);
 
+MODULE_PARM(agp_sis_force_delay,"i");
+MODULE_PARM_DESC(agp_sis_force_delay,"forces sis delay hack");
+MODULE_PARM(agp_sis_agp_spec,"i");
+MODULE_PARM_DESC(agp_sis_agp_spec,"0=force sis init, 1=force generic agp3 init, default: autodetect");
 MODULE_LICENSE("GPL and additional rights");



--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

