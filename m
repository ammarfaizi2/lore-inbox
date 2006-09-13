Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWIMBAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWIMBAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWIMBAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:00:35 -0400
Received: from gw.goop.org ([64.81.55.164]:24244 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030460AbWIMBAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:00:34 -0400
Message-ID: <45075829.701@goop.org>
Date: Tue, 12 Sep 2006 18:00:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: akpm@osdl.org, ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1158046540.2992.5.camel@laptopd505.fenrus.org>
Content-Type: multipart/mixed;
 boundary="------------000207000703040506000308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207000703040506000308
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> The advantage of this is very simple: %fs will be 0 for userspace most
> of the time. Putting 0 in a segment register is cheap for the cpu,
> putting anything else in is quite expensive (a LOT of security checks
> need to happen). As such I would MUCH rather see that the i386 PDA
> patches use %fs and not %gs... 
Hi Arjan,

I spent some time trying to measure this, to see if there really is a 
difference between loading a null selector vs a non-null.

The short answer is no, I couldn't measure any difference at all, on any 
CPU going back to a P166, up to a current Core Duo machine.

I used a usermode test model of the entry.S code in order to make it 
easier to test on more machines.  The basic inner loop is:

	push %segreg
	mov  %selectorreg, %segreg
	add  $1,%segreg:offset	# use the segment register
	pop  %segreg


I also unrolled the loop to minimize the overhead from anything else.  
This is clearly much more segment-register intense than any real use, so 
I'm hoping that this should exacerbate any performance differences.  I 
also tried to put cpuid in the loop in order to approximate the 
synchronizing effects of taking an exception, but it didn't seem to make 
much difference other than slow everything down by a constant amount 
(the cpuid slowdown swamped pretty much everything else on Intel CPUs, 
but was much less intrusive on the Athlon64).

I tried the push/load/pop sequence with both %fs and %gs, where pop %fs 
would result in a null selector load, and pop %gs would load the normal 
userspace TLS selector.

I also tried loading 3 types of selector after the push:

    * the normal usermode ds selector, on the grounds that the CPU might
      be more efficient in reloading a selector which is already in use
    * an ldt selector, which I thought might be slower since (at least
      conceptually) there's an indirection into a different descriptor table
    * and a gdt selector (the normally unused second TLS selector)


In general, I got identical results for all of these.  There were two 
exceptions:

    * The 1.8 GHz P4 Northwood was slower loading the LDT selector as
      expected, and pop %fs was faster than pop %gs.  The GDT and data
      selector results were the same independent of %fs or %gs.
    * The AMD K6 was consistently *slower* with pop %fs; pop %gs was
      faster.  I didn't try reversing the uses of %fs and %gs to see if
      it was the null selector being slower, or some inherent slowness
      in using %fs.


It's possible I got something wrong, and I'm not really measuring what I 
think I'm measuring.  The main thing that worries me about the results 
is that they don't scale much at all in proportion to the clock speed.  
Otherwise the results look sensible to me.  I'd appreciate it if people 
could review the test program to see if I've overlooked something.

So, in summary, I don't think there's much point in switching to %fs.  I 
may get around to confirming this by doing a %gs->%fs conversion patch, 
but given these results that's at a fairly low priority.

I've attached my test program and results.

    J

--------------000207000703040506000308
Content-Type: text/x-csrc;
 name="time-segops.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time-segops.c"

/* gcc -m32 -O3 -Wall -fomit-frame-pointer -funroll-loops -g  -o time-segops time-segops.c -lrt */
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <asm/unistd.h>

#define GTOD	0
#define SYNC	0
#define COUNT 50000000

/* different glibc's call this different things, so define our own */
struct desc {
	unsigned int  entry_number;
	unsigned long base_addr;
	unsigned int  limit;
	unsigned int  seg_32bit:1;
	unsigned int  contents:2;
	unsigned int  read_exec_only:1;
	unsigned int  limit_in_pages:1;
	unsigned int  seg_not_present:1;
	unsigned int  useable:1;
};

/* These don't seem to be consistently defined in glibc */
static int set_thread_area(struct desc *desc)
{
	int ret;
	asm("int $0x80"
	    : "=a" (ret)
	    : "0" (__NR_set_thread_area), "b" (desc)
	    : "memory");
	if (ret < 0) {
		errno = -ret;
		ret = -1;

	}
	return ret;
}
static int modify_ldt(int func, struct desc *desc, int size)
{
	int ret;
	asm("int $0x80"
	    : "=a" (ret)
	    : "0" (__NR_modify_ldt), "b" (func), "c" (desc), "d" (size)
	    : "memory");
	if (ret < 0) {
		errno = -ret;
		ret = -1;

	}
	return ret;
}

static inline unsigned long long now(void)
{
#if GTOD
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return tv.tv_sec * 1000000000ull + tv.tv_usec * 1000ull;
#else
	struct timespec ts;
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts);
	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
#endif
}

