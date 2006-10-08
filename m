Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWJHOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJHOdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWJHOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:33:15 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:55875 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751198AbWJHOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:33:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pf7mzxEfCQMmbcgWXzgUkGTwO/ANkE7QSgXTjv8LThF91f4h4jXevXqR/rOoY4sFaLE+Hq6zEMX4Uv6Iva20E6yZ7BaQSYnO9cfjWASi5hwjM3VZFN0Nuzb0Dgb2j/eWzNGSkNX9LYf8vn0zVhjGNGbbjNYFz0i+uRpWy8XMj1k=
Message-ID: <45290C5A.1020708@gmail.com>
Date: Sun, 08 Oct 2006 22:34:02 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.18 PATCH]: Filesystem Event Reporter V4
References: <451E8C47.6090407@gmail.com> <20061003164727.GA1804@2ka.mipt.ru>	 <4523D01F.6030202@gmail.com> <20061005094114.GD1015@2ka.mipt.ru> <4c4443230610080629j33bc3685g8bb22029c390727d@mail.gmail.com>
In-Reply-To: <4c4443230610080629j33bc3685g8bb22029c390727d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     I do not say that they are broken, but you in some places you
>     access per-cpu
>     variuables without turning preemption off. I think some locking or
>     preemption tweaks should be done there to explicitly mark critical
>     regions.
>
You're right, some places have such issues, I just considered how to 
avoid the lock
or atomic operation, Andrew ever mentioned the lock is unacceptible in 
file system
 code path, so I always avoid the lock or atomic operation.

>     > >What prevents from adding another skb into the queue between
>     above loop
>     > >and check for flag?
>     > >
>     > before adding a fsevent to the queue, a process will check
>     exit_flag, if
>     > it is set to 1, that
>     > process won't queue the fsevent and return immediately.
>
>     But you check for exit_flag in fsevent_commit() without any locks.
>
Only rmmod will set exit_flag, other users are readers, so I think the 
lock is unnecessary,
 only one issue is that I  should clear fsevent_queue in the last 
section of fsevent_exit.
>
>     > >
>     > >Above operation seems racy, what prevents from changing
>     missed_refcnt
>     > >after it was read?
>     > >
>     > if the case you said is hit, missed_refcnt must be not equal to
>     > missed_refcnt, because they are for the same cpu, so no problem,
>     it will
>     > be checked
>     > in the next work schedule.
>
>     Since it is called with disabled preemption it is ok, but in that
>     case
>     you do not need missed_refcnt to be atomic.
>
in include/linux/fsevent.h, it is possibly accessed from diffrent cpus, 
so atomic is necessary.
>
>     > >Why are you doing this? It looks wrong, since socket's queue is
>     cleaned
>     > >automatically.
>     > >
>     > When I release fsevent_sock, the kernel always printk a message
>     which
>     > says "sk_rmem_alloc isn't zero",
>     > I don't know why, I doubt there are some packets in recieve and
>     write
>     > queue, so try to free them.
>     > but sk_rmem_alloc is always non-zero, so I must set it to 0, the
>     kernel
>     > doesn't printk.
>
>     That means that you broke socket accounting in some way.
>     sock_release() should do all cleanup for you.
>
>     Each time you add skb into socket queue appropriate socket is
>     charged for
>     value equal to sizeof(skb)+sizeof(skb_shared_info)+aligned size of
>     the data.
>     That number is added to the one of the sk_r/wmem_alloc, depending
>     on the
>     direction of the skb way, skb's destructor is set to the function
>     which
>     will remove appropiate amount of from above variables.
>     When you call sock_release() all skbs are removed and freed, so socket
>     accounting is corrected in kfree_skb(), which (if there are no users)
>     calls destructor and frees skb and data.
>     If you see asserions that above variables are not zero, that means
>     that
>     you either removed skb from the queue and forgot to free it, or
>     freed it
>     several times (although it will be likely a crash in this case),
>     or you
>     overwrote that variables after some memory corruption.
>
maybe that surplus skb_get is the root cause.
>
>     > >This is racy.
>     > >
>     > This doesn't take effect in the normal processing, the work
>     kthread will
>     > do the real
>     > work which will ensure no racy.
>
>     Then just remove it, and actually the whole modularity does not
>     seems a
>     good idea, although it is of course your decision to make design
>     static
>     or not. I would implement such things with dynamic registration of
>     the
>     clients and just make fsevent statically built into the kernel.
>
It is hard a bit for the subsystem using the hook mechanism to be 
implemented as
 a module. In fact, all the newly-added code in this patch is for 
modularity. :)

Really that is a way to build as a static infrastructure, the filesystem 
init code calls
 a fsevent register API to enable it, but unregister is not a trivial, 
the syncronization
issue still exists.  Nevertheless, this is really is a way I can try.
>
>     > >This looks really racy.
>     > >What prevents from rescheduling here?
>     > >
>     > This has disabled the preemption, so it is impossible to reshcedule.
>
>     No, put_fsevent_refcnt() andbles it again.
>     Or is it disabled on higher layer?
>
I think your "reschedule" means process migration, those code just considers
 this issue, missed_refcnt is just for this, start_cpuid is used to 
identify the cpu
before migration, end_cpuid is used to identify the cpu after migration, if
start_cpuid is equal to end_cpuid, we can think there is no migration 
happened,
 otherwise, missed_refcnt[start_cpuid] will increase, because there are 
possibly
 several prcoesses on different cpus to modify this value, so it is 
defined as
atomic.
>
>     > >
>     > >What prevents change for __raise_fsevent in that function?
>     > >
>     > If reference count is not -1, rmmod won't change
>     __raise_fsevent. the
>     > key is two new-added
>     > refrence counters.
>
>     You do it without preemption disabled and any other locks...
>
Only rmmod will change __raise_fsevent and it will set it to 0 just after
all the filesystem code paths nerver call it, if reference count on anuy cpu
 is not -1, rmmod will wait for it until this cpu doesn't call raise_fsevent
 any more, rmmod will set it to 0 just after all the reference count on 
all the
cpu are -1, so only one user -- rmmod -- is accessing it in that time, 
this is
safe.
