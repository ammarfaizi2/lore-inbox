Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUDFLzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbUDFLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:55:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40406 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263657AbUDFLzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:55:23 -0400
Date: Tue, 6 Apr 2004 13:55:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406115539.GA31465@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405221641.GN2234@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> Note if you never run sysscalls you're probably fine with 4:4, I'd
> recommend to lower the timer irq back to 100 HZ though (2000 mm switch
> per second is way too much for number crunching with 4:4, it's way too
> much even with 3:1, with 3:1 is something like 1% slowdown just due
> the more frequent irqs [on a mean 1-2Ghz box], with 4:4 should be a
> lot lot worse than that).  [...]

my measurements do not support your claims wrt. the cost of 4:4.

here is a quick overview of the impact (on pure userspace speed) of
various kernel features turned on. Baseline is a 2.6 kernel with HZ=100,
UP, nohighmem and 3:1 (see [*] for details of the measurement):

   100Hz                100.00%
   100Hz + PAE:           0.00%
   100Hz + 4:4:           0.00%
   100Hz + PAE + 4:4:    -0.01%

   1000Hz:               -1.08%
   1000Hz + PAE:         -1.08%
   1000Hz + 4:4:         -1.11%
   1000Hz + PAE + 4:4:   -1.39%

i.e. 1000Hz itself causes a 1.08% slowdown. Adding 4:4+PAE [***] causes
an additional 0.21% overhead on the 1000Hz kernel.

so your statement:

> [...] (2000 mm switch per second is way too much for number crunching
> with 4:4, [...] with 4:4 should be a lot lot worse than that

is 'very very' incorrect. The cost of 4:4 (on pure userspace code) is
one fifth of the cost of HZ=1000!

4:4, as explained numerous times, does carry costs for a number of
workloads. 4:4 will cause degradation for workloads that switch between
kernel-mode and user-mode heavily, in the 5-10% range. Also, it causes
degradation for threaded applications that do alot of user-kernel copies
(up to 30% degradation). On mixed workloads like kernel compilation the
impact is in the 1-2% range.

But 4:4 does not degrade mostly-userspace (or mostly-kernelspace)
workloads significantly. Also, 4:4 pushes the lowmem limit up way higher
on lots-of-RAM x86 systems, and it gives 3.98 GB of userspace VM, which
no other kernel feature offers.

I'd like to ask you to tame your colorful attacks on the 4:4 feature. If
you dont want to offer the users of -aa the option of 4:4 then that's
your decision but please respect the choice of others.

	Ingo

[*] to get the numbers above, i used a simple userspace program to
    measure 'cycles per sec available to userspace' [**]:

        http://redhat.com/~mingo/4g-patches/loop_print.c

    on an otherwise completely idle system, to the accuracy of 0.02%.
    I ran the measurements 3 times and used the best time. (best/worst
    ratio was always within 0.02%) Kernel version used was
    2.6.4-rc3-mm3. I used a 525 MHz Celeron for testing. The results are
    similar on faster x86 systems.

[**] i also repeated the measurements with a d-TLB-intense workload,
     which should be the worst-case, considering the TLB flushes. [the
     workload iterated through #dTLB pages and touched one byte in each
     page.] This added +0.02% overhead in the 1000Hz + PAE case. (just
     at the statistical noise limit).

[***] non-PAE 4:4 kernels are being used too - there are a fair number 
      of users who run simulation code using 4GB of physical RAM and a 
      pure 4:4 kernel with no highmem features required. For these 4:4
      users the overhead on number-crunching is even smaller, only
      0.03%.
