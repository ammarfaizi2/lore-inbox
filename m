Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUBTVJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUBTVIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:08:00 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:14797 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261414AbUBTVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:05:06 -0500
Date: Fri, 20 Feb 2004 16:04:52 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, brugolsky@telemetry-investments.com
Subject: [PATCH][4/4] poll()/select() timeout behavior
Message-ID: <20040220210452.GE1912@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch forces select() to wait *at least* the specified timeout if
no events have occurred, same as poll(). The SUSv3 man page for select(2)
says:

   "If the timeout parameter is not a null pointer, it specifies a maximum
   interval to wait for the selection to complete. If the specified
   time interval expires without any requested operation becoming ready,
   the function shall return."

Additionally:

   "If the requested timeout interval requires a finer granularity than
   the implementation supports, the actual timeout interval shall be
   rounded up to the next supported value."

Unfortunately, fixing the fencepost error places a hard lower limit of
1/HZ on the time slept, and increases the average minimum sleep time
threefold, from 1/(2*HZ) jiffy to 3/(2*HZ).

Please consider applying.

	Bill Rugolsky

--- linux/fs/select.c	2004-02-20 14:29:11.000000000 -0500
+++ linux/fs/select.c	2004-02-20 14:30:18.326814232 -0500
@@ -313,8 +313,8 @@
 		if (sec < 0 || usec < 0 || usec >= 1000000)
 			goto out_nofds;
 
-		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-1) / HZ - 1) {
-			timeout = ROUND_UP(usec, 1000000/HZ);
+		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-2) / HZ - 1) {
+			timeout = ROUND_UP(usec, 1000000/HZ) + 1;
 			timeout += sec * (unsigned long) HZ;
 		} else {
 			timeout = MAX_SCHEDULE_TIMEOUT-1;
