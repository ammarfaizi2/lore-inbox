Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJMMRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJMMRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJMMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:17:51 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:16197 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750702AbVJMMRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:17:51 -0400
Message-ID: <434E521F.40100@sw.ru>
Date: Thu, 13 Oct 2005 16:25:03 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <20051011235017.21719.qmail@science.horizon.com>
In-Reply-To: <20051011235017.21719.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the interesting idea provided below.
I will try to implement it.

Kirill

>>The whole story started when we wrote the following code:
>>
>>void XXX(void)
>>{
>>	/* ints disabled */
>>restart:
>>	spin_lock(&lock);
>>	do_something();
>>	if (!flag)
>>		need_restart = 1;
>>	spin_unlock(&lock);
>>	if (need_restart)
>>		goto restart;	<<<< LOOPS 4EVER ON AMD!!!
>>}
>>
>>void YYY(void)
>>{
>>	spin_lock(&lock);	<<<< SPINS 4EVER ON AMD!!!
>>	flag = 1;
>>	spin_unlock(&lock);
>>}
>>
>>function XXX() starts on CPU0 and begins to loop since flag is not set, 
>>then CPU1 calls function YYY() and it turns out that it can't take the 
>>lock any arbitrary time.
> 
> 
> The right thing to do here is to wait for the flag to be set *outside*
> the lock, and then re-validate inside the lock:
> 
> void XXX(void)
> {
> 	/* ints disabled */
> restart:
> 	spin_lock(&lock);
> 	do_something();
> 	if (!flag)
> 		need_restart = 1;
> 	spin_unlock(&lock);
> 	if (need_restart) {
> 		while (!flag)
> 			cpu_relax();
> 		goto restart;
> 	}
> }
> 
> This way, XXX() keeps the lock dropped for as long as it takes for
> YYY() to notice and grab it.
> 
> 
> However, I realize that this is of course a simplified case of some real
> code, where even *finding* the flag requires the spin lock.
> 
> The generic solution is to have a global "progress" counter, which
> records "I made progress toward setting flag", that XXX() can
> busy-loop on:
> 
> int progress;
> 
> void XXX(void)
> {
> 	int old_progress;
> 	/* ints disabled */
> restart:
> 	spin_lock(&lock);
> 	do_something();
> 	if (!flag) {
> 		old_progress = progress;
> 		need_restart = 1;
> 	}
> 	spin_unlock(&lock);
> 	if (need_restart) {
> 		while (progress == old_progress)
> 			cpu_relax();
> 		goto restart;
> 	}
> }
> 
> void YYY(void)
> {
> 	spin_lock(&lock);
> 	flag = 1;
> 	progress++;
> 	spin_unlock(&lock);
> }
> 
> It may be that in your data structure, there is one or a series of
> fields that already exist that you can use for the purpose.  The goal
> is to merely detect *change*, so you can reacquire the lock and test
> definitively.  It's okay to read freed memory while doing this, as long as
> you can be sure that:
> - The memory read won't oops the kernel, and
> - You don't end up depending on the value of the freed memory to
>   get you out of the stall.
> 


