Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266231AbTGDXBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbTGDXBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:01:44 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:33552 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266224AbTGDW7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:59:01 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [6/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:10:35 +0200
Message-ID: <wrpllvdubv8.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual root :

- By default, do not try to probe the bus if the mainboard does not
seems to support EISA (allow this behaviour to be changed through a
command-line option).

	M.

diff -ruN linux-latest/drivers/eisa/virtual_root.c linux-eisa/drivers/eisa/virtual_root.c
--- linux-latest/drivers/eisa/virtual_root.c	2003-07-04 09:43:35.000000000 +0200
+++ linux-eisa/drivers/eisa/virtual_root.c	2003-07-04 09:45:31.000000000 +0200
@@ -7,12 +7,22 @@
  * This code is released under the GPL version 2.
  */
 
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/eisa.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 
+#if defined(CONFIG_ALPHA_JENSEN) || defined(CONFIG_EISA_VLB_PRIMING)
+#define EISA_FORCE_PROBE_DEFAULT 1
+#else
+#define EISA_FORCE_PROBE_DEFAULT 0
+#endif
+
+static int force_probe = EISA_FORCE_PROBE_DEFAULT;
+
 /* The default EISA device parent (virtual root device).
  * Now use a platform device, since that's the obvious choice. */
 
@@ -29,6 +39,7 @@
 	.bus_base_addr = 0,
 	.res	       = &ioport_resource,
 	.slots	       = EISA_MAX_SLOTS,
+	.dma_mask      = 0xffffffff,
 };
 
 static int virtual_eisa_root_init (void)
@@ -39,6 +50,8 @@
                 return r;
         }
 
+	eisa_bus_root.force_probe = force_probe;
+	
 	eisa_root_dev.dev.driver_data = &eisa_bus_root;
 
 	if (eisa_root_register (&eisa_bus_root)) {
@@ -51,4 +64,6 @@
 	return 0;
 }
 
+module_param (force_probe, int, 0444);
+
 device_initcall (virtual_eisa_root_init);

-- 
Places change, faces change. Life is so very strange.
