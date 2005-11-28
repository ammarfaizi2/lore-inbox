Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVK1R0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVK1R0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVK1R0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:26:17 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:5543 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750719AbVK1R0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:26:16 -0500
Date: Mon, 28 Nov 2005 09:30:40 -0800
From: thockin@hockin.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
Message-ID: <20051128173040.GA32547@hockin.org>
References: <1133179554.11491.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133179554.11491.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 07:05:54AM -0500, Steven Rostedt wrote:
> With -rt20 on the AMD64 x2, I'm getting a crap load of these:
> 
> read_tsc: ACK! TSC went backward! Unsynced TSCs?
> 
> So bad that the system wont even boot (at least I won't wait long enough
> to let it finish).

The kernel's use of TSC is wholly incorrect.  TSCs can ramp up and down
and *do* vary between nodes as well as between cores within a node.  You
really can not compare TSCs between cpu cores at all, as is (and the
kernel assumes 1 global TSC in at least a few places).

If you have any sort of power-management enabled on a k8 (including 'hlt'
C1 state), you *will* get hosed.

We got into a situation where 1 CPU had somehow lagged behind the other
because it was idle for a while.  Suddenly gettimeofday() was only giving
me HZ granularity.  Successive reads would get the exact same timeval, as
much as 1 ms later.

What happened was the last_tsc was set to the higher-TSC CPU.  The
gettimeofday code for TSC was running on the lower-TSC CPU.  The code
recognized that current tsc < last tsc and set current = last.  As long as
I was running on the laggy CPU, time stood still for bursts. Then if I
bounced CPUs it would shoot forward.

Switching to HPET for timing made it all go away, but (at least as of
2.6.11) it was horribly broken.

Tim
