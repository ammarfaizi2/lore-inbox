Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCMWNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCMWNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCMWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 17:13:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:29323 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261485AbVCMWNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 17:13:20 -0500
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sean Neakums <sneakums@zork.net>
In-Reply-To: <6uhdjf5hc8.fsf@zork.zork.net>
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6upsy37o0v.fsf@zork.zork.net> <1110717016.5787.143.camel@gaston>
	 <1110717351.5787.146.camel@gaston> <6uzmx75xiv.fsf@zork.zork.net>
	 <6usm2z5pq3.fsf@zork.zork.net> <1110750834.19810.162.camel@gaston>
	 <6uhdjf5hc8.fsf@zork.zork.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 09:12:25 +1100
Message-Id: <1110751945.14684.171.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh, fiddlesticks, that didn't occur to me.  I can redo with overnight
> sleeps on a full charge, if you like.

In the meantime, Andrew, please submit this one to Linus, I'll update
the stuff if it happens the other one gives better power consumptions:

--

This patch fixes a logic error in the ide-pmac driver which could try to
access the chip's fcr register after the cell clock has been shut down,
thus causing a machine check on machines with the "Intrepid" chipset.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-03-13 10:10:58.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-03-13 23:29:40.000000000 +1100
@@ -1208,16 +1208,17 @@
 	if (pmif->mediabay)
 		return 0;
 	
-	/* Disable the bus */
-	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id, 0);
-
-	/* Kauai has it different */
+	/* Kauai has bus control FCRs directly here */
 	if (pmif->kauai_fcr) {
 		u32 fcr = readl(pmif->kauai_fcr);
 		fcr &= ~(KAUAI_FCR_UATA_RESET_N | KAUAI_FCR_UATA_ENABLE);
 		writel(fcr, pmif->kauai_fcr);
 	}
 
+	/* Disable the bus on older machines and the cell on kauai */
+	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id,
+			    0);
+
 	return 0;
 }
 


