Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWCBPvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWCBPvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWCBPvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:51:11 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:38140 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751973AbWCBPvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:51:10 -0500
Date: Fri, 03 Mar 2006 00:51:03 +0900 (JST)
Message-Id: <20060303.005103.03976584.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ralf@linux-mips.org
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 02 Mar 2006 23:02:27 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> In kernel 2.6, update_times() is called directly in timer
anemo> interrupt, so there is no point calculating ticks here.  This
anemo> also get rid of difference of jiffies and jiffies_64 due to
anemo> compiler's optimization (which was reported previously with
anemo> subject "jiffies_64 vs. jiffies").

Sorry, it seems the patch breaks lost-tick handling on x86_64.  Here
is a revised patch including its adjustment.


In kernel 2.6, update_times() is called directly in timer interrupt,
so there is no point calculating ticks here.  This also get rid of
difference of jiffies and jiffies_64 due to compiler's optimization
(which was reported previously with subject "jiffies_64 vs. jiffies").

Also adjust x86_64 timer interrupt handler with this change.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 3080f84..7a1d790 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -423,7 +423,8 @@ void main_timer_handler(struct pt_regs *
 
 	if (lost > 0) {
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
+		while (lost--)
+			do_timer(regs);
 	}
 
 /*
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
