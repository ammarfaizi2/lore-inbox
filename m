Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSL1XkP>; Sat, 28 Dec 2002 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbSL1XkP>; Sat, 28 Dec 2002 18:40:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34828 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266120AbSL1XkN>; Sat, 28 Dec 2002 18:40:13 -0500
Date: Sat, 28 Dec 2002 23:48:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Trying (and failing) to eliminate __put_user warnings
Message-ID: <20021228234831.C5217@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to find an implementation of __put_user which supports
everything Linux needs it to support (8-bit, 16-bit, 32-bit and 64-bit
sizes) without producing any warnings.

It would appear that I've hit a brick wall - everything was fine until
the 64-bit requirement came in with filldir64().

The problem is where we do things like:

	void *foo = some_pointer;
	void **bar = some_userspace_pointer;

	__put_user(foo, bar);

The above is very similar to the siginfo code in kernel/signal.c, which
produces warnings for me.  This code looks fine on the surface, but when
you start looking beneath the macro mess that's known as __put_user(),
you start running into problems.

The problem is this.  To support 64-bit put_user on ARM, we need to cast
the first argument to an unsigned long long (or u64) before we can split
it into two 32-bit quantities for the asm code to use.  We are not able
to pass 64-bit quantities in through GCC's asm() syntax.  The code we
use is:

#define __put_user(x,p)	\
	__put_user_nocheck((__typeof(*(p)))(x),(p),sizeof(*(p)))

#define __put_user_nocheck(x,ptr,size)				\
({								\
	long __pu_err = 0;					\
	unsigned long __pu_addr = (unsigned long)(ptr);		\
	__put_user_size((x),__pu_addr,(size),__pu_err);		\
	__pu_err;						\
})

#define __put_user_size(x,ptr,size,retval)			\
do {								\
	switch (size) {						\
	...
	case 8:	__put_user_asm_dword(x,ptr,retval);	break;	\
	...
	}							\
} while (0)

#define __put_user_asm_dword(x,__pu_addr,err)			\
({								\
	unsigned long long __temp = (unsigned long long)x;	\
	__asm__ __volatile__(					\
	"1:	strt	%1, [%2], #0\n"				\
	"2:	strt	%3, [%4], #0\n"				\
	"3:\n"							\
	"	.section .fixup,\"ax\"\n"			\
	"	.align	2\n"					\
	"4:	mov	%0, %5\n"				\
	"	b	3b\n"					\
	"	.previous\n"					\
	"	.section __ex_table,\"a\"\n"			\
	"	.align	3\n"					\
	"	.long	1b, 4b\n"				\
	"	.long	2b, 4b\n"				\
	"	.previous"					\
	: "=r" (err)						\
	: "r" (__temp), "r" (__pu_addr),			\
	  "r" (__temp >> 32), "r" (__pu_addr + 4),		\
	  "i" (-EFAULT), "0" (err)				\
	: "cc");						\
})

However, the above code fragments results in the u64 implementation of
__put_user casting a void * to an unsigned long long.  This causes a
nice warning from the compiler - "cast from pointer to integer of
different size"

This means that for each and every usage of __put_user to store a
pointer to user space (eg, siginfo) we will produce a compiler warning.

I can see four possible solutions:

1. split out storing pointers from the integer __put_user
2. split out storing u64 quantities from __put_user
3. someone (not me) needs to work out how to fool the compiler into
   working the way Linux requires it to without producing warnings.
4. the compiler is buggy and I need to direct this report to the
   gcc bug database (all gcc versions >= 2.95 appear to produce
   this warning.)

Any further (more sane) suggestions welcome.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

