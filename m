Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbTFELqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTFELqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:46:20 -0400
Received: from h007.c015.snv.cp.net ([209.228.35.122]:39675 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id S264622AbTFELqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:46:06 -0400
X-Sent: 5 Jun 2003 11:59:34 GMT
Message-ID: <3EDF4D02.4010205@marcobagni.com>
Date: Thu, 05 Jun 2003 16:00:34 +0200
From: Marco Bagni <m.bagni@marcobagni.com>
Organization: marcobagni
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gcc 3.3-2 complains with arch/i386/meth-emu/poly.h
Content-Type: multipart/mixed;
 boundary="------------040003090809090602030908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003090809090602030908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

I have found a minor bug in the file "arch/i386/meth-emu/poly.h".

It seems that gcc does not allow anymore the "implicit" continuation
of a string in the next line and complains during the compilation of the
file "arch/i386/meth-emu/poly.h" in the execution of the asm directive
of the functions "add_Xsig_Xsig" and "add_two_Xsig". I have added my
"changes" which I submit to your attention.

I know that nobody uses this math-emulation code anymore, but if it has 
to be in Kernel, it must be possible to compile it without problems.

Regards

Marco Bagni

--------------040003090809090602030908
Content-Type: text/x-chdr;
 name="poly.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="poly.h"

/*---------------------------------------------------------------------------+
 |  poly.h                                                                   |
 |                                                                           |
 |  Header file for the FPU-emu poly*.c source files.                        |
 |                                                                           |
 | Copyright (C) 1994,1999                                                   |
 |                       W. Metzenthen, 22 Parker St, Ormond, Vic 3163,      |
 |                       Australia.  E-mail   billm@melbpc.org.au            |
 |                                                                           |
 | Declarations and definitions for functions operating on Xsig (12-byte     |
 | extended-significand) quantities.                                         |
 |                                                                           |
 +---------------------------------------------------------------------------*/

#ifndef _POLY_H
#define _POLY_H

/* This 12-byte structure is used to improve the accuracy of computation
   of transcendental functions.
   Intended to be used to get results better than 8-byte computation
   allows. 9-byte would probably be sufficient.
   */
typedef struct {
  unsigned long lsw;
  unsigned long midw;
  unsigned long msw;
} Xsig;

asmlinkage void mul64(unsigned long long const *a, unsigned long long const *b,
		      unsigned long long *result);
asmlinkage void polynomial_Xsig(Xsig *, const unsigned long long *x,
				const unsigned long long terms[], const int n);

asmlinkage void mul32_Xsig(Xsig *, const unsigned long mult);
asmlinkage void mul64_Xsig(Xsig *, const unsigned long long *mult);
asmlinkage void mul_Xsig_Xsig(Xsig *dest, const Xsig *mult);

asmlinkage void shr_Xsig(Xsig *, const int n);
asmlinkage int round_Xsig(Xsig *);
asmlinkage int norm_Xsig(Xsig *);
asmlinkage void div_Xsig(Xsig *x1, const Xsig *x2, const Xsig *dest);

/* Macro to extract the most significant 32 bits from a long long */
#define LL_MSW(x)     (((unsigned long *)&x)[1])

/* Macro to initialize an Xsig struct */
#define MK_XSIG(a,b,c)     { c, b, a }

/* Macro to access the 8 ms bytes of an Xsig as a long long */
#define XSIG_LL(x)         (*(unsigned long long *)&x.midw)


/*
   Need to run gcc with optimizations on to get these to
   actually be in-line.
   */

/* Multiply two fixed-point 32 bit numbers, producing a 32 bit result.
   The answer is the ms word of the product. */
/* Some versions of gcc make it difficult to stop eax from being clobbered.
   Merely specifying that it is used doesn't work...
 */
static inline unsigned long mul_32_32(const unsigned long arg1,
				      const unsigned long arg2)
{
  int retval;
  asm volatile ("mull %2; movl %%edx,%%eax" \
		:"=a" (retval) \
		:"0" (arg1), "g" (arg2) \
		:"dx");
  return retval;
}

/* Changed by Marco Bagni */
/* Add the 12 byte Xsig x2 to Xsig dest, with no checks for overflow. */
static inline void add_Xsig_Xsig(Xsig *dest, const Xsig *x2)
{
  asm volatile ("movl %1,%%edi; movl %2,%%esi; "
                "movl (%%esi),%%eax; addl %%eax,(%%edi); "
                "movl 4(%%esi),%%eax; adcl %%eax,4(%%edi); "
                "movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);"
                 :"=g" (*dest):"g" (dest), "g" (x2)
                 :"ax","si","di");
}

/* Changed by Marco Bagni */
/* Add the 12 byte Xsig x2 to Xsig dest, adjust exp if overflow occurs. */
/* Note: the constraints in the asm statement didn't always work properly
   with gcc 2.5.8.  Changing from using edi to using ecx got around the
   problem, but keep fingers crossed! */
static inline void add_two_Xsig(Xsig *dest, const Xsig *x2, long int *exp)
{
  asm volatile ("movl %2,%%ecx; movl %3,%%esi; "
                "movl (%%esi),%%eax; addl %%eax,(%%ecx); "
                "movl 4(%%esi),%%eax; adcl %%eax,4(%%ecx); "
                "movl 8(%%esi),%%eax; adcl %%eax,8(%%ecx); "
                "jnc 0f; "
		"rcrl 8(%%ecx); rcrl 4(%%ecx); rcrl (%%ecx); "
                "movl %4,%%ecx; incl (%%ecx); "
                "movl $1,%%eax; jmp 1f; "
                "0: xorl %%eax,%%eax; "
                "1:"
		:"=g" (*exp), "=g" (*dest)
		:"g" (dest), "g" (x2), "g" (exp)
		:"cx","si","ax");
}


/* Negate (subtract from 1.0) the 12 byte Xsig */
/* This is faster in a loop on my 386 than using the "neg" instruction. */
static inline void negate_Xsig(Xsig *x)
{
  asm volatile("movl %1,%%esi; "
               "xorl %%ecx,%%ecx; "
               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi); "
               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi); "
               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi); "
               :"=g" (*x):"g" (x):"si","ax","cx");
}

#endif /* _POLY_H */

--------------040003090809090602030908--

