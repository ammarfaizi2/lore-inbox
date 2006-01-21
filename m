Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWAUUxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAUUxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 15:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWAUUxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 15:53:36 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:3986 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932345AbWAUUxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 15:53:36 -0500
Date: Sat, 21 Jan 2006 15:49:46 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: set_bit() is broken on i386?
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: "Valdis.Kletnieks" <Valdis.Kletnieks@vt.edu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200601211553_MC3-1-B65F-A569@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.63.0601210245280.8060@alpha.polcom.net>

(Resent because I forgot the cc: list; Grzegorz, please don't
reply to my original.)

On Sat, 21 Jan 2006, Grzegorz Kulewski wrote:

> > On Fri, 20 Jan 2006 19:53:14 EST, Chuck Ebbert said:
> >> /*
> >>  * setbit.c -- test the Linux set_bit() function
> >>  *
> >>  * Compare the output of this program with and without the
> >>  * -finline-functions option to GCC.
> >>  *
> >>  * If they are not the same, set_bit is broken.

I should have said "If they do not both output '00010001' then
set_bit() is broken."

You got:

> gcc-3.4.5 (GCC) 3.4.5 (Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)
> 00000001
> 00000001
> 
> gcc-4.0.2 (GCC) 4.0.2 (Gentoo 4.0.2-r3, pie-8.7.8)
> 00000001
> 00000001
> 
> gcc-4.1.0-beta20060113 (GCC) 4.1.0-beta20060113  (prerelease)
> 00000001
> 00000001
> 
> gcc (GCC) 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1,

pie-8.7.7.1)
> 00010001
> 00000001

So the macro is broken even without -finline-functions on all but the
last compiler.

I couldn't break this new program, which assumes 'nr' is a constant:

/* 
 * setbit2.c -- test an alternate Linux set_bit() function
 *
 * Compare the output of this program with and without the
 * -finline-functions option to GCC.
 *
 * If they do not both contain two ones, set_bit is broken.
 *
 * Result on i386 with gcc 4.0.2 (Fedora Core 4):
 *
 * [me@d2 t]$ gcc -O2 -o setbit2.ex setbit2.c ; ./setbit2.ex
 * 0x00010001
 * [me@d2 t]$ gcc -O2 -o setbit2.ex -finline-functions setbit2.c ;
./setbit2.ex
 * 0x00010001
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#define inline __attribute__((always_inline))
#define LONGBITS (8 * sizeof(unsigned long))

/*
 * new set_bit() for testing; assumes nr is a compile-time constant
 */
#define ADDR (*(volatile long *) addr)
static inline void set_bit(int nr, volatile unsigned long * addr)
{
        __asm__ __volatile__( "lock ; "
                "btsl %2,%1"
                :"=m" (*(addr + nr/LONGBITS))
                :"m" (*addr),"Ir" (nr),"m" (*(addr + nr/LONGBITS))
                );
}

unsigned long a = 1;
unsigned long b[3];

#define WORD 2
int main(int argc, char * const argv[])
{
        b[WORD] = a;
        set_bit(WORD * LONGBITS + LONGBITS / 2, b);
        printf("0x%08x\n", b[WORD]);
        return 0;
}

-- 
Chuck
