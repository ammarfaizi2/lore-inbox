Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261922AbSI3FD0>; Mon, 30 Sep 2002 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbSI3FD0>; Mon, 30 Sep 2002 01:03:26 -0400
Received: from dp.samba.org ([66.70.73.150]:26259 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261922AbSI3FDV>;
	Mon, 30 Sep 2002 01:03:21 -0400
Date: Mon, 30 Sep 2002 15:08:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Orinoco-devel] Re: Orinoco driver update
Message-ID: <20020930050846.GG10265@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020927025227.GC1898@zax> <3D94B7F5.6030401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D94B7F5.6030401@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 03:56:37PM -0400, Jeff Garzik wrote:
> David,
> 
> This doesn't compile at all...  stuff like "static void 
> orinoco_reset[...]" in orinoco.c being called from orinoco_pci.c could 
> never hope to build...
> 
> Linus applied it... would you mind sending an update patch please?

Crud.  Looks like my patch making script was borken, so orinoco_pci.c
wasn't updated properly.  The patch below should fix that, and adds
some other minor updates (driver version 0.13a) as well.

diff -uNr linux-2.5-pristine/drivers/net/wireless/airport.c linux-orinoco/drivers/net/wireless/airport.c
--- linux-2.5-pristine/drivers/net/wireless/airport.c	2002-09-28 08:12:21.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/airport.c	2002-09-30 14:46:30.000000000 +1000
@@ -1,4 +1,4 @@
-/* airport.c 0.13
+/* airport.c 0.13a
  *
  * A driver for "Hermes" chipset based Apple Airport wireless
  * card.
@@ -264,7 +264,7 @@
 	kfree(dev);
 }				/* airport_detach */
 
-static char version[] __initdata = "airport.c 0.13 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "airport.c 0.13a (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
diff -uNr linux-2.5-pristine/drivers/net/wireless/hermes.h linux-orinoco/drivers/net/wireless/hermes.h
--- linux-2.5-pristine/drivers/net/wireless/hermes.h	2002-09-28 08:12:21.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/hermes.h	2002-09-30 14:46:30.000000000 +1000
@@ -251,6 +251,18 @@
 	struct hermes_scan_apinfo aps[35];        /* Scan result */
 } __attribute__ ((packed));
 
+#define HERMES_LINKSTATUS_NOT_CONNECTED   (0x0000)  
+#define HERMES_LINKSTATUS_CONNECTED       (0x0001)
+#define HERMES_LINKSTATUS_DISCONNECTED    (0x0002)
+#define HERMES_LINKSTATUS_AP_CHANGE       (0x0003)
+#define HERMES_LINKSTATUS_AP_OUT_OF_RANGE (0x0004)
+#define HERMES_LINKSTATUS_AP_IN_RANGE     (0x0005)
+#define HERMES_LINKSTATUS_ASSOC_FAILED    (0x0006)
+  
+struct hermes_linkstatus {
+	u16 linkstatus;         /* Link status */
+} __attribute__ ((packed));
+
 // #define HERMES_DEBUG_BUFFER 1
 #define HERMES_DEBUG_BUFSIZE 4096
 struct hermes_debug_entry {
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco.c linux-orinoco/drivers/net/wireless/orinoco.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco.c	2002-09-28 08:12:22.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.c	2002-09-30 14:46:30.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco.c 0.13	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c 0.13a	- (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
@@ -316,16 +316,22 @@
  *	o No longer ignore the hard_reset argument to
  *	  alloc_orinocodev().  Oops.
  *
- * v0.12c -> v0.13 - 13 Sep 2002 - David Gibson
+ * v0.12c -> v0.13beta1 - 13 Sep 2002 - David Gibson
  *	o Revert the broken 0.12* locking scheme and go to a new yet
  *	  simpler scheme.
  *	o Do firmware resets only in orinoco_init() and when waking
  *	  the card from hard sleep.
  *
- * v0.13 -> v0.13 - 27 Sep 2002 - David Gibson
+ * v0.13beta1 -> v0.13 - 27 Sep 2002 - David Gibson
  *	o Re-introduced full resets (via schedule_task()) on Tx
  *	  timeout.
  *
+ * v0.13 -> v0.13a - 30 Sep 2002 - David Gibson
+ *	o Minor cleanups to info frame handling.  Add basic support
+ *	  for linkstatus info frames.
+ *	o Include required kernel headers in orinoco.h, to avoid
+ *	  compile problems.
+ *
  * TODO
  *	o New wireless extensions API (patch forthcoming from Moustafa
  *	  Youssef).
@@ -1424,6 +1430,7 @@
 		u16 len;
 		u16 type;
 	} __attribute__ ((packed)) info;
+	int len, type;
 	int err;
 
 	/* This is an answer to an INQUIRE command that we did earlier,
@@ -1441,25 +1448,29 @@
 		return;
 	}
 	
-	switch (le16_to_cpu(info.type)) {
+	len = HERMES_RECLEN_TO_BYTES(le16_to_cpu(info.len));
+	type = le16_to_cpu(info.type);
+
+	switch (type) {
 	case HERMES_INQ_TALLIES: {
 		struct hermes_tallies_frame tallies;
 		struct iw_statistics *wstats = &priv->wstats;
-		int len = le16_to_cpu(info.len) - 1;
 		
-		if (len > (sizeof(tallies) / 2)) {
-			DEBUG(1, "%s: tallies frame too long.\n", dev->name);
-			len = sizeof(tallies) / 2;
+		if (len > sizeof(tallies)) {
+			printk(KERN_WARNING "%s: Tallies frame too long (%d bytes)\n",
+			       dev->name, len);
+			len = sizeof(tallies);
 		}
 		
 		/* Read directly the data (no seek) */
-		hermes_read_words(hw, HERMES_DATA1, (void *) &tallies, len);
+		hermes_read_words(hw, HERMES_DATA1, (void *) &tallies,
+				  len / 2); /* FIXME: blech! */
 		
 		/* Increment our various counters */
 		/* wstats->discard.nwid - no wrong BSSID stuff */
 		wstats->discard.code +=
 			le16_to_cpu(tallies.RxWEPUndecryptable);
-		if (len == (sizeof(tallies) / 2))  
+		if (len == sizeof(tallies))  
 			wstats->discard.code +=
 				le16_to_cpu(tallies.RxDiscards_WEPICVError) +
 				le16_to_cpu(tallies.RxDiscards_WEPExcluded);
@@ -1474,9 +1485,54 @@
 #endif /* WIRELESS_EXT > 11 */
 	}
 	break;
+	case HERMES_INQ_LINKSTATUS: {
+		struct hermes_linkstatus linkstatus;
+		u16 newstatus;
+		const char *s;
+		
+		if (len != sizeof(linkstatus)) {
+			printk(KERN_WARNING "%s: Unexpected size for linkstatus frame (%d bytes)\n",
+			       dev->name, len);
+			break;
+		}
+
+		hermes_read_words(hw, HERMES_DATA1, (void *) &linkstatus,
+				  len / 2);
+		newstatus = le16_to_cpu(linkstatus.linkstatus);
+
+		switch (newstatus) {
+		case HERMES_LINKSTATUS_NOT_CONNECTED:
+			s = "Not Connected";
+                       break;
+               case HERMES_LINKSTATUS_CONNECTED:
+		       s = "Connected";
+                       break;
+               case HERMES_LINKSTATUS_DISCONNECTED:
+		       s = "Disconnected";
+                       break;
+               case HERMES_LINKSTATUS_AP_CHANGE:
+		       s = "AP Changed";
+                       break;
+               case HERMES_LINKSTATUS_AP_OUT_OF_RANGE:
+		       s = "AP Out of Range";
+                       break;
+               case HERMES_LINKSTATUS_AP_IN_RANGE:
+		       s = "AP In Range";
+                       break;
+               case HERMES_LINKSTATUS_ASSOC_FAILED:
+		       s = "Association Failed";
+		       break;
+		default:
+			s = "UNKNOWN";
+		}
+
+		printk(KERN_INFO "%s: New link status: %s (%04x)\n",
+		       dev->name, s, newstatus);
+	}
+	break;
 	default:
-		DEBUG(1, "%s: Unknown information frame received (type %04x).\n",
-		      priv->ndev->name, le16_to_cpu(info.type));
+		printk(KERN_DEBUG "%s: Unknown information frame received (type %04x).\n",
+		      dev->name, type);
 		/* We don't actually do anything about it */
 		break;
 	}
