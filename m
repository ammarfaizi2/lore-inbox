Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUBOGRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 01:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUBOGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 01:17:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:26525 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264147AbUBOGRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 01:17:19 -0500
Subject: [PATCH] Remove debug cruft from via-pmu.c driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076825785.6960.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 17:16:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== drivers/macintosh/via-pmu.c 1.29 vs edited =====
--- 1.29/drivers/macintosh/via-pmu.c	Sun Feb 15 04:11:03 2004
+++ edited/drivers/macintosh/via-pmu.c	Sun Feb 15 17:14:06 2004
@@ -72,13 +72,6 @@
 /* How many iterations between battery polls */
 #define BATTERY_POLLING_COUNT	2
 
-/* Some debugging tools */
-#ifdef CONFIG_XMON
-//#define LIVE_DEBUG(req) ((req) && (req)->data[0] == 0x7d)
-#define LIVE_DEBUG(req) (0)
-static int whacky_debug;
-#endif /* CONFIG_XMON */
-
 static volatile unsigned char *via;
 
 /* VIA registers - spaced 0x200 bytes apart */
@@ -1218,12 +1211,6 @@
 	wait_for_ack();
 	/* set the shift register to shift out and send a byte */
 	send_byte(req->data[0]);
-#ifdef CONFIG_XMON
-	if (LIVE_DEBUG(req))
-		xmon_printf("R");
-	else
-		whacky_debug = 0;
-#endif /* CONFIG_XMON */
 }
 
 void __openfirmware
@@ -1476,29 +1463,17 @@
 	case sending:
 		req = current_req;
 		if (data_len < 0) {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(req))
-				xmon_printf("s");
-#endif /* CONFIG_XMON */
 			data_len = req->nbytes - 1;
 			send_byte(data_len);
 			break;
 		}
 		if (data_index <= data_len) {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(req))
-				xmon_printf("S");
-#endif /* CONFIG_XMON */
 			send_byte(req->data[data_index++]);
 			break;
 		}
 		req->sent = 1;
 		data_len = pmu_data_len[req->data[0]][1];
 		if (data_len == 0) {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(req))
-				xmon_printf("D");
-#endif /* CONFIG_XMON */
 			pmu_state = idle;
 			current_req = req->next;
 			if (req->reply_expected)
@@ -1506,10 +1481,6 @@
 			else
 				return req;
 		} else {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(req))
-				xmon_printf("-");
-#endif /* CONFIG_XMON */
 			pmu_state = reading;
 			data_index = 0;
 			reply_ptr = req->reply + req->reply_len;
@@ -1532,18 +1503,10 @@
 	case reading:
 	case reading_intr:
 		if (data_len == -1) {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(current_req))
-				xmon_printf("r");
-#endif /* CONFIG_XMON */
 			data_len = bite;
 			if (bite > 32)
 				printk(KERN_ERR "PMU: bad reply len %d\n", bite);
 		} else if (data_index < 32) {
-#ifdef CONFIG_XMON
-			if (LIVE_DEBUG(current_req))
-				xmon_printf("R");
-#endif /* CONFIG_XMON */
 			reply_ptr[data_index++] = bite;
 		}
 		if (data_index < data_len) {
@@ -1551,12 +1514,6 @@
 			break;
 		}
 
-#ifdef CONFIG_XMON
-		if (LIVE_DEBUG(current_req)) {
-			whacky_debug = 1;
-		       	xmon_printf("D");
-		}
-#endif /* CONFIG_XMON */
 		if (pmu_state == reading_intr) {
 			pmu_state = idle;
 			int_data_state[int_data_last] = int_data_ready;
@@ -1603,10 +1560,6 @@
 		intr = in_8(&via[IFR]) & (SR_INT | CB1_INT);
 		if (intr == 0)
 			break;
-#ifdef CONFIG_XMON
-		if (whacky_debug)
-			xmon_printf("|%02x|", intr);
-#endif /* CONFIG_XMON */
 		handled = 1;
 		if (++nloop > 1000) {
 			printk(KERN_DEBUG "PMU: stuck in intr loop, "
@@ -1629,10 +1582,6 @@
 recheck:
 	if (pmu_state == idle) {
 		if (adb_int_pending) {
-#ifdef CONFIG_XMON
-			if (whacky_debug)
-				xmon_printf("!A!");
-#endif /* CONFIG_XMON */
 			if (int_data_state[0] == int_data_empty)
 				int_data_last = 0;
 			else if (int_data_state[1] == int_data_empty)


