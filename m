Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTLCBVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLCBVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:21:47 -0500
Received: from ip008.siteplanet.com.br ([200.245.54.8]:15624 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id S264378AbTLCBVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:21:42 -0500
Subject: [PATCH 2.6] Realtek RTL-8169 RX/TX Statistics
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       RealTek Mailing List <realtek@scyld.com>
In-Reply-To: <20031202010649.A27879@electric-eye.fr.zoreil.com>
References: <1070212415.1607.17.camel@oxygenium>
	 <20031201020453.A16405@electric-eye.fr.zoreil.com>
	 <20031202010649.A27879@electric-eye.fr.zoreil.com>
Content-Type: multipart/mixed; boundary="=-uykaqYwglMIohnNI5TO5"
Organization: University Methodist of Piracicaba
Message-Id: <1070413198.1091.10.camel@oxygenium>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 22:59:58 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uykaqYwglMIohnNI5TO5
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Francois

It's a simple and small patch.
This patch add stats improvements and fixes.


Cheers!

-- 
Fernando Alencar Maróstica
Graduate Student, Computer Science
Linux Register User Id #281457
                                                                     
University Methodist of Piracicaba
Departament of Computer Science
email: famarost@unimep.br
homepage: http://www.unimep.br/~famarost




--=-uykaqYwglMIohnNI5TO5
Content-Disposition: attachment; filename=r8169-getstats.patch
Content-Type: text/x-patch; name=r8169-getstats.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- r8169.c.orig	2003-12-02 20:36:07.000000000 -0200
+++ r8169.c	2003-12-02 20:52:19.000000000 -0200
@@ -303,7 +303,7 @@
 static int rtl8169_close(struct net_device *dev);
 static void rtl8169_set_rx_mode(struct net_device *dev);
 static void rtl8169_tx_timeout(struct net_device *dev);
-static struct net_device_stats *rtl8169_get_stats(struct net_device *netdev);
+static struct net_device_stats *rtl8169_get_stats(struct net_device *ethernet_device);
 
 static const u16 rtl8169_intr_mask =
     SYSErr | PCSTimeout | RxUnderrun | RxOverflow | RxFIFOOver | TxErr | TxOK |
@@ -1113,11 +1113,26 @@
 	spin_unlock_irqrestore(&tp->lock, flags);
 }
 
+/**
+ *  rtl8169_get_stats: - Get rtl8169 read/write statistics
+ *  @ethernet_device: The Ethernet Device to get statistics for
+ *
+ *  Get TX/RX statistics for rtl8169
+ */
 struct net_device_stats *
-rtl8169_get_stats(struct net_device *dev)
+rtl8169_get_stats(struct net_device *ethernet_device)
 {
-	struct rtl8169_private *tp = dev->priv;
+	struct rtl8169_private *tp = ethernet_device->priv;
+	void *ioaddr = tp->mmio_addr;
+	unsigned long flags;
 
+        if (netif_running(ethernet_device)) {
+	    spin_lock_irqsave (&tp->lock, flags);
+	    tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
+	    RTL_W32 (RxMissed, 0);
+	    spin_unlock_irqrestore (&tp->lock, flags);
+	}
+		
 	return &tp->stats;
 }
 

--=-uykaqYwglMIohnNI5TO5--

