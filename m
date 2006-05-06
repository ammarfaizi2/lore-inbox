Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWEFBoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWEFBoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 21:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEFBoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 21:44:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58347 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750868AbWEFBoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 21:44:37 -0400
Subject: [PATCH] Time: optimize out some mults, since gcc can't avoid them
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Content-Type: text/plain
Date: Fri, 05 May 2006 18:44:33 -0700
Message-Id: <1146879873.12414.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newsflash: GCC not as smart as once hoped.

This patch removes some mults since GCC can't figure out how.

Pointed out by Roman Zippel.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 585789f..5f4a7f7 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -236,7 +236,6 @@ static inline int error_aproximation(u64
  *
  * Where mult_delta is the adjustment value made to mult
  *
- * XXX - Hopefully gcc is smart enough to avoid the multiplies.
  */
 static inline s64 make_ntp_adj(struct clocksource *clock,
 				cycles_t cycles_delta, s64* error)
@@ -244,27 +243,27 @@ static inline s64 make_ntp_adj(struct cl
 	s64 ret = 0;
 	if (*error  > ((s64)clock->interval_cycles+1)/2) {
 		/* calculate adjustment value */
-		int adjustment = 1 << error_aproximation(*error,
+		int adjustment = error_aproximation(*error,
 						clock->interval_cycles);
 		/* adjust clock */
-		clock->mult += adjustment;
-		clock->interval_snsecs += clock->interval_cycles * adjustment;
+		clock->mult += 1 << adjustment;
+		clock->interval_snsecs += clock->interval_cycles << adjustment;
 
 		/* adjust the base and error for the adjustment */
-		ret =  -(cycles_delta * adjustment);
-		*error -= clock->interval_cycles * adjustment;
+		ret =  -(cycles_delta << adjustment);
+		*error -= clock->interval_cycles << adjustment;
 		/* XXX adj error for cycle_delta offset? */
 	} else if ((-(*error))  > ((s64)clock->interval_cycles+1)/2) {
 		/* calculate adjustment value */
-		int adjustment = 1 << error_aproximation(-(*error),
+		int adjustment = error_aproximation(-(*error),
 						clock->interval_cycles);
 		/* adjust clock */
-		clock->mult -= adjustment;
-		clock->interval_snsecs -= clock->interval_cycles * adjustment;
+		clock->mult -= 1 << adjustment;
+		clock->interval_snsecs -= clock->interval_cycles << adjustment;
 
 		/* adjust the base and error for the adjustment */
-		ret =  cycles_delta * adjustment;
-		*error += clock->interval_cycles * adjustment;
+		ret =  cycles_delta << adjustment;
+		*error += clock->interval_cycles << adjustment;
 		/* XXX adj error for cycle_delta offset? */
 	}
 	return ret;


