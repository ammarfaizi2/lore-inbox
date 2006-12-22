Return-Path: <linux-kernel-owner+w=401wt.eu-S1946031AbWLVKnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946031AbWLVKnT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWLVKnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:43:19 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:57781 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946031AbWLVKnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:43:18 -0500
Date: Fri, 22 Dec 2006 02:43:06 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, suresh.b.siddha@intel.com,
       kenneth.w.chen@intel.com, tony.luck@intel.com,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: sched_clock() on i386
Message-ID: <20061222104306.GC1895@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


The perfmon subsystems needs to compute per-CPU duration. It is using
sched_clock() to provide this information. However, it seems they are
big variations in the way sched_clock() is implemented for each architectures,
especially in the accuracy of the returned value (going from TSC to jiffies).

Looking at the i386 implementation, it is not so clear to me what the
actual goal of the function is. I was under the impression that this
function was meant to compute per-CPU time deltas. This is how the
scheduler seems to use it. 

The x86-64 and i386 implementations are quite different. The i386 comment
about NUMA seems to contradict the initial goal of the function.
Why is that?

Does this come from the fact that sched_lock() is used for the time-stamping
printk(). But in this case, like on IA-64, couldn't we define a specific
timing function for printk?


Excerpt from arch/i386/kernel/tsc.c:

unsigned long long sched_clock(void)
{
        unsigned long long this_offset;

        /*
         * in the NUMA case we dont use the TSC as they are not
         * synchronized across all CPUs.
         */
#ifndef CONFIG_NUMA
        if (!cpu_khz || check_tsc_unstable())
#endif
                /* no locking but a rare wrong value is not a big deal */
                return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);

        /* read the Time Stamp Counter: */
        rdtscll(this_offset);

        /* return the value in ns */
        return cycles_2_ns(this_offset);
}


-- 
-Stephane
