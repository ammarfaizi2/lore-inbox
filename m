Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBGHg6>; Wed, 7 Feb 2001 02:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129173AbRBGHgt>; Wed, 7 Feb 2001 02:36:49 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:57354 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129138AbRBGHge>; Wed, 7 Feb 2001 02:36:34 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Feb 2001 08:36:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4 kernel & gcc code generation: a bug?
Message-ID: <3A8108F8.2476.21D0F5@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to find out what got broken in kernel 2.4, I was so clueless as 
to compare assembly output for 2.2.18 with 2.4.1. However the assembler 
is quite different, as 2.4 uses the more advanced optimizations of gcc-
2.95.2. Anyway:

1) spinlocks look strange in 2.2(!):

.globl rtc_lock
        .type    rtc_lock,@object
        .size    rtc_lock,0
rtc_lock:
.globl i8253_lock

while in 2.4.1 they look like this:

.globl rtc_lock
        .align 4
        .type    rtc_lock,@object
        .size    rtc_lock,4
rtc_lock:
        .long 0
.globl i8253_lock


2) gcc seems to fail to save registers that are marked "spilled" in 
inline asm's constraints, like rdtsc():

/* nanoseconds since last timer interrupt (using the CPU cycle-counter) */
static inline unsigned long do_exact_nanotime(void)
{
	register unsigned long eax asm("ax");
	register unsigned long edx asm("dx");
	unsigned long result;


	rdtsc(eax, edx);		/* Read the Time Stamp Counter 
*/

	/* .. relative to previous jiffy (32 bits is enough) */
	eax -= last_tsc_low;	/* tsc_low delta */

	/*
	 * Time offset = (tsc_low delta << 4) * exact_nanotime_quotient
	 *             = (tsc_low delta << 4) * (nsecs_per_clock)
	 *             = (tsc_low delta << 4) * (nsecs_per_jiffy /
	 *				    clocks_per_jiffy)
	 *
	 * Using a mull instead of a divl saves up to 31 clock cycles
	 * in the critical path.
	 */
	__asm__("mull %2"
		:"=a" (eax), "=d" (edx)
		:"rm" (exact_nanotime_quotient),
		 "0" (eax << 4));

	/* our adjusted time offset in nanoseconds */
	result = nanodelay_at_last_interrupt + edx;
	return result;
}

.text
        .align 4
.type    do_exact_nanotime,@function
do_exact_nanotime:
#APP
        rdtsc
#NO_APP
subl last_tsc_low,%eax
sall $4,%eax
#APP
        mull exact_nanotime_quotient
#NO_APP
movl nanodelay_at_last_interrupt,%eax
addl %edx,%eax
        ret
.Lfe7:
.size    do_exact_nanotime,.Lfe7-do_exact_nanotime
        .local  last_rtc_update
.comm   last_rtc_update,4,4
.comm   timer_ack,4,4
        .ident  "GCC: (GNU) 2.95.2 19991024 (release)"

#endif


You'll notice that %edx is not pushed at the start of the function. 
Unless the caller saves that, edx will be spilled. Depending on the 
level of optimization this can be bad. Am I wrong?

Regards,
Ulrich
P.S: Not subscribed here, so plese CC: if possible.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
