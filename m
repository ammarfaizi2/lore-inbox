Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWIRVCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWIRVCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWIRVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:02:14 -0400
Received: from av2.karneval.cz ([81.27.192.122]:46702 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030190AbWIRVCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:02:14 -0400
Message-id: <912929121291221@karneval.cz>
Subject: [PATCH] isicom: correct firmware loading
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 18 Sep 2006 23:02:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom: correct firmware loading

Loading of firmware didn't fail when something went wrong (returned 0). Pointer to
frame was incremented only by sizeof(frame) excluding it's data contents -- bad
idea. Tell the card we're ready just after checking is complete, not before.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 7fa7a3e6bcd181bb25adacfc71dc8a386e347e9d
tree 00758e71b46c5de09d98c79cf00f187012b9ba35
parent ca8b00296c6ff25faf9db7fe4b11d1460b64c7d7
author Jiri Slaby <xslaby@anemoi.localdomain> Mon, 18 Sep 2006 22:57:06 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Mon, 18 Sep 2006 22:57:06 +0200

 drivers/char/isicom.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 6cca4b2..ea2bbf8 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1756,9 +1756,12 @@ static int __devinit load_firmware(struc
 	if (retval)
 		goto end;
 
+	retval = -EIO;
+
 	for (frame = (struct stframe *)fw->data;
 			frame < (struct stframe *)(fw->data + fw->size);
-			frame++) {
+			frame = (struct stframe *)((u8 *)(frame + 1) +
+				frame->count)) {
 		if (WaitTillCardIsFree(base))
 			goto errrelfw;
 
@@ -1797,23 +1800,12 @@ static int __devinit load_firmware(struc
 		}
  	}
 
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
-
 /* XXX: should we test it by reading it back and comparing with original like
  * in load firmware package? */
-	for (frame = (struct stframe*)fw->data;
-			frame < (struct stframe*)(fw->data + fw->size);
-			frame++) {
+	for (frame = (struct stframe *)fw->data;
+			frame < (struct stframe *)(fw->data + fw->size);
+			frame = (struct stframe *)((u8 *)(frame + 1) +
+				frame->count)) {
 		if (WaitTillCardIsFree(base))
 			goto errrelfw;
 
@@ -1863,6 +1855,17 @@ static int __devinit load_firmware(struc
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
 
