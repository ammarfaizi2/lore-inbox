Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSLPWDm>; Mon, 16 Dec 2002 17:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSLPWDm>; Mon, 16 Dec 2002 17:03:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36010 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261645AbSLPWDl>;
	Mon, 16 Dec 2002 17:03:41 -0500
Subject: [RFC] linux-2.4.21-pre1_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1040076206.1583.14.camel@w-jstultz2.beaverton.ibm.com>
References: <1040076206.1583.14.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040076569.1576.21.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Dec 2002 14:09:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	On the x440, we occasionally (or not so occasionally) get SMIs that
take longer then a few ticks. This can cause brief inconsistencies in
gettimeofday values, as well as clock drift. This patch is my first
patch at compensating for the lost ticks. This applies on top of the
cyclone-timer_B3 patch. 

Comments, feedback, and flames requested. 

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Dec 16 13:57:55 2002
+++ b/arch/i386/kernel/time.c	Mon Dec 16 13:57:55 2002
@@ -279,6 +279,7 @@
 static inline void mark_timeoffset_cyclone(void)
 {
 	int count;
+	unsigned long delta = last_cyclone_timer;
 	spin_lock(&i8253_lock);
 	/* quickly read the cyclone timer */
 	if(cyclone_timer)
@@ -291,6 +292,13 @@
 	count |= inb(0x40) << 8;
 	spin_unlock(&i8253_lock);
 
+	/*lost tick compensation*/
+	delta = last_cyclone_timer - delta;
+	if(delta > loops_per_jiffy+2000){
+		delta = (delta/loops_per_jiffy)-1;
+		jiffies += delta;
+	}
+               
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }



