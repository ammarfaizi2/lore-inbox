Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSJYJlJ>; Fri, 25 Oct 2002 05:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJYJlJ>; Fri, 25 Oct 2002 05:41:09 -0400
Received: from sun.fadata.bg ([80.72.64.67]:48786 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S261330AbSJYJlE>;
	Fri, 25 Oct 2002 05:41:04 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Russell King <rmk@arm.linux.org.uk>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Csum and csum copyroutines benchmark
References: <200210231218.18733.roy@karlsbakk.net>
	<200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
	<87n0p3x8lh.fsf@fadata.bg>
	<200210250906.g9P96Yp14775@Port.imtp.ilyichevsk.odessa.ua>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <200210250906.g9P96Yp14775@Port.imtp.ilyichevsk.odessa.ua>
Date: 25 Oct 2002 12:47:05 +0300
Message-ID: <87znt297fq.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Denis" == Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

Denis> [please drop libc from CC:]
Denis> On 25 October 2002 05:48, Momchil Velikov wrote:
>>> Short conclusion:
>>> 1. It is possible to speed up csum routines for AMD processors
>>> by 30%.
>>> 2. It is possible to speed up csum_copy routines for both AMD
>>> andd Intel three times or more.

>> Additional data point:
>> 
>> Short summary:
>> 1. Checksum - kernelpii_csum is ~19% faster
>> 2. Copy - lernelpii_csum is ~6% faster
>> 
>> Dual Pentium III, 1266Mhz, 512K cache, 2G SDRAM (133Mhz, ECC)
>> 
>> The only changes I made were to decrease the buffer size to 1K (as I
>> think this is more representative to a network packet size, correct
>> me if I'm wrong) and increase the runs to 1024. Max values are
>> worthless indeed.

Denis> Well, that makes it run entirely in L0 cache. This is unrealistic
Denis> for actual use. movntq is x3 faster when you hit RAM instead of L0.

Oops ...

Denis> You need to be more clever than that - generate pseudo-random
Denis> offsets in large buffer and run on ~1K pieces of that buffer.

Here it is:

Csum benchmark program
buffer size: 1 K
Each test tried 1024 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  8678 max,  808 min cycles per kb. sum=0x400270e8
                     kernel_csum - took   941 max,  808 min cycles per kb. sum=0x400270e8
                     kernel_csum - took 11604 max,  808 min cycles per kb. sum=0x400270e8
                  kernelpii_csum - took 28839 max,  664 min cycles per kb. sum=0x400270e8
                kernelpiipf_csum - took  9163 max,  665 min cycles per kb. sum=0x400270e8
                        pfm_csum - took  2788 max, 1470 min cycles per kb. sum=0x400270e8
                       pfm2_csum - took  1179 max,  915 min cycles per kb. sum=0x400270e8
copy tests:
                     kernel_copy - took   688 max,  263 min cycles per kb. sum=0x400270e8
                     kernel_copy - took   456 max,  263 min cycles per kb. sum=0x400270e8
                     kernel_copy - took 11241 max,  263 min cycles per kb. sum=0x400270e8
                  kernelpii_copy - took  7635 max,  246 min cycles per kb. sum=0x400270e8
                      ntqpf_copy - took  5349 max,  536 min cycles per kb. sum=0x400270e8
                     ntqpfm_copy - took   769 max,  425 min cycles per kb. sum=0x400270e8
                        ntq_copy - took   672 max,  469 min cycles per kb. sum=0x400270e8
                     ntqpf2_copy - took  8000 max,  579 min cycles per kb. sum=0x400270e8
Done

Ran on a 512K (my cache size) buffer, choosing each time a 1K
piece. (making the buffer larger (2M, 4M) does not make any
difference).

And the modified 0main.c is attached.

~velco

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=0main.c

#include <stdio.h>
#include <stdlib.h>

#define NAME(a) \
unsigned int a##csum(const unsigned char * buff, int len, \
			unsigned int sum); \
unsigned int a##copy(const char *src, char *dst, \
                        int len, int sum, int *src_err_ptr, int *dst_err_ptr)
			
/* This makes adding/removing test functions easier */
/* asm ones... */
NAME(kernel_);
NAME(kernelpii_);
NAME(kernelpiipf_);
/* and C */
#include "pfm_csum.c"
#include "pfm2_csum.c"
#include "ntq_copy.c"
#include "ntqpf_copy.c"
#include "ntqpf2_copy.c"
#include "ntqpfm_copy.c"

const int TRY_TIMES = 1024;
const int NBUFS = 512;
const int BUFSIZE = 1024;
const int POISON = 0; // want to check correctness?

