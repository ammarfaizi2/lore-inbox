Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTFXQIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTFXQId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:08:33 -0400
Received: from pl543.nas911.n-yokohama.nttpc.ne.jp ([210.139.39.31]:48835 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S262488AbTFXQIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:08:13 -0400
Message-Id: <m19UqZT-000H3mC@standard.erephon>
Date: Wed, 25 Jun 2003 01:23:03 +0900 (JST)
To: linux-kernel@vger.kernel.org
From: ishikawa@yk.rim.or.jp
Subject: Patch to (x86) 2.4.21 asm/system.h to suppress warning from GCC 3.3.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to (x86) asm/system.h to suppress warning by GCC 3.3.

I would like to suggest a patch to x86 asm/system.h of the kernel
2.4.21.  Patch is attached at the end.

GCC version.
gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.3/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i386-linux
Thread model: posix
gcc version 3.3 (Debian)


Background:

linux kernel 2.4.21 asm/system.h header produces warnings when
compiled using GCC 3.3 (Debian).

For example, when I compile lm_sensors package
 ( See the following URL for lm_sensors 
   http://www2.lm-sensors.nu/~lm78/index.html )
I get many warnings similar to the following.

--- quote from compilation ---
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21/build/include  -nostdinc -I /usr/lib/gcc-lib/i386-linux/3.3/include  -Wall -O2   -c kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
In file included from /lib/modules/2.4.21/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.21/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.21/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.21/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.21/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.21/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.21/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.21/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.21/build/include/linux/pci.h:654,
                 from kernel/busses/i2c-nforce2.c:35:
/lib/modules/2.4.21/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.21/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:148: warning: `len' might be used uninitialized in this function
--- end quote.

Note the warning message "dereferencing type-punned pointer will break
strict-aliasing rules".

>From (x86) asm/system.h, we find the following code on line 190

    #define ll_low(x)	*(((unsigned int*)&(x))+0)
    #define ll_high(x)	*(((unsigned int*)&(x))+1)

    static inline void __set_64bit_var (unsigned long long *ptr,
			     unsigned long long value)
    {
--->	__set_64bit(ptr,ll_low(value), ll_high(value));
    }

We see that the "unsigned long long" value is handled using ll_low()
and ll_high() macros, which indeed play loose with pointers.

My suggested patch is basically as follows.

static inline void __set_64bit_var (unsigned long long *ptr,
			     unsigned long long value)
   {
     union { 
      unsigned long long ull;
      unsigned int ui2[2];
     } t;
    t.ull = value;
     __set_64bit(ptr,t.ui2[0], t.ui2[1]);

  }

Verification:

I checked that the generated assembly language code
for my modification is not that bad.
Indeed the modified code generates a little cleaner output
than the current C code does IMHO.
(Or am I missing something? Maybe )

The modified code also works correctly as far as I can see.

So I suggest that we modify the asm/system.h (for x86)
(Maybe someone can offer better fix which may not
break hidden assumptions/requirements missed by me.
In any case, suppressing warnings from a system-supplied
header ought to be a priority.)

Testing was done by the following C code.
---
#include <stdio.h>
#include <stdlib.h>

/* The following inlines were taken straight from
asm/system.h 
*/

static inline void __set_64bit (unsigned long long * ptr,
		unsigned int low, unsigned int high)
{
	__asm__ __volatile__ (
		"\n1:\t"
		"movl (%0), %%eax\n\t"
		"movl 4(%0), %%edx\n\t"
		"lock cmpxchg8b (%0)\n\t"
		"jnz 1b"
		: /* no outputs */
		:	"D"(ptr),
			"b"(low),
			"c"(high)
		:	"ax","dx","memory");
}

static inline void __set_64bit_constant (unsigned long long *ptr,
						 unsigned long long value)
{
	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
}
#define ll_low(x)	*(((unsigned int*)&(x))+0)
#define ll_high(x)	*(((unsigned int*)&(x))+1)

static inline void __set_64bit_var (unsigned long long *ptr,
			 unsigned long long value)
{
	__set_64bit(ptr,ll_low(value), ll_high(value));
}

/* Here is my modification.
   Does not produce warning from the compiler GCC 3.3,
   and seem to generate cleaner code.
 */

static inline void __set_64bit_var_2 (unsigned long long *ptr,
			 unsigned long long value)
{
  union { 
    unsigned long long ull;
    unsigned int ui2[2];
  } t;
  t.ull = value;
    __set_64bit(ptr,t.ui2[0], t.ui2[1]);
}




unsigned long long g_ull;
unsigned long long *g_ullptr;

int
test2()
{
  __set_64bit_var(g_ullptr, g_ull);
  return 0;
}
int test3()
{

  __set_64bit_var_2(g_ullptr, g_ull);
  return 0;
}

int
main()
{
  unsigned long long t;
  g_ullptr = &t;

  g_ull = 0x1100220033004400ull;

  test2();

  if(t != g_ull)
    abort();

  g_ull = 0x0011002200330044ull;

  test3();

  if( t != g_ull )
    abort();

  exit(0);
}

---
gcc -Wall -O2 -S test-macro.c
test-macro.c: In function `__set_64bit_var':
test-macro.c:35: warning: dereferencing type-punned pointer will break strict-aliasing rules
test-macro.c:35: warning: dereferencing type-punned pointer will break strict-aliasing rules
cat test-macro.s
	.file	"test-macro.c"
	.text
	.p2align 2,,3
.globl test2
	.type	test2, @function
test2:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%ebx
	subl	$8, %esp
	movl	g_ull, %eax
	movl	g_ull+4, %edx
	movl	%eax, -16(%ebp)
	movl	g_ullptr, %edi
	movl	%edx, -12(%ebp)
	movl	-16(%ebp), %ebx
	movl	-12(%ebp), %ecx
#APP
	
1:	movl (%edi), %eax
	movl 4(%edi), %edx
	lock cmpxchg8b (%edi)
	jnz 1b
#NO_APP
	addl	$8, %esp
	popl	%ebx
	xorl	%eax, %eax
	popl	%edi
	leave
	ret
	.size	test2, .-test2
	.p2align 2,,3
.globl test3
	.type	test3, @function
test3:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%ebx
	movl	g_ullptr, %edi
	movl	g_ull, %ebx
	movl	g_ull+4, %ecx
#APP
	
1:	movl (%edi), %eax
	movl 4(%edi), %edx
	lock cmpxchg8b (%edi)
	jnz 1b
#NO_APP
	popl	%ebx
	xorl	%eax, %eax
	popl	%edi
	leave
	ret
	.size	test3, .-test3
	.p2align 2,,3
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	andl	$-16, %esp
	leal	-16(%ebp), %eax
	movl	%eax, g_ullptr
	movl	$855655424, g_ull
	movl	$285221376, g_ull+4
	call	test2
	movl	-12(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	g_ull, %eax
	movl	g_ull+4, %edx
	movl	%ebx, %esi
	xorl	%edx, %esi
	xorl	%ecx, %eax
	orl	%eax, %esi
	jne	.L10
	movl	$3342404, g_ull
	movl	$1114146, g_ull+4
	call	test3
	movl	-12(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	g_ull, %eax
	movl	g_ull+4, %edx
	movl	%ebx, %esi
	xorl	%edx, %esi
	xorl	%ecx, %eax
	orl	%eax, %esi
	je	.L9
.L10:
	call	abort
.L9:
	subl	$12, %esp
	pushl	$0
	call	exit
	.size	main, .-main
	.comm	g_ull,8,8
	.comm	g_ullptr,4,4
	.ident	"GCC: (GNU) 3.3 (Debian)"
---
Run the program.

gcc -Wall -O2 test-macro.c
test-macro.c: In function `__set_64bit_var':
test-macro.c:35: warning: dereferencing type-punned pointer will break strict-aliasing rules
test-macro.c:35: warning: dereferencing type-punned pointer will break strict-aliasing rules

./a.out

(no error.)

PS: i am not on linux-kernel and I would appreciate it if 
follow-up is cc: to me as well.

PPS: I wondered why linux kernel compilatio itsefl didn't produce
the warning and found the use of -fno-strict-aliasing on gcc command
line. Hmm...

PPPS: In any case, the code produced seem to be cleaner (and possibly
faster. Will someone count the cycles?) and so the patch seems
preferable. 

[end of memo]



