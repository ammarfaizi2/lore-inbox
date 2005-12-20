Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVLTIMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVLTIMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVLTIMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:12:21 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:31653 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750848AbVLTIMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:12:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ctcD5086828aHC96Lc9XNTKuBwZFHwgJ++hiOLmBdgabt42Iw1T1jaRrYlb/Z13XtepR8zxxaZLfodoX1UUygvlV67ZnODtnjUIAghf+SpaliXGOsYFpUIyrNjQ+dmXxodI4NH4lSMZDSt7suC4YGu/kA9aIZ2wY+rad2AXNgZQ=  ;
Message-ID: <43A7BCE1.7050401@yahoo.com.au>
Date: Tue, 20 Dec 2005 19:12:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> On Tue, 20 Dec 2005, Ingo Molnar wrote:
> 
> 
>>* David Woodhouse <dwmw2@infradead.org> wrote:
>>
>>
>>>On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
>>>
>>>>Hi Ingo,
>>>>        Doesn't this corrupt caller saved registers?
>>>
>>>Looks like it. I _really_ don't like calling functions from inline 
>>>asm. It's not nice. Can't we use atomic_dec_return() for this?
>>
>>we can use atomic_dec_return(), but that will add one more instruction 
>>to the fastpath. OTOH, atomic_dec_return() is available on every 
>>architecture, so it's a really tempting thing. I'll experiment with it.
> 
> 
> Please consider using (a variant of) xchg() instead.  Although 
> atomic_dec() is available on all architectures, its implementation is 
> far from being the most efficient thing to do for them all.  For 
> example, see my discussion about swp on ARM:
> 

Considering that on UP, the arm should not need to disable interrupts
for this function (or has someone refuted Linus?), how about:

#ifndef CONFIG_SMP
typedef struct { volatile int counter; } mutex_counter_t;

static inline int mutex_counter_dec_return(mutex_counter *v)
{
     return --v->counter;
}

...
#else
#define mutex_counter_t atomic_t
...
#endif

Or does that get too bulky or have other problems?

MP ARMs should have an adequate atomic_dec_return.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
