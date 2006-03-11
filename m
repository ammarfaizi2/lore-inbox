Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWCKFjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWCKFjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 00:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWCKFjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 00:39:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50844 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751080AbWCKFjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 00:39:51 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidhash: Refactor the pid hash table.
References: <m1irqmi5ma.fsf@ebiederm.dsl.xmission.com>
	<20060310154524.3c293b8f.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 10 Mar 2006 22:39:12 -0700
In-Reply-To: <20060310154524.3c293b8f.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 10 Mar 2006 15:45:24 -0800")
Message-ID: <m1oe0dh75r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> +fastcall void put_pid(struct pid *pid)
>> +{
>> +	if (!pid)
>> +		return;
>> +	if ((atomic_read(&pid->count) == 1) ||
>> +	     atomic_dec_and_test(&pid->count))
>> +		kmem_cache_free(pid_cachep, pid);
>> +}
>
> This looks odd.  It's an RCU callback so it's asynchronous.  It doesn't
> take any locks, so if anyone else can have a ref on this thing then the
> refcount can change at any time.
>
> And both sides of the || are basically equivalent.  Perhaps you meant &&. 
> But I'm more worried by the apparent raciness?

The || was deliberate.

I expect the count to usually be 1.  So the atomic_read optimizes out
the atomic operation in the common case.  skb_put and kref_put do it
for the same reason.

As for the raciness, that is an interesting case.

Because the decrement is in the rcu callback the count of the structure
is guaranteed to be at least one the entire time the structure is reachable
in an rcu safe manner.  So during that interval the count can go up or down,
safely and atomically, and it won't reach zero.

After the structure stops being reachable in an rcu protected manner
through the hash table it devolves into a simple reference counted
structure.  Now unless something like /proc captured this pid it will
have a count of exactly one, and I expect this to be relatively
common.

So if pid->count == 1 it means I own the only reference, and can do
what I please with this structure.

If pid->count > 1 then I don't own the only reference and someone
may be racing with me.  In that case I do need to do the full
atomic_dec_and_test to see if I have the very last reference to
this structure.

I wasn't certain which part of this you were confused about so I tried
to cover all of my bases.  Hopefully I have cleared up your confusion.

Eric






