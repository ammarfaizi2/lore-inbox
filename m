Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTI0Dfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 23:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTI0Dfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 23:35:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:11281 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262056AbTI0DfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 23:35:05 -0400
Date: Sat, 27 Sep 2003 13:31:40 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ARCNET] Fix double request_region in com20020
Message-ID: <20030927033140.GA8051@gondor.apana.org.au>
References: <20030927033055.GA8012@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20030927033055.GA8012@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 27, 2003 at 01:30:55PM +1000, herbert wrote:
> 
> Currently com20020 and com20020_cs both call request_region on the same
> block of ports leading to a conflict.  This patch resolves this by moving
> request_region out of the generic driver and into the isa/pci/cs drivers.

And here is the patch for 2.4.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

Index: kernel-source-2.4/drivers/net/arcnet/com20020-isa.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/com20020-isa.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 com20020-isa.c
--- kernel-source-2.4/drivers/net/arcnet/com20020-isa.c	3 Aug 2002 00:39:44 -0000	1.1.1.5
+++ kernel-source-2.4/drivers/net/arcnet/com20020-isa.c	27 Sep 2003 03:19:37 -0000
@@ -53,6 +53,7 @@
 	int ioaddr;
 	unsigned long airqmask;
 	struct arcnet_local *lp = dev->priv;
+	int err;
 
 #ifndef MODULE
 	arcnet_init();
@@ -66,17 +67,20 @@
 		       "must specify the base address!\n");
 		return -ENODEV;
 	}
-	if (check_region(ioaddr, ARCNET_TOTAL_SIZE)) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
 		BUGMSG(D_NORMAL, "IO region %xh-%xh already allocated.\n",
 		       ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
 		return -ENXIO;
 	}
 	if (ASTATUS() == 0xFF) {
 		BUGMSG(D_NORMAL, "IO address %x empty\n", ioaddr);
-		return -ENODEV;
+		err = -ENODEV;
+		goto out;
+	}
+	if (com20020_check(dev)) {
+		err = -ENODEV;
+		goto out;
 	}
-	if (com20020_check(dev))
-		return -ENODEV;
 
 	if (!dev->irq) {
 		/* if we do this, we're sure to get an IRQ since the
@@ -100,13 +104,21 @@
 			dev->irq = probe_irq_off(airqmask);
 			if (dev->irq <= 0) {
 				BUGMSG(D_NORMAL, "Autoprobe IRQ failed.\n");
-				return -ENODEV;
+				err = -ENODEV;
+				goto out;
 			}
 		}
 	}
 
 	lp->card_name = "ISA COM20020";
-	return com20020_found(dev, 0);
+	if ((err = com20020_found(dev, SA_SHIRQ)) != 0)
+		goto out;
+
+	return 0;
+
+out:
+	release_region(ioaddr, ARCNET_TOTAL_SIZE);
+	return err;
 }
 
 
@@ -182,6 +194,7 @@
 void cleanup_module(void)
 {
 	com20020_remove(my_dev);
+	release_region(my_dev->base_addr, ARCNET_TOTAL_SIZE);
 }
 
 #else
Index: kernel-source-2.4/drivers/net/arcnet/com20020-pci.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/com20020-pci.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 com20020-pci.c
--- kernel-source-2.4/drivers/net/arcnet/com20020-pci.c	1 Jun 2003 03:06:26 -0000	1.1.1.10
+++ kernel-source-2.4/drivers/net/arcnet/com20020-pci.c	27 Sep 2003 03:15:23 -0000
@@ -113,7 +113,7 @@
 	lp->timeout = timeout;
 	lp->hw.open_close_ll = com20020pci_open_close;
 
-	if (check_region(ioaddr, ARCNET_TOTAL_SIZE)) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
 		BUGMSG(D_INIT, "IO region %xh-%xh already allocated.\n",
 		       ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
 		err = -EBUSY;
@@ -123,18 +123,20 @@
 		BUGMSG(D_NORMAL, "IO address %Xh was reported by PCI BIOS, "
 		       "but seems empty!\n", ioaddr);
 		err = -EIO;
-		goto out_priv;
+		goto out_port;
 	}
 	if (com20020_check(dev)) {
 		err = -EIO;
-		goto out_priv;
+		goto out_port;
 	}
 
 	if ((err = com20020_found(dev, SA_SHIRQ)) != 0)
-	        goto out_priv;
+	        goto out_port;
 
 	return 0;
 
+out_port:
+	release_region(ioaddr, ARCNET_TOTAL_SIZE);
 out_priv:
 	kfree(dev->priv);
 out_dev:
@@ -144,7 +146,9 @@
 
 static void __devexit com20020pci_remove(struct pci_dev *pdev)
 {
-	com20020_remove(pci_get_drvdata(pdev));
+	struct net_device *dev = pci_get_drvdata(pdev);
+	com20020_remove(dev);
+	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 }
 
 static struct pci_device_id com20020pci_id_table[] __devinitdata = {
Index: kernel-source-2.4/drivers/net/arcnet/com20020.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/com20020.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 com20020.c
--- kernel-source-2.4/drivers/net/arcnet/com20020.c	1 Jun 2003 03:06:26 -0000	1.1.1.5
+++ kernel-source-2.4/drivers/net/arcnet/com20020.c	27 Sep 2003 03:10:58 -0000
@@ -204,12 +204,6 @@
 		BUGMSG(D_NORMAL, "Can't get IRQ %d!\n", dev->irq);
 		return -ENODEV;
 	}
-	/* reserve the I/O region */
-	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
-		free_irq(dev->irq, dev);
-		return -EBUSY;
-	}
-	dev->base_addr = ioaddr;
 
 	BUGMSG(D_NORMAL, "%s: station %02Xh found at %03lXh, IRQ %d.\n",
 	       lp->card_name, dev->dev_addr[0], dev->base_addr, dev->irq);
@@ -226,7 +220,6 @@
 
 	if (!dev->init && register_netdev(dev)) {
 		free_irq(dev->irq, dev);
-		release_region(ioaddr, ARCNET_TOTAL_SIZE);
 		return -EIO;
 	}
 	return 0;
@@ -348,7 +341,6 @@
 {
 	unregister_netdev(dev);
 	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 	kfree(dev->priv);
 	kfree(dev);
 }

--zhXaljGHf11kAtnf--
