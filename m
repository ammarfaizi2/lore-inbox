Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265558AbSJXRJj>; Thu, 24 Oct 2002 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbSJXRJi>; Thu, 24 Oct 2002 13:09:38 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:62375 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265558AbSJXRJQ>;
	Thu, 24 Oct 2002 13:09:16 -0400
Message-ID: <3DB82ABF.8030706@colorfullife.com>
Date: Thu, 24 Oct 2002 19:15:43 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: arjanv@redhat.com
Subject: [CFT] faster athlon/duron memory copy implementation
Content-Type: multipart/mixed;
 boundary="------------020604040309010900080705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604040309010900080705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

AMD recommends to perform memory copies with backward read operations 
instead of prefetch.

http://208.15.46.63/events/gdc2002.htm

Attached is a test app that compares several memory copy implementations.
Could you run it and report the results to me, together with cpu, 
chipset and memory type?

Please run 2 or 3 times.

--
    Manfred

--------------020604040309010900080705
Content-Type: text/plain;
 name="athlon.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="athlon.c"

/*

(C) 2000 Arjan van de Ven and others  licensed under the terms of the GPL


$Revision: 1.6 $
*/

static char cvsid[] = "$Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $";
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* The 2.4 kernel one, adapted for userspace */

static void fast_clear_page(void *page)
{
	int i;
	char fpu_save[108];

	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
	
	__asm__ __volatile__ (
		"  pxor %%mm0, %%mm0\n" : :
	);

	for(i=0;i<4096/128;i++)
	{
		__asm__ __volatile__ (
		"  movq %%mm0, (%0)\n"
		"  movq %%mm0, 8(%0)\n"
		"  movq %%mm0, 16(%0)\n"
		"  movq %%mm0, 24(%0)\n"
		"  movq %%mm0, 32(%0)\n"
		"  movq %%mm0, 40(%0)\n"
		"  movq %%mm0, 48(%0)\n"
		"  movq %%mm0, 56(%0)\n"
		"  movq %%mm0, 64(%0)\n"
		"  movq %%mm0, 72(%0)\n"
		"  movq %%mm0, 80(%0)\n"
		"  movq %%mm0, 88(%0)\n"
		"  movq %%mm0, 96(%0)\n"
		"  movq %%mm0, 104(%0)\n"
		"  movq %%mm0, 112(%0)\n"
		"  movq %%mm0, 120(%0)\n"
		: : "r" (page) : "memory");
		page+=128;
	}
	__asm__ __volatile__ (
		"  femms\n" : :
	);
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
	
}

/* modified version for Athlon-family processors */
static void faster_clear_page(void *page)
{
	int i;
	char fpu_save[108];

	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
	__asm__ __volatile__ (
		"  pxor %%mm0, %%mm0\n" : :
	);

	for(i=0;i<4096/64;i++)
	{
		__asm__ __volatile__ (
		"  movntq %%mm0, (%0)\n"
		"  movntq %%mm0, 8(%0)\n"
		"  movntq %%mm0, 16(%0)\n"
		"  movntq %%mm0, 24(%0)\n"
		"  movntq %%mm0, 32(%0)\n"
		"  movntq %%mm0, 40(%0)\n"
		"  movntq %%mm0, 48(%0)\n"
		"  movntq %%mm0, 56(%0)\n"
		: : "r" (page) : "memory");
		page+=64;
	}
	__asm__ __volatile__ (
		" sfence \n "
		" femms\n" : :
	);
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );

}

/* test version to go even faster... this might be the same as faster_
 * but serves as my playground.
 */
static void even_faster_clear_page(void *page)
{
	int i;
	char fpu_save[108];
	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

	__asm__ __volatile__ (
		"  pxor %%mm0, %%mm0\n" : :
	);

	for(i=0;i<4096/64;i++)
	{
		__asm__ __volatile__ (
		"  movntq %%mm0, (%0)\n"
		"  movntq %%mm0, 8(%0)\n"
		"  movntq %%mm0, 16(%0)\n"
		"  movntq %%mm0, 24(%0)\n"
		"  movntq %%mm0, 32(%0)\n"
		"  movntq %%mm0, 40(%0)\n"
		"  movntq %%mm0, 48(%0)\n"
		"  movntq %%mm0, 56(%0)\n"
		: : "r" (page) : "memory");
		page+=64;
	}
	__asm__ __volatile__ (
		" sfence \n "
		" femms\n" : :
	);
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );

}

/* The "fallback" one as used by the kernel */
static void slow_zero_page(void * page)
{
	int d0, d1;
	__asm__ __volatile__( \
		"cld\n\t" \
		"rep ; stosl" \
		: "=&c" (d0), "=&D" (d1)
		:"a" (0),"1" (page),"0" (1024)
		:"memory");
}

static void slow_copy_page(void *to, void *from)
{
	int d0, d1, d2;
	__asm__ __volatile__( \
		"cld\n\t" \
		"rep ; movsl" \
		: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
		: "0" (1024),"1" ((long) to),"2" ((long) from) \
		: "memory");
}


/* 2.4 kernel mmx copy_page function */
static void fast_copy_page(void *to, void *from)
{
	int i;
	char fpu_save[108];
	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

	__asm__ __volatile__ (
		"1: prefetch (%0)\n"
		"   prefetch 64(%0)\n"
		"   prefetch 128(%0)\n"
		"   prefetch 192(%0)\n"
		"   prefetch 256(%0)\n"
		: : "r" (from) );

	for(i=0; i<4096/64; i++)
	{
		__asm__ __volatile__ (
		"1: prefetch 320(%0)\n"
		"2: movq (%0), %%mm0\n"
		"   movq 8(%0), %%mm1\n"
		"   movq 16(%0), %%mm2\n"
		"   movq 24(%0), %%mm3\n"
		"   movq %%mm0, (%1)\n"
		"   movq %%mm1, 8(%1)\n"
		"   movq %%mm2, 16(%1)\n"
		"   movq %%mm3, 24(%1)\n"
		"   movq 32(%0), %%mm0\n"
		"   movq 40(%0), %%mm1\n"
		"   movq 48(%0), %%mm2\n"
		"   movq 56(%0), %%mm3\n"
		"   movq %%mm0, 32(%1)\n"
		"   movq %%mm1, 40(%1)\n"
		"   movq %%mm2, 48(%1)\n"
		"   movq %%mm3, 56(%1)\n"
		: : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	__asm__ __volatile__ (
		" femms\n" : :
	);
	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

}


/* Athlon improved version */
static void faster_copy_page(void *to, void *from)
{
	int i;
	char fpu_save[108];

	__asm__ __volatile__ (
		"1: prefetchnta (%0)\n"
		"   prefetchnta 64(%0)\n"
		"   prefetchnta 128(%0)\n"
		"   prefetchnta 192(%0)\n"
		: : "r" (from) );

	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

	for(i=0; i<4096/64; i++)
	{
		__asm__ __volatile__ (
		"1: prefetchnta 320(%0)\n"
		"2: movq (%0), %%mm0\n"
		"   movq 8(%0), %%mm1\n"
		"   movq 16(%0), %%mm2\n"
		"   movq 24(%0), %%mm3\n"
		"   movq 32(%0), %%mm4\n"
		"   movq 40(%0), %%mm5\n"
		"   movq 48(%0), %%mm6\n"
		"   movq 56(%0), %%mm7\n"
		"   movntq %%mm0, (%1)\n"
		"   movntq %%mm1, 8(%1)\n"
		"   movntq %%mm2, 16(%1)\n"
		"   movntq %%mm3, 24(%1)\n"
		"   movntq %%mm4, 32(%1)\n"
		"   movntq %%mm5, 40(%1)\n"
		"   movntq %%mm6, 48(%1)\n"
		"   movntq %%mm7, 56(%1)\n"
		: : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
}
	__asm__ __volatile__ (
		" femms \n "
		" sfence\n" : :
	);
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );

}

/* test version to go even faster... this might be the same as faster_
 * but serves as my playground.
 */
static void even_faster_copy_page(void *to, void *from)
{
	int i;
	char fpu_save[108];

	__asm__ __volatile__ (
		"1: prefetchnta (%0)\n"
		"   prefetchnta 64(%0)\n"
		"   prefetchnta 128(%0)\n"
		"   prefetchnta 192(%0)\n"
		: : "r" (from) );

	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

	for(i=0; i<4096/64; i++)
	{
		__asm__ __volatile__ (
		"   prefetchnta 256(%0)\n"
		"   movq (%0), %%mm0\n"
		"   movntq %%mm0, (%1)\n"
		"   movq 8(%0), %%mm1\n"
		"   movntq %%mm1, 8(%1)\n"
		"   movq 16(%0), %%mm2\n"
		"   movntq %%mm2, 16(%1)\n"
		"   movq 24(%0), %%mm3\n"
		"   movntq %%mm3, 24(%1)\n"
		"   movq 32(%0), %%mm4\n"
		"   movntq %%mm4, 32(%1)\n"
		"   movq 40(%0), %%mm5\n"
		"   movntq %%mm5, 40(%1)\n"
		"   movq 48(%0), %%mm6\n"
		"   movntq %%mm6, 48(%1)\n"
		"   movq 56(%0), %%mm7\n"
		"   movntq %%mm7, 56(%1)\n"
		: : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	__asm__ __volatile__ (
		" femms \n "
		" sfence\n" : :
	);
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
	
}


/*
 * This looks horribly ugly, but the compiler can optimize it totally,
 * as the count is constant.
 */
static inline void * __constant_memcpy(void * to, const void * from, size_t n)
{
	switch (n) {
		case 0:
			return to;
		case 1:
			*(unsigned char *)to = *(const unsigned char *)from;
			return to;
		case 2:
			*(unsigned short *)to = *(const unsigned short *)from;
			return to;
		case 3:
			*(unsigned short *)to = *(const unsigned short *)from;
			*(2+(unsigned char *)to) = *(2+(const unsigned char *)from);
			return to;
		case 4:
			*(unsigned long *)to = *(const unsigned long *)from;
			return to;
		case 6:	/* for Ethernet addresses */
			*(unsigned long *)to = *(const unsigned long *)from;
			*(2+(unsigned short *)to) = *(2+(const unsigned short *)from);
			return to;
		case 8:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			return to;
		case 12:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			return to;
		case 16:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
			return to;
		case 20:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
			*(4+(unsigned long *)to) = *(4+(const unsigned long *)from);
			return to;
	}
#define COMMON(x) \
__asm__ __volatile__( \
	"rep ; movsl" \
	x \
	: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
	: "0" (n/4),"1" ((long) to),"2" ((long) from) \
	: "memory");
{
	int d0, d1, d2;
	switch (n % 4) {
		case 0: COMMON(""); return to;
		case 1: COMMON("\n\tmovsb"); return to;
		case 2: COMMON("\n\tmovsw"); return to;
		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
	}
}
  
#undef COMMON
}


static void normal_copy_page(void *to, void *from)
{
	__constant_memcpy(to,from,4096);
}


/*
 * This looks horribly ugly, but the compiler can optimize it totally,
 * as we by now know that both pattern and count is constant..
 */
static inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
{
	switch (count) {
		case 0:
			return s;
		case 1:
			*(unsigned char *)s = pattern;
			return s;
		case 2:
			*(unsigned short *)s = pattern;
			return s;
		case 3:
			*(unsigned short *)s = pattern;
			*(2+(unsigned char *)s) = pattern;
			return s;
		case 4:
			*(unsigned long *)s = pattern;
			return s;
	}
#define COMMON(x) \
__asm__  __volatile__( \
	"rep ; stosl" \
	x \
	: "=&c" (d0), "=&D" (d1) \
	: "a" (pattern),"0" (count/4),"1" ((long) s) \
	: "memory")
{
	int d0, d1;
	switch (count % 4) {
		case 0: COMMON(""); return s;
		case 1: COMMON("\n\tstosb"); return s;
		case 2: COMMON("\n\tstosw"); return s;
		default: COMMON("\n\tstosw\n\tstosb"); return s;
	}
}
  
#undef COMMON
}

static void normal_clear_page(void *to)
{
	 __constant_c_and_count_memset(to,0,4096);
}

/* test version to see if we can go even faster */
static void no_prefetch_copy_page(void *to, void *from) {
	int i, d1;
        char fpu_save[108];

	for (i=4096-256;i>=0;i-=256)
		__asm__ __volatile(
			"movl 192(%1,%2),%0\n"
			"movl 128(%1,%2),%0\n"
			"movl 64(%1,%2),%0\n"
			"movl 0(%1,%2),%0\n"
			: "=&r" (d1)
			: "r" (from), "r" (i));

        __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );

	for(i=0; i<4096/64; i++) {
		__asm__ __volatile__ (
		"   movq (%0), %%mm0\n"
		"   movntq %%mm0, (%1)\n"
		"   movq 8(%0), %%mm1\n"
		"   movntq %%mm1, 8(%1)\n"
		"   movq 16(%0), %%mm2\n"
		"   movntq %%mm2, 16(%1)\n"
		"   movq 24(%0), %%mm3\n"
		"   movntq %%mm3, 24(%1)\n"
		"   movq 32(%0), %%mm4\n"
		"   movntq %%mm4, 32(%1)\n"
		"   movq 40(%0), %%mm5\n"
		"   movntq %%mm5, 40(%1)\n"
		"   movq 48(%0), %%mm6\n"
		"   movntq %%mm6, 48(%1)\n"
		"   movq 56(%0), %%mm7\n"
		"   movntq %%mm7, 56(%1)\n"
		: : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	__asm__ __volatile__ (
		" sfence \n "
		" emms\n"
		" frstor %0;\n" ::"m"(fpu_save[0]) );
}


#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
     
typedef void (clear_func)(void *);
typedef void (copy_func)(void *,void *);

void test_one_clearpage(clear_func *func, char *name, char *Buffer)
{
	char *temp;
	int i;
	unsigned int blow,bhigh,alow,ahigh;
	unsigned long long before,after;

	rdtsc(blow,bhigh);
	temp = Buffer;
	for (i=0;i<4*1024;i++) {
		func(temp);
		temp += 4096;
	}
	rdtsc(alow,ahigh);
	before =  blow + (((long long)bhigh)<<32);
	after = alow +(((long long)ahigh)<<32);
	if (before>after) {
		printf("test invalid; timer overflow \n");
		return;
	}
	printf("clear_page function '%s'\t took %4lli cycles per page\n",name,(after-before)/(4*1024) );


}
     
void test_one_copypage(copy_func *func, char *name, char *Buffer)
{
	char *temp;
	int i;
	unsigned int blow,bhigh,alow,ahigh;
	unsigned long long before,after;

	sleep(1);
	rdtsc(blow,bhigh);
	temp = Buffer;
	for (i=0;i<2*1024;i++) {
		func(temp,temp+8*1024*1024);
		temp += 4096;
	}
	rdtsc(alow,ahigh);
	before =  blow+ (((long long)bhigh)<<32);
	after = alow+(((long long)ahigh)<<32);
	if (before>after) {
		printf("test invalid; timer overflow \n");
		return;
	}
	printf("copy_page function '%s'\t took %4lli cycles per page\n",name,(after-before)/(2*1024) );


}
     
     
void test_clearpage(char *Buffer)
{
	printf("clear_page() tests \n");

	test_one_clearpage(fast_clear_page,"warm up run",Buffer);
	test_one_clearpage(normal_clear_page,"2.4 non MMX",Buffer);
	test_one_clearpage(slow_zero_page,"2.4 MMX fallback",Buffer);
	test_one_clearpage(fast_clear_page,"2.4 MMX version",Buffer);
	test_one_clearpage(faster_clear_page,"faster_clear_page",Buffer);
	test_one_clearpage(even_faster_clear_page,"even_faster_clear",Buffer);
}   

void test_copypage(char *Buffer)
{
	printf("copy_page() tests \n");
	
	test_one_copypage(fast_copy_page,  "warm up run",Buffer);
	test_one_copypage(normal_copy_page,"2.4 non MMX",Buffer);
	test_one_copypage(slow_copy_page,  "2.4 MMX fallback",Buffer);
	test_one_copypage(fast_copy_page,  "2.4 MMX version",Buffer);
	test_one_copypage(faster_copy_page,"faster_copy",Buffer);
	test_one_copypage(even_faster_copy_page,"even_faster",Buffer);
	test_one_copypage(no_prefetch_copy_page,"no_prefetch",Buffer);
}

int main()
{
	char *Buffer;
	
	Buffer = malloc(1024*1024*16);
	memset(Buffer,0xfe,1024*1024*16);
	
	printf("Athlon test program %s \n",cvsid);
	
	printf("\n");
	test_copypage(Buffer);

	free(Buffer);

	return 0;
}

--------------020604040309010900080705--

