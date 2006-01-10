Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWAJUpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWAJUpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWAJUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:45:51 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6017 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932622AbWAJUpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:45:50 -0500
Message-ID: <43C41CC8.8000203@colorfullife.com>
Date: Tue, 10 Jan 2006 21:44:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: "Paul E. McKenney" <paulmck@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com> <20060110180954.GA5387@in.ibm.com>
In-Reply-To: <20060110180954.GA5387@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I haven't read the diff, just a short comment]

Dipankar Sarma wrote:

>rcu_state came over from Manfred's RCU_HUGE patch IIRC. I don't
>think it is necessary to allocate rcu_state separately in the
>current mainline RCU code. So, the patch looks OK to me, but
>Manfred might see something that I am not seeing.
>
>  
>
The two-level rcu code was never merged, I still plan to clean it up.

But the idea of splitting the control block and the state is used in the 
current code:
- __rcu_pending() is the hot path, it only performs a read access to 
rcu_ctrlblk.
- write accesses to the rcu_ctrlblk are really rare, they only happen 
when a new batch is started. Especially: independant from the number of 
cpus.

Write access to the rcu_state are common:
- each cpu must write once in each cycle to update it's cpu mask.
- The last cpu then completes the quiescent cycle.

The idea is that rcu_state is more or less write-only and rcu_state is 
read-only. Theoretically, rcu_state could be shared in all cpus caches, 
and there will be only one invalidate when a new batch is started. Thus 
no cacheline trashing due to rcu_pending calls.
I think it would be safer to keep the two state counters in a separate 
cacheline from the spinlock and the cpu mask, but I don't have any hard 
numbers. IIRC the problems with the large SGI systems disappered, and 
everyone was happy. No real benchmark comparisons were made.

--
    Manfred
