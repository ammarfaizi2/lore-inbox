Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbRFTGah>; Wed, 20 Jun 2001 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbRFTGaS>; Wed, 20 Jun 2001 02:30:18 -0400
Received: from web13908.mail.yahoo.com ([216.136.175.71]:5137 "HELO
	web13908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264848AbRFTGaJ>; Wed, 20 Jun 2001 02:30:09 -0400
Message-ID: <20010620063008.93936.qmail@web13908.mail.yahoo.com>
Date: Tue, 19 Jun 2001 23:30:08 -0700 (PDT)
From: Jun Sun <julian_sun@yahoo.com>
Subject: I hit the BUG() in schedule() ...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running a MIPS machine and hit the following BUG() in
kernel/sched.c:650:

        prepare_to_switch();
        {
                struct mm_struct *mm = next->mm;
                struct mm_struct *oldmm = prev->active_mm;
                if (!mm) {
                        if (next->active_mm) BUG();           <======
                        next->active_mm = oldmm;
                        atomic_inc(&oldmm->mm_count);
                        enter_lazy_tlb(oldmm, next, this_cpu);
                } else {
                        if (next->active_mm != mm) BUG();
                        switch_mm(oldmm, mm, next, this_cpu);
                }


The "next" processor is swapper.

I have not looked at it hard enough, but an initial investigation seems
to reveal the cause trivially.  

In include/linux/sched.h, the "swapper" task is set such that 'mm' is
NULL and 'active_mm' is &init_mm.  So obviously when we switch back to
"swapper" task, we will hit the BUG().  

That sounds little too obvious to be true.  What am I missing here? 

Thanks in advance.  Please cc your reply to this email account.  I
appreciate that.

Jun

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
