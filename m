Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971454-26836>; Sat, 11 Jul 1998 22:50:40 -0400
Received: from miris.lcs.mit.edu ([18.111.0.89]:54949 "EHLO miris.lcs.mit.edu" ident: "cananian") by vger.rutgers.edu with ESMTP id <971441-26836>; Sat, 11 Jul 1998 22:50:27 -0400
Date: Sat, 11 Jul 1998 23:59:25 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: linux-kernel@vger.rutgers.edu
Subject: PATCH: time.c modifications for clock instability.
Message-ID: <Pine.GSO.3.96.980711234511.8396G-100000@miris.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Attached is a patch to fix all the know kernel clock instability problems
with APM, processors that slow down or stop the TSC, etc.  I wrote it a
month-and-a-half ago (before life disruptions internet-vanished me for a
while), so it's against 2.1.103, but I think it should apply fairly
cleanly to new kernels, assuming the problems I address haven't already
been hacked at.  Andre Balsa can advocate the new approach for you; I'll just
summarize what this patch does:
 - Gets rid of those pesky divide-by-zero errors in the kernel.
 - allows recalibration of the TSC due to APM events, etc.
 - see the comments in the patch for more information.

Note that a little arithmetic magic can turn the global
'tsc_counts_per_jiffy' into a funky MHz reading at boot or in /proc, if
you like.  I don't want to get involved in kernel-bloat wars, so this
feature is purposefully *not* implemented here.  I suggest that patches
for this functionality, if desired, be kept *rigourously separate* from
the main overhaul of the kernel time code.

Note also the comment in linux/arch/i386/kernel/process.c in the patch.
Someone familiar with the Cyrix/Centaur/whatever processors that slow/stop
the processor clock on hlt should add the appropriate code at the point of
the comments.  When I wrote this patch, there was strong lobbying for a
revamp of the processor capabilities features.  I *hope* that was done:
the architectures discussed were very clean and sound, but I have been
away from linux-kernel so I don't know how it turned out.

I think that's it.  I'm drastically filtering linux-kernel at the moment,
as an alternative to unsubscribing all together (gasp!).  I will only see
your mail if you include 'time.c' somewhere in the subject.  Thanks.
 --Scott

[Oh -- and both Andre Balsa and I have been running versions of this patch
for about 2 months now, so it *should* be very stable.]
                                                         @ @
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-oOO-(_)-OOo-=-=-=-=-=
 C. Scott Ananian: cananian@lcs.mit.edu  /  Declare the Truth boldly and
 Laboratory for Computer Science/Crypto /       without hindrance.
 Massachusetts Institute of Technology /META-PARRESIAS AKOLUTOS:Acts 28:31
 -.-. .-.. .. ..-. ..-. --- .-. -..  ... -.-. --- - -  .- -. .- -. .. .- -.
 PGP key available via finger and from http://www.pdos.lcs.mit.edu/~cananian

diff -ruHp -X badboys linux-orig/arch/i386/kernel/time.c linux-2.1.103/arch/i386/kernel/time.c
--- linux-orig/arch/i386/kernel/time.c	Mon May 18 15:41:36 1998
+++ linux-2.1.103/arch/i386/kernel/time.c	Sun May 24 00:58:28 1998
@@ -45,67 +45,33 @@ extern volatile unsigned long lost_ticks
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY (1000020/HZ)
 
-#ifndef	CONFIG_APM	/* cycle counter may be unreliable */
-/* Cycle counter value at the previous timer interrupt.. */
+/* Cycle counter values */
 static struct {
 	unsigned long low;
 	unsigned long high;
-} init_timer_cc, last_timer_cc;
+} last_timer_cc;
+
+/* Cached *multiplier* to convert TSC counts to microseconds. */
+/* Equal to 2^32 * (1 / (clocks per usec) ).  Initialized in time_init. */
+static unsigned long fast_gettimeoffset_quotient=0;
+/* Allow us to fall back on slow method for a jiffy is TSC is trashed */
+static unsigned long stale_jiffies = 0;
+/* Export for external statistics */
+unsigned long tsc_counts_per_jiffy=0;
+
+/* Tell fast_gettimeoffset that the tsc is invalid.  Doesn't hurt even if
+ * the tsc is not present. */
+void invalidate_tsc(void) { stale_jiffies = jiffies; }
 
 static unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax asm("ax");
 	register unsigned long edx asm("dx");
