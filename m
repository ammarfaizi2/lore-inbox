Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWIMW3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWIMW3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWIMW3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:29:05 -0400
Received: from orfeus.profiwh.com ([85.93.165.27]:40713 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751233AbWIMW3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:29:03 -0400
Message-ID: <45083587.50908.reply@carlislefsp.com>
In-Reply-To: <45083587.50908@carlislefsp.com>
References: <4506DAD7.8030307.reply@wsc.cz>, <45082055.7010309@carlislefsp.com> <45082055.7010309.reply@wsc.cz>, <45083587.50908@carlislefsp.com>
From: Jiri Slaby <jirislaby@gmail.com>
To: Steve Roemen <stever@carlislefsp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: isicom module oops 2.6.17.13
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Wed, 13 Sep 2006 18:29:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Roemen wrote:
> here's with the firmware in the (converted to .deb rpm from 
> ftp://ftp.linux.org.uk/pub/linux/alan/Kernel/Drivers/ISI/ )
> 
> isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2052)
> isicom 0000:00:10.0: -Done
> isicom 0000:00:10.0: Firmware requested, size: 6553
> isicom 0000:00:10.0: Firmware loaded, last values:
>         WC: 5, FD: e09cc000, FP: e09cd999
> isicom 0000:00:10.0: Card is not free: 1836
> isicom: probe of 0000:00:10.0 failed with error -5
> 
> here's with the firmware from ftp://ftp.multitech.com/isi-cards/linux/ 
> l309_22x_24x.tar
> 
> isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2052)
> isicom 0000:00:10.0: -Done
> isicom 0000:00:10.0: Firmware requested, size: 7325
> isicom 0000:00:10.0: Firmware loaded, last values:
>         WC: 1, FD: e09cc000, FP: e09cdc9d
> isicom 0000:00:10.0: Card is not free: 1836
> isicom: probe of 0000:00:10.0 failed with error -5

Great, the third (and hope the last) copy&paste-at-2am-bug. Could you test
this patch, I hope this is why the card is not ready when reading?

BTW. which WaitTillCardIsFree fails, the line number (1836) doesn't match for
me here? (post `tail -n+1830 isicom.c | head`)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 6cca4b2..ab78f5a 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1756,11 +1756,18 @@ static int __devinit load_firmware(struc
 	if (retval)
 		goto end;
 
+	dev_info(&pdev->dev, "Firmware requested, size: %u\n", fw->size);
+
+	retval = -EIO;
+
 	for (frame = (struct stframe *)fw->data;
 			frame < (struct stframe *)(fw->data + fw->size);
-			frame++) {
-		if (WaitTillCardIsFree(base))
+			frame = (struct stframe *)((u8 *)frame + 4 +
+				frame->count)) {
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		outw(0xf0, base);	/* start upload sequence */
 		outw(0x00, base);
@@ -1772,8 +1779,10 @@ static int __devinit load_firmware(struc
 
 		udelay(100); /* 0x2f */
 
-		if (WaitTillCardIsFree(base))
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		if ((status = inw(base + 0x4)) != 0) {
 			dev_warn(&pdev->dev, "Card%d rejected load header:\n"
@@ -1787,8 +1796,10 @@ static int __devinit load_firmware(struc
 
 		udelay(50); /* 0x0f */
 
-		if (WaitTillCardIsFree(base))
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		if ((status = inw(base + 0x4)) != 0) {
 			dev_err(&pdev->dev, "Card%d got out of sync.Card "
@@ -1796,39 +1807,35 @@ static int __devinit load_firmware(struc
 			goto errrelfw;
 		}
  	}
-
-	retval = -EIO;
-
-	if (WaitTillCardIsFree(base))
-		goto errrelfw;
-
-	outw(0xf2, base);
-	outw(0x800, base);
-	outw(0x0, base);
-	outw(0x0, base);
-	InterruptTheCard(base);
-	outw(0x0, base + 0x4); /* for ISI4608 cards */
+	dev_info(&pdev->dev, "Firmware loaded, last values: \n\tWC: %u, "
+			"FD: %p, FP: %p\n",
+			word_count, fw->data, frame);
 
 /* XXX: should we test it by reading it back and comparing with original like
  * in load firmware package? */
-	for (frame = (struct stframe*)fw->data;
-			frame < (struct stframe*)(fw->data + fw->size);
-			frame++) {
-		if (WaitTillCardIsFree(base))
+	for (frame = (struct stframe *)fw->data;
+			frame < (struct stframe *)(fw->data + fw->size);
+			frame = (struct stframe *)((u8 *)frame + 4 +
+				frame->count)) {
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		outw(0xf1, base); /* start download sequence */
 		outw(0x00, base);
 		outw(frame->addr, base); /* lsb of address */
 
-		word_count = (frame->count >> 1) + frame->count % 2;
+		word_count = frame->count / 2 + frame->count % 2;
 		outw(word_count + 1, base);
 		InterruptTheCard(base);
 
 		udelay(50); /* 0xf */
 
-		if (WaitTillCardIsFree(base))
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		if ((status = inw(base + 0x4)) != 0) {
 			dev_warn(&pdev->dev, "Card%d rejected verify header:\n"
@@ -1853,8 +1860,10 @@ static int __devinit load_firmware(struc
 
 		udelay(50); /* 0xf */
 
-		if (WaitTillCardIsFree(base))
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		if ((status = inw(base + 0x4)) != 0) {
 			dev_err(&pdev->dev, "Card%d verify got out of sync. "
@@ -1863,6 +1872,17 @@ static int __devinit load_firmware(struc
 		}
 	}
 
+	/* xfer ctrl */
+	if (WaitTillCardIsFree(base))
+		goto errrelfw;
+
+	outw(0xf2, base);
+	outw(0x800, base);
+	outw(0x0, base);
+	outw(0x0, base);
+	InterruptTheCard(base);
+	outw(0x0, base + 0x4); /* for ISI4608 cards */
+
 	board->status |= FIRMWARE_LOADED;
 	retval = 0;
 
