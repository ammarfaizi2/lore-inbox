Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264275AbTCXQvD>; Mon, 24 Mar 2003 11:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264339AbTCXQud>; Mon, 24 Mar 2003 11:50:33 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:40170 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264275AbTCXQax>; Mon, 24 Mar 2003 11:30:53 -0500
Message-Id: <200303241642.h2OGg135008232@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:48 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: finish init_etherdev conversion for gt96100eth
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- No need to alloc dev->priv (due to init_etherdev usage)
- No need to kfree dev->priv (kfree'd with (dev) already)

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/gt96100eth.c linux-2.5/drivers/net/gt96100eth.c
--- bk-linus/drivers/net/gt96100eth.c	2003-03-08 09:57:15.000000000 +0000
+++ linux-2.5/drivers/net/gt96100eth.c	2003-01-06 19:00:54.000000000 +0000
@@ -758,19 +758,6 @@ gt96100_probe1(int port_num)
 		goto free_region;
 	}
 
-	/* Initialize our private structure. */
-	if (dev->priv == NULL) {
-
-		gp = (struct gt96100_private *)kmalloc(sizeof(*gp),
-						       GFP_KERNEL);
-		if (gp == NULL) {
-			retval = -ENOMEM;
-			goto free_region;
-		}
-	
-		dev->priv = gp;
-	}
-
 	gp = dev->priv;
 
 	memset(gp, 0, sizeof(*gp)); // clear it
@@ -854,8 +841,6 @@ gt96100_probe1(int port_num)
  free_region:
 	release_region(gtif->iobase, GT96100_ETH_IO_SIZE);
 	unregister_netdev(dev);
-	if (dev->priv != NULL)
-		kfree (dev->priv);
 	kfree (dev);
 	err("%s failed.  Returns %d\n", __FUNCTION__, retval);
 	return retval;
@@ -1601,8 +1586,6 @@ static void gt96100_cleanup_module(void)
 				(struct gt96100_private *)gtif->dev->priv;
 			release_region(gtif->iobase, gp->io_size);
 			unregister_netdev(gtif->dev);
-			if (gtif->dev->priv != NULL)
-				kfree (gtif->dev->priv);
 			kfree (gtif->dev);
 		}
 	}
