Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316132AbSEJVgl>; Fri, 10 May 2002 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316131AbSEJVgk>; Fri, 10 May 2002 17:36:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60657 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316130AbSEJVgi>;
	Fri, 10 May 2002 17:36:38 -0400
Message-ID: <3CDC3D39.607D1923@mvista.com>
Date: Fri, 10 May 2002 14:35:53 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 64-bit jiffies, a better solution
In-Reply-To: <1164.1003813848@ocs3.intra.ocs.com.au> <3BD52454.218387D9@mvista.com> <200110231545.f9NFjgg01377@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BD52454.218387D9@mvista.com>,
> george anzinger  <george@mvista.com> wrote:
> >
> >I am beginning to think that defining a u64 and casting, i.e.:
> >
> >#define jiffies (unsigned long volitial)jiffies_u64
> >
> >is the way to go.
> 
> ..except for gcc being bad at even 64->32-bit casts like the above.  It
> will usually still load the full 64-bit value, and then only use the low
> bits.
> 
> The efficient and sane way to do it is:
> 
>         /*
>          * The 64-bit value is not volatile - you MUST NOT read it
>          * without holding the spinlock
>          */
>         u64 jiffies_64;
> 
>         /*
>          * Most people don't necessarily care about the full 64-bit
>          * value, so we can just get the "unstable" low bits without
>          * holding the lock. For historical reasons we also mark
>          * it volatile so that busy-waiting doesn't get optimized
>          * away in old drivers.
>          */
>         #if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
>         #define jiffies (((volatile unsigned long *)&jiffies_64)[0])
>         #else
>         #define jiffies (((volatile unsigned long *)&jiffies_64)[1])
>         #endif
> 
> which looks ugly, but the ugliness is confined to that one place, and
> none of the users will ever have to care..
> 
>                 Linus

I tried the above and, aside from the numerous cases where "jiffies"
appears
as a dummy variable or a struct/union member which had to be "fixed", I
got 
flack from some folks who thought that:

extern unsigned long jiffies;

should work.  So here is a solution that does all the above and does 
NOT invade new name spaces:

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.14-org/Makefile linux/Makefile
--- linux-2.5.14-org/Makefile	Tue May  7 16:25:52 2002
+++ linux/Makefile	Thu May  9 18:18:53 2002
@@ -262,6 +262,7 @@
 
 vmlinux: include/linux/version.h $(CONFIGURATION) init/main.o
init/version.o init/do_mounts.o linuxsubdirs
 	$(LD) $(LINKFLAGS) $(HEAD) init/main.o init/version.o init/do_mounts.o
\
+		kernel/jiffies_linker_file.lds \
 		--start-group \
 		$(CORE_FILES) \
 		$(LIBS) \
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.14-org/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.14-org/include/linux/sched.h	Tue May  7 16:57:58 2002
+++ linux/include/linux/sched.h	Thu May  9 17:26:25 2002
@@ -459,6 +459,11 @@
 
 #include <asm/current.h>
 
+/*
+ * The 64-bit value is not volatile - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock)
+ */
+extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.14-org/kernel/jiffies_linker_file.lds
linux/kernel/jiffies_linker_file.lds
--- linux-2.5.14-org/kernel/jiffies_linker_file.lds	Wed Dec 31 16:00:00
1969
+++ linux/kernel/jiffies_linker_file.lds	Fri May 10 14:10:28 2002
@@ -0,0 +1,14 @@
+/*
+ * This linker script defines jiffies to be either the same as 
+ * jiffies_64 (for little endian or 64 bit machines) or
+ * jiffies_64+4 (for big endian machines)
+ * 
+ * It is intended to satisfy external references to a 32 bit jiffies
which
+ * is the low order 32-bits of a 64-bit jiffies.
+ *
+ * jiffies_at_jiffies_64 needs to be defined if this is a little endian
+ * or a 64-bit machine.
+ * Currently this is done in ..../kernel/timer.c
+ *
+ */
+jiffies =DEFINED(jiffies_at_jiffies_64) ? jiffies_64 : (jiffies_64 +
4);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.14-org/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.14-org/kernel/ksyms.c	Tue May  7 16:25:15 2002
+++ linux/kernel/ksyms.c	Thu May  9 17:21:43 2002
@@ -471,6 +471,7 @@
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 #endif
 EXPORT_SYMBOL(jiffies);
+EXPORT_SYMBOL(jiffies_64);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude
linux-2.5.14-org/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.14-org/kernel/timer.c	Tue May  7 16:15:52 2002
+++ linux/kernel/timer.c	Fri May 10 14:08:37 2002
@@ -67,7 +67,28 @@
 
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
-unsigned long volatile jiffies;
+/*
+ * The 64-bit value is not volatile - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock)
+ */
+u64 jiffies_64;
+/*
+ * Most people don't necessarily care about the full 64-bit
+ * value, so we can just get the "unstable" low bits without
+ * holding the lock. For historical reasons we also mark
+ * it volatile so that busy-waiting doesn't get optimized
+ * away in old drivers.
+ *
+ * This definition depends on the linker defining the actual address of
+ * jiffies using the following (found in
.../kernel/jiffies_linker_file):
+ * jiffies = DEFINED(jiffies_at_jiffies_64) ? jiffies_64 :
jiffies_64+4;
+ */
+#if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
+
+char jiffies_at_jiffies_64[0];
+#elif ! defined(__BIG_ENDIAN)
+#ERROR "Neither __LITTLE_ENDIAN nor __BIG_ENDIAN defined "
+#endif
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -664,7 +685,7 @@
 
 void do_timer(struct pt_regs *regs)
 {
-	(*(unsigned long *)&jiffies)++;
+	(*(u64 *)&jiffies_64)++;
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */

----------------------------------------------------------------------

And for those who think doing a ++ on 64-bits is too much to do in an
interrupt,
here is the before / after diff of the asm file for timer.c (messed up a
bit so
patch doesn't get confused):

*-* /usr/src/linux-2.5.14-kb/kernel/timer.o	Fri May 10 14:03:07 2002
*+* /usr/src/linux-2.5.14-kb/kernel/timer.s	Fri May 10 14:02:03 2002
** -1371,7 +1371,8 **
 .globl do_timer
 	.type	 do_timer,@function
 do_timer:
-	incl jiffies
+	addl $1,jiffies_64
+	adcl $0,jiffies_64+4
 	xorl %eax,%eax
 #APP
 	lock ; btsl %eax,bh_task_vec+4
-----------------------------
This solution should work for all platforms and long sizes, does not
depend on asm
and does not invade any new name spaces.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
