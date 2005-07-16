Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVGPDHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVGPDHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVGPDEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:04:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35259 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262102AbVGPDEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:04:30 -0400
Subject: [RFC][PATCH - 7/12] NTP cleanup: Cleanup signed shifting logic
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482925.25236.42.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:04:23 -0700
Message-Id: <1121483064.28638.0.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Signed shifting must be done carefully, and the ntp code has quite a
number of conditionals to do the signed shifting. This patch makes use
of the local shiftR() macro introduced in a previous patch to simplify a
bit of logic.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part7_B4.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -165,28 +165,19 @@ void second_overflow(void)
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
 
@@ -352,10 +343,7 @@ int ntp_adjtimex(struct timex *txc)
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


