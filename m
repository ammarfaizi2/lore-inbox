Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVGVD2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVGVD2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVGVD2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:28:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262026AbVGVD23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:28:29 -0400
Date: Fri, 22 Jul 2005 13:27:56 +1000
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
Message-Id: <20050722132756.578acca7.akpm@osdl.org>
In-Reply-To: <200507212309_MC3-1-A534-95EF@compuserve.com>
References: <200507212309_MC3-1-A534-95EF@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> 
>   This patch makes restore_fpu() an inline.  When L1/L2 cache are saturated
> it makes a measurable difference.
> 
>   Results from profiling Volanomark follow.  Sample rate was 2000 samples/sec
> (HZ = 250, profile multiplier = 8) on a dual-processor Pentium II Xeon.
> 
> 
> Before:
> 
>  10680 restore_fpu                              333.7500
>   8351 device_not_available                     203.6829
>   3823 math_state_restore                        59.7344
>  -----
>  22854
> 
> 
> After:
> 
>  12534 math_state_restore                       130.5625
>   8354 device_not_available                     203.7561
>  -----
>  20888
> 
> 
> Patch is "obviously correct" and cuts 9% of the overhead.  Please apply.

hm.  What context switch rate is that thing doing?

Is the benchmark actually doing floating point stuff?

We do have the `used_math' optimisation in there which attempts to avoid
doing the FP save/restore if the app isn't actually using math.  But
<ancient recollections> there's code in glibc startup which always does a
bit of float, so that optimisation is always defeated.  There was some
discussion about periodically setting tasks back into !used_math state to
try to restore the optimisation for tasks which only do a little bit of FP,
but nothing actually got done.

> Next step should be to physically place math_state_restore() after
> device_not_available().  Would such a patch be accepted?  (Yes it
> would be ugly and require linker script changes.)

Depends on the benefit/ugly ratio ;)

