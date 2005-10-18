Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVJRJrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVJRJrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 05:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVJRJrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 05:47:24 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:30412 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750731AbVJRJrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 05:47:23 -0400
Message-ID: <4354C476.40901@cosmosbay.com>
Date: Tue, 18 Oct 2005 11:46:30 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: dipankar@in.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <20051017225925.GB1298@us.ibm.com>
In-Reply-To: <20051017225925.GB1298@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 18 Oct 2005 11:46:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney a écrit :
> 
> 
>>+/*
>>+ *  Should we directly call rcu_do_batch() here ?
>>+ *  if (unlikely(rdp->count > 10000))
>>+ *      rcu_do_batch(rdp);
>>+ */
> 
> 
> Good thing that the above is commented out!  ;-)
> 
> Doing this can result in self-deadlock, for example with the following:
> 
> 	spin_lock(&mylock);
> 	/* do some stuff. */
> 	call_rcu(&p->rcu_head, my_rcu_callback);
> 	/* do some more stuff. */
> 	spin_unlock(&mylock);
> 
> void my_rcu_callback(struct rcu_head *p)
> {
> 	spin_lock(&mylock);
> 	/* self-deadlock via call_rcu() via rcu_do_batch()!!! */
> 	spin_unlock(&mylock);
> }
> 
> 
> 						Thanx, Paul

Thanks Paul for reminding us that call_rcu() should not ever call the callback 
function, as very well documented in Documentation/RCU/UP.txt
(Example 3: Death by Deadlock)

But is the same true for call_rcu_bh() ?

I intentionally wrote the comment to remind readers that a low maxbatch can 
trigger OOM in case a CPU is filled by some kind of DOS (network IRQ flood for 
example, targeting the IP dst cache)

To solve this problem, may be we could add a requirement to 
call_rcu_bh/callback functions  : If they have to lock a spinlock, only use a 
spin_trylock() and make them returns a status (0 : sucessfull callback, 1: 
please requeue me)

As most callback functions just kfree() some memory, most of OOM would be cleared.

int my_rcu_callback(struct rcu_head *p)
{
	if (!spin_trylock(&mylock))
		return 1; /* please call me later */
	/* do something here */
	...
	spin_unlock(&mylock);
	return 0;
}

(Changes to rcu_do_batch() are left as an exercice :) )

Eric
