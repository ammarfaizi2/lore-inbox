Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUD0RaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUD0RaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUD0RaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:30:18 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:24450 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264215AbUD0R33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:29:29 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
Subject: Re: [PATCH] SIS AGP vs 2.6.6-rc2
Date: Tue, 27 Apr 2004 19:29:16 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com,
       oschoett@t-online.de
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> <1082971956.24569.2.camel@pandora> <1083063853.24569.88.camel@pandora>
In-Reply-To: <1083063853.24569.88.camel@pandora>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_shpjAOsZJTJuBdX"
Message-Id: <200404271929.16786.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_shpjAOsZJTJuBdX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I tried your patch and is has rejects again:
energy linux # patch -p1 < sis.agp.patch
patching file drivers/char/agp/sis-agp.c
Hunk #1 succeeded at 13 with fuzz 2.
Hunk #2 succeeded at 69 with fuzz 2.
Hunk #3 FAILED at 96.
Hunk #4 FAILED at 224.
2 out of 5 hunks FAILED -- saving rejects to file=20
drivers/char/agp/sis-agp.c.rej

Attached is the .rej file.=20

Gl=FCck Auf
Volker

=2D-=20
Conclusions
 In a straight-up fight, the Empire squashes the Federation like a bug. Eve=
n=20
with its numerical advantage removed, the Empire would still squash the=20
=46ederation like a bug. Accept it. -Michael Wong

--Boundary-00=_shpjAOsZJTJuBdX
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="sis-agp.c.rej"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sis-agp.c.rej"

***************
*** 94,106 ****
                 pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
  
                 /*
-                 * Weird: on 648(fx) and 746(fx) chipsets any rate change in the target
                  * command register triggers a 5ms screwup during which the master
                  * cannot be configured          
                  */
-                if (device->device == PCI_DEVICE_ID_SI_648 ||
-                    device->device == PCI_DEVICE_ID_SI_746) {
-                        printk(KERN_INFO PFX "SiS chipset with AGP problems detected. Giving bridge time to recover.\n");
                         set_current_state(TASK_UNINTERRUPTIBLE);
                         schedule_timeout (1+(HZ*10)/1000);
                 }
--- 96,107 ----
                 pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
  
                 /*
+                 * Weird: on some sis chipsets any rate change in the target
                  * command register triggers a 5ms screwup during which the master
                  * cannot be configured          
                  */
+                if (device->device == agp_bridge->dev->device) {
+                        printk(KERN_INFO PFX "SiS delay workaround: giving bridge time to recover.\n");
                         set_current_state(TASK_UNINTERRUPTIBLE);
                         schedule_timeout (1+(HZ*10)/1000);
                 }
***************
*** 223,250 ****
  };
  
  
  static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
  {
-        if (bridge->dev->device == PCI_DEVICE_ID_SI_648) { 
-                sis_driver.agp_enable=sis_648_enable;
-                if (agp_bridge->major_version == 3) {
-                        sis_driver.aperture_sizes = agp3_generic_sizes;
-                        sis_driver.size_type = U16_APER_SIZE;
-                        sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
-                        sis_driver.configure = agp3_generic_configure;
-                        sis_driver.fetch_size = agp3_generic_fetch_size;
-                        sis_driver.cleanup = agp3_generic_cleanup;
-                        sis_driver.tlb_flush = agp3_generic_tlbflush;
-                }
-        }
  
-        if (bridge->dev->device == PCI_DEVICE_ID_SI_746) {
-                /*
-                 * We don't know enough about the 746 to enable it properly.
-                 * Though we do know that it needs the 'delay' hack to settle
-                 * after changing modes.
-                 */
-                sis_driver.agp_enable=sis_648_enable;
         }
  }
  
--- 224,258 ----
  };
  
  
+ // chipsets that require the 'delay hack'
+ static int sis_broken_chipsets[] __devinitdata = {
+        PCI_DEVICE_ID_SI_648,
+        PCI_DEVICE_ID_SI_746,
+        0 // terminator
+ };
+ 
  static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
  {
+        int i;
  
+        for(i=0; sis_broken_chipsets[i]!=0; ++i)
+                if(bridge->dev->device==sis_broken_chipsets[i])
+                        break;
+        
+        if(sis_broken_chipsets[i] || agp_sis_force_delay)
+                sis_driver.agp_enable=sis_delayed_enable;
+ 
+        // sis chipsets that indicate less than agp3.5
+        // are not actually fully agp3 compliant
+        if ((agp_bridge->major_version == 3 && agp_bridge->minor_version >= 5
+             && agp_sis_agp_spec!=0) || agp_sis_agp_spec==1) {
+                sis_driver.aperture_sizes = agp3_generic_sizes;
+                sis_driver.size_type = U16_APER_SIZE;
+                sis_driver.num_aperture_sizes = AGP_GENERIC_SIZES_ENTRIES;
+                sis_driver.configure = agp3_generic_configure;
+                sis_driver.fetch_size = agp3_generic_fetch_size;
+                sis_driver.cleanup = agp3_generic_cleanup;
+                sis_driver.tlb_flush = agp3_generic_tlbflush;
         }
  }
  

--Boundary-00=_shpjAOsZJTJuBdX--
