Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUDWKUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUDWKUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUDWKUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:20:21 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:12046 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264722AbUDWKUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:20:07 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pegasus@nerv.eu.org (Jure Pe?ar), debian-alpha@lists.debian.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH} Fix bad __exit reference in aic7xxx (was: building a recent kernel ...)
Organization: Core
In-Reply-To: <20040422001939.2e1ec7a2.pegasus@nerv.eu.org>
X-Newsgroups: apana.lists.os.linux.debian.alpha
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BGxmQ-0002sT-00@gondolin.me.apana.org.au>
Date: Fri, 23 Apr 2004 20:19:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jure Pe?ar <pegasus@nerv.eu.org> wrote:
>
> Error: ./drivers/scsi/aic7xxx/aic7xxx_osm.o .init.text refers to
> 0000000000000040 ELF_LITERAL       .exit.text
> Error: ./drivers/scsi/aic7xxx/aic7xxx_osm.o .init.text refers to
> 0000000000000044 HINT              .exit.text
> Error: ./drivers/scsi/aic7xxx/aic7xxx_osm.o .eh_frame refers to
> 0000000000000941 SREL32            .exit.text

That was my fault.  This patch should fix it.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/aic7xxx/aic7xxx_osm.c,v
retrieving revision 1.5
diff -u -r1.5 aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c	3 Apr 2004 10:13:36 -0000	1.5
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c	23 Apr 2004 10:15:57 -0000
@@ -891,21 +891,14 @@
 	 */
 	ahc_list_lockinit();
 
-#ifdef CONFIG_PCI
 	found = ahc_linux_pci_init();
 	if (found)
-		goto out;
-#endif
+		goto pci_err;
 
-#ifdef CONFIG_EISA
 	found = ahc_linux_eisa_init();
 	if (found) {
-#ifdef CONFIG_PCI
-		ahc_linux_pci_exit();
-#endif
-		goto out;
+		goto eisa_err;
 	}
-#endif
 
 	/*
 	 * Register with the SCSI layer all
@@ -921,7 +914,15 @@
 #endif
 	aic7xxx_detect_complete++;
 
-out:
+	if (!found) {
+		found = -ENODEV;
+
+		ahc_linux_eisa_exit();
+eisa_err:
+		ahc_linux_pci_exit();
+	}
+
+pci_err:
 	return (found);
 }
 
@@ -5088,11 +5089,7 @@
 ahc_linux_init(void)
 {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	int rc = ahc_linux_detect(&aic7xxx_driver_template);
-	if (rc)
-		return rc;
-	ahc_linux_exit();
-	return -ENODEV;
+	return ahc_linux_detect(&aic7xxx_driver_template);
 #else
 	scsi_register_module(MODULE_SCSI_HA, &aic7xxx_driver_template);
 	if (aic7xxx_driver_template.present == 0) {
@@ -5132,12 +5129,8 @@
 	 */
 	scsi_unregister_module(MODULE_SCSI_HA, &aic7xxx_driver_template);
 #endif
-#ifdef CONFIG_PCI
 	ahc_linux_pci_exit();
-#endif
-#ifdef CONFIG_EISA
 	ahc_linux_eisa_exit();
-#endif
 }
 
 module_init(ahc_linux_init);
Index: drivers/scsi/aic7xxx/aic7xxx_osm.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/scsi/aic7xxx/aic7xxx_osm.h,v
retrieving revision 1.2
diff -u -r1.2 aic7xxx_osm.h
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h	3 Apr 2004 09:26:57 -0000	1.2
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h	23 Apr 2004 10:12:43 -0000
@@ -845,6 +845,9 @@
 int			 aic7770_map_registers(struct ahc_softc *ahc,
 					       u_int port);
 int			 aic7770_map_int(struct ahc_softc *ahc, u_int irq);
+#else
+static __inline int ahc_linux_eisa_init(void) { return 0; }
+static __inline void ahc_linux_eisa_exit(void) {}
 #endif
 
 /******************************* PCI Routines *********************************/
@@ -960,6 +963,9 @@
  */
 #define ahc_pci_set_dma_mask(dev_softc, mask)  			\
 	(((dev_softc)->dma_mask = mask) && 0)
+
+static __inline int ahc_linux_pci_init(void) { return 0; }
+static __inline void ahc_linux_pci_exit(void) {}
 #endif
 /**************************** Proc FS Support *********************************/
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
