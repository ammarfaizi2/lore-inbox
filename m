Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbUKDSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUKDSML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbUKDSKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:10:49 -0500
Received: from mail.timesys.com ([65.117.135.102]:23185 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262352AbUKDSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:04:11 -0500
Message-ID: <418A7BFB.6020501@timesys.com>
Date: Thu, 04 Nov 2004 13:59:07 -0500
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
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu>
In-Reply-To: <20041104163254.GA3810@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2004 17:58:23.0703 (UTC) FILETIME=[E0968E70:01C4C297]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>X should be scheduled on the other CPU just fine. Only per-CPU kernel
>>threads (which are affine to their particular CPU) are affected by
>>this problem - ordinary tasks not. I.e. the system threads that have
>>/0 and /1 in their name. In theory you should not even need to chrt
>>the hardirq threads, those should schedule fine too.
> 
> 
> plus there's the 'priority inheritance dependency-chain closure' bug
> noticed by John Cooper - that should only affect the latency of RT tasks
> though.

This is a fairly gnarly problem to address.  The obvious
solution is to hold spinlocks in the mutexes as the dependency
tree is atomically traversed.  However this will deadlock under
MP due to the unpredictable order of mutexes traversed.  If the
dependency chain is not traversed (and semantics applied)
atomically, races exist which cause promotion decisions to be
made on [now] stale data.

The simple solution is a global spinlock which doesn't scale
well under MP.  Another possible solution would be conditional
traversal of the chain where contention within the chain under
foot (from another chain walker) causes the traversal to
abort and retry.  Though this has the down side of being
nondeterministic.

-- 
john.cooper@timesys.com
