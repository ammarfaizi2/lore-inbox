Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVC2U3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVC2U3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVC2U3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:29:19 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:31688 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261394AbVC2UYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:24:43 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix i386 memcpy
Date: Tue, 29 Mar 2005 23:24:32 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
References: <200503291737.06356.vda@ilport.com.ua> <200503292322.57515.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200503292322.57515.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AmbSCves+tmYZFF"
Message-Id: <200503292324.32775.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AmbSCves+tmYZFF
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 29 March 2005 23:22, Denis Vlasenko wrote:
> This patch shortens non-constant memcpy() by two bytes
> and fixes spurious out-of-line constant memcpy().
> 
> Patch is run-tested (I run on patched kernel right now).
> 
> Benchmark and code generation test program will be mailed as reply.

--Boundary-00=_AmbSCves+tmYZFF
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="bench.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bench.c"

/* Compile with: gcc -Os -fomit-frame-pointer -falign-functions=32 */
/* results:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron
stepping        : 1
cpu MHz         : 1196.236
cache size      : 256 KB
movsl_X wins    : N<=3
rep_movsl wins  : N>=6
('assign' wins always at the cost of much larger code)
*/

#include <time.h>
#include <stdio.h>

#define N 5

#define MOVSL1 __asm__ __volatile__("movsl")
#define MOVSL2 MOVSL1;MOVSL1
#define MOVSL3 MOVSL2;MOVSL1
#define MOVSL4 MOVSL3;MOVSL1
#define MOVSL5 MOVSL4;MOVSL1
#define MOVSL6 MOVSL5;MOVSL1
#define MOVSL7 MOVSL6;MOVSL1
#define MOVSL8 MOVSL7;MOVSL1
#define MOVSL9 MOVSL8;MOVSL1
#define MOVSL10 MOVSL9;MOVSL1
#define MOVSL11 MOVSL10;MOVSL1
#define MOVSL12 MOVSL11;MOVSL1
#define MOVSL13 MOVSL12;MOVSL1
#define MOVSL14 MOVSL13;MOVSL1
#define MOVSL15 MOVSL14;MOVSL1
#define MOVSL16 MOVSL15;MOVSL1
#define MOVSL17 MOVSL16;MOVSL1
#define MOVSL18 MOVSL17;MOVSL1
#define MOVSL19 MOVSL18;MOVSL1

#define MOVSL_(n) MOVSL##n
#define MOVSL(n) MOVSL_(n)

static inline void * rep_movsl(void * to, const void * from, size_t n)
{
	{
		int esi, edi;
		__asm__ __volatile__(
			""
			: "=&D" (edi), "=&S" (esi)
			: "0" ((long) to),"1" ((long) from)
			: "memory"
		);
	}
	{
		int ecx;
		__asm__ __volatile__(
			"rep ; movsl"
			: "=&c" (ecx)
			: "0" (n/4)
		);
	}
}

static inline void * movsl_X(void * to, const void * from, size_t n)
{
	{
		int esi, edi;
		__asm__ __volatile__(
			""
			: "=&D" (edi), "=&S" (esi)
			: "0" ((long) to),"1" ((long) from)
			: "memory"
		);
	}
	MOVSL(N);
}

static inline void * assign(void * to, const void * from, size_t n)
{
	switch (n) {
		case 4:
			*(unsigned long *)to = *(const unsigned long *)from;
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
		default:
			return rep_movsl(to, from, n);
	}
}


char f[256],t[256];

char *fp = f;
char *tp = t;

void r() { rep_movsl(f,t,N*4); }
void m() { movsl_X(f,t,N*4); }
void a() { assign(f,t,N*4); }

void rp() { rep_movsl(fp,tp,N*4); }
void mp() { movsl_X(fp,tp,N*4); }
void ap() { assign(fp,tp,N*4); }

int measure(void (*f)()) {
    int cnt = 0;
    time_t t = time(0);
    while(t==time(0)) f(); /* cache hot */
    t = time(0);
    while(t==time(0)) {
	f(); f(); f(); f(); f(); f(); f(); f();
	f(); f(); f(); f(); f(); f(); f(); f();
	cnt += 16;
    }
    return cnt;
}

