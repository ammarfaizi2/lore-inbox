Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752386AbWJ1Nez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbWJ1Nez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 09:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbWJ1Nez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 09:34:55 -0400
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:48544 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1752377AbWJ1Ney (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 09:34:54 -0400
Date: Sat, 28 Oct 2006 15:34:52 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take21 1/4] kevent: Core files.
In-reply-to: <20061028132816.GA25452@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Message-id: <45435C7C.10705@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=KOI8-R; format=flowed
Content-transfer-encoding: 7BIT
References: <11619654011980@2ka.mipt.ru> <454330BC.9000108@cosmosbay.com>
 <20061028105340.GC15038@2ka.mipt.ru> <45434ECF.4090209@cosmosbay.com>
 <20061028130350.GA18737@2ka.mipt.ru> <454359DC.4020905@cosmosbay.com>
 <20061028132816.GA25452@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a e'crit :
> On Sat, Oct 28, 2006 at 03:23:40PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
>>> diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
>>> index 711a8a8..ecee668 100644
>>> --- a/kernel/kevent/kevent_user.c
>>> +++ b/kernel/kevent/kevent_user.c
>>> @@ -235,6 +235,36 @@ static void kevent_free_rcu(struct rcu_h
>>> }
>>>
>>> /*
>>> + * Must be called under u->ready_lock.
>>> + * This function removes kevent from ready queue and 
>>> + * tries to add new kevent into ring buffer.
>>> + */
>>> +static void kevent_remove_ready(struct kevent *k)
>>> +{
>>> +	struct kevent_user *u = k->user;
>>> +
>>> +	list_del(&k->ready_entry);
>> Arg... no
>>
>> You cannot call list_del() , then check overflow_kevent.
>>
>> I you call list_del on what happens to be the kevent pointed by 
>> overflow_kevent, you loose...
> 
> This function is always called from appropriate context, where it is
> guaranteed that it is safe to call list_del:
> 1. when kevent is removed. It is called after check, that given kevent 
> is in the ready queue.
> 2. when dequeued from ready queue, which means that it can be removed
> from that queue.
> 

Could you please check the list_del() function ?

file include/linux/list.h

static inline void list_del(struct list_head *entry)
{
   __list_del(entry->prev, entry->next);
   entry->next = LIST_POISON1;
   entry->prev = LIST_POISON2;
}

So, after calling list_del(&k->read_entry);
next and prev are basically destroyed.

So when you write later :

+        if (!err || u->overflow_kevent == k) {
+            if (u->overflow_kevent->ready_entry.next == &u->ready_list)
+                u->overflow_kevent = NULL;
+            else
+                u->overflow_kevent = + 
list_entry(u->overflow_kevent->ready_entry.next, + 
struct kevent, ready_entry);
+        }


then you have a problem, since

list_entry(k->ready_entry.next, struct kevent, ready_entry);

will give you garbage.

Eric
