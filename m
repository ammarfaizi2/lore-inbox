Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRJMK4R>; Sat, 13 Oct 2001 06:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJMK4I>; Sat, 13 Oct 2001 06:56:08 -0400
Received: from fungus.teststation.com ([212.32.186.211]:8971 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276857AbRJMKzz>; Sat, 13 Oct 2001 06:55:55 -0400
Date: Sat, 13 Oct 2001 12:55:54 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Andrew Over <ajo@acm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops on removing via-rhine [2.4.10-ac11]
In-Reply-To: <20011011182445.A12015@yeah.cx>
Message-ID: <Pine.LNX.4.30.0110131248010.4721-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Andrew Over wrote:

> Trace; c010b6bc <pci_free_consistent+1c/20>
> Trace; e08fdbaa <[via-rhine]via_rhine_remove_one+2a/40>

remove_one shouldn't call pci_free_consistent as that is already done in
via_rhine_close (and I am assuming that if you open you must always close
before remove ...).

I could repeat some kind of crash, but could you please test if the patch
below fixes the crash you see. patch vs 2.4.13-pre2, but should apply vs
others as well.

/Urban


diff -urN -X exclude linux-2.4.13-pre2-orig/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.4.13-pre2-orig/drivers/net/via-rhine.c	Sat Oct 13 12:05:38 2001
+++ linux/drivers/net/via-rhine.c	Sat Oct 13 12:34:00 2001
@@ -764,6 +764,7 @@
 			    RX_RING_SIZE * sizeof(struct rx_desc) +
 			    TX_RING_SIZE * sizeof(struct tx_desc),
 			    np->rx_ring, np->rx_ring_dma);
+	np->tx_ring = NULL;
 
 	if (np->tx_bufs)
 		pci_free_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
@@ -1595,11 +1596,6 @@
 #ifndef USE_IO
 	iounmap((char *)(dev->base_addr));
 #endif
-
-	pci_free_consistent(pdev, 
-			    RX_RING_SIZE * sizeof(struct rx_desc) +
-			    TX_RING_SIZE * sizeof(struct tx_desc),
-			    np->rx_ring, np->rx_ring_dma);
 
 	kfree(dev);
 