int main() {
    printf("On global array:\n");
    printf("rep movsl(%d) per sec: %d\n", N, measure(r));
    printf("  movsl_X(%d) per sec: %d\n", N, measure(m));
    printf("   assign(%d) per sec: %d\n", N, measure(a));
    printf("Indirect:\n");
    printf("rep movsl(%d) per sec: %d\n", N, measure(rp));
    printf("  movsl_X(%d) per sec: %d\n", N, measure(mp));
    printf("   assign(%d) per sec: %d\n", N, measure(ap));
    return 0;
}

--Boundary-00=_AmbSCves+tmYZFF
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="codecheck.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="codecheck.c"

/* Compile with: gcc -Os -fomit-frame-pointer */
/* Check for correctness/size: objdump -r -d <file.o> | $PAGER */

typedef unsigned int size_t;

static inline void * __constant_memcpy(void * to, const void * from, size_t n)
{
#if 1	/* want to do small copies with non-string ops? */
	switch (n) {
		case 0: return to;
		case 1: *(char*)to = *(char*)from; return to;
		case 2: *(short*)to = *(short*)from; return to;
		case 4: *(int*)to = *(int*)from; return to;
#if 1	/* including those doable with two moves? */
		case 3: *(short*)to = *(short*)from;
			*((char*)to+2) = *((char*)from+2); return to;
		case 5: *(int*)to = *(int*)from;
			*((char*)to+4) = *((char*)from+4); return to;
		case 6: *(int*)to = *(int*)from;
			*((short*)to+2) = *((short*)from+2); return to;
		case 8: *(int*)to = *(int*)from;
			*((int*)to+1) = *((int*)from+1); return to;
#endif
	}
#else
	if (!n) return to;
#endif
	{
		/* load esi/edi */
		int esi, edi;
		__asm__ __volatile__(
			""
			: "=&D" (edi), "=&S" (esi)
			: "0" ((long) to),"1" ((long) from)
			: "memory"
		);
	}
	if (n >= 5*4) {
		/* large block: use rep prefix */
		int ecx;
		__asm__ __volatile__(
			"rep ; movsl"
			: "=&c" (ecx)
			: "0" (n/4)
		);
	} else {
		/* small block: don't clobber ecx + smaller code */
		if (n >= 4*4) __asm__ __volatile__("movsl");
		if (n >= 3*4) __asm__ __volatile__("movsl");
		if (n >= 2*4) __asm__ __volatile__("movsl");
		if (n >= 1*4) __asm__ __volatile__("movsl");
	}
	switch (n % 4) {
		/* tail */
		case 0: return to;
		case 1: __asm__ __volatile__("movsb"); return to;
		case 2: __asm__ __volatile__("movsw"); return to;
		default: __asm__ __volatile__("movsw\n\tmovsb"); return to;
	}
}

static inline void * __memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
	"rep ; movsl\n\t"
	"movl %4,%%ecx\n\t"
	"andl $3,%%ecx\n\t"
	"jz 1f\n\t"	/* pay 2 byte penalty for a chance to skip microcoded rep */
	"rep ; movsb\n\t"
	"1:"
	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
	: "memory");
return (to);
}

#define memcpy(t, f, n) \
(__builtin_constant_p(n) ? \
 __constant_memcpy((t),(f),(n)) : \
 __memcpy((t),(f),(n)))

