Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWEPQAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWEPQAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWEPQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:00:45 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52689
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932109AbWEPQAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:00:41 -0400
Message-Id: <446A137B.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 18:01:31 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH 1/3] reliable stack trace support
References: <4469FC07.76E4.0078.0@novell.com> <20060516150555.GB10760@elte.hu>
In-Reply-To: <20060516150555.GB10760@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ingo Molnar <mingo@elte.hu> 16.05.06 17:05 >>>
>* Jan Beulich <jbeulich@novell.com> wrote:
>> +#ifdef CONFIG_STACK_UNWIND
>> +#include <asm/unwind.h>
>> +#else
>> +#include <asm-generic/unwind.h>
>> +#endif
>
>this wants to become include/linux/unwind.h?

Not really, at least not until IA64 and PARISC get adopted to the same (architecture independent) interface.

>> +#ifdef MODULE_UNWIND_INFO
>> +#include <asm/unwind.h>
>> +#endif
>
>this too could then include <linux/unwind.h>

As above.

>> +DEFINE_SPINLOCK(table_lock);
>
>static?

Oh, yes.

>> +static struct unwind_table *
>> +find_table(unsigned long pc)
>> +{
>> +	int old_removals;
>> +	struct unwind_table *table = NULL;
>> +
>> +	do {
>> +		if (table)
>> +				atomic_dec(&table->users);
>> +		old_removals = atomic_read(&removals);
>
>racy? wants to become rcu?

I don't think so. As far as I can tell, this isn't going to be a problem, it may just result in an extra, normally
unneeded, re-run of the loop.

>> +	spin_lock(&table_lock);
>
>spin_lock_irq?

Why?

>> +	if (init_only && table == last_table) {
>> +		table->init.pc = 0;
>> +		table->init.range = 0;
>> +		return;
>> +	}
>
>SMP and PREEMPT unsafe.

I don't think so, given that this can be called only from the module loader. As Andi pointed out elsewhere, it may even
be unnecessary to do the locking at all.

>> +	spin_lock(&table_lock);
>
>spin_lock_irq().

Again, why?

>> +	if (table) {
>> +		while (atomic_read(&table->users) || atomic_read(&lookups))
>> +			msleep(1);
>> +		kfree(table);
>> +	}
>
>ugh!

???

>> +//todo			case DW_CFA_def_cfa_expression:
>> +//todo			case DW_CFA_expression:
>> +//todo			case DW_CFA_val_expression:
>
>hm?

This means what it says - it needs to be done, and I have no clear understanding of how these expressions are to be
treated, as I've never seen them in use anywhere.

>> +{
>> +	info->task = current;
>> +	arch_unwind_init_running(info, callback, arg);
>> +	return 0;
>
>newline before the return. (this happens in a couple of other places 
>too)

Surely can do that, although I don't see why this should be needed in functions this small.

Jan
