Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWFUReh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWFUReh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWFUReh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:34:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38296 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932284AbWFUReg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:34:36 -0400
Date: Wed, 21 Jun 2006 10:34:36 -0700
From: Mike Grundy <grundym@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060621173436.GA7834@localhost.localdomain>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com
References: <20060612131552.GA6647@localhost.localdomain> <1150141217.5495.72.camel@localhost> <20060621042804.GA20300@localhost.localdomain> <1150907920.8295.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150907920.8295.10.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> You misunderstood me here. I'm not talking about storing the same piece
> of data to memory on each processor. I'm talking about isolating all
> other cpus so that the initiating cpu can store the breakpoint to memory
> without running into the danger that another cpu is trying to execute it
> at the same time. But probably the store should be atomic in regard to
> instruction fetching on the other cpus. It is only two bytes and it
> should be aligned.

So maybe something like this:

void smp_replace_instruction(void *info) {
        struct ins_replace_args *parms;
        parms = (struct ins_replace_args *) info;
        *parms->addr = *parms->insn
}

void __kprobes arch_arm_kprobe(struct kprobe *p)
{
        struct ins_replace_args parms;
        parms.addr = p->addr;
        parms.insn = BREAKPOINT_INSTRUCTION

        preempt_disable();
        smp_call_function(smp_replace_instruction, &parms, 0, 1);
        preempt_enable();
}

Thanks
Mike
