Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTG1Svb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTG1SvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:51:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31498 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270480AbTG1SvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:51:10 -0400
Date: Mon, 28 Jul 2003 21:04:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, khc@pm.waw.pl
Subject: [PATCH] 2.6.0-test2 - HDLC hook update for drivers/net/wan/dscc4
Message-ID: <20030728210427.B8054@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- ChangeSet 1.1525, 2003/07/25 15:24:04-07:00, khc@pm.waw.pl
  [...]
           - protocol hooks are slighty changed to allow zeroing (memset).

  make: *** [drivers] Error 2
  drivers/net/wan/dscc4.c: In function `dscc4_found1':
  drivers/net/wan/dscc4.c:891: incompatible types in assignment
  [...]
  -> dscc4 module doesn't set hdlc->proto(.id) itself anymore.
- MOD_{INC/DEC}_USE_COUNT removal;
- SET_NETDEV_DEV() use;



 drivers/net/wan/dscc4.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -puN drivers/net/wan/dscc4.c~drivers-hooks-changed-dscc4 drivers/net/wan/dscc4.c
--- linux-2.6.0-test2/drivers/net/wan/dscc4.c~drivers-hooks-changed-dscc4	Mon Jul 28 20:35:32 2003
+++ linux-2.6.0-test2-fr/drivers/net/wan/dscc4.c	Mon Jul 28 20:46:52 2003
@@ -876,6 +876,8 @@ static int dscc4_found1(struct pci_dev *
 	        d->do_ioctl = dscc4_ioctl;
 		d->tx_timeout = dscc4_tx_timeout;
 		d->watchdog_timeo = TX_TIMEOUT;
+		SET_MODULE_OWNER(d);
+		SET_NETDEV_DEV(d, &pdev->dev);
 
 		dpriv->dev_id = i;
 		dpriv->pci_priv = ppriv;
@@ -888,8 +890,7 @@ static int dscc4_found1(struct pci_dev *
 			printk(KERN_ERR "%s: unable to register\n", DRV_NAME);
 			goto err_unregister;
 	        }
-		hdlc->proto = IF_PROTO_HDLC;
-		SET_MODULE_OWNER(d);
+
 		dscc4_init_registers(dpriv, d);
 		dpriv->parity = PARITY_CRC16_PR0_CCITT;
 		dpriv->encoding = ENCODING_NRZ;
@@ -955,8 +956,6 @@ static int dscc4_open(struct net_device 
 	if ((ret = hdlc_open(hdlc)))
 		goto err;
 
-	MOD_INC_USE_COUNT;
-
 	ppriv = dpriv->pci_priv;
 
 	if ((ret = dscc4_init_ring(dev)))
@@ -1015,7 +1014,6 @@ err_free_ring:
 	dscc4_release_ring(dpriv);
 err_out:
 	hdlc_close(hdlc);
-	MOD_DEC_USE_COUNT;
 err:
 	return ret;
 }

_
