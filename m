Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWEPPF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWEPPF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEPPF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:05:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40081 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751204AbWEPPF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:05:57 -0400
Date: Tue, 16 May 2006 17:05:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 1/3] reliable stack trace support
Message-ID: <20060516150555.GB10760@elte.hu>
References: <4469FC07.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469FC07.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Beulich <jbeulich@novell.com> wrote:

> These are the generic bits needed to enable reliable stack traces 
> based on Dwarf2-like (.eh_frame) unwind information. Subsequent 
> patches will enable x86-64 and i386 to make use of this.

some more detailed review:

> +#ifdef CONFIG_STACK_UNWIND
> +#include <asm/unwind.h>
> +#else
> +#include <asm-generic/unwind.h>
> +#endif

this wants to become include/linux/unwind.h?

> +#ifdef MODULE_UNWIND_INFO
> +#include <asm/unwind.h>
> +#endif

this too could then include <linux/unwind.h>

> +DEFINE_SPINLOCK(table_lock);

static?

> +static struct unwind_table *
> +find_table(unsigned long pc)
> +{
> +	int old_removals;
> +	struct unwind_table *table = NULL;
> +
> +	do {
> +		if (table)
> +				atomic_dec(&table->users);
> +		old_removals = atomic_read(&removals);

racy? wants to become rcu?

> +	spin_lock(&table_lock);

spin_lock_irq?

> +	if (init_only && table == last_table) {
> +		table->init.pc = 0;
> +		table->init.range = 0;
> +		return;
> +	}

SMP and PREEMPT unsafe.

> +	spin_lock(&table_lock);

spin_lock_irq().

> +	if (table) {
> +		while (atomic_read(&table->users) || atomic_read(&lookups))
> +			msleep(1);
> +		kfree(table);
> +	}

ugh!

> +//todo			case DW_CFA_def_cfa_expression:
> +//todo			case DW_CFA_expression:
> +//todo			case DW_CFA_val_expression:

hm?

> +{
> +	info->task = current;
> +	arch_unwind_init_running(info, callback, arg);
> +	return 0;

newline before the return. (this happens in a couple of other places 
too)

	Ingo
