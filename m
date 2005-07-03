Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVGCWRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVGCWRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVGCWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:17:23 -0400
Received: from [85.8.12.41] ([85.8.12.41]:16828 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261551AbVGCWRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:17:17 -0400
Message-ID: <42C8653D.9040103@drzeus.cx>
Date: Mon, 04 Jul 2005 00:22:53 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-31469-1120429036-0001-2"
To: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: [PATCH] 8139cp - redetect link after suspend
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-31469-1120429036-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

After suspend the driver needs to retest link status in case the cable
has been inserted or removed during the suspend.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-31469-1120429036-0001-2
Content-Type: text/x-patch; name="8139cp-mii-suspend.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8139cp-mii-suspend.patch"

Index: linux-wbsd/drivers/net/8139cp.c
===================================================================
--- linux-wbsd/drivers/net/8139cp.c	(revision 153)
+++ linux-wbsd/drivers/net/8139cp.c	(working copy)
@@ -1858,6 +1858,7 @@
 {
 	struct net_device *dev;
 	struct cp_private *cp;
+	unsigned long flags;
 
 	dev = pci_get_drvdata (pdev);
 	cp  = netdev_priv(dev);
@@ -1871,6 +1872,12 @@
 	
 	cp_init_hw (cp);
 	netif_start_queue (dev);
+
+	spin_lock_irqsave (&cp->lock, flags);
+
+	mii_check_media(&cp->mii_if, netif_msg_link(cp), FALSE);
+
+	spin_unlock_irqrestore (&cp->lock, flags);
 	
 	return 0;
 }

--=_hermes.drzeus.cx-31469-1120429036-0001-2--
