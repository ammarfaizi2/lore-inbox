Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTEWSmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTEWSmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:42:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12985 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264134AbTEWSmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:42:14 -0400
Date: Fri, 23 May 2003 13:55:13 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: multipart/mixed; boundary=Apple-Mail-11-246986084
Subject: [PATCH] drivers/net/ewrk.c memory leak
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Message-Id: <1608D98C-8D50-11D7-BCE2-000A95A0560C@austin.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-11-246986084
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi, this was caught by the Stanford memory leak checker a while ago 
(2.5.48). If the tmp_stats allocation fails, tmp is not being freed.

-- 
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-11-246986084
Content-Disposition: attachment;
	filename=ewrk3-memleak.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="ewrk3-memleak.diff"

--- drivers/net/ewrk3.c.orig	2003-05-13 13:51:55.000000000 -0500
+++ drivers/net/ewrk3.c	2003-05-13 13:54:55.000000000 -0500
@@ -1968,7 +1968,10 @@
 	case EWRK3_GET_STATS: { /* Get the driver statistics */
 		struct ewrk3_stats *tmp_stats =
         		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
-		if (!tmp_stats) return -ENOMEM;
+		if (!tmp_stats) {
+			status = -ENOMEM;
+			break;
+		}
 
 		spin_lock_irqsave(&lp->hw_lock, flags);
 		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));

--Apple-Mail-11-246986084--

