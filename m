Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWJSPT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWJSPT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJSPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:19:54 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:64270 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161456AbWJSPTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:19:47 -0400
Date: Thu, 19 Oct 2006 17:19:13 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3] Remove time-interpolators
In-Reply-To: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610191716130.1920@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_TIME_INTERPOLATION - never set either.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

Signed-off-by: G. Liakhovetski <gl@dsa-ac.de>

diff --exclude=CVS -ur linux-2.6.18-rt6/arch/ia64/kernel/asm-offsets.c linux-2.6.18-rt6-rmdead/arch/ia64/kernel/asm-offsets.c
--- linux-2.6.18-rt6/arch/ia64/kernel/asm-offsets.c	2006-10-19 15:52:47.662033868 +0200
+++ linux-2.6.18-rt6-rmdead/arch/ia64/kernel/asm-offsets.c	2006-10-19 15:57:26.945526349 +0200
@@ -254,14 +254,4 @@
  	DEFINE(IA64_PMSA_XIP_OFFSET,
  	       offsetof (struct pal_min_state_area_s, pmsa_xip));
  	BLANK();
-
-#ifdef CONFIG_TIME_INTERPOLATION
-	/* used by fsys_gettimeofday in arch/ia64/kernel/fsys.S */
-	DEFINE(IA64_TIMESPEC_TV_NSEC_OFFSET, offsetof (struct timespec, tv_nsec));
-	DEFINE(IA64_CLOCKSOURCE_MASK_OFFSET, offsetof (struct clocksource, mask));
-	DEFINE(IA64_CLOCKSOURCE_MULT_OFFSET, offsetof (struct clocksource, mult));
-	DEFINE(IA64_CLOCKSOURCE_SHIFT_OFFSET, offsetof (struct clocksource, shift));
-	DEFINE(IA64_CLOCKSOURCE_MMIO_PTR_OFFSET, offsetof (struct clocksource, fsys_mmio_ptr));
-	DEFINE(IA64_CLOCKSOURCE_CYCLE_LAST_OFFSET, offsetof (struct clocksource, cycle_last));
-#endif
  }
diff --exclude=CVS -ur linux-2.6.18-rt6/arch/ia64/kernel/fsys.S linux-2.6.18-rt6-rmdead/arch/ia64/kernel/fsys.S
--- linux-2.6.18-rt6/arch/ia64/kernel/fsys.S	2006-10-19 15:52:47.664033434 +0200
+++ linux-2.6.18-rt6-rmdead/arch/ia64/kernel/fsys.S	2006-10-19 15:59:09.069399735 +0200
@@ -24,319 +24,6 @@

  #include "entry.h"