typedef unsigned int csum_func(const unsigned char * buff, int len,
		unsigned int sum);
typedef unsigned int copy_func(const char *src, char *dst,
		int len, int sum, int *src_err_ptr, int *dst_err_ptr);

static inline long long rdtsc()
{
	unsigned int low,high;
	__asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high));
	return low + (((long long)high)<<32);
}

int die(const char *msg) {
	puts(msg);
	abort();
	return 1;
}

unsigned test_one_csum(csum_func *func, char *name, char *buffer)
{
	int i;
	unsigned long long before,after,min,max;
	unsigned sum;
	
	// pick fastest run
	min = ~0ULL;
	max = 0;
	for (i=0;i<TRY_TIMES;i++) {
		before = rdtsc();
		unsigned sum2 = func(buffer + (rand () % NBUFS) * BUFSIZE,
				     BUFSIZE, 0);
		after = rdtsc();
		if (before>after) die("timer overflow");
		else {
			after-=before;
			if(min>after) min=after;
			if(max<after) max=after;
		}		
	}
	printf("%32s - took %5lli max,%5lli min cycles per kb. sum=0x%08x\n",
		name,
		max / (BUFSIZE/1024),
		min / (BUFSIZE/1024),
		sum
		);
}
     
unsigned test_one_copy(copy_func *func, char *name, char *buffer)
{
	int i;
	unsigned long long before,after,min,max;
	unsigned sum;
	int err;

	// pick fastest run
	min = ~0ULL;
	max = 0;
	for (i=0; i<TRY_TIMES; i++) {
		if(POISON) memset(buffer,          0x55,BUFSIZE/2);
		if(POISON) memset(buffer+BUFSIZE/2,0xaa,BUFSIZE/2);
		buffer[0] = 0x77;
		buffer[BUFSIZE/2-1] = 0x44;
		before = rdtsc();
		char *buf = buffer + rand () % (NBUFS - 1);
		unsigned sum2 = func(buf,buf+BUFSIZE/2,BUFSIZE/2,0,&err,&err);
		after = rdtsc();
		if(POISON) if(memcmp(buffer,buffer+BUFSIZE/2,BUFSIZE/2)!=0) die("BAD copy!");
		if (before>after) die("timer overflow");
		else {
			after-=before;
			if(min>after) min=after;
			if(max<after) max=after;
		}		
	}
	printf("%32s - took %5lli max,%5lli min cycles per kb. sum=0x%08x\n",
		name,
		max / (BUFSIZE/1024) / 2,
		min / (BUFSIZE/1024) / 2,
		sum
	);
	return sum;
}
     
     
void test_csum(char *buffer)
{
	unsigned sum;
	puts("csum tests:");

#define	TEST_CSUM(a) test_one_csum(a,#a,buffer)
	TEST_CSUM(kernel_csum	);
	TEST_CSUM(kernel_csum	);
	TEST_CSUM(kernel_csum	);
	TEST_CSUM(kernelpii_csum	);
	TEST_CSUM(kernelpiipf_csum);
	TEST_CSUM(pfm_csum	);
	TEST_CSUM(pfm2_csum	);
#undef TEST_CSUM
}   

void test_copy(char *buffer)
{
	unsigned sum;
	puts("copy tests:");

#define	TEST_COPY(a) test_one_copy(a,#a,buffer)
	sum =  TEST_COPY(kernel_copy	);
	sum == TEST_COPY(kernel_copy	) || die("Bad sum");
	sum == TEST_COPY(kernel_copy	) || die("Bad sum");
	sum == TEST_COPY(kernelpii_copy	) || die("Bad sum");
	sum == TEST_COPY(ntqpf_copy	) || die("Bad sum");
	sum == TEST_COPY(ntqpfm_copy	) || die("Bad sum");
	sum == TEST_COPY(ntq_copy	) || die("Bad sum");
	sum == TEST_COPY(ntqpf2_copy	) || die("Bad sum");
#undef TEST_COPY
}

int main()
{
	char *buffer_raw,*buffer;
	printf("Csum benchmark program\n"
		"buffer size: %i K\n"
		"Each test tried %i times, max and min CPU cycles are reported.\n"
		"Please disregard max values. They are due to system interference only.\n",
		BUFSIZE/1024,
		TRY_TIMES
	);
	
	buffer_raw = malloc(NBUFS * BUFSIZE+16);
	if(!buffer_raw) die("Malloc failed");
		
	buffer = (char*) ((((int)buffer_raw)+15) & (~0xF));
	
	test_csum(buffer);
	test_copy(buffer);

	puts("Done");
	free(buffer_raw);
	return 0;
}

--=-=-=--
