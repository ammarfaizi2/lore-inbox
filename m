Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVJUQEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVJUQEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVJUQEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:04:48 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:28312 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S965006AbVJUQEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:04:48 -0400
Message-ID: <4359119E.6050407@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 12:04:46 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu>	 <1129903396.2786.19.camel@laptopd505.fenrus.org>	 <4359051C.2070401@csc.ncsu.edu>	 <1129908179.2786.23.camel@laptopd505.fenrus.org>	 <43590B23.2090101@csc.ncsu.edu> <1129909719.2786.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1129909719.2786.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clearly, it was a mistake to post that code.  I had no idea so many 
people would point out the bleeding obvious.

Here is a more elaborate version--that does the same thing, but more 
lines of code.  In it malloc'd memory is mprotect'd.  The program 
generates a SIGSEGV, a page fault.

----------------
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#include <limits.h>    /* for PAGESIZE */
#ifndef PAGESIZE
#define PAGESIZE 4096
#endif

int
main(void)
{
   char *p;
   char c;

   /* Allocate a buffer; it will have the default
      protection of PROT_READ|PROT_WRITE. */
   p = malloc(1024+PAGESIZE-1);
   if (!p) {
     perror("Couldn’t malloc(1024)");
     exit(errno);
   }

   /* Align to a multiple of PAGESIZE, assumed to be a power of two */
   p = (char *)(((int) p + PAGESIZE-1) & ~(PAGESIZE-1));

   c = p[666];         /* Read; ok */
   p[666] = 42;        /* Write; ok */

   /* Mark the buffer read-only. */
   if (mprotect(p, 1024, PROT_READ)) {
     perror("Couldn’t mprotect");
     exit(errno);
   }

   c = p[666];         /* Read; ok */
   p[666] = 42;        /* Write; program dies on SIGSEGV */

   exit(0);
}


Arjan van de Ven wrote:
>>But I can't mprotect the 66th page I malloc.  And mprotect fails SILENTLY!
> 
> 
> I'm not convinced it does that.. not until the bugs are out of the
> code.... since right now it mprotects the wrong stuff, which sometimes
> overlaps with what you malloced, sometimes not.
> 
> 
