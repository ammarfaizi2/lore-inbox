Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268006AbUHKJGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268006AbUHKJGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHKJF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:05:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16841 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268000AbUHKJFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:05:13 -0400
Date: Wed, 11 Aug 2004 11:06:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811090639.GA8354@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <1092210765.1650.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


most of the remaining latencies look quite suspect. E.g. the 
select()/tty_poll() ones:

  (gnome-terminal/826): 15491us non-preemptible critical section 
   violated 1100 us preempt threshold starting at
   add_wait_queue+0x15/0x50 and ending at add_wait_queue+0x2c/0x50

  [dump_stack+23/32] dump_stack+0x17/0x20
  [dec_preempt_count+60/80] dec_preempt_count+0x3c/0x50
  [add_wait_queue+44/80] add_wait_queue+0x2c/0x50
  [normal_poll+61/375] normal_poll+0x3d/0x177
  [tty_poll+97/128] tty_poll+0x61/0x80
  [do_pollfd+145/160] do_pollfd+0x91/0xa0
  [do_poll+95/192] do_poll+0x5f/0xc0
  [sys_poll+305/544] sys_poll+0x131/0x220
  [syscall_call+7/11] syscall_call+0x7/0xb

according to the trace this latency happened in a point where it's near
impossible to happen. add_wait_queue() is just a couple of straight
instructions on UP.

do you have any powersaving mode enabled in the BIOS? SMM handlers can
introduce such latencies (low probability).

the only other possibility is either a measurement error, or some mystic
IRQ overhead. But almost all IRQs are redirected so the IRQ overhead can
be eliminated almost completely. Plus direct-IRQ overhead should also
show up via the latest preempt-timing patch. Wrt. measurement error, the
jiffies based printout ought to help somewhat.

i'm currently running a loop of mlockall-test 100MB on a 466 MHz
Celeron, and not a single blip on the radar with a 1000 usecs threshold,
after 1 hour of runtime ...

i've previously seen RDTSC (cycle-counter) weirdnesses on another box,
in userspace. To exclude this possibility i've attached yet another
patch, it tries to make all the kernel rdtsc variants more robust. Does
this patch make any difference to the latency printouts? [this patch
doesnt handle cases where the rdtsc value jumps forward in time
permanently, but it handles the occasional blips i've seen on the other
box.]

	Ingo

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rdtsc-robust-2.6.8-rc3-A0"

--- linux/include/asm-i386/msr.h.orig3	
+++ linux/include/asm-i386/msr.h	
@@ -32,15 +32,50 @@ static inline void wrmsrl (unsigned long
 	wrmsr (msr, lo, hi);
 }
 
-#define rdtsc(low,high) \
+#define __rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
 
-#define rdtscl(low) \
+#define rdtsc(low,high) do {						\
+	unsigned int __low1, __high1, __low2, __high2;			\
+	for (;;) {							\
+		__rdtsc(__low1,__high1);				\
+		__rdtsc(__low2,__high2);				\
+		if (__high1 == __high2 && __low2 - __low1 < 1000)	\
+			break;						\
+	}								\
+	low = __low2;							\
+	high = __high2;							\
+} while (0)
+
+#define __rdtscl(low) \
      __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
 
-#define rdtscll(val) \
+#define rdtscl(low) do {						\
+	unsigned int __low1, __low2;					\
+	for (;;) {							\
+		__rdtscl(__low1);					\
+		__rdtscl(__low2);					\
+		if (__low2 - __low1 < 1000)				\
+			break;						\
+	}								\
+	low = __low2;							\
+} while (0)
+
+#define __rdtscll(val) \
      __asm__ __volatile__("rdtsc" : "=A" (val))
 
+#define rdtscll(val) do {						\
+	unsigned long long __val1, __val2;				\
+	for (;;) {							\
+		__rdtscll(__val1);					\
+		__rdtscll(__val2);					\
+		if (__val2 - __val1 < 1000ULL)				\
+			break;						\
+	}								\
+	val = __val2;							\
+} while (0)
+
+
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) \

--OgqxwSJOaUobr8KG--
