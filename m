Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTAHXRi>; Wed, 8 Jan 2003 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbTAHXRi>; Wed, 8 Jan 2003 18:17:38 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23468 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267970AbTAHXRh>;
	Wed, 8 Jan 2003 18:17:37 -0500
Subject: [PATCH] linux-2.4.21-pre3_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042068113.1048.150.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 Jan 2003 15:21:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 
	
	Occasionally due to SMIs issued by the service processor, x440s will
lose an interrupt or two. This can cause gettimeofday time
discontinuities as well as clock skew (due to jiffies not being
incremented when needed).  This patch uses the cyclone timer to notice
these lost ticks and compensate for them. It only affects systems using
the cyclone timer (x440s only at the moment). 

Please apply. 

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Jan  8 11:37:13 2003
+++ b/arch/i386/kernel/time.c	Wed Jan  8 11:37:13 2003
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



