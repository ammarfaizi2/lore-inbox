Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVHKBbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVHKBbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVHKBbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:31:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13013 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932136AbVHKBbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:31:19 -0400
Subject: [RFC][PATCH - 7/13] NTP cleanup: Cleanup signed shifting logic
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723739.32330.8.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
	 <1123723634.32330.4.camel@cog.beaverton.ibm.com>
	 <1123723696.32330.6.camel@cog.beaverton.ibm.com>
	 <1123723739.32330.8.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:31:15 -0700
Message-Id: <1123723875.32330.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Signed shifting must be done carefully, and the ntp code has quite a
number of conditionals to do the signed shifting. This patch makes use
of the shiftR() macro introduced in a previous patch to simplify a bit
of logic.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc6_timeofday-ntp-part7_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -162,28 +162,19 @@ void second_overflow(void)
 	}
 
 	ltemp = time_freq;
-	if (ltemp < 0)
-		time_adj -= -ltemp >> (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
-	else
-		time_adj += ltemp >> (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
+	time_adj += shiftR(ltemp, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
     /* Compensate for (HZ==100) != (1 << SHIFT_HZ).
      * Add 25% and 3.125% to get 128.125; => only 0.125% error (p. 14)
      */
-	if (time_adj < 0)
-		time_adj -= (-time_adj >> 2) + (-time_adj >> 5);
-	else
-		time_adj += (time_adj >> 2) + (time_adj >> 5);
+	time_adj += shiftR(time_adj,2) + shiftR(time_adj,5);
 #endif
 #if HZ == 1000
     /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
      * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
      */
-	if (time_adj < 0)
-		time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
-	else
-		time_adj += (time_adj >> 6) + (time_adj >> 7);
+	time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
 #endif
 }
 
@@ -349,10 +340,7 @@ int ntp_adjtimex(struct timex *txc)
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 		txc->offset = save_adjust;
 	else {
-		if (time_offset < 0)
-			txc->offset = -(-time_offset >> SHIFT_UPDATE);
-		else
-			txc->offset = time_offset >> SHIFT_UPDATE;
+		txc->offset = shiftR(time_offset, SHIFT_UPDATE);
 	}
 	txc->freq = time_freq;
 	txc->maxerror = time_maxerror;


