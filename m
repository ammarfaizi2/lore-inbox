Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263520AbTDGQQX (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTDGQQX (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:16:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:19930 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263520AbTDGQPi (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:15:38 -0400
In-Reply-To: <p73vfxqxpz4.fsf@oldwotan.suse.de>
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was
 Re: Makefile  issue)
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, aniruddha.marathe@wipro.com, linux-kernel@vger.kernel.org,
       ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFA555B9E6.223C91CB-ON85256D01.00582D99-86256D01.005A64CB@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 7 Apr 2003 11:26:49 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 04/07/2003 12:26:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm...so I guess the only viable solution for a single test to cover as
many archs as possible, is to explicitly define the number for each arch.
Here's how I would do it Aniruddha:
------------------------------------------
#ifdef __i386__
#define __NR_timer_create 259
#endif

#ifdef __x86_64__
#define __NR_timer_create 222
#endif

#if defined(__ppc__) || defined(__ppc64__)
#define __NR_timer_create 240
#else /* Not defined on this architecture */

#include "test.h"
#include "usctest.h"

int TST_TOTAL = 0;      /* Total number of testcases */

int main()
{
  tst_resm(TCONF,"This system call is not defined for this architecture.");
  tst_exit();
  /* NOT REACHED */
  return(0);
}
#endif /* Not defined on this architecture */

<REST OF TEST HERE>
------------------------------------------

Any comments???

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


                                                                                                                                      
                      Andi Kleen                                                                                                      
                      <ak@suse.de>             To:       Robert Williamson/Austin/IBM@IBMUS                                           
                      Sent by:                 cc:       linux-kernel@vger.kernel.org, aniruddha.marathe@wipro.com,                   
                      ak@suse.de                ltp-list@lists.sourceforge.net                                                        
                                               Subject:  Re: Same syscall is defined to different numbers on 3 different archs(was    
                                                Re: Makefile  issue)                                                                  
                      04/07/2003 10:54                                                                                                
                      AM                                                                                                              
                                                                                                                                      




"Robert Williamson" <robbiew@us.ibm.com> writes:
>
> Obviously, we could add additional code to check for the running arch and
> define the syscall accordingly, however I'm not sure this is the correct
> way to go.  I'm copying our list, as well as the kernel mailing list
about
> this, because I "think" the system calls should be defined to the same
> numbers across all architectures....but I'm not positive.  BTW,  I
attached

No. Linux has traditionally used different syscall numbers for different
architectures. The original ports (alpha etc.) always used the syscall
numbers
of the "native" Unix, so the numbering was often completely different.
Newer ports who weren't concered about such compatibility often did
a renumbering too. For example x86-64 has a completely new
"cache line optimized" ordering.

What should work on most architectures is
(most = someone told me it doesn't work properly on IA64)

#include </path/to/kernel/source/include/asm-<arch>/unistd.h>
(you need the version in the kernel source because many glibc packagers
in their infinite wisdom use an old outdated copy of asm/ usually from
the last stable kernel only)

_syscallN(...)

-Andi




