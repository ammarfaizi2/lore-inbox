Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTGWAzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 20:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271072AbTGWAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 20:55:40 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:49045 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271071AbTGWAzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 20:55:38 -0400
Subject: missing #if for 1000 HZ
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org, Ulrich.Windl@rz.uni-regensburg.de
Cc: Andrew Morton <akpm@digeo.com>, alan@redhat.com
Content-Type: text/plain
Organization: 
Message-Id: <1058921711.944.24.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Jul 2003 21:01:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should improve timekeeping a bit @ 1000 HZ.


diff -Naurd old/kernel/timer.c new/kernel/timer.c
--- old/kernel/timer.c	2003-07-18 17:27:01.000000000 -0400
+++ new/kernel/timer.c	2003-07-18 17:32:19.000000000 -0400
@@ -606,6 +606,15 @@
     else
 	time_adj += (time_adj >> 2) + (time_adj >> 5);
 #endif
+#if HZ == 1000
+    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
+     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
+     */
+    if (time_adj < 0)
+	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
+    else
+	time_adj += (time_adj >> 6) + (time_adj >> 7);
+#endif
 }
 
 /* in the NTP reference this is called "hardclock()" */



