Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTLNUTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTLNUTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:19:16 -0500
Received: from mx2.mail.ru ([194.67.23.22]:24076 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262355AbTLNUTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:19:07 -0500
Date: Sun, 14 Dec 2003 15:18:52 -0500
From: Alexander & Tatiana Bogdashevsky <sanderb@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH] 2.4.24-pre1 amd76x_pm.c
Message-Id: <20031214151852.6743b854.sanderb@mail.ru>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__14_Dec_2003_15_18_52_-0500_6y8eNAfCLSaUChv8"
X-Spam: Probable Spam
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__14_Dec_2003_15_18_52_-0500_6y8eNAfCLSaUChv8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

I did not find who is the maintainer of this module now (after Alan Cox went
studying), so I am sending the patch here.

There is a problem with amd76x_pm module in 2.4.23 and 2.4.24-pre1: it is
trying to grab southbridge unconditionally and if some other process already
did this, amd76x_pm just fails. As example: it is not compatible with
lm-sensor 2.8 and up.
This patch fixes this problem. It is based on Pasi Savolainen's patch for
2.6.0-test9(southbridge related changes only). The patch was tested (I am
using it on my ASUS A7M266-D with 2 Athlon MP 2000 CPUs without any problems).

With best regards,
Alexander Bogdashevsky
-------------------- start of patch ------------------
diff -ruN linux-2.4.24-pre1/drivers/char/amd76x_pm.c
linux-2.4.24-pre1-amd76x_pm/drivers/char/amd76x_pm.c---
linux-2.4.24-pre1/drivers/char/amd76x_pm.c	2003-11-28 13:26:20.000000000
-0500+++ linux-2.4.24-pre1-amd76x_pm/drivers/char/amd76x_pm.c	2003-12-08 22:56:24.000000000 -0500@@ -95,10 +95,6 @@
 static int __devinit amd_nb_init(struct pci_dev *pdev,
 				 const struct pci_device_id *ent);
 static void amd_nb_remove(struct pci_dev *pdev);
-static int __devinit amd_sb_init(struct pci_dev *pdev,
-				 const struct pci_device_id *ent);
-static void amd_sb_remove(struct pci_dev *pdev);
-
 
 static struct pci_dev *pdev_nb;
 static struct pci_dev *pdev_sb;
@@ -141,14 +137,6 @@
 	remove:__devexit_p(amd_nb_remove),
 };
 
-static struct pci_driver amd_sb_driver = {
-	name:"amd76x_pm-sb",
-	id_table:amd_sb_tbl,
-	probe:amd_sb_init,
-	remove:__devexit_p(amd_sb_remove),
-};
-
-
 static int __devinit
 amd_nb_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -165,24 +153,6 @@
 {
 }
 
-
-static int __devinit
-amd_sb_init(struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	pdev_sb = pdev;
-	printk(KERN_INFO "amd76x_pm: Initializing southbridge %s\n",
-	       pdev_sb->name);
-
-	return 0;
-}
-
-
-static void __devexit
-amd_sb_remove(struct pci_dev *pdev)
-{
-}
-
-
 /*
  * Configures the AMD-762 northbridge to support PM calls
  */
@@ -576,6 +546,17 @@
 {
 	int found;
 
+        /* Find southbridge */
+        pdev_sb = NULL;
+        while ((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb))
!= NULL) {+                if (pci_match_device(amd_sb_tbl, pdev_sb) != NULL)
+                        goto found_sb;
+        }
+        printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+        return -ENODEV;
+
+found_sb:
+
 	/* Find northbridge */
 	found = pci_register_driver(&amd_nb_driver);
 	if (found <= 0) {
@@ -584,15 +565,6 @@
 		return 1;
 	}
 
-	/* Find southbridge */
-	found = pci_register_driver(&amd_sb_driver);
-	if (found <= 0) {
-		printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
-		pci_unregister_driver(&amd_sb_driver);
-		pci_unregister_driver(&amd_nb_driver);
-		return 1;
-	}
-
 	/* Init southbridge */
 	switch (pdev_sb->device) {
 	case PCI_DEVICE_ID_AMD_VIPER_7413:	/* AMD-765 or 766 */
@@ -623,7 +595,6 @@
 	if (!amd76x_pm_cfg.curr_idle) {
 		printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
 		pci_unregister_driver(&amd_nb_driver);
-		pci_unregister_driver(&amd_sb_driver);
 		return 1;
 	}
 
@@ -683,8 +654,6 @@
 #endif
 
 	pci_unregister_driver(&amd_nb_driver);
-	pci_unregister_driver(&amd_sb_driver);
-
 }
 
 

--Signature=_Sun__14_Dec_2003_15_18_52_-0500_6y8eNAfCLSaUChv8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3MW3kWRpnirqPNYRAudRAJ4hBwFYEZQBwQZ0g6ez/xQpOU0AbQCcCSpx
Nv1IUBkiXpmNGjqlltb8S5I=
=Pk0G
-----END PGP SIGNATURE-----

--Signature=_Sun__14_Dec_2003_15_18_52_-0500_6y8eNAfCLSaUChv8--
