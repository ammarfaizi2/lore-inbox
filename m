Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263507AbREYDol>; Thu, 24 May 2001 23:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263508AbREYDob>; Thu, 24 May 2001 23:44:31 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:33250 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263507AbREYDoS>; Thu, 24 May 2001 23:44:18 -0400
Message-ID: <3B0DD3A4.2E2AB76D@uow.edu.au>
Date: Fri, 25 May 2001 13:38:12 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: Dawson Engler <engler@csl.stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242110.OAA29766@csl.Stanford.EDU> "from Dawson Engler at
	 May 24, 2001 02:10:00 pm" <200105242308.f4ON8fv8015978@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Dawson Engler writes:
> > Here are 37 errors where variables >= 1024 bytes are allocated on a
> > function's stack.
> 
> First of all, thanks very much for the work you are doing.  It really
> is useful, and a good way to catch those very rare error cases that
> would not otherwise be fixed.
> 
> I'm curious about this stack checker.  Does it check for a single
> stack allocation >= 1024 bytes, or does it also check for several
> individual, smaller allocations which total >= 1024 bytes inside
> a single function?  That would be equally useful.
> 
> On a side note, does anyone know if the kernel does checking if the
> stack overflowed at any time?

There's a little bit of code in show_task() which calculates
how close this task ever got to overrunning its kernel stack:

        {
                unsigned long * n = (unsigned long *) (p+1);
                while (!*n)
                        n++;
                free = (unsigned long) n - (unsigned long)(p+1);
        }
        printk("%5lu %5d %6d ", free, p->pid, p->p_pptr->pid);

SYSRQ-T will trigger this.

However it doesn't work, because do_fork() doesn't zero
out the stack pages when they're created.

-
