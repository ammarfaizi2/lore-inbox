Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWH1TJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWH1TJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWH1TJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:09:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:53692
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751348AbWH1TJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:09:27 -0400
Subject: [PATCH] synclink_gt fix receive tty error handling
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060826020123.GB4765@stusta.de>
References: <20060826020123.GB4765@stusta.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 14:07:13 -0500
Message-Id: <1156792033.18811.10.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix receive tty error handling in synclink_gt driver.
Adrian reported compiler warning for incorrect bit test
against char variable. I determined these and other
device specific error bits were incorrectly defined.
 
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.18-rc5/drivers/char/synclink_gt.c	2006-08-28 08:39:18.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-08-28 10:38:49.000000000 -0500
@@ -391,8 +391,8 @@ static MGSL_PARAMS default_params = {
 #define DESC_LIST_SIZE 4096
 
 #define MASK_PARITY  BIT1
-#define MASK_FRAMING BIT2
-#define MASK_BREAK   BIT3
+#define MASK_FRAMING BIT0
+#define MASK_BREAK   BIT14
 #define MASK_OVERRUN BIT4
 
 #define GSR   0x00 /* global status */
@@ -1800,17 +1800,17 @@ static void rx_async(struct slgt_info *i
 
 			stat = 0;
 
-			if ((status = *(p+1) & (BIT9 + BIT8))) {
-				if (status & BIT9)
+			if ((status = *(p+1) & (BIT1 + BIT0))) {
+				if (status & BIT1)
 					icount->parity++;
-				else if (status & BIT8)
+				else if (status & BIT0)
 					icount->frame++;
 				/* discard char if tty control flags say so */
 				if (status & info->ignore_status_mask)
 					continue;
-				if (status & BIT9)
+				if (status & BIT1)
 					stat = TTY_PARITY;
-				else if (status & BIT8)
+				else if (status & BIT0)
 					stat = TTY_FRAME;
 			}
 			if (tty) {




