Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRAKO46>; Thu, 11 Jan 2001 09:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAKO4t>; Thu, 11 Jan 2001 09:56:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:28918 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129927AbRAKO4h>; Thu, 11 Jan 2001 09:56:37 -0500
Date: Thu, 11 Jan 2001 11:09:21 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rick Richardson <rick@remotepoint.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] dgrs.c: kmalloc release on failure
Message-ID: <20010111110921.F32099@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rick Richardson <rick@remotepoint.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <01011109382601.29363@depoffice.localdomain> <E14Gj32-0002ND-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Gj32-0002ND-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 11, 2001 at 02:49:49PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying, comments in the patch.

- Arnaldo

--- linux-2.4.0-ac6/drivers/net/dgrs.c	Tue Dec 19 11:25:40 2000
+++ linux-2.4.0-ac6.acme/drivers/net/dgrs.c	Thu Jan 11 11:05:05 2001
@@ -71,6 +71,13 @@
  *	  into the kernel.
  *	- Better handling of multicast addresses.
  *
+ *	Fixes:
+ *	Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 11/01/2001
+ *	- fix dgrs_found_device wrt checking kmalloc return and
+ *	rollbacking the partial steps of the whole process when
+ *	one of the devices can't be allocated. Fix SET_MODULE_OWNER
+ *	on the loop to use devN instead of repeated calls to dev.
+ *
  */
 
 static char *version = "$Id: dgrs.c,v 1.13 2000/06/06 04:07:00 rick Exp $";
@@ -190,7 +197,7 @@
 /*
  *	Chain of device structures
  */
-static struct net_device *dgrs_root_dev = NULL;
+static struct net_device *dgrs_root_dev;
 
 /*
  *	Private per-board data structure (dev->priv)
@@ -1247,13 +1254,17 @@
 )
 {
 	DGRS_PRIV	*priv;
-	struct net_device *dev;
+	struct net_device *dev, *aux;
 
 	/* Allocate and fill new device structure. */
 	int dev_size = sizeof(struct net_device) + sizeof(DGRS_PRIV);
-	int i;
+	int i, ret;
 
 	dev = (struct net_device *) kmalloc(dev_size, GFP_KERNEL);
+
+	if (!dev)
+		return -ENOMEM;
+
 	memset(dev, 0, dev_size);
 	dev->priv = ((void *)dev) + sizeof(struct net_device);
 	priv = (DGRS_PRIV *)dev->priv;
@@ -1272,11 +1283,12 @@
 	dev->init = dgrs_probe1;
 	SET_MODULE_OWNER(dev);
 	ether_setup(dev);
-	priv->next_dev = dgrs_root_dev;
-	dgrs_root_dev = dev;
 	if (register_netdev(dev) != 0)
 		return -EIO;
 
+	priv->next_dev = dgrs_root_dev;
+	dgrs_root_dev = dev;
+
 	if ( !dgrs_nicmode )
 		return (0);	/* Switch mode, we are done */
 
@@ -1293,6 +1305,9 @@
 			/* Allocate new dev and priv structures */
 		devN = (struct net_device *) kmalloc(dev_size, GFP_KERNEL);
 			/* Make it an exact copy of dev[0]... */
+		ret = -ENOMEM;
+		if (!devN) 
+			goto fail;
 		memcpy(devN, dev, dev_size);
 		devN->priv = ((void *)devN) + sizeof(struct net_device);
 		privN = (DGRS_PRIV *)devN->priv;
@@ -1303,17 +1318,29 @@
 		devN->irq = 0;
 			/* ... and base MAC address off address of 1st port */
 		devN->dev_addr[5] += i;
-		privN->chan = i+1;
-		priv->devtbl[i] = devN;
 		devN->init = dgrs_initclone;
-		SET_MODULE_OWNER(dev);
+		SET_MODULE_OWNER(devN);
 		ether_setup(devN);
+		ret = -EIO;
+		if (register_netdev(devN)) {
+			kfree(devN);
+			goto fail;
+		}
+		privN->chan = i+1;
+		priv->devtbl[i] = devN;
 		privN->next_dev = dgrs_root_dev;
 		dgrs_root_dev = devN;
-		if (register_netdev(devN) != 0)
-			return -EIO;
 	}
-	return (0);
+	return 0;
+fail:	aux = priv->next_dev;
+	while (dgrs_root_dev != aux) {
+		struct net_device *d = dgrs_root_dev;
+		
+		dgrs_root_dev = ((DGRS_PRIV *)d->priv)->next_dev;
+		unregister_netdev(d);
+		kfree(d);
+	}
+	return ret;
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
