Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWDCT5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWDCT5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWDCT5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:57:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2537 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964866AbWDCT53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:57:29 -0400
Date: Mon, 3 Apr 2006 21:56:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] increase current_tick_length() resolution
Message-ID: <Pine.LNX.4.64.0604032156070.4711@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Increase the scale for current_tick_length() to 32bit, which gives NTP
more room for improvement and makes it simpler to extract the full nsec
part.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/powerpc/kernel/time.c |    2 +-
 kernel/timer.c             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-mm/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/arch/powerpc/kernel/time.c	2006-04-02 17:23:17.000000000 +0200
+++ linux-2.6-mm/arch/powerpc/kernel/time.c	2006-04-02 17:23:23.000000000 +0200
@@ -103,7 +103,7 @@ EXPORT_SYMBOL(tb_ticks_per_sec);	/* for 
 u64 tb_to_xs;
 unsigned tb_to_us;
 
-#define TICKLEN_SCALE	(SHIFT_SCALE - 10)
+#define TICKLEN_SCALE	32
 u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
 u64 ticklen_to_xs;	/* 0.64 fraction */
 
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-04-02 17:23:17.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-04-02 17:23:23.000000000 +0200
@@ -767,7 +767,7 @@ static void update_wall_time_one_tick(vo
  * Return how long ticks are at the moment, that is, how much time
  * update_wall_time_one_tick will add to xtime next time we call it
  * (assuming no calls to do_adjtimex in the meantime).
- * The return value is in fixed-point nanoseconds with SHIFT_SCALE-10
+ * The return value is in fixed-point nanoseconds with 32
  * bits to the right of the binary point.
  * This function has no side-effects.
  */
@@ -776,7 +776,7 @@ u64 current_tick_length(void)
 	long delta_nsec;
 
 	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
-	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
+	return ((u64)delta_nsec << 32) + ((s64)time_adj << (32 - (SHIFT_SCALE - 10)));
 }
 
 /*
