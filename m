Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUC1Whe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUC1Whe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:37:34 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9928 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262453AbUC1Wh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:37:26 -0500
Date: Mon, 29 Mar 2004 00:36:00 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bernd Fuhrmann <silverbanana@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: usage of RealTek 8169 crashes my Linux system
Message-ID: <20040329003600.A24995@electric-eye.fr.zoreil.com>
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <4067489E.2090400@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4067489E.2090400@gmx.de>; from silverbanana@gmx.de on Sun, Mar 28, 2004 at 11:50:22PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bernd Fuhrmann <silverbanana@gmx.de> :
[...]
> I haven't tried them yet, because I haven't seen any changes in the 
> recent mm-patches to that r8169 driver (just checked all the 
> announce.txt files of 2.6.5-rc1&2). Maybe I missed something.

The changes comes from the bk-netdev part of M. Morton's patchset.
The changelog is a bit terse for those (hint, hint).

> If you think one of these patches might fix it (please tell me the exact 
> patch number) I will apply and test it as soon as possible.

Please try any recent -mm.

nmi_watchdog and magic sysrq are your friends. Don't expect much from
syslog though.

Once you have applied -mm patch, you may apply the attached patch as well
to help debugging.

--
Ueimor

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169-break-irq-loop.patch"

 drivers/net/r8169.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/net/r8169.c~r8169-break-irq-loop drivers/net/r8169.c
--- linux-2.6.5-rc2/drivers/net/r8169.c~r8169-break-irq-loop	2004-03-24 23:52:23.000000000 +0100
+++ linux-2.6.5-rc2-fr/drivers/net/r8169.c	2004-03-24 23:56:26.000000000 +0100
@@ -1345,6 +1345,7 @@ rtl8169_tx_interrupt(struct net_device *
 		     void *ioaddr)
 {
 	unsigned long dirty_tx, tx_left = 0;
+	int max_try = 8192;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -1353,7 +1354,7 @@ rtl8169_tx_interrupt(struct net_device *
 	dirty_tx = tp->dirty_tx;
 	tx_left = tp->cur_tx - dirty_tx;
 
-	while (tx_left > 0) {
+	while ((tx_left > 0) && --max_try) {
 		int entry = dirty_tx % NUM_TX_DESC;
 
 		if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
@@ -1371,6 +1372,9 @@ rtl8169_tx_interrupt(struct net_device *
 		}
 	}
 
+	if (!max_try)
+		printk(KERN_INFO "%s: strangeness in Tx handler", dev->name);
+
 	if (tp->dirty_tx != dirty_tx) {
 		tp->dirty_tx = dirty_tx;
 		if (netif_queue_stopped(dev))
@@ -1406,6 +1410,7 @@ rtl8169_rx_interrupt(struct net_device *
 {
 	unsigned long cur_rx, rx_left;
 	int delta;
+	int max_try = 8192;
 
 	assert(dev != NULL);
 	assert(tp != NULL);
@@ -1414,7 +1419,7 @@ rtl8169_rx_interrupt(struct net_device *
 	cur_rx = tp->cur_rx;
 	rx_left = NUM_RX_DESC + tp->dirty_rx - cur_rx;
 
-	while (rx_left > 0) {
+	while ((rx_left > 0) && --max_try) {
 		int entry = cur_rx % NUM_RX_DESC;
 		u32 status = le32_to_cpu(tp->RxDescArray[entry].status);
 
@@ -1461,6 +1466,9 @@ rtl8169_rx_interrupt(struct net_device *
 		rx_left--;
 	}
 
+	if (!max_try)
+		printk(KERN_INFO "%s: strangeness in Rx handler", dev->name);
+
 	tp->cur_rx = cur_rx;
 
 	delta = rtl8169_rx_fill(tp, dev, tp->dirty_rx, tp->cur_rx);

_

--WhfpMioaduB5tiZL--
