Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbTIUHnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 03:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTIUHnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 03:43:52 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:16272 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262343AbTIUHnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 03:43:50 -0400
Message-ID: <3F6D5640.2040904@abcpages.com>
Date: Sun, 21 Sep 2003 09:41:52 +0200
From: Nicolae Mihalache <mache@abcpages.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] suspend/resume for the b44 driver
References: <3F6783D9.4070702@abcpages.com> <20030917100856.GA29368@ee.oulu.fi> <3F684608.2000707@abcpages.com> <20030917115048.GA2598@ee.oulu.fi>
In-Reply-To: <20030917115048.GA2598@ee.oulu.fi>
Content-Type: multipart/mixed;
 boundary="------------060900040008040701010209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900040008040701010209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This patch adds suspend/resume support for the Broadcom 4400 network 
card. It has been tested with 2.6.0-test5-mm1 with suspend to disk 
(suspend to ram does not work even without b44).


mache



--------------060900040008040701010209
Content-Type: text/plain;
 name="b44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b44.patch"

--- b44.c.orig	2003-09-20 21:10:13.168315056 +0200
+++ b44.c	2003-09-20 21:13:54.567657240 +0200
@@ -1859,11 +1859,57 @@
 	}
 }
 
+#ifdef CONFIG_PM
+static int b44_suspend(struct pci_dev *pdev, u32 state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct b44 *bp = dev->priv;
+
+        if (!netif_running(dev))
+                 return 0;
+
+	del_timer_sync(&bp->timer);
+
+	spin_lock_irq(&bp->lock); 
+
+	b44_halt(bp);
+	netif_carrier_off(bp->dev); 
+	netif_device_detach(bp->dev);
+	b44_free_rings(bp);
+
+	spin_unlock_irq(&bp->lock);
+	return 0;
+}
+
+static int b44_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct b44 *bp = dev->priv;
+
+	if (!netif_running(dev))
+		return 0;
+
+	spin_lock_irq(&bp->lock);
+
+	b44_init_rings(bp);
+	b44_init_hw(bp);
+	netif_device_attach(bp->dev);
+	spin_unlock_irq(&bp->lock);
+
+	b44_enable_ints(bp);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver b44_driver = {
 	.name		= DRV_MODULE_NAME,
 	.id_table	= b44_pci_tbl,
 	.probe		= b44_init_one,
 	.remove		= __devexit_p(b44_remove_one),
+#ifdef CONFIG_PM
+        .suspend        = b44_suspend,
+        .resume         = b44_resume,
+#endif /* CONFIG_PM */
 };
 
 static int __init b44_init(void)

--------------060900040008040701010209--

