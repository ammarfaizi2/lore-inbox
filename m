Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267949AbUGaMiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267949AbUGaMiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 08:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUGaMiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 08:38:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61866 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267953AbUGaMgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 08:36:14 -0400
Date: Sat, 31 Jul 2004 14:33:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040731143330.A25736@electric-eye.fr.zoreil.com>
References: <16650.21955.869485.332365@robur.slu.se> <Pine.LNX.4.44.0407302116010.23238-101000@silmu.st.jyu.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407302116010.23238-101000@silmu.st.jyu.fi>; from ptsjohol@cc.jyu.fi on Fri, Jul 30, 2004 at 09:40:28PM +0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
[interesting report]
> The hardest part is to tell where the problem is but I think that 
> rtl8139_poll-function would be good place to start looking for the bug?
> 
> readprofile didn't tell much.. Where to go next? I'm not so good 
> programmer that I could find the right place to fix..

In case it could make a difference: did you check if CONFIG_8139_OLD_RX_RESET
changes the behavior or not ?

If it does not, I'd welcome a test report + log with the two attached patch
applied. The first one is just a placebo but the second one could help.

Btw, you are probably right that the issue is not related to ksoftirqd at all.

--
Ueimor

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8139-10.patch"

 drivers/net/8139too.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/net/8139too.c~r8139-10 drivers/net/8139too.c
--- linux-2.6.8-rc2/drivers/net/8139too.c~r8139-10	2004-07-31 12:43:44.000000000 +0200
+++ linux-2.6.8-rc2-romieu/drivers/net/8139too.c	2004-07-31 12:43:44.000000000 +0200
@@ -1934,6 +1934,7 @@ static int rtl8139_rx(struct net_device 
 	int received = 0;
 	unsigned char *rx_ring = tp->rx_ring;
 	unsigned int cur_rx = tp->cur_rx;
+	u16 status;
 
 	DPRINTK ("%s: In rtl8139_rx(), current %4.4x BufAddr %4.4x,"
 		 " free to %4.4x, Cmd %2.2x.\n", dev->name, cur_rx,
@@ -1947,7 +1948,6 @@ static int rtl8139_rx(struct net_device 
 		unsigned int rx_size;
 		unsigned int pkt_size;
 		struct sk_buff *skb;
-		u16 status;
 
 		rmb();
 
@@ -2024,17 +2024,17 @@ static int rtl8139_rx(struct net_device 
 
 		cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
 		RTL_W16 (RxBufPtr, (u16) (cur_rx - 16));
+	}
 
-		/* Clear out errors and receive interrupts */
-		status = RTL_R16 (IntrStatus) & RxAckBits;
-		if (likely(status != 0)) {
-			if (unlikely(status & (RxFIFOOver | RxOverflow))) {
-				tp->stats.rx_errors++;
-				if (status & RxFIFOOver)
-					tp->stats.rx_fifo_errors++;
-			}
-			RTL_W16_F (IntrStatus, RxAckBits);
+	/* Clear out errors and receive interrupts */
+	status = RTL_R16 (IntrStatus) & RxAckBits;
+	if (likely(status != 0)) {
+		if (unlikely(status & (RxFIFOOver | RxOverflow))) {
+			tp->stats.rx_errors++;
+			if (status & RxFIFOOver)
+				tp->stats.rx_fifo_errors++;
 		}
+		RTL_W16_F (IntrStatus, RxAckBits);
 	}
 
  done:

_

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8139-20.patch"

 drivers/net/8139too.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -puN drivers/net/8139too.c~r8139-20 drivers/net/8139too.c
--- linux-2.6.8-rc2/drivers/net/8139too.c~r8139-20	2004-07-31 12:44:12.000000000 +0200
+++ linux-2.6.8-rc2-romieu/drivers/net/8139too.c	2004-07-31 14:20:36.000000000 +0200
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
 
@@ -1977,6 +1978,14 @@ static int rtl8139_rx(struct net_device 
 		 */
 		if (unlikely(rx_size == 0xfff0)) {
 			tp->xstats.early_rx++;
+			if (!tp->fifo_copy_timeout)
+				tp->fifo_copy_timeout = jiffies + 2;
+			else if (time_after(jiffies, tp->fifo_copy_timeout)) {
+				DPRINTK ("%s: hung FIFO. Reset.", dev->name);
+				tp->fifo_copy_timeout = 0;
+				rtl8139_rx_err (rx_status, dev, tp, ioaddr);
+				return -1;
+			}
 			goto done;
 		}
 

_

--Qxx1br4bt0+wmkIi--
