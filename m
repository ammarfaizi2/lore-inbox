Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUDNWy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDNWxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:53:06 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48026 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261880AbUDNWu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:50:58 -0400
Date: Wed, 14 Apr 2004 18:50:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Proposed patch to convert r128 DRM driver to userland firmware loading
Message-ID: <20040414225057.GA6035@twcny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: neroden@twcny.rr.com (Nathanael Nerode)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea whether this actually works, because I don't have the
affected hardware, but I'm throwing this out for anyone who does.  All
copyrightable changes are GPL-licensed of course.

I'm not subscribed, so if you want to tell me something (tips on how to
use request_firmware better... telling me that this function is called in
interrupt context and therefore can't do this... whatever), email me.

(drivers/char/drm/r128_cce.c)
--- r128_cce.c	2003-09-28 00:44:12.000000000 -0400
+++ r128_cce.c.new	2004-04-12 19:32:39.000000000 -0400
@@ -3,6 +3,7 @@
  *
  * Copyright 2000 Precision Insight, Inc., Cedar Park, Texas.
  * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
+ * Portions copyright 2003 Nathanael Nerode.
  * All Rights Reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
@@ -28,6 +29,7 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
+#include <linux/firmware.h>
 #include "r128.h"
 #include "drmP.h"
 #include "drm.h"
@@ -36,51 +38,6 @@
 
 #define R128_FIFO_DEBUG		0
 
