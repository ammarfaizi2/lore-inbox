Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFMXp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFMXp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFMXpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:45:04 -0400
Received: from mail.suse.de ([195.135.220.2]:17636 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261472AbVFMXez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:34:55 -0400
Date: Tue, 14 Jun 2005 01:34:46 +0200
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Tom Duffy <tduffy@sun.com>, "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050613233445.GK21345@wotan.suse.de>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com> <1118701245.9114.23.camel@duffman> <42AE13EF.8060105@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE13EF.8060105@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> asmlinkage void smp_call_function_interrupt(void)
> {
>        void (*func) (void *info) = call_data->func;
>        void *info = call_data->info;
>        int wait = call_data->wait;
> 
>        ack_APIC_irq();
>        /*
>         * Notify initiating CPU that I've grabbed the data and am
>         * about to execute the function
>         */
>        mb();
>        atomic_inc(&call_data->started);
>        /*
>         * At this point the info structure may be out of scope unless 
> wait==1
>         */
>        irq_enter();
>        (*func)(info);  <--- passed bogus data
> 
> Looks like you jumped through a bogus function pointer.  I'm guessing it 
> has something to do with an unitialized IRQ vector for the CPU speed on 
> one of the cores (simply because it seems somewhat plausible):

What should a "IRQ vector for the CPU speed" be?

> 
> extern u8 irq_vector[NR_IRQ_VECTORS];
> #define IO_APIC_VECTOR(irq)     (irq_vector[irq])
> #define AUTO_ASSIGN             -1
> 
> So irq_vector[AUTO_ASSIGN] = 0xff which could have somehow made it into 
> your function pointer.


Yes, but it is hard to see how that should happen short of massive
memory corruption. call_data is a global variable even.

However after a MCE things can be a bit instable. Maybe it would
be best to use a streamlined panic in this case that doesn't touch
the other CPUs.

-Andi
