Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSL2CEH>; Sat, 28 Dec 2002 21:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSL2CEH>; Sat, 28 Dec 2002 21:04:07 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:20975 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266316AbSL2CEF>; Sat, 28 Dec 2002 21:04:05 -0500
Date: Sat, 28 Dec 2002 21:04:52 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.53 : drivers/char/ftape/lowlevel/ftape-calibr.c
Message-ID: <Pine.LNX.4.44.0212282102110.999-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch swaps the save_flags/cli/restore_flags combo with a 
spinlock. Please review.

Regards,
Frank

--- linux/drivers/char/ftape/lowlevel/ftape-calibr.c.old	Sat Oct 19 12:04:19 2002
+++ linux/drivers/char/ftape/lowlevel/ftape-calibr.c	Sat Dec 28 21:01:01 2002
@@ -35,9 +35,10 @@
 # include <linux/timex.h>
 #endif
 #include <linux/ftape.h>
-#include "../lowlevel/ftape-tracing.h"
-#include "../lowlevel/ftape-calibr.h"
-#include "../lowlevel/fdc-io.h"
+#include "ftape-tracing.h"
+#include "ftape-calibr.h"
+#include "fdc-io.h"
+#include <linux/spinlock.h>
 
 #undef DEBUG
 
@@ -62,6 +63,7 @@
  * it will overflow only once per 30 seconds (on a 200MHz machine),
  * which is plenty.
  */
+static spinlock_t ftape_calibar_lock = SPIN_LOCK_UNLOCKED;
 
 unsigned int ftape_timestamp(void)
 {
@@ -75,13 +77,12 @@
 	__u16 lo;
 	__u16 hi;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ftape_calibar_lock, flags);
 	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	lo = inb_p(0x40);	/* read the latched count */
 	lo |= inb(0x40) << 8;
 	hi = jiffies;
-	restore_flags(flags);
+	spin_lock_irqrestore(&ftape_calibar_lock, flags);
 	return ((hi + 1) * (unsigned int) LATCH) - lo;  /* downcounter ! */
 #endif
 }
@@ -94,12 +95,11 @@
 	unsigned int count;
  	unsigned long flags;
  
- 	save_flags(flags);
- 	cli();
+ 	spin_lock_irqsave(&ftape_calibar_lock, flags);
  	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	count = inb_p(0x40);	/* read the latched count */
 	count |= inb(0x40) << 8;
- 	restore_flags(flags);
+ 	spin_unlock_irqrestore(&ftape_calibar_lock, flags);
 	return (LATCH - count);	/* normal: downcounter */
 #endif
 }
@@ -150,14 +150,13 @@
 	int status;
 	TRACE_FUN(ft_t_any);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&ftape_calibar_lock, flags);
 	t0 = short_ftape_timestamp();
 	for (i = 0; i < 1000; ++i) {
 		status = inb(fdc.msr);
 	}
 	t1 = short_ftape_timestamp();
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ftape_calibar_lock, flags);
 	TRACE(ft_t_info, "inb() duration: %d nsec", ftape_timediff(t0, t1));
 	TRACE_EXIT;
 }
@@ -241,8 +240,7 @@
 
 		*calibr_count =
 		*calibr_time = count;	/* set TC to 1 */
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&ftape_calibar_lock, flags);
 		fun(0);		/* dummy, get code into cache */
 		t0 = short_ftape_timestamp();
 		fun(0);		/* overhead + one test */
@@ -252,7 +250,7 @@
 		fun(count);		/* overhead + count tests */
 		t1 = short_ftape_timestamp();
 		multiple = diff(t0, t1);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&ftape_calibar_lock, flags);
 		time = ftape_timediff(0, multiple - once);
 		tc = (1000 * time) / (count - 1);
 		TRACE(ft_t_any, "once:%3d us,%6d times:%6d us, TC:%5d ns",

