Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUFQN7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUFQN7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUFQN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:59:22 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9171 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266502AbUFQN7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:59:13 -0400
Date: Thu, 17 Jun 2004 23:00:28 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040617131140.GA26107@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Message-id: <CDC4547371C888indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617131140.GA26107@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 15:11:40 +0200, Ingo Molnar wrote:

>
>* Ingo Molnar <mingo@elte.hu> wrote:
>
>> * Takao Indoh <indou.takao@soft.fujitsu.com> wrote:
>> 
>> > It sounds good because change of timer/tasklet code is not needed.
>> > But, I wonder whether this method is safe. For example, if kernel
>> > crashes because of problem of timer, clearing lists may be dangerous
>> > before dumping. Is it possible to clear all timer lists safely?
>> 
>> yes it can be done safely - just INIT_LIST_HEAD() all the timer list
>> heads - like init_timers_cpu() does.
>
>obviously this only involves the dumping CPU - no other CPU will run any
>kernel code. On SMP you should also clear the timer spinlock of the
>dumping CPU's timer base, if the crash happened within the timer code.
>
>	Ingo


How about this?

void clear_timers(void)
{
	int j;
	tvec_base_t *base;
       
	base = &per_cpu(tvec_bases, smp_processor_id());
	spin_lock_init(&base->lock);
	for (j = 0; j < TVN_SIZE; j++) {
		INIT_LIST_HEAD(base->tv5.vec + j);
		INIT_LIST_HEAD(base->tv4.vec + j);
		INIT_LIST_HEAD(base->tv3.vec + j);
		INIT_LIST_HEAD(base->tv2.vec + j);
	}
	for (j = 0; j < TVR_SIZE; j++)
		INIT_LIST_HEAD(base->tv1.vec + j);

	base->timer_jiffies = jiffies;
}

And new function which runs timer during dumping is needed,
like __run_timers() does...

Best Regards,
Takao Indoh

