Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbVJ1VVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbVJ1VVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbVJ1VVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:21:25 -0400
Received: from unused.mind.net ([69.9.134.98]:22438 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S1751810AbVJ1VVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:21:24 -0400
Date: Fri, 28 Oct 2005 14:15:00 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: Mark Knecht <markknecht@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Overruns are killing my recordings.
In-Reply-To: <5bdc1c8b0510281155w2b86be0bp9f85de02b806d664@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510281403410.26693@echo.lysdexia.org>
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com> 
 <200510271528.28919.diablod3@gmail.com>  <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
  <1130447216.19492.87.camel@mindpipe>  <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
  <1130470852.4363.26.camel@mindpipe>  <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
  <1130525006.4363.44.camel@mindpipe> <5bdc1c8b0510281155w2b86be0bp9f85de02b806d664@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005, Mark Knecht wrote:

> OK then I'll just hang tinght. I've not seen any response on the email
> I sent about 2.6.14-rc5-rt7. I cannot build it. It fails like this:
> 
> CC      arch/x86_64/kernel/sys_x86_64.o
>  CC      arch/x86_64/kernel/x8664_ksyms.o
>  CC      arch/x86_64/kernel/i387.o
>  CC      arch/x86_64/kernel/syscall.o
>  CC      arch/x86_64/kernel/vsyscall.o
> arch/x86_64/kernel/vsyscall.c:57: error: `SEQLOCK_UNLOCKED' undeclared
> here (not in a function)
> make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2
> lightning linux #
> 
> This is a new failure here since -rc5-rt3.

I don't have a 64 bit machine to test on, but the following patch should 
at least make the compiler happy.  This is the only place outside of 
seqlock.h that SEQLOCK_UNLOCKED is used, btw.

If this kernel gives you the 'BUG in get_monotonic_clock_ts' and 'time
warped' warnings, then you may want to look at the '2.6.14-rc4-rt7' lkml
thread for Steven's patch to fix the false positives.

Cheers,
--ww


--- linux-2.6.14-rc5-rt7/arch/x86_64/kernel/vsyscall.c.orig     2005-10-25 14:20:21.000000000 -0700
+++ linux-2.6.14-rc5-rt7/arch/x86_64/kernel/vsyscall.c  2005-10-28 14:08:37.000000000 -0700
@@ -54,7 +54,7 @@
 struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;
 
 extern seqlock_t vsyscall_gtod_lock;
-seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
+seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED(__section_vsyscall_gtod_lock);
 
 
 #include <asm/unistd.h>

