Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132918AbRDQX4s>; Tue, 17 Apr 2001 19:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132907AbRDQX4k>; Tue, 17 Apr 2001 19:56:40 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:6531 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S132906AbRDQX4Z>;
	Tue, 17 Apr 2001 19:56:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrea@suse.de
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Date: Wed, 18 Apr 2001 00:54:41 +0100
X-Mailer: KMail [version 1.2]
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041800544100.06481@orion.ddi.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is 36bytes. and on 64bit archs the difference is going to be less. 

You're right - I can't add up (must be too late at night), and I was looking 
at wait_queue not wait_queue_head. I suppose that means my implementations 
are then 20 and 16 bytes respectively.

On 64-bit archs the difference will be less, depending on what a "long" is.

> The real waste is the lock of the waitqueue that I don't need, so I should 
> probably keep two list_head in the waitqueue instead of using the 
> wait_queue_head_t and wake_up_process by hand. 

Perhaps you should steal my wake_up_ctx() idea. That means you only need one 
wait queue, and you use bits in the wait_queue flags to note which type of 
waiter is at the front of the queue.

You can then say "wake up the first thing at the front of the queue if it is 
a writer"; and you can say "wake up the first consequtive bunch of things at 
the front of the queue, provided they're all readers" or "wake up all the 
readers in the queue".

> The fast path has to be as fast as yours, if not then the only variable
> that can make difference is the fact I'm not inlining the fast path because
> it's not that small, in such a case I should simply inline the fast path

My point exactly... It can't be as fast because it's _all_ out of line. 
Therefore you always have to go through the overhead of a function call, 
whatever that entails on the architecture of choice.

> I don't care about the scalability of the slow path and I think the slow
> path may even be faster than yours because I don't run additional
> unlock/lock and memory barriers and the other cpus will stop dirtifying my
> stuff after their first trylock until I unlock. 

Except for the optimised case, you may be correct on an SMP configured kernel 
(for a UP kernel, spinlocks are nops).

However! mine runs for as little time as possible with spinlocks held in the 
generic case, and, perhaps more importantly, as little time as possible with 
interrupts disabled.

One other thing: should you be using spin_lock_irqsave() instead of 
spin_lock_irq() in your down functions? I'm not sure it's necessary, however, 
since you probably shouldn't be sleeping if you've got the interrupts 
disabled (though schedule() will cope).

> If you have time to benchmark I'd be interested to see some number. But
> anyways my implementation was mostly meant to be obviously right and
> possible to ovverride with per-arch algorithms

I'll have a go tomorrow evening. It's time to go to bed now I think:-)

David
