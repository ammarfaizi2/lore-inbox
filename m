Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVLETAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVLETAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVLETAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:00:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751407AbVLETAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:00:54 -0500
Date: Mon, 5 Dec 2005 11:00:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Johannes Stezenbach <js@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: [PATCH linux-2.6.15-rc5] sk98lin: rx checksum offset not set
Message-ID: <20051205110040.47adf428@localhost.localdomain>
In-Reply-To: <20051204234320.GA7478@linuxtv.org>
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
	<20051204234320.GA7478@linuxtv.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The checksum offsets for receive offload were not being set correctly.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


Index: linux-2.6/drivers/net/sk98lin/skge.c
===================================================================
--- linux-2.6.orig/drivers/net/sk98lin/skge.c
+++ linux-2.6/drivers/net/sk98lin/skge.c
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
