Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWIMPeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWIMPeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWIMPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:34:44 -0400
Received: from orfeus.profiwh.com ([85.93.165.27]:31503 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1750950AbWIMPen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:34:43 -0400
Message-ID: <45082055.7010309.reply@wsc.cz>
In-Reply-To: <45082055.7010309@carlislefsp.com>
References: <4506DAD7.8030307.reply@wsc.cz>, <45082055.7010309@carlislefsp.com>
From: Jiri Slaby <jirislaby@gmail.com>
To: Steve Roemen <stever@carlislefsp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: isicom module oops 2.6.17.13
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Wed, 13 Sep 2006 11:34:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Roemen wrote:
> after adding that patch to 2.6.18-rc6-mm2 and trying another card (an 
> isi5634 pci/8) i get this in dmesg while loading the driver:
> 
> faxserver2:~# modprobe isicom
> faxserver2:~# cat /var/log/kern.log
> 
> Sep 13 09:59:11 localhost kernel: isicom 0000:00:10.0: ISI PCI 
> Card(Device ID 0x2052)
> Sep 13 09:59:14 localhost kernel: isicom 0000:00:10.0: -Done
> Sep 13 09:59:15 localhost kernel: 00, FP: e09c762c
> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
> FD: e09c7000, FP: e09c7640
> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
> FD: e09c7000, FP: e09c7654

[snip]

> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
> FD: e09c7000, FP: e09c8964
> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
> FD: e09c7000, FP: e09c8978
> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 5, FC: 9, FD: 
> e09c7000, FP: e09c898c
> Sep 13 09:59:17 localhost kernel: isicom: probe of 0000:00:10.0 failed 
> with error -5

Yes, thanks a lot, but more diagnostics is needed and I forgot to correct for
loop for checking uploaded firmware...
Could you revert previous patch and apply this one, please?

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 6cca4b2..bf371b0 100644
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
@@ -1796,8 +1807,9 @@ static int __devinit load_firmware(struc
 			goto errrelfw;
 		}
  	}
-
-	retval = -EIO;
+	dev_info(&pdev->dev, "Firmware loaded, last values: \n\tWC: %u, "
+			"FD: %p, FP: %p\n",
+			word_count, fw->data, frame);
 
 	if (WaitTillCardIsFree(base))
 		goto errrelfw;
@@ -1811,24 +1823,29 @@ static int __devinit load_firmware(struc
 
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
@@ -1853,8 +1870,10 @@ static int __devinit load_firmware(struc
 
 		udelay(50); /* 0xf */
 
-		if (WaitTillCardIsFree(base))
+		if (WaitTillCardIsFree(base)) {
+			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
 			goto errrelfw;
+		}
 
 		if ((status = inw(base + 0x4)) != 0) {
 			dev_err(&pdev->dev, "Card%d verify got out of sync. "
