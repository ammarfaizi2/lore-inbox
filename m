Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUDWW7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUDWW7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUDWW7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:59:51 -0400
Received: from web10105.mail.yahoo.com ([216.136.130.55]:17583 "HELO
	web10105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261638AbUDWW7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:59:39 -0400
Message-ID: <20040423225938.57650.qmail@web10105.mail.yahoo.com>
Date: Fri, 23 Apr 2004 15:59:38 -0700 (PDT)
From: Oliver Heilmann <heilmano@yahoo.com>
Subject: [PATCH] SIS AGP clean up, blacklist and module options
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is to clean up the mess in sis-agp.c.
Here's what changed:

* All chipsets that require the sis delay-hack are
listed in sis_broken_chipsets (and no other place).

* There are two new module options to force agp3-spec
compliant initialisation and/or the delay hack. As I
only have a 648FX chipset to test on, I figured this
might be useful to experiment with on other chipsets
(i.e.746[FX]).

Basically, if you have an  SiS chipset and your
machine freezes when you start X, try the
-agp_sis_force_delay=1 option. If this fixes your
problem add your PCI ID to sis_broken_chipsets in
sis-agp.c
Note to 746[FX] people: I'm still not sure what the
differences between the two 746 versions and the 648
series are. If this patch does not work for you try
playing with the agp_sis_agp_spec module option.
Any feedback is greatly appreciated.

Oliver

--- drivers/char/agp/sis-agp.c.orig     2004-04-23
23:14:35.000000000 +0100
+++ drivers/char/agp/sis-agp.c  2004-04-23
19:51:46.000000000 +0100
@@ -13,6 +13,8 @@
 #define SIS_TLBCNTRL   0x97
 #define SIS_TLBFLUSH   0x98

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
@@ -93,10 +95,13 @@ static void sis_648_enable(u32
mode)

                pci_write_config_dword(device, agp +
PCI_AGP_COMMAND, command);

-               if(device->device ==
PCI_DEVICE_ID_SI_648) {
-                       // weird: on 648 and 648fx
chipsets any rate change in the target command
register
-                       // triggers a 5ms screwup
during which the master cannot be configured
-                       printk(KERN_INFO PFX "sis 648
agp fix - giving bridge time to recover\n");
+               /*
+                * Weird: on some sis chipsets any
rate change in the target
+                * command register triggers a 5ms
screwup during which the master
+                * cannot be configured
+                */
+               if (device->device ==
agp_bridge->dev->device) {
+                       printk(KERN_INFO PFX "SiS
delay workaround: giving bridge time to recover.\n");
                       
set_current_state(TASK_UNINTERRUPTIBLE);
                        schedule_timeout
(1+(HZ*10)/1000);
                }
@@ -219,21 +224,35 @@ static struct agp_device_ids
sis_agp_dev
 };


+// chipsets that require the 'delay hack'
+static int sis_broken_chipsets[] __devinitdata = {
+       PCI_DEVICE_ID_SI_648,
+       PCI_DEVICE_ID_SI_746,
+       0 // terminator
+};
+
 static void __devinit sis_get_driver(struct
agp_bridge_data *bridge)
 {
-       if (bridge->dev->device ==
PCI_DEVICE_ID_SI_648) {
-               if (agp_bridge->major_version == 3 &&
agp_bridge->minor_version < 5) {
-                      
sis_driver.agp_enable=sis_648_enable;
-               } else {
-                       sis_driver.agp_enable         
         = sis_648_enable;
-                       sis_driver.aperture_sizes     
         = agp3_generic_sizes;
-                       sis_driver.size_type          
         = U16_APER_SIZE;
-                       sis_driver.num_aperture_sizes 
 = AGP_GENERIC_SIZES_ENTRIES;
-                       sis_driver.configure          
         = agp3_generic_configure;
-                       sis_driver.fetch_size         
         = agp3_generic_fetch_size;
-                       sis_driver.cleanup            
                 = agp3_generic_cleanup;
-                       sis_driver.tlb_flush          
         = agp3_generic_tlbflush;
-               }
+       int i;
+
+       for(i=0; sis_broken_chipsets[i]!=0; ++i)
+              
if(bridge->dev->device==sis_broken_chipsets[i])
+                       break;
+
+       if(sis_broken_chipsets[i] ||
agp_sis_force_delay)
+              
sis_driver.agp_enable=sis_delayed_enable;
+
+       // sis chipsets that indicate less than agp3.5
+       // are not actually fully agp3 compliant
+       if ((agp_bridge->major_version == 3 &&
agp_bridge->minor_version >= 5
+            && agp_sis_agp_spec!=0) ||
agp_sis_agp_spec==1) {
+               sis_driver.aperture_sizes =
agp3_generic_sizes;
+               sis_driver.size_type = U16_APER_SIZE;
+               sis_driver.num_aperture_sizes =
AGP_GENERIC_SIZES_ENTRIES;
+               sis_driver.configure =
agp3_generic_configure;
+               sis_driver.fetch_size =
agp3_generic_fetch_size;
+               sis_driver.cleanup =
agp3_generic_cleanup;
+               sis_driver.tlb_flush =
agp3_generic_tlbflush;
        }
 }

@@ -324,4 +343,8 @@ static void __exit
agp_sis_cleanup(void)
 module_init(agp_sis_init);
 module_exit(agp_sis_cleanup);

+MODULE_PARM(agp_sis_force_delay,"i");
+MODULE_PARM_DESC(agp_sis_force_delay,"forces sis
delay hack");
+MODULE_PARM(agp_sis_agp_spec,"i");
+MODULE_PARM_DESC(agp_sis_agp_spec,"0=force sis init,
1=force generic agp3 init, default: autodetect");
 MODULE_LICENSE("GPL and additional rights");



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
