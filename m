Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFOS02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFOS02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVFOS01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:26:27 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:53923 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261262AbVFOS0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:26:06 -0400
Message-ID: <000a01c571df$11af6440$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Gene Heskett" <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>
References: <000b01c57187$ade6b9b0$2800000a@pc365dualp2> <200506150818.24465.gene.heskett@verizon.net>
Subject: Re: .../asm-i386/bitops.h  performance improvements
Date: Wed, 15 Jun 2005 15:18:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Gene Heskett" <gene.heskett@verizon.net>
To: <linux-kernel@vger.kernel.org>
> >
> To what cpu families does this apply?  eg, this may be true for intel,
> but what about amd, via etc?

You tell me -- I've included below a small benchmark that compares them.

These are the results I've gotten so far:

                      LEA       SHL/ADD
---------------------------------------
Pentium Pro 200       88sec     96sec
AMD K6/2-500          29sec     48sec
386SLC(386SX core)  2966sec   4932sec

If LEA isn't fast, those CPU's you mentioned have much bigger problems than
these two inline functions because GCC always generates (with the kernel
default -O2 at least) an LEA for things like this:

unsigned int foo(unsigned int bar)
{
return ((bar<<3)+bar);
}

----------- LEA vs SHL/ADD ----------

#include <stdio.h>
#include <time.h>

#define ITERATIONS 2000000L

#define START  start = time(&start);
#define STOP   stop = time(&stop); delta = stop - start;
#define SUMMARY(s) printf(s " [%ld] seconds\n",delta);
#define TESTLOOP for (i=0; i<ITERATIONS; i++)

static void inline shl(void)
{
__asm__("shll $3,%edi; addl %edi,%eax");
}

static void inline lea(void)
{
__asm__("leal (%eax,%edi,8),%eax");
}


int main(int argc, char *argv[], char *envp[])
{
time_t start, stop, delta;
int i;

START;
   TESTLOOP
 {
#undef  T
#define T shl();shl();shl();shl();shl();shl();shl();shl();shl();shl();
#define T100 T T T T T T T T T T T
#define T1000 T100 T100 T100 T100 T100 T100 T100 T100 T100 T100

__asm__ __volatile__("pushl %eax");
__asm__ __volatile__("pushl %edi");
 T1000 T1000 T1000 T1000 T1000 T1000
__asm__ __volatile__("popl %edi");
__asm__ __volatile__("popl %eax");
 }
STOP;
SUMMARY("SHL/ADD");


/*---------------------------------------------------*/

START;
   TESTLOOP
 {
#undef  T
#define T lea();lea();lea();lea();lea();lea();lea();lea();lea();lea();
#define T100 T T T T T T T T T T T
#define T1000 T100 T100 T100 T100 T100 T100 T100 T100 T100 T100

__asm__ __volatile__("pushl %eax");
__asm__ __volatile__("pushl %edi");
 T1000 T1000 T1000 T1000 T1000 T1000
__asm__ __volatile__("popl %edi");
__asm__ __volatile__("popl %eax");
 }
STOP;
SUMMARY("LEA");

return 0;
}


