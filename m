Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUKWB2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUKWB2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKWB0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:26:07 -0500
Received: from mail.timesys.com ([65.117.135.102]:17314 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262448AbUKWBVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:21:54 -0500
Message-ID: <41A2902A.5050308@timesys.com>
Date: Mon, 22 Nov 2004 20:19:38 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <41A1F4B2.10401@timesys.com> <20041122152452.GA2036@elte.hu>
In-Reply-To: <20041122152452.GA2036@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2004 01:15:10.0843 (UTC) FILETIME=[E0B244B0:01C4D0F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * john cooper <john.cooper@timesys.com> wrote:
> 
> 
>>I'd hazard a guess the reason existing implementations do not do this
>>type of dependency-chain closure is the complexity of a general
>>approach. [...]
> 
> 
> please take a look at the latest patch, it is i believe handling all the
> cases correctly. It certainly appears to solve the cases uncovered by
> pi_test.

Yes I see where you are walking the dependency chain
in pi_setprio().  But this is under the global spinlock
'pi_lock'.

My earlier comment was of the difficulty to establish fine
grained locking, ie: per-mutex to synchronize mutex
ownership/waiter lists and per task to synchronize
the list maintaining mutexes owned by task.  While this
arguably scales better in an SMP environment, there are
issues of mutex traversal sequence during PI which lead
to deadlock scenarios.  Though I believe there are
reasonable constraints placed on application mutex
acquisition order which side step this problem.

In the current design pi_lock has scope protecting all
mutex waiter lists (rooted either in mutex or owning task),
as well as per-mutex owner(s).  The result of this is
pi_lock must be speculatively acquired before altering
any of the above lists/data regardless whether a PI
scenario is encountered.  The behavior looks correct to
my reading.  However I'd offer there is more concurrency
possible in this design.

-john




-- 
john.cooper@timesys.com
