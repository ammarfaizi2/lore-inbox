Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRLDCQb>; Mon, 3 Dec 2001 21:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRLDCPQ>; Mon, 3 Dec 2001 21:15:16 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:17422 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284327AbRLDBpo>; Mon, 3 Dec 2001 20:45:44 -0500
Message-ID: <3C0C2AAF.6141D797@zip.com.au>
Date: Mon, 03 Dec 2001 17:45:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: j-nomura@ce.jp.nec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor initializationcheck)
In-Reply-To: <3C0B43DC.7A8F582A@zip.com.au>,
		<20011203144615C.nomura@hpc.bs1.fc.nec.co.jp>
		<3C0B43DC.7A8F582A@zip.com.au> <20011203193235S.nomura@hpc.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j-nomura@ce.jp.nec.com wrote:
> 
> Hi,
> 
> Thank you for commenting.
> 
> From: Andrew Morton <akpm@zip.com.au>
> Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor initialization check)
> Date: Mon, 03 Dec 2001 01:20:28 -0800
> 
> > Seems that there is some sort of ordering problem here - someone
> > is calling printk before the MMU is initialised, but after some
> > console drivers have been installed.
> 
> Yes.
> Because smp_init() is later in place than console_init(), printk() can be
> called in such a situation.
> For example, in IA-64, identify_cpu() is called before ia64_mmu_init(),
> while identify_cpu() calls printk() in it.
> I don't think the ordering itself is a problem.
> 
> > I suspect the real fix is elsewhere, but I'm not sure where.
> >
> > Probably a clearer place to put this test would be within
> > printk itself, immediately before the down_trylock.  Does that
> > work?
> 
> The reason I put it in release_console_sem() is that release_console_sem()
> can be called from other functions than printk(), e.g. console_unblank().
> I agree with you that it is clearer but I think it is not sufficient.
> 

I really doubt if any of those paths could be called before
even the MMU is set up.

It seems that the ia64 port has installed some console drivers,
and has then called them before it is ready to do so.  Via printk.

It should not have installed the console drivers that early.  Do
you know what console driver is causing the problem?

If the console driver is not fixable then a more general approach
would be, in printk.c:

#ifndef ARCH_HAS_PRINTK_MAY_BE_USED
#define printk_may_be_used() (1)
#endif

then, in printk() itself:

                if (*p == '\n')
                        log_level_unknown = 1;
        }

+	if (!printk_may_be_used())
+		return printed_len;

        if (!down_trylock(&console_sem)) {
                /*

then, for ia64, give it a printk_may_be_used() function, and
define ARCH_HAS_PRINTK_MAY_BE_USED somewhere.

Or just not install console drivers before they may be safely
used!

-
