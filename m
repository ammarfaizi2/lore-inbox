Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbUKDXGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUKDXGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKDWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:36:57 -0500
Received: from mail.timesys.com ([65.117.135.102]:39311 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262466AbUKDWaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:30:39 -0500
Message-ID: <418ABA69.6090205@timesys.com>
Date: Thu, 04 Nov 2004 18:25:29 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu> <418A7BFB.6020501@timesys.com> <20041104194416.GC10107@elte.hu>
In-Reply-To: <20041104194416.GC10107@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2004 22:24:47.0343 (UTC) FILETIME=[179477F0:01C4C2BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * john cooper <john.cooper@timesys.com> wrote:
> 
> 
>>>plus there's the 'priority inheritance dependency-chain closure' bug
>>>noticed by John Cooper - that should only affect the latency of RT 
>>>tasks though.
>>
>>This is a fairly gnarly problem to address.  The obvious solution is
>>to hold spinlocks in the mutexes as the dependency tree is atomically
>>traversed.  However this will deadlock under MP due to the
>>unpredictable order of mutexes traversed.  If the dependency chain is
>>not traversed (and semantics applied) atomically, races exist which
>>cause promotion decisions to be made on [now] stale data.
> 
> 
> is the order of locks in the dependency chain really unpredictable? If
> two chain walkers get two locks in opposite order, doesnt that mean that
> the lock ordering (as attempted by the blocked tasks) is deadlock-prone
> already? I.e. this scenario should not happen.

There does appear to be hope here.  If the per-task mutex ownership
list is maintained in strict order of acquisition sequence and
reader-mutex acquisition sequence is policed this would seem to remove
the possibly of chain traversal deadlock.

As an implementation note, single-owner hard spinlocks seem
excessive for the chain walk.  An approach allowing maximum
concurrency during traversal would be a reader-reference acquired
per node during the walk which would need to upgrade to an exclusive
writer-reference to effect promotion (waiter list priority reorder),
and then downgrade to a reader-reference to continue the traversal.

-john


-- 
john.cooper@timesys.com
