Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSHAOxe>; Thu, 1 Aug 2002 10:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSHAOxe>; Thu, 1 Aug 2002 10:53:34 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:34572 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S315119AbSHAOxd>;
	Thu, 1 Aug 2002 10:53:33 -0400
Subject: Re: [PATCH] Guarantee APM power status change notifications
From: Ray Lee <ray-lk@madrabbit.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020731160429.10522B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1020731160429.10522B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 01 Aug 2002 07:56:55 -0700
Message-Id: <1028213816.1027.155.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimmed the cc:]
On Wed, 2002-07-31 at 13:10, Bill Davidsen wrote:
> Actually there is one more case, where the BIOS unreliably tells you
> something has changed. I have an old Toshiba which I bought with Windows
> installed, and it always noticed pulling the plug and going line=>battery,
> but only sometimes noticed battery=>line. Of course this might be an o/s
> bug.

Well, that's just special. I wonder where the blame lies in that case.

> Can't test that any more, the battery failed and the transition is
> now line=>dead.

Heh.

> Anyway, if you are paranoid you could just ignore the "I knew that" cases
> and leave the workaround in place, unless that would generate other
> issues.

Hmm. I don't think that would cover everything. Taking your example
case, and assuming it's the BIOS being flaky, we'd have to just ignore
all transitions from the BIOS apm and just poll ourselves. Otherwise,
we'd have line->battery (signaled), battery->line (not signaled),
line->battery (signaled) and *then* we'd know to be paranoid. In the
meantime, we lost the second transition, which could have been hours
ago. The solution in that case would be to infrequently poll (say, twice
a minute) to verify what the BIOS told us. If it's out of sync, give it
a bit of a grace period, double-check, then take over the reins for
reporting.

The bottom line is that I didn't want to incur an extra set of BIOS
calls on systems that don't need it, on general principle. <Shrug> Heck,
maybe it's fast and the overhead is unnoticeable, but I don't know (ISTR
some low-latency issues when doing BIOS calls). Considering the APM
thread is only getting invoked once a second, it's seems that it would
be unnoticeable and zero risk, but hey, what do I know.

Anyway, a patch to do double-checking would be fairly straight-forward,
but without any reports of hardware out there that fails like that...
dunno. I'll work up a patch when I'm back from my road trip and see if
it's as clean.

Ray


