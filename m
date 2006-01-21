Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWAUBqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAUBqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAUBqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:46:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbWAUBqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:46:24 -0500
Date: Fri, 20 Jan 2006 17:48:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, mingo@redhat.com,
       torvalds@osdl.org
Subject: Re: set_bit() is broken on i386?
Message-Id: <20060120174813.7fe5e85a.akpm@osdl.org>
In-Reply-To: <200601201955_MC3-1-B649-DCF5@compuserve.com>
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> /* 
>  * setbit.c -- test the Linux set_bit() function
>  *
>  * Compare the output of this program with and without the
>  * -finline-functions option to GCC.
>  *
>  * If they are not the same, set_bit is broken.
>  *
>  * Result on i386 with gcc 3.3.2 (Fedora Core 2):
>  *
>  * [me@d2 t]$ gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
>  * 00010001
>  * [me@d2 t]$ gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
>  * 00000001
>  */
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> 
> #define inline __attribute__((always_inline))
> 
> /*
>  * From 2.6.15/include/asm-i386/bitops.h -- needs a memory clobber?
>  */
> #define ADDR (*(volatile long *) addr)
> static inline void set_bit(int nr, volatile unsigned long * addr)
> {
> 	__asm__ __volatile__( "lock ; "
> 		"btsl %1,%0"
> 		:"=m" (ADDR)
> 		:"Ir" (nr));
> }
> 
> unsigned long b[2];
> 
> int main(int argc, char * const argv[])
> {
> 	b[1] = 0x1;
> 	set_bit(12 * sizeof(unsigned long), b);
> 	printf("%08x\n", b[1]);
> 	return 0;
> }

Yes, that's a bit of a trap.  Seems that any place where the compiler
"knows" the value of b[1], it'll cache it for the printf() push.

It's actually quite rare for the kernel to manipulate an unsigned long as
both a target of the bitops functions and as a plain old unsigned long.

We have smp_mb__before_clear_bit() and smp_mb__after_clear_bit(), which
need to be explicity used in the special case where we're using clear_bit()
in still-rather-poorly-defined circumstances.

But what you have here is misbehaviour on UP, with set_bit(), due to
compiler actions, which is quite unrelated.  

So I guess we could add the rule "you need to use barrier() before treating
a bitop-manipulated word as a word" or we can go stick all the barriers
into bitops.h.

<does that>

OK, adding nine "memory"s to i386/bitops.h increases my allnoconfig
vmlinux's text from 774636 bytes to 774928 (292 bytes more).

But the problem is that we've gone and altered the foo_bit() _semantics_ on
x86.  So people can now go and write code which will only work properly on
x86 (even more than at present).

It'll be hard to find all the code which treats bitops-targets as scalars. 
It would be easier if we'd defined bitops as operating on a bitop_target_t
or whatever, but we didn't do that.

Personally, I'd like to stick the barriers in there and sleep soundly.  But
we do need to make architectures all behave the same way (and define that
way clearly), and the impact of the new semantics might be worse on some
other architectures.

