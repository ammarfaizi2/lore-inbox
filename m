Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbUA0UYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUA0UYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:24:09 -0500
Received: from [195.23.16.24] ([195.23.16.24]:54987 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265657AbUA0UYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:24:04 -0500
Message-ID: <4016C8B6.6070704@grupopie.com>
Date: Tue, 27 Jan 2004 20:23:18 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: joe.korty@ccur.com
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] volatile may be needed in rwsem
References: <20040127191155.GA12128@tsunami.ccur.com> <23376.1075231180@redhat.com> <20040127194343.GA12763@tsunami.ccur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:

> On Tue, Jan 27, 2004 at 07:19:40PM +0000, David Howells wrote:
> 
>>>'flags' should be declared volatile as rwsem_down_failed_common() spins
>>>waiting for this to change.  Untested.
>>>
>>Is it though? Does this fix an error?
>>
>>The thing is, we make a function call inside of the loop:
>>
>>	/* wait to be given the lock */
>>	for (;;) {
>>		if (!waiter->flags)
>>			break;
>>		schedule();
>>		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>>	}
>>
>>Which might preclude that need. I'm not entirely sure, though... it's one of
>>those compiler black magic things.
>>
>>I suppose it can't hurt...
>>
>>David
>>
> 
> Hi David,
> I misspoke.  The potentially failing spin is in __down_write and
> __down_read in lib/rwsem-spinlock.c, not in rwsem_down_failed_common.
> 
> The problem is is that 'flags' is on the callee's stack and is thus
> subject to be optimized out of the loop if the compiler is smart enough
> to discover that it is on the stack.  Apparently gcc is not yet smart
> enough but that doesn't mean it won't be so soon.
> 

It seems to me that the compiler did the right thing and was smart enough, 
because after the function did:

list_add_tail(&waiter.list,&sem->wait_list);

it "published" the address of the structure, so the compiler can no longer 
assume that no outside function will have access to it.

So even if the compiler was extremely smart, it would have to do the same thing.

If you told no one where your structure is, how could it be modified outside 
your function, and how could you expect "waiter.flags" to be modified while 
inside the loop anyway (even if it was volatile)?

IMHO the code is correct.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

