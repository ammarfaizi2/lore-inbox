Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTI0DbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 23:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTI0DbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 23:31:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6161 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262050AbTI0DbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 23:31:07 -0400
Date: Sat, 27 Sep 2003 13:30:55 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ARCNET] Fix double request_region in com20020
Message-ID: <20030927033055.GA8012@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Currently com20020 and com20020_cs both call request_region on the same
block of ports leading to a conflict.  This patch resolves this by moving
request_region out of the generic driver and into the isa/pci/cs drivers.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/net/arcnet/com20020-isa.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/arcnet/com20020-isa.c,v
retrieving revision 1.2
diff -u -r1.2 com20020-isa.c
--- kernel-source-2.5/drivers/net/arcnet/com20020-isa.c	30 Jul 2003 10:44:01 -0000	1.2
+++ kernel-source-2.5/drivers/net/arcnet/com20020-isa.c	27 Sep 2003 03:19:19 -0000
@@ -53,6 +53,7 @@
 	int ioaddr;
 	unsigned long airqmask;
 	struct arcnet_local *lp = dev->priv;
+	int err;
 
 	BUGLVL(D_NORMAL) printk(VERSION);
 
@@ -62,17 +63,20 @@
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
@@ -96,13 +100,21 @@
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
+	if ((err = com20020_found(dev, 0)) != 0)
+		goto out;
+
+	return 0;
+
+out:
+	release_region(ioaddr, ARCNET_TOTAL_SIZE);
+	return err;
 }
 
 
@@ -170,6 +182,7 @@
 void cleanup_module(void)
 {
 	com20020_remove(my_dev);
+	release_region(my_dev->base_addr, ARCNET_TOTAL_SIZE);
 }
 
 #else
Index: kernel-source-2.5/drivers/net/arcnet/com20020-pci.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/arcnet/com20020-pci.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 com20020-pci.c
--- kernel-source-2.5/drivers/net/arcnet/com20020-pci.c	22 Aug 2003 23:52:53 -0000	1.1.1.7
+++ kernel-source-2.5/drivers/net/arcnet/com20020-pci.c	27 Sep 2003 03:25:16 -0000
@@ -115,20 +115,20 @@
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
 
-	release_region(ioaddr, ARCNET_TOTAL_SIZE);
-
 	if ((err = com20020_found(dev, SA_SHIRQ)) != 0)
-	        goto out_priv;
+	        goto out_port;
 
 	return 0;
 
+out_port:
+	release_region(ioaddr, ARCNET_TOTAL_SIZE);
 out_priv:
 	kfree(dev->priv);
 out_dev:
@@ -138,7 +138,9 @@
 
 static void __devexit com20020pci_remove(struct pci_dev *pdev)
 {
-	com20020_remove(pci_get_drvdata(pdev));
+	struct net_device *dev = pci_get_drvdata(pdev);
+	com20020_remove(dev);
+	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 }
 
 static struct pci_device_id com20020pci_id_table[] = {
Index: kernel-source-2.5/drivers/net/arcnet/com20020.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/arcnet/com20020.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 com20020.c
--- kernel-source-2.5/drivers/net/arcnet/com20020.c	22 Aug 2003 23:53:52 -0000	1.1.1.4
+++ kernel-source-2.5/drivers/net/arcnet/com20020.c	27 Sep 2003 03:17:37 -0000
@@ -180,10 +180,6 @@
 	if (!dev->dev_addr[0])
 		dev->dev_addr[0] = inb(ioaddr + 8);	/* FIXME: do this some other way! */
 
-	/* reserve the I/O region */
-	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)"))
-		return -EBUSY;
-
 	SET_SUBADR(SUB_SETUP1);
 	outb(lp->setup, _XREG);
 
@@ -207,7 +203,6 @@
 	if (request_irq(dev->irq, &arcnet_interrupt, shared,
 			"arcnet (COM20020)", dev)) {
 		BUGMSG(D_NORMAL, "Can't get IRQ %d!\n", dev->irq);
-		release_region(ioaddr, ARCNET_TOTAL_SIZE);
 		return -ENODEV;
 	}
 
@@ -227,7 +222,6 @@
 	       clockrates[3 - ((lp->setup2 & 0xF0) >> 4) + ((lp->setup & 0x0F) >> 1)]);
 
 	if (!dev->init && register_netdev(dev)) {
-		release_region(ioaddr, ARCNET_TOTAL_SIZE);
 		free_irq(dev->irq, dev);
 		return -EIO;
 	}
@@ -342,7 +336,6 @@
 {
 	unregister_netdev(dev);
 	free_irq(dev->irq, dev);
-	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 	kfree(dev->priv);
 	free_netdev(dev);
 }

--FL5UXtIhxfXey3p5--
