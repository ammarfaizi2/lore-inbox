Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWC0XVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWC0XVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWC0XVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:21:41 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:12680 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751134AbWC0XVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:21:40 -0500
Message-ID: <44287382.4050108@bigpond.net.au>
Date: Tue, 28 Mar 2006 10:21:38 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: prevent high load weight tasks suppressing balancing
References: <4427873A.4010601@bigpond.net.au> <20060327135204.B12364@unix-os.sc.intel.com>
In-Reply-To: <20060327135204.B12364@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 27 Mar 2006 23:21:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> This breaks HT and MC optimizations.. Consider a DP system with each
> physical processor having two HT logical threads.. if there are two 
> runnable processes running on package-0, with this patch scheduler 
> will never move one of those processes to package-1..

Is this an active_load_balance() issue?

If it is then I suggest that the solution is to fix the 
active_load_balance() and associated code so that it works with this 
patch in place.

It would be possible to modify find_busiest_group() and 
find_busiest_queue() so that they just PREFER the busiest group to have 
at least one CPU with more than one running task and the busiest queue 
to have more than one task.  However, this would make the code 
considerably more complex and I'm reluctant to impose that on all 
architectures just to satisfy HT and MC requirements.  Are there 
configuration macros or other means that I can use to exclude this 
(proposed) code on systems where it isn't needed i.e. non HT and MC 
systems or HT and MC systems with only one package.

Personally, I think that the optimal performance of the load balancing 
code has already been considerably compromised by its unconditionally 
accommodating the requirements of active_load_balance() (which you have 
said is now only required by HT and MC systems) and that it might be 
better if active load balancing was separated out into a separate 
mechanism that could be excluded from the build on architectures that 
don't need it.  I can't help thinking that this would result in a more 
efficient active load balancing mechanism as well because the current 
one is very inefficient.

Peter
PS I don't think that this issue is sufficiently important to prevent 
the adoption of the smpnice patches while it's being resolved.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
