Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQLAUk2>; Fri, 1 Dec 2000 15:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQLAUkT>; Fri, 1 Dec 2000 15:40:19 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:59737
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129932AbQLAUkG>; Fri, 1 Dec 2000 15:40:06 -0500
Date: Fri, 1 Dec 2000 21:09:30 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: vma@iol.unh.edu
Cc: linux-kernel@vger.kernel.org
Subject: #ifdef cleanup for drivers/net/fc/iph5526.c (240-test12-pre3)
Message-ID: <20001201210930.H621@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I recently investigated an 'unused function' warning in iph5526.c. Looking
at it (both the code causing the warning and the whole driver) convinced
me that the driver cannot be used without PCI enabled. 

I therefore propose that we add a dependency in net/Config.in for this
driver and clean the driver itself of #ifdef CONFIG_PCI stuff. The patch 
below does this and additionally some trivial code reordering to elininate
some further #ifdefs.

Please comment.


--- linux-240-t12-pre3-clean/drivers/net/fc/iph5526.c	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/fc/iph5526.c	Fri Dec  1 20:48:16 2000
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
--- linux-240-t12-pre3-clean/drivers/net/Config.in	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/Config.in	Wed Nov 29 20:00:37 2000
@@ -258,7 +258,7 @@
 
 bool 'Fibre Channel driver support' CONFIG_NET_FC
 if [ "$CONFIG_NET_FC" = "y" ]; then
-   dep_tristate '  Interphase 5526 Tachyon chipset based adapter support' CONFIG_IPHASE5526 $CONFIG_SCSI
+   dep_tristate '  Interphase 5526 Tachyon chipset based adapter support' CONFIG_IPHASE5526 $CONFIG_SCSI $CONFIG_PCI
 fi
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"The glass is not half full, nor half empty. The glass is just too big."
  --Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
