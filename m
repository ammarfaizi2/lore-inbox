Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVE3Rqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVE3Rqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVE3Rqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:46:46 -0400
Received: from one.firstfloor.org ([213.235.205.2]:18323 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261604AbVE3Rqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:46:36 -0400
To: Chris Friesen <cfriesen@nortel.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
References: <934f64a205052715315c21d722@mail.gmail.com>
	<A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de>
	<429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de>
	<429B4957.7070405@nortel.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 30 May 2005 19:46:35 +0200
In-Reply-To: <429B4957.7070405@nortel.com> (Chris Friesen's message of "Mon,
 30 May 2005 11:11:51 -0600")
Message-ID: <m1k6lgwqro.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> writes:

> Andi Kleen wrote:
>> On Mon, May 30, 2005 at 08:52:13AM -0600, Chris Friesen wrote:
>
>>>What about rdtsc?
>
>> It fails the reliable and monotonic test on AMD;
>
> tsc goes backwards on AMD?  Under what circumstances (I'm curious,
> since I'm running one...)

It is not synchronized between CPUs and slowly drifts and can even run
at completely different frequencies there when you use powernow! on a
MP system. 

It can be used reliably when you only do deltas on same CPU
and correct for the changing frequency. However then you run
into other problems, like it being quite slow on Intel.

I suspect any attempt to use time stamps in locks is a bad
idea because of this.

Note that at least on modern Intel systems you can just use
MONITOR/MWAIT which is much more efficient, if you are willing to eat
the fake wakeups due to the cache line padding they use.

My impression is that the aggressive bus access avoidance the
original poster was trying to implement is not that useful
on modern systems anyways which have fast busses. Also 
it is not even clear it even saves anything; after all the
CPU will always snoop cache accesses for all cache lines 
and polling for the EXCLUSIVE transition of the local cache line
is probably either free or very cheap.

Optimizing for the congested case is always a bad idea anyways; in
case lock congestion is a problem it is better to fix the lock.  And
when you have a really congested lock that for some reason cannot be
fixed then using some kind of queued lock (which also gives you
fairness on NUMA) is probably a better idea. But again you should
really fix the the lock instead, everything else is the wrong answer.

BTW Getting the fairness on the backoff scheme right would have been
probably a major problem.

The thing that seems to tickle CPU vendors much more is to avoid
wasting CPU time on SMT or on Hypervisors while spinning.  That can be
all done with much simpler hints (like rep ; nop).

-Andi

