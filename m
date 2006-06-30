Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWF3Moe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWF3Moe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWF3Moe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:44:34 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:33747 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S932581AbWF3Mod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:44:33 -0400
Date: Fri, 30 Jun 2006 05:36:29 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630123629.GA22381@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73fyhmx1zv.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fyhmx1zv.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Thanks for your feedback. I will make the changes you
requested.

About the context switch code, what about I do the following
in __switch_to():

__kprobes struct task_struct *
__switch_to(struct task_struct *prev_p, struct task_struct *next_p)
{
        struct thread_struct *prev = &prev_p->thread,
                                 *next = &next_p->thread;
        int cpu = smp_processor_id();
        struct tss_struct *tss = &per_cpu(init_tss, cpu);

        if (unlikely(__get_cpu_var(pmu_ctx) || next_p->pfm_context))
                __pfm_ctxswout(prev_p, next_p);

        /*
         * Reload esp0, LDT and the page table pointer:
         */
        tss->rsp0 = next->rsp0;

There is now a single hook and a conditional branch.
this is similar to what you have with the debug registers.

--
-Stephane