int f00(char *a, char *b) __attribute__ ((section ("ff00"))); int f00(char *a, char *b) { memcpy(a,b,0); }
int f01(char *a, char *b) __attribute__ ((section ("ff01"))); int f01(char *a, char *b) { memcpy(a,b,1); }
int f02(char *a, char *b) __attribute__ ((section ("ff02"))); int f02(char *a, char *b) { memcpy(a,b,2); }
int f03(char *a, char *b) __attribute__ ((section ("ff03"))); int f03(char *a, char *b) { memcpy(a,b,3); }
int f04(char *a, char *b) __attribute__ ((section ("ff04"))); int f04(char *a, char *b) { memcpy(a,b,4); }
int f05(char *a, char *b) __attribute__ ((section ("ff05"))); int f05(char *a, char *b) { memcpy(a,b,5); }
int f06(char *a, char *b) __attribute__ ((section ("ff06"))); int f06(char *a, char *b) { memcpy(a,b,6); }
int f07(char *a, char *b) __attribute__ ((section ("ff07"))); int f07(char *a, char *b) { memcpy(a,b,7); }
int f08(char *a, char *b) __attribute__ ((section ("ff08"))); int f08(char *a, char *b) { memcpy(a,b,8); }
int f09(char *a, char *b) __attribute__ ((section ("ff09"))); int f09(char *a, char *b) { memcpy(a,b,9); }
int f10(char *a, char *b) __attribute__ ((section ("ff10"))); int f10(char *a, char *b) { memcpy(a,b,10); }
int f11(char *a, char *b) __attribute__ ((section ("ff11"))); int f11(char *a, char *b) { memcpy(a,b,11); }
int f12(char *a, char *b) __attribute__ ((section ("ff12"))); int f12(char *a, char *b) { memcpy(a,b,12); }
int f13(char *a, char *b) __attribute__ ((section ("ff13"))); int f13(char *a, char *b) { memcpy(a,b,13); }
int f14(char *a, char *b) __attribute__ ((section ("ff14"))); int f14(char *a, char *b) { memcpy(a,b,14); }
int f15(char *a, char *b) __attribute__ ((section ("ff15"))); int f15(char *a, char *b) { memcpy(a,b,15); }
int f16(char *a, char *b) __attribute__ ((section ("ff16"))); int f16(char *a, char *b) { memcpy(a,b,16); }
int f17(char *a, char *b) __attribute__ ((section ("ff17"))); int f17(char *a, char *b) { memcpy(a,b,17); }
int f18(char *a, char *b) __attribute__ ((section ("ff18"))); int f18(char *a, char *b) { memcpy(a,b,18); }
int f19(char *a, char *b) __attribute__ ((section ("ff19"))); int f19(char *a, char *b) { memcpy(a,b,19); }
int f20(char *a, char *b) __attribute__ ((section ("ff20"))); int f20(char *a, char *b) { memcpy(a,b,20); }
int f21(char *a, char *b) __attribute__ ((section ("ff21"))); int f21(char *a, char *b) { memcpy(a,b,21); }
int f22(char *a, char *b) __attribute__ ((section ("ff22"))); int f22(char *a, char *b) { memcpy(a,b,22); }
int f23(char *a, char *b) __attribute__ ((section ("ff23"))); int f23(char *a, char *b) { memcpy(a,b,23); }
int f24(char *a, char *b) __attribute__ ((section ("ff24"))); int f24(char *a, char *b) { memcpy(a,b,24); }
int f25(char *a, char *b) __attribute__ ((section ("ff25"))); int f25(char *a, char *b) { memcpy(a,b,25); }
int f26(char *a, char *b) __attribute__ ((section ("ff26"))); int f26(char *a, char *b) { memcpy(a,b,26); }
int f27(char *a, char *b) __attribute__ ((section ("ff27"))); int f27(char *a, char *b) { memcpy(a,b,27); }
int f28(char *a, char *b) __attribute__ ((section ("ff28"))); int f28(char *a, char *b) { memcpy(a,b,28); }
int f29(char *a, char *b) __attribute__ ((section ("ff29"))); int f29(char *a, char *b) { memcpy(a,b,29); }
int f3k(char *a, char *b) __attribute__ ((section ("ff3k"))); int f3k(char *a, char *b) { memcpy(a,b,3000); }

int f(char *a, char *b) {
memcpy(a,b,0);
memcpy(a,b,1); 
memcpy(a,b,2); 
memcpy(a,b,3); 
memcpy(a,b,4); 
memcpy(a,b,5); 
memcpy(a,b,6); 
memcpy(a,b,7); 
memcpy(a,b,8); 
memcpy(a,b,9); 
memcpy(a,b,10);
memcpy(a,b,11);
memcpy(a,b,12);
memcpy(a,b,13);
memcpy(a,b,14);
memcpy(a,b,15);
memcpy(a,b,16);
memcpy(a,b,17);
memcpy(a,b,18);
memcpy(a,b,19);
memcpy(a,b,20);
memcpy(a,b,21);
memcpy(a,b,22);
memcpy(a,b,23);
memcpy(a,b,24);
memcpy(a,b,25);
memcpy(a,b,3000);
}

--Boundary-00=_AmbSCves+tmYZFF--

