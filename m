Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbTCQR3p>; Mon, 17 Mar 2003 12:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbTCQR3p>; Mon, 17 Mar 2003 12:29:45 -0500
Received: from 39.208-78-194.adsl-fix.skynet.be ([194.78.208.39]:24997 "EHLO
	mail.macqel.be") by vger.kernel.org with ESMTP id <S261809AbTCQR3o>;
	Mon, 17 Mar 2003 12:29:44 -0500
Message-Id: <200303171740.h2HHebY01003@mail.macqel.be>
Subject: Re: sundance DFE-580TX DL10050B patch
In-Reply-To: <20030317172416.GA3366@suse.de> from Dave Jones at "Mar 17, 2003
 04:24:21 pm"
To: Dave Jones <davej@codemonkey.org.uk>
Date: Mon, 17 Mar 2003 18:40:36 +0100 (CET)
CC: linux-kernel@vger.kernel.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote :
> On Mon, Mar 17, 2003 at 02:56:09PM +0100, Philippe De Muyter wrote:
> 
>  > +		writew((dev->dev_addr[i + 1] << 8) + dev->dev_addr[i],
> 
> Don't you want to OR those together instead of add them ?
> 
> 		Dave
> 
You're right.

Here it is :

--- drivers/net/sundance.c	Mon Mar 17 13:15:48 2003
+++ drivers/net/sundance.c	Thu Feb 13 11:56:43 2003
@@ -853,8 +853,10 @@
 	writel(np->rx_ring_dma, ioaddr + RxListPtr);
 	/* The Tx list pointer is written as packets are queued. */
 
-	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
+	/* Station address must be written as 16 bit words with the DL10050B chip. */
+	for (i = 0; i < 6; i += 2)
+		writew((dev->dev_addr[i + 1] << 8) | dev->dev_addr[i],
+			   ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
 	writew(dev->mtu + 14, ioaddr + MaxFrameSize);
