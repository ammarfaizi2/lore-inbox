Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUFQMoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUFQMoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFQMon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:44:43 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14770 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266457AbUFQMok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:44:40 -0400
Date: Thu, 17 Jun 2004 21:45:55 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040617120020.GA30691@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@muc.de>
Message-id: <C8C45469080F08indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617120020.GA30691@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for comment. After I fix these codes, I'll post new version of
diskdump.

Best Regards,
Takao Indoh


>> diff -Nur linux-2.6.6.org/include/linux/diskdumplib.h linux-2.6.6/include
>> /linux/diskdumplib.h
>> --- linux-2.6.6.org/include/linux/diskdumplib.h	1970-01-01 09:00:00.
>> 000000000 +0900
>> +++ linux-2.6.6/include/linux/diskdumplib.h	2004-06-17 18:28:01.000000000
>>  +0900
>
>Should probably just go to linux/dump.h or dump_priv.h
>
>> diff -Nur linux-2.6.6.org/include/linux/interrupt.h linux-2.6.6/include/
>> linux/interrupt.h
>> --- linux-2.6.6.org/include/linux/interrupt.h	2004-06-04 21:22:09.
>> 000000000 +0900
>> +++ linux-2.6.6/include/linux/interrupt.h	2004-06-17 18:28:01.000000000 +

>> 0900
>> @@ -7,6 +7,7 @@
>>  #include <linux/linkage.h>
>>  #include <linux/bitops.h>
>>  #include <linux/preempt.h>
>> +#include <linux/diskdumplib.h>
>>  #include <asm/atomic.h>
>>  #include <asm/hardirq.h>
>>  #include <asm/ptrace.h>
>> @@ -172,6 +173,11 @@
>>  
>>  static inline void tasklet_schedule(struct tasklet_struct *t)
>>  {
>> +	if (crashdump_mode()) {
>> +		diskdump_tasklet_schedule(t);
>> +		return;
>> +	}
>> +
>>  	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
>>  		__tasklet_schedule(t);
>>  }
>
>Please sprinclde unlikely's all over here.  Also the above could be
>shortened to
>
>static inline void tasklet_schedule(struct tasklet_struct *t)
>{
>	if (unlikely(crashdump_mode()))
>		diskdump_tasklet_schedule(t);
>	else if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
>		__tasklet_schedule(t);
>}
>
>> +int diskdump_schedule_work(struct work_struct *work)
>> +{
>> +	list_add_tail(&work->entry, &diskdump_workq);
>> +	return 1;
>> +}
>
>Should probably just inlined, I guess the function call is bigger
>than all of list_add_tail.
>
>> +void diskdump_add_timer(struct timer_list *timer)
>> +{
>> +	timer->base = (void *)1;
>> +	list_add(&timer->entry, &diskdump_timers);
>> +}
>
>dito.
>
>> +	/* run timers */
>> +	list_for_each_safe(t, n, &diskdump_timers) {
>> +		timer = list_entry(t, struct timer_list, entry);
>
>list_for_each_entry_safe here please.
>
>> @@ -255,6 +255,10 @@
>>  {
>>  	BUG_ON(!timer->function);
>>  
>> +	if (crashdump_mode()) {
>> +		return diskdump_mod_timer(timer, expires);
>> +	}
>
>please remove the superflous braces here.
>
