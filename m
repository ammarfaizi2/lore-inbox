Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129592AbRBUIgW>; Wed, 21 Feb 2001 03:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbRBUIgN>; Wed, 21 Feb 2001 03:36:13 -0500
Received: from fw.pvt.cz ([194.149.101.194]:40708 "EHLO fw.pvt.cz")
	by vger.kernel.org with ESMTP id <S129592AbRBUIf7>;
	Wed, 21 Feb 2001 03:35:59 -0500
Date: Wed, 21 Feb 2001 09:35:51 +0100 (CET)
From: Tom Mraz <t8m@centrum.cz>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Moxa Smartio driver
Message-ID: <Pine.LNX.4.30.0102210935200.18348-100000@p38mraz.cbu.pvt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I send you a patch to the Moxa Smartio driver in the 2.4.1 kernel.
There are included the fixes which I've made to make my Moxa Smartio Card
work.

First there is backed out the wrong fix which was included in some of the
2.4.0-testxx version. Then there is a fix to the PCI lookup of the card.
And finally there is a fix to module usage count which wasn't properly
increased.

--- ../linux/drivers/char/mxser.c	Wed Dec  6 21:06:18 2000
+++ linux/drivers/char/mxser.c	Tue Feb 20 18:19:08 2001
@@ -120,7 +120,7 @@
 #define CI104J_ASIC_ID  5

 enum {
-	MXSER_BOARD_C168_ISA = 0,
+	MXSER_BOARD_C168_ISA = 1,
 	MXSER_BOARD_C104_ISA,
 	MXSER_BOARD_CI104J,
 	MXSER_BOARD_C168_PCI,
@@ -617,16 +617,18 @@
 			pdev = pci_find_device(mxser_pcibrds[b].vendor_id,
 					       mxser_pcibrds[b].device_id, pdev);
 			if (!pdev)
-				break;
+			{
+				b++;
+				continue;
+			}
 			if (pci_enable_device(pdev))
 				continue;
-			b++;
 			hwconf.pdev = pdev;
 			printk("Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
 				mxser_brdname[mxser_pcibrds[b].board_type - 1],
 				pdev->bus->number, PCI_SLOT(pdev->devfn >> 3));
 			if (m >= MXSER_BOARDS) {
-				printk("Too many Smartio family boards find (maximum %d),board not configured\n", MXSER_BOARDS);
+				printk("Too many Smartio family boards found (maximum %d),board not configured\n", MXSER_BOARDS);
 			} else {
 				retval = mxser_get_PCI_conf(pdev,
 				   mxser_pcibrds[b].board_type, &hwconf);
@@ -1457,7 +1459,9 @@

 	if (info->xmit_cnt < WAKEUP_CHARS) {
 		set_bit(MXSER_EVENT_TXLOW, &info->event);
-		schedule_task(&info->tqueue);
+		MOD_INC_USE_COUNT;
+		if (schedule_task(&info->tqueue) == 0)
+		    MOD_DEC_USE_COUNT;
 	}
 	if (info->xmit_cnt <= 0) {
 		info->IER &= ~UART_IER_THRI;
@@ -1486,8 +1490,9 @@
 		else if (!((info->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (info->flags & ASYNC_CALLOUT_NOHUP)))
 			set_bit(MXSER_EVENT_HANGUP, &info->event);
-		schedule_task(&info->tqueue);
-
+		MOD_INC_USE_COUNT;
+		if (schedule_task(&info->tqueue) == 0)
+		    MOD_DEC_USE_COUNT;
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
 		if (info->tty->hw_stopped) {



I would like to send the patch to Linus, but because it's my first patch to
kernel, I would like someone to comment it. Please cc me on your reply,
because I read the kernel mailing list only on some web archive.

Thanks,
Tomas Mraz

-----------------------------------------------------------------
No matter how far down the wrong road you've gone, turn back.
						Turkish proverb


