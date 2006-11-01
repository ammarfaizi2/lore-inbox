Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWKAXEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWKAXEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbWKAXEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:04:13 -0500
Received: from [62.205.161.221] ([62.205.161.221]:55428 "EHLO sacred.ru")
	by vger.kernel.org with ESMTP id S1752110AbWKAXEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:04:12 -0500
Message-ID: <45492764.6060700@openvz.org>
Date: Thu, 02 Nov 2006 02:01:56 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061001)
MIME-Version: 1.0
To: devel@openvz.org
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com,
       Paul Menage <menage@google.com>, Chris Friesen <cfriesen@nortel.com>
Subject: Re: [Devel] Re: [ckrm-tech] [RFC] Resource Management - Infrastructure
 choices
References: <20061030103356.GA16833@in.ibm.com>	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>	<20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com>
In-Reply-To: <45490F0D.7000804@nortel.com>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0rc6 (sacred.ru [62.205.161.221]); Thu, 02 Nov 2006 02:02:20 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Srivatsa Vaddagiri wrote:
>
>>>>        - Support limit (soft and/or hard depending on the resource
>>>>          type) in controllers. Guarantee feature could be indirectly
>>>>          met thr limits.
>
> I just thought I'd weigh in on this.  As far as our usage pattern is
> concerned, guarantees cannot be met via limits.
>
> I want to give "x" cpu to container X, "y" cpu to container Y, and "z"
> cpu to container Z.
>
> If these are percentages, x+y+z must be less than 100.
>
> However, if Y does not use its share of the cpu, I would like the
> leftover cpu time to be made available to X and Z, in a ratio based on
> their allocated weights.
>
> With limits, I don't see how I can get the ability for containers to
> make opportunistic use of cpu that becomes available.
This is basically how "cpuunits" in OpenVZ works. It is not limiting a
container in any way, just assigns some relative "units" to it, with sum
of all units across all containers equal to 100% CPU. Thus, if we have
cpuunits 10, 20, and 30 assigned to containers X, Y, and Z, and run some
CPU-intensive tasks in all the containers, X will be given
10/(10+20+30), or 20% of CPU time, Y -- 20/50, i.e. 40%, while Z gets
60%. Now, if Z is not using CPU, X will be given 33% and Y -- 66%. The
scheduler used is based on a per-VE runqueues, is quite fair, and works
fine and fair for, say, uneven case of 3 containers on a 4 CPU box.

OpenVZ also has a "cpulimit" resource, which is, naturally, a hard limit
of CPU usage for a VE. Still, given the fact that cpunits works just
fine, cpulimit is rarely needed -- makes sense only in special scenarios
where you want to see how app is run on a slow box, or in case of some
proprietary software licensed per CPU MHZ, or smth like that.

Looks like this is what you need, right?
> I can see that with things like memory this could become tricky (How
> do you free up memory that was allocated to X when Y decides that it
> really wants it after all?) but for CPU I think it's a valid scenario.
Yes, CPU controller is quite different of other resource controllers.

Kir.