-/* CCE microcode (from ATI) */
-static u32 r128_cce_microcode[] = {
-	0, 276838400, 0, 268449792, 2, 142, 2, 145, 0, 1076765731, 0,
-	1617039951, 0, 774592877, 0, 1987540286, 0, 2307490946U, 0,
-	599558925, 0, 589505315, 0, 596487092, 0, 589505315, 1,
-	11544576, 1, 206848, 1, 311296, 1, 198656, 2, 912273422, 11,
-	262144, 0, 0, 1, 33559837, 1, 7438, 1, 14809, 1, 6615, 12, 28,
-	1, 6614, 12, 28, 2, 23, 11, 18874368, 0, 16790922, 1, 409600, 9,
-	30, 1, 147854772, 16, 420483072, 3, 8192, 0, 10240, 1, 198656,
-	1, 15630, 1, 51200, 10, 34858, 9, 42, 1, 33559823, 2, 10276, 1,
-	15717, 1, 15718, 2, 43, 1, 15936948, 1, 570480831, 1, 14715071,
-	12, 322123831, 1, 33953125, 12, 55, 1, 33559908, 1, 15718, 2,
-	46, 4, 2099258, 1, 526336, 1, 442623, 4, 4194365, 1, 509952, 1,
-	459007, 3, 0, 12, 92, 2, 46, 12, 176, 1, 15734, 1, 206848, 1,
-	18432, 1, 133120, 1, 100670734, 1, 149504, 1, 165888, 1,
-	15975928, 1, 1048576, 6, 3145806, 1, 15715, 16, 2150645232U, 2,
-	268449859, 2, 10307, 12, 176, 1, 15734, 1, 15735, 1, 15630, 1,
-	15631, 1, 5253120, 6, 3145810, 16, 2150645232U, 1, 15864, 2, 82,
-	1, 343310, 1, 1064207, 2, 3145813, 1, 15728, 1, 7817, 1, 15729,
-	3, 15730, 12, 92, 2, 98, 1, 16168, 1, 16167, 1, 16002, 1, 16008,
-	1, 15974, 1, 15975, 1, 15990, 1, 15976, 1, 15977, 1, 15980, 0,
-	15981, 1, 10240, 1, 5253120, 1, 15720, 1, 198656, 6, 110, 1,
-	180224, 1, 103824738, 2, 112, 2, 3145839, 0, 536885440, 1,
-	114880, 14, 125, 12, 206975, 1, 33559995, 12, 198784, 0,
-	33570236, 1, 15803, 0, 15804, 3, 294912, 1, 294912, 3, 442370,
-	1, 11544576, 0, 811612160, 1, 12593152, 1, 11536384, 1,
-	14024704, 7, 310382726, 0, 10240, 1, 14796, 1, 14797, 1, 14793,
-	1, 14794, 0, 14795, 1, 268679168, 1, 9437184, 1, 268449792, 1,
-	198656, 1, 9452827, 1, 1075854602, 1, 1075854603, 1, 557056, 1,
-	114880, 14, 159, 12, 198784, 1, 1109409213, 12, 198783, 1,
-	1107312059, 12, 198784, 1, 1109409212, 2, 162, 1, 1075854781, 1,
-	1073757627, 1, 1075854780, 1, 540672, 1, 10485760, 6, 3145894,
-	16, 274741248, 9, 168, 3, 4194304, 3, 4209949, 0, 0, 0, 256, 14,
-	174, 1, 114857, 1, 33560007, 12, 176, 0, 10240, 1, 114858, 1,
-	33560018, 1, 114857, 3, 33560007, 1, 16008, 1, 114874, 1,
-	33560360, 1, 114875, 1, 33560154, 0, 15963, 0, 256, 0, 4096, 1,
-	409611, 9, 188, 0, 10240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
-};
-
 int R128_READ_PLL(drm_device_t *dev, int addr)
 {
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -176,21 +133,50 @@
  */
 
 /* Load the microcode for the CCE */
-static void r128_cce_load_microcode( drm_r128_private_t *dev_priv )
+static void r128_cce_load_microcode( drm_device_t *dev,
+                                     drm_r128_private_t *dev_priv )
 {
 	int i;
+	const struct firmware *fw_entry = NULL;
+
+	if ( request_firmware(&fw_entry, "r128_cce_microcode", &dev) != 0 ) {
+		printk(KERN_ALERT
+	               "%s: Firmware \"r128_cce_microcode\" not available.\n",
+		       dev->name);
+		return;
+	}
 
 	DRM_DEBUG( "\n" );
 
 	r128_do_wait_for_idle( dev_priv );
 
 	R128_WRITE( R128_PM4_MICROCODE_ADDR, 0 );
+
+	/* Assumes 256 x 2 x 32 bits of data */
+	if (fw_entry->size != 256 * 4 * 2) {
+		printk(KERN_ALERT
+	               "%s: Firmware \"r128_cce_microcode\" wrong size!\n",
+		       dev->name);
+		return;
+	}
+
 	for ( i = 0 ; i < 256 ; i++ ) {
+		/* fw_entry->data is a char[], but we want a u32[] (sigh).
+		   We simply assume big-endian byte order for now. */
 		R128_WRITE( R128_PM4_MICROCODE_DATAH,
-			    r128_cce_microcode[i * 2] );
+			      ( (u32) fw_entry->data[i * 8] << 24)
+			    + ( (u32) fw_entry->data[i * 8 + 1] << 16)
+			    + ( (u32) fw_entry->data[i * 8 + 2] << 8)
+			    + ( (u32) fw_entry->data[i * 8 + 3])
+			  );
 		R128_WRITE( R128_PM4_MICROCODE_DATAL,
-			    r128_cce_microcode[i * 2 + 1] );
+			      ( (u32) fw_entry->data[i * 8 + 4] << 24)
+			    + ( (u32) fw_entry->data[i * 8 + 5] << 16)
+			    + ( (u32) fw_entry->data[i * 8 + 6] << 8)
+			    + ( (u32) fw_entry->data[i * 8 + 7])
+			  );
 	}
+	release_firmware(fw_entry);
 }
 
 /* Flush any pending commands to the CCE.  This should only be used just
@@ -603,7 +589,7 @@
 #endif
 
 	r128_cce_init_ring_buffer( dev, dev_priv );
-	r128_cce_load_microcode( dev_priv );
+	r128_cce_load_microcode( dev, dev_priv );
 
 	dev->dev_private = (void *)dev_priv;
 

-- 
Make sure your vote will count.
http://www.verifiedvoting.org/