/* Simulate an exception's effect on the pipeline? */
static inline void sync(void)
{
	if (0) {
		int a,b,c,d;
		asm volatile("cpuid"
			     : "=a" (a), "=b" (b), "=c" (c), "=d" (d)
			     : "0" (0), "2" (0)
			     : "memory");
	} else
		asm volatile("" : : : "memory");
}

static const char *test_none(int seg, int *offset)
{
	int i;

	for(i = 0; i < COUNT; i++) {
		sync();
	}

	return "<none>";
}

static const char *test_fs(int seg, int *offset)
{
	int i;

	for(i = 0; i < COUNT; i++) {
		asm volatile("push %%fs; mov %1, %%fs; addl $1, %%fs:%0; popl %%fs"
			     : "+m" (*offset): "r" (seg) : "memory");
		sync();
	}
	return "fs";
}

static const char *test_gs(int seg, int *offset)
{
	int i;

	for(i = 0; i < COUNT; i++) {
		asm volatile("push %%gs; mov %1, %%gs; addl $1, %%gs:%0; popl %%gs"
			     : "+m" (*offset): "r" (seg) : "memory");
		sync();
	}
	return "gs";
}

typedef const char *(*test_t)(int, int *);

static const test_t tests[] = {
	test_none,
	test_fs,
	test_gs,
	NULL,
};

static int segment[1];


static void test(int seg, int *offset, const char *segdesc)
{
	int i;

	for(i = 0; tests[i]; i++) {
		unsigned long long start, end;
		unsigned long long delta;
		const char *t;

		start = now();
		t = (*tests[i])(seg, offset);
		end = now();

		delta = (end - start);

		printf("   %s with %s selector: %lluns/iteration\n",
		       t, segdesc, delta / COUNT);
	}
}

struct cpu
{
	char modelname[100];
	int family, model, stepping;
	float speed;
};

static int cpu_details(struct cpu *cpu)
{
	FILE *fp = fopen("/proc/cpuinfo", "r");
	char buf[500];

	if (fp == NULL) {
		perror("open /proc/cpuinfo");
		return 0;
	}

	while(fgets(buf, sizeof(buf), fp) != NULL) {
		char *col = strchr(buf, ':');
		char *val;

		if (col == NULL)
			continue;

		val = col+1;
		while(*val == ' ')
			val++;

		col--;
		while(col > buf && isspace(*col))
			col--;
		col[1] = 0;

		col = strchr(val, '\n');
		if (col)
			*col = 0;

		//printf("name=%s val=%s\n", buf, val);

		if (strcmp(buf, "model name") == 0)
			strcpy(cpu->modelname, val);
		if (strcmp(buf, "cpu family") == 0)
			sscanf(val, "%d", &cpu->family);
		if (strcmp(buf, "model") == 0)
			sscanf(val, "%d", &cpu->model);
		if (strcmp(buf, "stepping") == 0)
			sscanf(val, "%d", &cpu->stepping);
		if (strcmp(buf, "cpu MHz") == 0)
			sscanf(val, "%f", &cpu->speed);

		if (strcmp(buf, "processor") == 0 && strcmp(val, "0") != 0)
			break;
	}
	fclose(fp);

	return 1;
}

