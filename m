Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbULIBxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbULIBxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULIBwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:52:43 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15037 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261435AbULIBvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:51:35 -0500
Date: Wed, 8 Dec 2004 17:51:34 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Fix via_ircc pci init code
Message-ID: <20041209015134.GB2298@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_via_pci_hack.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Bugfix suggested by Arkadiusz Miskiewicz>
	o [CORRECT] Try to fix the worse abuse of the pci init code in via_ircc

Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/via-ircc.d2.c linux/drivers/net/irda/via-ircc.c
--- linux/drivers/net/irda/via-ircc.d2.c	Wed Dec  8 16:13:03 2004
+++ linux/drivers/net/irda/via-ircc.c	Wed Dec  8 16:39:43 2004
@@ -75,6 +75,9 @@ static int dongle_id = 0;	/* default: pr
 /* We can't guess the type of connected dongle, user *must* supply it. */
 MODULE_PARM(dongle_id, "i");
 
+/* FIXME : we should not need this, because instances should be automatically
+ * managed by the PCI layer. Especially that we seem to only be using the
+ * first entry. Jean II */
 /* Max 4 instances for now */
 static struct via_ircc_cb *dev_self[] = { NULL, NULL, NULL, NULL };
 
@@ -153,11 +156,9 @@ static int __init via_ircc_init(void)
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	rc = pci_register_driver(&via_driver);
-	if (rc < 1) {
+	if (rc < 0) {
 		IRDA_DEBUG(0, "%s(): error rc = %d, returning  -ENODEV...\n",
 			   __FUNCTION__, rc);
-		if (rc == 0)
-			pci_unregister_driver (&via_driver);
 		return -ENODEV;
 	}
 	return 0;
@@ -288,15 +289,27 @@ static void __exit via_remove_one (struc
 {
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
+	/* FIXME : This is ugly. We should use pci_get_drvdata(pdev);
+	 * to get our driver instance and call directly via_ircc_close().
+	 * See vlsi_ir for details...
+	 * Jean II */
 	via_ircc_clean();
 
+	/* FIXME : This should be in via_ircc_close(), because here we may
+	 * theoritically disable still configured devices :-( - Jean II */
+	pci_disable_device(pdev);
 }
 
 static void __exit via_ircc_cleanup(void)
 {
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
+	/* FIXME : This should be redundant, as pci_unregister_driver()
+	 * should call via_remove_one() on each device.
+	 * Jean II */
 	via_ircc_clean();
+
+	/* Cleanup all instances of the driver */
 	pci_unregister_driver (&via_driver); 
 }
 
@@ -323,6 +336,10 @@ static __devinit int via_ircc_open(int i
 	self->netdev = dev;
 	spin_lock_init(&self->lock);
 
+	/* FIXME : We should store our driver instance in the PCI layer,
+	 * using pci_set_drvdata(), not in this array.
+	 * See vlsi_ir for details... - Jean II */
+	/* FIXME : 'i' is always 0 (see via_init_one()) :-( - Jean II */
 	/* Need to store self somewhere */
 	dev_self[i] = self;
 	self->index = i;
