Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVLLUhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLLUhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLLUhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:37:52 -0500
Received: from havoc.gtf.org ([69.61.125.42]:50911 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750973AbVLLUhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:37:51 -0500
Date: Mon, 12 Dec 2005 15:37:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver fixes
Message-ID: <20051212203743.GA4333@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/pcnet32.c      |    5 -----
 drivers/net/sk98lin/skge.c |    4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

Olaf Hering:
      pcnet32: use MAC address from prom also on powerpc

Stephen Hemminger:
      sk98lin: rx checksum offset not set

diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index be31922..8f6cf8c 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -1251,12 +1251,7 @@ pcnet32_probe1(unsigned long ioaddr, int
 
     if (memcmp(promaddr, dev->dev_addr, 6)
 	|| !is_valid_ether_addr(dev->dev_addr)) {
-#ifndef __powerpc__
 	if (is_valid_ether_addr(promaddr)) {
-#else
-	if (!is_valid_ether_addr(dev->dev_addr)
-	    && is_valid_ether_addr(promaddr)) {
-#endif
 	    if (pcnet32_debug & NETIF_MSG_PROBE) {
 		printk(" warning: CSR address invalid,\n");
 		printk(KERN_INFO "    using instead PROM address of");
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index 00c5d7f..ae73439 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -818,7 +818,7 @@ uintptr_t VNextDescr;	/* the virtual bus
 		/* set the pointers right */
 		pDescr->VNextRxd = VNextDescr & 0xffffffffULL;
 		pDescr->pNextRxd = pNextDescr;
-		pDescr->TcpSumStarts = 0;
+		if (!IsTx) pDescr->TcpSumStarts = ETH_HLEN << 16 | ETH_HLEN;
 
 		/* advance one step */
 		pPrevDescr = pDescr;
@@ -2169,7 +2169,7 @@ rx_start:	
 		} /* frame > SK_COPY_TRESHOLD */
 
 #ifdef USE_SK_RX_CHECKSUM
-		pMsg->csum = pRxd->TcpSums;
+		pMsg->csum = pRxd->TcpSums & 0xffff;
 		pMsg->ip_summed = CHECKSUM_HW;
 #else
 		pMsg->ip_summed = CHECKSUM_NONE;
