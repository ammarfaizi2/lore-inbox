Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUDZPyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDZPyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUDZPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:54:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54791 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262648AbUDZPyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:54:20 -0400
To: David Johnson <dj@david-web.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too not working in 2.6
References: <opr62ahdvlpsnffn@mail.mcaserta.com>
	<200404261241.41818.dj@david-web.co.uk>
	<200404261526.00971.dj@david-web.co.uk>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Apr 2004 00:53:39 +0900
In-Reply-To: <200404261526.00971.dj@david-web.co.uk>
Message-ID: <873c6qrb0c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

David Johnson <dj@david-web.co.uk> writes:

> Attached is my dmesg, lspci and the output of dump_pirq.pl.
> This was when running 2.6.6-rc1.

Looks like 8139too still isn't loaded. Could you apply the attached
patch, and send the output of dmesg after the problem was happened?

I'd like to see the debugging message of rtl8139_tx_timeout().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=8139too-useful-txtimeout.patch


[PATCH] 8139too: more useful debug info for tx_timeout

	/* disable Tx ASAP, if not already */
	tmp8 = RTL_R8 (ChipCmd);
	if (tmp8 & CmdTxEnb)
		RTL_W8 (ChipCmd, CmdRxEnb);

The above will clear the Tx Descs. So, this prints the debugging info
before rtl8139_tx_timeout() does it. And IntrStatus etc. also prints
anytime for the debug.


---

 drivers/net/8139too.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff -puN drivers/net/8139too.c~8139too-useful-txtimeout drivers/net/8139too.c
--- linux-2.6.6-rc2/drivers/net/8139too.c~8139too-useful-txtimeout	2004-04-22 02:14:42.000000000 +0900
+++ linux-2.6.6-rc2-hirofumi/drivers/net/8139too.c	2004-04-22 02:14:42.000000000 +0900
@@ -1677,11 +1677,17 @@ static void rtl8139_tx_timeout (struct n
 	u8 tmp8;
 	unsigned long flags;
 
-	DPRINTK ("%s: Transmit timeout, status %2.2x %4.4x "
-		 "media %2.2x.\n", dev->name,
-		 RTL_R8 (ChipCmd),
-		 RTL_R16 (IntrStatus),
-		 RTL_R8 (MediaStatus));
+	printk (KERN_DEBUG "%s: Transmit timeout, status %2.2x %4.4x %4.4x "
+		"media %2.2x.\n", dev->name, RTL_R8 (ChipCmd),
+		RTL_R16(IntrStatus), RTL_R16(IntrMask), RTL_R8(MediaStatus));
+	/* Emit info to figure out what went wrong. */
+	printk (KERN_DEBUG "%s: Tx queue start entry %ld  dirty entry %ld.\n",
+		dev->name, tp->cur_tx, tp->dirty_tx);
+	for (i = 0; i < NUM_TX_DESC; i++)
+		printk (KERN_DEBUG "%s:  Tx descriptor %d is %8.8lx.%s\n",
+			dev->name, i, RTL_R32 (TxStatus0 + (i * 4)),
+			i == tp->dirty_tx % NUM_TX_DESC ?
+				" (queue head)" : "");
 
 	tp->xstats.tx_timeouts++;
 
@@ -1694,15 +1700,6 @@ static void rtl8139_tx_timeout (struct n
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
 
-	/* Emit info to figure out what went wrong. */
-	printk (KERN_DEBUG "%s: Tx queue start entry %ld  dirty entry %ld.\n",
-		dev->name, tp->cur_tx, tp->dirty_tx);
-	for (i = 0; i < NUM_TX_DESC; i++)
-		printk (KERN_DEBUG "%s:  Tx descriptor %d is %8.8lx.%s\n",
-			dev->name, i, RTL_R32 (TxStatus0 + (i * 4)),
-			i == tp->dirty_tx % NUM_TX_DESC ?
-				" (queue head)" : "");
-
 	/* Stop a shared interrupt from scavenging while we are. */
 	spin_lock_irqsave (&tp->lock, flags);
 	rtl8139_tx_clear (tp);
@@ -1714,7 +1711,6 @@ static void rtl8139_tx_timeout (struct n
 		netif_wake_queue (dev);
 	}
 	spin_unlock(&tp->rx_lock);
-	
 }
 
 

_

--=-=-=--
