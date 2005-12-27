Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVL0PJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVL0PJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVL0PJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:09:05 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:7059 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1750847AbVL0PJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:09:04 -0500
Message-ID: <43B158A6.7080508@cosmosbay.com>
Date: Tue, 27 Dec 2005 16:07:18 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 04/11] mutex subsystem, add include/asm-x86_64/mutex.h
References: <20051227141548.GE6660@elte.hu>
In-Reply-To: <20051227141548.GE6660@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 27 Dec 2005 16:07:23 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> add the x86_64 version of mutex.h, optimized in assembly.
> +/**
> + * __mutex_fastpath_lock - decrement and call function if negative
> + * @v: pointer of type atomic_t
> + * @fn: function to call if the result is negative
> + *
> + * Atomically decrements @v and calls <fn> if the result is negative.
> + */
> +#define __mutex_fastpath_lock(v, fn_name)				\
> +do {									\
> +	/* type-check the function too: */				\
> +	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
> +	unsigned long dummy;						\
> +									\
> +	(void)__tmp;							\
> +	typecheck(atomic_t *, v);					\
> +									\
> +	__asm__ __volatile__(						\
> +		LOCK	"   decl (%%rdi)	\n"			\
> +			"   js 2f		\n"			\
> +			"1:			\n"			\
> +									\
> +		LOCK_SECTION_START("")					\
> +			"2: call "#fn_name"	\n"			\
> +			"   jmp 1b		\n"			\
> +		LOCK_SECTION_END					\
> +									\
> +		:"=D" (dummy)						\
> +		: "D" (v)						\
> +		: "rax", "rsi", "rdx", "rcx",				\
> +		  "r8", "r9", "r10", "r11", "memory");			\
> +} while (0)

Hi Ingo

I do think this assembly is not very fair.
It has an *insane* register pressure for the compiler :
The fast path is thus not so fast.

Compare with the include/asm-x86_64/semaphore.h
         __asm__ __volatile__(
                 "# atomic down operation\n\t"
                 LOCK "decl %0\n\t"     /* --sem->count */
                 "js 2f\n"
                 "1:\n"
                 LOCK_SECTION_START("")
                 "2:\tcall __down_failed\n\t"
                 "jmp 1b\n"
                 LOCK_SECTION_END
                 :"=m" (sem->count)
                 :"D" (sem)
                 :"memory");

Only one register is mandatory (%rdi), instead of nine.

Two solutions :

(This one has no register constraint, but the slowpath is 'long')
It also requires the mutex is not on the stack.

#define PUSH_SCRATCH "push %%rdi; push %%rax; push %%rsi;"  \
		     "push %%rdx; push %%rcx; push %%r8;" \
		     "push %%r9; push %%r10; push %%r11\n"

#define POP_SCRATCH  "pop %%r11; pop %%r10; pop %%r9;"    \
	             "pop %%r8; pop %%rcx; pop %%rdx;"     \
                      "pop %%rsi; pop %%rax"; pop %%rdi\n"

  	__asm__ __volatile__(					\
  		LOCK	"   decl %0	\n"		\
  			"   js 2f		\n"		\
  			"1:			\n"		\
  								\
  		LOCK_SECTION_START("")				\
                        "2:" PUSH_SCRATCH                        \
			"lea %0,%%rdi            \n"            \
  			"call "#fn_name"	\n"             \
			POP_SCRATCH				\
  			"   jmp 1b		\n"		\
  		LOCK_SECTION_END				\
  								\
  		:"=m" (v->count)					\
  		: "m" (v->count)					\
  		: "memory");			\


Or call a wrapper that does the PUSH/POP thing.

Thank you
Eric
