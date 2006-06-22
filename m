Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWFVMai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWFVMai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWFVMai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:30:38 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:27587 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751774AbWFVMah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:30:37 -0400
Date: Thu, 22 Jun 2006 08:23:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Message-ID: <200606220827_MC3-1-C320-BEB3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606211914.37137.ak@suse.de>

On Wed, 21 Jun 2006 19:14:37 +0200, Andi Kleen wrote:

>> 
>> /* test how fast lsl/jnz/and runs.
>>  */
>> #define _GNU_SOURCE
>> #include <stdio.h>
>> #include <stdlib.h>
>> 
>> #define rdtscll(t)   asm volatile ("rdtsc" : "=A" (t))
>> 
>> #ifndef ITERS
>> #define ITERS        1000000
>> #endif
>> 
>> int main(int argc, char * const argv[])
>> {
>>      unsigned long long tsc1, tsc2;
>>      int count, cpu, junk;
>> 
>>      rdtscll(tsc1);
>>      asm (
>>              "       pushl %%ds              \n"
>>              "       popl %2                 \n"
>>              "1:                             \n"
>> #ifdef DO_TEST
>>              "       lsl %2,%0               \n"
>>              "       jnz 2f                  \n"
>>              "       and $0xff,%0            \n"
>> #endif
>>              "       dec %1                  \n"
>>              "       jnz 1b                  \n"
>>              "2:                             \n"
>>              : "=&r" (cpu), "=&r" (count), "=&r" (junk)
>>              : "1" (ITERS), "0" (-1)
>>      );
>>      rdtscll(tsc2);
>
> Measuring this way is a bad idea because you get far too much 
> noise from the RDTSCs. Usually you need to put a a few thousands entry 
> loop inside the RDTSCP and devide the result by the loop count

I got tired of people (namely me) forgetting to compile the C code
with optimization, so I did the loop in assembler.  It does 1000000
iterations by default.  Later I added the DO_TEST that lets you test
the empty loop just because I was curious.

A more realistic test with the two 'mov' instructions inside the loops
still only takes 16 clocks, so I'm wondering why you get 60?  Does the
vsyscall add that much overhead?  With this I get 29-30 clocks per loop
on Pentium II:


/* vgetcpu.c: test how fast vgetcpu runs
 * boot kernel with vgetcpu patch first, then build this:
 *  gcc -O3 -o vgetcpu vgetcpu.c <srcpath>/arch/i386/kernel/vsyscall-int80.so
 * (don't forget the optimization (-O3))
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

extern int __vgetcpu(void);

#define rdtscll(t)      asm("rdtsc" : "=A" (t))

int main(int argc, char * const argv[])
{
        long long tsc1, tsc2;
        int i, iters = 999999;

        rdtscll(tsc1);
        for (i = 0; i < iters; i++)
                __vgetcpu();
        rdtscll(tsc2);

        printf("loops: %d, avg: %llu\n", iters, (tsc2 - tsc1) / iters);

        return 0;
}
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
