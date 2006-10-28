Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752224AbWJ1Mgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbWJ1Mgg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbWJ1Mgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:36:36 -0400
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:62954 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1752222AbWJ1Mgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:36:35 -0400
Date: Sat, 28 Oct 2006 14:36:31 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take21 1/4] kevent: Core files.
In-reply-to: <20061028105340.GC15038@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Message-id: <45434ECF.4090209@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=KOI8-R; format=flowed
Content-transfer-encoding: 7BIT
References: <11619654011980@2ka.mipt.ru> <454330BC.9000108@cosmosbay.com>
 <20061028105340.GC15038@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a e'crit :
> On Sat, Oct 28, 2006 at 12:28:12PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
>>
>> I really dont understand how you manage to queue multiple kevents in the 
>> 'overflow list'. You just queue one kevent at most. What am I missing ?
> 
> There is no overflow list - it is a pointer to the first kevent in the
> ready queue, which was not put into ring buffer. It is an optimisation, 
> which allows to not search for that position each time new event should 
> be placed into the buffer, when it starts to have an empty slot.

This overflow list (you may call it differently, but still it IS a list), is 
not complete. I feel you add it just to make me happy, but I am not (yet :) )

For example, you make no test at kevent_finish_user_complete() time.

Obviously, you can have a dangling pointer, and crash your box in certain 
conditions.

static void kevent_finish_user_complete(struct kevent *k, int deq)
{
	struct kevent_user *u = k->user;
	unsigned long flags;

	if (deq)
		kevent_dequeue(k);

	spin_lock_irqsave(&u->ready_lock, flags);
	if (k->flags & KEVENT_READY) {
+               if (u->overflow_event == k) {
+		/* MUST do something to change u->overflow_kevent */
+		}
		list_del(&k->ready_entry);
		k->flags &= ~KEVENT_READY;
		u->ready_num--;
	}
	spin_unlock_irqrestore(&u->ready_lock, flags);

	kevent_user_put(u);
	call_rcu(&k->rcu_head, kevent_free_rcu);
}

Eric