-#ifdef CONFIG_TIME_INTERPOLATION
-/*
- * See Documentation/ia64/fsys.txt for details on fsyscalls.
- *
- * On entry to an fsyscall handler:
- *   r10	= 0 (i.e., defaults to "successful syscall return")
- *   r11	= saved ar.pfs (a user-level value)
- *   r15	= system call number
- *   r16	= "current" task pointer (in normal kernel-mode, this is in r13)
- *   r32-r39	= system call arguments
- *   b6		= return address (a user-level value)
- *   ar.pfs	= previous frame-state (a user-level value)
- *   PSR.be	= cleared to zero (i.e., little-endian byte order is in effect)
- *   all other registers may contain values passed in from user-mode
- *
- * On return from an fsyscall handler:
- *   r11	= saved ar.pfs (as passed into the fsyscall handler)
- *   r15	= system call number (as passed into the fsyscall handler)
- *   r32-r39	= system call arguments (as passed into the fsyscall handler)
- *   b6		= return address (as passed into the fsyscall handler)
- *   ar.pfs	= previous frame-state (as passed into the fsyscall handler)
- */
-
-ENTRY(fsys_ni_syscall)
-	.prologue
-	.altrp b6
-	.body
-	mov r8=ENOSYS
-	mov r10=-1
-	FSYS_RETURN
-END(fsys_ni_syscall)
-
-ENTRY(fsys_getpid)
-	.prologue
-	.altrp b6
-	.body
-	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
-	;;
-	ld4 r9=[r9]
-	add r8=IA64_TASK_TGID_OFFSET,r16
-	;;
-	and r9=TIF_ALLWORK_MASK,r9
-	ld4 r8=[r8]				// r8 = current->tgid
-	;;
-	cmp.ne p8,p0=0,r9
-(p8)	br.spnt.many fsys_fallback_syscall
-	FSYS_RETURN
-END(fsys_getpid)
-
-ENTRY(fsys_getppid)
-	.prologue
-	.altrp b6
-	.body
-	add r17=IA64_TASK_GROUP_LEADER_OFFSET,r16
-	;;
-	ld8 r17=[r17]				// r17 = current->group_leader
-	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
-	;;
-
-	ld4 r9=[r9]
-	add r17=IA64_TASK_REAL_PARENT_OFFSET,r17 // r17 = &current->group_leader->real_parent
-	;;
-	and r9=TIF_ALLWORK_MASK,r9
-
-1:	ld8 r18=[r17]				// r18 = current->group_leader->real_parent
-	;;
-	cmp.ne p8,p0=0,r9
-	add r8=IA64_TASK_TGID_OFFSET,r18	// r8 = &current->group_leader->real_parent->tgid
-	;;
-
-	/*
-	 * The .acq is needed to ensure that the read of tgid has returned its data before
-	 * we re-check "real_parent".
-	 */
-	ld4.acq r8=[r8]				// r8 = current->group_leader->real_parent->tgid
-#ifdef CONFIG_SMP
-	/*
-	 * Re-read current->group_leader->real_parent.
-	 */
-	ld8 r19=[r17]				// r19 = current->group_leader->real_parent
-(p8)	br.spnt.many fsys_fallback_syscall
-	;;
-	cmp.ne p6,p0=r18,r19			// did real_parent change?
-	mov r19=0			// i must not leak kernel bits...
-(p6)	br.cond.spnt.few 1b			// yes -> redo the read of tgid and the check
-	;;
-	mov r17=0			// i must not leak kernel bits...
-	mov r18=0			// i must not leak kernel bits...
-#else
-	mov r17=0			// i must not leak kernel bits...
-	mov r18=0			// i must not leak kernel bits...
-	mov r19=0			// i must not leak kernel bits...
-#endif
-	FSYS_RETURN
-END(fsys_getppid)
-
-ENTRY(fsys_set_tid_address)
-	.prologue
-	.altrp b6
-	.body
-	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
-	;;
-	ld4 r9=[r9]
-	tnat.z p6,p7=r32		// check argument register for being NaT
-	;;
-	and r9=TIF_ALLWORK_MASK,r9
-	add r8=IA64_TASK_PID_OFFSET,r16
-	add r18=IA64_TASK_CLEAR_CHILD_TID_OFFSET,r16
-	;;
-	ld4 r8=[r8]
-	cmp.ne p8,p0=0,r9
-	mov r17=-1
-	;;
-(p6)	st8 [r18]=r32
-(p7)	st8 [r18]=r17
-(p8)	br.spnt.many fsys_fallback_syscall
-	;;
-	mov r17=0			// i must not leak kernel bits...
-	mov r18=0			// i must not leak kernel bits...
-	FSYS_RETURN
-END(fsys_set_tid_address)
-
-#define CLOCK_REALTIME 0
-#define CLOCK_MONOTONIC 1
-#define CLOCK_DIVIDE_BY_1000 0x4000
-#define CLOCK_ADD_MONOTONIC 0x8000
-
-ENTRY(fsys_gettimeofday)
-	.prologue
-	.altrp b6
-	.body
-	mov r31 = r32
-	tnat.nz p6,p0 = r33		// guard against NaT argument
-(p6)    br.cond.spnt.few .fail_einval
-	mov r30 = CLOCK_DIVIDE_BY_1000
-	;;
-.gettime:
-	// Register map
-	// Incoming r31 = pointer to address where to place result
-	//          r30 = flags determining how time is processed
-	// r2,r3 = temp r4-r7 preserved
-	// r8 = result nanoseconds
-	// r9 = result seconds
-	// r10 = temporary storage for clock difference
-	// r11 = preserved: saved ar.pfs
-	// r12 = preserved: memory stack
-	// r13 = preserved: thread pointer
-	// r14 = address of mask / mask value
-	// r15 = preserved: system call number
-	// r16 = preserved: current task pointer
-	// r17 = wall to monotonic use
-	// r19 = address of itc_lastcycle
-	// r20 = struct clocksource / address of first element
-	// r21 = shift value
-	// r22 = address of itc_jitter/ wall_to_monotonic
-	// r23 = address of shift
-	// r24 = address mult factor / cycle_last value
-	// r25 = itc_lastcycle value
-	// r26 = address clocksource cycle_last
-	// r27 = pointer to xtime
-	// r28 = sequence number at the beginning of critcal section
-	// r29 = address of seqlock
-	// r30 = time processing flags / memory address
-	// r31 = pointer to result
-	// Predicates
-	// p6,p7 short term use
-	// p8 = timesource ar.itc
-	// p9 = timesource mmio64
-	// p10 = timesource mmio32 - not used
-	// p11 = timesource not to be handled by asm code
-	// p12 = memory time source ( = p9 | p10) - not used
-	// p13 = do cmpxchg with time_interpolator_last_cycle
-	// p14 = Divide by 1000
-	// p15 = Add monotonic
-	//
-	// Note that instructions are optimized for McKinley. McKinley can process two
-	// bundles simultaneously and therefore we continuously try to feed the CPU
-	// two bundles and then a stop.
-	tnat.nz p6,p0 = r31	// branch deferred since it does not fit into bundle structure
-	mov pr = r30,0xc000	// Set predicates according to function
-	add r2 = TI_FLAGS+IA64_TASK_SIZE,r16
-	movl r20 = fsyscall_clock // load fsyscall clocksource address
-	;;
-	add r10 = IA64_CLOCKSOURCE_MMIO_PTR_OFFSET,r20
-	movl r29 = xtime_lock
-	ld4 r2 = [r2]		// process work pending flags
-	movl r27 = xtime
-	;;	// only one bundle here
-	add r14 = IA64_CLOCKSOURCE_MASK_OFFSET,r20
-	movl r22 = itc_jitter
-	add r24 = IA64_CLOCKSOURCE_MULT_OFFSET,r20
-	and r2 = TIF_ALLWORK_MASK,r2
-(p6)    br.cond.spnt.few .fail_einval	// deferred branch
-	;;
-	ld8 r30 = [r10]		// clocksource->mmio_ptr
-	movl r19 = itc_lastcycle
-	add r23 = IA64_CLOCKSOURCE_SHIFT_OFFSET,r20
-	cmp.ne p6, p0 = 0, r2	// Fallback if work is scheduled
-(p6)    br.cond.spnt.many fsys_fallback_syscall
-	;;
-	ld8 r14 = [r14]         // clocksource mask value
-	ld4 r2 = [r22]		// itc_jitter value
-	add r26 = IA64_CLOCKSOURCE_CYCLE_LAST_OFFSET,r20 // clock fsyscall_cycle_last
-	ld4 r3 = [r24]		// clocksource->mult value
-	cmp.eq p8,p9 = 0,r30	// Check for cpu timer, no mmio_ptr, set p8, clear p9
-	;;
-	setf.sig f7 = r3	// Setup for mult scaling of counter
-(p15)	movl r22 = wall_to_monotonic
-	ld4 r21 = [r23]		// shift value
-(p8)	cmp.ne p13,p0 = r2,r0	// need jitter compensation, set p13
-(p9)	cmp.eq p13,p0 = 0,r30	// if mmio_ptr, clear p13 jitter control
-	;;
-.time_redo:
-	.pred.rel.mutex p8,p9,p10
-	ld4.acq r28 = [r29]	// xtime_lock.sequence. Must come first for locking purposes
-(p8)	mov r2 = ar.itc		// CPU_TIMER. 36 clocks latency!!!
-(p9)	ld8 r2 = [r30]		// readq(ti->address). Could also have latency issues..
-(p13)	ld8 r25 = [r19]		// get itc_lastcycle value
-	;;			// could be removed by moving the last add upward
- 	ld8 r9 = [r27],IA64_TIMESPEC_TV_NSEC_OFFSET
-	ld8 r24 = [r26]		// get fsyscall_cycle_last value
-(p15)	ld8 r17 = [r22],IA64_TIMESPEC_TV_NSEC_OFFSET
-	;;
-	ld8 r8 = [r27],-IA64_TIMESPEC_TV_NSEC_OFFSET	// xtime.tv_nsec
-(p13)	sub r3 = r25,r2		// Diff needed before comparison (thanks davidm)
-	;;
-(p13)	cmp.gt.unc p6,p7 = r3,r0 // check if it is less than last. p6,p7 cleared
-	sub r10 = r2,r24	// current_counter - last_counter
-	;;
-(p6)	sub r10 = r25,r24	// time we got was less than last_cycle
-(p7)	mov ar.ccv = r25	// more than last_cycle. Prep for cmpxchg
-	;;
-	and r10 = r10,r14	// Apply mask
-	;;
-	setf.sig f8 = r10
-	nop.i 123
-	;;
-(p7)	cmpxchg8.rel r3 = [r19],r2,ar.ccv
-EX(.fail_efault, probe.w.fault r31, 3)	// This takes 5 cycles and we have spare time
-	xmpy.l f8 = f8,f7	// nsec_per_cyc*(counter-last_counter)
-(p15)	add r9 = r9,r17		// Add wall to monotonic.secs to result secs
-	;;
-(p15)	ld8 r17 = [r22],-IA64_TIMESPEC_TV_NSEC_OFFSET
-(p7)	cmp.ne p7,p0 = r25,r3	// if cmpxchg not successful redo
-	// simulate tbit.nz.or p7,p0 = r28,0
-	and r28 = ~1,r28	// Make sequence even to force retry if odd
-	getf.sig r2 = f8
-	mf
-	;;
-	ld4 r10 = [r29]		// xtime_lock.sequence
-(p15)	add r8 = r8, r17	// Add monotonic.nsecs to nsecs
-	shr.u r2 = r2,r21	// shift by factor
-	;;		// overloaded 3 bundles!
-	// End critical section.
-	add r8 = r8,r2		// Add xtime.nsecs
-	cmp4.ne.or p7,p0 = r28,r10
-(p7)	br.cond.dpnt.few .time_redo	// sequence number changed ?
-	// Now r8=tv->tv_nsec and r9=tv->tv_sec
-	mov r10 = r0
-	movl r2 = 1000000000
-	add r23 = IA64_TIMESPEC_TV_NSEC_OFFSET, r31
-(p14)	movl r3 = 2361183241434822607	// Prep for / 1000 hack
-	;;
-.time_normalize:
-	mov r21 = r8
-	cmp.ge p6,p0 = r8,r2
-(p14)	shr.u r20 = r8, 3		// We can repeat this if necessary just wasting some time
-	;;
-(p14)	setf.sig f8 = r20
-(p6)	sub r8 = r8,r2
-(p6)	add r9 = 1,r9			// two nops before the branch.
-(p14)	setf.sig f7 = r3		// Chances for repeats are 1 in 10000 for gettod
-(p6)	br.cond.dpnt.few .time_normalize
-	;;
-	// Divided by 8 though shift. Now divide by 125
-	// The compiler was able to do that with a multiply
-	// and a shift and we do the same
-EX(.fail_efault, probe.w.fault r23, 3)		// This also costs 5 cycles
-(p14)	xmpy.hu f8 = f8, f7			// xmpy has 5 cycles latency so use it...
-	;;
-	mov r8 = r0
-(p14)	getf.sig r2 = f8
-	;;
-(p14)	shr.u r21 = r2, 4
-	;;
-EX(.fail_efault, st8 [r31] = r9)
-EX(.fail_efault, st8 [r23] = r21)
-	FSYS_RETURN
-.fail_einval:
-	mov r8 = EINVAL
-	mov r10 = -1
-	FSYS_RETURN
-.fail_efault:
-	mov r8 = EFAULT
-	mov r10 = -1
-	FSYS_RETURN
-END(fsys_gettimeofday)
-
-ENTRY(fsys_clock_gettime)
-	.prologue
-	.altrp b6
-	.body
-	cmp4.ltu p6, p0 = CLOCK_MONOTONIC, r32
-	// Fallback if this is not CLOCK_REALTIME or CLOCK_MONOTONIC
-(p6)	br.spnt.few fsys_fallback_syscall
-	mov r31 = r33
-	shl r30 = r32,15
-	br.many .gettime
-END(fsys_clock_gettime)
-
-
-#else // !CONFIG_TIME_INTERPOLATION
-
  # define fsys_gettimeofday 0
  # define fsys_clock_gettime 0

