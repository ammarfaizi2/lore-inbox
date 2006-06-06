Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWFFKrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWFFKrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWFFKrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:47:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:21702 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751034AbWFFKrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:47:41 -0400
Date: Tue, 6 Jun 2006 16:17:29 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Message-ID: <20060606104728.GB4394@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200606020003.51504.a1426z@gawab.com> <447F956B.3090402@bigpond.net.au> <1149247384.28649.691.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149247384.28649.691.camel@stark>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 04:23:04AM -0700, Matt Helsley wrote:
> There are two problems as I see it:
> 
> 1) If X1 grows to use 35% then X2's usage can't grow back from 15% until
> X1 relents. This is seems unpleasantly like cooperative scheduling
> within group X because if we take this to its limit X2 gets 0% and X1
> gets 50% -- effectively starving X2. What little I know about nice
> suggests this wouldn't really happen. However I think may highlight one
> case where fiddling with nice can't effectively control CPU usage.

I would expect task Z to adjust the limits of X1, X2 again when it notices 
that X2 is "hungry". Until Z gets around to do that, what situation you
describe will be true. If Z is configured to run quite frequently (every
5 seconds?) to monitor/adjust limits, then this starvation (of X2) may be
avoided for longer periods?

> 2) Suppose we add group Y with tasks Y1-YM, Y's CPU usage is limited to
> 49%, each task of Y uses its limit of (M/49)% CPU, and the remaining 1%
> is left for Z (i.e. the single CPU is being used heavily). Z must use
> this 1% to read accounting information and adjust nice values as
> described above. If X1 spawns X3 we're likely in trouble -- Z might not
> get to run for a while but X3 has inheritted X1's nice value. If we
> return to our initial assumption that X1 and X2 are each using their
> limit of 25% then X3 will get limited to 25% too. The sum of Xi can now
> exceed 50% until Z is scheduled next. This only gets worse if there is
> an imbalance between X1 and X2 as described earlier. In that case group
> X could use 100% CPU until Z is scheduled! It also probably gets worse
> as load increases and the number of scheduling opportunities for Z
> decrease.
> 
> 
> 	I don't see how task Z could solve the second problem. As with UP, in
> SMP I think it depends on when Z (or one Z fixed to each CPU) is
> scheduled.

Wouldn't it help if Z is made to run with nice -20 (or with RT prio maybe),
so that when Z wants to run (every 5 or 10 seconds) it is run
immediately? This is assuming that Z can do its job of adjusting limits
for all tasks "quickly" (maybe 100-200 ms?).

> 
> 	I think these are simple scenarios that demonstrate the problem with
> splitting resource management into accounting and control with userspace
> in between.
> 
> Cheers,
> 	-Matt Helsley

-- 
Regards,
vatsa
