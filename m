Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315305AbSEAGCG>; Wed, 1 May 2002 02:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315306AbSEAGCF>; Wed, 1 May 2002 02:02:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:36564 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315305AbSEAGCD>;
	Wed, 1 May 2002 02:02:03 -0400
Date: Wed, 1 May 2002 15:55:50 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
        Orinoco Testers List <orinoco-testers@lists.sourceforge.net>
Subject: Another orinoco update
Message-ID: <20020501055550.GG11049@zax>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Orinoco Testers List <orinoco-testers@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The patch below, against 2.5.12, makes another update to the orinoco
driver to fix several bad kfree() bugs in the version I sent you
yesterday.  And I'm all out of brown paper bags...

diff -uNr linux-2.5-pristine/drivers/net/wireless/airport.c linux-orinoco/drivers/net/wireless/airport.c
--- linux-2.5-pristine/drivers/net/wireless/airport.c	Wed May  1 11:15:48 2002
+++ linux-orinoco/drivers/net/wireless/airport.c	Wed May  1 15:47:29 2002
@@ -1,4 +1,4 @@
-/* airport.c 0.11a
+/* airport.c 0.11b
  *
  * A driver for "Hermes" chipset based Apple Airport wireless
  * card.
@@ -42,7 +42,7 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-static char version[] __initdata = "airport.c 0.11a (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "airport.c 0.11b (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
@@ -270,8 +270,8 @@
 static void
 airport_detach(struct net_device *dev)
 {
-	struct orinoco_private *priv = (struct orinoco_private *)dev->priv;
-	struct airport *card = (struct airport *)priv->card;
+	struct orinoco_private *priv = dev->priv;
+	struct airport *card = priv->card;
 
 	/* Unregister proc entry */
 	orinoco_proc_dev_cleanup(priv);
@@ -299,7 +299,7 @@
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(HZ);
 	
-	kfree(card);
+	kfree(dev);
 }				/* airport_detach */
 
 static int __init
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco.c linux-orinoco/drivers/net/wireless/orinoco.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco.c	Wed May  1 11:15:48 2002
+++ linux-orinoco/drivers/net/wireless/orinoco.c	Wed May  1 15:47:29 2002
@@ -1,4 +1,4 @@
-/* orinoco.c 0.11a	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c 0.11b	- (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
@@ -256,7 +256,7 @@
  *	o Fixes for recent Symbol firmwares which lack AP density
  *	  (Pavel Roskin).
  *
- * v0.11 -> v0.11a - 29 Apr 2002 - David Gibson
+ * v0.11 -> v0.11b - 29 Apr 2002 - David Gibson
  *	o Handle different register spacing, necessary for Prism 2.5
  *	  PCI adaptors (Steve Hill).
  *	o Cleaned up initialization of card structures in orinoco_cs
@@ -274,15 +274,21 @@
  *	o Makefile changes for better integration into David Hinds
  *	  pcmcia-cs package.
  *
+ * v0.11a -> v0.11b - 1 May 2002 - David Gibson
+ *	o Better error reporting in orinoco_plx_init_one()
+ *	o Fixed multiple bad kfree() bugs introduced by the
+ *	  alloc_orinocodev() changes.
+ *
  * TODO
- *	o Re-assess our encapsulation detection strategy
+ *	o New wireless extensions API
  *	o Handle de-encapsulation within network layer, provide 802.11
  *	  headers
  *	o Fix possible races in SPY handling.
  *	o Disconnect wireless extensions from fundamental configuration.
  *
  *	o Convert /proc debugging stuff to seqfile
- *	o Use multiple Tx buffers */
+ *	o Use multiple Tx buffers
+ */
 /* Notes on locking:
  *
  * The basic principle of operation is that everything except the
@@ -351,7 +357,7 @@
 #define SPY_NUMBER(priv)	0
 #endif /* WIRELESS_SPY */
 
-static char version[] __initdata = "orinoco.c 0.11a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for Lucent Orinoco, Prism II based and similar wireless cards");
 #ifdef MODULE_LICENSE
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c linux-orinoco/drivers/net/wireless/orinoco_cs.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c	Wed May  1 11:15:48 2002
+++ linux-orinoco/drivers/net/wireless/orinoco_cs.c	Wed May  1 15:47:29 2002
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.11a	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.11b	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -47,7 +47,7 @@
 
 /*====================================================================*/
 
-static char version[] __initdata = "orinoco_cs.c 0.11a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for PCMCIA Lucent Orinoco, Prism II based and similar wireless cards");
@@ -373,6 +373,7 @@
 {
 	dev_link_t **linkp;
 	struct orinoco_private *priv = link->priv;
+	struct net_device *dev = priv->ndev;
 
 	TRACE_ENTER("orinoco");
 
@@ -408,9 +409,9 @@
 	if (link->dev) {
 		DEBUG(0, "orinoco_cs: About to unregister net device %p\n",
 		      priv->ndev);
-		unregister_netdev(priv->ndev);
+		unregister_netdev(dev);
 	}
-	kfree(priv->card);
+	kfree(dev);
 
  out:
 	TRACE_EXIT("orinoco");
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c linux-orinoco/drivers/net/wireless/orinoco_plx.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c	Wed May  1 11:15:48 2002
+++ linux-orinoco/drivers/net/wireless/orinoco_plx.c	Wed May  1 15:47:29 2002
@@ -1,4 +1,4 @@
-/* orinoco_plx.c 0.11a
+/* orinoco_plx.c 0.11b
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052. 
@@ -134,7 +134,7 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-static char version[] __initdata = "orinoco_plx.c 0.11a (Daniel Barlow <dan@telent.net>)";
+static char version[] __initdata = "orinoco_plx.c 0.11b (Daniel Barlow <dan@telent.net>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 #ifdef MODULE_LICENSE
@@ -284,7 +284,7 @@
 
 	hermes_struct_init(&(priv->hw), dev->base_addr,
 			HERMES_IO, HERMES_16BIT_REGSPACING);
-	pci_set_drvdata(pdev, priv);
+	pci_set_drvdata(pdev, dev);
 
 	err = request_irq(pdev->irq, orinoco_plx_interrupt, SA_SHIRQ, dev->name, priv);
 	if (err) {
@@ -337,12 +337,12 @@
 
 static void __devexit orinoco_plx_remove_one(struct pci_dev *pdev)
 {
-	struct orinoco_private *priv = pci_get_drvdata(pdev);
-	struct net_device *dev = priv->ndev;
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct orinoco_private *priv = dev->priv;
 
 	TRACE_ENTER("orinoco_plx");
 
-	if (!priv)
+	if (! dev)
 		BUG();
 
 	orinoco_proc_dev_cleanup(priv);
@@ -352,7 +352,7 @@
 	if (dev->irq)
 		free_irq(dev->irq, priv);
 		
-	kfree(priv);
+	kfree(dev);
 
 	release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
 


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
