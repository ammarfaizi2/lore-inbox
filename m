Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUD3CFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUD3CFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbUD3CFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:05:37 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:59808 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265000AbUD3CFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:05:17 -0400
Subject: Re: 2.6.6-rc2-mm2
From: James Bottomley <James.Bottomley@steeleye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040430002455.GA996@holomorphy.com>
References: <20040426013944.49a105a8.akpm@osdl.org>
	<20040429184126.GB783@holomorphy.com>
	<20040429134546.5e9515d8.akpm@osdl.org>
	<20040429211825.GC783@holomorphy.com>  <20040430002455.GA996@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Apr 2004 21:05:06 -0500
Message-Id: <1083290708.1804.191.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 19:24, William Lee Irwin III wrote:
> # ChangeSet
> #   2004/04/25 09:10:30-05:00 akpm@osdl.org 
> #   [PATCH] aic7xxx: fix oops whe hardware is not present
> #   From: Herbert Xu <herbert@gondor.apana.org.au>

OK, well, on inspection that patch is fairly comprehensively incorrect.

Can you try out the attached?  I've compiled it but have nothing to test
installation with.

Thanks,

James

===== aic7770_osm.c 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/aic7770_osm.c	Tue Apr  6 23:09:31 2004
+++ edited/aic7770_osm.c	Thu Apr 29 20:07:39 2004
@@ -159,10 +159,10 @@
 void
 ahc_linux_eisa_exit(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	eisa_driver_unregister(&aic7770_driver);
-	free(aic7770_driver.id_table, M_DEVBUF);
-#endif
+	if(aic7xxx_probe_eisa_vl != 0 && aic7770_driver.id_table != NULL) {
+		eisa_driver_unregister(&aic7770_driver);
+		free(aic7770_driver.id_table, M_DEVBUF);
+	}
 }
 
 static int
===== aic7xxx_osm.c 1.51 vs edited =====
--- 1.51/drivers/scsi/aic7xxx/aic7xxx_osm.c	Sun Apr 25 09:11:53 2004
+++ edited/aic7xxx_osm.c	Thu Apr 29 20:32:32 2004
@@ -843,7 +843,8 @@
 ahc_linux_detect(Scsi_Host_Template *template)
 {
 	struct	ahc_softc *ahc;
-	int     found;
+	int     found = 0;
+	int	eisa_err, pci_err;
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	/*
@@ -891,21 +892,12 @@
 	 */
 	ahc_list_lockinit();
 
-#ifdef CONFIG_PCI
-	found = ahc_linux_pci_init();
-	if (found)
-		goto out;
-#endif
+	pci_err = ahc_linux_pci_init();
+	eisa_err = ahc_linux_eisa_init();
 
-#ifdef CONFIG_EISA
-	found = ahc_linux_eisa_init();
-	if (found) {
-#ifdef CONFIG_PCI
-		ahc_linux_pci_exit();
-#endif
+	if(pci_err && eisa_err)
 		goto out;
-	}
-#endif
+
 
 	/*
 	 * Register with the SCSI layer all
@@ -916,12 +908,13 @@
 		if (ahc_linux_register_host(ahc, template) == 0)
 			found++;
 	}
+out:
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	spin_lock_irq(&io_request_lock);
 #endif
 	aic7xxx_detect_complete++;
 
-out:
 	return (found);
 }
 
@@ -5078,7 +5071,7 @@
 	}
 }
 
-static void __exit ahc_linux_exit(void);
+static void ahc_linux_exit(void);
 
 static int __init
 ahc_linux_init(void)
@@ -5101,7 +5094,7 @@
 #endif
 }
 
-static void __exit
+static void
 ahc_linux_exit(void)
 {
 	struct ahc_softc *ahc;
@@ -5128,12 +5121,8 @@
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
===== aic7xxx_osm.h 1.52 vs edited =====
--- 1.52/drivers/scsi/aic7xxx/aic7xxx_osm.h	Tue Apr  6 23:09:31 2004
+++ edited/aic7xxx_osm.h	Thu Apr 29 20:39:50 2004
@@ -845,6 +845,12 @@
 int			 aic7770_map_registers(struct ahc_softc *ahc,
 					       u_int port);
 int			 aic7770_map_int(struct ahc_softc *ahc, u_int irq);
+#else
+static inline int	ahc_linux_eisa_init(void) {
+	return -ENODEV;
+}
+static inline void	ahc_linux_eisa_exit(void) {
+}
 #endif
 
 /******************************* PCI Routines *********************************/
@@ -931,6 +937,12 @@
 ahc_get_pci_bus(ahc_dev_softc_t pci)
 {
 	return (pci->bus->number);
+}
+#else
+static inline int ahc_linux_pci_init(void) {
+	return -ENODEV;
+}
+static inline void ahc_linux_pci_exit(void) {
 }
 #endif
 