@@ -350,9 +37,6 @@
  	mov r10 = -1
  	FSYS_RETURN

-#endif
-
-

  /*
   * long fsys_rt_sigprocmask (int how, sigset_t *set, sigset_t *oset, size_t sigsetsize).
diff --exclude=CVS -ur linux-2.6.18-rt6/arch/ia64/kernel/time.c linux-2.6.18-rt6-rmdead/arch/ia64/kernel/time.c
--- linux-2.6.18-rt6/arch/ia64/kernel/time.c	2006-10-19 15:52:47.675031052 +0200
+++ linux-2.6.18-rt6-rmdead/arch/ia64/kernel/time.c	2006-10-19 15:59:33.462114604 +0200
@@ -235,24 +235,6 @@
  	local_cpu_data->nsec_per_cyc = ((NSEC_PER_SEC<<IA64_NSEC_PER_CYC_SHIFT)
  					+ itc_freq/2)/itc_freq;

-#ifdef CONFIG_TIME_INTERPOLATION
-	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
-#ifdef CONFIG_SMP
-		/* On IA64 in an SMP configuration ITCs are never accurately synchronized.
-		 * Jitter compensation requires a cmpxchg which may limit
-		 * the scalability of the syscalls for retrieving time.
-		 * The ITC synchronization is usually successful to within a few
-		 * ITC ticks but this is not a sure thing. If you need to improve
-		 * timer performance in SMP situations then boot the kernel with the
-		 * "nojitter" option. However, doing so may result in time fluctuating (maybe
-		 * even going backward) if the ITC offsets between the individual CPUs
-		 * are too large.
-		 */
-		if (!nojitter) itc_jitter = 1;
-#endif
-	}
-#endif
-
  	/* Setup the CPU local timer tick */
  	ia64_cpu_local_tick();