int main()
{
	int ds, fs, gs;
	static struct desc desc = {
		.entry_number = 1,
		.base_addr = (unsigned long)segment,
		.limit = sizeof(segment)-1,
		.seg_32bit = 1,
		.contents = 0,
		.read_exec_only = 0,
		.limit_in_pages = 0,
		.seg_not_present = 0,
		.useable = 1,
	};
	int gdtseg, ldtseg;
	struct cpu cpu;
	float speed;

	if (!cpu_details(&cpu)) {
		printf("can't read CPU details");
		return 1;
	}
	speed = cpu.speed;


	if (modify_ldt(1, &desc, sizeof(desc)) == -1)
		perror("modify ldt");
	ldtseg = desc.entry_number * 8 | 4 | 3;

	desc.entry_number = -1;
	if (set_thread_area(&desc) == -1)
		perror("set_thread_area");
	gdtseg = desc.entry_number * 8 | 3;

	asm volatile("mov %%ds, %0; "
		     "mov %%fs, %1; "
		     "mov %%gs, %2"
		     : "=r" (ds), "=r" (fs), "=r" (gs) : : "memory");

	printf("\"%s\" @%gMhz (%d,%d,%d):\n",
	       cpu.modelname, cpu.speed, cpu.family, cpu.model, cpu.stepping);
	printf("ds=%x fs=%x gs=%x ldt=%x gdt=%x %s %s\n",
	       ds, fs, gs, ldtseg, gdtseg,
	       GTOD ? "GTOD" : "CPUTIME",
	       SYNC ? "SYNC" : "");

	test(ds, segment, "data");
	printf("\n");
	test(ldtseg, 0, "LDT");
	printf("\n");
	test(gdtseg, 0, "GDT");

	if (cpu_details(&cpu)) {
		if (speed != cpu.speed)
			printf("cpu speed changed %f->%f?! disable CPUFREQ\n",
			       speed, cpu.speed);
	}

	return 0;
}

--------------000207000703040506000308
Content-Type: text/plain;
 name="results-nosync.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="results-nosync.txt"

"Genuine Intel(R) CPU           T2400  @ 1.83GHz" @1000Mhz (6,14,8):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 0ns/iteration
   fs with data selector: 27ns/iteration
   gs with data selector: 28ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 27ns/iteration
   gs with LDT selector: 28ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 27ns/iteration
   gs with GDT selector: 28ns/iteration

"AMD Athlon(tm) 64 Processor 3500+" @1000Mhz (15,15,0):
fs=0 gs=63 ldt=f gdt=6b
   <none> with data selector: 0ns/iteration
   fs with data selector: 10ns/iteration
   gs with data selector: 10ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 10ns/iteration
   gs with LDT selector: 10ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 10ns/iteration
   gs with GDT selector: 10ns/iteration

"Intel(R) Pentium(R) 4 CPU 1.80GHz" @1817.91Mhz (15,2,4):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 0ns/iteration
   fs with data selector: 30ns/iteration
   gs with data selector: 31ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 40ns/iteration
   gs with LDT selector: 44ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 30ns/iteration
   gs with GDT selector: 31ns/iteration

"Intel(R) Celeron(R) CPU 2.40GHz" @2394.47Mhz (15,2,9):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 0ns/iteration
   fs with data selector: 27ns/iteration
   gs with data selector: 25ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 25ns/iteration
   gs with LDT selector: 25ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 24ns/iteration
   gs with GDT selector: 25ns/iteration

"Pentium 75 - 200" @166.213Mhz (5,2,12):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 1ns/iteration
   fs with data selector: 57ns/iteration
   gs with data selector: 57ns/iteration

   <none> with LDT selector: 1ns/iteration
   fs with LDT selector: 57ns/iteration
   gs with LDT selector: 57ns/iteration

   <none> with GDT selector: 1ns/iteration
   fs with GDT selector: 57ns/iteration
   gs with GDT selector: 57ns/iteration

"AMD-K6(tm) 3D+ Processor" @451.105Mhz (5,9,1):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 0ns/iteration
   fs with data selector: 57ns/iteration
   gs with data selector: 44ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 57ns/iteration
   gs with LDT selector: 44ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 57ns/iteration
   gs with GDT selector: 44ns/iteration

"Pentium III (Coppermine)" @700Mhz (6,8,6):
fs=0 gs=33 ldt=f gdt=3b
   <none> with data selector: 0ns/iteration
   fs with data selector: 46ns/iteration
   gs with data selector: 46ns/iteration

   <none> with LDT selector: 0ns/iteration
   fs with LDT selector: 46ns/iteration
   gs with LDT selector: 47ns/iteration

   <none> with GDT selector: 0ns/iteration
   fs with GDT selector: 46ns/iteration
   gs with GDT selector: 47ns/iteration

--------------000207000703040506000308--
