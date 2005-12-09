Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVLIR5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVLIR5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVLIR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:57:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964849AbVLIR5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:57:38 -0500
Date: Fri, 9 Dec 2005 09:57:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.15-rc5 spits oodles of hw csum failures
Message-ID: <20051209095733.7faf8e13@unknown-222.office.pdx.osdl.net>
In-Reply-To: <20051209121220.GJ26185@suse.de>
References: <20051209121220.GJ26185@suse.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You missed this patch that I posted just after Linus left for parts unknown.

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
