Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSHTJWb>; Tue, 20 Aug 2002 05:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHTJWb>; Tue, 20 Aug 2002 05:22:31 -0400
Received: from miranda.axis.se ([193.13.178.2]:22408 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S316728AbSHTJWa>;
	Tue, 20 Aug 2002 05:22:30 -0400
From: johan.adolfsson@axis.com
Message-ID: <01a301c2482c$51a00e40$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Johan Adolfsson" <johan.adolfsson@axis.com>
Subject: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Tue, 20 Aug 2002 11:31:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cris architecture don't have any tsc, but it has a couple of
timer registers that can be used to get better than jiffie resolution.

I set the time to a 40 us resolution counter with a slight
"jump" since lower 8 bit only counts from 0 to 249,
the patch does not take wrapping of the register into account either
to save some cycles, is that a problem or a good thing?

The num is xor:d with the value from 2 timer registers,
which in turn contains different fields breifly described below.

Does the patch below look sane?

/Johan Adolfsson


--- random.c    7 Dec 2001 16:53:17 -0000       1.10
+++ random.c    20 Aug 2002 09:10:04 -0000
@@ -746,6 +746,15 @@ static void add_timer_randomness(struct
        __u32 high;
        rdtsc(time, high);
        num ^= high;
+#elif defined (__CRIS__)
+       /* R_TIMER0_DATA, 8 bit, 40 us resolution, counting down from 250 */
+       /* R_TIMER_DATA, 4*8 bit, timer1, timer0, 38.4kHz, 7.3728MHz */
+       /* R_PRESCALE_STATUS, upper 16 bit: 320ns resolution,
+          lower 16 bit: 40 ns resolution, ~10 bits used,
+          counting down from 1000 */
+       time = jiffies << 8;
+       time |= (TIMER0_DIV - *R_TIMER0_DATA);
+       num ^= *R_PRESCALE_STATUS ^ *R_TIMER_DATA;
 #else
        time = jiffies;
 #endif


