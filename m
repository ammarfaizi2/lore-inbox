Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVJFPyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVJFPyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVJFPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:54:45 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:60055 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751122AbVJFPyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:54:44 -0400
Message-ID: <43454886.6010608@cosmosbay.com>
Date: Thu, 06 Oct 2005 17:53:42 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <Pine.LNX.4.64.0510060741000.31407@g5.osdl.org> <Pine.LNX.4.61.0510061631260.11029@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510061631260.11029@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 06 Oct 2005 17:53:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins a écrit :
> On Thu, 6 Oct 2005, Linus Torvalds wrote:
> 
>>If you want to notify another CPU that you want the spinlock, then you 
>>need to set the "flag" variable _outside_ of the spinlock.
>>
>>Spinlocks are not fair, not by a long shot. They never have been, and they 
>>never will. Fairness would be extremely expensive indeed.
> 
> 
> That reminds me: ought cond_resched_lock to be doing something more?
> 
> int cond_resched_lock(spinlock_t *lock)
> {
> 	int ret = 0;
> 
> 	if (need_lockbreak(lock)) {
> 		spin_unlock(lock);
> 		cpu_relax();
> 		ret = 1;
> 		spin_lock(lock);
> 	}
> -

Isnt it funny that some bugs can spot other bugs ? :)

break_lock should be declared atomic_t and used like that :

void __lockfunc _##op##_lock(locktype##_t *lock)
{
     preempt_disable();
     for (;;) {
         if (likely(_raw_##op##_trylock(lock)))
             break;
         preempt_enable();
	atomic_inc(&(lock)->break_lock);
         while (!op##_can_lock(lock))
             cpu_relax();
         preempt_disable();
	atomic_dec(&(lock)->break_lock);
     }
}


Eric
