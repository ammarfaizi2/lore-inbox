Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSFVBbX>; Fri, 21 Jun 2002 21:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSFVBbW>; Fri, 21 Jun 2002 21:31:22 -0400
Received: from daimi.au.dk ([130.225.16.1]:43399 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316824AbSFVBbV>;
	Fri, 21 Jun 2002 21:31:21 -0400
Message-ID: <3D13D365.A39B1F38@daimi.au.dk>
Date: Sat, 22 Jun 2002 03:31:17 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [RFC] [PATCH] tsc_disable_B2 with "soft" rdtsc
References: <1024613272.5184.176.camel@cog>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> Hello all,
> 
>         Here is my next rev of the tsc-disable patch. This one corrects a
> Configure.in typo (Caught by Gabriel Paubert), and probably more
> controversial, implements a soft rdtsc instruction via do_gettimeofday.
> 
> This avoids the earlier "box won't boot" problems with i686 optimized
> glibc's that called rdtsc. The rdtsc instruction will now be caught, and
> faked returning to the user program the same value of gettimeofday. Yes,
> its pretty hackish, but it works, albeit slowly.

+#ifdef CONFIG_X86_NUMA
+       /* "soft" rdtsc implementation */
+       if(!cpu_has_tsc)
+       {
+               char rdtsc_inst[2] = {0x0f, 0x31}; /*rdtsc opcode*/
+               char* inst_ptr = (char*)regs->eip;
+               if((inst_ptr[0] == rdtsc_inst[0])
+                       &&(inst_ptr[1] == rdtsc_inst[1])){

Any particular reason for puting the opcode in an
array and verify against that instead of just
verifying inst_ptr[i] against the constants?

+                       struct timeval tv;
+                       do_gettimeofday(&tv);
+                       regs->eax = tv.tv_usec;
+                       regs->edx = tv.tv_sec;

Looks like the soft tsc is going to be jumping
rather than runing. It is going to be increasing
at a constat rate most of the time, but will make
a big jump ahead every second. Couldn't the jump
easilly be made a lot smaller by using:
   regs->eax = tv.tv_usec<<2;

Of course this is not completely accurate either,
are we willing to pay the price for a more
accurate version?

+                       regs->eip += 2; /*= size of opcode*/
+                       return;
+               }
+       }
+#endif

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
