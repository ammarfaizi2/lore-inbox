Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWC2P0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWC2P0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWC2P0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:26:48 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:16010 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751170AbWC2P0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:26:47 -0500
Message-ID: <442AA708.3030802@cosmosbay.com>
Date: Wed, 29 Mar 2006 17:26:00 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pierre PEIFFER <pierre.peiffer@bull.net>
CC: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <442A8933.6090408@bull.net>
In-Reply-To: <442A8933.6090408@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 29 Mar 2006 17:26:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre PEIFFER a écrit :
> Ulrich Drepper a écrit :
>>
>> There are no such situations anymore in an optimal userlevel
>> implementation.  The last problem (in pthread_cond_signal) was fixed
>> by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
>> at is simply not optimized for the modern kernels.
>>
> 
> I think there is a misunderstanding here.
> 

Hum... maybe Ulrich was answering to my own message (where I stated that most 
existing multithreaded pay the price of context switches)

(To Ulrich : Most existing applications use glibc <= 2.3.6, where 
FUTEX_WAKE_OP is not used yet AFAIK)

I think your analysis is correct Pierre, but you speak of 'task-switches', 
where there is only a spinlock involved :

On UP case : a wake_up_all() wont preempt current thread : it will task-switch 
only when current thread exits kernel mode.

On PREEMPT case : wake_up_all() wont preempt current thread (because current 
thread is holding bh->lock).

On SMP : the awaken thread will spin some time on bh->lock, but not 
task-switch again.

On RT kernel, this might be different of course...

> FUTEX_WAKE_OP is implemented to handle simultaneously more than one 
> futex in some specific situations (such as pthread_cond_signal).
> 
> The scenario I've described occurred in futex_wake, futex_wake_op and 
> futex_requeue and is _independent_ of the userlevel code.
> 
> All these functions call wake_futex, and then wake_up_all, with the 
> futex_hash_bucket lock still held.
> 
> If the woken thread is immediately scheduled (in wake_up_all), and only 
> in this case (because of a higher priority, etc), it will try to take 
> this lock too (because of the "if (lock_ptr != 0)" statement in 
> unqueue_me), causing two task-switches to take this lock for nothing.
> 
> Otherwise, it will not: lock_ptr is set to NULL just after the 
> wake_up_all call)
> 
> This scenario happens at least in pthread_cond_signal, 
> pthread_cond_broadcast and probably all pthread_*_unlock functions.
> 
> The patch I've proposed should, at least in theory, solve this. But I'm 
> not sure of the correctness...
> 

