Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDKJIT>; Wed, 11 Apr 2001 05:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDKJIJ>; Wed, 11 Apr 2001 05:08:09 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:20713 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S132537AbRDKJH4> convert rfc822-to-8bit; Wed, 11 Apr 2001 05:07:56 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: george anzinger <george@mvista.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Message-ID: <C1256A2B.0031F59B.00@d12mta07.de.ibm.com>
Date: Wed, 11 Apr 2001 11:06:00 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>f) As noted, the account timers (task user/system times) would be much
>more accurate with the tick less approach.  The cost is added code in
>both the system call and the schedule path.
>
>Tentative conclusions:
>
>Currently we feel that the tick less approach is not acceptable due to
>(f).  We felt that this added code would NOT be welcome AND would, in a
>reasonably active system, have much higher overhead than any savings in
>not having a tick.  Also (d) implies a list organization that will, at
>the very least, be harder to understand.  (We have some thoughts here,
>but abandoned the effort because of (f).)  We are, of course, open to
>discussion on this issue and all others related to the project
>objectives.
f) might be true on Intel based systems. At least for s/390 the situation
is a little bit different. Here is a extract from the s/390 part of the
timer patch:

       .macro  UPDATE_ENTER_TIME reload
       la      %r14,thread+_TSS_UTIME(%r9) # pointer to utime
       tm      SP_PSW+1(%r15),0x01      # interrupting from user ?
       jno     0f                       # yes -> add to user time
       la      %r14,8(%r14)             # no -> add to system time
0:     lm      %r0,%r1,0(%r14)          # load user/system time
       sl      %r1,__LC_LAST_MARK+4     # subtract last time mark
       bc      3,BASED(1f)              # borrow ?
       sl      %r0,BASED(.Lc1)
1:     sl      %r0,__LC_LAST_MARK
       stck    __LC_LAST_MARK           # make a new mark
       al      %r1,__LC_LAST_MARK+4     # add new mark -> added delta
       bc      12,BASED(2f)             # carry ?
       al      %r0,BASED(.Lc1)
2:     al      %r0,__LC_LAST_MARK
       stm     %r0,%r1,0(%r14)          # store updated user/system time
       clc     __LC_LAST_MARK(8),__LC_JIFFY_TIMER # check if enough time
       jl      3f                       # passed for a jiffy update
       l       %r1,BASED(.Ltime_warp)
       basr    %r14,%r1
       .if     \reload                  # reload != 0 for system call
       lm      %r2,%r6,SP_R2(%r15)      # reload clobbered parameters
       .endif
3:

       .macro  UPDATE_LEAVE_TIME
       l       %r1,BASED(.Ltq_timer)    # test if tq_timer list is empty
       x       %r1,0(%r1)               # tq_timer->next != tq_timer ?
       jz      0f
       l       %r1,BASED(.Ltq_timer_active)
       icm     %r0,15,0(%r1)            # timer event already added ?
       jnz     0f
       l       %r1,BASED(.Ltq_pending)
       basr    %r14,%r1
0:     lm      %r0,%r1,thread+_TSS_STIME(%r9) # load system time
       sl      %r1,__LC_LAST_MARK+4     # subtract last time mark
       bc      3,BASED(1f)              # borrow ?
       sl      %r0,BASED(.Lc1)
1:     sl      %r0,__LC_LAST_MARK
       stck    __LC_LAST_MARK           # make new mark
       al      %r1,__LC_LAST_MARK+4     # add new mark -> added delta
       bc      12,BASED(2f)             # carry ?
       al      %r0,BASED(.Lc1)
2:     al      %r0,__LC_LAST_MARK
       stm     %r0,%r1,thread+_TSS_STIME(%r9) # store system time
       .endm

The two macros UPDATE_ENTER_TIME and UPDATE_LEAVE_TIMER are executed
on every system entry/exit. In the case that no special work has to
be done less then 31 instruction are executed in addition to the
normal system entry/exit code. Special work has to be done if more
time then 1/HZ has passed (call time_warp), or if tq_timer contains
an element (call tq_pending).
The accuracy of the timer events has not changed. It still is 1/HZ.
The only thing this patch does is to avoid unneeded interruptions.
I'd be happy if this could be combined with a new, more accurate
timing method.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


