Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWCTOST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWCTOST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWCTOSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:18:18 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:7565 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964809AbWCTOSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:18:18 -0500
Date: Mon, 20 Mar 2006 22:24:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] latency-tracing-v2.6.16
Message-ID: <20060320142409.GA5769@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20060320101307.GA15477@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320101307.GA15477@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 11:13:07AM +0100, Ingo Molnar wrote:
> i've released the latency-tracer patch for v2.6.16:
> 
>    http://redhat.com/~mingo/latency-tracing-patches/latency-tracing-v2.6.16.patch
 
Thanks, it helps a lot :)

> max scheduling latencies can be tracked via the enabling of 
> CONFIG_WAKEUP_TIMING. Tracking can be started via the resetting of the 
> max latency:
> 
> 	echo 0 > /proc/sys/kernel/preempt_max_latency
> 
> if CONFIG_LATENCY_TRACE is enabled too then an execution trace will be 
> automatically generated as well, accessible via /proc/latency_trace.

In fact that is not enough.
In include/asm-i386/timex.h, get_cycles() is defined as

        static inline cycles_t get_cycles (void)
        {
                unsigned long long ret=0;
        
        #ifndef CONFIG_X86_TSC
                if (!cpu_has_tsc)
                        return 0;
        #endif
        
        #if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
                rdtscll(ret);
        #endif
                return ret;
        }

If one (as I did at the first attempt) selects a CPU type of
"586/K5/5x86/6x86/6x86MX", he will get nothing from /proc/latency_trace.

So does it make sense to add dependency lines like the following one?

        depends on (!X86_32 || X86_GENERIC || X86_TSC)

Cheers,
Wu
