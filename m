Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVLNVXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVLNVXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVLNVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:23:41 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:31108 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932356AbVLNVXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:23:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4gE8fU7eko9NJc5aIdIL2MQg5mZ3EzAX7HaL6j6/OFFwjtT1rEZgQu9qX3/H6sfz/yentQEUTsVoWFR/N0kpUQfTGFQ4/+CO0pqnTzM8+9ipcWwZNCuAjtdHdJz7/TdyL63Ua8y9kz674Iatnp/yRH1RQLb0X2Shjc2tohjGRmc=  ;
Message-ID: <43A08D50.30707@yahoo.com.au>
Date: Thu, 15 Dec 2005 08:23:28 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <439FFF63.6020105@yahoo.com.au>  <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com>
In-Reply-To: <15157.1134560767@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>> (1) If it's using spinlocks, then it's pointless to use atomic_cmpxchg.
>>>
>>
>>Why?
> 
> 
> Because you're going to end up with loops around the cmpxchg bit in certain
> places, and if you do, then you've effectively got this:
> 
> 	spin_lock_irqsave(mutexlock, flags);
> 	do {
> 		new = calc_state(orig, oldstate);
> 		spin_lock_irqsave(atomiclock, flags2);
> 		oldstate = __cmpxchg(&mutex->count, orig, new)
> 		spin_unlock_irqrestore(atomiclock, flags2);
+> 	} while (oldstate != orig);
> 	spin_unlock_irqrestore(mutexlock, flags);
> 
> which is very bad. You _should_ have:
> 
> 	spin_lock_irqsave(mutexlock, flags);
> 	oldstate = mutex->count;
> 	mutex->count = modify_state(mutex->count);
> 	spin_unlock_irqrestore(mutexlock, flags);
> 
> instead.

I was under the impression that with cmpxchg, you don't need the mutex lock.
If you do then sure, cmpxchg doesn't buy you anything (even if the arch does
natively support it).

> 
> No. If you have XCHG/TAS/BSET/SWAP, but not CMPXCHG/CAS then you can do a lot
> better by not pretending that cmpxchg exists. That way the fast paths don't
> have to take any spinlocks at all.
> 
> And if you've got LLD/SCD or LDARX/STDCX or similar then you can probably do
> better than CMPXCHG also.
> 
> If you want an illustration, then consider this:
> 
> 	#define __mutex_trylock(mutex)					\
> 	({								\
> 		int oldstate;						\
> 									\
> 		asm volatile("swap%I0 %M0,%1"				\
> 			     : "+m"(mutex->state), "=r"(oldstate)	\
> 			     : "1"(1)					\
> 			     : "memory");				\
> 									\
> 		oldstate == 0;						\
> 	})
> 
> 	static inline int down_trylock(struct mutex *mutex)
> 	{
> 		if (likely(__mutex_trylock(mutex))) {
> 			/* success */
> 			return 0;
> 		}
> 
> 		/* failure */
> 		return 1;
> 	}
> 
> 	void fastcall __sched down(struct mutex *mutex)
> 	{
> 		if (down_trylock(mutex) == 1)
> 			__down(mutex);
> 	}
> 
> 	EXPORT_SYMBOL(down);
> 
> On FRV, this can be made to map to:
> 
> 	setlos	0x1,gr4
> 	ori	gr4,0,gr5
> 	swap	@(gr8,gr0),gr5
> 	subicc	gr5,0,gr0,icc0
> 	beqlr	icc0,0x2	<-- probable-rated conditional return
> 	sethi.p	0xc01c,gr14
> 	setlo	0x9df0,gr14
> 	jmpl	@(gr14,gr0)
> 
> That's an out-of-line fast path of _5_ instructions. Attempting to emulate
> CMPXCHG requires a lot more. On FRV, the case is alleviated somewhat since it
> doesn't yet provide spinlocks and support SMP, but you'd be very hard pressed
> to squeeze it down to just five instructions.
> 

I think all of about parisc and sparc32 "emulate" cmpxchg with spinlocks.
For architectures like i386, x86_64, ppc, ia64, etc. the cmpxchg will
give good code.

Then if FRV was still unhappy, then you could override the mutex in that
architecture. This just seemed better to me than having a crappy simple
implementation that *everyone* will want to override (and I see FRV
overrides it as well, I don't see how you can complain about that).

But I guess that's moot if you can't to do a lockless version using
cmpxchg.

> 
>>> (2) atomic_t is a 32-bit type, and on a 64-bit platform I will want a
>>>     64-bit type so that I can stick the owner address in there (I've got
>>>     a second variant not yet released).
>>>
>>
>>I'm sure you could use a seperate field as it would be a debug
>>option, right?
> 
> 
> True. Ingo suggested this, and it seems reasonable. OTOH, shrinking the count
> by 4 bytes would allow the whole structure to shrink by 8 on a 64-bit platform
> with a 4-byte spinlock, which would be even better.
> 

I'm sure you'd manage. spinlocks can get pretty large with debugging on too.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
