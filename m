Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJACeE>; Mon, 30 Sep 2002 22:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJACeE>; Mon, 30 Sep 2002 22:34:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26325 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261449AbSJACeC>;
	Mon, 30 Sep 2002 22:34:02 -0400
Subject: [PATCH] linux-2.5.39_timer-changes_A3 (1/3 - infrastructure)
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Sep 2002 19:34:34 -0700
Message-Id: <1033439675.1013.64.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Dave, all,

	This is part 1 of 3 of my timer-changes patch. Nothing new in this
release, but I broke it up considerably to try to aid people who might
attempt to read over it. 

As I've said before, this collection of patches breaks up the i386
time.c using a timer_ops structure to abstract away the different time
sources used (such as TSC, PIT, and in the future HPET, cyclone,
ACPIpm). 

Part 1 is just the infrastructure required (struct timer_ops,
select_timer()), and changes no existing code.

Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/timer.c b/arch/i386/kernel/timer.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timer.c	Mon Sep 30 19:14:54 2002
@@ -0,0 +1,26 @@
+#include <linux/kernel.h>
+#include <asm/timer.h>
+
+/* list of externed timers */
+/* eg: extern struct timer_opts timer_XXX*/;
+
+/* list of timers, ordered by preference */
+struct timer_opts* timers[] = {
+	/* eg: &timer_XXX */
+};
+
+#define NR_TIMERS (sizeof(timers)/sizeof(timers[0]))
+
+/* iterates through the list of timers, returning the first 
+ * one that initializes successfully.
+ */
+struct timer_opts* select_timer(void)
+{
+	int i;
+	/* find most preferred working timer */
+	for(i=0; i < NR_TIMERS; i++)
+		if(timers[i]->init())
+			return timers[i];
+	panic("select_timer: Cannot find a suitable timer\n");
+	return 0;
+}
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/timer.h	Mon Sep 30 19:14:54 2002
@@ -0,0 +1,14 @@
+#ifndef _ASMi386_TIMER_H
+#define _ASMi386_TIMER_H
+
+struct timer_opts{
+	/* probes and initializes timer. returns 1 on sucess, 0 on failure */
+	int (*init)(void);
+	/* called by the timer interrupt */
+	void (*mark_offset)(void);
+	/* called by gettimeofday. returns # ms since the last timer interrupt */
+	unsigned long (*get_offset)(void);
+};
+
+struct timer_opts* select_timer(void);
+#endif

