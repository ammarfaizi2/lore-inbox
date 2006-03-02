Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCBOCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCBOCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWCBOCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:02:34 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:49901 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750820AbWCBOCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:02:33 -0500
Date: Thu, 02 Mar 2006 23:02:27 +0900 (JST)
Message-Id: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ralf@linux-mips.org
Subject: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing
 problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6, update_times() is called directly in timer interrupt,
so there is no point calculating ticks here.  This also get rid of
difference of jiffies and jiffies_64 due to compiler's optimization
(which was reported previously with subject "jiffies_64 vs. jiffies").

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/kernel/timer.c b/kernel/timer.c
index fe3a9a9..6188c99 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -906,14 +906,9 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
-	if (ticks) {
-		wall_jiffies += ticks;
-		update_wall_time(ticks);
-	}
-	calc_load(ticks);
+	wall_jiffies++;
+	update_wall_time(1);
+	calc_load(1);
 }
   
 /*

---
Atsushi Nemoto
