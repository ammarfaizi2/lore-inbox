Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSKDLgO>; Mon, 4 Nov 2002 06:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSKDLgO>; Mon, 4 Nov 2002 06:36:14 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7430 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264647AbSKDLgK>; Mon, 4 Nov 2002 06:36:10 -0500
Message-Id: <200211041137.gA4Bbip32222@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Improving string.h memcp()y implementation
Date: Mon, 4 Nov 2002 14:29:39 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at this all evening:

static inline void *
__memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
	"rep ; movsl\n\t"
	"testb $2,%b4\n\t"
	"je 1f\n\t"
	"movsw\n"
	"1:\ttestb $1,%b4\n\t"
	"je 2f\n\t"
	"movsb\n"
	"2:"
	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
	:"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
	: "memory");
return (to);
}

Something was not okay there... no, not and ugly style,
something else... finally I saw it:
there are two jumps too many! This is how it can be done:

static inline void *
vda_memcpy(void * to, const void * from, size_t n)
{
	int d0, d1, d2;
	char flag;
	__asm__ __volatile__(
	"	shrl	$1, %%ecx\n"
	"	setc	%3\n"
	"	shrl	$1, %%ecx\n"
	"	rep; movsl\n"
	"	rcll	$1, %%ecx\n"
	"	rep; movsw\n"
	"	movb	%3, %%cl\n"
	"	rep; movsb\n"
		: "=&c" (d0), "=&D" (d1), "=&S" (d2), "=rb" (flag)
		:"0" (n), "1" ((long) to), "2" ((long) from)
		: "memory"
	);
	return (to);
}

But it is still looked not okay...
I think there are 3 intructions too many! Maybe:

static inline void *
vda_memcpy2(void * to, const void * from, size_t n)
{
	int d0, d1, d2, d3;
	__asm__ __volatile__(
	"	shrdl	$2, %%ecx, %3\n"
	"	shrl	$2, %%ecx\n"
	"	rep; movsl\n"
	"	shldl	$2, %3, %%ecx\n"
	"	rep; movsb\n"
		: "=&c" (d0), "=&D" (d1), "=&S" (d2), "=r" (d3)
		: "0" (n), "1" ((long) to), "2" ((long) from)
		: "memory"
	);
	return (to);
}

Just before mailing this, I thought a bit more...

static inline void *
vda_memcpy3(void * to, const void * from, size_t n)
{
        int d0, d1, d2;
        __asm__ __volatile__(
        "       rep; movsl\n"
        "       movl    %4, %%ecx\n"
        "       rep; movsb\n"
                : "=&c" (d0), "=&D" (d1), "=&S" (d2)
                : "0" (n/4), "g" (n&3), "1" ((long) to), "2" ((long) from)
                : "memory"
        );
        return (to);
}

# cat test.c
#include <stdlib.h> // for size_t
#include "string.h" // for abm memcpys
void *to, *from; int sz;
void f2() __attribute__ ((section ("ff2")));
void f3() __attribute__ ((section ("ff3")));
void f4() __attribute__ ((section ("ff4")));
void f5() __attribute__ ((section ("ff5")));
void f2() { memcpy(to,from,sz); }
void f3() { vda_memcpy(to,from,sz); }
void f4() { vda_memcpy2(to,from,sz); }
void f5() { vda_memcpy3(to,from,sz); }

# gcc -c -O2 -fomit-frame-pointer test.c
# objdump -D test.o

Disassembly of section ff2:

00000000 <f2>:
   0:	a1 00 00 00 00       	mov    0x0,%eax
   5:	57                   	push   %edi
   6:	89 c1                	mov    %eax,%ecx
   8:	56                   	push   %esi
   9:	8b 3d 00 00 00 00    	mov    0x0,%edi
   f:	8b 35 00 00 00 00    	mov    0x0,%esi
  15:	c1 e9 02             	shr    $0x2,%ecx
  18:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
  1a:	a8 02                	test   $0x2,%al
  1c:	74 02                	je     20 <f2+0x20>
  1e:	66 a5                	movsw  %ds:(%esi),%es:(%edi)
  20:	a8 01                	test   $0x1,%al
  22:	74 01                	je     25 <f2+0x25>
  24:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  25:	5e                   	pop    %esi
  26:	5f                   	pop    %edi
  27:	c3                   	ret    
Disassembly of section ff3:

00000000 <f3>:
   0:	57                   	push   %edi
   1:	56                   	push   %esi
   2:	8b 3d 00 00 00 00    	mov    0x0,%edi
   8:	8b 35 00 00 00 00    	mov    0x0,%esi
   e:	8b 0d 00 00 00 00    	mov    0x0,%ecx
  14:	d1 e9                	shr    %ecx
  16:	0f 92 c0             	setb   %al
  19:	d1 e9                	shr    %ecx
  1b:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
  1d:	d1 d1                	rcl    %ecx
  1f:	f3 66 a5             	repz movsw %ds:(%esi),%es:(%edi)
  22:	88 c1                	mov    %al,%cl
  24:	f3 a4                	repz movsb %ds:(%esi),%es:(%edi)
  26:	5e                   	pop    %esi
  27:	5f                   	pop    %edi
  28:	c3                   	ret    
Disassembly of section ff4:

00000000 <f4>:
   0:	57                   	push   %edi
   1:	56                   	push   %esi
   2:	8b 3d 00 00 00 00    	mov    0x0,%edi
   8:	8b 35 00 00 00 00    	mov    0x0,%esi
   e:	8b 0d 00 00 00 00    	mov    0x0,%ecx
  14:	0f ac c8 02          	shrd   $0x2,%ecx,%eax
  18:	c1 e9 02             	shr    $0x2,%ecx
  1b:	f3 a5                	repz movsl %ds:(%esi),%es:(%edi)
  1d:	0f a4 c1 02          	shld   $0x2,%eax,%ecx
  21:	f3 a4                	repz movsb %ds:(%esi),%es:(%edi)
  23:	5e                   	pop    %esi
  24:	5f                   	pop    %edi
  25:	c3                   	ret
Disassembly of section ff5:
    
00000000 <f5>:
   0:   8b 0d 00 00 00 00       mov    0x0,%ecx
   6:   57                      push   %edi
   7:   89 c8                   mov    %ecx,%eax
   9:   56                      push   %esi
   a:   8b 3d 00 00 00 00       mov    0x0,%edi
  10:   8b 35 00 00 00 00       mov    0x0,%esi
  16:   83 e0 03                and    $0x3,%eax
  19:   c1 e9 02                shr    $0x2,%ecx
  1c:   f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
  1e:   89 c1                   mov    %eax,%ecx
  20:   f3 a4                   repz movsb %ds:(%esi),%es:(%edi)
  22:   5e                      pop    %esi
  23:   5f                      pop    %edi
  24:   c3                      ret

I think I shall not look there for a while ;)
Please somebody stop me... ;) ;)
--
vda