-	unsigned long tmp, quotient, low_timer;
-
-	/* Last jiffy when do_fast_gettimeoffset() was called. */
-	static unsigned long last_jiffies=0;
-
-	/*
-	 * Cached "1/(clocks per usec)*2^32" value. 
-	 * It has to be recalculated once each jiffy.
-	 */
-	static unsigned long cached_quotient=0;
-
-	tmp = jiffies;
 
-	quotient = cached_quotient;
-	low_timer = last_timer_cc.low;
-
-	if (last_jiffies != tmp) {
-		last_jiffies = tmp;
-
-		/* Get last timer tick in absolute kernel time */
-		eax = low_timer;
-		edx = last_timer_cc.high;
-		__asm__("subl "SYMBOL_NAME_STR(init_timer_cc)",%0\n\t"
-			"sbbl "SYMBOL_NAME_STR(init_timer_cc)"+4,%1"
-			:"=a" (eax), "=d" (edx)
-			:"0" (eax), "1" (edx));
-
-		/*
-		 * Divide the 64-bit time with the 32-bit jiffy counter,
-		 * getting the quotient in clocks.
-		 *
-		 * Giving quotient = "1/(average internal clocks per usec)*2^32"
-		 * we do this '1/...' trick to get the 'mull' into the critical 
-		 * path. 'mull' is much faster than divl (10 vs. 41 clocks)
-		 */
-		__asm__("divl %2"
-			:"=a" (eax), "=d" (edx)
-			:"r" (tmp),
-			 "0" (eax), "1" (edx));
-
-		edx = USECS_PER_JIFFY;
-		tmp = eax;
-		eax = 0;
-
-		__asm__("divl %2"
-			:"=a" (eax), "=d" (edx)
-			:"r" (tmp),
-			 "0" (eax), "1" (edx));
-		cached_quotient = eax;
-		quotient = eax;
+	/* Check for a stale time stamp counter. */
+	if (jiffies == stale_jiffies) {
+		static unsigned long do_slow_gettimeoffset(void);
+		return do_slow_gettimeoffset(); /* use alternate */
 	}
 
 	/* Read the time counter */
@@ -113,15 +79,17 @@ static unsigned long do_fast_gettimeoffs
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	edx = 0;
-	eax -= low_timer;
+	eax -= last_timer_cc.low;
 
 	/*
-	 * Time offset = (USECS_PER_JIFFY * time_low) * quotient.
+	 * Time offset = time_low * fast_gettimeoffset_quotient.
+	 *             = time_low / (clocks_per_usec)
+	 *             = time_low / (clocks_per_jiffy / USECS_PER_JIFFY)
 	 */
 
 	__asm__("mull %2"
 		:"=a" (eax), "=d" (edx)
-		:"r" (quotient),
+		:"r" (fast_gettimeoffset_quotient),
 		 "0" (eax), "1" (edx));
 
 	/*
@@ -133,7 +101,6 @@ static unsigned long do_fast_gettimeoffs
 
 	return edx;
 }
-#endif
 
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
@@ -248,7 +215,6 @@ static unsigned long do_slow_gettimeoffs
 	return count;
 }
 
-#ifndef CONFIG_APM
 /*
  * this is only used if we have fast gettimeoffset:
  */
@@ -256,7 +222,6 @@ static void do_x86_get_fast_time(struct 
 {
 	do_gettimeofday(tv);
 }
-#endif
 
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
@@ -430,7 +395,6 @@ static inline void timer_interrupt(int i
 #endif
 }
 
-#ifndef	CONFIG_APM	/* cycle counter may be unreliable */
 /*
  * This is the same as the above, except we _also_ save the current
  * cycle counter value at the time of the timer interrupt, so that
@@ -444,7 +408,6 @@ static void pentium_timer_interrupt(int 
 		 "=d" (last_timer_cc.high));
 	timer_interrupt(irq, NULL, regs);
 }
-#endif
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
@@ -519,6 +482,70 @@ unsigned long get_cmos_time(void)
 
 static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
 
+/* ------ Calibrate the TSC. <cananian@alumni.princeton.edu> ------- */
+/* Return 2^32 * ( 1/(TSC clocks per usec) ) for do_fast_gettimeoffset */
+__initfunc(static unsigned long calibrate_tsc(void))
+{
+/* Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake I want to keep the overhead on the CTC busy loop
+ * as low as possible.
+ */
+#define READ_CTR0_STATUS \
+		"movb $0xE2, %%al\n\t" \
+		"outb %%al,  $0x43\n\t" /* Latch status of counter 0 */ \
+		"outb %%al,  $0x80\n\t" /* Slow down. */ \
+		"inb  $0x40, %%al\n\t" /* Read Status */ \
+		"outb %%al,  $0x80\n\t" /* Slow down. */ \
+		"testb $0x80,%%al\n\t" /* Test OUT signal level */
+
+	unsigned long retval;
+	__asm__(/* Wait for the CTC output to go low. */
+		"0: " READ_CTR0_STATUS
+		"jz 0b\n\t"
+		/* Now wait for it to return high. */
+		"1: " READ_CTR0_STATUS
+		"jnz 1b\n\t"
+		/* Read the TSC */
+		"wbinvd\n\t" /* FORCE SERIALIZATION (XXX) */
+		"rdtsc\n\t"
+		/* Move the value for safe-keeping. */
+		"movl %%eax, %%ebx\n\t"
+		"movl %%edx, %%ecx\n\t"
+		/* Now do it again: wait for CTC to go low, then high... */
+		"2:" READ_CTR0_STATUS
+		"jz 2b\n\t"
+		"3: " READ_CTR0_STATUS
+		"jnz 3b\n\t"
+		/* And read the TSC.  1 jiffy (10.002ms) has elapsed. */
+		"wbinvd\n\t" /* FORCE SERIALIZATION (XXX) */
+		"rdtsc\n\t"
+		/* Great.  So far so good.  Store last TSC reading in
+		 * last_timer_cc... */
+		"movl %%eax, last_timer_cc\n\t"
+		"movl %%edx, last_timer_cc+4\n\t"
+		/* And now calculate the difference between the readings. */
+		"subl %%ebx, %%eax\n\t"
+		"sbbl %%ecx, %%edx\n\t" /* 64-bit subtract */
+		/* Now we have TSC counts per jiffy in EDX:EAX.  We want
+		 * to calculate TSC->microsecond conversion factor. */
+		"movl %%eax, tsc_counts_per_jiffy\n\t" /* save this value */
+
+		/* Note that edx (high 32-bits of difference) will now be 
+		 * zero iff CPU clock speed is less than 429 GHz.  Moore's
+		 * law says that this is likely to be true for the next
+		 * 15 years or so.  You will have to change this code to
+		 * do a real 64-by-64 divide before that time's up. */
+		"movl %%eax, %%ecx\n\t"
+		"xorl %%eax, %%eax\n\t"
+		"movl %1, %%edx\n\t"
+		"divl %%ecx\n\t" /* eax= 2^32 / (TSC counts per microsecond) */
+                /* Return eax for the use of fast_gettimeoffset */
+		"movl %%eax, %0\n\t"
+		: "=r" (retval)
+		: "r" (USECS_PER_JIFFY)
+		: /* we clobber: */ "ax", "bx", "cx", "dx", "cc", "memory");
+	return retval;
+}
 
 __initfunc(void time_init(void))
 {
@@ -526,18 +553,22 @@ __initfunc(void time_init(void))
 	xtime.tv_usec = 0;
 
 /*
- * If we have APM enabled we can't currently depend
- * on the cycle counter, because a suspend to disk
- * will reset it. Somebody should come up with a
- * better solution than to just disable the fast time
- * code..
+ * If the CPU clock speed is variable (CPU stops clock on HLT or 
+ * slows clock to save power) then the TSC timings in 
+ * do_fast_gettimeoffset may diverge slightly from 'real time'
+ * but nothing will break. The TSC counter may even be reset 
+ * (as when APM suspends to disk) without breaking things:
+ * calls to invalidate_tsc() in the APM code let us fall back
+ * on do_slow_gettimeoffset in such cases.  
+ * See devices/char/apm_bios.c and arch/i386/kernel/process.c for
+ * exact details on when the tsc is invalidated.
  */
-#ifndef CONFIG_APM
 	/* If we have the CPU hardware time counters, use them */
 	if (boot_cpu_data.x86_capability & 16) {
 		do_gettimeoffset = do_fast_gettimeoffset;
 		do_get_fast_time = do_x86_get_fast_time;
 
+#if 0 /* I don't think this is necessary any more. */
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 		    boot_cpu_data.x86 == 5 &&
 		    boot_cpu_data.x86_model == 0) {
@@ -549,13 +580,11 @@ __initfunc(void time_init(void))
                                       : : : "ax", "cx", "dx" );
 				udelay(500);
 		}
+#endif
+		fast_gettimeoffset_quotient = calibrate_tsc();
 
-		/* read Pentium cycle counter */
-		__asm__("rdtsc"
-			:"=a" (init_timer_cc.low),
-			 "=d" (init_timer_cc.high));
 		irq0.handler = pentium_timer_interrupt;
 	}
-#endif
+
 	setup_x86_irq(0, &irq0);
 }
