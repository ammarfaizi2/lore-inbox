Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUIBOts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUIBOts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBOts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:49:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5558 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268401AbUIBOlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:41:47 -0400
Date: Thu, 2 Sep 2004 16:43:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Charbonnel <thomas@undata.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040902144301.GA11224@elte.hu>
References: <OF3E3C1690.FD6E285E-ON86256F03.004CDD15-86256F03.004CDD4F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3E3C1690.FD6E285E-ON86256F03.004CDD15-86256F03.004CDD4F@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> The test just completed. Over 100 traces (>500 usec) in 25 minutes
> of test runs.
> 
> To recap - this kernel has:
> 
> Downloaded linux-2.6.8.1 from
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.1.tar.bz2
> Downloaded patches from
> http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> http://people.redhat.com/mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7
> ... email saved into mark-offset-tsc-mcount.patch ...
> ... email saved into ens001.patch ...

thanks for the data. There are dozens of traces that show a big latency
for no algorithmic reason, in completely unlocked codepaths. In these
places the CPU seems to have an inexplicable inability to run simple
sequential code that has no looping potential at all.

the NMI samples show that just about any kernel code can be delayed by
this phenomenon - the kernel functions that have critical sections show
up by their likely frequency of use. There doesnt seem to be anything
common to the functions that show these delays, other than that they
have a critical section and that they are running in your workload.

so the remaining theories are:

 - DMA starvation. I've never seen anything on this scale but it's
   pretty much the only thing interacting with a CPU's ability to
   execute code - besides the other CPU running in the system.

   i'd not be surprised if some audio cards tried tricks to do as 
   agressive DMA as physically possible, even violating hw
   specifications - for the purpose of producing skip-free audio output. 
   Do you have another soundcard for testing by any chance? Another 
   option would be to try latencytest driven not by the soundcard IRQ 
   but by /dev/rtc.

 - some sort of SMM handler that is triggered on I/O ops or something. 
   But a number of functions in the traces dont do any I/O ops (port
   instructions like IN or OUT) so it's hard to imagine this to be the 
   case. An externally triggered SMM is possible too, perhaps some
   independent timer triggers a watchdog SMM?

it is nearly impossible for these traces to be caused by the kernel. It
really has to be some hardware effect, based on the data we have so far.

	Ingo
