Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbSJJAMN>; Wed, 9 Oct 2002 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJJAMN>; Wed, 9 Oct 2002 20:12:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58342 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262495AbSJJAMK>; Wed, 9 Oct 2002 20:12:10 -0400
Subject: [PATCH] linux-2.5.41_timer-changes_A4 (1/3 - infrastructure)
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, greg kh <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 17:11:35 -0700
Message-Id: <1034208695.21965.1356.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

        The i386 time.c code is turning into a mess. We've got multiple
functions that do the same thing, only with different hardware, all
surrounded #ifdefs and even more difficult to follow #ifndefs. George
Anzinger is introducing a new ACPIpm time source, I'm going to attempt
to add the cyclone counter as a time source, and in the future there
will be HPET to deal with. These will not go in cleanly together as
things are now.
        
        Inspired by suggestions from Alan, this collection of patches
tries to clean up time.c by breaking out the PIT and TSC specific parts
into their own files. Additionally the patch creates an abstract
interface to use these existing time soruces, as well as make it easier
to add future time sources. 
        
        It introduces "struct timer_ops" which gives the time code a
clear interface to use these different time sources. It also allows for
clearer conditional compilation of these various time sources. 

        This first patch (part 1 of 3) provides the infrastructure
needed via the timer_ops structure, as well as the select_timer()
function for choosing the best available timer. 

New in this version (A4):
* nitpick changes -GregKH
* move new files into their own directory -Pat Mochel
        
Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer.c	Wed Oct  9 17:06:09 2002
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
+++ b/include/asm-i386/timer.h	Wed Oct  9 17:06:09 2002
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

