Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSLCIyA>; Tue, 3 Dec 2002 03:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSLCIyA>; Tue, 3 Dec 2002 03:54:00 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:17045 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264962AbSLCIx7>; Tue, 3 Dec 2002 03:53:59 -0500
Message-Id: <4.3.2.7.2.20021203094649.00b596c0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 03 Dec 2002 10:01:55 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.19/20, 2.5 missing P4 ifdef ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I think you are mistaken. The prefetch instructions came to
 > Intel CPUs with SSE. There are no (afair) no SSE Pentium II's.

Correct.
And while we are at it, any kernel guru like to take a squint at
include/asm-i386 and arch/i386 ?
It seems to me that it should be possible to get a lot more out
of P3's and P4's.
Taking the example of the (misnamed) 3DNOW page_clear code,
for the P4(SSE2) it could be implemented as :

         __asm__ __volatile__ (
                 "  pxor %%xmm0, %%xmm0\n" : :
         );

         for(i=0;i<4096/128;i++)
         {
                 __asm__ __volatile__ (
                 "  movntdq %%xmm0, (%0)\n"
                 "  movntdq %%xmm0, 16(%0)\n"
                 "  movntdq %%xmm0, 32(%0)\n"
                 "  movntdq %%xmm0, 48(%0)\n"
                 "  movntdq %%xmm0, 64(%0)\n"
                 "  movntdq %%xmm0, 80(%0)\n"
                 "  movntdq %%xmm0, 96(%0)\n"
                 "  movntdq %%xmm0, 112(%0)\n"
                 : : "r" (page) : "memory");
                 page+=128;
         }
         /* since movntdq is weakly-ordered, a "sfence" is needed to become
          * ordered again.
          */
         __asm__ __volatile__ (
                 "  sfence \n" : :
         );

I'm quite willing to be flamed on this :-)

Margit 

