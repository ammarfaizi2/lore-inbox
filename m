Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUHBWiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUHBWiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHBWiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:38:03 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21693 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264382AbUHBWgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:36:18 -0400
Date: Tue, 3 Aug 2004 00:35:15 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040803003515.A29885@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0408021234290.15888-100000@silmu.st.jyu.fi> <Pine.LNX.4.44.0408021301030.17420-100000@silmu.st.jyu.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0408021301030.17420-100000@silmu.st.jyu.fi>; from ptsjohol@cc.jyu.fi on Mon, Aug 02, 2004 at 01:03:15PM +0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
> I forgot to mention that it was quite hard to crash the driver with that 
> /* Clear out errors and receive interrupts */-patch. Took about 15minutes 
> everytime, when normally it takes about 2mins.

I have made a few changes. Please enable the DEBUG option and set msglvl
to its maximal value via ethtool. You may test the patches separately if
you find some time but the log once both r8139-10.patch and r8139-20.patch
are applied would be enough.

If the log fills too fast, you may comment out any message which does
not belong to rtl8139_rx().

--
Ueimor

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8139-10.patch"


- read the interruption status word that the driver will ack before the
  actual processing is done;
- avoid a few heavy pci transactions when several packets are received at
  the same time.


 drivers/net/8139too.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff -puN drivers/net/8139too.c~r8139-10 drivers/net/8139too.c
--- linux-2.6.8-rc2/drivers/net/8139too.c~r8139-10	2004-08-02 22:39:24.000000000 +0200
+++ linux-2.6.8-rc2-romieu/drivers/net/8139too.c	2004-08-02 23:08:00.000000000 +0200
@@ -1934,12 +1934,15 @@ static int rtl8139_rx(struct net_device 
 	int received = 0;
 	unsigned char *rx_ring = tp->rx_ring;
 	unsigned int cur_rx = tp->cur_rx;
+	u16 status;
 
 	DPRINTK ("%s: In rtl8139_rx(), current %4.4x BufAddr %4.4x,"
 		 " free to %4.4x, Cmd %2.2x.\n", dev->name, cur_rx,
 		 RTL_R16 (RxBufAddr),
 		 RTL_R16 (RxBufPtr), RTL_R8 (ChipCmd));
 
+	status = RTL_R16 (IntrStatus) & RxAckBits;
+
 	while (netif_running(dev) && received < budget 
 	       && (RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {
 		u32 ring_offset = cur_rx % RX_BUF_LEN;
@@ -1947,7 +1950,6 @@ static int rtl8139_rx(struct net_device 
 		unsigned int rx_size;
 		unsigned int pkt_size;
 		struct sk_buff *skb;
-		u16 status;
 
 		rmb();
 
@@ -1977,7 +1979,7 @@ static int rtl8139_rx(struct net_device 
 		 */
 		if (unlikely(rx_size == 0xfff0)) {
 			tp->xstats.early_rx++;
-			goto done;
+			break;
 		}
 
 		/* If Rx err or invalid rx_size/rx_status received
@@ -1989,7 +1991,8 @@ static int rtl8139_rx(struct net_device 
 			     (rx_size < 8) ||
 			     (!(rx_status & RxStatusOK)))) {
 			rtl8139_rx_err (rx_status, dev, tp, ioaddr);
-			return -1;
+			received = -1;
+			goto out;
 		}
 
 		/* Malloc up new buffer, compatible with net-2e. */
@@ -2024,21 +2027,20 @@ static int rtl8139_rx(struct net_device 
 
 		cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
 		RTL_W16 (RxBufPtr, (u16) (cur_rx - 16));
+	}
 
+	if (received > 0) {
 		/* Clear out errors and receive interrupts */
-		status = RTL_R16 (IntrStatus) & RxAckBits;
 		if (likely(status != 0)) {
 			if (unlikely(status & (RxFIFOOver | RxOverflow))) {
 				tp->stats.rx_errors++;
-				if (status & RxFIFOOver)
+			if (status & RxFIFOOver)
 					tp->stats.rx_fifo_errors++;
 			}
 			RTL_W16_F (IntrStatus, RxAckBits);
 		}
 	}
 
- done:
-
 #if RTL8139_DEBUG > 1
 	DPRINTK ("%s: Done rtl8139_rx(), current %4.4x BufAddr %4.4x,"
 		 " free to %4.4x, Cmd %2.2x.\n", dev->name, cur_rx,
@@ -2047,6 +2049,7 @@ static int rtl8139_rx(struct net_device 
 #endif
 
 	tp->cur_rx = cur_rx;
+out:
 	return received;
 }
 

_

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8139-20.patch"


Let's be sure that the driver will make some progress/reset when
crap hits the packet size descriptor.


 drivers/net/8139too.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletion(-)

diff -puN drivers/net/8139too.c~r8139-20 drivers/net/8139too.c
--- linux-2.6.8-rc2/drivers/net/8139too.c~r8139-20	2004-08-02 23:21:36.000000000 +0200
+++ linux-2.6.8-rc2-romieu/drivers/net/8139too.c	2004-08-03 00:13:56.000000000 +0200
@@ -593,6 +593,7 @@ struct rtl8139_private {
 	int time_to_die;
 	struct mii_if_info mii;
 	unsigned int regs_len;
+	unsigned long fifo_copy_timeout;
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
@@ -1937,7 +1938,7 @@ static int rtl8139_rx(struct net_device 
 	u16 status;
 
 	DPRINTK ("%s: In rtl8139_rx(), current %4.4x BufAddr %4.4x,"
-		 " free to %4.4x, Cmd %2.2x.\n", dev->name, cur_rx,
+		 " free to %4.4x, Cmd %2.2x.\n", dev->name, (u16)cur_rx,
 		 RTL_R16 (RxBufAddr),
 		 RTL_R16 (RxBufPtr), RTL_R8 (ChipCmd));
 
@@ -1978,10 +1979,24 @@ static int rtl8139_rx(struct net_device 
 		 * since EarlyRx is disabled.
 		 */
 		if (unlikely(rx_size == 0xfff0)) {
+			if (!tp->fifo_copy_timeout)
+				tp->fifo_copy_timeout = jiffies + 2;
+			else if (time_after(jiffies, tp->fifo_copy_timeout)) {
+				DPRINTK ("%s: hung FIFO. Reset.", dev->name);
+				rx_size = 0;
+				goto no_early_rx;
+			}
+			if (netif_msg_intr(tp)) {
+				printk(KERN_DEBUG "%s: fifo copy in progress.",
+				       dev->name);
+			}
 			tp->xstats.early_rx++;
 			break;
 		}
 
+no_early_rx:
+		tp->fifo_copy_timeout = 0;
+
 		/* If Rx err or invalid rx_size/rx_status received
 		 * (which happens if we get lost in the ring),
 		 * Rx process gets reset, so we abort any further
@@ -2049,6 +2064,14 @@ static int rtl8139_rx(struct net_device 
 #endif
 
 	tp->cur_rx = cur_rx;
+
+	/*
+	 * The receive buffer should be mostly empty.
+	 * Tell NAPI to reenable the Rx irq.
+	 */
+	if (tp->fifo_copy_timeout)
+		received = budget;
+
 out:
 	return received;
 }

_

--bp/iNruPH9dso1Pn--
