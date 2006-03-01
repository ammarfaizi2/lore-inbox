Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWCAMFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWCAMFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWCAMFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:05:44 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:42582 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S964824AbWCAMFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:05:43 -0500
Date: Wed, 01 Mar 2006 21:05:41 +0900 (JST)
Message-Id: <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 01 Mar 2006 14:44:42 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Hi.  I noticed that the 'jiffies' variable has 'wall_jiffies +
anemo> 1' value in most of time.  I'm using MIPS platform but I think
anemo> this is same for other platforms.

anemo> I suppose this is due to gcc does not know that jiffies_64 and
anemo> jiffies share same place.
...
anemo> Is this really expected code?  If no, how it can be fixed?
anemo> Insert "barrier()" right after "jiffies_64++" ?

I suppose passing updated jiffies to update_times() would be more
efficient than barrier().  Here is a patch.


Pass updated jiffies to update_times() to avoid jiffies/jiffies_64
aliasing.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/kernel/timer.c b/kernel/timer.c
index fe3a9a9..7734788 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -904,11 +904,11 @@ void run_local_timers(void)
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
-static inline void update_times(void)
+static inline void update_times(unsigned long jif)
 {
 	unsigned long ticks;
 
-	ticks = jiffies - wall_jiffies;
+	ticks = jif - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
@@ -924,8 +924,7 @@ static inline void update_times(void)
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
-	update_times();
+	update_times(++jiffies_64);
 	softlockup_tick(regs);
 }
 
---
Atsushi Nemoto
