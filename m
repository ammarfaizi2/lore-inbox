Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCPNFl>; Fri, 16 Mar 2001 08:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRCPNFb>; Fri, 16 Mar 2001 08:05:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15047 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129259AbRCPNFR>;
	Fri, 16 Mar 2001 08:05:17 -0500
Message-ID: <3AB20F42.1D37984C@mandrakesoft.com>
Date: Fri, 16 Mar 2001 08:04:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pmhahn@titan.lahn.de
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: [OOPS] 8139too
In-Reply-To: <Pine.LNX.4.33.0103151022220.1497-100000@titan.lahn.de>
Content-Type: multipart/mixed;
 boundary="------------DF8484491B89A50436827FA2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF8484491B89A50436827FA2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> i686 2.4.2 UP+kdb+lm_sensors+pcmcia
> after APM laptop suspend to disk
> 8139too is build-in, not pcmcia
> I often get hangups after suspend-to-disk if I'm connected to a hub/switch.
> This is the first oops I've actually seen and copied it by hand:

Philipp,

Does the attached patch solve the problem?

Modifying the interrupt handler may not be necessary, but it's there
just in case.  (that's the first chunk of the patch)

Regards,

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------DF8484491B89A50436827FA2
Content-Type: text/plain; charset=us-ascii;
 name="8139too.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8139too.patch"

Index: drivers/net/8139too.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/8139too.c,v
retrieving revision 1.1.1.29.10.1
diff -u -r1.1.1.29.10.1 8139too.c
--- drivers/net/8139too.c	2001/03/13 05:12:53	1.1.1.29.10.1
+++ drivers/net/8139too.c	2001/03/16 13:01:08
@@ -2028,10 +2028,12 @@
 			rtl8139_weird_interrupt (dev, tp, ioaddr,
 						 status, link_changed);
 
-		if (status & (RxOK | RxUnderrun | RxOverflow | RxFIFOOver))	/* Rx interrupt */
+		if (netif_running (dev) &&
+		    status & (RxOK | RxUnderrun | RxOverflow | RxFIFOOver))	/* Rx interrupt */
 			rtl8139_rx_interrupt (dev, tp, ioaddr);
 
-		if (status & (TxOK | TxErr)) {
+		if (netif_running (dev) &&
+		    status & (TxOK | TxErr)) {
 			spin_lock (&tp->lock);
 			rtl8139_tx_interrupt (dev, tp, ioaddr);
 			spin_unlock (&tp->lock);
@@ -2262,6 +2264,9 @@
 	void *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
+	if (!netif_running (dev))
+		return;
+
 	netif_device_detach (dev);
 
 	spin_lock_irqsave (&tp->lock, flags);
@@ -2282,6 +2287,8 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 
+	if (!netif_running (dev))
+		return;
 	netif_device_attach (dev);
 	rtl8139_hw_start (dev);
 }

--------------DF8484491B89A50436827FA2--