@@ -4206,7 +4262,7 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco.c 0.13 (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init init_orinoco(void)
 {
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco.h linux-orinoco/drivers/net/wireless/orinoco.h
--- linux-2.5-pristine/drivers/net/wireless/orinoco.h	2002-09-28 08:12:22.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco.h	2002-09-30 14:46:30.000000000 +1000
@@ -7,6 +7,11 @@
 #ifndef _ORINOCO_H
 #define _ORINOCO_H
 
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/netdevice.h>
+#include <linux/wireless.h>
+#include <linux/tqueue.h>
 #include "hermes.h"
 
 /* To enable debug messages */
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c linux-orinoco/drivers/net/wireless/orinoco_cs.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_cs.c	2002-09-28 08:12:22.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_cs.c	2002-09-30 14:46:30.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.13	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.13a	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -693,7 +693,7 @@
 
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
-static char version[] __initdata = "orinoco_cs.c 0.13 (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char version[] __initdata = "orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 static int __init
 init_orinoco_cs(void)
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_pci.c linux-orinoco/drivers/net/wireless/orinoco_pci.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_pci.c	2002-08-14 13:13:13.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_pci.c	2002-09-30 14:46:30.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_pci.c 0.01
+/* orinoco_pci.c 0.13a
  * 
  * Driver for Prism II devices that have a direct PCI interface
  * (i.e., not in a Pcmcia or PLX bridge)
@@ -122,41 +122,6 @@
 #define HERMES_PCI_COR_OFFT	(500)		/* ms */
 #define HERMES_PCI_COR_BUSYT	(500)		/* ms */
 
-MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
-MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
-MODULE_LICENSE("Dual MPL/GPL");
-
-static int orinoco_pci_open(struct net_device *dev)
-{
-	struct orinoco_private *priv = (struct orinoco_private *) dev->priv;
-	int err;
-
-	netif_device_attach(dev);
-
-	err = orinoco_reset(priv);
-	if (err)
-		printk(KERN_ERR "%s: orinoco_reset failed in orinoco_pci_open()",
-		       dev->name);
-	else
-		netif_start_queue(dev);
-
-	return err;
-}
-
-static int orinoco_pci_stop(struct net_device *dev)
-{
-	struct orinoco_private *priv = (struct orinoco_private *) dev->priv;
-	netif_stop_queue(dev);
-	orinoco_shutdown(priv);
-	return 0;
-}
-
-static void
-orinoco_pci_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	orinoco_interrupt(irq, (struct orinoco_private *)dev_id, regs);
-}
-
 /*
  * Do a soft reset of the PCI card using the Configuration Option Register
  * We need this to get going...
@@ -179,7 +144,6 @@
 
 	TRACE_ENTER(priv->ndev->name);
 
-
 	/* Assert the reset until the card notice */
 	hermes_write_regn(hw, PCI_COR, HERMES_PCI_COR_MASK);
 	printk(KERN_NOTICE "Reset done");
@@ -235,8 +199,6 @@
 	struct net_device *dev = NULL;
 	int netdev_registered = 0;
 
-	TRACE_ENTER("orinoco_pci");
-
 	err = pci_enable_device(pdev);
 	if (err)
 		return -EIO;
@@ -249,7 +211,7 @@
 		goto fail;
 
 	/* Usual setup of structures */
-	dev = alloc_orinocodev(0);
+	dev = alloc_orinocodev(0, NULL);
 	if (! dev) {
 		err = -ENOMEM;
 		goto fail;
@@ -259,9 +221,6 @@
 	dev->base_addr = (int) pci_ioaddr;
         dev->mem_start = (unsigned long) pci_iorange;
         dev->mem_end = ((unsigned long) pci_iorange) + pci_iolen - 1;
-	dev->open = orinoco_pci_open;
-	dev->stop = orinoco_pci_stop;
-/*  	priv->card_reset_handler = orinoco_pci_cor_reset; */
 
 	SET_MODULE_OWNER(dev);
 
@@ -270,9 +229,9 @@
 	       pdev->slot_name, dev->mem_start, dev->mem_end, pci_ioaddr, pdev->irq);
 
 	hermes_struct_init(&(priv->hw), dev->base_addr, HERMES_MEM, HERMES_32BIT_REGSPACING);
-	pci_set_drvdata(pdev, priv);
+	pci_set_drvdata(pdev, dev);
 
-	err = request_irq(pdev->irq, orinoco_pci_interrupt, SA_SHIRQ, dev->name, priv);
+	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ, dev->name, priv);
 	if (err) {
 		printk(KERN_ERR "orinoco_pci: Error allocating IRQ %d.\n", pdev->irq);
 		err = -EBUSY;
@@ -291,32 +250,30 @@
 	priv->firmware_type = FIRMWARE_TYPE_INTERSIL;
 
 	err = register_netdev(dev);
-	if (err)
+	if (err) {
+		printk(KERN_ERR "%s: Failed to register net device\n", dev->name);
 		goto fail;
+	}
 	netdev_registered = 1;
 
-	err = orinoco_proc_dev_init(priv);
+	err = orinoco_proc_dev_init(dev);
 	if (err) {
 		printk(KERN_ERR "%s: Failed to create /proc node\n", dev->name);
 		err = -EIO;
 		goto fail;
 	}
 
-	TRACE_EXIT("orinoco_pci");
-
         return 0;               /* succeeded */
  fail:
-	printk(KERN_DEBUG "orinoco_pci: init_one(), FAIL!\n");
-
-	if (priv) {
-		orinoco_proc_dev_cleanup(priv);
+	if (dev) {
+		orinoco_proc_dev_cleanup(dev);
 		if (netdev_registered)
 			unregister_netdev(dev);
 
 		if (dev->irq)
 			free_irq(dev->irq, priv);
 
-		kfree(priv);
+		kfree(dev);
 	}
 
 	if (pci_ioaddr)
@@ -327,15 +284,13 @@
 
 static void __devexit orinoco_pci_remove_one(struct pci_dev *pdev)
 {
-	struct orinoco_private *priv = pci_get_drvdata(pdev);
-	struct net_device *dev = priv->ndev;
-
-	TRACE_ENTER("orinoco_pci");
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct orinoco_private *priv = dev->priv;
 
-	if (!priv)
+	if (! dev)
 		BUG();
 
-	orinoco_proc_dev_cleanup(priv);
+	orinoco_proc_dev_cleanup(dev);
 
 	unregister_netdev(dev);
 
@@ -345,14 +300,11 @@
 	if (priv->hw.iobase)
 		iounmap((unsigned char *) priv->hw.iobase);
 
-	kfree(priv);
+	kfree(dev);
 
 	pci_disable_device(pdev);
-
-	TRACE_EXIT("orinoco_pci");
 }
 
-
 static struct pci_device_id orinoco_pci_pci_id_table[] __devinitdata = {
 	{0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
@@ -365,10 +317,18 @@
 	.id_table	= orinoco_pci_pci_id_table,
 	.probe		= orinoco_pci_init_one,
 	.remove		= __devexit_p(orinoco_pci_remove_one),
+	.suspend	= 0,
+	.resume		= 0
 };
 
+static char version[] __initdata = "orinoco_pci.c 0.13a (Jean Tourrilhes <jt@hpl.hp.com>)";
+MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
+MODULE_LICENSE("Dual MPL/GPL");
+
 static int __init orinoco_pci_init(void)
 {
+	printk(KERN_DEBUG "%s\n", version);
 	return pci_module_init(&orinoco_pci_driver);
 }
 
diff -uNr linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c linux-orinoco/drivers/net/wireless/orinoco_plx.c
--- linux-2.5-pristine/drivers/net/wireless/orinoco_plx.c	2002-09-28 08:12:22.000000000 +1000
+++ linux-orinoco/drivers/net/wireless/orinoco_plx.c	2002-09-30 14:46:30.000000000 +1000
@@ -1,4 +1,4 @@
-/* orinoco_plx.c 0.13
+/* orinoco_plx.c 0.13a
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052. 
@@ -341,7 +341,7 @@
 	.resume		= 0,
 };
 
-static char version[] __initdata = "orinoco_plx.c 0.13 (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
+static char version[] __initdata = "orinoco_plx.c 0.13a (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 #ifdef MODULE_LICENSE


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
