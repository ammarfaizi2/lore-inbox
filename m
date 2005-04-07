Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVDGAv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVDGAv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVDGAv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 20:51:59 -0400
Received: from ozlabs.org ([203.10.76.45]:59353 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262362AbVDGAvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 20:51:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16980.33841.943558.94159@cargo.ozlabs.ibm.com>
Date: Thu, 7 Apr 2005 10:52:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>, Alan Modra <amodra@bigpond.net.au>
Cc: Marty Ridgeway <mridge@us.ibm.com>, linux-kernel@vger.kernel.org,
       ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net
Subject: Re: [ANNOUNCE] April Release of LTP now Available
In-Reply-To: <20050406043001.3f3d7c1c.akpm@osdl.org>
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com>
	<20050406043001.3f3d7c1c.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Marty Ridgeway <mridge@us.ibm.com> wrote:
> >
> > The April release of LTP is now on SourceForge.
> > 
> >  LTP-20050405
> 
> It seems to have an x86ism in it which causes the compile to fail on ppc64:

Looks to me like gcc is objecting to our (ppc64's) _syscall2
definition; Alan Modra (cc'd) can probably say what we're doing wrong.

> socketcall01.c: In function `socketcall':
> socketcall01.c:80: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
> 
> 
> 
> 
> #ifndef _syscall2
> #include <linux/unistd.h>
> #endif
> 
> #include "test.h"
> #include "usctest.h"
> 
> char *TCID = "socketcall01";                             /* Test program identifier.    */
> #ifdef __NR_socketcall
> 
> _syscall2(int ,socketcall ,int ,call, unsigned long *, args);

Here is the definition of _syscall2 (for Alan):

#define __syscall_nr(nr, type, name, args...)				\
	unsigned long __sc_ret, __sc_err;				\
	{								\
		register unsigned long __sc_0  __asm__ ("r0");		\
		register unsigned long __sc_3  __asm__ ("r3");		\
		register unsigned long __sc_4  __asm__ ("r4");		\
		register unsigned long __sc_5  __asm__ ("r5");		\
		register unsigned long __sc_6  __asm__ ("r6");		\
		register unsigned long __sc_7  __asm__ ("r7");		\
		register unsigned long __sc_8  __asm__ ("r8");		\
									\
		__sc_loadargs_##nr(name, args);				\
		__asm__ __volatile__					\
			("sc           \n\t"				\
			 "mfcr %0      "				\
			: "=&r" (__sc_0),				\
			  "=&r" (__sc_3),  "=&r" (__sc_4),		\
			  "=&r" (__sc_5),  "=&r" (__sc_6),		\
			  "=&r" (__sc_7),  "=&r" (__sc_8)		\
			: __sc_asm_input_##nr				\
			: "cr0", "ctr", "memory",			\
			        "r9", "r10","r11", "r12");		\
		__sc_ret = __sc_3;					\
		__sc_err = __sc_0;					\
	}								\
	if (__sc_err & 0x10000000)					\
	{								\
		errno = __sc_ret;					\
		__sc_ret = -1;						\
	}								\
	return (type) __sc_ret

#define __sc_loadargs_0(name, dummy...)					\
	__sc_0 = __NR_##name
#define __sc_loadargs_1(name, arg1)					\
	__sc_loadargs_0(name);						\
	__sc_3 = (unsigned long) (arg1)
#define __sc_loadargs_2(name, arg1, arg2)				\
	__sc_loadargs_1(name, arg1);					\
	__sc_4 = (unsigned long) (arg2)
#define __sc_loadargs_3(name, arg1, arg2, arg3)				\
	__sc_loadargs_2(name, arg1, arg2);				\
	__sc_5 = (unsigned long) (arg3)
#define __sc_loadargs_4(name, arg1, arg2, arg3, arg4)			\
	__sc_loadargs_3(name, arg1, arg2, arg3);			\
	__sc_6 = (unsigned long) (arg4)
#define __sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5)		\
	__sc_loadargs_4(name, arg1, arg2, arg3, arg4);			\
	__sc_7 = (unsigned long) (arg5)
#define __sc_loadargs_6(name, arg1, arg2, arg3, arg4, arg5, arg6)	\
	__sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5);		\
	__sc_8 = (unsigned long) (arg6)

#define __sc_asm_input_0 "0" (__sc_0)
#define __sc_asm_input_1 __sc_asm_input_0, "1" (__sc_3)
#define __sc_asm_input_2 __sc_asm_input_1, "2" (__sc_4)
#define __sc_asm_input_3 __sc_asm_input_2, "3" (__sc_5)
#define __sc_asm_input_4 __sc_asm_input_3, "4" (__sc_6)
#define __sc_asm_input_5 __sc_asm_input_4, "5" (__sc_7)
#define __sc_asm_input_6 __sc_asm_input_5, "6" (__sc_8)

#define _syscall0(type,name)						\
type name(void)								\
{									\
	__syscall_nr(0, type, name);					\
}

#define _syscall1(type,name,type1,arg1)					\
type name(type1 arg1)							\
{									\
	__syscall_nr(1, type, name, arg1);				\
}

#define _syscall2(type,name,type1,arg1,type2,arg2)			\
type name(type1 arg1, type2 arg2)					\
{									\
	__syscall_nr(2, type, name, arg1, arg2);			\
}
