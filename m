Return-Path: <linux-kernel-owner+w=401wt.eu-S1751059AbXACSuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXACSuN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbXACSuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:50:13 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:41848 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXACSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:50:11 -0500
In-Reply-To: <000001c72f01$7e4e1e30$8b8c030a@amr.corp.intel.com>
References: <000001c72f01$7e4e1e30$8b8c030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <32AF3D8D-536F-4B9F-908B-C292CB9D6AEE@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: add per task aio wait event condition
Date: Wed, 3 Jan 2007 10:50:06 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 2, 2007, at 10:36 PM, Chen, Kenneth W wrote:

> Zach Brown wrote on Tuesday, January 02, 2007 6:06 PM
>>> In the example you
>>> gave earlier, task with min_nr of 2 will be woken up after 4  
>>> completed
>>> events.
>>
>> I only gave 2 ios/events in that example.
>>
>> Does that clear up the confusion?
>
> It occurs to me that people might not be aware how peculiar the
> current io_getevent wakeup scheme is, to the extend of erratic
> behavior.

Yeah.  I have to admit that I hadn't fully grasped the behaviour of  
the interface when we started this thread.  I realized just how  
insane it was as I was finishing off last night.

> wakes up on event _4_.  If someone ask me to describe algorithm
> of io_getevents wake-up scheme in the presence of multiple
> waiters, I call it erratic and un-deterministic.

I agree completely.  This leads me to assume that essentially *no  
one* has multiple waiters on a context who care about min_nr.  That's  
good news because we can consider it the slow path for now :)

> So I can categorize my patchset as a bug fix instead of a
> performance patch ;-)  Let's be serious, this ought to be fixed
> one way or the other.

Yeah.  How about this:

Start with a cleanup of the event copying loop:

- prefault user event dest with fault_in_pages_writable()
- copy multiple events with _inatomic
- only copy events if min_nr are available
- back off and retry if _inatomic faults
- go back to sleep if too few events are available
- return once a copy doesn't fault

(I guess one could only fall back to prefaulting if the _inatomic  
fails.  I don't know if most event buffers fault or not, I'd guess not.)

This would get rid of the nonsense of consuming events (possibly  
depriving other concurrent waiters) without returning them to  
userspace in a timely fashion.  We get rid of a lot of the per-event- 
delivery overhead that the current loop suffers from.

The controversial part here happens when min_nr is larger than the  
ring size.  In that case I think we should consider min_nr to be  
equal to the ring size.  We'll return fewer events than userspace  
asked for, but it'll still be a big batch.

Does io_getevents() returning +ve but < min_nr raise alarm bells for  
anyone?  It's already done in the timeout case, so arguably code  
already handles it.

Now, on the waking and sleeping side:

- min_nr 0 and 1 as exclusive waiters in ctx->wait
- maintain a rbtree of with min_nr of waiters when > 1
- always wake ctx->wait if it's pending
- wake rb_first of the tree if nr_in_ring >= node->min_nr

The rbtree nodes would have a task_struct pointer and its waker would  
use wake_up_process().  It'd be maintained under the ctx lock.  It'll  
be expensive to maintain in the case of lots of concurrent min_nr > 1  
waiters, but we're declaring that the slow path.

The fast path of a single waiter with > 1 min_nr becomes a pointer  
indirection through the root node of the rb tree.  It should be just  
like the current list_head use in the wait queue.  If the wait queue  
head and rbtree root node share a cacheline in the context then  
checking them both (and almost always only finding one of them  
populated) shouldn't cost the completion path much.

I don't have a strong opinion about using exclusive wake-ups or not  
because I doubt we ever have concurrent waiters in the field.  I'm  
leaning towards avoiding the thundering herd, even if that risks the  
event delivery stream waiting behind a woken waiter who might be  
blocking while prefaulting their destination event buffer.  We should  
wake from io_getevents() before it sleeps or returns, then.  I could  
easily be convinced otherwise.

The wait queue lets us support lots of min_nr == 1 waiters without  
the rbtree maintenance overhead.. they're not as self-evidently  
broken in the current code as multiple min_nr > 1 waiters, so they  
may well be in use?  who knows.  It's easy.

How's this all sound?  I can throw this together if you'd prefer it  
that way.  Though I suspect you'll want to keep hacking on this :).

Finally, let's get a test case for multiple min_nr > 1 waiters into  
autotest.  I'd use our trivial example where the min_nr = 2 waiter  
fires of 3 ios for the concurrent min_nr = 3 waiter to ensure that  
things don't get stuck.

- z
