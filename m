Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbUKRCNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbUKRCNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRCL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:11:27 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7336 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262379AbUKRCIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:08:55 -0500
Date: Thu, 18 Nov 2004 11:10:50 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: Futex queue_me/get_user ordering
In-reply-to: <20041117084703.GL10340@devserv.devel.redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, drepper@redhat.com
Message-id: <419C04AA.3030302@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
References: <20041113164048.2f31a8dd.akpm@osdl.org>
 <20041114090023.GA478@mail.shareable.org>
 <20041114010943.3d56985a.akpm@osdl.org>
 <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com>
 <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com>
 <20041115132218.GB25502@mail.shareable.org>
 <20041117084703.GL10340@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Mon, Nov 15, 2004 at 01:22:18PM +0000, Jamie Lokier wrote:
> 
>>  1. A lost wakeup.
>>
>>     wait_A is woken, but wait_B is not, even though the second
>>     pthread_cond_signal is "observably" after wait_B.
>>
>>     The operation order is observable in sense that wait_B could
>>     update the data structure which is protected by cond+mutex, and
>>     wake_Y could read that update prior to deciding to signal.
>>
>>     _Logically_, what happens is that wait_A is woken by wake_X, but
>>     it does not immediately re-acquire the mutex.  In this time
>>     window, wait_B and wake_Y both run, and then wait_A acquires the
>>     mutex.  During this window, wait_A is able to absorb the second
>>     signal.
>>
>>     It's not clear to me if POSIX requires wait_B to be signalled or
>>     not in this case.
>>
>>  2. Future lost wakeups.
>>
>>     Future calls to pthread_cond_signal(cond) fail to wake wait_B,
>>     even much later, because cond's NPTL data structure is
>>     inconsistent.  It's invariant is broken.
>>
>>     This is a bug in NPTL and it's easy to fix.  Never increment wake
>>     unconditionally.  Instead, increment it conditionally when (a)
>>     FUTEX_WAKE returns 1, and also (b) when FUTEX_WAIT returns -EAGAIN.
> 
> 
> If you think it is fixable in userland, please write at least the pseudo
> code that you believe should work.  We have spent quite a lot of time
> on that code and don't believe this is solvable in userland.
> E.g. the futex IMHO must be incremented before FUTEX_WAKE, as otherwise
> the woken tasks wouldn't see the effect.
> 
> I believe the only place this is solvable in is the kernel, by ensuring
> atomicity (i.e. queuing task iff curval == expected_val operation atomic
> wrt. futex_wake/futex_requeue in other tasks).

I agree. I think this is kernel problem.

Even if it is possible to avoid this problem by tricks in userland, I think
it is ugly that it could happen that threads having randomness val could be
waken.  i.g.:

 >>>> >>      "returns 0 if the futex was not equal to the expected value, but
 >>>> >>       the process was woken by a FUTEX_WAKE call."

Still now, update of manpage is unnecessary, I think.


Thanks,
H.Seto

