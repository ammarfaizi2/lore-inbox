Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVDFDde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVDFDde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVDFDde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:33:34 -0400
Received: from fmr24.intel.com ([143.183.121.16]:59102 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262094AbVDFDdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:33:25 -0400
Message-Id: <200504060333.j363XFg23271@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Paul Jackson" <pj@engr.sgi.com>, <torvalds@osdl.org>,
       <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Tue, 5 Apr 2005 20:33:14 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU5jFe6wV+TMcJXTaGnEA7ytRDNXwAsil9w
In-Reply-To: <20050405030447.GA13590@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Monday, April 04, 2005 8:05 PM
>
> latest patch attached. Changes:
>
>  - stabilized calibration even more, by using cache flushing
>    instructions to generate a predictable working set. The cache
>    flushing itself is not timed, it is used to create quiescent
>    cache  state.
>
>    I only guessed the ia64 version - e.g. i didnt know what 'type'
>    argument to pass to ia64_sal_cache_flush() to get a d/cache
>    flush+invalidate.

It is preferable to use a ia64_pal_cache_flush instead of SAL call. But
it hangs the machine with that pal call.  I will look at it tomorrow.
The type argument for sal_cache_flush is: 1 for icache, 2 for dcache,
and 3 for i+d.


>  - due to more stable results, reduced ITERATIONS from 3 to 2 - this
>    should further speed up calibration.
>
> tested on x86, the calibration results look ok there.

Calibration result on ia64 (1.5 GHz, 9 MB), somewhat smaller in this
version compare to earlier estimate of 10.4ms.  The optimal setting
found by a db workload is around 16 ms.

---------------------
| migration cost matrix (max_cache_size: 9437184, cpu: -1 MHz):

---------------------
          [00]    [01]    [02]    [03]
[00]:     -     9.3(0)  9.3(0)  9.3(0)
[01]:   9.3(0)    -     9.3(0)  9.3(0)
[02]:   9.3(0)  9.3(0)    -     9.3(0)
[03]:   9.3(0)  9.3(0)  9.3(0)    -
--------------------------------
| cacheflush times [1]: 9.3 (9329800)
| calibration delay: 16 seconds
--------------------------------


