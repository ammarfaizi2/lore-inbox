Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWAQTQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWAQTQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWAQTQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:16:31 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50916 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751222AbWAQTQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:16:30 -0500
Subject: [PATCH] Time: Delay clocksource selection until later in boot
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: malattia@linux.it, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 11:16:05 -0800
Message-Id: <1137525365.27699.97.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Delay installing new clocksources until later in boot. This avoids some
of the clocksource churn that can occur at boot, possibly allowing the
system to run for a brief time with a bad clocksource.

This patch resolves the boot time stalls seen by Mattia Dongili.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>


diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -51,13 +51,27 @@ static LIST_HEAD(clocksource_list);
 static DEFINE_SPINLOCK(clocksource_lock);
 static char override_name[32];
 
+static int finished_booting;
+
+/* clocksource_done_booting - Called near the end of bootup
+ *
+ * Hack to avoid lots of clocksource churn at boot time 
+ */
+static int clocksource_done_booting(void)
+{
+	finished_booting = 1;
+	return 0;
+}
+
+late_initcall(clocksource_done_booting);
+
 /**
  * get_next_clocksource - Returns the selected clocksource
  */
 struct clocksource *get_next_clocksource(void)
 {
 	spin_lock(&clocksource_lock);
-	if (next_clocksource) {
+	if (next_clocksource && finished_booting) {
 		curr_clocksource = next_clocksource;
 		next_clocksource = NULL;
 	}


