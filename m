Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbTCQNpS>; Mon, 17 Mar 2003 08:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbTCQNpS>; Mon, 17 Mar 2003 08:45:18 -0500
Received: from 39.208-78-194.adsl-fix.skynet.be ([194.78.208.39]:19313 "EHLO
	mail.macqel.be") by vger.kernel.org with ESMTP id <S261659AbTCQNpQ>;
	Mon, 17 Mar 2003 08:45:16 -0500
Message-Id: <200303171356.h2HDu9U30575@mail.macqel.be>
Subject: sundance DFE-580TX DL10050B patch
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2003 14:56:09 +0100 (CET)
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

trying to use the bonding functionality with a DFE-580TX quad port board,
I discovered I had to change the sundance.c driver to write the station
address with word access; that's actually what the sundance technology st201
and the ic+ IP100 data sheets say, so that should be ok in the general
case.

Philippe

Philippe De Muyter  phdm@macqel.be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077

--- drivers/net/sundance.c	Mon Mar 17 13:15:48 2003
+++ drivers/net/sundance.c	Thu Feb 13 11:56:43 2003
@@ -853,8 +853,10 @@
 	writel(np->rx_ring_dma, ioaddr + RxListPtr);
 	/* The Tx list pointer is written as packets are queued. */
 
-	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
+	/* Station address must be written as 16 bit words with the DL10050B chip. */
+	for (i = 0; i < 6; i += 2)
+		writew((dev->dev_addr[i + 1] << 8) + dev->dev_addr[i],
+			   ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
 	writew(dev->mtu + 14, ioaddr + MaxFrameSize);