diff -ruHp -X badboys linux-orig/drivers/char/apm_bios.c linux-2.1.103/drivers/char/apm_bios.c
--- linux-orig/drivers/char/apm_bios.c	Wed May  6 13:56:03 1998
+++ linux-2.1.103/drivers/char/apm_bios.c	Sun May 24 00:02:56 1998
@@ -98,6 +98,7 @@ EXPORT_SYMBOL(apm_register_callback);
 EXPORT_SYMBOL(apm_unregister_callback);
 
 extern unsigned long get_cmos_time(void);
+extern void invalidate_tsc(void);
 
 /*
  * The apm_bios device is one of the misc char devices.
@@ -695,7 +696,8 @@ static void suspend(void)
 	err = apm_set_power_state(APM_STATE_SUSPEND);
 	if (err)
 		apm_error("suspend", err);
-	set_time();
+	invalidate_tsc(); /* processor clock may have slowed or stopped */
+	set_time(); /* and we may have lost timer interrupts. */
 }
 
 static void standby(void)
@@ -705,6 +707,7 @@ static void standby(void)
 	err = apm_set_power_state(APM_STATE_STANDBY);
 	if (err)
 		apm_error("standby", err);
+	invalidate_tsc(); /* clock may have slowed or stopped */
 }
 
 static apm_event_t get_event(void)
