Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUBTVCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUBTVCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:02:53 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:8141 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261401AbUBTVBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:01:39 -0500
Date: Fri, 20 Feb 2004 16:01:27 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, brugolsky@telemetry-investments.com
Subject: [PATCH][1/4] poll()/select() timeout behavior
Message-ID: <20040220210127.GB1912@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the useful range of the poll() timeout parameter
from a mere 2147s (LONG_MAX/(1000*HZ)) to 2147483s (LONG_MAX/1000).

Please apply.

	Bill Rugolsky

--- linux/fs/select.c	2004-02-03 22:43:06.000000000 -0500
+++ linux/fs/select.c	2004-02-19 14:29:03.827275000 -0500
@@ -469,11 +469,17 @@
 		return -EINVAL;
 
 	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
+                if (timeout < 0) {
 			timeout = MAX_SCHEDULE_TIMEOUT;
+		} else { 
+			/* Careful about overflow in the intermediate values */
+			long seconds = timeout/1000;
+			timeout = ((timeout - 1000*seconds)*HZ + 999)/1000 + 1;
+			if (seconds <= (MAX_SCHEDULE_TIMEOUT-2) / HZ - 1)
+				timeout += seconds*HZ;
+			else
+				timeout = MAX_SCHEDULE_TIMEOUT;
+		}
 	}
 
 	poll_initwait(&table);