diff --exclude=CVS -ur linux-2.6.18-rt6/include/linux/timex.h linux-2.6.18-rt6-rmdead/include/linux/timex.h
--- linux-2.6.18-rt6/include/linux/timex.h	2006-10-19 15:52:47.893983617 +0200
+++ linux-2.6.18-rt6-rmdead/include/linux/timex.h	2006-10-19 16:05:14.451270841 +0200
@@ -224,66 +224,6 @@
  	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
  })

-
-#ifdef CONFIG_TIME_INTERPOLATION
-
-#define TIME_SOURCE_CPU 0
-#define TIME_SOURCE_MMIO64 1
-#define TIME_SOURCE_MMIO32 2
-#define TIME_SOURCE_FUNCTION 3
-
-/* For proper operations time_interpolator clocks must run slightly slower
- * than the standard clock since the interpolator may only correct by having
- * time jump forward during a tick. A slower clock is usually a side effect
- * of the integer divide of the nanoseconds in a second by the frequency.
- * The accuracy of the division can be increased by specifying a shift.
- * However, this may cause the clock not to be slow enough.
- * The interpolator will self-tune the clock by slowing down if no
- * resets occur or speeding up if the time jumps per analysis cycle
- * become too high.
- *
- * Setting jitter compensates for a fluctuating timesource by comparing
- * to the last value read from the timesource to insure that an earlier value
- * is not returned by a later call. The price to pay
- * for the compensation is that the timer routines are not as scalable anymore.
- */
-
-struct time_interpolator {
-	u16 source;			/* time source flags */
-	u8 shift;			/* increases accuracy of multiply by shifting. */
-				/* Note that bits may be lost if shift is set too high */
-	u8 jitter;			/* if set compensate for fluctuations */
-	u32 nsec_per_cyc;		/* set by register_time_interpolator() */
-	void *addr;			/* address of counter or function */
-	u64 mask;			/* mask the valid bits of the counter */
-	unsigned long offset;		/* nsec offset at last update of interpolator */
-	u64 last_counter;		/* counter value in units of the counter at last update */
-	u64 last_cycle;			/* Last timer value if TIME_SOURCE_JITTER is set */
-	u64 frequency;			/* frequency in counts/second */
-	long drift;			/* drift in parts-per-million (or -1) */
-	unsigned long skips;		/* skips forward */
-	unsigned long ns_skipped;	/* nanoseconds skipped */
-	struct time_interpolator *next;
-};
-
-extern void register_time_interpolator(struct time_interpolator *);
-extern void unregister_time_interpolator(struct time_interpolator *);
-extern void time_interpolator_reset(void);
-extern unsigned long time_interpolator_get_offset(void);
-extern void time_interpolator_update(long delta_nsec);
-
-#else /* !CONFIG_TIME_INTERPOLATION */
-
-static inline void time_interpolator_reset(void)
-{
-}
-
-static inline void time_interpolator_update(long delta_nsec)
-{
-}
-
-#endif /* !CONFIG_TIME_INTERPOLATION */
-
  #define TICK_LENGTH_SHIFT	32

  /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
