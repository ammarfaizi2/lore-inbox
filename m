Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWFVMon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWFVMon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWFVMon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:44:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19348 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751440AbWFVMom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:44:42 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Thu, 22 Jun 2006 14:44:29 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200606220827_MC3-1-C320-BEB3@compuserve.com>
In-Reply-To: <200606220827_MC3-1-C320-BEB3@compuserve.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tCpmEGEVJkZFeAO"
Message-Id: <200606221444.29372.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tCpmEGEVJkZFeAO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 22 June 2006 14:23, Chuck Ebbert wrote:
> In-Reply-To: <200606211914.37137.ak@suse.de>
> 
> On Wed, 21 Jun 2006 19:14:37 +0200, Andi Kleen wrote:
> 
> >> 
> >> /* test how fast lsl/jnz/and runs.
> >>  */
> >> #define _GNU_SOURCE
> >> #include <stdio.h>
> >> #include <stdlib.h>
> >> 
> >> #define rdtscll(t)   asm volatile ("rdtsc" : "=A" (t))
> >> 
> >> #ifndef ITERS
> >> #define ITERS        1000000
> >> #endif
> >> 
> >> int main(int argc, char * const argv[])
> >> {
> >>      unsigned long long tsc1, tsc2;
> >>      int count, cpu, junk;
> >> 
> >>      rdtscll(tsc1);
> >>      asm (
> >>              "       pushl %%ds              \n"
> >>              "       popl %2                 \n"
> >>              "1:                             \n"
> >> #ifdef DO_TEST
> >>              "       lsl %2,%0               \n"
> >>              "       jnz 2f                  \n"
> >>              "       and $0xff,%0            \n"
> >> #endif
> >>              "       dec %1                  \n"
> >>              "       jnz 1b                  \n"
> >>              "2:                             \n"
> >>              : "=&r" (cpu), "=&r" (count), "=&r" (junk)
> >>              : "1" (ITERS), "0" (-1)
> >>      );
> >>      rdtscll(tsc2);
> >
> > Measuring this way is a bad idea because you get far too much 
> > noise from the RDTSCs. Usually you need to put a a few thousands entry 
> > loop inside the RDTSCP and devide the result by the loop count
> 
> I got tired of people (namely me) forgetting to compile the C code
> with optimization, so I did the loop in assembler.  It does 1000000
> iterations by default.  Later I added the DO_TEST that lets you test
> the empty loop just because I was curious.
> 
> A more realistic test with the two 'mov' instructions inside the loops
> still only takes 16 clocks, so I'm wondering why you get 60?  Does the
> vsyscall add that much overhead?  With this I get 29-30 clocks per loop
> on Pentium II:

This is the x86-64 test code I used. It's basically an emulation of the vsyscall
(including indirect call) in user space.

rdtscp shows less cycles, so it's not all overhead of the infrastructure.

-Andi


K8 E stepping: 

getpid 168 cycles
vgetcpu lsl 79 cycles
vgetcpu cached 15 cycles

K8 F stepping:

getpid 162 cycles
vgetcpu lsl 77 cycles
vgetcpu rdtscp 32 cycles
vgetcpu cached 15 cycles

Nocona: 

getpid 1491 cycles
vgetcpu lsl 130 cycles
vgetcpu cached 26 cycles



--Boundary-00=_tCpmEGEVJkZFeAO
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="tvgetcpu.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tvgetcpu.c"

#include <asm/msr.h>
#include <asm/unistd.h>
#include <stdio.h>

int errno;

_syscall0(int,getpid)

#define rdtscp(low,high,aux) \
     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))

#define rdtscpll(val, aux) do { \
     unsigned long __a, __d; \
     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (__a), "=d" (__d), "=c" (aux)); \
(val) = (__d << 32) | __a; \
} while (0)


enum {
	ITER = 100000,
}; 

long __jiffies;
enum {
	VGETCPU_RDTSCP = 1,
} __vgetcpu_mode;
unsigned char __cpu_to_node[32];

long do_vgetcpu(int *cpu, int *node, unsigned long *tcache)
{
       unsigned int dummy, p;
       unsigned long j = __jiffies;

       /* Fast cache - only recompute value once per jiffies and avoid
          relatively costly rdtscp/cpuid otherwise.
          This works because the scheduler usually keeps the process
          on the same CPU and this syscall doesn't guarantee its
          results anyways.
          We do this here because otherwise user space would do it on
          its own in a likely inferior way (no access to jiffies).
          If you don't like it pass NULL. */
       if (tcache && tcache[0] == j) {
               p = tcache[1];
       } else if (__vgetcpu_mode == VGETCPU_RDTSCP) {
               rdtscp(dummy, dummy, p);
       } else {
#if 1
		asm("lsl %1,%0" : "=r" (p) : "r" (15 * 8));
#else
               cpuid(1, &dummy, &p, &dummy, &dummy);
               p >>= 24;
               p |= (__cpu_to_node[p] << 16);
#endif
       }
       if (tcache) {
               tcache[0] = j;
               tcache[1] = p;
       }
       if (cpu)
               *cpu = p & 0xffff;
       if (node)
               *node = p >> 16;
       return 0;
 }

long (*vgetcpu)(int *cpu, int *node, unsigned long *tcache) = do_vgetcpu;


int main(void)
{
	unsigned long start, end; 
	int i;
	int rdtscp = 0;

#if 0
	rdtscp = 1;
#endif

	rdtscll(start);
	for (i = 0; i < ITER; i++) 
		getpid();
	rdtscll(end);
	printf("getpid %lu cycles\n", (end-start)/ITER); 

	int cpu, node;
	rdtscll(start);
	for (i = 0; i < ITER; i++) 
		vgetcpu(&cpu, &node, NULL);
	rdtscll(end);
	printf("vgetcpu lsl %lu cycles\n", (end-start)/ITER); 

	if (rdtscp) { 
		__vgetcpu_mode = VGETCPU_RDTSCP;

		rdtscll(start);
		for (i = 0; i < ITER; i++) 
			vgetcpu(&cpu, &node, NULL);
		rdtscll(end);
		printf("vgetcpu rdtscp %lu cycles\n", (end-start)/ITER); 

	}

	unsigned long cache[2];
	rdtscll(start);
	for (i = 0; i < ITER; i++) 
		vgetcpu(&cpu,&node,cache);
	rdtscll(end);
	printf("vgetcpu cached %lu cycles\n", (end-start)/ITER); 

	return 0;
}



--Boundary-00=_tCpmEGEVJkZFeAO--
