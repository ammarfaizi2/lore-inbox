Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWAUAzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWAUAzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWAUAzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:55:39 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:12998 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932234AbWAUAzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:55:39 -0500
Date: Fri, 20 Jan 2006 19:53:14 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: set_bit() is broken on i386?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200601201955_MC3-1-B649-DCF5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* 
 * setbit.c -- test the Linux set_bit() function
 *
 * Compare the output of this program with and without the
 * -finline-functions option to GCC.
 *
 * If they are not the same, set_bit is broken.
 *
 * Result on i386 with gcc 3.3.2 (Fedora Core 2):
 *
 * [me@d2 t]$ gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
 * 00010001
 * [me@d2 t]$ gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
 * 00000001
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#define inline __attribute__((always_inline))

/*
 * From 2.6.15/include/asm-i386/bitops.h -- needs a memory clobber?
 */
#define ADDR (*(volatile long *) addr)
static inline void set_bit(int nr, volatile unsigned long * addr)
{
	__asm__ __volatile__( "lock ; "
		"btsl %1,%0"
		:"=m" (ADDR)
		:"Ir" (nr));
}

unsigned long b[2];

int main(int argc, char * const argv[])
{
	b[1] = 0x1;
	set_bit(12 * sizeof(unsigned long), b);
	printf("%08x\n", b[1]);
	return 0;
}
-- 
Chuck
Currently reading: _Sun Of Suns_ by Karl Schroeder
