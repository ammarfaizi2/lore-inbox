Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267732AbUHEOLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUHEOLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267688AbUHEOHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:07:37 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:36337 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267732AbUHEODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:03:11 -0400
Message-ID: <41123DDD.5040607@nortelnetworks.com>
Date: Thu, 05 Aug 2004 10:02:05 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       rusty@rustcorp.com.au, mingo@elte.hu, jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>	<20040804232123.3906dab6.akpm@osdl.org>	<4111DC8C.7050504@redhat.com> <20040805001737.78afb0d6.akpm@osdl.org> <4111E3B5.1070608@redhat.com>
In-Reply-To: <4111E3B5.1070608@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Andrew Morton wrote:
> 
> 
>>How large is the slowdown, and on what workloads?
> 
> 
> The fast path for all locking primitives etc in nptl today is entirely
> at userlevel.  Normally just a single atomic operation with a dozen
> other instructions.  With the fusyn stuff each and every locking
> operation needs a system call to register/unregister the thread as it
> locks/unlocks mutex/rwlocks/etc.  Go figure how well this works.  We are
> talking about making the fast path of the locking primitives
> two/three/four orders of magnitude more expensive.  And this for
> absolutely no benefit for 99.999% of all the code which uses threads.

Just a small clarification.  (Rusty already touched on this briefly, but I think 
he made a mistake.)

If the arch has atomic compare-and-exchange, then the non-contended case is 
entirely userspace and no syscall is needed.  I don't think that the cmpxchg 
need be 64-bit.  From the OLS 2004 talk:

int vfulock_lock (&vfulock, flags, pid, &timeout) {
	unsigned old = VFULOCK_UNLOCKED;
	if (cmpxchg(vfulock,old,pid) != old) return 0;
	return SYSCALL(ufulock_lock,3,vfulock,flags,to);
}

That looks like a 32-bit cmpxchg to me.

Also, Inaky reported general operation about 10% slower than NPTL, but said that 
he wanted to fix that if possible.

Chris