@@ -856,6 +859,7 @@ int apm_do_idle(void)
 		return 0;
 
 	clock_slowed = (apm_bios_info.flags & APM_IDLE_SLOWS_CLOCK) != 0;
+	if (clock_slowed) invalidate_tsc(); /* time stamp counter slowed */
 	return 1;
 #else
 	return 0;
diff -ruHp -X badboys linux-orig/arch/i386/kernel/irq.c linux-2.1.103/arch/i386/kernel/irq.c
--- linux-orig/arch/i386/kernel/irq.c	Wed May 20 15:11:55 1998
+++ linux-2.1.103/arch/i386/kernel/irq.c	Sat May 23 04:11:23 1998
@@ -1235,6 +1235,7 @@ __initfunc(void init_IRQ(void))
 {
 	int i;
 
+	/* This sets up the 82c54 timer chip, which generates our jiffies. */
 	/* set the clock to 100 Hz */
 	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
 	outb_p(LATCH & 0xff , 0x40);	/* LSB */
diff -ruHp -X badboys linux-orig/arch/i386/kernel/process.c linux-2.1.103/arch/i386/kernel/process.c
--- linux-orig/arch/i386/kernel/process.c	Tue May 19 12:46:39 1998
+++ linux-2.1.103/arch/i386/kernel/process.c	Sun May 24 00:04:49 1998
@@ -92,6 +92,12 @@ static void hard_idle(void)
 #else
 			__asm__("hlt");
 #endif
+			/* XXX CPUs that slow/stop the processor clock on
+			 * hlt need a call to invalidate_tsc() in time.c
+			 * here.  Can't do this until the appropriate
+			 * features field is added to the CPU info 
+			 * structure.
+			 */
 	        }
  		if (need_resched) 
  			break;
diff -ruHp -X badboys linux-orig/arch/i386/kernel/setup.c linux-2.1.103/arch/i386/kernel/setup.c
--- linux-orig/arch/i386/kernel/setup.c	Wed May 13 14:47:26 1998
+++ linux-2.1.103/arch/i386/kernel/setup.c	Sun May 24 00:13:13 1998
@@ -464,6 +464,13 @@ int get_cpuinfo(char * buffer)
 			       c->x86 + '0',
 			       c->x86_model_id[0] ? c->x86_model_id : "unknown",
 			       c->x86_vendor_id[0] ? c->x86_vendor_id : "unknown");
+		/* We only time the first CPU at the moment. For SMP we
+		 * assume they're all the same... (it is *S*MP, after all) */
+		if (c->x86_capability & 16) { /* TSC capability */
+			extern unsigned long tsc_counts_per_jiffy; /* time.c */
+			p+=sprintf(p, "clock_rate\t: %d MHz\n",
+				   tsc_counts_per_jiffy/(1000*1000/HZ));
+		}
 		if (c->x86_mask) {
 			if (c->x86_vendor == X86_VENDOR_CYRIX)
 				p += sprintf(p, "stepping\t: %d rev %d\n",


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
