Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSG2UdT>; Mon, 29 Jul 2002 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSG2UdT>; Mon, 29 Jul 2002 16:33:19 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:30377 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S317779AbSG2UdO>; Mon, 29 Jul 2002 16:33:14 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F3AD@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Cc: "'hpl@cs.utk.edu'" <hpl@cs.utk.edu>
Subject: Linux kernel deadlock caused by spinlock bug
Date: Mon, 29 Jul 2002 15:37:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have hit a problem with the Linux reader/writer spinlock
implementation that is causing a kernel deadlock (technically
livelock) which causes the system to hang (hard) when running
certain user applications.  This problem could be exploited as
a DoS attack on medium-to-large SMP machines.

Using some spiffy logic analyzers and debugging tools, I was able
to piece together the following scenario.

With "several" processors acquiring and releasing read locks, it is
possible for a processor to _never_ succeed in acquiring a write lock.
Even though the read lock is held for a very short period, with much
contention for the cache line the processor would often lose ownership
before it could release the read lock.  [Even if it had it longer,
because it was looping, there would still be a good chance that it
would lose the cache line while holding the reader lock.]  By the time
the reader got the cache line back to release the lock, another processor
had acquired the read lock.  This behavior resulted in a processor not
being able to acquire the write lock, which it was attempting to do in
an interrupt handler.  So the interrupt handler was _never_ able to
complete and other interrupts were blocked by that processor (in my
case, network and keyboard interrupts).

The specific case I tracked down consisted of several processes in
a tight gettimeofday() loop, which resulted in the reader count never
getting to zero because there was always an outstanding reader.  While
I will stipulate that it is not a good thing for several processes to
be looping in gettimeofday(), I will assert that it is a very bad thing
for a few processes calling such a benign system call to hang the system.

Unfortunately, this was not even a contrived test case, as I hit it
experimenting with HPL Linpack on a 32-processor Unisys ES7000 Orion 200,
although it does not take nearly 32 processors to reproduce.
See http://www.unisys.com/products/es7000__servers/hardware/index.htm

The HPL code polls for an incoming message in HPL_bcast, called by
HPL_pdupdateTT.  However, in the same while loop, it also calls
gettimeofday via HPL_ptimer.  The system hung when processor 0
received a timer interrupt before the user process it was running
sent the message, and after several processes were waiting for the
message.  So the other processes spun calling gettimeofday waiting
for the message that would not come until they stopped calling
gettimeofday.  Classic deadlock.  It normally took less than 5
minutes to reproduce (at which time I had to hard-reboot the system).

The logic analyzer proved it was not a hardware issue, since the
cache line was being fairly shared by the processors and the
reader count was being updated correctly.

I have included a new version of the write_lock code for IA64 at
the end of this email.  I'm not making any claims about it being
optimal, just that it appears to work.

I changed the code to allow the writer bit to remain set even if
there is a reader.  By only allowing a single processor to set
the writer bit, I don't have to worry about pending writers starving
out readers.  The potential writer that was able to set the writer bit
gains ownership of the lock when the current readers finish.  Since
the retry for read_lock does not keep trying to increment the reader
count, there are no other required changes.


A similar patch is needed for IA32 and any other SMP platform that
supports more than ~4 processors and does not already guarantee fairness
to writers.

The "fix" for IA32 would probably be very similar to the IA64 code,
but retaining the RW_LOCK_BIAS.  The only code that needs to change
is __write_lock_failed, which would need to keep RW_LOCK_BIAS subtracted
if the result is > 0xFF000000UL (0x0 - RW_LOCK_BIAS) [would not get
in __write_lock_failed if the result was 0].  Implementing that change
may require trashing another register.

Actually, the IA32 code should also have a "pause" instruction inserted
(especially for Foster processors) in all the retry code loops...
I've left the actual IA32 fix as an exercise for the reader, but I can
fix it and send out a patch if needed.

Kevin Van Maren



Here is the new IA64 write_lock code (include/asm-ia64/spinlock.h):


/*
 * write_lock pseudo-code:
 * Assume lock is unlocked, and try to acquire it.
 * If failed, wait until there isn't a writer, and then set the writer bit.
 * Once have writer bit, wait until there are no more readers.
 */
#define write_lock(rw)
\
do {
\
        __asm__ __volatile__ (
\
                "mov ar.ccv = r0\n"
\
                "dep r29 = -1, r0, 31, 1\n"
\
                ";;\n"
\
                "cmpxchg4.acq r2 = [%0], r29, ar.ccv\n"
\
                ";;\n"
\
                "cmp4.eq p0,p7 = r0, r2\n"
\
                "(p7) br.cond.spnt.few 2f\n"
\
                ";;\n"
\
                "1:\n"
\
                ".section .text.lock,\"ax\"\n"
\
                "2:\tld4 r30 = [%0]\n"
\
                ";;\n"
\
                "tbit.nz p7,p0 = r30, 31\n"
\
                "(p7) br.cond.spnt.few 2b\n"
\
                ";;\n"
\
                "mov ar.ccv = r30\n"
\
                "dep r29 = -1, r0, 31, 1\n"
\
                ";;\n"
\
                "or r29 = r29, r30\n"
\
                ";;\n"
\
                "cmpxchg4.acq r2 = [%0], r29, ar.ccv\n"
\
                ";;\n"
\
                "cmp4.eq p0,p7 = r30, r2\n"
\
                "(p7) br.cond.spnt.few 2b\n"
\
                ";;\n"
\
                "3:\n"
\
                "ld4 r2 = [%0]\n"
\
                ";;\n"
\
                "extr.u r30 = r2, 0, 31\n"
\
                ";;\n"
\
                "cmp4.eq p0,p7 = r0, r30\n"
\
                "(p7) br.cond.spnt.few 3b\n"
\
                "br.cond.sptk.few 1b\n"
\
                ".previous\n"
\
                :: "r"(rw) : "ar.ccv", "p7", "r2", "r29", "r30", "memory");
\
} while(0)

/*
 * clear_bit() has "acq" semantics; we're really need "rel" semantics,
 * but for simplicity, we simply do a fence for now...
 */
#define write_unlock(x)                         ({mb(); clear_bit(31,
(x));})



The old IA64 code (for comparison) was:

#define write_lock(rw)
\
do {
\
        __asm__ __volatile__ (
\
                "mov ar.ccv = r0\n"
\
                "dep r29 = -1, r0, 31, 1\n"
\
                ";;\n"
\
                "1:\n"
\
                "ld4 r2 = [%0]\n"
\
                ";;\n"
\
                "cmp4.eq p0,p7 = r0,r2\n"
\
                "(p7) br.cond.spnt.few 1b \n"
\
                "cmpxchg4.acq r2 = [%0], r29, ar.ccv\n"
\
                ";;\n"
\
                "cmp4.eq p0,p7 = r0, r2\n"
\
                "(p7) br.cond.spnt.few 1b\n"
\
                ";;\n"
\
                :: "r"(rw) : "ar.ccv", "p7", "r2", "r29", "memory");
\
} while(0)