diff --exclude=CVS -ur linux-2.6.18-rt6/kernel/time/ntp.c linux-2.6.18-rt6-rmdead/kernel/time/ntp.c
--- linux-2.6.18-rt6/kernel/time/ntp.c	2006-10-19 15:52:47.947971921 +0200
+++ linux-2.6.18-rt6-rmdead/kernel/time/ntp.c	2006-10-19 16:06:20.080065993 +0200
@@ -110,11 +110,6 @@
  		if (xtime.tv_sec % 86400 == 0) {
  			xtime.tv_sec--;
  			wall_to_monotonic.tv_sec++;
-			/*
-			 * The timer interpolator will make time change
-			 * gradually instead of an immediate jump by one second
-			 */
-			time_interpolator_update(-NSEC_PER_SEC);
  			time_state = TIME_OOP;
  			clock_was_set();
  			printk(KERN_NOTICE "Clock: inserting leap second "
@@ -125,11 +120,6 @@
  		if ((xtime.tv_sec + 1) % 86400 == 0) {
  			xtime.tv_sec++;
  			wall_to_monotonic.tv_sec--;
-			/*
-			 * Use of time interpolator for a gradual change of
-			 * time
-			 */
-			time_interpolator_update(NSEC_PER_SEC);
  			time_state = TIME_WAIT;
  			clock_was_set();
  			printk(KERN_NOTICE "Clock: deleting leap second "
diff --exclude=CVS -ur linux-2.6.18-rt6/kernel/time.c linux-2.6.18-rt6-rmdead/kernel/time.c
--- linux-2.6.18-rt6/kernel/time.c	2006-10-19 15:52:47.945972354 +0200
+++ linux-2.6.18-rt6-rmdead/kernel/time.c	2006-10-19 16:06:47.833058925 +0200
@@ -134,7 +134,6 @@
  	write_seqlock_irq(&xtime_lock);
  	wall_to_monotonic.tv_sec -= sys_tz.tz_minuteswest * 60;
  	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
-	time_interpolator_reset();
  	warp_check_clock_was_changed();
  	write_sequnlock_irq(&xtime_lock);
  	clock_was_set();
@@ -277,81 +276,6 @@
  	return t;
  }
  EXPORT_SYMBOL(timespec_trunc);
-
-#ifdef CONFIG_TIME_INTERPOLATION
-void getnstimeofday (struct timespec *tv)
-{
-	unsigned long seq,sec,nsec;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		sec = xtime.tv_sec;
-		nsec = xtime.tv_nsec+time_interpolator_get_offset();
-	} while (unlikely(read_seqretry(&xtime_lock, seq)));
-
-	while (unlikely(nsec >= NSEC_PER_SEC)) {
-		nsec -= NSEC_PER_SEC;
-		++sec;
-	}
-	tv->tv_sec = sec;
-	tv->tv_nsec = nsec;
-}
-EXPORT_SYMBOL_GPL(getnstimeofday);
-
-int do_settimeofday (struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	{
-		wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-		wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-		set_normalized_timespec(&xtime, sec, nsec);
-		set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-		time_adjust = 0;		/* stop active adjtime() */
-		time_status |= STA_UNSYNC;
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_esterror = NTP_PHASE_LIMIT;
-		time_interpolator_reset();
-	}
-	warp_check_clock_was_changed();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-EXPORT_SYMBOL(do_settimeofday);
-
-void do_gettimeofday (struct timeval *tv)
-{
-	unsigned long seq, nsec, usec, sec, offset;
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		offset = time_interpolator_get_offset();
-		sec = xtime.tv_sec;
-		nsec = xtime.tv_nsec;
-	} while (unlikely(read_seqretry(&xtime_lock, seq)));
-
-	usec = (nsec + offset) / 1000;
-
-	while (unlikely(usec >= USEC_PER_SEC)) {
-		usec -= USEC_PER_SEC;
-		++sec;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-
-#else
  #ifndef CONFIG_GENERIC_TIME
  /*
   * Simulate gettimeofday using do_gettimeofday which only allows a timeval
@@ -367,7 +291,6 @@
  }
  EXPORT_SYMBOL_GPL(getnstimeofday);
  #endif
-#endif

  /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
   * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
diff --exclude=CVS -ur linux-2.6.18-rt6/kernel/timer.c linux-2.6.18-rt6-rmdead/kernel/timer.c
--- linux-2.6.18-rt6/kernel/timer.c	2006-10-19 15:52:47.950971271 +0200
+++ linux-2.6.18-rt6-rmdead/kernel/timer.c	2006-10-19 16:06:55.523394356 +0200
@@ -1145,10 +1145,6 @@
  			second_overflow();
  		}

-		/* interpolator bits */
-		time_interpolator_update((clock->xtime_interval
-						>> clock->shift)<<shift);
-
  		/* accumulate error between NTP and clock interval */
  		clock->error += current_tick_length() << shift;
  		clock->error -= (clock->xtime_interval
@@ -1736,194 +1732,6 @@
  	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
  }

-#ifdef CONFIG_TIME_INTERPOLATION
-
-struct time_interpolator *time_interpolator __read_mostly;
-static struct time_interpolator *time_interpolator_list __read_mostly;
-static DEFINE_SPINLOCK(time_interpolator_lock);
-
-static inline u64 time_interpolator_get_cycles(unsigned int src)
-{
-	unsigned long (*x)(void);
-
-	switch (src)
-	{
-		case TIME_SOURCE_FUNCTION:
-			x = time_interpolator->addr;
-			return x();
-
-		case TIME_SOURCE_MMIO64	:
-			return readq_relaxed((void __iomem *)time_interpolator->addr);
-
-		case TIME_SOURCE_MMIO32	:
-			return readl_relaxed((void __iomem *)time_interpolator->addr);
-
-		default: return get_cycles();
-	}
-}
-
-static inline u64 time_interpolator_get_counter(int writelock)
-{
-	unsigned int src = time_interpolator->source;
-
-	if (time_interpolator->jitter)
-	{
-		u64 lcycle;
-		u64 now;
-
-		do {
-			lcycle = time_interpolator->last_cycle;
-			now = time_interpolator_get_cycles(src);
-			if (lcycle && time_after(lcycle, now))
-				return lcycle;
-
-			/* When holding the xtime write lock, there's no need
-			 * to add the overhead of the cmpxchg.  Readers are
-			 * force to retry until the write lock is released.
-			 */
-			if (writelock) {
-				time_interpolator->last_cycle = now;
-				return now;
-			}
-			/* Keep track of the last timer value returned. The use of cmpxchg here
-			 * will cause contention in an SMP environment.
-			 */
-		} while (unlikely(cmpxchg(&time_interpolator->last_cycle, lcycle, now) != lcycle));
-		return now;
-	}
-	else
-		return time_interpolator_get_cycles(src);
-}
-
-void time_interpolator_reset(void)
-{
-	time_interpolator->offset = 0;
-	time_interpolator->last_counter = time_interpolator_get_counter(1);
-}
-
-#define GET_TI_NSECS(count,i) (((((count) - i->last_counter) & (i)->mask) * (i)->nsec_per_cyc) >> (i)->shift)
-
-unsigned long time_interpolator_get_offset(void)
-{
-	/* If we do not have a time interpolator set up then just return zero */
-	if (!time_interpolator)
-		return 0;
-
-	return time_interpolator->offset +
-		GET_TI_NSECS(time_interpolator_get_counter(0), time_interpolator);
-}
-
-#define INTERPOLATOR_ADJUST 65536
-#define INTERPOLATOR_MAX_SKIP 10*INTERPOLATOR_ADJUST
-
-void time_interpolator_update(long delta_nsec)
-{
-	u64 counter;
-	unsigned long offset;
-
-	/* If there is no time interpolator set up then do nothing */
-	if (!time_interpolator)
-		return;
-
-	/*
-	 * The interpolator compensates for late ticks by accumulating the late
-	 * time in time_interpolator->offset. A tick earlier than expected will
-	 * lead to a reset of the offset and a corresponding jump of the clock
-	 * forward. Again this only works if the interpolator clock is running
-	 * slightly slower than the regular clock and the tuning logic insures
-	 * that.
-	 */
-
-	counter = time_interpolator_get_counter(1);
-	offset = time_interpolator->offset +
-			GET_TI_NSECS(counter, time_interpolator);
-
-	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)
-		time_interpolator->offset = offset - delta_nsec;
-	else {
-		time_interpolator->skips++;
-		time_interpolator->ns_skipped += delta_nsec - offset;
-		time_interpolator->offset = 0;
-	}
-	time_interpolator->last_counter = counter;
-
-	/* Tuning logic for time interpolator invoked every minute or so.
-	 * Decrease interpolator clock speed if no skips occurred and an offset is carried.
-	 * Increase interpolator clock speed if we skip too much time.
-	 */
-	if (jiffies % INTERPOLATOR_ADJUST == 0)
-	{
-		if (time_interpolator->skips == 0 && time_interpolator->offset > tick_nsec)
-			time_interpolator->nsec_per_cyc--;
-		if (time_interpolator->ns_skipped > INTERPOLATOR_MAX_SKIP && time_interpolator->offset == 0)
-			time_interpolator->nsec_per_cyc++;
-		time_interpolator->skips = 0;
-		time_interpolator->ns_skipped = 0;
-	}
-}
-
-static inline int
-is_better_time_interpolator(struct time_interpolator *new)
-{
-	if (!time_interpolator)
-		return 1;
-	return new->frequency > 2*time_interpolator->frequency ||
-	    (unsigned long)new->drift < (unsigned long)time_interpolator->drift;
-}
-
-void
-register_time_interpolator(struct time_interpolator *ti)
-{
-	unsigned long flags;
-
-	/* Sanity check */
-	BUG_ON(ti->frequency == 0 || ti->mask == 0);
-
-	ti->nsec_per_cyc = ((u64)NSEC_PER_SEC << ti->shift) / ti->frequency;
-	spin_lock(&time_interpolator_lock);
-	write_seqlock_irqsave(&xtime_lock, flags);
-	if (is_better_time_interpolator(ti)) {
-		time_interpolator = ti;
-		time_interpolator_reset();
-	}
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	ti->next = time_interpolator_list;
-	time_interpolator_list = ti;
-	spin_unlock(&time_interpolator_lock);
-}
-
-void
-unregister_time_interpolator(struct time_interpolator *ti)
-{
-	struct time_interpolator *curr, **prev;
-	unsigned long flags;
-
-	spin_lock(&time_interpolator_lock);
-	prev = &time_interpolator_list;
-	for (curr = *prev; curr; curr = curr->next) {
-		if (curr == ti) {
-			*prev = curr->next;
-			break;
-		}
-		prev = &curr->next;
-	}
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	if (ti == time_interpolator) {
-		/* we lost the best time-interpolator: */
-		time_interpolator = NULL;
-		/* find the next-best interpolator */
-		for (curr = time_interpolator_list; curr; curr = curr->next)
-			if (is_better_time_interpolator(curr))
-				time_interpolator = curr;
-		time_interpolator_reset();
-	}
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-	spin_unlock(&time_interpolator_lock);
-}
-#endif /* CONFIG_TIME_INTERPOLATION */
-
  /**
   * msleep - sleep safely even with waitqueue interruptions
   * @msecs: Time in milliseconds to sleep for
