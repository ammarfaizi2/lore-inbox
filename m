Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSGXBFM>; Tue, 23 Jul 2002 21:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSGXBFM>; Tue, 23 Jul 2002 21:05:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20722 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315784AbSGXBFL>; Tue, 23 Jul 2002 21:05:11 -0400
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in
	2.5.27?]
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: george anzinger <george@mvista.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 18:08:17 -0700
Message-Id: <1027472897.927.247.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 16:28, Ingo Molnar wrote:

> this is most definitely not the correct fix ...
> 
> i'm quite convinced that the fix is to avoid illegal preemption, not to
> work it around.

I am not sure I am fully convinced one way or the other, but treating
every bit of code as we find it scares me.  The fact is, if a
spin_unlock() can magically reenable interrupts that is a bug.

I don't like relying on chance and the possibility your debug tool found
the problem... but at the same time, Ingo's solution is a lot cleaner.

Linus, Ingo, comments?

Attached is the patch George mentioned, against 2.5.27.

	Robert Love

diff -urN linux-2.5.27/include/asm-i386/system.h linux/include/asm-i386/system.h
--- linux-2.5.27/include/asm-i386/system.h	Sat Jul 20 12:11:05 2002
+++ linux/include/asm-i386/system.h	Tue Jul 23 18:03:47 2002
@@ -270,6 +270,13 @@
 /* Compiling for a 386 proper.	Is it worth implementing via cli/sti?  */
 #endif
 
+#define MASK_IF			0x200
+#define interrupts_enabled()	({ \
+		int flg; \
+		__save_flags(flg); \
+		flg & MASK_IF; \
+})
+
 /*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
diff -urN linux-2.5.27/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.27/kernel/sched.c	Sat Jul 20 12:11:11 2002
+++ linux/kernel/sched.c	Tue Jul 23 18:02:13 2002
@@ -899,7 +899,7 @@
 {
 	struct thread_info *ti = current_thread_info();
 
-	if (unlikely(ti->preempt_count))
+	if (unlikely(ti->preempt_count || !interrupts_enabled()))
 		return;
 
 need_resched:

