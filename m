Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131332AbQLGXaE>; Thu, 7 Dec 2000 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131731AbQLGX3y>; Thu, 7 Dec 2000 18:29:54 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:30828
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131692AbQLGX3q>; Thu, 7 Dec 2000 18:29:46 -0500
Date: Fri, 8 Dec 2000 00:59:05 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: torvalds@transmeta.com, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PCI cleanup in drivers/net/fc/iph5526.c (240t12p7)
Message-ID: <20001208005905.A600@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch is blessed by the maintainer and is based on the observation
that the Interphase 5526 card requires PCI to work. Therefore the PCI
dependency is moved into net/Config.in and removed from the .c-file.
The maintainers email address is also updated and a minor code shuffle
is done in order to eliminate an #ifdef MODULE.

Please apply (or at least comment :) )


diff -Naur linux-240-t12-pre7-clean/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-240-t12-pre7-clean/drivers/net/Config.in	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/Config.in	Fri Dec  8 00:50:34 2000
@@ -258,7 +258,7 @@
 
 bool 'Fibre Channel driver support' CONFIG_NET_FC
 if [ "$CONFIG_NET_FC" = "y" ]; then
-   dep_tristate '  Interphase 5526 Tachyon chipset based adapter support' CONFIG_IPHASE5526 $CONFIG_SCSI
+   dep_tristate '  Interphase 5526 Tachyon chipset based adapter support' CONFIG_IPHASE5526 $CONFIG_SCSI $CONFIG_PCI
 fi
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -Naur linux-240-t12-pre7-clean/drivers/net/fc/iph5526.c linux/drivers/net/fc/iph5526.c
--- linux-240-t12-pre7-clean/drivers/net/fc/iph5526.c	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/fc/iph5526.c	Fri Dec  8 00:50:34 2000
@@ -1,7 +1,7 @@
 /**********************************************************************
  * iph5526.c: IP/SCSI driver for the Interphase 5526 PCI Fibre Channel
  *			  Card.
- * Copyright (C) 1999 Vineet M Abraham <vma@iol.unh.edu>
+ * Copyright (C) 1999 Vineet M Abraham <vmabraham@hotmail.com>
  *
  * This program is free software; you can redistribute it and/or 
  * modify it under the terms of the GNU General Public License as 
@@ -33,7 +33,7 @@
 */	
 
 static const char *version =
-    "iph5526.c:v1.0 07.08.99 Vineet Abraham (vma@iol.unh.edu)\n";
+    "iph5526.c:v1.0 07.08.99 Vineet Abraham (vmabraham@hotmail.com)\n";
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -220,32 +220,23 @@
 
 static void iph5526_timeout(struct net_device *dev);
 
-#ifdef CONFIG_PCI
 static int iph5526_probe_pci(struct net_device *dev);
-#endif
-
 
 int __init iph5526_probe(struct net_device *dev)
 {
-#ifdef CONFIG_PCI
 	if (pci_present() && (iph5526_probe_pci(dev) == 0))
 		return 0;
-#endif
     return -ENODEV;
 }
 
-#ifdef CONFIG_PCI
 static int __init iph5526_probe_pci(struct net_device *dev)
 {
-#ifndef MODULE
-struct fc_info *fi;
-static int count = 0;
-#endif
 #ifdef MODULE
-struct fc_info *fi = (struct fc_info *)dev->priv;
-#endif
-
-#ifndef MODULE
+	struct fc_info *fi = (struct fc_info *)dev->priv;
+#else
+	struct fc_info *fi;
+	static int count = 0;
+ 
 	if(fc[count] != NULL) {
 		if (dev == NULL) {
 			dev = init_fcdev(NULL, 0);
@@ -277,7 +268,6 @@
 	display_cache(fi);
 	return 0;
 }
-#endif  /* CONFIG_PCI */
 
 static int __init fcdev_init(struct net_device *dev)
 {
diff -Naur linux-240-t12-pre7-clean/drivers/net/fc/tach_structs.h linux/drivers/net/fc/tach_structs.h
--- linux-240-t12-pre7-clean/drivers/net/fc/tach_structs.h	Mon Aug 23 19:12:38 1999
+++ linux/drivers/net/fc/tach_structs.h	Fri Dec  8 00:50:34 2000
@@ -1,7 +1,7 @@
 /**********************************************************************
  * iph5526.c: Structures for the Interphase 5526 PCI Fibre Channel 
  *			  IP/SCSI driver.
- * Copyright (C) 1999 Vineet M Abraham <vma@iol.unh.edu>
+ * Copyright (C) 1999 Vineet M Abraham <vmabraham@hotmail.com>
  **********************************************************************/
 
 #ifndef _TACH_STRUCT_H

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Without censorship, things can get terribly confused in the
public mind. -General William Westmoreland, during the war in Viet Nam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
