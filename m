Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971784-26836>; Mon, 13 Jul 1998 09:43:28 -0400
Received: from eagle1a.raptor.com ([209.48.140.11]:50042 "HELO eagle-140.raptor.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <971914-26836>; Mon, 13 Jul 1998 09:41:38 -0400
Message-ID: <35AA1F4F.A4840FDA@raptor.com>
Date: Mon, 13 Jul 1998 10:53:03 -0400
From: Philip Gladstone <philip@raptor.com>
Organization: Raptor Systems, Inc
X-Mailer: Mozilla 4.05 [en] (WinNT; I)
MIME-Version: 1.0
To: andrebalsa@altern.org
CC: linux-kernel@vger.rutgers.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>, Rafael Reilova <rreilova@ececs.uc.edu>, Colin Plumb <colin@nyx.net>
Subject: Re: new version of time.c
References: <98071212561206.00441@lw2l.bnc.interdrome.fr>
Content-Type: multipart/mixed; boundary="------------129955A5189328E86108BB0D"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.
--------------129955A5189328E86108BB0D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This code suffers from the same problem that all the existing
do_fast code suffers from -- namely, the assumption that the timer
interrupt is processed exactly on the 100Hz tick.

The attached patch fixes the problem for 2.0.3x series kernels
and has been running for a time without problems. It also includes
a debugging function (do_both_gettimeoffset) that can be used
to demonstrate the problem.

The trick is to record (using the do_slow mechanism) the time
when the interrupt is actually taken, and then factor that into
the calculation.

Philip

Andrew Derrick Balsa wrote:
> 
> The code itself:
> (drop-in replacement for time.c in 2.0.34)
> ---------------------
> Andrew D. Balsa
> andrebalsa@altern.org
> 
>   ------------------------------------------------------------------------
> 
>                 Name: time.c
>    time.c       Type: C Source File (application/x-unknown-content-type-cfile)
>             Encoding: base64

-- 
Philip Gladstone                           +1 781 530 2461
Raptor Systems / Axent Technologies 
Waltham, MA         		    http://www.raptor.com/
--------------129955A5189328E86108BB0D
Content-Type: text/plain; charset=us-ascii; name="mtime.pf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="mtime.pf"

--- time.c.orig	Fri Nov  7 13:06:21 1997
+++ linux/arch/i386/kernel/time.c	Thu May 14 16:03:02 1998
@@ -43,6 +47,9 @@
 	unsigned long high;
 } init_timer_cc, last_timer_cc;
 
+/* Number of usecs that the last interrupt was delayed */
+static int delay_at_last_interrupt;
+
 /*
  * This is more assembly than C, but it's also rather
  * timing-critical and we have to use assembler to get
@@ -129,10 +136,16 @@
 	 * we need to check the result so that we'll get a timer
 	 * that is monotonic.
 	 */
-	if (edx >= 1000020/HZ)
-		edx = 1000020/HZ-1;
+        /* 
+         * Monotonic times should be enforced in gettimeofday,
+         * and it is not the case that the error is limited to
+         * one tick. 
+         *
+	 * if (edx >= 1000020/HZ)
+         * 	edx = 1000020/HZ-1;
+         */
 
-	eax = edx + missing_time;
+	eax = edx + missing_time + delay_at_last_interrupt;
 	return eax;
 }
 #endif
@@ -234,6 +247,28 @@
 	return offset + count;
 }
 
+static unsigned long do_both_gettimeoffset(void)
+{
+       unsigned long slow, fast;
+       static int fast_after_slow;
+       static int slow_after_fast = 5;
+
+       fast = do_fast_gettimeoffset();
+       slow = do_slow_gettimeoffset();
+
+       if (slow + fast_after_slow < fast) {
+           fast_after_slow = fast - slow;
+           printk(KERN_WARNING "do_fast_gettimeoffset()=%ld - do_slow_gettimeoffset()=%ld = %d\n", fast, slow, fast_after_slow);
+       }
+
+       if (fast + slow_after_fast < slow) {
+           slow_after_fast = slow - fast;
+           printk(KERN_WARNING "do_fast_gettimeoffset()=%ld - do_slow_gettimeoffset()=%ld = %d\n", fast, slow, -slow_after_fast);
+       }
+
+       return fast;
+}
+
 static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
 
 /*
@@ -385,10 +471,24 @@
  */
 static void pentium_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+        int count;
+
+        /* It is important that these two operations happen at the
+         * same time. It is unclear which order is better!
+         */
+
+	outb_p(0x00, 0x43);	/* latch the count ASAP */
 	/* read Pentium cycle counter */
 	__asm__(".byte 0x0f,0x31"
 		:"=a" (last_timer_cc.low),
 		 "=d" (last_timer_cc.high));
+
+	count = inb_p(0x40);	/* read the latched count */
+	count |= inb(0x40) << 8;
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+
 	timer_interrupt(irq, NULL, regs);
 }
 #endif
--- linux/kernel/time.c.old	Tue Nov 11 15:51:14 1997
+++ linux/kernel/time.c	Tue Nov 11 15:52:11 1997
@@ -68,23 +68,17 @@
  */
 asmlinkage int sys_stime(int * tptr)
 {
-	int error, value;
+	int error;
+	struct timeval new_tv;
 
 	if (!suser())
 		return -EPERM;
 	error = verify_area(VERIFY_READ, tptr, sizeof(*tptr));
 	if (error)
 		return error;
-	value = get_user(tptr);
-	cli();
-	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_state = TIME_ERROR;	/* p. 24, (a) */
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	sti();
+	new_tv.tv_sec = get_user(tptr);
+	new_tv.tv_usec = 0;
+	do_settimeofday(&new_tv);
 	return 0;
 }
 

--------------129955A5189328E86108BB0D--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
