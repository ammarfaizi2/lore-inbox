Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVDFGqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVDFGqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 02:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDFGqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 02:46:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13765 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262039AbVDFGqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 02:46:14 -0400
Date: Wed, 6 Apr 2005 08:45:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Paul Jackson <pj@engr.sgi.com>, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050406064550.GA6367@elte.hu>
References: <20050405030447.GA13590@elte.hu> <200504060333.j363XFg23271@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504060333.j363XFg23271@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > tested on x86, the calibration results look ok there.
> 
> Calibration result on ia64 (1.5 GHz, 9 MB), somewhat smaller in this 
> version compare to earlier estimate of 10.4ms.  The optimal setting 
> found by a db workload is around 16 ms.

with idle time in the system i'd first concentrate on getting rid of the 
idle time, and then re-measuring the sweet spot. 9.3 msec is certainly a 
correct ballpark figure.

There will also be workload related artifacts: you may speculatively 
delay migration to another CPU, in the hope of the currently executing 
task scheduling away soon. (I have played with that in the past - the 
scheduler has some idea about how scheduling-happy a task is, based on 
the interactivity estimator.)

The cost matrix on the other hand measures the pure cache-related 
migration cost, on a quiet system. There can be an up to factor 2 
increase in the 'effective migration cost', depending on the average 
length of the scheduling atom of the currently executing task. Further 
increases may happen if the system does not scale and interacting 
migrations slow down each other. So with the 9.3msec estimate, the true 
migration factor might be between 9.3 and 18.6 msecs. The bad news would 
be if the estimator gave a higher value than your sweet spot.

once we have a good estimate of the migration cost between domains 
(ignoring permanent penalties such as NUMA), there's a whole lot of 
things we can do with that, to apply it in a broader sense.

> ---------------------
> | migration cost matrix (max_cache_size: 9437184, cpu: -1 MHz):
> ---------------------
>           [00]    [01]    [02]    [03]
> [00]:     -     9.3(0)  9.3(0)  9.3(0)
> [01]:   9.3(0)    -     9.3(0)  9.3(0)
> [02]:   9.3(0)  9.3(0)    -     9.3(0)
> [03]:   9.3(0)  9.3(0)  9.3(0)    -
> --------------------------------
> | cacheflush times [1]: 9.3 (9329800)
> | calibration delay: 16 seconds
> --------------------------------

ok, the delay of 16 secs is alot better. Could you send me the full 
detection log, how stable is the curve?

	Ingo
