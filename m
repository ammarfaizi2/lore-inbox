Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUFQOpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUFQOpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFQOpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:45:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266512AbUFQOpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:45:51 -0400
Message-ID: <40D1AE7F.8080902@redhat.com>
Date: Thu, 17 Jun 2004 10:45:19 -0400
From: Nobuhiro Tachino <ntachino@redhat.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takao Indoh <indou.takao@soft.fujitsu.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
References: <20040617131140.GA26107@elte.hu> <CDC4547371C888indou.takao@soft.fujitsu.com>
In-Reply-To: <CDC4547371C888indou.takao@soft.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Takao Indoh wrote:
> On Thu, 17 Jun 2004 15:11:40 +0200, Ingo Molnar wrote:
> 
> 
>>* Ingo Molnar <mingo@elte.hu> wrote:
>>
>>
>>>* Takao Indoh <indou.takao@soft.fujitsu.com> wrote:
>>>
>>>
>>>>It sounds good because change of timer/tasklet code is not needed.
>>>>But, I wonder whether this method is safe. For example, if kernel
>>>>crashes because of problem of timer, clearing lists may be dangerous
>>>>before dumping. Is it possible to clear all timer lists safely?
>>>
>>>yes it can be done safely - just INIT_LIST_HEAD() all the timer list
>>>heads - like init_timers_cpu() does.
>>
>>obviously this only involves the dumping CPU - no other CPU will run any
>>kernel code. On SMP you should also clear the timer spinlock of the
>>dumping CPU's timer base, if the crash happened within the timer code.
>>
>>	Ingo
> 
> 
> 
> How about this?
> 
> void clear_timers(void)
> {
> 	int j;
> 	tvec_base_t *base;
>        
> 	base = &per_cpu(tvec_bases, smp_processor_id());
> 	spin_lock_init(&base->lock);
> 	for (j = 0; j < TVN_SIZE; j++) {
> 		INIT_LIST_HEAD(base->tv5.vec + j);
> 		INIT_LIST_HEAD(base->tv4.vec + j);
> 		INIT_LIST_HEAD(base->tv3.vec + j);
> 		INIT_LIST_HEAD(base->tv2.vec + j);
> 	}
> 	for (j = 0; j < TVR_SIZE; j++)
> 		INIT_LIST_HEAD(base->tv1.vec + j);
> 
> 	base->timer_jiffies = jiffies;
> }

I think you should save original values to somewhere else, so you can
refer these values from vmcore if you want.
